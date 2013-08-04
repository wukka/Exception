#!/usr/bin/env php
<?php
include __DIR__ . '/../autoload.php';
use Wukka\Test as T;
use Wukka\Exception;

T::plan(10);

$e = new Exception();

T::ok( $e instanceof \Exception, 'instantiated an empty exception');
T::is( $e->getErrorParameters(), array(), 'got error parameters back');
T::is( $e->getMessage(), '', 'empty message, none passed in');
T::is( $e->getDebug(), NULL, 'no debug set');
T::like( $e->__toString(), "#wukka([\\\\])exception#i", '__toString method implemented');

$e = new Exception(array('message'=>'test', 'debug'=>'foo', 'bar'=>'bazz') );

T::is( $e->getMessage(), 'test', 'instantiated an exception with the message in an array');
T::is( $e->getDebug(), 'foo', 'got debug from the array');
$p = $e->getErrorParameters();
T::is( $p['bar'], 'bazz', 'got a parameter from the exception');

$e = new Exception('test', $debug = new stdclass);
T::is( $e->getMessage(), 'test', 'standard instantiation, passes message in properly');
T::is( $e->getDebug(), $debug, 'got the debug object');