import 'package:console/console.dart' show Console;
import 'package:dcli/dcli.dart' show cyan, red;

import 'package:sembast_client_dart/config/index.dart';

enum PrintQuery { normal, inline, warn, error }

String lang(int index, [PrintQuery? typeQuery, List<String>? custom]) {

  final app = container.resolve<App>();

  List<String> dictEsp = [
    "No has especificado un archivo de base de datos.",
    "Este archivo no existe.",
    "Este archivo no es válido para la lectura",
    "Este archivo no es de sembast.",
    "Contraseña: ",
    "La contraseña de encriptación que proporcionaste no es correcta.",
    "Todos los derechos reservados.",
    "Escriba 'help' para obtener ayuda, 'exit' para salir",
    "Te falta escribir el store",
    "No hay ningún store seleccionado",
    "Te falta escribir el key",
    "La orden ${custom != null ? custom[0] : ''} no es reconocido",
    "El store ${custom != null ? custom[0] : ''} está vacío o no está registrado",
    "El store ${custom != null ? custom[0] : ''} tiene ${custom != null && custom.length > 1 ? custom[1] : ''} records con llaves de tipo entero",
    "El store ${custom != null ? custom[0] : ''} tiene ${custom != null && custom.length > 1 ? custom[1] : ''} records con llaves de tipo cadena",
    "No existe ningún record con esa llave",
    "La llave debe ser un número entero",
    "\tVerifica si el store tiene elementos",
    "\tSelecciona el store para operar",
    "\t\tLista todos los records del store seleccionado",
    "\tObtiene el record que coincida con esa llave",
    "\tInserta un record con una llave especificada, hasta que el usuario envie '*'",
    "\tInserta un record con una llave especificada, usando la sintaxis de JSON",
    "\tActualiza un record con una llave especificada, sólo con en un campo existente",
    "\tActualiza un record con una llave especificada, usando JSON, si no encuentra el campo a editar, lo crea",
    "\tElimina el elemento que coincida con esa llave",
    "\t\tElimina todos los elementos del store seleccionado",
    "\t\tDevincularse del store actual",
    "Ya existe un record con esa llave",
    "Record insertado correctamente",
    "La sintaxis escrita no es válida",
    "Ya existe un record con esta llave",
    "Clave (Pulsa '*' y enter para guardar, o '%' para cancelar): ",
    "La clave ya existe",
    "Valor: ",
    "Record insertado correctamente",
    "La llave debe ser un número entero",
    "El store está vacío",
    "No existe ningún record con esa llave",
    "¿Estás seguro? (s/n): ",
    "Record eliminado exitosamente",
    "El store está vacío",
    "¿Estás seguro?, esto puede comprometer seriamente los datos (s/n): ",
    "Store eliminado exitosamente",
    "Record actualizado correctamente",
    "Clave (Pulsa '%' para cancelar): ",
    "La clave no existe",
    "Este store está vacío, ¿qué tipo de llave quieres usar? (int/str): ",
    "Este store usa llaves de tipo entero con un total de ${custom != null ? custom[0] : ''} records",
    "Este store usa llaves de tipo cadena con un total de ${custom != null ? custom[0] : ''} records",
    "\tLista todos los records dado un rango de índices",
    "El formato es incorrecto, debe ser 'start' 'end', por ejemplo: 0 10",
    "Alguno de los valores no es un número entero",
    "El valor de inicio debe ser menor al valor final",
  ];

  List<String> dictEng = [
    "Database file not found in args",
    "This file not found.",
    "This file is not a database file.",
    "This file is not a sembast database file.",
    "Password: ",
    "The encryption password you provided is incorrect.",
    "All rights reserved.",
    "Type 'help' for help, 'exit' to exit",
    "You need to write the store",
    "There is no store selected",
    "You need to write the key",
    "The order ${custom != null ? custom[0] : ''} is not recognized",
    "The store ${custom != null ? custom[0] : ''} is empty or not registered",
    "The store ${custom != null ? custom[0] : ''} has ${custom != null && custom.length > 1 ? custom[1] : ''} records with integer keys",
    "The store ${custom != null ? custom[0] : ''} has ${custom != null && custom.length > 1 ? custom[1] : ''} records with string keys",
    "There is no record with that key",
    "The key must be an integer number",
    "\tVerifies if the store has elements",
    "\tSelect the store to operate",
    "\t\tList all records of the selected store",
    "\tGet the record that matches that key",
    "\tInsert a record with a specified key, until the user sends '*'",
    "\tInsert a record with a specified key, using JSON syntax",
    "\tUpdate a record with a specified key, only with an existing field",
    "\tUpdate a record with a specified key, using JSON, if it does not find the field to edit, it creates it",
    "\tDelete the element that matches that key",
    "\t\tDelete all elements of the selected store",
    "\t\tDetach from the current store",
    "There is already a record with that key",
    "Record inserted correctly",
    "The written syntax is not valid",
    "There is already a record with that key",
    "Key (Press '*' and enter to save, or '%' to cancel): ",
    "The key already exists",
    "Value: ",
    "Record inserted correctly",
    "The key must be an integer number",
    "The store is empty",
    "There is no record with that key",
    "Are you sure? (y/n): ",
    "Record deleted successfully",
    "The store is empty",
    "Are you sure?, this can seriously compromise the data (y/n): ",
    "Store deleted successfully",
    "Record updated successfully",
    "Key (Press '%' to cancel): ",
    "The key does not exist",
    "This store is empty, what type of key do you want to use? (int/str): ",
    "This store uses integer keys with a total of ${custom != null ? custom[0] : ''} records",
    "This store uses string keys with a total of ${custom != null ? custom[0] : ''} records",
    "\tList all records given a range of indices",
    "The format is incorrect, it must be 'start' 'end', for example: 0 10",
    "One of the values is not an integer number",
    "The start value must be less than the final value",
  ];

  if(typeQuery == null) {
    return app.english ? dictEng[index] : dictEsp[index];
  } else {
    switch(typeQuery) {
      case PrintQuery.normal:
        print(app.english ? dictEng[index] : dictEsp[index]);
        return "";
      case PrintQuery.inline:
        Console.write(app.english ? dictEng[index] : dictEsp[index]);
        return "";
      case PrintQuery.warn:
        Console.write(cyan("[*] "));
        print("WARNING: ${app.english ? dictEng[index] : dictEsp[index]}");
        return "";
      case PrintQuery.error:
        Console.write(red("[*] "));
        print("ERROR: ${app.english ? dictEng[index] : dictEsp[index]}");
        return "";
    }
  }
}