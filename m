Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368877;
	b=Rnopdn7RPROPa7w+qUp4iThmX8R86VDd1FQaquCavkPKhWJbWjVRpjzR102uSbBOj3kI
	 yxzz7y9IO58+qdq+sK416qEnsB+25ysTmqCVhXs88c8cOKyyIPDoAZ/pzQxH50NZ6lZq8
	 IFS7Z3T6ygo6Ea/3nZRa4tsRSPkYgqZPUFaXIu/b3YRYWHrHdNOSAdkmOpZXCYiFyUx54
	 j1yKhuG373QSRNb96YkTqX+39uTRIA76Y/evbo5hqeQaiFhPr3W/t53UR3HE3OMjXvbAC
	 xkjLSWbm11AVbJLEU+GqCM4bvpAZ1MMZNq2dlgHDwdpixcwa0IUQvSo/HZGnvJAElnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368877;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UaW9heRhIXfvFu+qMOlkLpF5r6AsXKyNZZ6y1RPDHRk=;
	b=OiKNg0nHLI+jHVA9QfY6ZO1OI9FjwTPX0LJC6+A561Kvc9TOWfRW2xKtzSTI+NbsmUih
	 r9d7PuQKKMOuz9pLuyLxB3dBL8pWiWGChIufPEcNKaIwHGnFldP5SUK99MQ1z+tDmx/V7
	 sQbdayJzETaXqG18JNS47HFJUc0R7OZLmIBW61Igu8R/euvxTBd73RCBa8HDcjMbsptr4
	 LZhEjPUGJ++SmPZys81tohyVyXMbwEILjuh9Vp7ZJioPZtNEZCr4deuSp6DTF8nweyk2/
	 /OPaqKdqKVtId4BGMCct8QmtJ1XTxG4sTysqmm8Je7dfIBv2g6Yap2MalP8dSrwG9Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hcFVS5Pr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D8A606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hcFVS5Pr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D04D1F0089F;
	Wed, 11 Nov 2026 03:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794368877;
	bh=UaW9heRhIXfvFu+qMOlkLpF5r6AsXKyNZZ6y1RPDHRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hcFVS5Pr63MGvlXkz/o9VD1wxnjMGZFpH/6odR3PyNyvw1sTNRxy6jEIxIe4q6LbC
	 KeysBxKEKGUI8eONy3XOQUWSNz31DMTQ9VKUzmNq30K4VZpFUo00uHRkpm04CGSmO9
	 570HITXAaYgciQu15NfnSa56CzwVI/U7WQ8VtwwcXDCkEMnP/pB2e8sT37oevZTjEA
	 1kwJVTCUvvY7DwosHz5XvVHTCB8J0y3Qd7WDp5PvhU97h4y0Pk01m+lLA1i6xRaBPd
	 FWOHAf/Gl6OxaDyz7L6HKqOLw088wsfiZXgKrscRsdRHL/gV+zBgzxk8yG1JrJVx9f
	 VVfMaJeSfw+OQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Henning Schild <henning.schild@siemens.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] leds: simatic-ipc-leds-gpio: Split up into multiple drivers
Date: Tue, 10 Nov 2026 22:47:52 -0500
Message-ID: <20261111034412.921658-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111034412.921658-1-sashal@kernel.org>
References: <20261107054744-failed-6.1-9523698252fd@kernel.org>
 <20261111034412.921658-1-sashal@kernel.org>
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

From: Henning Schild <henning.schild@siemens.com>

[ Upstream commit 2f5d6fe37b97cabf5cb5fc2be9630e37e2820e94 ]

In order to clearly describe the dependencies between the GPIO
controller drivers and the users the driver is split up into a core,
two drivers and a common header.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Lee Jones <lee@kernel.org>
Link: https://lore.kernel.org/r/20230524124628.32295-4-henning.schild@siemens.com
Stable-dep-of: 9523698252fd ("platform/x86: simatic-ipc: fix platform device leak on registration failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/simple/Makefile                  |   4 +-
 .../simple/simatic-ipc-leds-gpio-apollolake.c |  66 +++++++
 .../leds/simple/simatic-ipc-leds-gpio-core.c  | 104 +++++++++++
 .../simple/simatic-ipc-leds-gpio-f7188x.c     |  66 +++++++
 drivers/leds/simple/simatic-ipc-leds-gpio.c   | 163 ------------------
 drivers/leds/simple/simatic-ipc-leds-gpio.h   |  22 +++
 drivers/leds/simple/simatic-ipc-leds.c        |   1 -
 drivers/platform/x86/simatic-ipc.c            |   7 +-
 8 files changed, 265 insertions(+), 168 deletions(-)
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-apollolake.c
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-core.c
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
 delete mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.c
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.h

diff --git a/drivers/leds/simple/Makefile b/drivers/leds/simple/Makefile
index 1c7ef5e1324ba..ed9057f7b6da5 100644
--- a/drivers/leds/simple/Makefile
+++ b/drivers/leds/simple/Makefile
@@ -1,3 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds.o
-obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds-gpio.o
+obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)  += simatic-ipc-leds-gpio-core.o
+obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds-gpio-apollolake.o
+obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds-gpio-f7188x.o
diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio-apollolake.c b/drivers/leds/simple/simatic-ipc-leds-gpio-apollolake.c
new file mode 100644
index 0000000000000..e1c712729dcf7
--- /dev/null
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio-apollolake.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Siemens SIMATIC IPC driver for GPIO based LEDs
+ *
+ * Copyright (c) Siemens AG, 2023
+ *
+ * Author:
+ *  Henning Schild <henning.schild@siemens.com>
+ */
+
+#include <linux/gpio/machine.h>
+#include <linux/gpio/consumer.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/x86/simatic-ipc-base.h>
+
+#include "simatic-ipc-leds-gpio.h"
+
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table = {
+	.dev_id = "leds-gpio",
+	.table = {
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 52, NULL, 0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 53, NULL, 1, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 57, NULL, 2, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 58, NULL, 3, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 60, NULL, 4, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 5, GPIO_ACTIVE_LOW),
+		{} /* Terminating entry */
+	},
+};
+
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table_extra = {
+	.dev_id = NULL, /* Filled during initialization */
+	.table = {
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 56, NULL, 6, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 59, NULL, 7, GPIO_ACTIVE_HIGH),
+		{} /* Terminating entry */
+	},
+};
+
+static int simatic_ipc_leds_gpio_apollolake_probe(struct platform_device *pdev)
+{
+	return simatic_ipc_leds_gpio_probe(pdev, &simatic_ipc_led_gpio_table,
+					   &simatic_ipc_led_gpio_table_extra);
+}
+
+static int simatic_ipc_leds_gpio_apollolake_remove(struct platform_device *pdev)
+{
+	return simatic_ipc_leds_gpio_remove(pdev, &simatic_ipc_led_gpio_table,
+					    &simatic_ipc_led_gpio_table_extra);
+}
+
+static struct platform_driver simatic_ipc_led_gpio_apollolake_driver = {
+	.probe = simatic_ipc_leds_gpio_apollolake_probe,
+	.remove = simatic_ipc_leds_gpio_apollolake_remove,
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+};
+module_platform_driver(simatic_ipc_led_gpio_apollolake_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" KBUILD_MODNAME);
+MODULE_SOFTDEP("pre: simatic-ipc-leds-gpio-core platform:apollolake-pinctrl");
+MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio-core.c b/drivers/leds/simple/simatic-ipc-leds-gpio-core.c
new file mode 100644
index 0000000000000..2a21b663df874
--- /dev/null
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio-core.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Siemens SIMATIC IPC driver for GPIO based LEDs
+ *
+ * Copyright (c) Siemens AG, 2023
+ *
+ * Author:
+ *  Henning Schild <henning.schild@siemens.com>
+ */
+
+#include <linux/gpio/machine.h>
+#include <linux/gpio/consumer.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/x86/simatic-ipc-base.h>
+
+#include "simatic-ipc-leds-gpio.h"
+
+static struct platform_device *simatic_leds_pdev;
+
+static const struct gpio_led simatic_ipc_gpio_leds[] = {
+	{ .name = "red:" LED_FUNCTION_STATUS "-1" },
+	{ .name = "green:" LED_FUNCTION_STATUS "-1" },
+	{ .name = "red:" LED_FUNCTION_STATUS "-2" },
+	{ .name = "green:" LED_FUNCTION_STATUS "-2" },
+	{ .name = "red:" LED_FUNCTION_STATUS "-3" },
+	{ .name = "green:" LED_FUNCTION_STATUS "-3" },
+};
+
+static const struct gpio_led_platform_data simatic_ipc_gpio_leds_pdata = {
+	.num_leds	= ARRAY_SIZE(simatic_ipc_gpio_leds),
+	.leds		= simatic_ipc_gpio_leds,
+};
+
+int simatic_ipc_leds_gpio_remove(struct platform_device *pdev,
+				 struct gpiod_lookup_table *table,
+				 struct gpiod_lookup_table *table_extra)
+{
+	gpiod_remove_lookup_table(table);
+	gpiod_remove_lookup_table(table_extra);
+	platform_device_unregister(simatic_leds_pdev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(simatic_ipc_leds_gpio_remove);
+
+int simatic_ipc_leds_gpio_probe(struct platform_device *pdev,
+				struct gpiod_lookup_table *table,
+				struct gpiod_lookup_table *table_extra)
+{
+	const struct simatic_ipc_platform *plat = pdev->dev.platform_data;
+	struct device *dev = &pdev->dev;
+	struct gpio_desc *gpiod;
+	int err;
+
+	switch (plat->devmode) {
+	case SIMATIC_IPC_DEVICE_127E:
+	case SIMATIC_IPC_DEVICE_227G:
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	gpiod_add_lookup_table(table);
+	simatic_leds_pdev = platform_device_register_resndata(NULL,
+		"leds-gpio", PLATFORM_DEVID_NONE, NULL, 0,
+		&simatic_ipc_gpio_leds_pdata,
+		sizeof(simatic_ipc_gpio_leds_pdata));
+	if (IS_ERR(simatic_leds_pdev)) {
+		err = PTR_ERR(simatic_leds_pdev);
+		goto out;
+	}
+
+	table_extra->dev_id = dev_name(dev);
+	gpiod_add_lookup_table(table_extra);
+
+	/* PM_BIOS_BOOT_N */
+	gpiod = gpiod_get_index(dev, NULL, 6, GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod)) {
+		err = PTR_ERR(gpiod);
+		goto out;
+	}
+	gpiod_put(gpiod);
+
+	/* PM_WDT_OUT */
+	gpiod = gpiod_get_index(dev, NULL, 7, GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod)) {
+		err = PTR_ERR(gpiod);
+		goto out;
+	}
+	gpiod_put(gpiod);
+
+	return 0;
+out:
+	simatic_ipc_leds_gpio_remove(pdev, table, table_extra);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(simatic_ipc_leds_gpio_probe);
+
+MODULE_LICENSE("GPL v2");
+MODULE_SOFTDEP("pre: platform:leds-gpio");
+MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c b/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
new file mode 100644
index 0000000000000..583a6b6c7c222
--- /dev/null
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Siemens SIMATIC IPC driver for GPIO based LEDs
+ *
+ * Copyright (c) Siemens AG, 2023
+ *
+ * Author:
+ *  Henning Schild <henning.schild@siemens.com>
+ */
+
+#include <linux/gpio/machine.h>
+#include <linux/gpio/consumer.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/x86/simatic-ipc-base.h>
+
+#include "simatic-ipc-leds-gpio.h"
+
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table = {
+	.dev_id = "leds-gpio",
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-f7188x-2", 0, NULL, 0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-f7188x-2", 1, NULL, 1, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-f7188x-2", 2, NULL, 2, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-f7188x-2", 3, NULL, 3, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-f7188x-2", 4, NULL, 4, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-f7188x-2", 5, NULL, 5, GPIO_ACTIVE_LOW),
+		{} /* Terminating entry */
+	},
+};
+
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table_extra = {
+	.dev_id = NULL, /* Filled during initialization */
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-f7188x-3", 6, NULL, 6, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("gpio-f7188x-3", 7, NULL, 7, GPIO_ACTIVE_HIGH),
+		{} /* Terminating entry */
+	},
+};
+
+static int simatic_ipc_leds_gpio_f7188x_probe(struct platform_device *pdev)
+{
+	return simatic_ipc_leds_gpio_probe(pdev, &simatic_ipc_led_gpio_table,
+					   &simatic_ipc_led_gpio_table_extra);
+}
+
+static int simatic_ipc_leds_gpio_f7188x_remove(struct platform_device *pdev)
+{
+	return simatic_ipc_leds_gpio_remove(pdev, &simatic_ipc_led_gpio_table,
+					    &simatic_ipc_led_gpio_table_extra);
+}
+
+static struct platform_driver simatic_ipc_led_gpio_driver = {
+	.probe = simatic_ipc_leds_gpio_f7188x_probe,
+	.remove = simatic_ipc_leds_gpio_f7188x_remove,
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+};
+module_platform_driver(simatic_ipc_led_gpio_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" KBUILD_MODNAME);
+MODULE_SOFTDEP("pre: simatic-ipc-leds-gpio-core gpio_f7188x");
+MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c b/drivers/leds/simple/simatic-ipc-leds-gpio.c
deleted file mode 100644
index 0f1fde44e8d99..0000000000000
--- a/drivers/leds/simple/simatic-ipc-leds-gpio.c
+++ /dev/null
@@ -1,163 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Siemens SIMATIC IPC driver for GPIO based LEDs
- *
- * Copyright (c) Siemens AG, 2022
- *
- * Authors:
- *  Henning Schild <henning.schild@siemens.com>
- */
-
-#include <linux/gpio/machine.h>
-#include <linux/gpio/consumer.h>
-#include <linux/leds.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/platform_data/x86/simatic-ipc-base.h>
-
-static struct gpiod_lookup_table *simatic_ipc_led_gpio_table;
-static struct gpiod_lookup_table *simatic_ipc_led_gpio_table_extra;
-
-static struct gpiod_lookup_table simatic_ipc_led_gpio_table_127e = {
-	.dev_id = "leds-gpio",
-	.table = {
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 52, NULL, 0, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 53, NULL, 1, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 57, NULL, 2, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 58, NULL, 3, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 60, NULL, 4, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 5, GPIO_ACTIVE_LOW),
-		{} /* Terminating entry */
-	},
-};
-
-static struct gpiod_lookup_table simatic_ipc_led_gpio_table_127e_extra = {
-	.dev_id = NULL, /* Filled during initialization */
-	.table = {
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 56, NULL, 6, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 59, NULL, 7, GPIO_ACTIVE_HIGH),
-		{} /* Terminating entry */
-	},
-};
-
-static struct gpiod_lookup_table simatic_ipc_led_gpio_table_227g = {
-	.dev_id = "leds-gpio",
-	.table = {
-		GPIO_LOOKUP_IDX("gpio-f7188x-2", 0, NULL, 0, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("gpio-f7188x-2", 1, NULL, 1, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("gpio-f7188x-2", 2, NULL, 2, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("gpio-f7188x-2", 3, NULL, 3, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("gpio-f7188x-2", 4, NULL, 4, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("gpio-f7188x-2", 5, NULL, 5, GPIO_ACTIVE_LOW),
-		{} /* Terminating entry */
-	},
-};
-
-static struct gpiod_lookup_table simatic_ipc_led_gpio_table_227g_extra = {
-	.dev_id = NULL, /* Filled during initialization */
-	.table = {
-		GPIO_LOOKUP_IDX("gpio-f7188x-3", 6, NULL, 6, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("gpio-f7188x-3", 7, NULL, 7, GPIO_ACTIVE_HIGH),
-		{} /* Terminating entry */
-	},
-};
-
-static const struct gpio_led simatic_ipc_gpio_leds[] = {
-	{ .name = "red:" LED_FUNCTION_STATUS "-1" },
-	{ .name = "green:" LED_FUNCTION_STATUS "-1" },
-	{ .name = "red:" LED_FUNCTION_STATUS "-2" },
-	{ .name = "green:" LED_FUNCTION_STATUS "-2" },
-	{ .name = "red:" LED_FUNCTION_STATUS "-3" },
-	{ .name = "green:" LED_FUNCTION_STATUS "-3" },
-};
-
-static const struct gpio_led_platform_data simatic_ipc_gpio_leds_pdata = {
-	.num_leds	= ARRAY_SIZE(simatic_ipc_gpio_leds),
-	.leds		= simatic_ipc_gpio_leds,
-};
-
-static struct platform_device *simatic_leds_pdev;
-
-static int simatic_ipc_leds_gpio_remove(struct platform_device *pdev)
-{
-	gpiod_remove_lookup_table(simatic_ipc_led_gpio_table);
-	gpiod_remove_lookup_table(simatic_ipc_led_gpio_table_extra);
-	platform_device_unregister(simatic_leds_pdev);
-
-	return 0;
-}
-
-static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
-{
-	const struct simatic_ipc_platform *plat = pdev->dev.platform_data;
-	struct device *dev = &pdev->dev;
-	struct gpio_desc *gpiod;
-	int err;
-
-	switch (plat->devmode) {
-	case SIMATIC_IPC_DEVICE_127E:
-		if (!IS_ENABLED(CONFIG_PINCTRL_BROXTON))
-			return -ENODEV;
-		simatic_ipc_led_gpio_table = &simatic_ipc_led_gpio_table_127e;
-		simatic_ipc_led_gpio_table_extra = &simatic_ipc_led_gpio_table_127e_extra;
-		break;
-	case SIMATIC_IPC_DEVICE_227G:
-		if (!IS_ENABLED(CONFIG_GPIO_F7188X))
-			return -ENODEV;
-		request_module("gpio-f7188x");
-		simatic_ipc_led_gpio_table = &simatic_ipc_led_gpio_table_227g;
-		simatic_ipc_led_gpio_table_extra = &simatic_ipc_led_gpio_table_227g_extra;
-		break;
-	default:
-		return -ENODEV;
-	}
-
-	gpiod_add_lookup_table(simatic_ipc_led_gpio_table);
-	simatic_leds_pdev = platform_device_register_resndata(NULL,
-		"leds-gpio", PLATFORM_DEVID_NONE, NULL, 0,
-		&simatic_ipc_gpio_leds_pdata,
-		sizeof(simatic_ipc_gpio_leds_pdata));
-	if (IS_ERR(simatic_leds_pdev)) {
-		err = PTR_ERR(simatic_leds_pdev);
-		goto out;
-	}
-
-	simatic_ipc_led_gpio_table_extra->dev_id = dev_name(dev);
-	gpiod_add_lookup_table(simatic_ipc_led_gpio_table_extra);
-
-	/* PM_BIOS_BOOT_N */
-	gpiod = gpiod_get_index(dev, NULL, 6, GPIOD_OUT_LOW);
-	if (IS_ERR(gpiod)) {
-		err = PTR_ERR(gpiod);
-		goto out;
-	}
-	gpiod_put(gpiod);
-
-	/* PM_WDT_OUT */
-	gpiod = gpiod_get_index(dev, NULL, 7, GPIOD_OUT_LOW);
-	if (IS_ERR(gpiod)) {
-		err = PTR_ERR(gpiod);
-		goto out;
-	}
-	gpiod_put(gpiod);
-
-	return 0;
-out:
-	simatic_ipc_leds_gpio_remove(pdev);
-
-	return err;
-}
-
-static struct platform_driver simatic_ipc_led_gpio_driver = {
-	.probe = simatic_ipc_leds_gpio_probe,
-	.remove = simatic_ipc_leds_gpio_remove,
-	.driver = {
-		.name = KBUILD_MODNAME,
-	}
-};
-module_platform_driver(simatic_ipc_led_gpio_driver);
-
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:" KBUILD_MODNAME);
-MODULE_SOFTDEP("pre: platform:leds-gpio");
-MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.h b/drivers/leds/simple/simatic-ipc-leds-gpio.h
new file mode 100644
index 0000000000000..bf258c32f83de
--- /dev/null
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio.h
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Siemens SIMATIC IPC driver for GPIO based LEDs
+ *
+ * Copyright (c) Siemens AG, 2023
+ *
+ * Author:
+ *  Henning Schild <henning.schild@siemens.com>
+ */
+
+#ifndef _SIMATIC_IPC_LEDS_GPIO_H
+#define _SIMATIC_IPC_LEDS_GPIO_H
+
+int simatic_ipc_leds_gpio_probe(struct platform_device *pdev,
+				struct gpiod_lookup_table *table,
+				struct gpiod_lookup_table *table_extra);
+
+int simatic_ipc_leds_gpio_remove(struct platform_device *pdev,
+				 struct gpiod_lookup_table *table,
+				 struct gpiod_lookup_table *table_extra);
+
+#endif /* _SIMATIC_IPC_LEDS_GPIO_H */
diff --git a/drivers/leds/simple/simatic-ipc-leds.c b/drivers/leds/simple/simatic-ipc-leds.c
index 4894c228c165f..2124f6d09930b 100644
--- a/drivers/leds/simple/simatic-ipc-leds.c
+++ b/drivers/leds/simple/simatic-ipc-leds.c
@@ -126,7 +126,6 @@ static struct platform_driver simatic_ipc_led_driver = {
 		.name = KBUILD_MODNAME,
 	}
 };
-
 module_platform_driver(simatic_ipc_led_driver);
 
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/platform/x86/simatic-ipc.c b/drivers/platform/x86/simatic-ipc.c
index b3622419cd1a4..c773995b230d4 100644
--- a/drivers/platform/x86/simatic-ipc.c
+++ b/drivers/platform/x86/simatic-ipc.c
@@ -68,9 +68,10 @@ static int register_platform_devices(u32 station_id)
 	}
 
 	if (ledmode != SIMATIC_IPC_DEVICE_NONE) {
-		if (ledmode == SIMATIC_IPC_DEVICE_127E ||
-		    ledmode == SIMATIC_IPC_DEVICE_227G)
-			pdevname = KBUILD_MODNAME "_leds_gpio";
+		if (ledmode == SIMATIC_IPC_DEVICE_127E)
+			pdevname = KBUILD_MODNAME "_leds_gpio_apollolake";
+		if (ledmode == SIMATIC_IPC_DEVICE_227G)
+			pdevname = KBUILD_MODNAME "_leds_gpio_f7188x";
 		platform_data.devmode = ledmode;
 		ipc_led_platform_device =
 			platform_device_register_data(NULL,
-- 
2.53.0

