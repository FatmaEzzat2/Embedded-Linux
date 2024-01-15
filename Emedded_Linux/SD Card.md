

# How to create a Virtual SD image in Linux

We have the option to emulate an SD card instead of investing in physical hardware, achieved by creating a virtual image file on our hard disk.

## ****Steps to create a virtual SD image:****

## 📌 ****Step 1 : Create an image of the SD card****

```bash
dd if=/dev/zero of=sd.img bs=1M count=1024
```

- In this case, This command creates a file named **`sd.img`** filled with zeros (null bytes) and a size of 1 GB (1024 MB)
- After completing this step, you will find **`sd.img`** in the current directory.
    1. **`dd`** command is a powerful utility for copying and converting data. It stands for "data duplicator" and is commonly used for tasks like creating disk images, copying data between devices, and formatting storage media.
    2. **`if=/dev/zero`**: The input file is **`/dev/zero`**, which is a special file that produces null bytes when read.
    3. **`of=sd.img`**: The output file is **`sd.img`**, where the null bytes will be written.
    4. **`bs=1M`**: Sets the block size to 1 megabyte. This is the amount of data that **`dd`** reads and writes at a time.
    5. **`count=1024`**: Specifies the number of blocks to copy. In this case, it's set to 1024, creating a 1 GB file.

## 📌**Step 2: We need to divide the SD card into two partitions and configure them**

- The total size of SD card is 1 GB
    1. ***FAT** partition size is  200 MB*
    2. ***EXT4** partition size is 800 MB*
    
    ```bash
    cfdisk sd.img
    ```
    
- Once we run the command, **`cfdisk`** will open a text-based interface for managing partitions.
- It provides some options to configure the partition table of the SD card
    1. **Navigate using arrow keys:**
        - Use the arrow keys to move between options.
        - Use Enter to select an option.
    2. **Create a new partition:**
        - Select the "New" option to create a new partition.
        - Specify the partition size and type (primary or extended).
            - For a typical **FAT partition**, set the size (200 MB) and the type **primary**
            - For a typical **EXT partition,** set the size (800 MB) and the type **extended**
    3. **Set the partition type:**
        - After creating a partition, select the "Type" option to set the partition type.
        - For a typical **FAT partition**, set the type FAT.
        - For a typical **EXT partition,** set the type Linux
    4. Assign the **“Boot”** feature to the FAT partition
        - by selecting “**Bootable**” option
    5. **Write changes:**
        - Once you've made your desired changes, select the "Write" option to write the new partition table to the image file.
    6. **Quit:**
        - After writing the changes, select the "Quit" option to exit **`cfdisk`**.

***Now that we have `sd.img` as a file, our objective is to use it as block storage, so…***

## 📌Step 3: **Emulate the sd.img as a Storage Device**

After running this command, you should see the loop device associated with the image file. For example, it might output something like **`/dev/loop0`**. If there are partitions, you'll also see devices like **`/dev/loop0p1`** for the first partition.

```bash
sudo losetup -f --show --partscan sd.img
```

After running this command, you should see the loop device associated with the image file .

- **`f`**: Find the first available loop device.
- **`--show`**: Display the name of the loop device.
- **`--partscan`**: Automatically scan and create loop devices for partitions within the image file.

***You can check the associated loop device by running:***

```bash
losetup -l
```

or 

```bash
lsblk
```

## 📌**Step 4: Create file systems on a storage device**

Now, we want to format SD card partitions to be :

- partition 1 will be ***a FAT** file* system on a storage device with label "boot”
- partition 2 will be ***a*** ***Ext4***  *****file* system on a storage device with label "rootfs"

### First,

```bash
sudo mkfs.vfat -F 16 -n boot /dev/loop19p1
```

- **`mkfs.vfat`**: The command for creating a FAT file system.
- **`-F 16`**: Specifies the FAT type as FAT16.
- **`-n boot`**: Sets the volume label to "boot."
- **`/dev/loop19p1` :** The partition you want to format. Assuming that **`/dev/loop19`** is associated with your virtual SD card image and it has a second partition (**`p1`**).

### Second,

```bash
sudo mkfs.ext4 -L rootfs /dev/loop19p2
```

- **`mkfs.ext4`**: The command for creating an Ext4 file system.
- **`L rootfs`**: Sets the volume label to "rootfs."
- **`/dev/loop19p2`**: The partition you want to format. Assuming that **`/dev/loop19`** is associated with your virtual SD card image and it has a second partition (**`p2`**).

## 📌Step 5: Mount the two partitions of SD card

We need to attach file systems to the directory tree, so we can use the **`mount`** command that is essential for accessing the contents of storage devices or disk images.

```bash
sudo mount /dev/device_name /mount_point
```

- **`mount_point`** is the directory where we want to access the partitions of SD card

**In our case this command will be**

```bash
sudo mkdir bootfile
sudo mkdir rootfilesys
sudo mount /dev/loop19p1 bootfile
sudo mount /dev/loop19p2 rootfilesys
```

*Now, SD card is ready to use !* 🎃
