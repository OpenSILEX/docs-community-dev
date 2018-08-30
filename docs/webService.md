# Web Service

## Java Bean Validation (JSR 380)

When you create a new service, you must use the [Java Bean Validation](https://beanvalidation.org/2.0/spec/#builtinconstraints) to validate the input parameters.

### Use an existing constraint

You can add a verification on the DTO for the post and the ResourceService classes for the get parameters.

```java
public class ExampleResourceService {

  @GET
  public Response get(
    @QueryParam("url") @Required @URL String url
  ) {
    ...
  }

  @POST
  public Response post(ArrayList<ExampleDTO> @Valid examples) {
    ...
  }
}

public class ExampleDTO {
  String url;
  SecondExample secondExample;

  @URL
  @Required
  public String getUrl() {
    return url;
  }

  @Valid
  public SecondExample getSecondExample() {
    return secondExample;
  }
}
```

### Create a custom constraint validation

Create the custom validation annotation in the package `service.resources.validation.validators`.

```java
public class URLListValidator implements ConstraintValidator<URL, List<String>> {

    @Override
    public void initialize(URL constraintAnnotation) {
    }

    @Override
    public boolean isValid(List<String> valueList, ConstraintValidatorContext context) {
        if (valueList == null) {
            return true;
        }

        Boolean allValid = true;
        String lastUrlCheck = null;

        // loop over string
        for (String url : valueList) {
            final java.net.URL finalUrl;
            lastUrlCheck = url;
            try {
                finalUrl = new java.net.URL(url);
            } catch (MalformedURLException e1) {
                allValid = false;
            }
        }

        // if not valid returns the last false index
        if (!allValid) {
            context.disableDefaultConstraintViolation();
            context.buildConstraintViolationWithTemplate(
                    "The string at the index [" + valueList.indexOf(lastUrlCheck) + "] is not an URL"
            ).addConstraintViolation();
        }

        return allValid;
    }
}
```

Create the custom validation annotation interface in the package `service.resources.validation.interfaces`.

```java
@Target(value={METHOD,FIELD,ANNOTATION_TYPE,CONSTRUCTOR,PARAMETER})
@Retention(RUNTIME)
@Constraint(validatedBy = {URLValidator.class,URLListValidator.class})
public @interface URL {
    String message() default "is not an URL";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

    /**
     * This code block is used to applied the validator to a list of elements.
     */
    @Target(value = {METHOD,FIELD,ANNOTATION_TYPE,CONSTRUCTOR,PARAMETER})
    @Retention(value =RUNTIME)
    @Documented
    public @interface List {
        public URL[] value();
    }
}
```
You can then use your custom constraint validator such as the [built in constraints](https://beanvalidation.org/2.0/spec/#builtinconstraints) by using `@URL`.

For more examples see the others custom constraints validators of the web services in the packages `service.resources.validation.validators` and `service.resources.validation.interfaces`.
