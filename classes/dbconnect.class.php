<?php

static class dbconnection {
	private static $connection;

	public static function establish ()
	{
		try
		{
			self::$connection = new \PDO ('mysql:dbname=utenze:host=localhost', 'root', 'P455word!');
		} catch ($PDOException)
		{
			throw new \ErrorException ('An error occurred while trying to establish a database connection: ' . $PDOException->getMessage (), $PDOException->getCode (), $PDOException->getSeverity ());
		}
	}
}

?>
