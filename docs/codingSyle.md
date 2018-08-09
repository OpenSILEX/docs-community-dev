# Coding style

## Comments

Comments must be only in english. Each complicated code should be explained with comments.

### Files headers

```java
//******************************************************************************
//                                       ${nameAndExt}
// SILEX-PHIS
// Copyright © INRA ${date?date?string("yyyy")}
// Contact: ${userEmail}, anne.tireau@inra.fr, pascal.neveu@inra.fr
//******************************************************************************
```
### Classes

```java
/**
 * Generate differents kinds of uris (vector, sensor, ...)
 * @update [Morgane Vidal] 04 July, 2018 : explanation
 * @update [Arnaud Charleroy] 18 July, 2018 : explanation
 * @see link to class or website
 * @author Morgane Vidal <morgane.vidal@inra.fr>, Arnaud Charleroy <arnaud.charleroy@inra.fr>
 */
 public class UriGenerator {
   //comments which explaint the attribute purpose with an example if needed
   String attribute;
 }
```
### Functions

```java
/**
  * generates a new vector uri. a vector uri has the following form :
  * <prefix>:<year>/<unic_code>
  * <unic_code> = 1 letter type + 2 numbers year + auto incremented number
  * with 3 digits (per year)
  * @error the error message possible or what happends if an error occured.
  * @example http://www.phenome-fppn.fr/diaphen/2017/v1702
  * @example
  * SELECT ?uri
  * WHERE {
  *     ?uri rdf:type <http://www.phenome-fppn.fr/vocabulary/2017#Vector>   
  * }
  * @param year the insertion year of the vector.
  * @return the new vector uri
  */
  public String generateVectorUri(String year) {
    ...
  }
```

If the function returns a boolean, the @return should be presented as the following example :
```java
/**
  * @return true explanation
  *         false explanation
  */
```

## Coding style

A Space between *if* and *)* is required. No space after *)* et before *(*. The *{* are mandatory. The same rules are applied to for and while.

```java
if (expression) {
}

for (expression) {

}

while (expression) {

}
```


## Tags

We are using SILEX tags to highlight some code blocks or add some additional information.

List of the actual existing tags :

```java
//SILEX:login
Used in the PHIS main client, to highlight the temporary login blocks of code.
//\SILEX:login

/*SILEX:required*/
Used in the main client css to highlight the automatic add of red asterisk on the required fields of the forms.
/*\SILEX:required*/

//SILEX:geographicLocation
Used to highlight the places where we should add the geographic location.
//\SILEX:geographicLocation

//SILEX:access
Used to highlight the places where the access rights are applied
//\SILEX:access

//SILEX:test
Used to highlight a test code block.
//\SILEX:test

//SILEX:conception
Used to highlight a block whom code design / architecture should be review or add ideas about that.
//\SILEX:conception

//SILEX:todo
Code to write, explained in simple words.
//\SILEX:todo

//SILEX:info
Information about a block of code or an idea or something complicated.
//\SILEX:info

//SILEX:sql
Code about an SQL query
//\SILEX:sql

//SILEX:refactor
Code which needs to be refactored
//\SILEX:refactor
```
