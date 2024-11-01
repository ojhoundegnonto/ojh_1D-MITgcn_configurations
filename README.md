<h1> The MITgcm</h1>

The MIT General Circulation Model (MITgcm) is a sophisticated computational tool developed for investigating atmospheric, oceanic, and climatic phenomena. Its innovative design utilizes mathematical similarities between fluid systems, allowing a single core algorithm to model both atmospheric and oceanic currents. This versatile approach enables researchers to study a wide range of Earth system processes using a unified framework. The MITgcm has a non-hydrostatic capability that can be used to study both small-scale and large scale processes. It also resolved the sea ice, ocean-ice and land-ice dynamics processes. More detail can be found [here](https://mitgcm.readthedocs.io/en/latest/overview/overview.html). Additional documentation on the MITgcm features and how to use it can also be foud [here](https://readthedocs.org/projects/mitgcm/downloads/pdf/latest/). In the present study, we use the 1D ocean ice column with sea ice on top model derived from the MITgcm. The default code source can be found [here](https://github.com/MITgcm/MITgcm/tree/master/verification/1D_ocean_ice_column). In our study, the used configurations are described below.

<h1>How to install?</h1>

The MITgcm is developed to perform efficiently on a wide variety of computational platforms. The processes to build and run the MITgcm is described on the MITgcm main page ([here](https://mitgcm.readthedocs.io/en/latest/overview/overview.html)) under the sections `3. getting Started with MITgcm` [here](https://mitgcm.readthedocs.io/en/latest/getting_started/getting_started.html) and `4. MITgcm Tutorial Example Experiments` [here](https://mitgcm.readthedocs.io/en/latest/examples/examples.html). For the purpose of our analysis, the model compiled and run inside a `Docker` image set to host the latest stable version of `Ubunto` OS. The `Docker` image configuration is provided below.

<h1>Docker image to run the 1D ocean-ice column model</h1>

<h1>Configurations for the present work</h1>

For the present work:

- the folder `code` contains codes specific to the `1D ocean ice column model`. The full containt is as follow: `CPP_OPTIONS.h`, `SEAICE_OPTIONS.h`, `diffs.txt`
  `DIAGNOSTICS_SIZE.h`, `SIZE.h` and `packages.conf`.
- the folder `buil` contains the compiled model codes with the executable files `mitgcmuv`.
- the folder `run` contains all required input files including ocean initial conditions data, atmospheric forcing data, bathymerty data and the model configuration files. See the attached folder for cas example from the present work.

<h2>Before Conpilation</h2>

In the present study, the model vetical levels are set to 70. Thus, before the model source code compilation, the file `SIZE.h` was edited so that `Nr = 70`. In addition, the file of `package.conf` was edited with the following content: `gfd`, `kpp`, `seaice`, `exf`, `diagnostics`, `mnc` and `timeave`. In other words, the file `package.conf` stands for activating packages that are needed for the model simulations. See the attached files of `SIZE.h` and `package.conf` in the folder of `code`.

| Name          | Definition                                                                                                                                                                                                                                                                                                                                  |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `gfd`         | -                                                                                                                                                                                                                                                                                                                                           |
| `kpp`         | This allows the model to run with the K-profile parameterization (KPP) module for the vertical mixing and convection parameterizations.                                                                                                                                                                                                     |
| `seaice`      | -                                                                                                                                                                                                                                                                                                                                           |
| `exf`         | This allow the model to read the external forcing data file. In the present, the external forcing data are the atmospheric forcing data.                                                                                                                                                                                                    |
| `diagnostics` | -                                                                                                                                                                                                                                                                                                                                           |
| `mnc`         | This allow saving the model output in NetCDF file format.                                                                                                                                                                                                                                                                                   |
| `timeave`     | This allow the model to save the output at the specified time spet in the `data` configurations file. In our case, the model time step is set to hourly (`deltaTtracer=3600.0` and `deltaTClock =3600.0` in second) and we request the model to save the daily average (`monitorFreq=86400.`, in second) of each variable (cf. `data` file) |

NB: with `mnc` allowed in `package.conf`, the model outputs are save directely inside the folder `run/mnc_test_001`. The sufix `001` depend on how many time the model simulations are lunched:

- One => `001`,
- two => `002`,
- ...

So, we did not use the folder of `input` since all required input data are inserted into `run`. See the [4. MITgcm Tutorial Example Experiments](https://mitgcm.readthedocs.io/en/latest/examples/examples.html) of the main MITgcm page for more detail.

<h2>After Compilation</h2>

After the model's code source compilation, the `data`, `data.cal`, `data.diagnostics`, `data.exf` and `data.seaice` are edited from the default files (from the native folder `Verification`) as follow:

### `data` file:

The `data` file includes four main components: `PARM01`, `PARM02`, `PARM03`, `PARM04` and `PARM05` that hold specifics bloc instructions. The meaning of theses components can be found on the main page of MITgcm. In the present study, we edited the bloc instruction under `PARM03`, `PARM04` and `PARM05` from the default configurations as follow:

| Components | Instructions                   | Definitions                                                                                                                                                                                                                                                                                                                                                                                                   |
| ---------- | ------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| PARM03     | `startTime=0.0`                | set the simulation starting time as the same as indicated in `data.cal` file.                                                                                                                                                                                                                                                                                                                                 |
|            | `nTimeSteps= 3456`             | set the                                                                                                                                                                                                                                                                                                                                                                                                       |
|            | `deltaTtracer=3600.0`          | set the time derivative `dt` to hourly for each variable.                                                                                                                                                                                                                                                                                                                                                     |
|            | `deltaTClock =3600.0`          | set the time derivative `dt` to hourly for the model time record.                                                                                                                                                                                                                                                                                                                                             |
|            | `cAdjFreq=0.`                  | -                                                                                                                                                                                                                                                                                                                                                                                                             |
|            | `abEps=0.1`                    | -                                                                                                                                                                                                                                                                                                                                                                                                             |
|            | `tracForcingOutAB=1`           | -                                                                                                                                                                                                                                                                                                                                                                                                             |
|            | `pChkptFreq=0.`                | -                                                                                                                                                                                                                                                                                                                                                                                                             |
|            | `chkptFreq= 0.`                | -                                                                                                                                                                                                                                                                                                                                                                                                             |
|            | `umpFreq = 86400.`             | -                                                                                                                                                                                                                                                                                                                                                                                                             |
|            | `taveFreq = 2635000.`          | -                                                                                                                                                                                                                                                                                                                                                                                                             |
|            | `monitorFreq=86400.`           | -                                                                                                                                                                                                                                                                                                                                                                                                             |
| PARM04     | `usingCartesianGrid=.TRUE.`    | -                                                                                                                                                                                                                                                                                                                                                                                                             |
|            | `dXspacing=5000.`              | Horizontal derivative step value along `X axis` is set to `5000 m` (so `5 km`).                                                                                                                                                                                                                                                                                                                               |
|            | `dYspacing=5000.`              | Horizontal derivative step value along `Y axis` is set to `5000 m` (so `5 km`).                                                                                                                                                                                                                                                                                                                               |
|            | `delZ`                         | This defines the vertical derivative step value as the model vetical resolution. In our case, `delZ` is to `1` for each vertical level, so that the model vertival resolution is `1 m` over the whole depth.                                                                                                                                                                                                  |
| PARM05     | `bathyFile = 'bathy_1x1_file'` | The parameter `bathyFile` is the place to set the bathymetry to be considered at each location. Here, we considered for each cCTD location, the bathymetry as the depth at `1 m` below the `70th` level of each `T` & `S` profiles. When, the `T` and `S` profiles are shallow (less deeper than `65.5 m`), the bathymetry is considered as the depth at `1 m` below the last `non NaN` value of the profiles |
|            | `hydrogThetaFile = 'tRef.bin'` | `'tRef.bin'` is the potential temperature profile file used as the ocean initial temperature conditions. This file has to be save in `bin` and gib indian (`'>f4'`) format. See the python script folder for a python routine made for this purpose.                                                                                                                                                          |
|            | `hydrogSaltFile = 'sRef.bin'`  | `'sRef.bin'` is the salinity profile file used as the ocean initial salinity conditions. This file has to be save in `bin` and gib indian (`'>f4'`) format. See the python script folder for a python routine made for this purpose.                                                                                                                                                                          |

### `data.cal` file:

This file holds the model time configurations relative to the starting of the simulations and the forcing data.

### `data.diagnoastics` file:

The `data.diagnostics` file specify the variable to saved as output along with the model simulations. See

### `data.exf` file:

### `data.seaice` file:

The parameter `SEAICE_mcPheePiston` is set `0.0001` to allow the model to run at `1 m` vertical resolution. Note that the default setiing is: `SEAICE_mcPheePiston= 0.0008749999999999999`.

<h1>Results: Example from the present work</h1>

In the results, we include the NetCDF file of the model output for variables used in the present analysis. The NetCDF file include the following variables:

| Name            | Definition                                               |
| --------------- | -------------------------------------------------------- |
| `Longitude`     | Longitude coordinates at each cCTD cast locations        |
| `Latitude`      | Latitude coordinates at each cCTD cast locations         |
| `Temp`          | Potential temperature                                    |
| `Sal`           | Salinity                                                 |
| `ETA`           | Free surface r-anomaly                                   |
| `Ice_thickness` | Effective ice thickness                                  |
| `Ice_coverage`  | Fractional ice-covered area from FRSEAICE product        |
| `Ice_EmPmR`     | Net upward freshwater flux                               |
| `Ice_Qnet`      | Net upward surface heat flux (including shortwave)       |
| `Ice_Qsw`       | Net upward shortwave radiation                           |
| `EXFhs`         | Sensible heat flux into ocean, >0 increases theta        |
| `EXFhl`         | Latent heat flux into ocean, >0 increases theta          |
| `EXFempmr`      | Net upward freshwater flux, > 0 increases salinity       |
| `EXFpreci`      | Precipitation, > 0 decreases salinity                    |
| `EXFevap`       | Evaporation, > 0 increases salinity                      |
| `EXFaqh`        | Surface (2-m) specific humidity                          |
| `EXFatemp`      | Surface (2-m) air temperature                            |
| `EXFswdn`       | Downward shortwave radiation, >0 increases theta         |
| `EXFlwdn`       | Downward longwave radiation, >0 increases theta          |
| `EXFvwind`      | Meridional 10-m wind speed, >0 increases uVel            |
| `EXFuwind`      | Zonal 10-m wind speed, >0 increases uVel                 |
| `EXFqnet`       | Net upward heat flux (turb+rad), >0 decreases theta      |
| `EXFswnet`      | Net upward shortwave radiation, >0 decreases theta       |
| `EXFlwnet`      | Net upward longwave radiation, >0 decreases theta        |
| `SIqnet`        | Ocean surface heatflux, turb+rad, >0 decreases theta     |
| `SIqsw`         | Ocean surface shortwave radiat., >0 decreases theta      |
| `SIqneto`       | Open Ocean Part of SIqnet, turb+rad, >0 decreases theta  |
| `SIqneti`       | Ice Covered Part of SIqnet, turb+rad, >0 decreases theta |
