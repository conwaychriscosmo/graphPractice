# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  data = [4, 8, 15, 16, 23, 42];
  x = d3.scale.linear()
      .domain([0, d3.max(data)])
      .range([0, window.innerWidth])
  d3.select(".basic-html-bar-chart")
    .selectAll("div")
      .data(data)
    .enter().append("div")
      .style("width", (d) -> return x(d) + "px")
      .style("background-color", "#0F0")
      .text( (d) -> return d);
  barHeight = 20
  svgChart = d3.select(".svg-chart")
  .attr("width", window.innerWidth)
  .attr("height", barHeight * data.length)
  bar = svgChart.selectAll("g")
  .data(data)
  .enter().append("g")
  .attr("transform", (d,i) -> return "translate(0," + i * barHeight + ")")

  bar.append("rect")
    .attr("width", x)
    .attr("height", barHeight - 1)

  bar.append("text")
      .attr("x", (d) ->  return x(d) - 3 )
      .attr("y", barHeight / 2)
      .attr("dy", ".35em")
      .text((d) -> return d );
  
  
  height = Math.min(window.innerHeight, 500)
  width = Math.min(window.innerWidth, 960)
  x = d3.scale.ordinal()
    .rangeRoundBands([0, width], .1)
  y = d3.scale.linear()
      .domain([0, d3.max(data)])
      .range([height, 0])
  barWidth = 20
  letterChart = d3.select(".vertical-chart")
  .attr("height", height )
  .attr("width", barWidth * 26)
  callback = (error,data) ->
    if error
      console.log("warning " + error)
      return
    console.log(data)
    dataArray = []
    dataArray.push( [key, value] ) for key, value of data
    console.log(dataArray)
    x.domain(dataArray.map((key)-> return key[0]))
    y.domain( [0, d3.max(d3.values(data), (d)-> return d )] )
    bar = letterChart.selectAll("g")
    .data(d3.entries(data))
    .enter().append("g")
    .attr("transform", (d,i) -> return "translate(" + i * barWidth + ",0)")

    bar.append("rect")
      .attr("y", (d) -> return y(d.value))
      .attr("width", barWidth - 1)
      .attr("height", (d) -> height - y(d.value))

    bar.append("text")
        .attr("y", (d) ->  return y(d.value) + 3 )
        .attr("x", barWidth / 2)
        .attr("dy", ".75em")
        .attr("dx", ".75em")
        .text((d) -> return d.value );
  d3.json("/welcome/data", (error, data) -> return callback(error,data) )