# Tools on Cloud-V

## Using Environment Modules

Users can use environment modules to load different versions of same program. For using environment modules the pattern is as follows:

```shell
module load <PACKAGENAME/VERSION>
```  

_Important Note: Be sure to use `#!/bin/bash -l` instead of `#!/bin/bash` in CI pipeline file since that is required for environment modules to load_

For example if you want to load python version 3.9.2 compiled for x86, you will need to use following command:  

```shell
module load python/3.9.2
```  

For packages compiled for RISC-V architecture host, you will need to append `_riscv` to package name. For example, for python 3.8.15 compiled for RISC-V, following command will be used.  

```shell
module load python_riscv/3.8.15
```
