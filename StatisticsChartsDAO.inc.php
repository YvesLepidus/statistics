<?php
/**
  * @file plugins/generic/statistics/StatisticsChartsDAO.inc.php
  *
  * Copyright (c) 2016 Fran Máñez - Universitat Politècnica de Catalunya (UPC)
  * fran.upc@gmail.com
  *
  * Updated for OJS 3.x by: Reewos Talla <reewos.etc@gmail.com>, Conan <xdnan7@gmail.com>
  *
  * @class StatisticsChartsDAO
  *
  */

import('classes.statistics.MetricsDAO');

class StatisticsChartsDAO extends MetricsDAO {
	
	function getMetricsMonthByType($journalId, $assoc_type, $year) {
		$result = $this->retrieve(
			'SELECT month, SUM(metric) AS sum_metric FROM metrics WHERE context_id = ? AND assoc_type = ? AND SUBSTR(month,1,4) = ? GROUP BY month order by month ASC;',
			array((int) $journalId, (int) $assoc_type, $year)
		);

		$returner = [];
		if (!empty($result)) {
			foreach ($result as $row) {
				$returner[] = (array) $row;
			}
		}
		unset($result);

		return $returner;
	}
	
	function getMetricsYearByType($journalId, $assoc_type, $year) {
		$yearInit = $year-5;
		$yearEnd = $year;
		$result = $this->retrieve(
			'SELECT SUBSTR(month,1,4) AS year_name, SUM(metric) AS sum_metric FROM metrics WHERE context_id = ? AND assoc_type = ? AND SUBSTR(month,1,4)>= ? AND SUBSTR(month,1,4)<= ? GROUP BY SUBSTR(month,1,4) order by SUBSTR(month,1,4) ASC;',
			array((int) $journalId, (int) $assoc_type, $yearInit, $yearEnd)
		);

		$returner = [];
		if (!empty($result)) {
			foreach ($result as $row) {
				$returner[] = (array) $row;
			}
		}
		unset($result);

		return $returner;
	}
	
	function getMetricsWeekByType($journalId, $assoc_type) {
		$result = $this->retrieve(
			'SELECT day, SUM(metric) AS sum_metric FROM metrics WHERE context_id = ? AND assoc_type = ? AND CAST(day as date) > current_date - 9 GROUP BY day order by day DESC LIMIT 7;',
			array((int) $journalId, (int) $assoc_type)
		);

		$returner = [];
		if (!empty($result)) {
			foreach ($result as $row) {
				$returner[] = (array) $row;
			}
		}
		unset($result);

		return $returner;
	}
	
	function getMetricsByCountryType($journalId, $assoc_type, $year) {
		$result = $this->retrieve(
			'SELECT country_id, SUM(metric) AS sum_metric FROM metrics WHERE context_id = ? AND assoc_type = ? AND SUBSTR(month,1,4) = ? GROUP BY country_id order by SUM(metric) ASC LIMIT 20;',
			array((int) $journalId, (int) $assoc_type, $year)
		);

		$returner = [];
		if (!empty($result)) {
			foreach ($result as $row) {
				$returner[] = (array) $row;
			}
		}
		unset($result);

		return $returner;
	}
	
	function getMetricsMostPopularByType($journalId, $assoc_type, $year, $primaryLocale) {
		$result = $this->retrieve(
			"SELECT ps.setting_value, SUM(m.metric) AS sum_metric, m.submission_id FROM metrics as m ". 
			'INNER JOIN publications p ON m.submission_id = p.submission_id '.
			'INNER JOIN publication_settings ps ON p.publication_id = ps.publication_id '.
			'WHERE m.context_id = ? '.
			'AND m.assoc_type = ? '.
			'AND SUBSTR(m.month,1,4) = ? '.
			'AND p.status = 3 '.
			"AND ps.setting_name = 'title' ".
			'AND ps.locale = ? '.
			'GROUP BY ps.setting_value, m.submission_id ORDER BY SUM(m.metric) DESC LIMIT 20;',
			array((int) $journalId, (int) $assoc_type, $year, $primaryLocale)
		);
		
		$returner = [];
		if (!empty($result)) {
			foreach ($result as $row) {
				$returner[] = (array) $row;
			}
		}
		unset($result);

		return $returner;
	}
	
	function getMetricsIssues($journalId, $assoc_type, $year, $primaryLocale) {
		$result = $this->retrieve(
			'SELECT i.volume, i.number, i.year, iset.setting_value, SUM(m.metric) AS sum_metric FROM metrics as m '. 
			'inner join issues as i on m.assoc_id = i.issue_id '.
			'inner join issue_settings as iset on i.issue_id= iset.issue_id '.
			'WHERE m.context_id = ? '.
			'AND m.assoc_type = ? '.
			'AND SUBSTR(m.month,1,4) = ? '.
			"AND iset.setting_name = 'title' ".
			'AND iset.locale = ? '.
			'AND i.published = 1 '.
			'GROUP BY i.volume,i.number,i.year,iset.setting_value '.
			'ORDER BY SUM(m.metric) DESC LIMIT 20;',
			array((int) $journalId, (int) $assoc_type, $year, $primaryLocale)
		);
		
		$returner = [];
		if (!empty($result)) {
			foreach ($result as $row) {
				$returner[] = (array) $row;
			}
		}
		unset($result);

		return $returner;
	}
}
