# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  height = Math.min(window.innerHeight, 500)
  width = Math.min(window.innerWidth, 960)
  margin = {top: (20/500)*height, right: (30/960)*width, bottom: (30/500)*height, left: (40/960)*width}
  innerWidth = width - margin.left - margin.right
  innerHeight = height - margin.top - margin.bottom;
  barWidth = innerWidth/6
  x = d3.scale.ordinal()
    .rangeRoundBands([0, innerWidth], .1)
  y = d3.scale.linear()
      .domain([0, d3.max(data)])
      .range([innerHeight, margin.top])
  xAxis = d3.svg.axis()
  .scale(x)
  .orient("bottom")
  .ticks(6);
  yAxis = d3.svg.axis()
  .scale(y)
  .orient("left")
  .ticks(10,"%");
  letterChart = d3.select(".dice-game-analytics")
  .attr("height", height )
  .attr("width", width)
  .append("g").attr("transform", "translate(" + margin.left + "," + margin.top + ")")
  buildBarGraph = (data) ->
    dataArray = []
    dataArray.push( [key, value] ) for key, value of data
    x.domain(dataArray.map((key)-> return key[0]))
    y.domain( [0, d3.max(d3.values(data), (d)-> return d )] )
    letterChart.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + innerHeight + ")")
        .call(xAxis);
    letterChart.append("g")
        .attr("class", "y axis")
        .call(yAxis)
    .append("text")
      .attr("transform", "rotate(-90)")
      .attr("y", 6)
      .attr("dy", "-2em")
      .style("text-anchor", "end")
      .style("fill", "black")
      .text("Occurences");
    bar = letterChart.selectAll(".bar")
    .data(d3.entries(data))
    .enter().append("g")
    .attr("transform", (d,i) -> return "translate(" + i * barWidth + ",0)")
    bar.append("rect")
      .attr("y", (d) -> return y(d.value))
      .attr("x", (d) -> return x(d.name))
      .attr("width", x.rangeBand)
      .attr("height", (d) -> innerHeight - y(d.value))

    bar.append("text")
        .attr("y", (d) ->  return y(d.value) + 3 )
        .attr("x", barWidth / 2)
        .attr("dy", ".75em")
        .attr("dx", ".75em")
        .text((d) -> return d.value );
    bar.append("text")
      .attr("y", innerHeight + margin.top)
      .style("fill", "black")
      .style("align", "center")
      .attr("dy", ".35em")
      .attr("dx", ".35em")
      .attr("x", barWidth / 2)
      .text((d) -> return d.key );
  callback = (error,data) ->
    if error
      console.log("warning " + error)
      return
    buildBarGraph(data)
  d3.json("/dice_games/data", (error, data) -> return callback(error,data) )