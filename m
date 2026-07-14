Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0023559C9
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 01:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783991796; cv=none; b=M6KtZdOncH6pplX/bg3eo/c1o3hfTCMEaTFtMUJ0LrhmGg9RusCMzMRq3pZpFZ6yBxxefHtAsIVQATSmaZQ+hiT+uQNLwVz97u6iyM7+WEX9AGNyzJxr6D7D44QOweKG8XLgY5oYf3502RNTl1fjaO9a9pOKvsQjZzd+K00GdwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783991796; c=relaxed/simple;
	bh=kUI91N9gZuZolNPckWq1vC52ozfd3rjDGKITszkNZgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctOkvnQA+4y+gyZGhinQ1U8imHOq/V97ew7U+ziubP4ox7goMVZXPHhGHTAGgTKLRtuBj75nCx/OlF05S7dSpbXJUZJcTcU+1iBeceGpEke5RusQa3bZb7pZRx/DAezRow5TTdOSdh8JJi9FDU2rmVXfsvZwUCOs7LLTMjU+5cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9aGc9g0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9aGc9g0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE59A1F00AC4;
	Tue, 14 Jul 2026 01:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783991794;
	bh=1wRQ4CeMwPep9uoUigCebihX0N5fify4HwTYUXrLNiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L9aGc9g0WtlA487MlP97v5gMltew9Xz4gd2sogOWN31dHlsulMw/cAVBeiWPWHLpl
	 LuJ97LWhTGdr+KFpL4iLw0pNZHs6anGFv+1UUMYWZm17TawEN+pvQqwGeUpcTWdFcx
	 WsAqkEkDtvZZ+iHNT/QV09Perf6bWDjljogumMK7GDTz8ZRQCNsXXgT2KGzpTVOeri
	 EhiYMEwjLJX2oEednWcawZeAWi6DmoChP/BwXEzewL2hVBi6pBE/q/R8EeT0qI5FAB
	 sdPaHrHzDKmfhfRAKSxNsriNEuecvcBDuLYQ8nT0Y57Ty1H+nIlXx81eQDLMuD4MXn
	 QYV0CA7XN5UqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 6/8] iio: invensense: fix timestamp glitches when switching frequency
Date: Mon, 13 Jul 2026 21:16:25 -0400
Message-ID: <20260714011627.2188779-6-sashal@kernel.org>
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

[ Upstream commit bf8367b00c33c64a9391c262bb2e11d274c9f2a4 ]

When a sensor is running and there is a FIFO frequency change due to
another sensor turned on/off, there are glitches on timestamp. Fix that
by using only interrupt timestamp when there is the corresponding sensor
data in the FIFO.

Delete FIFO period handling and simplify internal functions.

Update integration inside inv_mpu6050 and inv_icm42600 drivers.

Fixes: 0ecc363ccea7 ("iio: make invensense timestamp module generic")
Cc: Stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Link: https://lore.kernel.org/r/20240426094835.138389-1-inv.git-commit@tdk.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: affe3f077d7a ("iio: imu: inv_icm42600: fix timestamping by limiting FIFO reading")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../inv_sensors/inv_sensors_timestamp.c       | 30 ++++++++-----------
 .../imu/inv_icm42600/inv_icm42600_buffer.c    | 20 +++++--------
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  2 +-
 .../linux/iio/common/inv_sensors_timestamp.h  |  3 +-
 4 files changed, 23 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index 77ab578ee1698d..d904fdd67d38ef 100644
--- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
@@ -70,13 +70,13 @@ int inv_sensors_timestamp_update_odr(struct inv_sensors_timestamp *ts,
 }
 EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_update_odr, IIO_INV_SENSORS_TIMESTAMP);
 
-static bool inv_validate_period(struct inv_sensors_timestamp *ts, uint32_t period, uint32_t mult)
+static bool inv_validate_period(struct inv_sensors_timestamp *ts, uint32_t period)
 {
 	uint32_t period_min, period_max;
 
 	/* check that period is acceptable */
-	period_min = ts->min_period * mult;
-	period_max = ts->max_period * mult;
+	period_min = ts->min_period * ts->mult;
+	period_max = ts->max_period * ts->mult;
 	if (period > period_min && period < period_max)
 		return true;
 	else
@@ -84,32 +84,30 @@ static bool inv_validate_period(struct inv_sensors_timestamp *ts, uint32_t perio
 }
 
 static bool inv_compute_chip_period(struct inv_sensors_timestamp *ts,
-				    uint32_t mult, uint32_t period)
+				    uint32_t period)
 {
 	uint32_t new_chip_period;
 
-	if (!inv_validate_period(ts, period, mult))
+	if (!inv_validate_period(ts, period))
 		return false;
 
 	/* update chip internal period estimation */
-	new_chip_period = period / mult;
+	new_chip_period = period / ts->mult;
 	inv_update_acc(&ts->chip_period, new_chip_period);
 
 	return true;
 }
 
 void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
-				      uint32_t fifo_period, size_t fifo_nb,
-				      size_t sensor_nb, int64_t timestamp)
+				     size_t sample_nb, int64_t timestamp)
 {
 	struct inv_sensors_timestamp_interval *it;
 	int64_t delta, interval;
-	const uint32_t fifo_mult = fifo_period / ts->chip.clock_period;
 	uint32_t period;
 	int32_t m;
 	bool valid = false;
 
-	if (fifo_nb == 0)
+	if (sample_nb == 0)
 		return;
 
 	/* update interrupt timestamp and compute chip and sensor periods */
@@ -119,8 +117,8 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
 	delta = it->up - it->lo;
 	if (it->lo != 0) {
 		/* compute period: delta time divided by number of samples */
-		period = div_s64(delta, fifo_nb);
-		valid = inv_compute_chip_period(ts, fifo_mult, period);
+		period = div_s64(delta, sample_nb);
+		valid = inv_compute_chip_period(ts, period);
 		/* update sensor period if chip internal period is updated */
 		if (valid)
 			ts->period = ts->mult * ts->chip_period.val;
@@ -129,20 +127,18 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
 	/* no previous data, compute theoritical value from interrupt */
 	if (ts->timestamp == 0) {
 		/* elapsed time: sensor period * sensor samples number */
-		interval = (int64_t)ts->period * (int64_t)sensor_nb;
+		interval = (int64_t)ts->period * (int64_t)sample_nb;
 		ts->timestamp = it->up - interval;
 		return;
 	}
 
 	/* if interrupt interval is valid, sync with interrupt timestamp */
 	if (valid) {
-		/* compute measured fifo_period */
-		fifo_period = fifo_mult * ts->chip_period.val;
 		/* delta time between last sample and last interrupt */
 		delta = it->lo - ts->timestamp;
 		/* if there are multiple samples, go back to first one */
-		while (delta >= (fifo_period * 3 / 2))
-			delta -= fifo_period;
+		while (delta >= (ts->period * 3 / 2))
+			delta -= ts->period;
 		/* compute maximal adjustment value */
 		m = INV_SENSORS_TIMESTAMP_JITTER((int64_t)ts->period, ts->chip.jitter);
 		if (delta > m)
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 24b43dc75f72a2..e0e159e5de74af 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -515,20 +515,20 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 		return 0;
 
 	/* handle gyroscope timestamp and FIFO data parsing */
-	ts = iio_priv(st->indio_gyro);
-	inv_sensors_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.total,
-					st->fifo.nb.gyro, st->timestamp.gyro);
 	if (st->fifo.nb.gyro > 0) {
+		ts = iio_priv(st->indio_gyro);
+		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro,
+						st->timestamp.gyro);
 		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
 		if (ret)
 			return ret;
 	}
 
 	/* handle accelerometer timestamp and FIFO data parsing */
-	ts = iio_priv(st->indio_accel);
-	inv_sensors_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.total,
-					st->fifo.nb.accel, st->timestamp.accel);
 	if (st->fifo.nb.accel > 0) {
+		ts = iio_priv(st->indio_accel);
+		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel,
+						st->timestamp.accel);
 		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
 		if (ret)
 			return ret;
@@ -556,9 +556,7 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
 
 	if (st->fifo.nb.gyro > 0) {
 		ts = iio_priv(st->indio_gyro);
-		inv_sensors_timestamp_interrupt(ts, st->fifo.period,
-						st->fifo.nb.total, st->fifo.nb.gyro,
-						gyro_ts);
+		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro, gyro_ts);
 		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
 		if (ret)
 			return ret;
@@ -566,9 +564,7 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
 
 	if (st->fifo.nb.accel > 0) {
 		ts = iio_priv(st->indio_accel);
-		inv_sensors_timestamp_interrupt(ts, st->fifo.period,
-						st->fifo.nb.total, st->fifo.nb.accel,
-						accel_ts);
+		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel, accel_ts);
 		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
 		if (ret)
 			return ret;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index d83f61a9950494..41e978773b0982 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -109,7 +109,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	nb = fifo_count / bytes_per_datum;
 	/* Each FIFO data contains all sensors, so same number for FIFO and sensor data */
 	fifo_period = NSEC_PER_SEC / INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
-	inv_sensors_timestamp_interrupt(&st->timestamp, fifo_period, nb, nb, pf->timestamp);
+	inv_sensors_timestamp_interrupt(&st->timestamp, nb, pf->timestamp);
 	inv_sensors_timestamp_apply_odr(&st->timestamp, fifo_period, nb, 0);
 	for (i = 0; i < nb; ++i) {
 		result = regmap_noinc_read(st->map, st->reg->fifo_r_w,
diff --git a/include/linux/iio/common/inv_sensors_timestamp.h b/include/linux/iio/common/inv_sensors_timestamp.h
index a47d304d1ba7c4..8d506f1e9df292 100644
--- a/include/linux/iio/common/inv_sensors_timestamp.h
+++ b/include/linux/iio/common/inv_sensors_timestamp.h
@@ -71,8 +71,7 @@ int inv_sensors_timestamp_update_odr(struct inv_sensors_timestamp *ts,
 				     uint32_t period, bool fifo);
 
 void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
-				     uint32_t fifo_period, size_t fifo_nb,
-				     size_t sensor_nb, int64_t timestamp);
+				     size_t sample_nb, int64_t timestamp);
 
 static inline int64_t inv_sensors_timestamp_pop(struct inv_sensors_timestamp *ts)
 {
-- 
2.53.0

