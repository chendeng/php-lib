<?php
/**
 * debuging('dtrace');          //查看调用栈
 * debuging($var);                      //打印$var(var_dump)
 * debuging($var, 'php');       //打印$var(var_export)
 * debuging($var, $echo, 2); //以json格式输出$var
 */
function debuging($var = '', $echo = '', $die = false, $force = false){
    static $clear;
    if(0 && $clear === null){
        ob_end_flush();
        $clear = true;
    }

    static $trace;
    if($var === 'dtrace' || isset($_GET['dtrace']) && empty($trace)){
        $trace = 1;
        $echo = getTrace();
    }

    $force && $_GET['debug'] = 1;
    if(isset($_GET['debug'])){
		echo "================================= <br>\n";
		debugingPos();
        if($die === 2){
            header('Content-type: application/json');
            echo json_encode($var);
        }else{
            echo "<pre>\n";
            if($echo){
                echo "$echo:";
            }
            if($echo === 'php')
                var_export($var);
            else
                var_dump($var);
            echo "</pre>\n";
        }
        $die && die;
    }
}
function debugingPos(){
	$pos = debug_backtrace(2, 2)[1];
    if(isset($pos['class'])){
        echo "{$pos['class']}->{$pos['function']} <br>\n";
    }else{
        echo "{$pos['function']}(): {$pos['file']} . (line:{$pos['line']})<br>\n";
    }
}
function getTrace(){
	try{
		static $lastTime;
		$lastTime or $lastTime = $_SERVER['REQUEST_TIME'];
		$currTime = microtime(true);
		$totalTime = $currTime-$_SERVER['REQUEST_TIME'];
		$execTime = $currTime-$lastTime;$lastTime = $currTime;
		$msg = "<hr>\n".
			"execTime: $execTime s.<br/>\n" .
			"totalTime: $totalTime s.<br/>\n".
			"Trace:<br/>\n";
		throw new Exception();
	}catch(Exception $e){
		//debug_print_backtrace();
		return $msg . $e->getTraceAsString();
	}
}

/**
 * xhprof
 */
if(isset($_GET['DEBUG']) && function_exists('xhprof_enable')){
	xhprof_enable(XHPROF_FLAGS_CPU + XHPROF_FLAGS_MEMORY);
	ob_start(function($buf){
		$xhprof_data = xhprof_disable();
		$XHPROF_ROOT = '/tmp/xhprof';
		include_once $XHPROF_ROOT . "/xhprof_lib/utils/xhprof_lib.php";
		include_once $XHPROF_ROOT . "/xhprof_lib/utils/xhprof_runs.php";
		$source = 'xhprof_debug';
		$run_id = (new XHProfRuns_Default())->save_run($xhprof_data, $source);
		$url = "http://{$_SERVER['SERVER_ADDR']}:8000/index.php?run={$run_id}&source=$source";
		$link =  "<a href='$url'> $url</a><br>";
		return $link . $buf;
	});
}
