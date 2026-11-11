Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368991;
	b=cOQ9nfxjR/CV6i5UIuT0PApx4VSKY4kEEgdKMMqRRXGb9qsn8QyOvjBSdHxCm5w4PrMv
	 QYCrNp7En4cFNQzXAjgvrVhoOOEr/FlGTCLDgKLzziQoSy8IihtnEia9O/nlb2jQL6On/
	 RHABxHAYSSXbpJa3zYjdPi2a09ZjVviIwGRT5tlH7ptu8yXPK9aKofIoZXm5zQ+5z579v
	 hNY5sN+sD53oGFqWHATXmCoMJm/QHta9+WZP6Qt2t5JsCvIJ73sbUmPjhP0xkCUUWilTq
	 hxOL5bcQEwyY73wmUUl+3pm/Zu8YyZWBX0cB24rEWk34ddwbZb4cl7ZpoFxfTfTmEOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368991;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=96CSzYr0+yMFnouvhm8GoGoxlg48+AnQOSCReiNfWzc=;
	b=LV+lB+892ffAHwJR+bQ6iSE+guibzSb8bUMk3kMcyTB/JMZM7Mj87vemi89LHhNX4yrw
	 aaSVeoFCRE9DWTl2jt3smczq8yWshx0lMi79R2J4YQHIUphxJjRibH0kyys0QyYu+ped0
	 rbISU5smtfVMW9bxyesvQqdAXE2Ox06KUEyF9h/mNvqvGs4jK7QdMdz3fciSbfpRu0O9p
	 U3V0xVeWczvv7MaGPZxIpME8UBrDf1n22uM2Ctz5OgCcD7q2HEPYx3g/M5OmvV+V28rus
	 MPAXM9sYTtRjg6359gcU23o1VkOPsknD2AYjOUoR6VBbbD2w9CpaW+EllCv52ng+g8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TlUEZBxi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E83606A327
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TlUEZBxi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AECF1F00A03;
	Wed, 11 Nov 2026 03:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794368991;
	bh=96CSzYr0+yMFnouvhm8GoGoxlg48+AnQOSCReiNfWzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TlUEZBxiM9JPwnIakKz8CPaS2PboCTLVNu8u3QLjuCcJrW1yfRuMqAhRRc6qagHfs
	 NBzcDP/a2waq2GHPuKZjO5/fBiy6jRoGBYkz+YtdC8Sonm9o1D0gq2gOLv0hOmh0v8
	 qMS9V2Zf5rgI2RC+2CMpoFQxj6r6XWHJ+w3+pW6p+oQ+5ghOOX1FXl9hx9fYcQtkjt
	 pChM08bZzzLYlNbGu/9/d5+j+ZOUFr7KZVoO6ZpA4KyxiedsmpzrZ1iurF8xFMOrRk
	 yr0cm2H6lnz/T7rBdqYr+4rbjl/x44IJ0DgKFS0ZQWJIKfckAdFbhnQF2UumEbZ3Mb
	 20MiBf6+GHcxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/4] platform/x86: Rename hp-wireless to wireless-hotkey
Date: Tue, 10 Nov 2026 22:49:46 -0500
Message-ID: <20261111034941.936350-2-sashal@kernel.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit a558ea42c0decd088df1950bb232ac2257929281 ]

This driver was originally intended to support some HP laptops, but
later support was added for Xioami and AMD laptops.

Rename it to make it clear that it supports a larger variety of
systems.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20210519174405.30155-1-mario.limonciello@amd.com
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Stable-dep-of: 6dea092b261f ("platform/x86: hp-wmi: fix heap OOB read and memory corruption in hp_wmi_perform_query()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/Kconfig           |   9 ++-
 drivers/platform/x86/Makefile          |   2 +-
 drivers/platform/x86/hp-wireless.c     | 102 ------------------------
 drivers/platform/x86/wireless-hotkey.c | 103 +++++++++++++++++++++++++
 4 files changed, 109 insertions(+), 107 deletions(-)
 delete mode 100644 drivers/platform/x86/hp-wireless.c
 create mode 100644 drivers/platform/x86/wireless-hotkey.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index c14c145b88d80..b7bbe97b727eb 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -530,16 +530,17 @@ config HP_ACCEL
 	  To compile this driver as a module, choose M here: the module will
 	  be called hp_accel.
 
-config HP_WIRELESS
-	tristate "HP wireless button"
+config WIRELESS_HOTKEY
+	tristate "Wireless hotkey button"
 	depends on ACPI
 	depends on INPUT
 	help
-	 This driver provides supports for new HP wireless button for Windows 8.
+	 This driver provides supports for the wireless buttons found on some AMD,
+	 HP, & Xioami laptops.
 	 On such systems the driver should load automatically (via ACPI alias).
 
 	 To compile this driver as a module, choose M here: the module will
-	 be called hp-wireless.
+	 be called wireless-hotkey.
 
 config HP_WMI
 	tristate "HP WMI extras"
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 5f823f7eff452..5779c9a061384 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -58,7 +58,6 @@ obj-$(CONFIG_GPD_POCKET_FAN)	+= gpd-pocket-fan.o
 
 # Hewlett Packard
 obj-$(CONFIG_HP_ACCEL)		+= hp_accel.o
-obj-$(CONFIG_HP_WIRELESS)	+= hp-wireless.o
 obj-$(CONFIG_HP_WMI)		+= hp-wmi.o
 obj-$(CONFIG_TC1100_WMI)	+= tc1100-wmi.o
 
@@ -124,6 +123,7 @@ obj-$(CONFIG_TOPSTAR_LAPTOP)	+= topstar-laptop.o
 obj-$(CONFIG_I2C_MULTI_INSTANTIATE)	+= i2c-multi-instantiate.o
 obj-$(CONFIG_MLX_PLATFORM)		+= mlx-platform.o
 obj-$(CONFIG_TOUCHSCREEN_DMI)		+= touchscreen_dmi.o
+obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
 
 # Intel uncore drivers
 obj-$(CONFIG_INTEL_IPS)				+= intel_ips.o
diff --git a/drivers/platform/x86/hp-wireless.c b/drivers/platform/x86/hp-wireless.c
deleted file mode 100644
index 0753ef18e7211..0000000000000
--- a/drivers/platform/x86/hp-wireless.c
+++ /dev/null
@@ -1,102 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  Airplane mode button for HP & Xiaomi laptops
- *
- *  Copyright (C) 2014-2017 Alex Hung <alex.hung@canonical.com>
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/input.h>
-#include <linux/platform_device.h>
-#include <linux/acpi.h>
-#include <acpi/acpi_bus.h>
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Alex Hung");
-MODULE_ALIAS("acpi*:HPQ6001:*");
-MODULE_ALIAS("acpi*:WSTADEF:*");
-MODULE_ALIAS("acpi*:AMDI0051:*");
-
-static struct input_dev *hpwl_input_dev;
-
-static const struct acpi_device_id hpwl_ids[] = {
-	{"HPQ6001", 0},
-	{"WSTADEF", 0},
-	{"AMDI0051", 0},
-	{"", 0},
-};
-
-static int hp_wireless_input_setup(void)
-{
-	int err;
-
-	hpwl_input_dev = input_allocate_device();
-	if (!hpwl_input_dev)
-		return -ENOMEM;
-
-	hpwl_input_dev->name = "HP Wireless hotkeys";
-	hpwl_input_dev->phys = "hpq6001/input0";
-	hpwl_input_dev->id.bustype = BUS_HOST;
-	hpwl_input_dev->evbit[0] = BIT(EV_KEY);
-	set_bit(KEY_RFKILL, hpwl_input_dev->keybit);
-
-	err = input_register_device(hpwl_input_dev);
-	if (err)
-		goto err_free_dev;
-
-	return 0;
-
-err_free_dev:
-	input_free_device(hpwl_input_dev);
-	return err;
-}
-
-static void hp_wireless_input_destroy(void)
-{
-	input_unregister_device(hpwl_input_dev);
-}
-
-static void hpwl_notify(struct acpi_device *acpi_dev, u32 event)
-{
-	if (event != 0x80) {
-		pr_info("Received unknown event (0x%x)\n", event);
-		return;
-	}
-
-	input_report_key(hpwl_input_dev, KEY_RFKILL, 1);
-	input_sync(hpwl_input_dev);
-	input_report_key(hpwl_input_dev, KEY_RFKILL, 0);
-	input_sync(hpwl_input_dev);
-}
-
-static int hpwl_add(struct acpi_device *device)
-{
-	int err;
-
-	err = hp_wireless_input_setup();
-	if (err)
-		pr_err("Failed to setup hp wireless hotkeys\n");
-
-	return err;
-}
-
-static int hpwl_remove(struct acpi_device *device)
-{
-	hp_wireless_input_destroy();
-	return 0;
-}
-
-static struct acpi_driver hpwl_driver = {
-	.name	= "hp-wireless",
-	.owner	= THIS_MODULE,
-	.ids	= hpwl_ids,
-	.ops	= {
-		.add	= hpwl_add,
-		.remove	= hpwl_remove,
-		.notify	= hpwl_notify,
-	},
-};
-
-module_acpi_driver(hpwl_driver);
diff --git a/drivers/platform/x86/wireless-hotkey.c b/drivers/platform/x86/wireless-hotkey.c
new file mode 100644
index 0000000000000..b010e4ca33831
--- /dev/null
+++ b/drivers/platform/x86/wireless-hotkey.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Airplane mode button for AMD, HP & Xiaomi laptops
+ *
+ *  Copyright (C) 2014-2017 Alex Hung <alex.hung@canonical.com>
+ *  Copyright (C) 2021 Advanced Micro Devices
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/platform_device.h>
+#include <linux/acpi.h>
+#include <acpi/acpi_bus.h>
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Alex Hung");
+MODULE_ALIAS("acpi*:HPQ6001:*");
+MODULE_ALIAS("acpi*:WSTADEF:*");
+MODULE_ALIAS("acpi*:AMDI0051:*");
+
+static struct input_dev *wl_input_dev;
+
+static const struct acpi_device_id wl_ids[] = {
+	{"HPQ6001", 0},
+	{"WSTADEF", 0},
+	{"AMDI0051", 0},
+	{"", 0},
+};
+
+static int wireless_input_setup(void)
+{
+	int err;
+
+	wl_input_dev = input_allocate_device();
+	if (!wl_input_dev)
+		return -ENOMEM;
+
+	wl_input_dev->name = "Wireless hotkeys";
+	wl_input_dev->phys = "hpq6001/input0";
+	wl_input_dev->id.bustype = BUS_HOST;
+	wl_input_dev->evbit[0] = BIT(EV_KEY);
+	set_bit(KEY_RFKILL, wl_input_dev->keybit);
+
+	err = input_register_device(wl_input_dev);
+	if (err)
+		goto err_free_dev;
+
+	return 0;
+
+err_free_dev:
+	input_free_device(wl_input_dev);
+	return err;
+}
+
+static void wireless_input_destroy(void)
+{
+	input_unregister_device(wl_input_dev);
+}
+
+static void wl_notify(struct acpi_device *acpi_dev, u32 event)
+{
+	if (event != 0x80) {
+		pr_info("Received unknown event (0x%x)\n", event);
+		return;
+	}
+
+	input_report_key(wl_input_dev, KEY_RFKILL, 1);
+	input_sync(wl_input_dev);
+	input_report_key(wl_input_dev, KEY_RFKILL, 0);
+	input_sync(wl_input_dev);
+}
+
+static int wl_add(struct acpi_device *device)
+{
+	int err;
+
+	err = wireless_input_setup();
+	if (err)
+		pr_err("Failed to setup hp wireless hotkeys\n");
+
+	return err;
+}
+
+static int wl_remove(struct acpi_device *device)
+{
+	wireless_input_destroy();
+	return 0;
+}
+
+static struct acpi_driver wl_driver = {
+	.name	= "wireless-hotkey",
+	.owner	= THIS_MODULE,
+	.ids	= wl_ids,
+	.ops	= {
+		.add	= wl_add,
+		.remove	= wl_remove,
+		.notify	= wl_notify,
+	},
+};
+
+module_acpi_driver(wl_driver);
-- 
2.53.0

