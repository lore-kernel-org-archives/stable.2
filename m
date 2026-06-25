Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D4C2F8E9F
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 16:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404712; cv=none; b=CsabQR0848ODbCTelEQVRBTE7pxfVE9ioPQCTG3YQCkIcZOFRQl2MsQvs/0z/0FNI9vCt9fH5ZpSizUX3H3cDGrcZW5RBQiwZRXoY1sb1eY8R6ua5FLhWBHbQa2oz7Xbu2ci0P47pyvW6azlPAwMswMPLaNRTW2IXxyMZW4j8rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404712; c=relaxed/simple;
	bh=CzqoYuS13eMinFbAn+yeEXjLUDbqBK43bF3O26g1Fto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTrnWlUCBSD98LFAsroUV58PSuuyJ/IJ0LNVceoKEtqpEotiLNgVaJdaZOban9nuxX2q6b5dEKVU9d/Gh0x7b7bAty2FNbZ5muiSxGSjV8kjtSuZwrDjUBJcJ2Vy6zFiGOF6S1IUMQlk9MbXgYD02A5Xct1glvW3qZJS7qu0igk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYrHzsWq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYrHzsWq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E86D1F000E9;
	Thu, 25 Jun 2026 16:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782404710;
	bh=7zlW33xhl+r6gxQeIX0WBS5GgSJxuCz0f3CmcYkgrfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IYrHzsWqPoLeLX9Qc6XSeivNdkWO7w6KBl5Jy8RRiLMD1oM7OxNP4KNsu8LPcA94X
	 pIB1DN7m53EYwMHtxh8Su3FRj0YUQdHjx5UV0B+na/ViIl63qMYGfZE0fmEApMz3M5
	 /pHb0DWF3WI/IGmp5WTPhMAnd8SQCqT0fJqwNuMqDg18SVnLi3Jajiv1ffME15qEFf
	 r9Z7bhwjG6p2dDKEefMfWke1SFpw41cCzy8A7mDHLveSlT7k1Y7BHiFLvXDl42NXo9
	 I457UYS2fHiASkDpbcfV81/oXzaSFOPQa6PGpnM6+KHnsqEKVJv8wVZt0lchTfDEj6
	 UsvIp/1KNOvRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] Input: include export.h in modules using EXPORT_SYMBOL*()
Date: Thu, 25 Jun 2026 12:25:07 -0400
Message-ID: <20260625162508.2501015-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026062528-cyclist-operable-1e2f@gregkh>
References: <2026062528-cyclist-operable-1e2f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit df595059d54383c42607b59f1f9ea74dade280fe ]

A number of modules in the input subsystem use EXPORT_SYMBOL() and
friends without explicitly including the corresponding header
<linux/export.h>. While the build currently succeeds due to this header
being pulled in transitively, this is not guaranteed to be the case in
the future.

Let's add the explicit include to make the dependencies clear and
prevent future build breakage.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Stable-dep-of: 0adb483fbf2d ("Input: rmi4 - refactor register descriptor parsing")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/ff-core.c                        | 2 +-
 drivers/input/ff-memless.c                     | 1 +
 drivers/input/gameport/gameport.c              | 1 +
 drivers/input/input-poller.c                   | 1 +
 drivers/input/input.c                          | 1 +
 drivers/input/joystick/iforce/iforce-main.c    | 1 +
 drivers/input/joystick/iforce/iforce-packets.c | 1 +
 drivers/input/misc/ad714x.c                    | 1 +
 drivers/input/misc/adxl34x.c                   | 1 +
 drivers/input/misc/cma3000_d0x.c               | 1 +
 drivers/input/rmi4/rmi_2d_sensor.c             | 1 +
 drivers/input/rmi4/rmi_bus.c                   | 1 +
 drivers/input/rmi4/rmi_driver.c                | 1 +
 drivers/input/serio/hil_mlc.c                  | 1 +
 drivers/input/serio/hp_sdc.c                   | 1 +
 drivers/input/serio/i8042.c                    | 1 +
 drivers/input/serio/libps2.c                   | 1 +
 drivers/input/serio/serio.c                    | 1 +
 drivers/input/sparse-keymap.c                  | 1 +
 drivers/input/touchscreen.c                    | 1 +
 drivers/input/touchscreen/ad7879.c             | 1 +
 drivers/input/touchscreen/cyttsp_core.c        | 1 +
 drivers/input/touchscreen/goodix_berlin_core.c | 1 +
 drivers/input/touchscreen/tsc200x-core.c       | 1 +
 drivers/input/touchscreen/wm9705.c             | 1 +
 drivers/input/touchscreen/wm9712.c             | 1 +
 drivers/input/touchscreen/wm9713.c             | 1 +
 drivers/input/touchscreen/wm97xx-core.c        | 1 +
 28 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/input/ff-core.c b/drivers/input/ff-core.c
index 609a5f01761bd3..de5948c9579833 100644
--- a/drivers/input/ff-core.c
+++ b/drivers/input/ff-core.c
@@ -8,9 +8,9 @@
 
 /* #define DEBUG */
 
+#include <linux/export.h>
 #include <linux/input.h>
 #include <linux/limits.h>
-#include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/overflow.h>
 #include <linux/sched.h>
diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
index c321cdabd21418..ef711bc35f738f 100644
--- a/drivers/input/ff-memless.c
+++ b/drivers/input/ff-memless.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/input.h>
 #include <linux/module.h>
diff --git a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
index 10cc95867415a5..3ab0c33bc32a03 100644
--- a/drivers/input/gameport/gameport.c
+++ b/drivers/input/gameport/gameport.c
@@ -9,6 +9,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/export.h>
 #include <linux/stddef.h>
 #include <linux/module.h>
 #include <linux/io.h>
diff --git a/drivers/input/input-poller.c b/drivers/input/input-poller.c
index 688e3cb1c2a0cb..5f2867bf1e2b9f 100644
--- a/drivers/input/input-poller.c
+++ b/drivers/input/input-poller.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/export.h>
 #include <linux/input.h>
 #include <linux/jiffies.h>
 #include <linux/mutex.h>
diff --git a/drivers/input/input.c b/drivers/input/input.c
index c51858f1cdc556..2a58584c2b504f 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt) KBUILD_BASENAME ": " fmt
 
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/idr.h>
diff --git a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/joystick/iforce/iforce-main.c
index 55e6321adab9d6..86d09faa685c52 100644
--- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -6,6 +6,7 @@
  *  USB/RS232 I-Force joysticks and wheels.
  */
 
+#include <linux/export.h>
 #include <linux/unaligned.h>
 #include "iforce.h"
 
diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index 08c889a72f6c67..4dedc22ee281ca 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -6,6 +6,7 @@
  *  USB/RS232 I-Force joysticks and wheels.
  */
 
+#include <linux/export.h>
 #include <linux/unaligned.h>
 #include "iforce.h"
 
diff --git a/drivers/input/misc/ad714x.c b/drivers/input/misc/ad714x.c
index 1acd8429c56c97..aa271b42f8b442 100644
--- a/drivers/input/misc/ad714x.c
+++ b/drivers/input/misc/ad714x.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/export.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
diff --git a/drivers/input/misc/adxl34x.c b/drivers/input/misc/adxl34x.c
index 7cafbf8d5f1ad8..ac7674647c0928 100644
--- a/drivers/input/misc/adxl34x.c
+++ b/drivers/input/misc/adxl34x.c
@@ -9,6 +9,7 @@
 
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/export.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
diff --git a/drivers/input/misc/cma3000_d0x.c b/drivers/input/misc/cma3000_d0x.c
index 0c68e924a1ccdc..81235a83c33edd 100644
--- a/drivers/input/misc/cma3000_d0x.c
+++ b/drivers/input/misc/cma3000_d0x.c
@@ -6,6 +6,7 @@
  * Author: Hemanth V <hemanthv@ti.com>
  */
 
+#include <linux/export.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
diff --git a/drivers/input/rmi4/rmi_2d_sensor.c b/drivers/input/rmi4/rmi_2d_sensor.c
index b7fe6eb35a4ecd..ea3eb87a89af53 100644
--- a/drivers/input/rmi4/rmi_2d_sensor.c
+++ b/drivers/input/rmi4/rmi_2d_sensor.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2011 Unixphere
  */
 
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/of.h>
diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index 3aee0483720533..c32564084a9131 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2011 Unixphere
  */
 
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/irq.h>
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 2168b6cd716733..ccd9338a44dbef 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -21,6 +21,7 @@
 #include <linux/irqdomain.h>
 #include <uapi/linux/input.h>
 #include <linux/rmi.h>
+#include <linux/export.h>
 #include "rmi_bus.h"
 #include "rmi_driver.h"
 
diff --git a/drivers/input/serio/hil_mlc.c b/drivers/input/serio/hil_mlc.c
index d36e89d6fc546a..d8bd6dae08eb3b 100644
--- a/drivers/input/serio/hil_mlc.c
+++ b/drivers/input/serio/hil_mlc.c
@@ -54,6 +54,7 @@
 
 #include <linux/hil_mlc.h>
 #include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/drivers/input/serio/hp_sdc.c b/drivers/input/serio/hp_sdc.c
index 13eacf6ab43100..fa0c097cafb42e 100644
--- a/drivers/input/serio/hp_sdc.c
+++ b/drivers/input/serio/hp_sdc.c
@@ -63,6 +63,7 @@
 
 #include <linux/hp_sdc.h>
 #include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/ioport.h>
diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 8ec4872b447145..62814204b84dec 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -10,6 +10,7 @@
 
 #include <linux/types.h>
 #include <linux/delay.h>
+#include <linux/export.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index 6d78a1fe00c1bf..03949187a14e44 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -8,6 +8,7 @@
 
 
 #include <linux/delay.h>
+#include <linux/export.h>
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index 97d8eacb911276..38ad4794ab95d3 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -9,6 +9,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/export.h>
 #include <linux/stddef.h>
 #include <linux/module.h>
 #include <linux/serio.h>
diff --git a/drivers/input/sparse-keymap.c b/drivers/input/sparse-keymap.c
index 25bf8be6e71116..6f28fd79ea39d4 100644
--- a/drivers/input/sparse-keymap.c
+++ b/drivers/input/sparse-keymap.c
@@ -10,6 +10,7 @@
  * Copyright (C) 2005 Dmitry Torokhov <dtor@mail.ru>
  */
 
+#include <linux/export.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
 #include <linux/module.h>
diff --git a/drivers/input/touchscreen.c b/drivers/input/touchscreen.c
index 4620e20d0190f7..d699b24bb5486c 100644
--- a/drivers/input/touchscreen.c
+++ b/drivers/input/touchscreen.c
@@ -6,6 +6,7 @@
  *  Copyright (c) 2014 Sebastian Reichel <sre@kernel.org>
  */
 
+#include <linux/export.h>
 #include <linux/property.h>
 #include <linux/input.h>
 #include <linux/input/mt.h>
diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index e5d69bf2276e0f..991337053edc2a 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -22,6 +22,7 @@
 
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/export.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/touchscreen/cyttsp_core.c
index b8ce6012364cfe..9e729910fbc8d8 100644
--- a/drivers/input/touchscreen/cyttsp_core.c
+++ b/drivers/input/touchscreen/cyttsp_core.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/export.h>
 #include <linux/input.h>
 #include <linux/input/mt.h>
 #include <linux/input/touchscreen.h>
diff --git a/drivers/input/touchscreen/goodix_berlin_core.c b/drivers/input/touchscreen/goodix_berlin_core.c
index 141c64675997db..218ba7375673cc 100644
--- a/drivers/input/touchscreen/goodix_berlin_core.c
+++ b/drivers/input/touchscreen/goodix_berlin_core.c
@@ -24,6 +24,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/export.h>
 #include <linux/gpio/consumer.h>
 #include <linux/input.h>
 #include <linux/input/mt.h>
diff --git a/drivers/input/touchscreen/tsc200x-core.c b/drivers/input/touchscreen/tsc200x-core.c
index df39dee13e1ca4..f96108351cf8b8 100644
--- a/drivers/input/touchscreen/tsc200x-core.c
+++ b/drivers/input/touchscreen/tsc200x-core.c
@@ -10,6 +10,7 @@
  * based on TSC2301 driver by Klaus K. Pedersen <klaus.k.pedersen@nokia.com>
  */
 
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/input.h>
diff --git a/drivers/input/touchscreen/wm9705.c b/drivers/input/touchscreen/wm9705.c
index 4b55d5e1ea0fb8..96484aae030c89 100644
--- a/drivers/input/touchscreen/wm9705.c
+++ b/drivers/input/touchscreen/wm9705.c
@@ -9,6 +9,7 @@
  *                   Russell King <rmk@arm.linux.org.uk>
  */
 
+#include <linux/export.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
diff --git a/drivers/input/touchscreen/wm9712.c b/drivers/input/touchscreen/wm9712.c
index 6947714dfefa18..087ece57741a08 100644
--- a/drivers/input/touchscreen/wm9712.c
+++ b/drivers/input/touchscreen/wm9712.c
@@ -9,6 +9,7 @@
  *                   Russell King <rmk@arm.linux.org.uk>
  */
 
+#include <linux/export.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
diff --git a/drivers/input/touchscreen/wm9713.c b/drivers/input/touchscreen/wm9713.c
index a67fbe304f9291..6f13f46ce6e6f8 100644
--- a/drivers/input/touchscreen/wm9713.c
+++ b/drivers/input/touchscreen/wm9713.c
@@ -9,6 +9,7 @@
  *                   Russell King <rmk@arm.linux.org.uk>
  */
 
+#include <linux/export.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index f01f6cc9b59fa8..45d19f6aef5f52 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -29,6 +29,7 @@
  *       - Support for async sampling control for noisy LCDs.
  */
 
+#include <linux/export.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
-- 
2.53.0

