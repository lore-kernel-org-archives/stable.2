Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09373655F0
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 03:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783998289; cv=none; b=RsTLJd/Gc9ivjxmcO9uAY4NJzhV5x37fX9vGeJRK7gh0VrR7DQQCyLpPBiFyvXfMtytKSxbiJuG5el5/IYqzEoSrzTuDNFgoSy6S3vFd665ZqCW/emkUBxW/PC7fXZ5N033se/fedMl7gP7YIXhTMjBJMkaIuP2PFPii0keNwDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783998289; c=relaxed/simple;
	bh=G2SgSMHOQydfgWebSTERv6HYUGw+/MdQwG5a6v/VgKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Or8/n6DMFmO07iwR1VjMoD82q3Jhsm2BecQIbe1edcYq4EF2uNvBl7MelnHhOsNy5MTCpAlYHSXgjHOiX2rcp2QWrNUELrnqSr/KDfoD+yGfko/ncQ+xBO57tFrKBiZLRrUH7Bjw4q4obB3LUGydg5eU6gg4DwrOPM3MfU5O9tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGhBzRU1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGhBzRU1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB141F00A3D;
	Tue, 14 Jul 2026 03:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783998287;
	bh=j0BkXq3kTwJRJEnGWd+p3VoP4qToPykPxZzjyCneL90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bGhBzRU1YUwdyp9xmJj+7OKwwFS7x5lvTpkriV6ubzj9qYlRHWy/1stnX+irM1wRC
	 b/3L7Vw4X1FXb2tHcK7xbNtKSBjrlrO+9m760dYfROMQ6txJbiN/2GJo1HlK5oxi1U
	 VAdnc7TSTj6o3JS3XlVq66dWnWZ18Hch3ieYYd9EGArn9WvKhJhW5493kSqb+UULoM
	 bf72Anco1kcnMBqpZgPU8Sa3PlqFD1G4R+KGYxxG+qo6b8cqI5MMSJMqudaKOovpfO
	 +t1+e4ZpVo9a8npamk39zllXs8/n0ymlg7fSpudaVGHUO4RgVfReOKQqUYUKH1ljr5
	 3JROAkquBwedw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/8] iio: move inv_icm42600 timestamp module in common
Date: Mon, 13 Jul 2026 23:04:38 -0400
Message-ID: <20260714030444.2382550-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714030444.2382550-1-sashal@kernel.org>
References: <2026071317-litmus-defame-e23c@gregkh>
 <20260714030444.2382550-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

[ Upstream commit d99ff463ecf651437e9e4abe68f331dfb6b5bd9d ]

Create new inv_sensors common modules and move inv_icm42600
timestamp module inside. This module will be used by IMUs and
also in the future by other chips.

Modify inv_icm42600 driver to use timestamp module and do some
headers cleanup.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/20230606162147.79667-3-inv.git-commit@tdk.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: affe3f077d7a ("iio: imu: inv_icm42600: fix timestamping by limiting FIFO reading")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/common/Kconfig                            |  1 +
 drivers/iio/common/Makefile                           |  1 +
 drivers/iio/common/inv_sensors/Kconfig                |  7 +++++++
 drivers/iio/common/inv_sensors/Makefile               |  6 ++++++
 .../inv_sensors}/inv_icm42600_timestamp.c             | 11 ++++++++++-
 drivers/iio/imu/inv_icm42600/Kconfig                  |  1 +
 drivers/iio/imu/inv_icm42600/Makefile                 |  1 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c     |  5 +++--
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c    |  5 +++--
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c      |  4 +++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c      |  5 +++--
 .../linux/iio/common}/inv_icm42600_timestamp.h        |  0
 12 files changed, 38 insertions(+), 9 deletions(-)
 create mode 100644 drivers/iio/common/inv_sensors/Kconfig
 create mode 100644 drivers/iio/common/inv_sensors/Makefile
 rename drivers/iio/{imu/inv_icm42600 => common/inv_sensors}/inv_icm42600_timestamp.c (91%)
 rename {drivers/iio/imu/inv_icm42600 => include/linux/iio/common}/inv_icm42600_timestamp.h (100%)

diff --git a/drivers/iio/common/Kconfig b/drivers/iio/common/Kconfig
index 2b9ee9161abdc9..9279803453d9d3 100644
--- a/drivers/iio/common/Kconfig
+++ b/drivers/iio/common/Kconfig
@@ -5,6 +5,7 @@
 
 source "drivers/iio/common/cros_ec_sensors/Kconfig"
 source "drivers/iio/common/hid-sensors/Kconfig"
+source "drivers/iio/common/inv_sensors/Kconfig"
 source "drivers/iio/common/ms_sensors/Kconfig"
 source "drivers/iio/common/ssp_sensors/Kconfig"
 source "drivers/iio/common/st_sensors/Kconfig"
diff --git a/drivers/iio/common/Makefile b/drivers/iio/common/Makefile
index 4bc30bb548e2d5..266ddba5d843da 100644
--- a/drivers/iio/common/Makefile
+++ b/drivers/iio/common/Makefile
@@ -10,6 +10,7 @@
 # When adding new entries keep the list in alphabetical order
 obj-y += cros_ec_sensors/
 obj-y += hid-sensors/
+obj-y += inv_sensors/
 obj-y += ms_sensors/
 obj-y += ssp_sensors/
 obj-y += st_sensors/
diff --git a/drivers/iio/common/inv_sensors/Kconfig b/drivers/iio/common/inv_sensors/Kconfig
new file mode 100644
index 00000000000000..28815fb431573d
--- /dev/null
+++ b/drivers/iio/common/inv_sensors/Kconfig
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# TDK-InvenSense sensors common library
+#
+
+config IIO_INV_SENSORS_TIMESTAMP
+	tristate
diff --git a/drivers/iio/common/inv_sensors/Makefile b/drivers/iio/common/inv_sensors/Makefile
new file mode 100644
index 00000000000000..93bddb9356b833
--- /dev/null
+++ b/drivers/iio/common/inv_sensors/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for TDK-InvenSense sensors module.
+#
+
+obj-$(CONFIG_IIO_INV_SENSORS_TIMESTAMP) += inv_icm42600_timestamp.o
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c b/drivers/iio/common/inv_sensors/inv_icm42600_timestamp.c
similarity index 91%
rename from drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
rename to drivers/iio/common/inv_sensors/inv_icm42600_timestamp.c
index d3d560eaa7d8ed..f1a144fbd9b096 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_icm42600_timestamp.c
@@ -6,8 +6,9 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/math64.h>
+#include <linux/module.h>
 
-#include "inv_icm42600_timestamp.h"
+#include <linux/iio/common/inv_icm42600_timestamp.h>
 
 /* internal chip period is 32kHz, 31250ns */
 #define INV_ICM42600_TIMESTAMP_PERIOD		31250
@@ -54,6 +55,7 @@ void inv_icm42600_timestamp_init(struct inv_icm42600_timestamp *ts,
 	/* use theoretical value for chip period */
 	inv_update_acc(&ts->chip_period, INV_ICM42600_TIMESTAMP_PERIOD);
 }
+EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_init, IIO_INV_SENSORS_TIMESTAMP);
 
 int inv_icm42600_timestamp_update_odr(struct inv_icm42600_timestamp *ts,
 				      uint32_t period, bool fifo)
@@ -66,6 +68,7 @@ int inv_icm42600_timestamp_update_odr(struct inv_icm42600_timestamp *ts,
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_update_odr, IIO_INV_SENSORS_TIMESTAMP);
 
 static bool inv_validate_period(uint32_t period, uint32_t mult)
 {
@@ -150,6 +153,7 @@ void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *ts,
 		ts->timestamp += delta;
 	}
 }
+EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_interrupt, IIO_INV_SENSORS_TIMESTAMP);
 
 void inv_icm42600_timestamp_apply_odr(struct inv_icm42600_timestamp *ts,
 				      uint32_t fifo_period, size_t fifo_nb,
@@ -181,3 +185,8 @@ void inv_icm42600_timestamp_apply_odr(struct inv_icm42600_timestamp *ts,
 		ts->timestamp = ts->it.up - interval;
 	}
 }
+EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_apply_odr, IIO_INV_SENSORS_TIMESTAMP);
+
+MODULE_AUTHOR("InvenSense, Inc.");
+MODULE_DESCRIPTION("InvenSense sensors timestamp module");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/imu/inv_icm42600/Kconfig b/drivers/iio/imu/inv_icm42600/Kconfig
index 50cbcfcb6cf18c..f56b0816cc4db2 100644
--- a/drivers/iio/imu/inv_icm42600/Kconfig
+++ b/drivers/iio/imu/inv_icm42600/Kconfig
@@ -3,6 +3,7 @@
 config INV_ICM42600
 	tristate
 	select IIO_BUFFER
+	select IIO_INV_SENSORS_TIMESTAMP
 
 config INV_ICM42600_I2C
 	tristate "InvenSense ICM-426xx I2C driver"
diff --git a/drivers/iio/imu/inv_icm42600/Makefile b/drivers/iio/imu/inv_icm42600/Makefile
index 291714d9aa54f2..0f49f6df3647bb 100644
--- a/drivers/iio/imu/inv_icm42600/Makefile
+++ b/drivers/iio/imu/inv_icm42600/Makefile
@@ -6,7 +6,6 @@ inv-icm42600-y += inv_icm42600_gyro.o
 inv-icm42600-y += inv_icm42600_accel.o
 inv-icm42600-y += inv_icm42600_temp.o
 inv-icm42600-y += inv_icm42600_buffer.o
-inv-icm42600-y += inv_icm42600_timestamp.o
 
 obj-$(CONFIG_INV_ICM42600_I2C) += inv-icm42600-i2c.o
 inv-icm42600-i2c-y += inv_icm42600_i2c.o
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index b05ab6c04d97e8..473d68b45935f6 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -10,14 +10,15 @@
 #include <linux/regmap.h>
 #include <linux/delay.h>
 #include <linux/math64.h>
-#include <linux/iio/iio.h>
+
 #include <linux/iio/buffer.h>
+#include <linux/iio/common/inv_icm42600_timestamp.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 
 #include "inv_icm42600.h"
 #include "inv_icm42600_temp.h"
 #include "inv_icm42600_buffer.h"
-#include "inv_icm42600_timestamp.h"
 
 #define INV_ICM42600_ACCEL_CHAN(_modifier, _index, _ext_info)		\
 	{								\
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index f29c3e8531e6fb..afaaa45477a967 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -9,11 +9,12 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/delay.h>
-#include <linux/iio/iio.h>
+
 #include <linux/iio/buffer.h>
+#include <linux/iio/common/inv_icm42600_timestamp.h>
+#include <linux/iio/iio.h>
 
 #include "inv_icm42600.h"
-#include "inv_icm42600_timestamp.h"
 #include "inv_icm42600_buffer.h"
 
 /* FIFO header: 1 byte */
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 7f588bd7a5f797..96777ca4176016 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -15,11 +15,12 @@
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+
+#include <linux/iio/common/inv_icm42600_timestamp.h>
 #include <linux/iio/iio.h>
 
 #include "inv_icm42600.h"
 #include "inv_icm42600_buffer.h"
-#include "inv_icm42600_timestamp.h"
 
 static const struct regmap_range_cfg inv_icm42600_regmap_ranges[] = {
 	{
@@ -798,3 +799,4 @@ EXPORT_SYMBOL_GPL(inv_icm42600_pm_ops);
 MODULE_AUTHOR("InvenSense, Inc.");
 MODULE_DESCRIPTION("InvenSense ICM-426xx device driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_INV_SENSORS_TIMESTAMP);
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 550e083c93edb5..1a019ebca4c791 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -10,14 +10,15 @@
 #include <linux/regmap.h>
 #include <linux/delay.h>
 #include <linux/math64.h>
-#include <linux/iio/iio.h>
+
 #include <linux/iio/buffer.h>
+#include <linux/iio/common/inv_icm42600_timestamp.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 
 #include "inv_icm42600.h"
 #include "inv_icm42600_temp.h"
 #include "inv_icm42600_buffer.h"
-#include "inv_icm42600_timestamp.h"
 
 #define INV_ICM42600_GYRO_CHAN(_modifier, _index, _ext_info)		\
 	{								\
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h b/include/linux/iio/common/inv_icm42600_timestamp.h
similarity index 100%
rename from drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h
rename to include/linux/iio/common/inv_icm42600_timestamp.h
-- 
2.53.0

