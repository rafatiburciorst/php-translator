<?php
require 'vendor/autoload.php';


use Stichoza\GoogleTranslate\GoogleTranslate;

$tr = new GoogleTranslate('pt');

echo $tr->translate('Hello my name is Rafael, I am a developer.');