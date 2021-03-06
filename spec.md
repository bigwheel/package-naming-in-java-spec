## 6.1. Declarations

#### Package Names and Module Names

Developers should take steps to avoid the possibility of two published packages having the same name by choosing unique package names for packages that are widely distributed. This allows packages to be easily and automatically installed and catalogued. This section specifies a suggested convention for generating such unique package names. Implementations of the Java SE Platform are encouraged to provide automatic support for converting a set of packages from local and casual package names to the unique name format described here.

If unique package names are not used, then package name conflicts may arise far from the point of creation of either of the conflicting packages. This may create a situation that is difficult or impossible for the user or programmer to resolve. The classes ClassLoader and ModuleLayer can be used to isolate packages with the same name from each other in those cases where the packages will have constrained interactions, but not in a way that is transparent to a naïve program.

You form a unique package name by first having (or belonging to an organization that has) an Internet domain name, such as oracle.com. You then reverse this name, component by component, to obtain, in this example, com.oracle, and use this as a prefix for your package names, using a convention developed within your organization to further administer package names. Such a convention might specify that certain package name components be division, department, project, machine, or login names.

```
Example 6.1-1. Unique Package Names

com.nighthacks.scrabble.dictionary
org.openjdk.compiler.source.tree
net.jcip.annotations
edu.cmu.cs.bovik.cheese
gov.whitehouse.socks.mousefinder
```

The first component of a unique package name is always written in all-lowercase ASCII letters and should be one of the top level domain names, such as com, edu, gov, mil, net, or org, or one of the English two-letter codes identifying countries as specified in ISO Standard 3166.

In some cases, the Internet domain name may not be a valid package name. Here are some suggested conventions for dealing with these situations:

* If the domain name contains a hyphen, or any other special character not allowed in an identifier (§3.8), convert it into an underscore.

* If any of the resulting package name components are keywords (§3.9), append an underscore to them.

* If any of the resulting package name components start with a digit, or any other character that is not allowed as an initial character of an identifier, have an underscore prefixed to the component.

The name of a module should correspond to the name of its principal exported package. If a module does not have such a package, or if for legacy reasons it must have a name that does not correspond to one of its exported packages, then its name should still start with the reversed form of an Internet domain with which its author is associated.

```
Example 6.1-2. Unique Module Names

com.nighthacks.scrabble
org.openjdk.compiler
net.jcip.annotations
```

The first component of a package or module name must not be the identifier java. Package and module names that start with the identifier java are reserved for packages and modules of the Java SE Platform.

The name of a package or module is not meant to imply where the package or module is stored on the Internet. For example, a package named edu.cmu.cs.bovik.cheese is not necessarily obtainable from the host cmu.edu or cs.cmu.edu or bovik.cs.cmu.edu. The suggested convention for generating unique package and module names is merely a way to piggyback a package and module naming convention on top of an existing, widely known unique name registry instead of having to create a separate registry for package and module names.
