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
  margin = {top: (20/500)*height, right: (30/960)*width, bottom: (30/500)*height, left: (40/960)*width}
  innerWidth = width - margin.left - margin.right
  innerHeight = height - margin.top - margin.bottom;
  barWidth = innerWidth/26
  x = d3.scale.ordinal()
    .rangeRoundBands([0, innerWidth], .1)
  y = d3.scale.linear()
      .domain([0, d3.max(data)])
      .range([innerHeight, margin.top])
  xAxis = d3.svg.axis()
  .scale(x)
  .orient("bottom")
  .ticks(26);
  yAxis = d3.svg.axis()
  .scale(y)
  .orient("left")
  .ticks(10,"%");
  letterChart = d3.select(".vertical-chart")
  .attr("height", height )
  .attr("width", width)
  .append("g").attr("transform", "translate(" + margin.left + "," + margin.top + ")")

  circleX = d3.scale
  circleChart = d3.select(".svg-circles")
  .attr("height", height)
  .attr("width", width)
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

  buildCuteCircles = (data) ->
    totalLetters = 0
    aggregateD = 0
    displayHeight = height/4
    totalLetters += num for key, num of data
    translationCalculation = (d, i) ->
      dBefore = aggregateD
      aggregateD += ((d.value *1.0)/totalLetters) * 2 * width 
      if Math.floor(aggregateD/width) > Math.floor(dBefore/width)
        displayHeight += height/4
        aggregateD = ((d.value *1.0)/totalLetters) * 2 * width
      return "translate(" + (aggregateD - ((d.value *1.0)/totalLetters) * (width)) +  "," + displayHeight + ")"
    circle = circleChart.selectAll(".circle")
    .data(d3.entries(data))
    .enter().append("g")
    .attr("transform", (d,i) -> return translationCalculation(d,i) )
    circle.append("circle")
      .attr("r", (d) -> return ((d.value * 1.0)/totalLetters) * (width))
    
      
    circle.append("text")
      .style("fill","white")
      .attr("dx", ".05em")
      .attr("dy", ".2em")
      .text((d) -> return d.key)
    circle.append("svg:title")
      .text((d)-> return d.value)


  callback = (error,data) ->
    if error
      console.log("warning " + error)
      return
    buildBarGraph(data)
    buildCuteCircles(data)

  d3.json("/welcome/data", (error, data) -> return callback(error,data) )