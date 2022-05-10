<?php

class bolletta implements validable {

	protected null|string	$numero;
	protected null|string	$data_di_emissione;
	protected null|string	$data_di_scadenza;
	protected null|string	$periodo_contabile;
	protected null|float	$importo;

	use \validate;

	public function __construct (null|string $numero = null, null|string $data_di_emissione = null, null|string $data_di_scadenza = null, null|string $periodo_contabile = null, null|float $importo = null)
	{
		$this->numero = $numero;
		$this->data_di_emissione = $data_di_emissione;
		$this->data_di_scadenza = $data_di_scadenza;
		$this->periodo_contabile = $periodo_contabile;
		$this->importo = $importo;
	}

	public function set_numero (string $numero): void
	{
		$this->numero = $numero;
	}
	
	public function set_data_di_emissione (string $data_di_emissione)
	{
		$this->validate ($data_di_emissione, )
	}

	public function __get ($attribute): mixed
	{
		if (property_exists (__CLASS__, $attribute))
		{
			return $this->$attribute;
		}

		throw new \ErrorException ("L'attributo richiesto ($attribute) non esiste nella classe " . __CLASS__, 0, E_USER_ERROR);
	}

	public function __set ($attribute, $value): void
	{
		//\Exception $e;

		if (property_exists (__CLASS__, $attribute))
		{
			try
			{
				$this->$attribute = $value;
			} catch (\Exception $e)
			{
				throw new \ErrorException ("Il valore $value non è compatibile con l'attributo $attribute della classe " . __CLASS__, 0, E_USER_ERROR);
			}
		}
		else
		{
			throw new \ErrorException ("L'attributo richiesto ($attribute) non esiste nella classe " . __CLASS__, 0, E_USER_ERROR);
		}
	}

	public function __serialize (): array
	{
		return array (
			'id'	=>	$this->id,
			'utenza'	=>	$this->utenza,
			'numero'	=>	$this->numero,
			'emissione'	=>	$this->emissione,
			'scadenza'	=>	$this->scadenza,
			'periodo'	=>	$this->periodo,
			'importo'	=>	$this->importo
		);
	}

	public function __unserialize (array $array)
	{
		array_key_exists ('id') || throw new \ErrorException ("Non è definito un valore corrispondente alla chiave 'id': impossibile ricostruire l'oggetto", 0 , E_USER_ERROR);
		array_key_exists ('utenza') || throw new \ErrorException ("Non è definito un valore corrispondente alla chiave 'utenza': impossibile ricostruire l'oggetto", 0 , E_USER_ERROR);
		array_key_exists ('numero') || throw new \ErrorException ("Non è definito un valore corrispondente alla chiave 'numero': impossibile ricostruire l'oggetto", 0 , E_USER_ERROR);
		array_key_exists ('emissione') || throw new \ErrorException ("Non è definito un valore corrispondente alla chiave 'emissione': impossibile ricostruire l'oggetto", 0 , E_USER_ERROR);
		array_key_exists ('scadenza') || throw new \ErrorException ("Non è definito un valore corrispondente alla chiave 'scadenza': impossibile ricostruire l'oggetto", 0 , E_USER_ERROR);
		array_key_exists ('periodo') || throw new \ErrorException ("Non è definito un valore corrispondente alla chiave 'periodo': impossibile ricostruire l'oggetto", 0 , E_USER_ERROR);
		array_key_exists ('importo') || throw new \ErrorException ("Non è definito un valore corrispondente alla chiave 'importo': impossibile ricostruire l'oggetto", 0 , E_USER_ERROR);

		$this->id = $array ('id');
		$this->utenza = $array ('utenza');
		$this->numero = $array ('numero');
		$this->emissione = $array ('emissione');
		$this->scadenza = $array ('scadenza');
		$this->periodo = $array ('periodo');
		$this->importo = $array ('importo');
	}

	public function __toString (): string
	{
		return "Bolletta " . $this->utenza . " nr " . $this->numero . " del " . $this->emissione . "in scadenza il " . $this->scadenza . " (Periodo: " . $this->periodo . "): " . $this->importo . " €.";
	}
}

?>
