# DUNE Setup Scripts

This repository contains setup and utility scripts related to the DUNE software environment. These scripts help configure simulation tools like GEANT4, GENIE, and GGD in a reproducible way.

## Contents

| Script Name             | Purpose |
|-------------------------|---------|
| `duneggd.sh`            | Sets up the DUNE GGD environment |
| `dunendggd.sh`          | ND-specific GGD configuration |
| `geant4_edepsim.sh`     | Standard GEANT4 + edep-sim environment setup |
| `geant4_edepsim_ups.sh` | UPS-based version of GEANT4 + edep-sim setup |
| `genie_v2_12_10c.sh`    | Loads GENIE v2.12.10c |
| `genie_v3_02_00b.sh`    | Loads GENIE v3.02.00b |

## Usage

Each script is meant to be sourced:

```bash
source ./geant4_edepsim.sh
```

You may need to adjust environment paths based on your working directory, CVMFS setup, or specific project versioning.

## Notes

- Scripts are tailored to FNAL/DUNE environments
- Intended as a personal utility toolbox for DUNE software

## Disclaimer

This repository is for personal use and workflow optimization. It does not represent official DUNE software distribution.
