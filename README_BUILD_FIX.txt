Vialumix 1.20.1 - Build fix v10

Correction: the previous build used Gradle settings-level dependency repositories with
RepositoriesMode.PREFER_SETTINGS. Fabric Loom adds required Minecraft/Mojang repositories
at project level, so Gradle was ignoring them and could not resolve authlib, brigadier,
etc. The settings file has been corrected to let Loom manage those repositories.

Java 17 is correct for this Minecraft/Fabric 1.20.1 project.
