Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795712827;
	b=b6DtwX1kRspgj4YUI3QueKZ6LnC15tZgCwFyBnfLpa7jLhafvirMDQpnJtt54Qk/TAsz
	 /B+mlW2C2BNl5GwTANvmNjzcv9sAuUD9Wnr8DNR0SCimOjb2kPMSEfthpkuo/PsSxlV3m
	 Bm8DajPoMre6AeFwjoxaJzQBNltzIYJhZUaQbK1YLqHrHYTQ36KgzCi1B6uklBciOUnJ4
	 CoqKmNc/yhrZx0WW2FvoFksjMZCNL2CK1L8JM9e7iuj1xQX2nArFo9t4sUtDiMYiPLWBW
	 uytn+W4rhVzWZurDt8TKLNJ++PyBKw9aFtTK7ehkDo+X6G+z2xSMkEHMkcsyhKw7oxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795712827;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LEaKnwjQQrAnQdEm3JzolhjoXx9a42ufgGBWE1VrxMw=;
	b=fBiw+DYB1h412cufCCiHDOguAdfwP9ofzpq9fnKP0BpX+U7W8OEhyt8FJgt8f0E42hYC
	 DRQnR8YuwrNbGGPyPIA5tf1+WTJvJtByNTlPW8wi1a0WuWGyYqpbYH9rnzfZYf0iOzv+O
	 eRaespVH9VdfIvUM3zp7RImSI5OCrkMEtQbZ8kRJ9jOesqxGr1ImKvjvJiCcTNkAUGIEe
	 C8Rw1Pe2lwXmwRgEOlOsRjSefC4XkWs07MGkSyyl24i8EPwfbngEHUEFlHqyMV4YX88jr
	 0k+YOB1g+ef44QELHhYI2GC2aUuxk+P0dgJtBjTZu019dBQ9D/o5sy/gdYyv8sDNniw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZGAQKPW5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591BD606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZGAQKPW5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413DB1F000E6;
	Thu, 26 Nov 2026 17:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795712826;
	bh=LEaKnwjQQrAnQdEm3JzolhjoXx9a42ufgGBWE1VrxMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZGAQKPW5BZLB1R+nXnz88U9PZdyFu/hUSeel/fCkt197N5MU3bq6ddi9XNq/MqerZ
	 eRUeZirW9TDaV6ysc9uZTWOWK7xT3k1UYgG4ZhqIE+J9yGt199rB0Ec131f5Pagz6l
	 vrE+w2QxPorzeJPnGvtujKeVQPVu6JjvfErHUjULeFjyOBcDmp3blsdFbzB18rOuIx
	 ++Ovt8iMmyichje91QOwgHvLSOVeb4FTxycXOBDSioPYvVAS3d26TToUe6ZaATBoIq
	 j0F0sHw++oVG4rUPppoeZi2AtfvEt4hkZD8jBI536jeWk5zWplSpCCEcNcgmEFf9y3
	 lsRIEE5pDmBRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/5] iio: inv_sensors: convert to kernel types
Date: Thu, 26 Nov 2026 12:07:00 -0500
Message-ID: <20261126170626.2690323-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126170626.2690323-1-sashal@kernel.org>
References: <2026112538-browse-ascertain-b38c@gregkh>
 <20261126170626.2690323-1-sashal@kernel.org>
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

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

[ Upstream commit 1330597c7480611334977ff66878fd40b411fa41 ]

Convert standard types (u)intXX_t to kernel type u/sXX.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Stable-dep-of: 3785dffc7c68 ("iio: inv_sensors: prevent timestamps going back in time in transitions")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../inv_sensors/inv_sensors_timestamp.c       | 48 +++++++++----------
 .../linux/iio/common/inv_sensors_timestamp.h  | 34 ++++++-------
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index e0b10366ed2bf..ecfd54ffe7e92 100644
--- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
@@ -19,9 +19,9 @@
 	(((_val) * (1000 + (_jitter))) / 1000)
 
 /* Add a new value inside an accumulator and update the estimate value */
-static void inv_update_acc(struct inv_sensors_timestamp_acc *acc, uint32_t val)
+static void inv_update_acc(struct inv_sensors_timestamp_acc *acc, u32 val)
 {
-	uint64_t sum = 0;
+	u64 sum = 0;
 	size_t i;
 
 	acc->values[acc->idx++] = val;
@@ -58,9 +58,9 @@ void inv_sensors_timestamp_init(struct inv_sensors_timestamp *ts,
 EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_init, "IIO_INV_SENSORS_TIMESTAMP");
 
 int inv_sensors_timestamp_update_odr(struct inv_sensors_timestamp *ts,
-				     uint32_t period, bool fifo)
+				     u32 period, bool fifo)
 {
-	uint32_t mult;
+	u32 mult;
 
 	/* when FIFO is on, prevent odr change if one is already pending */
 	if (fifo && ts->new_mult != 0)
@@ -78,9 +78,9 @@ int inv_sensors_timestamp_update_odr(struct inv_sensors_timestamp *ts,
 }
 EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_update_odr, "IIO_INV_SENSORS_TIMESTAMP");
 
-static bool inv_validate_period(struct inv_sensors_timestamp *ts, uint32_t period)
+static bool inv_validate_period(struct inv_sensors_timestamp *ts, u32 period)
 {
-	uint32_t period_min, period_max;
+	u32 period_min, period_max;
 
 	/* check that period is acceptable */
 	period_min = ts->min_period * ts->mult;
@@ -92,9 +92,9 @@ static bool inv_validate_period(struct inv_sensors_timestamp *ts, uint32_t perio
 }
 
 static bool inv_update_chip_period(struct inv_sensors_timestamp *ts,
-				   uint32_t period)
+				   u32 period)
 {
-	uint32_t new_chip_period;
+	u32 new_chip_period;
 
 	if (!inv_validate_period(ts, period))
 		return false;
@@ -109,19 +109,19 @@ static bool inv_update_chip_period(struct inv_sensors_timestamp *ts,
 
 static void inv_align_timestamp_it(struct inv_sensors_timestamp *ts)
 {
-	const int64_t period_min = (int64_t)ts->min_period * ts->mult;
-	const int64_t period_max = (int64_t)ts->max_period * ts->mult;
-	int64_t add_max, sub_max;
-	int64_t delta, jitter;
-	int64_t adjust;
+	const s64 period_min = (s64)ts->min_period * ts->mult;
+	const s64 period_max = (s64)ts->max_period * ts->mult;
+	s64 add_max, sub_max;
+	s64 delta, jitter;
+	s64 adjust;
 
 	/* delta time between last sample and last interrupt */
 	delta = ts->it.lo - ts->timestamp;
 
 	/* adjust timestamp while respecting jitter */
-	add_max = period_max - (int64_t)ts->period;
-	sub_max = period_min - (int64_t)ts->period;
-	jitter = INV_SENSORS_TIMESTAMP_JITTER((int64_t)ts->period, ts->chip.jitter);
+	add_max = period_max - (s64)ts->period;
+	sub_max = period_min - (s64)ts->period;
+	jitter = INV_SENSORS_TIMESTAMP_JITTER((s64)ts->period, ts->chip.jitter);
 	if (delta > jitter)
 		adjust = add_max;
 	else if (delta < -jitter)
@@ -133,11 +133,11 @@ static void inv_align_timestamp_it(struct inv_sensors_timestamp *ts)
 }
 
 void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
-				     size_t sample_nb, int64_t timestamp)
+				     size_t sample_nb, s64 timestamp)
 {
 	struct inv_sensors_timestamp_interval *it;
-	int64_t delta, interval;
-	uint32_t period;
+	s64 delta, interval;
+	u32 period;
 	bool valid = false;
 
 	if (sample_nb == 0)
@@ -157,7 +157,7 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
 	/* no previous data, compute theoretical value from interrupt */
 	if (ts->timestamp == 0) {
 		/* elapsed time: sensor period * sensor samples number */
-		interval = (int64_t)ts->period * (int64_t)sample_nb;
+		interval = (s64)ts->period * (s64)sample_nb;
 		ts->timestamp = it->up - interval;
 		return;
 	}
@@ -169,11 +169,11 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
 EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_interrupt, "IIO_INV_SENSORS_TIMESTAMP");
 
 void inv_sensors_timestamp_apply_odr(struct inv_sensors_timestamp *ts,
-				     uint32_t fifo_period, size_t fifo_nb,
+				     u32 fifo_period, size_t fifo_nb,
 				     unsigned int fifo_no)
 {
-	int64_t interval;
-	uint32_t fifo_mult;
+	s64 interval;
+	u32 fifo_mult;
 
 	if (ts->new_mult == 0)
 		return;
@@ -194,7 +194,7 @@ void inv_sensors_timestamp_apply_odr(struct inv_sensors_timestamp *ts,
 		fifo_mult = fifo_period / ts->chip.clock_period;
 		fifo_period = fifo_mult * ts->chip_period.val;
 		/* computes time interval between interrupt and this sample */
-		interval = (int64_t)(fifo_nb - fifo_no) * (int64_t)fifo_period;
+		interval = (s64)(fifo_nb - fifo_no) * (s64)fifo_period;
 		ts->timestamp = ts->it.up - interval;
 	}
 }
diff --git a/include/linux/iio/common/inv_sensors_timestamp.h b/include/linux/iio/common/inv_sensors_timestamp.h
index 8d506f1e9df29..e4e720e6f4b72 100644
--- a/include/linux/iio/common/inv_sensors_timestamp.h
+++ b/include/linux/iio/common/inv_sensors_timestamp.h
@@ -13,9 +13,9 @@
  * @init_period:	chip initial period at reset in ns
  */
 struct inv_sensors_timestamp_chip {
-	uint32_t clock_period;
-	uint32_t jitter;
-	uint32_t init_period;
+	u32 clock_period;
+	u32 jitter;
+	u32 init_period;
 };
 
 /**
@@ -24,8 +24,8 @@ struct inv_sensors_timestamp_chip {
  * @up:	interval upper bound
  */
 struct inv_sensors_timestamp_interval {
-	int64_t lo;
-	int64_t up;
+	s64 lo;
+	s64 up;
 };
 
 /**
@@ -35,9 +35,9 @@ struct inv_sensors_timestamp_interval {
  * @values:	table of all measured values, use for computing the mean
  */
 struct inv_sensors_timestamp_acc {
-	uint32_t val;
+	u32 val;
 	size_t idx;
-	uint32_t values[32];
+	u32 values[32];
 };
 
 /**
@@ -54,13 +54,13 @@ struct inv_sensors_timestamp_acc {
  */
 struct inv_sensors_timestamp {
 	struct inv_sensors_timestamp_chip chip;
-	uint32_t min_period;
-	uint32_t max_period;
+	u32 min_period;
+	u32 max_period;
 	struct inv_sensors_timestamp_interval it;
-	int64_t timestamp;
-	uint32_t mult;
-	uint32_t new_mult;
-	uint32_t period;
+	s64 timestamp;
+	u32 mult;
+	u32 new_mult;
+	u32 period;
 	struct inv_sensors_timestamp_acc chip_period;
 };
 
@@ -68,19 +68,19 @@ void inv_sensors_timestamp_init(struct inv_sensors_timestamp *ts,
 				const struct inv_sensors_timestamp_chip *chip);
 
 int inv_sensors_timestamp_update_odr(struct inv_sensors_timestamp *ts,
-				     uint32_t period, bool fifo);
+				     u32 period, bool fifo);
 
 void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
-				     size_t sample_nb, int64_t timestamp);
+				     size_t sample_nb, s64 timestamp);
 
-static inline int64_t inv_sensors_timestamp_pop(struct inv_sensors_timestamp *ts)
+static inline s64 inv_sensors_timestamp_pop(struct inv_sensors_timestamp *ts)
 {
 	ts->timestamp += ts->period;
 	return ts->timestamp;
 }
 
 void inv_sensors_timestamp_apply_odr(struct inv_sensors_timestamp *ts,
-				     uint32_t fifo_period, size_t fifo_nb,
+				     u32 fifo_period, size_t fifo_nb,
 				     unsigned int fifo_no);
 
 static inline void inv_sensors_timestamp_reset(struct inv_sensors_timestamp *ts)
-- 
2.53.0

