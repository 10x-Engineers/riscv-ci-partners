# Adding Custom-build packages in Jenkins
_*NOTE:* For this documentation, Ubuntu 22.04 and Jenkins version 2.371 is used._

While working open-source, many times one may need to build the package from source code. While working on the local machine, the built package may be accessible by adding it to the `$PATH` environment variable. But while working with Jenkins, This may not work.

## Where to install package for Jenkins job
In Jenkins job, the package is installed on the node (or agent) on which the specific job is being used and **NOT** on the node where the jenkins controller node is installed. For example if the Jenkins controller node is on `computer1` and slave node on which the `job` is destined to run is on `computer2` then `computer2` should have all the packages used by the `job` and not the `computer1`.

## Adding the package to Jenkins
Considering there is a node with name `Runner1` in jenkins on which the `job` is destined to run and that job uses a toolchain `riscv64-unknown-elf-gcc` to run properly and that toolchain is present in directory `/home/runner1/path_to_install/bin`, then the following procedure is used to add the toolchain in Jenkins.
- Go to `Dashboard > Manage Jenkins > Nodes > Runner1`.
- Scroll down and check `Environment variables`.
- Under section `List of variables` add:
    - `Name` as `PATH`
    - `Value` as `$PATH:/home/runner1/path_to_install/bin`.
- Click on `Save`.
After this, the package should be available to be used.

