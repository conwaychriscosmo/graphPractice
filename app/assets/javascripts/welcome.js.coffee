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
