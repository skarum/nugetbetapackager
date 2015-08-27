# nugetbetapackager
Auto create nuget package beta versions

_More documentation will follow..._

In short it does the following:

* Looks for a <code>.nuspec</code> file in the current path
* Looks for a corresponding <code>nupgk</code> in my local nuget feed
* Figurest out the last beta build number and increments it by 1
* Build the project, package it and publish it to my local feed
