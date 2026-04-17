{**
 * @file plugins/generic/statistics/index.tpl
 *
 * Copyright (c) 2016 Fran Máñez - Universitat Politècnica de Catalunya (UPC)
 * fran.upc@gmail.com
 *
 * Updated for OJS 3.x by: Reewos Talla <reewos.etc@gmail.com>
 *
 *
 *}
 
{strip}
{assign var="pageTitle" value="plugins.generic.statistics.name"}
{include file="frontend/components/header.tpl"}
{/strip}

<div id="content">

<head>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="{$baseUrl}/plugins/generic/statistics/js/bootstrap-switch.min.js" type="text/javascript"></script>
	<link rel="stylesheet" href="{$baseUrl}/plugins/generic/statistics/css/bootstrap-statistics.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/plugins/generic/statistics/css/bootstrap-switch.min.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/plugins/generic/statistics/css/range.css" type="text/css" />
</head>

<h1>{translate key="plugins.generic.statistics.titlePage"}</h1>

<div class="well">
	 
	<div class="row">
		<div class="col-md-12">
			<div class="btn-group btn-group-sm" id="divSpinner" role="group" aria-label="...">
				<button type="button" name="btnPrev" id="btnPrev" class="btn btn-default">-</button>
			  	<button type="button" name="valueYear" id="year" disabled="disabled" class="btn btn-default">{'Y'|date}</button>
			  	<button type="button" name="btnNext" id="btnNext" class="btn btn-default">+</button>
			</div>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<div class="btn-group btn-group-sm" id="btnGroup" role="group" aria-label="...">
				<button type="button" name="typeChart" id="btnTypeColumns" class="btn btn-success">{translate key="plugins.generic.statistics.columns"}</button>
			  	<button type="button" name="typeChart" id="btnTypeColumnsStack" class="btn btn-default">{translate key="plugins.generic.statistics.columnsStack"}</button>
			  	<button type="button" name="typeChart" id="btnTypeLine" class="btn btn-default">{translate key="plugins.generic.statistics.lines"}</button>
			</div>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</div>
	</div>
</div>

<br>
<div class="panel">
	<ul class="nav nav-pills" id="myTab" >
    	<li class="active"><a href="#tabMonth" data-toggle="tab" class="btnOLD">{translate key="plugins.generic.statistics.monthly"}</a></li>
		<li><a href="#tabYear" data-toggle="tab">{translate key="plugins.generic.statistics.lastYears"}</a></li>
		{* <li><a href="#tabWeek" data-toggle="tab">{translate key="plugins.generic.statistics.lastDays"}</a></li> *}
		<li><a href="#tabByCountry" data-toggle="tab">{translate key="plugins.generic.statistics.byCountry"}</a></li>
		<li><a href="#tabArticleDownload" data-toggle="tab">{translate key="plugins.generic.statistics.article"} ({translate key="plugins.generic.statistics.downloads"})</a></li>
		<li><a href="#tabArticleAbstract" data-toggle="tab">{translate key="plugins.generic.statistics.article"} ({translate key="common.abstract"})</a></li>
		<li><a href="#tabIssues" data-toggle="tab">{translate key="plugins.generic.statistics.issues"}</a></li>
	</ul>
	<br><br>
    <div class="tab-content">
    	<div class="tab-pane active" id="tabMonth">
			<div id="chartStatMonth" style="min-width: 450px; height: 450px; margin: 0 auto"></div>
		</div>
        <div class="tab-pane" id="tabYear">
        	<div id="chartStatByYear" style="min-width: 450px; height: 450px; margin: 0 auto"></div>
		</div>
    	<div class="tab-pane active" id="tabWeek">
			<div id="chartStatWeek" style="min-width: 450px; height: 450px; margin: 0 auto"></div>
		</div>
		<div class="tab-pane" id="tabByCountry">
			<div id="chartCountryDownload" style="min-width: 450px; height: 450px; margin: 0 auto"></div>
			<br/>
        	<div id="chartCountryAbstract" style="min-width: 450px; height: 450px; margin: 0 auto"></div>
		</div>
		<div class="tab-pane" id="tabArticleDownload">
			<div id="chartArticleDownload" style="min-width: 450px; height: 450px; margin: 0 auto"></div>
		
        	<table class="table table-striped table-hover">
				<thead>
			    	<tr>
			      		<th class="text-center">#</th>
			      		<th class="text-left">{translate key="plugins.generic.statistics.nameArticle"}</th>
			      		<th class="text-center">{translate key="plugins.generic.statistics.downloads"}</th>
			   	 	</tr>
			  	</thead>
			  	<tbody id="tbodyDownload">
				</tbody>
			</table>
		</div>
		<div class="tab-pane" id="tabArticleAbstract">
			<div id="chartArticleAbstract" style="min-width: 400px; height: 400px; margin: 0 auto"></div>
		
        	<table class="table table-striped table-hover">
				<thead>
			    	<tr>
			      		<th class="text-center">#</th>
			      		<th class="text-left">{translate key="plugins.generic.statistics.nameArticle"}</th>
			      		<th class="text-center">{translate key="plugins.generic.statistics.abstracts"}</th>
			   	 	</tr>
			  	</thead>
			  	<tbody id="tbodyAbstract">
				</tbody>
			</table>
		</div>
		<div class="tab-pane" id="tabIssues">
			<div id="chartIssues" style="min-width: 400px; height: 400px; margin: 0 auto"></div>
		
        	<table class="table table-striped table-hover">
				<thead>
			    	<tr>
			      		<th class="text-center">#</th>
			      		<th class="text-center">{translate key="plugins.generic.statistics.volume"}</th>
			      		<th class="text-center">{translate key="plugins.generic.statistics.number"}</th>
			      		<th class="text-center">{translate key="plugins.generic.statistics.year"}</th>
			      		<th class="text-left">{translate key="plugins.generic.statistics.nameIssue"}</th>
			      		<th class="text-center">{translate key="plugins.generic.statistics.abstracts"}</th>
			   	 	</tr>
			  	</thead>
			  	<tbody id="tbodyIssues">
				</tbody>
			</table>
		</div>
	</div>
	
	
</div>

<script language="javascript">
	{literal}
	
	var l = window.location;
	var base_location = l;
	var base_url = l.protocol + "//" + l.host + "/" + l.pathname.split('/')[1];
	var base_url_journal = l.pathname.slice(0, l.pathname.lastIndexOf('/'));

	var typeChart = "column";
	var tabSelected = "tabMonth";

	
	$(document).ready(function() {
		
		
		/***********************************************************
		 *        			FUNCTIONS UPDATE DATA
		 ***********************************************************/

		
		
		//Chart Days 
		
		
		//Chart MONTH 
		jQuery.fn.updateChartMonth = function() {
			optionsMonth.title.text = '{/literal}{translate key="plugins.generic.statistics.querysToTheJournal"}{literal} '+$('#year').text();

			jQuery.getJSON(base_location+'/getStatisticsByMonth?year='+$('#year').text(), null, function(data) {

				optionsMonth.series = new Array(data.length);

				for (var i = 0; i < data.length; i++){
					optionsMonth.series[i] = new Object();
					optionsMonth.series[i].name = data[i].name;
					optionsMonth.series[i].data = data[i].values;
				}

				
				chartMonth = new Highcharts.Chart(optionsMonth);
			});
		};


		//Chart YEAR
		jQuery.fn.updateChartByYear = function() {

			$yearSelected = $('#year').text();
			$yearSelected5 = $yearSelected-5;

			optionsByYear.title.text = '{/literal}{translate key="plugins.generic.statistics.querysFrom"}{literal} '+$yearSelected5+' {/literal}{translate key="plugins.generic.statistics.querysTo"}{literal} '+$yearSelected,
			optionsByYear.xAxis.categories = [$yearSelected-5,$yearSelected-4,$yearSelected-3,$yearSelected-2,$yearSelected-1,$yearSelected];

			jQuery.getJSON(base_location+'/getStatisticsByYear?year='+$('#year').text(), null, function(data) {
				
				optionsByYear.series = new Array(data.length);

				for (var i = 0; i < data.length; i++){
					optionsByYear.series[i] = new Object();
					optionsByYear.series[i].name = data[i].name;
					optionsByYear.series[i].data = data[i].values;
				}
						
				chartByYear = new Highcharts.Chart(optionsByYear);
			});
		};

		//Chart WEEK
		jQuery.fn.updateChartWeek = function() {
			optionsWeek.title.text = '{/literal}{translate key="plugins.generic.statistics.forWeek"}{literal}';
			
			jQuery.getJSON(base_location+'/getStatisticsWeek?year='+$('#year').text(), null, function(data) {

				optionsWeek.series = new Array(data.length);

				for (var i = 0; i < data.length; i++){
					optionsWeek.series[i] = new Object();
					optionsWeek.series[i].name = data[i].name;
					optionsWeek.series[i].data = data[i].values;
					optionsWeek.series[i].day = data[i].day;
				}
				//data[0].day = date(data[0].day);
				
				optionsWeek.xAxis.categories = data[0].day;
				chartWeek = new Highcharts.Chart(optionsWeek);
			});
		};

		//Chart COUNTRY ABSTRACT
		jQuery.fn.updateChartPaisesAbstract = function() {

			optionsPaisesAbstract.title.text = '{/literal}{translate key="plugins.generic.statistics.viewAbstractsByCountry"}{literal} '+$('#year').text();
			
			$yearSelected = $('#year').text();
			
			jQuery.getJSON(base_location+'/getStatisticsByCountryAbstract?year='+$yearSelected, null, function(data) {

				optionsPaisesAbstract.series[0].data = [];

				for (var i = 0; i < data.length; i++){
					optionsPaisesAbstract.series[0].data[i] = [data[i].country, parseInt(data[i].count)];
				}

				
				chartCountryAbstract = new Highcharts.Chart(optionsPaisesAbstract);
			});
		};

		//Chart COUNTRY DOWNLOAD
		jQuery.fn.updateChartPaisesDownload = function() {

			optionsPaisesDownload.title.text = '{/literal}{translate key="plugins.generic.statistics.viewDownloads"}{literal} '+$('#year').text();
			
			$yearSelected = $('#year').text();
			
			jQuery.getJSON(base_location+'/getStatisticsByCountryDownload?year='+$yearSelected, null, function(data) {

				optionsPaisesDownload.series[0].data = [];

				for (var i = 0; i < data.length; i++){
					optionsPaisesDownload.series[0].data[i] = [data[i].country, parseInt(data[i].count)];
				}

				chartCountryDownload = new Highcharts.Chart(optionsPaisesDownload);
			});
		};

		//Chart and list ARTICLE DOWNLOAD
		jQuery.fn.updateChartArticleDownload = function() {
			optionsArticleDownload.title.text = '{/literal}{translate key="plugins.generic.statistics.rankingDownloadArticles"}{literal} '+$('#year').text();
			
			$yearSelected = $('#year').text();
			
			jQuery.getJSON(base_location+'/getStatisticsMostPopularDownload?year='+$yearSelected+"&type=515", null, function(data) {

				optionsArticleDownload.series[0].data = [];

				$("#tbodyDownload").html('');
				for (var i = 0; i < data.length; i++){
					optionsArticleDownload.series[0].data[i] = ["#"+(i+1), parseInt(data[i].count)];

					var $link = $('<a>')
						.attr('href', base_url_journal + '/article/view/' + parseInt(data[i].id))
						.addClass('pkpStatistics__itemLink')
						.text(data[i].article);
					var $row = $('<tr>')
						.append($('<td>').addClass('text-center success').text(i+1))
						.append($('<td>').addClass('text-left').append($link))
						.append($('<td>').addClass('text-center').text(data[i].count));
					$("#tbodyDownload").append($row);
				}

				chartArticleDownload = new Highcharts.Chart(optionsArticleDownload);
			});
		};

		//Chart and list ARTICLE ABSTRACT
		jQuery.fn.updateChartArticleAbstract = function() {

			optionsArticleAbstract.title.text = '{/literal}{translate key="plugins.generic.statistics.rankingAbstractArticles"}{literal} '+$('#year').text();
			
			$yearSelected = $('#year').text();
			
			jQuery.getJSON(base_location+'/getStatisticsMostPopularDownload?year='+$yearSelected+"&type=1048585", null, function(data) {

				optionsArticleAbstract.series[0].data = [];

				$("#tbodyAbstract").html('');
				for (var i = 0; i < data.length; i++){
					optionsArticleAbstract.series[0].data[i] = ["#"+(i+1), parseInt(data[i].count)];

					var $link = $('<a>')
						.attr('href', base_url_journal + '/article/view/' + parseInt(data[i].id))
						.text(data[i].article);
					var $row = $('<tr>')
						.append($('<td>').addClass('text-center success').text(i+1))
						.append($('<td>').addClass('text-left').append($link))
						.append($('<td>').addClass('text-center').text(data[i].count));
					$("#tbodyAbstract").append($row);
				}

				chartArticleAbstract = new Highcharts.Chart(optionsArticleAbstract);
			});
		};

		//Chart and list ISSUES
		jQuery.fn.updateChartIssues = function() {

			optionsIssues.title.text = '{/literal}{translate key="plugins.generic.statistics.rankingIssues"}{literal} '+$('#year').text();
			
			$yearSelected = $('#year').text();
			
			jQuery.getJSON(base_location+'/getStatisticsIssues?year='+$yearSelected, null, function(data) {

				optionsIssues.series[0].data = [];

				$("#tbodyIssues").html('');
				for (var i = 0; i < data.length; i++){
					optionsIssues.series[0].data[i] = ["Vol. "+data[i].volume+", Num. "+data[i].number+", Year "+data[i].year, parseInt(data[i].count)];

					var $row = $('<tr>')
						.append($('<td>').addClass('text-center success').text(i+1))
						.append($('<td>').addClass('text-center').text(data[i].volume))
						.append($('<td>').addClass('text-center').text(data[i].number))
						.append($('<td>').addClass('text-center').text(data[i].year))
						.append($('<td>').addClass('text-left').text(data[i].name))
						.append($('<td>').addClass('text-center').text(data[i].count));
					$("#tbodyIssues").append($row);
				}

				chartIssues = new Highcharts.Chart(optionsIssues);
			});
		};

		
		/***********************************************************
		 *           			 CHARTS
		 ***********************************************************/
		
		//Chart Statistics month
		var chartMonth;
		var optionsMonth = {
			chart: {
	            renderTo: 'chartStatMonth',
	            type: typeChart,
	            options3d: {
	                enabled: false,
	                alpha: 10,
	                beta: 25,
	                depth: 70
	            }
	        },
	        title: {
	        	text: '{/literal}{translate key="plugins.generic.statistics.querysToTheJournal"}{literal}'+$('#year').text()
	        },
	        subtitle: {
	            text: '{/literal}{translate key="plugins.generic.statistics.byMonth"}{literal}'
	        },
	        xAxis: {
	            categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
	            crosshair: true
	        },
	        yAxis: {
		        min: 0,
	            title: {
	        		text: '{/literal}{translate key="plugins.generic.statistics.queryNumbers"}{literal}'
	            }
	        },
			tooltip: {
	            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
	            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
	                '<td style="padding:0"><b>{point.y:.0f}</b></td></tr>',
	            footerFormat: '</table>',
	            shared: true,
	            useHTML: true
	        },
	        plotOptions: {
	            column: {
	                pointPadding: 0.2,
	                borderWidth: 0
	            }
	        },
	        series: [],
			exporting: {
				buttons: {
					contextButton: {
						enabled: false
					}
				}
			}
		}

		//onload page load chart by MONTH
		jQuery.fn.updateChartMonth ();


		//*******************************************************************************************
		
		//Chart statistics year
		var chartByYear;
		var optionsByYear = {
			chart: {
	            renderTo: 'chartStatByYear',
	            type: typeChart,
	            options3d: {
	                enabled: false,
	                alpha: 10,
	                beta: 25,
	                depth: 70
	            }
	        },
	        title: {
	            text: ''
	        },
	        subtitle: {
	            text: '{/literal}{translate key="plugins.generic.statistics.lastYears2"}{literal}'
	        },
	        xAxis: {
	        	categories: [],
	        	crosshair: true
	        },
	        yAxis: {
	        	min: 0,
	            title: {
	        		text: '{/literal}{translate key="plugins.generic.statistics.queryNumbers"}{literal}'
	            }
	        },
	        tooltip: {
	            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
	            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
	                '<td style="padding:0"><b>{point.y:.0f}</b></td></tr>',
	            footerFormat: '</table>',
	            shared: true,
	            useHTML: true
	        },
	        plotOptions: {
	            column: {
	                pointPadding: 0.2,
	                borderWidth: 0
	            }
	        },
	        series: [],
			exporting: {
				buttons: {
					contextButton: {
						enabled: false
					}
				}
			}
		}


		//*******************************************************************************************
		
		//Chart statistics week
		var chartWeek;
		var optionsWeek = {
			chart: {
	            renderTo: 'chartStatWeek',
	            type: typeChart,
	            options3d: {
	                enabled: false,
	                alpha: 10,
	                beta: 25,
	                depth: 70
	            }
	        },
	        title: {
	            text: ''
	        },
	        subtitle: {
	            text: '{/literal}{translate key="plugins.generic.statistics.lastDays2"}{literal}'
	        },
	        xAxis: {
	        	categories: [],
	        	crosshair: true
	        },
	        yAxis: {
	        	min: 0,
	            title: {
	        		text: '{/literal}{translate key="plugins.generic.statistics.queryNumbers"}{literal}'
	            }
	        },
	        tooltip: {
	            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
	            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
	                '<td style="padding:0"><b>{point.y:.0f}</b></td></tr>',
	            footerFormat: '</table>',
	            shared: true,
	            useHTML: true
	        },
	        plotOptions: {
	            column: {
	                pointPadding: 0.2,
	                borderWidth: 0
	            }
	        },
	        series: [],
			exporting: {
				buttons: {
					contextButton: {
						enabled: false
					}
				}
			}
		}


		//*******************************************************************************************

		var chartCountryAbstract;
		
		var optionsPaisesAbstract = {
			chart: {
	            renderTo: 'chartCountryAbstract',
	            options3d: {
	                enabled: true,
	                alpha: 45,
	                beta: 0
	            }
	        },
	        title: {
	        	text: '{/literal}{translate key="plugins.generic.statistics.querysToTheJournal"}{literal}'+$('#year').text(),
	        },
	        tooltip: {
	            pointFormat: '{series.name}: <b>{point.y} - {point.percentage:.1f}%</b>'
	        },
	        plotOptions: {
	            pie: {
	                allowPointSelect: true,
	                cursor: 'pointer',
	                depth: 35,
	                dataLabels: {
	                    enabled: true,
	                    format: '{point.name} : {point.y}'
	                }
	            }
	        },
	        series: [{
	        	type: 'pie',
	        	name: '{/literal}{translate key="plugins.generic.statistics.viewByCountries"}{literal}',
                data: [
                ]
            }],
			exporting: {
				buttons: {
					contextButton: {
						enabled: false
					}
				}
			}
		}


		//*******************************************************************************************

		var chartCountryDownload;
		
		var optionsPaisesDownload = {
			chart: {
	            renderTo: 'chartCountryDownload',
	            options3d: {
	                enabled: true,
	                alpha: 45,
	                beta: 0
	            }
	        },
	        title: {
	        	text: '{/literal}{translate key="plugins.generic.statistics.querysToTheJournal"}{literal}'+$('#year').text(),
	        },
	        tooltip: {
	            pointFormat: '{series.name}: <b>{point.y} - {point.percentage:.1f}%</b>'
	        },
	        plotOptions: {
	            pie: {
	                allowPointSelect: true,
	                cursor: 'pointer',
	                depth: 35,
	                dataLabels: {
	                    enabled: true,
	                    format: '{point.name} : {point.y}'
	                }
	            }
	        },
	        series: [{
	        	type: 'pie',
	        	name: '{/literal}{translate key="plugins.generic.statistics.downloadByCountries"}{literal}',
                data: [
                ]
            }],
			exporting: {
				buttons: {
					contextButton: {
						enabled: false
					}
				}
			}
		}


		//*******************************************************************************************

		var chartArticleDownload;
				
		var optionsArticleDownload = {
			chart: {
	            renderTo: 'chartArticleDownload',
	            options3d: {
	                enabled: true,
	                alpha: 45,
	                beta: 0
	            }
	        },
	        title: {
	        	text: '{/literal}{translate key="plugins.generic.statistics.querysToTheJournal"}{literal}'+$('#year').text(),
	        },
	        tooltip: {
	            pointFormat: '{series.name}: <b>{point.y} - {point.percentage:.1f}%</b>'
	        },
	        plotOptions: {
	            pie: {
	                allowPointSelect: true,
	                cursor: 'pointer',
	                depth: 35,
	                dataLabels: {
	                    enabled: true,
	                    format: '{point.name} : {point.y}'
	                }
	            }
	        },
	        series: [{
	        	type: 'pie',
	        	name: '{/literal}{translate key="plugins.generic.statistics.downloadByCountries"}{literal}',
                data: [
                ]
            }],
			exporting: {
				buttons: {
					contextButton: {
						enabled: false
					}
				}
			}
		}

		//*******************************************************************************************

		var chartArticleAbstract;
				
		var optionsArticleAbstract = {
			chart: {
	            renderTo: 'chartArticleAbstract',
	            options3d: {
	                enabled: true,
	                alpha: 45,
	                beta: 0
	            }
	        },
	        title: {
	        	text: '{/literal}{translate key="plugins.generic.statistics.querysToTheJournal"}{literal}'+$('#year').text(),
	        },
	        tooltip: {
	            pointFormat: '{series.name}: <b>{point.y} - {point.percentage:.1f}%</b>'
	        },
	        plotOptions: {
	            pie: {
	                allowPointSelect: true,
	                cursor: 'pointer',
	                depth: 35,
	                dataLabels: {
	                    enabled: true,
	                    format: '{point.name} : {point.y}'
	                }
	            }
	        },
	        series: [{
	        	type: 'pie',
	        	name: '{/literal}{translate key="plugins.generic.statistics.viewAbstracts"}{literal}',
                data: [
                ]
            }],
			exporting: {
				buttons: {
					contextButton: {
						enabled: false
					}
				}
			}
		}

		//*******************************************************************************************

		var chartIssues;
				
		var optionsIssues = {
			chart: {
	            renderTo: 'chartIssues',
	            options3d: {
	                enabled: true,
	                alpha: 45,
	                beta: 0
	            }
	        },
	        title: {
	        	text: '{/literal}{translate key="plugins.generic.statistics.querysToTheJournal"}{literal}'+$('#year').text(),
	        },
	        tooltip: {
	            pointFormat: '{series.name}: <b>{point.y} - {point.percentage:.1f}%</b>'
	        },
	        plotOptions: {
	            pie: {
	                allowPointSelect: true,
	                cursor: 'pointer',
	                depth: 35,
	                dataLabels: {
	                    enabled: true,
	                    format: '{point.name} : {point.y}'
	                }
	            }
	        },
	        series: [{
	        	type: 'pie',
	        	name: '{/literal}{translate key="plugins.generic.statistics.viewAbstracts"}{literal}',
                data: [
                ]
            }],
			exporting: {
				buttons: {
					contextButton: {
						enabled: false
					}
				}
			}
		}

		/***********************************************************
		 *         			 	EVENTS
		 ***********************************************************/
		
		$('[data-toggle="tab"]').click(function(e) {
		    var $this = $(this);
		    href = $this.attr('href');
			if (href == "#tabMonth") {
				tabSelected = "tabMonth";
				if(chartMonth) chartMonth.destroy();
				jQuery.fn.updateChartMonth();

				$('#btnGroup button').removeAttr('disabled');
				
			} else if (href == "#tabYear") {
				tabSelected = "tabYear";
				if(chartByYear) chartByYear.destroy();
				jQuery.fn.updateChartByYear();
				
				$('#btnGroup button').removeAttr('disabled');
				
			} else if (href == "#tabWeek") {
				tabSelected = "tabWeek";
				if(chartWeek) chartWeek.destroy();
				jQuery.fn.updateChartWeek();
				
				$('#btnGroup button').removeAttr('disabled');
				
			} else if (href == "#tabByCountry") {
				tabSelected = "tabByCountry";
				if(chartCountryAbstract) chartCountryAbstract.destroy();
				if(chartCountryDownload) chartCountryDownload.destroy();
				jQuery.fn.updateChartPaisesAbstract();
				jQuery.fn.updateChartPaisesDownload();
				
				$('#btnGroup button').attr('disabled','disabled');
				
			} else if (href == "#tabArticleDownload") {
				tabSelected = "tabArticleDownload";
				if(chartArticleDownload) chartArticleDownload.destroy();
				jQuery.fn.updateChartArticleDownload();
				
				$('#btnGroup button').attr('disabled','disabled');
				
			} else if (href == "#tabArticleAbstract") {
				tabSelected = "tabArticleAbstract";
				if(chartArticleAbstract) chartArticleAbstract.destroy();
				jQuery.fn.updateChartArticleAbstract();

				$('#btnGroup button').attr('disabled','disabled');
				
			} else if (href == "#tabIssues") {
				tabSelected = "tabIssues";
				if(chartIssues) chartIssues.destroy();
				jQuery.fn.updateChartIssues();

				$('#btnGroup button').attr('disabled','disabled');
			}

		    $this.tab('show');

		    return false;
		});

	    $('#btnPrev').on('click', function (e) {
			$('#year').text($('#year').text()-1);
	    	if (tabSelected == "tabMonth") {
				$('this').updateChartMonth ();				
			} else if (tabSelected == "tabYear") {
				$('this').updateChartByYear ();
			} else if (tabSelected == "tabByCountry") {
				$('this').updateChartPaisesAbstract ();
				$('this').updateChartPaisesDownload ();
			} else if (tabSelected == "tabArticleDownload") {
				$('this').updateChartArticleDownload ();
			} else if (tabSelected == "tabArticleAbstract") {
				$('this').updateChartArticleAbstract ();
			} else if (tabSelected == "tabIssues") {
				$('this').updateChartIssues ();
			}
	    });

	    $('#btnNext').on('click', function (e) {
			$("#year").text($('#year').text()-0+1);
	    	if (tabSelected == "tabMonth") {
				$('this').updateChartMonth ();				
			} else if (tabSelected == "tabYear") {
				$('this').updateChartByYear ();
			} else if (tabSelected == "tabByCountry") {
				$('this').updateChartPaisesAbstract ();
				$('this').updateChartPaisesDownload ();
			} else if (tabSelected == "tabArticleDownload") {
				$('this').updateChartArticleDownload ();
			} else if (tabSelected == "tabArticleAbstract") {
				$('this').updateChartArticleAbstract ();
			} else if (tabSelected == "tabIssues") {
				$('this').updateChartIssues ();
			}
	    });

	    $('#btnTypeColumns').on('click', function (e) {

	    	$("#btnTypeColumns").attr('class', 'btn btn-success');
	    	$("#btnTypeColumnsStack").attr('class', 'btn btn-default');
	    	$("#btnTypeLine").attr('class', 'btn btn-default');

	    	typeChart = 'column';
			optionsMonth.chart.type = 'column';
		   	optionsMonth.plotOptions.column.stacking = '';
		   	optionsByYear.chart.type = 'column';
		   	optionsByYear.plotOptions.column.stacking = '';
			optionsWeek.chart.type = 'column';
		   	optionsWeek.plotOptions.column.stacking = '';

	    	if(tabSelected == "tabMonth") {
		    	chartMonth = new Highcharts.Chart(optionsMonth);
			} else if(tabSelected == "tabYear") {
			    chartByYear = new Highcharts.Chart(optionsByYear);
			} else if(tabSelected == "tabWeek") {
			    chartWeek = new Highcharts.Chart(optionsWeek);
			}
	    });

	    $('#btnTypeColumnsStack').on('click', function (e) {

	    	$("#btnTypeColumns").attr('class', 'btn btn-default');
	    	$("#btnTypeColumnsStack").attr('class', 'btn btn-success');
	    	$("#btnTypeLine").attr('class', 'btn btn-default');

	    	typeChart = 'column';
			optionsMonth.chart.type = 'column';
		   	optionsMonth.plotOptions.column.stacking = 'normal';
		   	optionsByYear.chart.type = 'column';
		   	optionsByYear.plotOptions.column.stacking = 'normal';
			optionsWeek.chart.type = 'column';
		   	optionsWeek.plotOptions.column.stacking = 'normal';

	    	if (tabSelected == "tabMonth") {
		    	chartMonth = new Highcharts.Chart(optionsMonth);
			} else if(tabSelected == "tabYear") {
			    chartByYear = new Highcharts.Chart(optionsByYear);
			} else if(tabSelected == "tabWeek") {
			    chartWeek = new Highcharts.Chart(optionsWeek);
			}
	    });


	    $('#btnTypeLine').on('click', function (e) {
	    	
	    	$("#btnTypeColumns").attr('class', 'btn btn-default');
	    	$("#btnTypeColumnsStack").attr('class', 'btn btn-default');
	    	$("#btnTypeLine").attr('class', 'btn btn-success');

	    	typeChart = 'line';
		    optionsMonth.chart.type = 'line';
			optionsMonth.plotOptions.column.stacking = '';
			optionsByYear.chart.type = 'line';
			optionsByYear.plotOptions.column.stacking = '';
			optionsWeek.chart.type = 'line';
		   	optionsWeek.plotOptions.column.stacking = '';

	    	if (tabSelected == "tabMonth") {
		    	chartMonth = new Highcharts.Chart(optionsMonth);
			} else if(tabSelected == "tabYear") {
			    chartByYear = new Highcharts.Chart(optionsByYear);
			} else if(tabSelected == "tabWeek") {
				chartWeek = new Highcharts.Chart(optionsWeek);
			}
	    });
	    
	}); //end ready function

 	{/literal}
</script>

</div>

{include file="frontend/components/footer.tpl"}