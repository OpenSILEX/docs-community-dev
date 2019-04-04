---
title: Coding style
layout: default
---
# Coding style

## Comments

Comments must be only in english. Each complicated code should be explained with comments. This rules are design for *Java* and *Php* and must be respected as much as possible for other languages.

### Files headers

The date must be in the "DD MM YYYY" English format (e.g "27 Aug. 2018").

```java
//******************************************************************************
//                                ${nameAndExt}
// SILEX-PHIS
// Copyright © INRA ${date?date?string("yyyy")}
// Creation date: ${date}
// Contact: ${userEmail}, anne.tireau@inra.fr, pascal.neveu@inra.fr
//******************************************************************************
```
### Classes

```java
/**
 * DAO mother class. 
 * Provides generic functions to query the storage. 
 * Comments begins with a capital letter and ends with a dot.
 * The @author tag designates the first contributors of the class. A contributor that 
 * updates the class won't be considered as an @author.
 * @update [Alice Boizet, Michel Simon] 4 Sept. 2018: explanation.
 * @update [Andréas Garcia] 18 Sept. 2018: explanation.
 * @see optional link to class or website that helps the comprehension of the class.
 * @param <T> the type of object handled.
 * @author Morgane Vidal <morgane.vidal@inra.fr>, Arnaud Charleroy <arnaud.charleroy@inra.fr>
 */
 public class DAO<T> {
   
   /**
    * Comment which explains the complexeAttribute purpose.
    * All attributes are private. They are accessible from other classes throught the
    * getters and setters functions.
    * @example possible value for this attribute without parenthesis.
    */
   private String complexeAttribute;
   
   // Comment which explains the simpleAttribute purpose.
   private String simpleAttribute;
 }
```
### Functions

```java
/**
  * Generates a new vector URI. A vector URI has follow this pattern:
  * <prefix>:<year>/<unic_code>
  * <unic_code> = 1 letter type + 2 numbers year + auto incremented number
  * with 3 digits (per year).
  * Functions comment generally starts with a verb in the third person.
  * @error the error message possible or what happends if an error occured.
  * @example http://www.phenome-fppn.fr/diaphen/2017/v1702
  * @example
  * SELECT ?uri
  * WHERE {
  *     ?uri rdf:type <http://www.phenome-fppn.fr/vocabulary/2017#Vector>   
  * }
  * @param year the insertion year of the vector.
  * @return the new vector URI.
  */
  public String generateVectorUri(String year) {
    ...
  }
```

If the function returns a boolean, the @return tag should be presented as follows:
```java
/**
  * @return true explanation.
  *         false explanation.
  */
```
Function names must be meaningful. The name must specify the exact action of the function and for most cases must start with a verb. (e.g. createPasswordHash).

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

## Variables
Follow the coding global best practices. See for example this article https://dzone.com/articles/best-practices-variable-and.

Main rules to follow :
* use meaningful names
* avoid abbreviations: "connection" instead of "con" 
* use Camel Case (aka Upper Camel Case) for classes: VelocityResponseWriter
* use Lower Case for packages: com.company.project.ui
* use Mixed Case (aka Lower Camel Case) for variables: studentName
* use Upper Case for constants : MAX_PARAMETER_COUNT = 100
* use Camel Case for enum class names and Upper Case for enum values.
* don't use '_' anywhere except constants and enum values (which are constants).

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
