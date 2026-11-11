Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368992;
	b=l709fztUj9AWB4sPYZkcaiSLzXVub1TpV6tN6ikkxwGNzgg3epIzq4t5QGnYpSN0E3LP
	 qIw3xgzhJ0J/3u3MbycBsm/0g4N5kuRJN2hNm/55wexsjZfCM/ODqwaq5uHlFTQI+BKE9
	 H/2kOvWrbZfDdWDK9uVaNvKKxnpnolJaSd94Fa1CPsN+nF6lZYXWaUJjs6VjsEV7drtKw
	 vhZt1qZk05e4g1BKrWqa80bUQBx5O5Yp8TZwbzFpOcdLbFif2z9iDuR0PAHSdfqmmYMxo
	 sDCr/cyRynIQTQWCdxaIW/2ojGOmSHgBlfO1NPTwO9KrdF2nNJVCfU/SNAM4hs3YMtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368992;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=r36nbPQGFmnDODbrj1aT9EZcNOQjsY712y3Jt391xmc=;
	b=bxYyNSqKp2R9eS44nlgBsG8V/LO/3X9bDKvthXelpBd2M40PFspsuFm5ND3KRrYnMNyN
	 0h+nDAMYBFd6fK3sl6xBh5xb+LgFJsIY3FCDdqElEe4wwixf/zpQ4oLuwzDUy67EReHhh
	 MgarlIkVuB80uhft5j0EMaT5ctZAOSoT3ZG3E7owSJAdqYhjtUllXl7NKldsTCyIa+k7v
	 7pzweD/Lgs4OuX/0MSJrCeHsYcrKJXS6308bWivBBkMfRD+4n7xfSERMry7vPPLvaSIcZ
	 3gKbsAqddRYZabU/+LLKXtUB+XNFYMU8sFgb3w94xxd3EGD99A5J6Rf9TTPe839YOqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K6CP5oIE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5762B606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K6CP5oIE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6CC1F0089F;
	Wed, 11 Nov 2026 03:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794368991;
	bh=r36nbPQGFmnDODbrj1aT9EZcNOQjsY712y3Jt391xmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K6CP5oIEh/bY1L0xSTYk9NZxz8yKXN7qFuXsChU5x95kt/h5WNVmrjK6kZ60g/ZFE
	 WSGcbV8NR/3/g8yLtAV2PlOv2SjDPDQHM+6ng81T1RMcqYjjs+/g5QaxwbhaK5T8Ao
	 kGHwPpm+uS5ymD4geDNidJm4ujS2xgP8nFOhx1Qx4dTWHK/AFpgWGu6tz1+AxUz/OA
	 TSb0ISmlL+nonhxXQ202jyfqRTsSFEdQwJ/0PTjkxVdQYK8+z8S9yF89thlcsRLcQ8
	 +yaG4I9TpUEr0IWGa74wk0e6YezsWiQDbKMXNiVB6t+yK//N10Ji6VIcb2762h0kDD
	 qi3GHY2HH10Ig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jorge Lopez <jorge.lopez2@hp.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] platform/x86: Move existing HP drivers to a new hp subdir
Date: Tue, 10 Nov 2026 22:49:47 -0500
Message-ID: <20261111034941.936350-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111034941.936350-1-sashal@kernel.org>
References: <20261107062147-failed-5.10-6dea092b261f@kernel.org>
 <20261111034941.936350-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jorge Lopez <jorge.lopez2@hp.com>

[ Upstream commit 6e9b8992b122cb12688bd259fc99e67d1be234eb ]

The purpose of this patch is to provide a central location where all
HP related drivers are found. HP drivers will recide under
drivers/platform/x86/hp directory.

Introduce changes to Kconfig file to list all HP driver under "HP X86
Platform Specific Device Drivers" menu option. Additional changes
include update MAINTAINERS file to indicate hp related drivers new
path.

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
Link: https://lore.kernel.org/r/20221020201033.12790-2-jorge.lopez2@hp.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>

HP related drivers are found. HP drivers will reside in the new
subdirectory.

Introduce changes to Kconfig file to list all HP driver under "HP X86
Platform Specific Device Drivers" menu option. Additional changes
include update MAINTAINERS file to indicate hp related drivers new
path.

Keep the existing HP WMI configuration requirements: platform profile
and hardware monitoring support are not present in this driver.

Include the missing-object cleanup branch and invalid-object diagnostic
from the later query implementation so the subsequent buffer bounds
check applies without pulling in the unrelated buffer allocation changes.

Stable-dep-of: 6dea092b261f ("platform/x86: hp-wmi: fix heap OOB read and memory corruption in hp_wmi_perform_query()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 MAINTAINERS                                |  4 +-
 drivers/platform/x86/Kconfig               | 41 +--------------
 drivers/platform/x86/Makefile              |  4 +-
 drivers/platform/x86/hp/Kconfig            | 61 ++++++++++++++++++++++
 drivers/platform/x86/hp/Makefile           | 10 ++++
 drivers/platform/x86/{ => hp}/hp-wmi.c     |  7 ++-
 drivers/platform/x86/{ => hp}/hp_accel.c   |  2 +-
 drivers/platform/x86/{ => hp}/tc1100-wmi.c |  0
 8 files changed, 81 insertions(+), 48 deletions(-)
 create mode 100644 drivers/platform/x86/hp/Kconfig
 create mode 100644 drivers/platform/x86/hp/Makefile
 rename drivers/platform/x86/{ => hp}/hp-wmi.c (99%)
 rename drivers/platform/x86/{ => hp}/hp_accel.c (99%)
 rename drivers/platform/x86/{ => hp}/tc1100-wmi.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index beaa5f6294bd2..81bab641d84f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8028,7 +8028,7 @@ F:	drivers/net/wireless/intersil/hostap/
 HP COMPAQ TC1100 TABLET WMI EXTRAS DRIVER
 L:	platform-driver-x86@vger.kernel.org
 S:	Orphan
-F:	drivers/platform/x86/tc1100-wmi.c
+F:	drivers/platform/x86/hp/tc1100-wmi.c
 
 HPET:	High Precision Event Timers driver
 M:	Clemens Ladisch <clemens@ladisch.de>
@@ -10159,7 +10159,7 @@ M:	Eric Piel <eric.piel@tremplin-utc.net>
 S:	Maintained
 F:	Documentation/misc-devices/lis3lv02d.rst
 F:	drivers/misc/lis3lv02d/
-F:	drivers/platform/x86/hp_accel.c
+F:	drivers/platform/x86/hp/hp_accel.c
 
 LIST KUNIT TEST
 M:	David Gow <davidgow@google.com>
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index b7bbe97b727eb..7555bb0eb6a0f 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -511,24 +511,7 @@ config GPD_POCKET_FAN
 	  of the CPU temperature. Say Y or M if the kernel may be used on a
 	  GPD pocket.
 
-config HP_ACCEL
-	tristate "HP laptop accelerometer"
-	depends on INPUT && ACPI
-	depends on SERIO_I8042
-	select SENSORS_LIS3LV02D
-	select NEW_LEDS
-	select LEDS_CLASS
-	help
-	  This driver provides support for the "Mobile Data Protection System 3D"
-	  or "3D DriveGuard" feature of HP laptops. On such systems the driver
-	  should load automatically (via ACPI alias).
-
-	  Support for a led indicating disk protection will be provided as
-	  hp::hddprotect. For more information on the feature, refer to
-	  Documentation/misc-devices/lis3lv02d.rst.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called hp_accel.
+source "drivers/platform/x86/hp/Kconfig"
 
 config WIRELESS_HOTKEY
 	tristate "Wireless hotkey button"
@@ -542,28 +525,6 @@ config WIRELESS_HOTKEY
 	 To compile this driver as a module, choose M here: the module will
 	 be called wireless-hotkey.
 
-config HP_WMI
-	tristate "HP WMI extras"
-	depends on ACPI_WMI
-	depends on INPUT
-	depends on RFKILL || RFKILL = n
-	select INPUT_SPARSEKMAP
-	help
-	 Say Y here if you want to support WMI-based hotkeys on HP laptops and
-	 to read data from WMI such as docking or ambient light sensor state.
-
-	 To compile this driver as a module, choose M here: the module will
-	 be called hp-wmi.
-
-config TC1100_WMI
-	tristate "HP Compaq TC1100 Tablet WMI Extras"
-	depends on !X86_64
-	depends on ACPI
-	depends on ACPI_WMI
-	help
-	  This is a driver for the WMI extensions (wireless and bluetooth power
-	  control) of the HP Compaq TC1100 tablet.
-
 config IBM_RTL
 	tristate "Device driver to enable PRTL support"
 	depends on PCI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 5779c9a061384..4aa356a431668 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -57,9 +57,7 @@ obj-$(CONFIG_FUJITSU_TABLET)	+= fujitsu-tablet.o
 obj-$(CONFIG_GPD_POCKET_FAN)	+= gpd-pocket-fan.o
 
 # Hewlett Packard
-obj-$(CONFIG_HP_ACCEL)		+= hp_accel.o
-obj-$(CONFIG_HP_WMI)		+= hp-wmi.o
-obj-$(CONFIG_TC1100_WMI)	+= tc1100-wmi.o
+obj-$(CONFIG_X86_PLATFORM_DRIVERS_HP)	+= hp/
 
 # IBM Thinkpad and Lenovo
 obj-$(CONFIG_IBM_RTL)		+= ibm_rtl.o
diff --git a/drivers/platform/x86/hp/Kconfig b/drivers/platform/x86/hp/Kconfig
new file mode 100644
index 0000000000000..5f0f55dbf34bd
--- /dev/null
+++ b/drivers/platform/x86/hp/Kconfig
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# X86 Platform Specific Drivers
+#
+menuconfig X86_PLATFORM_DRIVERS_HP
+	bool "HP X86 Platform Specific Device Drivers"
+	depends on X86_PLATFORM_DEVICES
+	help
+	  Say Y here to get to see options for device drivers for various
+	  HP x86 platforms, including vendor-specific laptop extension drivers.
+	  This option alone does not add any kernel code.
+
+	  If you say N, all options in this submenu will be skipped and disabled.
+
+if X86_PLATFORM_DRIVERS_HP
+
+config HP_ACCEL
+	tristate "HP laptop accelerometer"
+	default m
+	depends on INPUT && ACPI
+	depends on SERIO_I8042
+	select SENSORS_LIS3LV02D
+	select NEW_LEDS
+	select LEDS_CLASS
+	help
+	  This driver provides support for the "Mobile Data Protection System 3D"
+	  or "3D DriveGuard" feature of HP laptops. On such systems the driver
+	  should load automatically (via ACPI alias).
+
+	  Support for a led indicating disk protection will be provided as
+	  hp::hddprotect. For more information on the feature, refer to
+	  Documentation/misc-devices/lis3lv02d.rst.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called hp_accel.
+
+config HP_WMI
+	tristate "HP WMI extras"
+	default m
+	depends on ACPI_WMI
+	depends on INPUT
+	depends on RFKILL || RFKILL = n
+	select INPUT_SPARSEKMAP
+	help
+	  Say Y here if you want to support WMI-based hotkeys on HP laptops and
+	  to read data from WMI such as docking or ambient light sensor state.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called hp-wmi.
+
+config TC1100_WMI
+	tristate "HP Compaq TC1100 Tablet WMI Extras"
+	default m
+	depends on !X86_64
+	depends on ACPI
+	depends on ACPI_WMI
+	help
+	  This is a driver for the WMI extensions (wireless and bluetooth power
+	  control) of the HP Compaq TC1100 tablet.
+
+endif # X86_PLATFORM_DRIVERS_HP
diff --git a/drivers/platform/x86/hp/Makefile b/drivers/platform/x86/hp/Makefile
new file mode 100644
index 0000000000000..db1eed4cd7c7d
--- /dev/null
+++ b/drivers/platform/x86/hp/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for linux/drivers/platform/x86/hp
+# HP x86 Platform-Specific Drivers
+#
+
+# Hewlett Packard
+obj-$(CONFIG_HP_ACCEL)		+= hp_accel.o
+obj-$(CONFIG_HP_WMI)		+= hp-wmi.o
+obj-$(CONFIG_TC1100_WMI)	+= tc1100-wmi.o
diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
similarity index 99%
rename from drivers/platform/x86/hp-wmi.c
rename to drivers/platform/x86/hp/hp-wmi.c
index 370f74fa4a9ab..140a5f797980d 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -241,10 +241,13 @@ static int hp_wmi_perform_query(int query, enum hp_wmi_command command,
 
 	obj = output.pointer;
 
-	if (!obj)
-		return -EINVAL;
+	if (!obj) {
+		ret = -EINVAL;
+		goto out_free;
+	}
 
 	if (obj->type != ACPI_TYPE_BUFFER) {
+		pr_warn("query 0x%x returned an invalid object 0x%x\n", query, ret);
 		ret = -EINVAL;
 		goto out_free;
 	}
diff --git a/drivers/platform/x86/hp_accel.c b/drivers/platform/x86/hp/hp_accel.c
similarity index 99%
rename from drivers/platform/x86/hp_accel.c
rename to drivers/platform/x86/hp/hp_accel.c
index 0dfaa1a43b674..823ea56bf778c 100644
--- a/drivers/platform/x86/hp_accel.c
+++ b/drivers/platform/x86/hp/hp_accel.c
@@ -26,7 +26,7 @@
 #include <linux/acpi.h>
 #include <linux/i8042.h>
 #include <linux/serio.h>
-#include "../../misc/lis3lv02d/lis3lv02d.h"
+#include "../../../misc/lis3lv02d/lis3lv02d.h"
 
 #define DRIVER_NAME     "hp_accel"
 #define ACPI_MDPS_CLASS "accelerometer"
diff --git a/drivers/platform/x86/tc1100-wmi.c b/drivers/platform/x86/hp/tc1100-wmi.c
similarity index 100%
rename from drivers/platform/x86/tc1100-wmi.c
rename to drivers/platform/x86/hp/tc1100-wmi.c
-- 
2.53.0

