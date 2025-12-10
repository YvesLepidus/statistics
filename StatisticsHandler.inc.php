<?php
/**
  * @file plugins/generic/statistics/StatisticsHandler.inc.php
  *
  * Copyright (c) 2016 Fran Máñez - Universitat Politècnica de Catalunya (UPC)
  * fran.upc@gmail.com
  *
  * Updated for OJS 3.x by: Reewos Talla <reewos.etc@gmail.com>, Conan <xdnan7@gmail.com>
  *
  * @class StatisticsHandler
  *
  */

import('classes.handler.Handler');
import('classes.core.Application');

class StatisticsHandler extends Handler {

	/**
	 * Constructor
	 **/
	function StatisticsHandler() {
		parent::__construct();
	}
	
	/**
	 * Display the main log analyzer page.
	 */
	function index($args, $request) {
		//this plugin depends on 'Counter Plugin'
		//$plugins =& PluginRegistry::getPlugins();
		
		$this->validate(null, null);
		$this->setupTemplate(true);
		$plugin =& $this->plugin;

		$templateManager =& TemplateManager::getManager();
		
		
		// library highcharts jquery
		$templateManager->addJavaScript('highcharts',$request->getBaseUrl().'/plugins/generic/statistics/js/highcharts/highcharts.js',array('contexts'));
		$templateManager->addJavaScript('highcharts-3d',$request->getBaseUrl().'/plugins/generic/statistics/js/highcharts/highcharts-3d.js',array('contexts'));
		$templateManager->addJavaScript('grid-light',$request->getBaseUrl().'/plugins/generic/statistics/js/highcharts/themes/grid-light.js',array('contexts'));
		$templateManager->addJavaScript('exporting',$request->getBaseUrl().'/plugins/generic/statistics/js/highcharts/modules/exporting.js',array('contexts'));
		
		$templateManager->addJavaScript('bootstrap',$request->getBaseUrl().'/plugins/generic/statistics/js/bootstrap.min.js',array('contexts'));
		$templateManager->addJavaScript('bootstrap-switch',$request->getBaseUrl().'/plugins/generic/statistics/js/bootstrap-switch.min.js',array('contexts'));
		
		//$templateManager->display('/frontend/pages/statistics.tpl');
		$templateManager->display('../plugins/generic/statistics/index.tpl');
	}
	
	
	function getStatisticsWeek() {
		$request = \Application::get()->getRequest();
		$journal = $request->getJournal();
		
		//statistics report
		$statisticsChartsDAO =& DAORegistry::getDAO('StatisticsChartsDAO');
			
		//statistics abstract
		$result = $statisticsChartsDAO->getMetricsWeekByType($journal->getId(), ASSOC_TYPE_SUBMISSION);
		StatisticsHandler::dataForWeek($cols, $result);
		StatisticsHandler::day($days, $result);
		
		$obj[0] = new stdClass();
		$obj[0]->name = AppLocale::Translate('plugins.generic.statistics.viewAbstracts');
		$obj[0]->values = array_reverse($cols);
		$obj[0]->day = array_reverse($days);
		unset($cols);
		
		//statistics download
		$result = $statisticsChartsDAO->getMetricsWeekByType($journal->getId(), ASSOC_TYPE_SUBMISSION_FILE);
		StatisticsHandler::dataForWeek($cols, $result);
		StatisticsHandler::day($days, $result);
		
		$obj[1] = new stdClass();
		$obj[1]->name = AppLocale::Translate('plugins.generic.statistics.viewDownloads');
		$obj[1]->values = array_reverse($cols);
		$obj[1]->day = array_reverse($days);
		unset($cols);

		echo json_encode($obj);
	}
	
	
	
	
	/**
	 * Get statistics (download and abstract) by month year from table METRICS
	 */

	function getStatisticsByMonth() {
		$request = \Application::get()->getRequest();
		$journal =& $request->getJournal();

		$year = $request->getUserVar('year');
		if (empty($year)) $year = date('Y');
		
		//statistics report
		$statisticsChartsDAO =& DAORegistry::getDAO('StatisticsChartsDAO');
			
		//statistics abstract
		$result = $statisticsChartsDAO->getMetricsMonthByType($journal->getId(), ASSOC_TYPE_SUBMISSION, $year);
		StatisticsHandler::dataForMonth($cols, $result);
		$obj[0] = new stdClass();
		$obj[0]->name = AppLocale::Translate('plugins.generic.statistics.viewAbstracts');
		$obj[0]->values = $cols;
		unset($cols);
		
		//statistics download
		$result = $statisticsChartsDAO->getMetricsMonthByType($journal->getId(), ASSOC_TYPE_SUBMISSION_FILE, $year);
		StatisticsHandler::dataForMonth($cols, $result);
		$obj[1] = new stdClass();
		$obj[1]->name = AppLocale::Translate('plugins.generic.statistics.viewDownloads');
		$obj[1]->values = $cols;
		unset($cols);

		echo json_encode($obj);
	}
	
	
	/**
	 * Get statistics (download and abstract) by year from table METRICS
	 */
	function getStatisticsByYear() {
		$request = \Application::get()->getRequest();
		$journal =& $request->getJournal();
		$year = $request->getUserVar('year');
		if (empty($year)) $year = date('Y');
		
		$statisticsChartsDAO =& DAORegistry::getDAO('StatisticsChartsDAO');
			
		//statistics abstract
		$result = $statisticsChartsDAO->getMetricsYearByType($journal->getId(), ASSOC_TYPE_SUBMISSION, $year);
		StatisticsHandler::dataForYear($cols, $result, $year);
		$obj[0] = new stdClass();
		$obj[0]->name = AppLocale::Translate('plugins.generic.statistics.viewAbstracts');
		$obj[0]->values = $cols;
		unset($cols);
		
		//statistics download
		$result = $statisticsChartsDAO->getMetricsYearByType($journal->getId(), ASSOC_TYPE_SUBMISSION_FILE, $year);
		StatisticsHandler::dataForYear($cols, $result, $year);
		$obj[1] = new stdClass();
		$obj[1]->name = AppLocale::Translate('plugins.generic.statistics.viewDownloads');
		$obj[1]->values = $cols;
		unset($cols);
		
		echo json_encode($obj);
	}
	
	/**
	 * Get statistics (abstract) by country from table METRICS
	 */
	function getStatisticsByCountryAbstract() {
		$request = \Application::get()->getRequest();
		$journal =& $request->getJournal();
		$year = $request->getUserVar('year');
		if (empty($year)) $year = date('Y');
		
		$statisticsChartsDAO =& DAORegistry::getDAO('StatisticsChartsDAO');
		$result = $statisticsChartsDAO->getMetricsByCountryType($journal->getId(), ASSOC_TYPE_SUBMISSION, $year);
		
		$i = 0;
		$obj = array();
		
		if (!empty($result)) {
			foreach ($result as $record) {
				$obj[$i] = new stdClass();
				$obj[$i]->country = $record['country_id'] == null ? "Others" : $record['country_id'];
				$obj[$i]->count = $record['sum_metric'];
				$i++;
			}
		}
		
		echo json_encode($obj);
	}
	
	/**
	 * Get statistics (download) by country from table METRICS
	 */
	function getStatisticsByCountryDownload() {
		$request = \Application::get()->getRequest();
		$journal =& $request->getJournal();
		$year = $request->getUserVar('year');
		if (empty($year)) $year = date('Y');
		
		$statisticsChartsDAO =& DAORegistry::getDAO('StatisticsChartsDAO');
		$result = $statisticsChartsDAO->getMetricsByCountryType($journal->getId(), ASSOC_TYPE_SUBMISSION_FILE, $year);
		$i = 0;
		$obj = array();
		if (!empty($result)) {
			foreach ($result as $record) {
				$obj[$i] = new stdClass();
				$obj[$i]->country = $record['country_id'] == null ? "Others" : $record['country_id'];
				$obj[$i]->count = $record['sum_metric'];
				$i++;
			}
		}
		
		echo json_encode($obj);
	}
	
	/**
	 * Get statistics (download or abstract, request parameter) most popular articles from table METRICS
	 */
	function getStatisticsMostPopularDownload() {
		$request = \Application::get()->getRequest();
		$journal =& $request->getJournal();
		$primaryLocale = $journal->getPrimaryLocale();

		$year = $request->getUserVar('year');
		if (empty($year)) $year = date('Y');
		
		$type = $request->getUserVar('type');
		
		$statisticsChartsDAO =& DAORegistry::getDAO('StatisticsChartsDAO');
		$result = $statisticsChartsDAO->getMetricsMostPopularByType($journal->getId(), $type, $year, $primaryLocale);
		
		$i = 0;
		$obj = array();
		if (!empty($result)) {
			foreach ($result as $record) {
				$object = (object) array('article' => $record['setting_value'], 'count' => $record['sum_metric'], 'id' => $record['submission_id']);
				$obj[] = $object;
				$i++;
			}
		}
		
		echo json_encode($obj);
	}
	
	/**
	 * Get statistics (download) most popular articles from table METRICS
	 */
	function getStatisticsIssues() {
		$request = \Application::get()->getRequest();
		$journal =& $request->getJournal();
		$primaryLocale = $journal->getPrimaryLocale();

		$year = $request->getUserVar('year');
		if (empty($year)) $year = date('Y');
		
		//statistics report
		$statisticsChartsDAO =& DAORegistry::getDAO('StatisticsChartsDAO');
			
		//statistics abstract
		$result = $statisticsChartsDAO->getMetricsIssues($journal->getId(), ASSOC_TYPE_ISSUE, $year, $primaryLocale);
		
		$i = 0;
		$obj = array();
		if (!empty($result)) {
			foreach ($result as $record) {
				$object = (object) array('volume' => $record['volume'], 'number' => $record['number'], 'year' => $record['year'], 'name' => $record['setting_value'], 'count' => $record['sum_metric']);
				$obj[] = $object;
				$i++;
			}
		}
		
		echo json_encode($obj);
	}
	
	/**
	 * Validate that user has site admin privileges or journal manager priveleges.
	 * Redirects to the user index page if not properly authenticated.
	 * @param $canRedirect boolean Whether or not to redirect if the user cannot be validated; if not, the script simply terminates.
	 */
	function validate($requiredContexts = NULL, $request = NULL) {
		parent::validate();
		$plugin =& Registry::get('plugin');
		$this->plugin =& $plugin;
		return true;
	}

	
	/**
	 * ************************************************************
	 * 					PARSER DATA FUNCTIONS
	 * ************************************************************
	 */
	
	private function dataForMonth(&$cols, $entries) {
		if($entries == null) return;
		$currTotal = 0;
		for ($i = 1; $i <= 12; $i++) {
			$currTotal = 0;
			foreach ($entries as $entry) {
				$month = substr($entry['month'], -2, 2);
				if ($i==$month) {
					$currTotal += $entry['sum_metric'];
				}
			}
			$cols[]=$currTotal;
		}
	}
	
	private function dataForWeek(&$cols, $entries) {
		if($entries == null) return;
		foreach($entries as $entry) {
			$currTotal = 0;
			$currTotal += $entry['sum_metric'];
			$cols[]=$currTotal;
		}
	}

	private function day(&$cols, $entries) {
		if($entries == null) return;
		foreach($entries as $entry) {
			$currTotal = substr($entry['day'],-2,2) . "/" . substr($entry['day'],-4,2) . "/" . substr($entry['day'],0,4) ;
			$cols[]=$currTotal;
		}
	}
	
	private function dataForYear(&$cols, $entries, $year) {
		if($entries == null) return;
		$currTotal = 0;
		for ($i = $year-5; $i <= $year; $i++) {
			$currTotal = 0;
			foreach ($entries as $entry) {
				if ($i==$entry['year_name']) {
					$currTotal += $entry['sum_metric'];
				}
			}
			$cols[]=$currTotal;
		}
	}
}
