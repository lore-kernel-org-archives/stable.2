Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2AD2FF65F
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 03:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783998291; cv=none; b=JJuqf3WD/kLO7yl2J/Xq/WW4yv1y5XQK5ez/eQ17cMfcSLYbYw2PWOWKbB+dKoMHi4+Yjh7NTyZdRnhSKLMfC0mYuOlMAozDC4wX83P/Fcp/WCXIXothGD2ffDN7fyMHXLxusgJzi8Aq/SE7gonNXeVRUEmTWeOzABI4eypQvwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783998291; c=relaxed/simple;
	bh=qrfyElRd12p3FtuFpJrXSJyAVkLBStHS8LTDJ1cDxR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwjOT2QqP4Lh/GaZtJfGf6MQUy6yrNttAJx7YFlab/2ljKYcTLGWrmxq5+kHCViYUvN7N8k2apkqVp19ydPHTn9Upt+hPXrcaS7wdyWqvYccmE751YTUU4md2SORMDsy+2ZIhkx2nqE3q5qahBs0bV82s3g39/qRhWrXPrDlD2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7gmbAEx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7gmbAEx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1510C1F00A3A;
	Tue, 14 Jul 2026 03:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783998288;
	bh=optrier/YwEcHX8KLcF5oGRYEvvKo3S3PiGFNuAit9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F7gmbAExTR5fe5YZ3pvO0hqeVdCOAJWHT0HymdTP7UXxv8NzdIo+Iq9KriTn34UGk
	 4AY/BCCYBda6Z959jW8ja3TE69S7EVPRj+b5QIwGFAx7+yUksaencDJhJ1fnJOJNi1
	 wVMsgTUsWmTlKuYYEHWqREagVndWgeWqSwrsrX9wJtHKaj3U74lG9yEGtN+99mos9s
	 k7dU5UrGYal4yTD04wqlkZHGlYxjdV8eSlmILSsT5LfoEoI4H70kAbY2OixiW/itba
	 SFshJ1+QIj9K6nVB6HMWf6YO0CLKHzLe7tAgvKOVq8yycgAPbzVnIjZM6dgchSMe+g
	 uffXSzkTqvFXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/8] iio: make invensense timestamp module generic
Date: Mon, 13 Jul 2026 23:04:39 -0400
Message-ID: <20260714030444.2382550-3-sashal@kernel.org>
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

[ Upstream commit 0ecc363ccea71eda6a2cceade120489259bcdb33 ]

Rename common module to inv_sensors_timestamp, add configuration
at init (chip internal clock, acceptable jitter, ...) and update
inv_icm42600 driver integration.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/20230606162147.79667-4-inv.git-commit@tdk.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: affe3f077d7a ("iio: imu: inv_icm42600: fix timestamping by limiting FIFO reading")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/common/inv_sensors/Makefile       |  2 +-
 ...00_timestamp.c => inv_sensors_timestamp.c} | 83 ++++++++--------
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 32 ++++---
 .../imu/inv_icm42600/inv_icm42600_buffer.c    | 34 +++----
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 10 +-
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 32 ++++---
 .../linux/iio/common/inv_icm42600_timestamp.h | 79 ---------------
 .../linux/iio/common/inv_sensors_timestamp.h  | 95 +++++++++++++++++++
 8 files changed, 199 insertions(+), 168 deletions(-)
 rename drivers/iio/common/inv_sensors/{inv_icm42600_timestamp.c => inv_sensors_timestamp.c} (61%)
 delete mode 100644 include/linux/iio/common/inv_icm42600_timestamp.h
 create mode 100644 include/linux/iio/common/inv_sensors_timestamp.h

diff --git a/drivers/iio/common/inv_sensors/Makefile b/drivers/iio/common/inv_sensors/Makefile
index 93bddb9356b833..dcf39f249112c4 100644
--- a/drivers/iio/common/inv_sensors/Makefile
+++ b/drivers/iio/common/inv_sensors/Makefile
@@ -3,4 +3,4 @@
 # Makefile for TDK-InvenSense sensors module.
 #
 
-obj-$(CONFIG_IIO_INV_SENSORS_TIMESTAMP) += inv_icm42600_timestamp.o
+obj-$(CONFIG_IIO_INV_SENSORS_TIMESTAMP) += inv_sensors_timestamp.o
diff --git a/drivers/iio/common/inv_sensors/inv_icm42600_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
similarity index 61%
rename from drivers/iio/common/inv_sensors/inv_icm42600_timestamp.c
rename to drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index f1a144fbd9b096..033d3788dcf73b 100644
--- a/drivers/iio/common/inv_sensors/inv_icm42600_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
@@ -8,20 +8,18 @@
 #include <linux/math64.h>
 #include <linux/module.h>
 
-#include <linux/iio/common/inv_icm42600_timestamp.h>
-
-/* internal chip period is 32kHz, 31250ns */
-#define INV_ICM42600_TIMESTAMP_PERIOD		31250
-/* allow a jitter of +/- 2% */
-#define INV_ICM42600_TIMESTAMP_JITTER		2
-/* compute min and max periods accepted */
-#define INV_ICM42600_TIMESTAMP_MIN_PERIOD(_p)		\
-	(((_p) * (100 - INV_ICM42600_TIMESTAMP_JITTER)) / 100)
-#define INV_ICM42600_TIMESTAMP_MAX_PERIOD(_p)		\
-	(((_p) * (100 + INV_ICM42600_TIMESTAMP_JITTER)) / 100)
+#include <linux/iio/common/inv_sensors_timestamp.h>
+
+/* compute jitter, min and max following jitter in per mille */
+#define INV_SENSORS_TIMESTAMP_JITTER(_val, _jitter)		\
+	(div_s64((_val) * (_jitter), 1000))
+#define INV_SENSORS_TIMESTAMP_MIN(_val, _jitter)		\
+	(((_val) * (1000 - (_jitter))) / 1000)
+#define INV_SENSORS_TIMESTAMP_MAX(_val, _jitter)		\
+	(((_val) * (1000 + (_jitter))) / 1000)
 
 /* Add a new value inside an accumulator and update the estimate value */
-static void inv_update_acc(struct inv_icm42600_timestamp_acc *acc, uint32_t val)
+static void inv_update_acc(struct inv_sensors_timestamp_acc *acc, uint32_t val)
 {
 	uint64_t sum = 0;
 	size_t i;
@@ -40,56 +38,57 @@ static void inv_update_acc(struct inv_icm42600_timestamp_acc *acc, uint32_t val)
 	acc->val = div_u64(sum, i);
 }
 
-void inv_icm42600_timestamp_init(struct inv_icm42600_timestamp *ts,
-				 uint32_t period)
+void inv_sensors_timestamp_init(struct inv_sensors_timestamp *ts,
+				const struct inv_sensors_timestamp_chip *chip)
 {
-	/* initial odr for sensor after reset is 1kHz */
-	const uint32_t default_period = 1000000;
+	memset(ts, 0, sizeof(*ts));
+
+	/* save chip parameters and compute min and max clock period */
+	ts->chip = *chip;
+	ts->min_period = INV_SENSORS_TIMESTAMP_MIN(chip->clock_period, chip->jitter);
+	ts->max_period = INV_SENSORS_TIMESTAMP_MAX(chip->clock_period, chip->jitter);
 
 	/* current multiplier and period values after reset */
-	ts->mult = default_period / INV_ICM42600_TIMESTAMP_PERIOD;
-	ts->period = default_period;
-	/* new set multiplier is the one from chip initialization */
-	ts->new_mult = period / INV_ICM42600_TIMESTAMP_PERIOD;
+	ts->mult = chip->init_period / chip->clock_period;
+	ts->period = chip->init_period;
 
 	/* use theoretical value for chip period */
-	inv_update_acc(&ts->chip_period, INV_ICM42600_TIMESTAMP_PERIOD);
+	inv_update_acc(&ts->chip_period, chip->clock_period);
 }
-EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_init, IIO_INV_SENSORS_TIMESTAMP);
+EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_init, IIO_INV_SENSORS_TIMESTAMP);
 
-int inv_icm42600_timestamp_update_odr(struct inv_icm42600_timestamp *ts,
-				      uint32_t period, bool fifo)
+int inv_sensors_timestamp_update_odr(struct inv_sensors_timestamp *ts,
+				     uint32_t period, bool fifo)
 {
 	/* when FIFO is on, prevent odr change if one is already pending */
 	if (fifo && ts->new_mult != 0)
 		return -EAGAIN;
 
-	ts->new_mult = period / INV_ICM42600_TIMESTAMP_PERIOD;
+	ts->new_mult = period / ts->chip.clock_period;
 
 	return 0;
 }
-EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_update_odr, IIO_INV_SENSORS_TIMESTAMP);
+EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_update_odr, IIO_INV_SENSORS_TIMESTAMP);
 
-static bool inv_validate_period(uint32_t period, uint32_t mult)
+static bool inv_validate_period(struct inv_sensors_timestamp *ts, uint32_t period, uint32_t mult)
 {
-	const uint32_t chip_period = INV_ICM42600_TIMESTAMP_PERIOD;
 	uint32_t period_min, period_max;
 
 	/* check that period is acceptable */
-	period_min = INV_ICM42600_TIMESTAMP_MIN_PERIOD(chip_period) * mult;
-	period_max = INV_ICM42600_TIMESTAMP_MAX_PERIOD(chip_period) * mult;
+	period_min = ts->min_period * mult;
+	period_max = ts->max_period * mult;
 	if (period > period_min && period < period_max)
 		return true;
 	else
 		return false;
 }
 
-static bool inv_compute_chip_period(struct inv_icm42600_timestamp *ts,
+static bool inv_compute_chip_period(struct inv_sensors_timestamp *ts,
 				    uint32_t mult, uint32_t period)
 {
 	uint32_t new_chip_period;
 
-	if (!inv_validate_period(period, mult))
+	if (!inv_validate_period(ts, period, mult))
 		return false;
 
 	/* update chip internal period estimation */
@@ -99,13 +98,13 @@ static bool inv_compute_chip_period(struct inv_icm42600_timestamp *ts,
 	return true;
 }
 
-void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *ts,
+void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
 				      uint32_t fifo_period, size_t fifo_nb,
 				      size_t sensor_nb, int64_t timestamp)
 {
-	struct inv_icm42600_timestamp_interval *it;
+	struct inv_sensors_timestamp_interval *it;
 	int64_t delta, interval;
-	const uint32_t fifo_mult = fifo_period / INV_ICM42600_TIMESTAMP_PERIOD;
+	const uint32_t fifo_mult = fifo_period / ts->chip.clock_period;
 	uint32_t period = ts->period;
 	int32_t m;
 	bool valid = false;
@@ -145,7 +144,7 @@ void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *ts,
 		while (delta >= (fifo_period * 3 / 2))
 			delta -= fifo_period;
 		/* compute maximal adjustment value */
-		m = INV_ICM42600_TIMESTAMP_MAX_PERIOD(ts->period) - ts->period;
+		m = INV_SENSORS_TIMESTAMP_JITTER((int64_t)ts->period, ts->chip.jitter);
 		if (delta > m)
 			delta = m;
 		else if (delta < -m)
@@ -153,11 +152,11 @@ void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *ts,
 		ts->timestamp += delta;
 	}
 }
-EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_interrupt, IIO_INV_SENSORS_TIMESTAMP);
+EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_interrupt, IIO_INV_SENSORS_TIMESTAMP);
 
-void inv_icm42600_timestamp_apply_odr(struct inv_icm42600_timestamp *ts,
-				      uint32_t fifo_period, size_t fifo_nb,
-				      unsigned int fifo_no)
+void inv_sensors_timestamp_apply_odr(struct inv_sensors_timestamp *ts,
+				     uint32_t fifo_period, size_t fifo_nb,
+				     unsigned int fifo_no)
 {
 	int64_t interval;
 	uint32_t fifo_mult;
@@ -178,14 +177,14 @@ void inv_icm42600_timestamp_apply_odr(struct inv_icm42600_timestamp *ts,
 	 */
 	if (ts->timestamp != 0) {
 		/* compute measured fifo period */
-		fifo_mult = fifo_period / INV_ICM42600_TIMESTAMP_PERIOD;
+		fifo_mult = fifo_period / ts->chip.clock_period;
 		fifo_period = fifo_mult * ts->chip_period.val;
 		/* computes time interval between interrupt and this sample */
 		interval = (int64_t)(fifo_nb - fifo_no) * (int64_t)fifo_period;
 		ts->timestamp = ts->it.up - interval;
 	}
 }
-EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_apply_odr, IIO_INV_SENSORS_TIMESTAMP);
+EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_apply_odr, IIO_INV_SENSORS_TIMESTAMP);
 
 MODULE_AUTHOR("InvenSense, Inc.");
 MODULE_DESCRIPTION("InvenSense sensors timestamp module");
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 473d68b45935f6..d2aa1800669732 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -12,7 +12,7 @@
 #include <linux/math64.h>
 
 #include <linux/iio/buffer.h>
-#include <linux/iio/common/inv_icm42600_timestamp.h>
+#include <linux/iio/common/inv_sensors_timestamp.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 
@@ -99,7 +99,7 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 					       const unsigned long *scan_mask)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	unsigned int fifo_en = 0;
 	unsigned int sleep_temp = 0;
@@ -127,7 +127,7 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 	}
 
 	/* update data FIFO write */
-	inv_icm42600_timestamp_apply_odr(ts, 0, 0, 0);
+	inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
 	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
 
 out_unlock:
@@ -308,7 +308,7 @@ static int inv_icm42600_accel_write_odr(struct iio_dev *indio_dev,
 					int val, int val2)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int idx;
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
@@ -329,8 +329,8 @@ static int inv_icm42600_accel_write_odr(struct iio_dev *indio_dev,
 	pm_runtime_get_sync(dev);
 	mutex_lock(&st->lock);
 
-	ret = inv_icm42600_timestamp_update_odr(ts, inv_icm42600_odr_to_period(conf.odr),
-						iio_buffer_enabled(indio_dev));
+	ret = inv_sensors_timestamp_update_odr(ts, inv_icm42600_odr_to_period(conf.odr),
+					       iio_buffer_enabled(indio_dev));
 	if (ret)
 		goto out_unlock;
 
@@ -706,7 +706,8 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 {
 	struct device *dev = regmap_get_device(st->map);
 	const char *name;
-	struct inv_icm42600_timestamp *ts;
+	struct inv_sensors_timestamp_chip ts_chip;
+	struct inv_sensors_timestamp *ts;
 	struct iio_dev *indio_dev;
 	struct iio_buffer *buffer;
 	int ret;
@@ -723,8 +724,15 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 	if (!buffer)
 		return ERR_PTR(-ENOMEM);
 
+	/*
+	 * clock period is 32kHz (31250ns)
+	 * jitter is +/- 2% (20 per mille)
+	 */
+	ts_chip.clock_period = 31250;
+	ts_chip.jitter = 20;
+	ts_chip.init_period = inv_icm42600_odr_to_period(st->conf.accel.odr);
 	ts = iio_priv(indio_dev);
-	inv_icm42600_timestamp_init(ts, inv_icm42600_odr_to_period(st->conf.accel.odr));
+	inv_sensors_timestamp_init(ts, &ts_chip);
 
 	iio_device_set_drvdata(indio_dev, st);
 	indio_dev->name = name;
@@ -747,7 +755,7 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
 	ssize_t i, size;
 	unsigned int no;
 	const void *accel, *gyro, *timestamp;
@@ -771,13 +779,13 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 
 		/* update odr */
 		if (odr & INV_ICM42600_SENSOR_ACCEL)
-			inv_icm42600_timestamp_apply_odr(ts, st->fifo.period,
-							 st->fifo.nb.total, no);
+			inv_sensors_timestamp_apply_odr(ts, st->fifo.period,
+							st->fifo.nb.total, no);
 
 		memcpy(&buffer.accel, accel, sizeof(buffer.accel));
 		/* convert 8 bits FIFO temperature in high resolution format */
 		buffer.temp = temp ? (*temp * 64) : 0;
-		ts_val = inv_icm42600_timestamp_pop(ts);
+		ts_val = inv_sensors_timestamp_pop(ts);
 		iio_push_to_buffers_with_timestamp(indio_dev, &buffer, ts_val);
 	}
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index afaaa45477a967..24b43dc75f72a2 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -11,7 +11,7 @@
 #include <linux/delay.h>
 
 #include <linux/iio/buffer.h>
-#include <linux/iio/common/inv_icm42600_timestamp.h>
+#include <linux/iio/common/inv_sensors_timestamp.h>
 #include <linux/iio/iio.h>
 
 #include "inv_icm42600.h"
@@ -276,12 +276,12 @@ static int inv_icm42600_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
 	struct device *dev = regmap_get_device(st->map);
-	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
 
 	pm_runtime_get_sync(dev);
 
 	mutex_lock(&st->lock);
-	inv_icm42600_timestamp_reset(ts);
+	inv_sensors_timestamp_reset(ts);
 	mutex_unlock(&st->lock);
 
 	return 0;
@@ -378,7 +378,7 @@ static int inv_icm42600_buffer_predisable(struct iio_dev *indio_dev)
 static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int sensor;
 	unsigned int *watermark;
@@ -400,7 +400,7 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 
 	mutex_lock(&st->lock);
 
-	inv_icm42600_timestamp_apply_odr(ts, 0, 0, 0);
+	inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
 
 	ret = inv_icm42600_buffer_set_fifo_en(st, st->fifo.en & ~sensor);
 	if (ret)
@@ -508,7 +508,7 @@ int inv_icm42600_buffer_fifo_read(struct inv_icm42600_state *st,
 
 int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 {
-	struct inv_icm42600_timestamp *ts;
+	struct inv_sensors_timestamp *ts;
 	int ret;
 
 	if (st->fifo.nb.total == 0)
@@ -516,8 +516,8 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 
 	/* handle gyroscope timestamp and FIFO data parsing */
 	ts = iio_priv(st->indio_gyro);
-	inv_icm42600_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.total,
-					 st->fifo.nb.gyro, st->timestamp.gyro);
+	inv_sensors_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.total,
+					st->fifo.nb.gyro, st->timestamp.gyro);
 	if (st->fifo.nb.gyro > 0) {
 		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
 		if (ret)
@@ -526,8 +526,8 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 
 	/* handle accelerometer timestamp and FIFO data parsing */
 	ts = iio_priv(st->indio_accel);
-	inv_icm42600_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.total,
-					 st->fifo.nb.accel, st->timestamp.accel);
+	inv_sensors_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.total,
+					st->fifo.nb.accel, st->timestamp.accel);
 	if (st->fifo.nb.accel > 0) {
 		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
 		if (ret)
@@ -540,7 +540,7 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
 				     unsigned int count)
 {
-	struct inv_icm42600_timestamp *ts;
+	struct inv_sensors_timestamp *ts;
 	int64_t gyro_ts, accel_ts;
 	int ret;
 
@@ -556,9 +556,9 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
 
 	if (st->fifo.nb.gyro > 0) {
 		ts = iio_priv(st->indio_gyro);
-		inv_icm42600_timestamp_interrupt(ts, st->fifo.period,
-						 st->fifo.nb.total, st->fifo.nb.gyro,
-						 gyro_ts);
+		inv_sensors_timestamp_interrupt(ts, st->fifo.period,
+						st->fifo.nb.total, st->fifo.nb.gyro,
+						gyro_ts);
 		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
 		if (ret)
 			return ret;
@@ -566,9 +566,9 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
 
 	if (st->fifo.nb.accel > 0) {
 		ts = iio_priv(st->indio_accel);
-		inv_icm42600_timestamp_interrupt(ts, st->fifo.period,
-						 st->fifo.nb.total, st->fifo.nb.accel,
-						 accel_ts);
+		inv_sensors_timestamp_interrupt(ts, st->fifo.period,
+						st->fifo.nb.total, st->fifo.nb.accel,
+						accel_ts);
 		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
 		if (ret)
 			return ret;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 96777ca4176016..576e4736a90f95 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -16,7 +16,7 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 
-#include <linux/iio/common/inv_icm42600_timestamp.h>
+#include <linux/iio/common/inv_sensors_timestamp.h>
 #include <linux/iio/iio.h>
 
 #include "inv_icm42600.h"
@@ -720,8 +720,8 @@ static int __maybe_unused inv_icm42600_suspend(struct device *dev)
 static int __maybe_unused inv_icm42600_resume(struct device *dev)
 {
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
-	struct inv_icm42600_timestamp *gyro_ts = iio_priv(st->indio_gyro);
-	struct inv_icm42600_timestamp *accel_ts = iio_priv(st->indio_accel);
+	struct inv_sensors_timestamp *gyro_ts = iio_priv(st->indio_gyro);
+	struct inv_sensors_timestamp *accel_ts = iio_priv(st->indio_accel);
 	int ret = 0;
 
 	mutex_lock(&st->lock);
@@ -742,8 +742,8 @@ static int __maybe_unused inv_icm42600_resume(struct device *dev)
 
 	/* restore FIFO data streaming */
 	if (st->fifo.on) {
-		inv_icm42600_timestamp_reset(gyro_ts);
-		inv_icm42600_timestamp_reset(accel_ts);
+		inv_sensors_timestamp_reset(gyro_ts);
+		inv_sensors_timestamp_reset(accel_ts);
 		ret = regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
 				   INV_ICM42600_FIFO_CONFIG_STREAM);
 	}
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 1a019ebca4c791..62844ef1cf87b5 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -12,7 +12,7 @@
 #include <linux/math64.h>
 
 #include <linux/iio/buffer.h>
-#include <linux/iio/common/inv_icm42600_timestamp.h>
+#include <linux/iio/common/inv_sensors_timestamp.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 
@@ -99,7 +99,7 @@ static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
 					      const unsigned long *scan_mask)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	unsigned int fifo_en = 0;
 	unsigned int sleep_gyro = 0;
@@ -127,7 +127,7 @@ static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
 	}
 
 	/* update data FIFO write */
-	inv_icm42600_timestamp_apply_odr(ts, 0, 0, 0);
+	inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
 	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
 
 out_unlock:
@@ -320,7 +320,7 @@ static int inv_icm42600_gyro_write_odr(struct iio_dev *indio_dev,
 				       int val, int val2)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int idx;
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
@@ -341,8 +341,8 @@ static int inv_icm42600_gyro_write_odr(struct iio_dev *indio_dev,
 	pm_runtime_get_sync(dev);
 	mutex_lock(&st->lock);
 
-	ret = inv_icm42600_timestamp_update_odr(ts, inv_icm42600_odr_to_period(conf.odr),
-						iio_buffer_enabled(indio_dev));
+	ret = inv_sensors_timestamp_update_odr(ts, inv_icm42600_odr_to_period(conf.odr),
+					       iio_buffer_enabled(indio_dev));
 	if (ret)
 		goto out_unlock;
 
@@ -717,7 +717,8 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 {
 	struct device *dev = regmap_get_device(st->map);
 	const char *name;
-	struct inv_icm42600_timestamp *ts;
+	struct inv_sensors_timestamp_chip ts_chip;
+	struct inv_sensors_timestamp *ts;
 	struct iio_dev *indio_dev;
 	struct iio_buffer *buffer;
 	int ret;
@@ -734,8 +735,15 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 	if (!buffer)
 		return ERR_PTR(-ENOMEM);
 
+	/*
+	 * clock period is 32kHz (31250ns)
+	 * jitter is +/- 2% (20 per mille)
+	 */
+	ts_chip.clock_period = 31250;
+	ts_chip.jitter = 20;
+	ts_chip.init_period = inv_icm42600_odr_to_period(st->conf.accel.odr);
 	ts = iio_priv(indio_dev);
-	inv_icm42600_timestamp_init(ts, inv_icm42600_odr_to_period(st->conf.gyro.odr));
+	inv_sensors_timestamp_init(ts, &ts_chip);
 
 	iio_device_set_drvdata(indio_dev, st);
 	indio_dev->name = name;
@@ -758,7 +766,7 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
 	ssize_t i, size;
 	unsigned int no;
 	const void *accel, *gyro, *timestamp;
@@ -782,13 +790,13 @@ int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)
 
 		/* update odr */
 		if (odr & INV_ICM42600_SENSOR_GYRO)
-			inv_icm42600_timestamp_apply_odr(ts, st->fifo.period,
-							 st->fifo.nb.total, no);
+			inv_sensors_timestamp_apply_odr(ts, st->fifo.period,
+							st->fifo.nb.total, no);
 
 		memcpy(&buffer.gyro, gyro, sizeof(buffer.gyro));
 		/* convert 8 bits FIFO temperature in high resolution format */
 		buffer.temp = temp ? (*temp * 64) : 0;
-		ts_val = inv_icm42600_timestamp_pop(ts);
+		ts_val = inv_sensors_timestamp_pop(ts);
 		iio_push_to_buffers_with_timestamp(indio_dev, &buffer, ts_val);
 	}
 
diff --git a/include/linux/iio/common/inv_icm42600_timestamp.h b/include/linux/iio/common/inv_icm42600_timestamp.h
deleted file mode 100644
index b808a6da15e585..00000000000000
--- a/include/linux/iio/common/inv_icm42600_timestamp.h
+++ /dev/null
@@ -1,79 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2020 Invensense, Inc.
- */
-
-#ifndef INV_ICM42600_TIMESTAMP_H_
-#define INV_ICM42600_TIMESTAMP_H_
-
-/**
- * struct inv_icm42600_timestamp_interval - timestamps interval
- * @lo:	interval lower bound
- * @up:	interval upper bound
- */
-struct inv_icm42600_timestamp_interval {
-	int64_t lo;
-	int64_t up;
-};
-
-/**
- * struct inv_icm42600_timestamp_acc - accumulator for computing an estimation
- * @val:	current estimation of the value, the mean of all values
- * @idx:	current index of the next free place in values table
- * @values:	table of all measured values, use for computing the mean
- */
-struct inv_icm42600_timestamp_acc {
-	uint32_t val;
-	size_t idx;
-	uint32_t values[32];
-};
-
-/**
- * struct inv_icm42600_timestamp - timestamp management states
- * @it:			interrupts interval timestamps
- * @timestamp:		store last timestamp for computing next data timestamp
- * @mult:		current internal period multiplier
- * @new_mult:		new set internal period multiplier (not yet effective)
- * @period:		measured current period of the sensor
- * @chip_period:	accumulator for computing internal chip period
- */
-struct inv_icm42600_timestamp {
-	struct inv_icm42600_timestamp_interval it;
-	int64_t timestamp;
-	uint32_t mult;
-	uint32_t new_mult;
-	uint32_t period;
-	struct inv_icm42600_timestamp_acc chip_period;
-};
-
-void inv_icm42600_timestamp_init(struct inv_icm42600_timestamp *ts,
-				 uint32_t period);
-
-int inv_icm42600_timestamp_update_odr(struct inv_icm42600_timestamp *ts,
-				      uint32_t period, bool fifo);
-
-void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *ts,
-				      uint32_t fifo_period, size_t fifo_nb,
-				      size_t sensor_nb, int64_t timestamp);
-
-static inline int64_t
-inv_icm42600_timestamp_pop(struct inv_icm42600_timestamp *ts)
-{
-	ts->timestamp += ts->period;
-	return ts->timestamp;
-}
-
-void inv_icm42600_timestamp_apply_odr(struct inv_icm42600_timestamp *ts,
-				      uint32_t fifo_period, size_t fifo_nb,
-				      unsigned int fifo_no);
-
-static inline void
-inv_icm42600_timestamp_reset(struct inv_icm42600_timestamp *ts)
-{
-	const struct inv_icm42600_timestamp_interval interval_init = {0LL, 0LL};
-
-	ts->it = interval_init;
-	ts->timestamp = 0;
-}
-
-#endif
diff --git a/include/linux/iio/common/inv_sensors_timestamp.h b/include/linux/iio/common/inv_sensors_timestamp.h
new file mode 100644
index 00000000000000..a47d304d1ba7c4
--- /dev/null
+++ b/include/linux/iio/common/inv_sensors_timestamp.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2020 Invensense, Inc.
+ */
+
+#ifndef INV_SENSORS_TIMESTAMP_H_
+#define INV_SENSORS_TIMESTAMP_H_
+
+/**
+ * struct inv_sensors_timestamp_chip - chip internal properties
+ * @clock_period:	internal clock period in ns
+ * @jitter:		acceptable jitter in per-mille
+ * @init_period:	chip initial period at reset in ns
+ */
+struct inv_sensors_timestamp_chip {
+	uint32_t clock_period;
+	uint32_t jitter;
+	uint32_t init_period;
+};
+
+/**
+ * struct inv_sensors_timestamp_interval - timestamps interval
+ * @lo:	interval lower bound
+ * @up:	interval upper bound
+ */
+struct inv_sensors_timestamp_interval {
+	int64_t lo;
+	int64_t up;
+};
+
+/**
+ * struct inv_sensors_timestamp_acc - accumulator for computing an estimation
+ * @val:	current estimation of the value, the mean of all values
+ * @idx:	current index of the next free place in values table
+ * @values:	table of all measured values, use for computing the mean
+ */
+struct inv_sensors_timestamp_acc {
+	uint32_t val;
+	size_t idx;
+	uint32_t values[32];
+};
+
+/**
+ * struct inv_sensors_timestamp - timestamp management states
+ * @chip:		chip internal characteristics
+ * @min_period:		minimal acceptable clock period
+ * @max_period:		maximal acceptable clock period
+ * @it:			interrupts interval timestamps
+ * @timestamp:		store last timestamp for computing next data timestamp
+ * @mult:		current internal period multiplier
+ * @new_mult:		new set internal period multiplier (not yet effective)
+ * @period:		measured current period of the sensor
+ * @chip_period:	accumulator for computing internal chip period
+ */
+struct inv_sensors_timestamp {
+	struct inv_sensors_timestamp_chip chip;
+	uint32_t min_period;
+	uint32_t max_period;
+	struct inv_sensors_timestamp_interval it;
+	int64_t timestamp;
+	uint32_t mult;
+	uint32_t new_mult;
+	uint32_t period;
+	struct inv_sensors_timestamp_acc chip_period;
+};
+
+void inv_sensors_timestamp_init(struct inv_sensors_timestamp *ts,
+				const struct inv_sensors_timestamp_chip *chip);
+
+int inv_sensors_timestamp_update_odr(struct inv_sensors_timestamp *ts,
+				     uint32_t period, bool fifo);
+
+void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
+				     uint32_t fifo_period, size_t fifo_nb,
+				     size_t sensor_nb, int64_t timestamp);
+
+static inline int64_t inv_sensors_timestamp_pop(struct inv_sensors_timestamp *ts)
+{
+	ts->timestamp += ts->period;
+	return ts->timestamp;
+}
+
+void inv_sensors_timestamp_apply_odr(struct inv_sensors_timestamp *ts,
+				     uint32_t fifo_period, size_t fifo_nb,
+				     unsigned int fifo_no);
+
+static inline void inv_sensors_timestamp_reset(struct inv_sensors_timestamp *ts)
+{
+	const struct inv_sensors_timestamp_interval interval_init = {0LL, 0LL};
+
+	ts->it = interval_init;
+	ts->timestamp = 0;
+}
+
+#endif
-- 
2.53.0

