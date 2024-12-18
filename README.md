<h1> The MITgcm</h1>

The MIT General Circulation Model (MITgcm) is a sophisticated computational tool developed for investigating atmospheric, oceanic, and climatic phenomena. Its innovative design utilizes mathematical similarities between fluid systems, allowing a single core algorithm to model both atmospheric and oceanic currents. This versatile approach enables researchers to study a wide range of Earth system processes using a unified framework. The MITgcm has a non-hydrostatic capability that can be used to study both small-scale and large scale processes. It also resolved the sea ice, ocean-ice and land-ice dynamics processes. More detail can be found [here](https://mitgcm.readthedocs.io/en/latest/overview/overview.html). Additional documentation on the MITgcm features and how to use it can also be foud [here](https://readthedocs.org/projects/mitgcm/downloads/pdf/latest/). In the present study, we use the 1D ocean ice column with sea ice on top model derived from the MITgcm. The default code source can be found [here](https://github.com/MITgcm/MITgcm/tree/master/verification/1D_ocean_ice_column). In our study, the used configurations are described below.

<h1>How to install?</h1>

The MITgcm is developed to perform efficiently on a wide variety of computational platforms. The processes to build and run the MITgcm is described on the MITgcm main page ([here](https://mitgcm.readthedocs.io/en/latest/overview/overview.html)) under the sections `3. getting Started with MITgcm` ([here](https://mitgcm.readthedocs.io/en/latest/getting_started/getting_started.html)) and `4. MITgcm Tutorial Example Experiments` ([here](https://mitgcm.readthedocs.io/en/latest/examples/examples.html)). For the purpose of our analysis, the model compiled and run inside a `Docker` image set to host the latest stable version of `Ubunto` OS. The `Docker` image configuration is provided below.

<h1>Docker image to run the 1D ocean-ice column model</h1>

The 1D MITgcm ocean-ice column simulations were performed using a Docker image. The Docker image was built from ECCO-v4r4 Docker image that can be foud `here`!!.

<h1>Configurations for the present work</h1>

For the present work:

- the folder `code` contains codes specific to the `1D ocean ice column model`. The full content is as follow: `CPP_OPTIONS.h`, `SEAICE_OPTIONS.h`, `diffs.txt`
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

- One time => `mnc_test_001` ; two times => `mnc_test_002`, ...

So, we did not use the folder of `input` since all required input data are inserted into `run`. See the [4. MITgcm Tutorial Example Experiments](https://mitgcm.readthedocs.io/en/latest/examples/examples.html) of the main MITgcm page for more detail.

<h2>After Compilation</h2>

After the model's code source compilation, the `data`, `data.cal`, `data.diagnostics`, `data.exf` and `data.seaice` are edited from the default configurations files (from the native folder [verification/1D_ocean_ice_column](https://github.com/MITgcm/MITgcm/tree/master/verification/1D_ocean_ice_column)) as follow:

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

The `data.diagnostics` file specify the variable to save as output along with the model simulations. See the attached file for example case of the present work.

### `data.exf` file:

This file is set to specify the atmospheric forcing data. See the attached file for example case of the present work.

### `data.seaice` file:

The parameter `SEAICE_mcPheePiston` is set `0.0001` to allow the model to run at `1 m` vertical resolution. Note that the default setiing is: `SEAICE_mcPheePiston= 0.0008749999999999999`.

#### Note:

All configurations files of `data`,`data.cal`, `data.diagnoastics`, `data.exf` and `data.seaice` can found in the folder `Config_files`.

<h1>Results: output from simulations</h1>

In the folder `data_and_output`, we include the NetCDF file of the model output for variables used in the present analysis. It also contains the atmospheric forcing data that we used (see: ).
