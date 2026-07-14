Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173711EEA31
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 01:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783991792; cv=none; b=c/KtB2D2/j5d/QKUroBV1f9KAhWABfaKU5OiUz8CkHY3/eygEXMZNI6Wj+8OzvcLH/mgHLVn+JNpx7QYUnPIBBsU1mqW/LIPTRNiHSugIBGA/LoQNt0a4i/eWPXe/5unL+yPCm6404+pA5eE3dDTa4d0copTutrcHMXqtrpU5l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783991792; c=relaxed/simple;
	bh=eFXiDhCeQcq5+1a2q79TVvkQH/EG396rZQYD4fXoxi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGw+24CTCIyfNbXpevaC4Uk7yZ+D3qNNhLdD4dRiSzCeGUPQYS5/3PpeX5vBaZuOApMeMGJpuIVLfAowUls6yA6EXO8CqsgjXqSqUO/7Dm+4ZKmxa7BmVjBherjpTicCGJLEOJZKCMj8cawlDiXjp4b3zIQpW/k1lwEo9iBxaUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRaKoRef; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRaKoRef"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663AD1F00A3A;
	Tue, 14 Jul 2026 01:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783991791;
	bh=ziE+Xo+lMlLKvDFS0ETyZydHDEZC9J2aVkxrt5Noox4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TRaKoRefK09yYFbM0B6lGRiRyyt1UWvPPuvNOm6XDy0Ih1xyEC+06sdzTxipquuvJ
	 N4OdqtArqSopR+sMnPcFmsnmM/gId/Yh0gO7yyzP2du1Lv5ajTyp4Rknj5TEy0gncJ
	 8IhmqovxeXNTXTKBIaLPyusWF/fvCxzHiua5eJm4YhBCui9ru8hTjxlUkBwrQ8WyXu
	 G6HimtMHs888zgEmetgBJCfMObnT1OGVQE0rKU+if4uLpVIB22yyrihSs3KGjaipK3
	 2haBNtGZjms05LWGkTAj77f12ctPLVwG0iPU9RwbMU/kE7b+05v8TSnk+EAmIpHnoX
	 wK/NB8QtbHNQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/8] iio: move inv_icm42600 timestamp module in common
Date: Mon, 13 Jul 2026 21:16:21 -0400
Message-ID: <20260714011627.2188779-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714011627.2188779-1-sashal@kernel.org>
References: <2026071317-refill-huntress-d0e2@gregkh>
 <20260714011627.2188779-1-sashal@kernel.org>
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
index 0334b495477338..1ccb5ccf370660 100644
--- a/drivers/iio/common/Kconfig
+++ b/drivers/iio/common/Kconfig
@@ -5,6 +5,7 @@
 
 source "drivers/iio/common/cros_ec_sensors/Kconfig"
 source "drivers/iio/common/hid-sensors/Kconfig"
+source "drivers/iio/common/inv_sensors/Kconfig"
 source "drivers/iio/common/ms_sensors/Kconfig"
 source "drivers/iio/common/scmi_sensors/Kconfig"
 source "drivers/iio/common/ssp_sensors/Kconfig"
diff --git a/drivers/iio/common/Makefile b/drivers/iio/common/Makefile
index fad40e1e171819..d3e952239a6219 100644
--- a/drivers/iio/common/Makefile
+++ b/drivers/iio/common/Makefile
@@ -10,6 +10,7 @@
 # When adding new entries keep the list in alphabetical order
 obj-y += cros_ec_sensors/
 obj-y += hid-sensors/
+obj-y += inv_sensors/
 obj-y += ms_sensors/
 obj-y += scmi_sensors/
 obj-y += ssp_sensors/
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
index 926a2cba9070ae..d0f078635c6f66 100644
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
index 0369cfd990ca01..f8ec87f4a3461f 100644
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
index 53132846d18bdd..744b1ef35ba28c 100644
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

