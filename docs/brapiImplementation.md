---
title: Developping a new BrAPI service
layout: default
---
# Developping a new BrAPI service
You can see BrAPI documentation in [https://brapi.org](https://brapi.org/)

## Return new call informations in the Calls service

The service Calls returns information from every Phis web services which are BrAPI compliant.
So when you create a new BrAPI service, in order to retrieve your call information in the calls service, you need to follow these instructions:
* Your class NewBrAPIResourceService must implement the interface BrapiCall to override the method callInfo() where you can give your new call information (name, datatypes, methods and versions).
You can follow the code example below.
```java
public class CallsResourceService implements BrapiCall {
    final static Logger LOGGER = LoggerFactory.getLogger(CallsResourceService.class);
    /**
     * Overriding BrapiCall method
     * @date 27 Aug 2018
     * @return Calls call information
     */
    @Override
    public Call callInfo() {
        ArrayList<String> calldatatypes = new ArrayList<>();
        calldatatypes.add("json");
        ArrayList<String> callMethods = new ArrayList<>();
        callMethods.add("GET");
        ArrayList<String> callVersions = new ArrayList<>();
        callVersions.add("1.1");
        callVersions.add("1.2");
        Call callscall = new Call("calls", calldatatypes, callMethods, callVersions);
        return callscall;
    }
```

* You have to modify the class phis2ws/services/ApplicationInitConfig.java. and add the line  `bind(NewBrapiResourceService.class).to(BrapiCall.class);` inside the `new AbstractBinder(){}`.

```java
register(new AbstractBinder() {
    @Override
    protected void configure() {
        // create the session from the last sessionId received
        bindFactory(SessionFactory.class).to(Session.class);
        // Session injection thanks to the type defined in SessionInjectResolver
        bind(SessionInjectResolver.class)
                .to(new TypeLiteral<InjectionResolver<SessionInject>>() {
                })
                .in(Singleton.class);
        //Brapi services injection
        bind(CallsResourceService.class).to(BrapiCall.class);
        bind(NewBrapiResourceService.class).to(BrapiCall.class);
    }
});
```
