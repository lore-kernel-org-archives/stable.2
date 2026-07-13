Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE38C35DA6E
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 20:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783975188; cv=none; b=fQt79MzNIhEAjJihC5IYg3WEuSOb+73onp6jC6SZ576ZYAfRhpsvgEtxuZ0kqhYTvFoe7An5OOV+JQe9dDZluWaFCFnQjjYne4qiIWIzItwmFKJ44qlcrfTDT3PgIjVTc7O0T8nMnwWSnG2dtQC8lyLlSDWk4d9bbIDVrxOF4zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783975188; c=relaxed/simple;
	bh=A7MI0GnOPXbHvt1poyeFeH79vEGfa27Nj2mOmcteV8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IuvQopkePQDg0pOHUA+oPsHlATxhlxfT522pQ9dEjG2AUZCP0Rlyqsl1uBtEDDbqQMqsNbsW/1VBRFr+LERz7lp9csL/nZQwK5xkzGWCVA5NHQjX16LGQVv/rgrHSIYwom5uP/7sTONnsg1kMWKv9DQ1De8QSMjqC4GAxZ4GsVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTW9FxD/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTW9FxD/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CCA71F000E9;
	Mon, 13 Jul 2026 20:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783975186;
	bh=LAGOTeW3QBwNOBE8s1IQSBkKkAD0V16GJA2X3R3u2+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cTW9FxD/rvtHz+Fc6kXNHLA6gtFmo8c1LbWexTmcfLQYjlrMzZ7sjv60xUFR9AfnS
	 N7pgkY5mvh66h8Fu8yjZEBOIWbBDyLyvuYo/SkLN3uEXifHLbLE6PR45uSD8wVS+R6
	 8mcci5EAZ+XudcZhmFkBmH6/eLWLCaK1gwyS0Wfi/W3s0xJtNYnxI8mCfzmnf5hivu
	 jNSrNPdpWZbwHS3mrshseSERYXG8xaIlH9e2XkQJO1BWryVxmDTN/yTD2Ss2H2MNT4
	 CsNjvMsItmvUDbGmD4Tj53hO5h7YknFGLrKvGpa+jvuxE/Z7KnSftAFlDx3B7jyBxL
	 h6eoKyeqrTtcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/8] iio: imu: inv_mpu6050: use the common inv_sensors timestamp module
Date: Mon, 13 Jul 2026 16:39:38 -0400
Message-ID: <20260713203942.2144352-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713203942.2144352-1-sashal@kernel.org>
References: <2026071317-shortwave-thrift-0c90@gregkh>
 <20260713203942.2144352-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

[ Upstream commit 111e1abd00455971f6a568900f033cbddec9d4e5 ]

Replace timestamping by the new common inv_sensors timestamp
module. The principle behind is the same but the implementation in
the new module is far better providing less jitter and a better
estimation.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/20230606162147.79667-5-inv.git-commit@tdk.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: affe3f077d7a ("iio: imu: inv_icm42600: fix timestamping by limiting FIFO reading")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/imu/inv_mpu6050/Kconfig           |  1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 30 +++++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     | 18 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 83 ++-----------------
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  6 +-
 5 files changed, 45 insertions(+), 93 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
index 3636b1bc90f1c2..9c69164e2ddee1 100644
--- a/drivers/iio/imu/inv_mpu6050/Kconfig
+++ b/drivers/iio/imu/inv_mpu6050/Kconfig
@@ -7,6 +7,7 @@ config INV_MPU6050_IIO
 	tristate
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
+	select IIO_INV_SENSORS_TIMESTAMP
 
 config INV_MPU6050_I2C
 	tristate "Invensense MPU6050 devices (I2C)"
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 19a1ef5351d24d..bd64a71817b27f 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -12,12 +12,15 @@
 #include <linux/jiffies.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
-#include <linux/iio/iio.h>
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
+
+#include <linux/iio/common/inv_sensors_timestamp.h>
+#include <linux/iio/iio.h>
+
 #include "inv_mpu_iio.h"
 #include "inv_mpu_magn.h"
 
@@ -512,6 +515,7 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
 	int result;
 	u8 d;
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	struct inv_sensors_timestamp_chip timestamp;
 
 	result = inv_mpu6050_set_gyro_fsr(st, st->chip_config.fsr);
 	if (result)
@@ -535,12 +539,12 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
 	if (result)
 		return result;
 
-	/*
-	 * Internal chip period is 1ms (1kHz).
-	 * Let's use at the beginning the theorical value before measuring
-	 * with interrupt timestamps.
-	 */
-	st->chip_period = NSEC_PER_MSEC;
+	/* clock jitter is +/- 2% */
+	timestamp.clock_period = NSEC_PER_SEC / INV_MPU6050_INTERNAL_FREQ_HZ;
+	timestamp.jitter = 20;
+	timestamp.init_period =
+			NSEC_PER_SEC / INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
+	inv_sensors_timestamp_init(&st->timestamp, &timestamp);
 
 	/* magn chip init, noop if not present in the chip */
 	result = inv_mpu_magn_probe(st);
@@ -927,6 +931,8 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
 	int fifo_rate;
+	u32 fifo_period;
+	bool fifo_on;
 	u8 d;
 	int result;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -943,12 +949,21 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
 	d = INV_MPU6050_FIFO_RATE_TO_DIVIDER(fifo_rate);
 	/* compute back the fifo rate to handle truncation cases */
 	fifo_rate = INV_MPU6050_DIVIDER_TO_FIFO_RATE(d);
+	fifo_period = NSEC_PER_SEC / fifo_rate;
 
 	mutex_lock(&st->lock);
 	if (d == st->chip_config.divider) {
 		result = 0;
 		goto fifo_rate_fail_unlock;
 	}
+
+	fifo_on = st->chip_config.accl_fifo_enable ||
+		  st->chip_config.gyro_fifo_enable ||
+		  st->chip_config.magn_fifo_enable;
+	result = inv_sensors_timestamp_update_odr(&st->timestamp, fifo_period, fifo_on);
+	if (result)
+		goto fifo_rate_fail_unlock;
+
 	result = pm_runtime_resume_and_get(pdev);
 	if (result)
 		goto fifo_rate_fail_unlock;
@@ -1776,3 +1791,4 @@ EXPORT_SYMBOL_GPL(inv_mpu_pmops);
 MODULE_AUTHOR("Invensense Corporation");
 MODULE_DESCRIPTION("Invensense device MPU6050 driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_INV_SENSORS_TIMESTAMP);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 94b54c501ec0a6..daff6405b435bb 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -9,15 +9,17 @@
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
 #include <linux/mutex.h>
-#include <linux/iio/iio.h>
-#include <linux/iio/buffer.h>
+#include <linux/platform_data/invensense_mpu6050.h>
 #include <linux/regmap.h>
-#include <linux/iio/sysfs.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/common/inv_sensors_timestamp.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
-#include <linux/platform_data/invensense_mpu6050.h>
+#include <linux/iio/sysfs.h>
 
 /**
  *  struct inv_mpu6050_reg_map - Notable registers.
@@ -169,9 +171,7 @@ struct inv_mpu6050_hw {
  *  @map		regmap pointer.
  *  @irq		interrupt number.
  *  @irq_mask		the int_pin_cfg mask to configure interrupt type.
- *  @chip_period:	chip internal period estimation (~1kHz).
- *  @it_timestamp:	timestamp from previous interrupt.
- *  @data_timestamp:	timestamp for next data sample.
+ *  @timestamp:		timestamping module
  *  @vdd_supply:	VDD voltage regulator for the chip.
  *  @vddio_supply	I/O voltage regulator for the chip.
  *  @magn_disabled:     magnetometer disabled for backward compatibility reason.
@@ -195,9 +195,7 @@ struct inv_mpu6050_state {
 	int irq;
 	u8 irq_mask;
 	unsigned skip_samples;
-	s64 chip_period;
-	s64 it_timestamp;
-	s64 data_timestamp;
+	struct inv_sensors_timestamp timestamp;
 	struct regulator *vdd_supply;
 	struct regulator *vddio_supply;
 	bool magn_disabled;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 45c37525c2f165..d83f61a9950494 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -13,81 +13,10 @@
 #include <linux/interrupt.h>
 #include <linux/poll.h>
 #include <linux/math64.h>
-#include "inv_mpu_iio.h"
-
-/**
- *  inv_mpu6050_update_period() - Update chip internal period estimation
- *
- *  @st:		driver state
- *  @timestamp:		the interrupt timestamp
- *  @nb:		number of data set in the fifo
- *
- *  This function uses interrupt timestamps to estimate the chip period and
- *  to choose the data timestamp to come.
- */
-static void inv_mpu6050_update_period(struct inv_mpu6050_state *st,
-				      s64 timestamp, size_t nb)
-{
-	/* Period boundaries for accepting timestamp */
-	const s64 period_min =
-		(NSEC_PER_MSEC * (100 - INV_MPU6050_TS_PERIOD_JITTER)) / 100;
-	const s64 period_max =
-		(NSEC_PER_MSEC * (100 + INV_MPU6050_TS_PERIOD_JITTER)) / 100;
-	const s32 divider = INV_MPU6050_FREQ_DIVIDER(st);
-	s64 delta, interval;
-	bool use_it_timestamp = false;
-
-	if (st->it_timestamp == 0) {
-		/* not initialized, forced to use it_timestamp */
-		use_it_timestamp = true;
-	} else if (nb == 1) {
-		/*
-		 * Validate the use of it timestamp by checking if interrupt
-		 * has been delayed.
-		 * nb > 1 means interrupt was delayed for more than 1 sample,
-		 * so it's obviously not good.
-		 * Compute the chip period between 2 interrupts for validating.
-		 */
-		delta = div_s64(timestamp - st->it_timestamp, divider);
-		if (delta > period_min && delta < period_max) {
-			/* update chip period and use it timestamp */
-			st->chip_period = (st->chip_period + delta) / 2;
-			use_it_timestamp = true;
-		}
-	}
 
-	if (use_it_timestamp) {
-		/*
-		 * Manage case of multiple samples in the fifo (nb > 1):
-		 * compute timestamp corresponding to the first sample using
-		 * estimated chip period.
-		 */
-		interval = (nb - 1) * st->chip_period * divider;
-		st->data_timestamp = timestamp - interval;
-	}
+#include <linux/iio/common/inv_sensors_timestamp.h>
 
-	/* save it timestamp */
-	st->it_timestamp = timestamp;
-}
-
-/**
- *  inv_mpu6050_get_timestamp() - Return the current data timestamp
- *
- *  @st:		driver state
- *  @return:		current data timestamp
- *
- *  This function returns the current data timestamp and prepares for next one.
- */
-static s64 inv_mpu6050_get_timestamp(struct inv_mpu6050_state *st)
-{
-	s64 ts;
-
-	/* return current data timestamp and increment */
-	ts = st->data_timestamp;
-	st->data_timestamp += st->chip_period * INV_MPU6050_FREQ_DIVIDER(st);
-
-	return ts;
-}
+#include "inv_mpu_iio.h"
 
 static int inv_reset_fifo(struct iio_dev *indio_dev)
 {
@@ -121,6 +50,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	size_t bytes_per_datum;
 	int result;
 	u16 fifo_count;
+	u32 fifo_period;
 	s64 timestamp;
 	int int_status;
 	size_t i, nb;
@@ -177,7 +107,10 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 
 	/* compute and process all complete datum */
 	nb = fifo_count / bytes_per_datum;
-	inv_mpu6050_update_period(st, pf->timestamp, nb);
+	/* Each FIFO data contains all sensors, so same number for FIFO and sensor data */
+	fifo_period = NSEC_PER_SEC / INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
+	inv_sensors_timestamp_interrupt(&st->timestamp, fifo_period, nb, nb, pf->timestamp);
+	inv_sensors_timestamp_apply_odr(&st->timestamp, fifo_period, nb, 0);
 	for (i = 0; i < nb; ++i) {
 		result = regmap_noinc_read(st->map, st->reg->fifo_r_w,
 					   st->data, bytes_per_datum);
@@ -188,7 +121,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 			st->skip_samples--;
 			continue;
 		}
-		timestamp = inv_mpu6050_get_timestamp(st);
+		timestamp = inv_sensors_timestamp_pop(&st->timestamp);
 		iio_push_to_buffers_with_timestamp(indio_dev, st->data, timestamp);
 	}
 
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 882546897255cd..676704f9151fcb 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -4,6 +4,9 @@
 */
 
 #include <linux/pm_runtime.h>
+
+#include <linux/iio/common/inv_sensors_timestamp.h>
+
 #include "inv_mpu_iio.h"
 
 static unsigned int inv_scan_query_mpu6050(struct iio_dev *indio_dev)
@@ -106,7 +109,8 @@ int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state *st, bool enable)
 	int ret;
 
 	if (enable) {
-		st->it_timestamp = 0;
+		/* reset timestamping */
+		inv_sensors_timestamp_reset(&st->timestamp);
 		/* reset FIFO */
 		d = st->chip_config.user_ctrl | INV_MPU6050_BIT_FIFO_RST;
 		ret = regmap_write(st->map, st->reg->user_ctrl, d);
-- 
2.53.0

