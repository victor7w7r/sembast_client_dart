# Sembast Client for CLI

A CLI client for basic manipulation of sembast database files

![Alt text](brandwhite.png?raw=true "Title")

## Prerequisites of use

- Basic notion of JSON and NoSQL
- Basic usage of sembast database

## Features

- Password authentication for encoded databases
- Basic IO operations for stores

## Usage

```
 check <store>  Verifies if the store has elements
 use <store>    Select the store to operate

 ls             List all records of the selected store
 get <key>      Get the record that matches that key
 insert <key>   Insert a record with a specified key, until the user sends '*'
 ijson <key>    Insert a record with a specified key, using JSON syntax
 limit <start> <end>    List all records given a range of indices
 update <key>   Update a record with a specified key, only with an existing field
 ujson <key>    Update a record with a specified key, using JSON, if it does not find the field to edit, it creates it
 rm <key>       Delete the element that matches that key
 rmall          Delete all elements of the selected store
 detach         Detach from the current store
```