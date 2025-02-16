# How to -ish

## Ingredients

- `nvidia-detect`
- `nvidia-settings`

## Steps

1. See check what card is installed
2. Backup system
3. Install nvidia poop
4. Reboot


### Step 1: See check what card is installed

- install `nvidia-detect` 
- run it 

```bash
$ nvidia-detect
Detected NVIDIA GPUs:
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation TU117GLM [Quadro T1000 Mobile] [10de:1fb9] (rev a1)

Checking card:  NVIDIA Corporation TU117GLM [Quadro T1000 Mobile] (rev a1)
Your card is supported by all driver versions.
Your card is also supported by the Tesla 470 drivers series.
It is recommended to install the
    nvidia-driver
package.
```

> it says to install `nvidia-driver` but this didn't work for me for some reason

> i was never able to find the command that told me which driver I was using

### Step 2: Backup system

Assuming you are on a `btrfs` filesystem, take a snapshot:

```bash
$ sudo btrfs subvolume snapshot / /snapshots/post-linux-nvidia-driver
```

You will eventually need to delete this.  If you don't need to boot it haha.

### Step 3: Install nvidia poop

```bash
$ sudo install nvidia-settings
```

I had better luck with `nvidia-settings` than `nvidia-driver` for some reason.  Anyway you get little GUI thing from nvidia out of the deal.


### Step 4: Reboot



## References

in no particular order...

- [1](https://linuxcapable.com/install-nvidia-drivers-on-debian/)
- [2](https://linuxconfig.org/how-to-install-nvidia-driver-on-debian-12-bookworm-linux)
- [3](https://phoenixnap.com/kb/nvidia-drivers-debian)
- [4](https://idroot.us/install-nvidia-drivers-debian-12/)
