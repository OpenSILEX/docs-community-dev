---
title: Coding style
layout: default
---
# Coding style

## Comments

Comments must be only in english. Each complicated code should be explained with comments. This rules are design for *Java* and *Php* and must be respected as much as possible for other languages.

### Files headers

Date must be in english format, for example "27 Aug, 2018"

```java
//******************************************************************************
//                                       ${nameAndExt}
// SILEX-PHIS
// Copyright © INRA ${date?date?string("yyyy")}
// Creation date: ${date}
// Contact: ${userEmail}, anne.tireau@inra.fr, pascal.neveu@inra.fr
//******************************************************************************
```
### Classes

```java
/**
 * Generate differents kinds of uris (vector, sensor, ...)
 * @update [Morgane Vidal] 04 July, 2018: explanation
 * @update [Arnaud Charleroy] 18 July, 2018: explanation
 * @see link to class or website
 * @author Morgane Vidal <morgane.vidal@inra.fr>, Arnaud Charleroy <arnaud.charleroy@inra.fr>
 */
 public class UriGenerator {
   //comment which explains the attribute purpose with an example if needed
   String attribute;
 }
```
### Functions

```java
/**
  * Generate a new vector uri. A vector uri has the following form:
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

If the function returns a boolean, the @return should be presented as the following example:
```java
/**
  * @return true explanation
  *         false explanation
  */
```

## Blank Lines

**Two blank lines** should always be used in the following circumstances:
* Between sections of a source file
* Between class and interface definitions

**One blank line** should always be used in the following circumstances:
* Between methods
* Between the local variables in a method and its first statement
* Before a block or single-line comment
* Between logical sections inside a method to improve readability

```java
/**
* comment
**/
public interface MyInterface {
    Boolean isEmptyMethod();
}


/**
* comment
**/
class Sample extends Object {
    int ivar1;
    int ivar2;

    Sample(int i, int j) {
        int k;

        i = k;

        /* comment */
        ivar1 = i;
        ivar2 = j;     
    }

    int emptyMethod() {}

    Boolean isEmptyMethod() {}
    ...
}
```


## Blank Spaces

Blank spaces should be used in the following circumstances:
* A keyword followed by a parenthesis should be separated by a space.
A Space between *if* and *)* is required. No space after *)* and before *(*. The *{* are mandatory. The same rules apply to *for* and *while*.

```java
if (expression) {
}

for (expression) {
}

while (expression) {
}
```
Note that a blank space should not be used between a method name and its opening parenthesis. This helps to distinguish keywords from method calls.

```java
callMethod();
this.myMethod();
```

* Variable affectation: a space between *=* is also required.
```java
  myVariable = 33 ;
```

* All **binary operators** (+, +=, ++, etc.) except *.* should be separated from their operands by spaces. Blank spaces should never separate unary operators such as unary minus, increment ("++"), and decrement ("--") from their operands.
```java
a += c + d;
a = (a + b) / (c * d);
```

## Tags

We are using SILEX tags to highlight some code blocks or add some additional information.

List of the actual existing tags:

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
Used to highlight a block whom code design / architecture should be review or add ideas about.
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
