<h1> The MITgcm</h1>
<h1>How to install?</h1>
<h1>Docker image to run the 1D ocean-ice column model</h1>
<h1>Configurations for the present work</h1>
<h2>Before Conpilation</h2>

# SIZE.h

In the present study, the model vetical levels are set to 70. Thus, the file "SIZE.h" is edited so that `Nr = 70`.

# package.conf

The file of `package.conf` was edited with the following content:
`gfd
kpp
seaice
exf
diagnostics
mnc
timeave
`

<h2>After Compilation</h2>
<h1>Example from the present work</h1>
