<h1> The MITgcm</h1>

<h1>How to install?</h1>
<h1>Docker image to run the 1D ocean-ice column model</h1>
<h1>Configurations for the present work</h1>

<h2>Before Conpilation</h2>

In the present study, the model vetical levels are set to 70. Thus, before the model source code compilation, the file `SIZE.h` was edited so that `Nr = 70`. In addition, the file of `package.conf` was edited with the following content: `gfd`, `kpp`, `seaice`, `exf`, `diagnostics`, `mnc` and `timeave` (see the attached file of `SIZE.h` and `package.conf` in the folder of `code`).

| Name          | Definition                                                                                                                                                                                                                                                                                                                                  |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `gfd`         | -                                                                                                                                                                                                                                                                                                                                           |
| `kpp`         | This allows the model to run with the K-profile parameterization (KPP) module for the vertical mixing and convection parameterizations.                                                                                                                                                                                                     |
| `seaice`      | -                                                                                                                                                                                                                                                                                                                                           |
| `exf`         | This allow the model to read the external forcing data file. In the present, the external forcing data are the atmospheric forcing data.                                                                                                                                                                                                    |
| `diagnostics` | -                                                                                                                                                                                                                                                                                                                                           |
| `mnc`         | This allow saving the model output in NetCDF file format                                                                                                                                                                                                                                                                                    |
| `timeave`     | This allow the model to save the output at the specified time spet in the `data` configurations file. In our case, the model time step is set to hourly (`deltaTtracer=3600.0` and `deltaTClock =3600.0` in second) and we request the model to save the daily average (`monitorFreq=86400.`, in second) of each variable (cf. `data` file) |

<h2>After Compilation</h2>

After the model's code source compilation, the `data`, `data.cal`, `data.diagnostics`, `data.exf` and `data.seaice` are edited from the default files (from the native folder `Verification`) as follow:

### `data` file:

The `data` file includes four main components: `PARM01`, `PARM02`, `PARM03`, `PARM04` and `PARM05` that hold specifics bloc instructions. The meaning of theses components can be found on the main page of MITgcm. In the present study, we edited the bloc instruction under `PARM03`, `PARM04` and `PARM05` from the default configurations as follow:

| Components | Instructions          | Definitions                                                             |
| ---------- | --------------------- | ----------------------------------------------------------------------- |
| PARM03     | `startTime=0.0`       | set the simulation starting time as the same as indicated in `data.cal` |
|            | `nTimeSteps= 3456`    | set the                                                                 |
|            | `deltaTtracer=3600.0` | set the time derivative `dt` to hourl for each variable.                |
|            | `deltaTClock =3600.0` |                                                                         |
| PARM04     |                       |                                                                         |
| PARM05     |                       |                                                                         |

### `data.cal` file:

### `data.diagnoastics` file:

### `data.exf` file:

### `data.seaice` file:

The parameter `SEAICE_mcPheePiston` is set `0.0001` to allow the model to run at `1 m` vertical resolution. Note that the default setiing is: `SEAICE_mcPheePiston= 0.0008749999999999999`.

<h1>Results: Example from the present work</h1>

In the results, we include the NetCDF file of the model output for variables used in the present analysis. The NetCDF file include the following variables:

| Name            | Definition                                           |
| --------------- | ---------------------------------------------------- |
| `Longitude`     | Longitude coordinates at each cCTD cast locations    |
| `Latitude`      | Latitude coordinates at each cCTD cast locations     |
| `Temp`          | Potential temperature                                |
| `Sal`           | Salinity                                             |
| `ETA`           | Free surface r-anomaly                               |
| `Ice_thickness` | Effective ice thickness                              |
| `Ice_coverage`  | Fractional ice-covered area from FRSEAICE product    |
| `Ice_EmPmR`     | Net upward freshwater flux                           |
| `Ice_Qnet`      | Net upward surface heat flux (including shortwave)   |
| `Ice_Qsw`       | Net upward shortwave radiation                       |
| `EXFhs`         | Sensible heat flux into ocean, >0 increases theta    |
| `EXFhl`         | Latent heat flux into ocean, >0 increases theta      |
| `EXFempmr`      | Net upward freshwater flux, > 0 increases salinity   |
| `EXFpreci`      | Precipitation, > 0 decreases salinity                |
| `EXFevap`       | Evaporation, > 0 increases salinity                  |
| `EXFaqh`        | Surface (2-m) specific humidity                      |
| `EXFatemp`      | Surface (2-m) air temperature                        |
| `EXFswdn`       | Downward shortwave radiation, >0 increases theta     |
| `EXFlwdn`       | Downward longwave radiation, >0 increases theta      |
| `EXFvwind`      | Meridional 10-m wind speed, >0 increases uVel-       |
| `EXFuwind`      | Zonal 10-m wind speed, >0 increases uVel             |
| `EXFqnet`       | Net upward heat flux (turb+rad), >0 decreases theta  |
| `EXFswnet`      | Net upward shortwave radiation, >0 decreases theta   |
| `EXFlwnet`      | Net upward longwave radiation, >0 decreases theta    |
| `SIqnet`        | Ocean surface heatflux, turb+rad, >0 decreases theta |
| `SIqsw`         | Ocean surface shortwave radiat., >0 decreases theta  |
| `SIqneto`       | Open Ocean Part of SIqnet, turb+rad, >0 decr theta   |
| `SIqneti`       | Ice Covered Part of SIqnet, turb+rad, >0 decr theta  |
