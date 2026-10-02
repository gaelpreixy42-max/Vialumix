# Vialumix — Minecraft 1.20.1

Vialumix is a Fabric client mod project intended to combine the Iris/Sodium shader workflow with a dedicated Vulkan ray-tracing backend inspired by Radiance/MCVR.

## Current development state

- Fabric 1.20.1 client entrypoint.
- Sodium 0.5.13 + Iris 1.7.6 integration as compile-time dependencies.
- Custom Vialumix graphics screen.
- Shaderpack enumeration and application delegated to Iris.
- Persistent Vialumix configuration.
- Separate render-backend state (`iris` / `vulkan`).
- Vulkan capability probe for hardware ray tracing.
- Instance-local NVIDIA NGX runtime discovery.
- Separate capability checks for DLSS Super Resolution, Ray Reconstruction and Frame Generation.
- Native bridge prepared for the MCVR renderer.

## DLSS runtime layout

Vialumix uses its own instance directory rather than modifying Radiance's directory:

    .minecraft/vialumix/
        nvngx_dlss.dll
        nvngx_dlssd.dll
        nvngx_dlssg.dll   (optional)
        core.dll          (native Vialumix/MCVR renderer, once built)
        shaders/          (native pipeline assets)
        modules/          (native pipeline modules)

The NVIDIA DLLs are not downloaded by Vialumix. They must be obtained from the appropriate NVIDIA distribution and kept under their applicable license terms.

## Important architecture note

Iris shaderpacks are OpenGL/GLSL-oriented. MCVR/Radiance is a Vulkan renderer. Therefore, simply loading an Iris shaderpack inside MCVR does not make the two systems compatible. The final Vialumix RT path requires a shader compatibility/translation layer (GLSL shaderpack semantics -> Vialumix/MCVR Vulkan pipeline) in addition to the Java UI and JNI bridge.

The current project intentionally keeps this boundary explicit: Iris remains the normal backend, while the Vulkan backend is selected only when its native renderer is actually available. This avoids presenting a UI toggle as a fake ray-tracing implementation.

## Native build

The small `native/` target builds the capability/JNI bridge. The real renderer is based on MCVR and is configured separately because MCVR has its own third-party submodules and generated JNI headers.

Example:

    cmake -S native -B native/build -DVIALUMIX_MCVR_ROOT="C:/path/to/MCVR"
    cmake --build native/build --config Release

The complete installable mod JAR must be produced by Gradle/Loom in an environment with access to the Fabric/Minecraft Maven artifacts. This development environment cannot reach the Gradle/Maven network, so no fake JAR is included.


## Java de compilation

Minecraft 1.20.1 / Fabric Loom doit être compilé avec un JDK compatible. Java 25 n'est pas utilisable avec Gradle 8.14.1 dans cette configuration (major version 69). `tools/BUILD_AND_INSTALL.bat` tente automatiquement d'utiliser un Java compatible déjà présent, notamment un runtime du launcher Minecraft. Sinon, installe JDK 17 ou 21.
