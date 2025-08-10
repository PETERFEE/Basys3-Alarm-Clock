# VHDL Digital Alarm Clock for the Digilent Basys3

This repository contains the complete Vivado project for a 24-hour digital alarm clock, designed in VHDL to run on a Digilent Basys3 Artix-7 FPGA board.

The project features a large 7-segment display, simple controls for setting the time and alarm, and a highly visible flashing LED alert system. This guide provides all the necessary steps to download, set up, and run the project on your own board.

![Basys3 Board](basys3_hardware_walkaround.png)

---
## How to Run This Project

This guide will walk you through setting up the project from scratch. It's designed for users who may not be familiar with Vivado or FPGAs.

### **1. Prerequisites**

#### Hardware
* **Digilent Basys3 Artix-7 FPGA Trainer Board:** This is the specific board the project was designed for.
* **Micro-USB Cable:** To connect the board to your computer for power and programming.

#### Software
* **Xilinx Vivado HLx Edition:** This is the main software used to synthesize the VHDL code and program the FPGA. The free "WebPACK" version is all you need.
    * **Download Link:** [**Vivado ML Edition - 2024.1 Full Product Installation**](https://www.xilinx.com/support/download.html) (You will need to create a free AMD/Xilinx account to download).
* **Git:** A version control system used to download (clone) the project files from GitHub.
    * **Download Link:** [**Git for Windows**](https://git-scm.com/downloads)

### **2. Download the Project Files**

You need to copy the project files from this GitHub repository to your computer.

1.  Open a terminal or **Git Bash**.
2.  Navigate to a directory where you want to store the project (e.g., `C:/Vivado_Projects`).
3.  Clone the repository using the following command:
    ```bash
    git clone [https://github.com/YourUsername/FPGA-Alarm-Clock.git](https://github.com/YourUsername/FPGA-Alarm-Clock.git)
    ```
    *(Make sure to replace `YourUsername/FPGA-Alarm-Clock.git` with the actual URL of this repository).*

### **3. Create and Configure the Vivado Project**

Since Vivado project files are user-specific, you will create a new project and import the source code.

1.  **Launch Vivado.**
2.  From the welcome screen, select **Create Project**.
3.  Click **Next**. In the "Project Name" window, give your project a name (e.g., `alarm_clock`) and choose the folder you just cloned as the "Project location". Click **Next**.
4.  For "Project Type," select **RTL Project** and check the box for **"Do not specify sources at this time"**. Click **Next**.
5.  In the "Default Part" window, select the **Boards** tab.
    * If you see **Basys3** in the list, select it.
    * If you don't see it, you need to install the Digilent board files. Follow this quick [**Digilent Board Files Tutorial**](https://digilent.com/reference/programmable-logic/guides/installing-vivado-and-vitis-and-digilent-board-files). Once installed, restart Vivado and the board will appear.
6.  Click **Next**, review the summary, and click **Finish**.

### **4. Add Source Files to the Project**

Now you'll add the VHDL code (`.vhd`) and the constraints file (`.xdc`) to your new project.

1.  **Add VHDL Source:**
    * In the "Sources" pane on the left, click the **plus icon (+)** or right-click and select **Add Sources**.
    * Select **"Add or create design sources"** and click **Next**.
    * Click **Add Files**. Navigate into the project folder you cloned and select `alarm_clock.vhd`.
    * Click **OK**, then click **Finish**.

2.  **Add Constraints File:**
    * Right-click on **Constraints** in the "Sources" pane and select **Add Sources**.
    * Select **"Add or create constraints"** and click **Next**.
    * Click **Add Files**. Select `alarm_clock.xdc` from the project folder.
    * Click **OK**, then click **Finish**.

### **5. Generate the Bitstream**

This is the compilation step that turns your human-readable code into a machine-readable `.bit` file for the FPGA.

1.  In the "Flow Navigator" on the far left, scroll down and click **Generate Bitstream**.
2.  Vivado will ask if it's okay to run Synthesis and Implementation first. Click **Yes**.
3.  This process can take several minutes. You can monitor the progress in the top-right corner of the Vivado window.
4.  When it's done, a dialog box will appear. You can click **Cancel** on this box.

### **6. Program the FPGA**

The final step is to load the generated file onto your Basys3 board.

1.  Connect your Basys3 board to your computer with the micro-USB cable and turn the power switch on.
2.  In the "Flow Navigator," at the bottom, click **Open Hardware Manager**.
3.  In the green banner that appears, click **Open Target** and select **Auto Connect**. Vivado will find and connect to your board.
4.  Once connected, click **Program Device**. A window will pop up. The correct `.bit` file should already be listed.
5.  Click **Program**.

After a few seconds, the FPGA will be programmed, and your alarm clock will appear on the 7-segment display!

---
## User Manual
![Basys3 Board picture](IMG_1570.png)
### Controls Layout
Your alarm clock is controlled by four main slide switches (S0-S3) and one push button (BTNC for Reset).

| Control | Board Label | Function                                     |
| :------ | :---------- | :------------------------------------------- |
| `sw0`   | S0          | Activates time-setting mode.                 |
| `sw1`   | S1          | Activates/views alarm-setting mode.          |
| `sw2`   | S2          | Increments the minutes.                      |
| `sw3`   | S3          | Increments the hours.                        |
| `rst`   | BTNC        | Resets the clock to its initial state (00:00). |

### Operating the Clock

#### Normal Time Display Mode
This is the default mode. The display shows the current time in 24-hour format (HH:MM). All switches (S0-S3) should be in the 'down' or 'off' position.

#### Setting the Current Time
1.  Slide **S0** to the 'up' position.
2.  Use **S3** to increment the **hours** (0-23).
3.  Use **S2** to increment the **minutes** (0-59).
4.  Slide **S0** back down to save and resume normal operation.

#### Setting the Alarm
1.  Slide **S1** to the 'up' position. The display will now show the current alarm time.
2.  Use **S3** to set the alarm **hours**.
3.  Use **S2** to set the alarm **minutes**.
4.  Slide **S1** back down. This saves the alarm time and activates it.

### The Alarm Function

* **Alarm Behavior:** When the current time matches the set alarm time, all 16 LEDs on the board will flash rapidly.
* **Alarm Duration:** The alarm will flash for exactly **30 seconds** and then turn off automatically.
* **Silencing the Alarm:** You can silence a flashing alarm at any time by moving **any of the four slide switches (S0-S3)**. This deactivates the alarm for the current day.

### Resetting the System
Press the **BTNC (Reset)** button at any time to reset the current time and alarm time to 00:00.
