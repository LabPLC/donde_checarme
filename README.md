# Donde Checarme

[![Build Status](https://travis-ci.org/LabPLC/donde_checarme.svg?branch=master)](https://travis-ci.org/LabPLC/donde_checarme)
[![Dependency Status](https://gemnasium.com/LabPLC/donde_checarme.svg)](https://gemnasium.com/LabPLC/donde_checarme)
[![Code Climate](https://codeclimate.com/github/LabPLC/donde_checarme.png)](https://codeclimate.com/github/LabPLC/donde_checarme)
[![Coverage Status](https://coveralls.io/repos/LabPLC/donde_checarme/badge.png)](https://coveralls.io/r/LabPLC/donde_checarme)

En este proyecto encontraras la localizacion de los centros de salud del DF

**_Donde Checarme_** es una aplicación desarrollada en **Ruby on Rails** como despachador de páginas y Javascript con Coffee Script como front-end para localizar los elementos en el mapa.

## ¿Cómo utilizar tus propios puntos?

**Donde Checarme** fue realizado con el objetivo de desarrollar a futuro un framework sencillo de localización en un mapa de puntos georreferenciados

Actualmente **Donde Checarme** utiliza una API REST desarrollada en RubyOnRails que devuelve la latitud y longitud de los puntos en formato JSON. Estos puntos son tomados por el script en CoffeeScript para luego ser colocados en el mapa. 

El modelo y la API actualmente desarrollado en la app de RubyOnRails no son necesarios. Si quieres utilizar tus propios puntos, simplemente modifica los endpoints en el script de CoffeeScript para que **Donde Checarme** reciva los datos de tu API.

## Uso

	rails server

## Datos

Los datos de las clinicas, hospitales y centros de salud utilizados por **Donde Checarme** fueron proporcionados por la [Secretaría de Salud del Distrito Federal](http://www.salud.df.gob.mx/‎) mediante el [Laboratorio de Datos](http://datos.labplc.mx/)

## Preguntas, comentarios, etc

Puedes utilizar [Github Issue tracker](https://github.com/LabPLC/donde_checarme/issues) para cualquier bug o problema que encuentres con la aplicación. Así mismo puedes contactar a [@juancar1os](http://www.twitter.com/juancar1os)
