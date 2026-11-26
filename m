Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795714196;
	b=L2qyhuPJ3iJIkR5OPM3Y5TOTVyd62WmTFSWKE7uaBQb6ztxM8ZUiqKZxzv4d7MzcJ8b/
	 6S2l4p9fTVkNlOZKCer5zYyw6FNDQYl42AS7RsPMKufWJ65CLJW5ZwmL8qB7mW6dUrXIB
	 BGoG+bYF/VRslRt+CUQXd2AtT8VlZX2CV3XJMCNNYJvtUDA4CdCN9xWhiPAn/hbAWYgRy
	 wyaQ8/ewLQlD223gUUMofhvlpZK/EBKDtpYpnC4hR9sIBVlciuTqkr0SisMwR4ypVza2c
	 67wI/EhkcT9x99GpE4Z2UXcrnLCgY9CQ5b+yZmXUuQYdzB7O8nqkh+WVrZbdgU08IzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795714196;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YZPZBWVWOSEodS6UorajtVzSytMqlv6Bhq5+mczWxag=;
	b=XUoqrvhVFsWhEMgXjfbBr1BaTh2bsdsEGL4icBKn37pjbbM/YIBRT5AsyaFimb8W3rzP
	 fc70yHFLbL0QUsQ65EdBdPXcP7LZUc9zUdYA9/ILQlXoyfM/l7BGfLYLfbeL7LTCU0CSw
	 Z4QlPqapjD03au5kzEC+sqdybzo/LwDxtuZ8b5gKgrXtHc4dmlajjhlJlDoXYX2Ywj7D7
	 7XS2CyeGZj/0Zl4y4/4lkCczoSRNDEh14260dqLTBRJ9PvJ8GyLLeufIlShngozqv+4Zu
	 v0dm7xaARWl9ls05Ca0e4Bm1/sxWkngug9NGemaQJ9ke16UyjuMLV49emlWGVc+AiEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I2+PpSeE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1BE606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I2+PpSeE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44F91F000CA;
	Thu, 26 Nov 2026 17:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795714196;
	bh=YZPZBWVWOSEodS6UorajtVzSytMqlv6Bhq5+mczWxag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I2+PpSeEjUWcehp8m7+KfucJ1SuIkXvdif7pPKklY1C8GWF8WxMmdeFL6FzSLEE8M
	 r/AaMX0KhXMP7SfV5QIjODV9G3K8BflmNkeMd2EfENucsOLPgZhCsfZK16oDOi31lg
	 0YaPJcrDmPtD9aU8IHR79xQamzi/QJ0kt3sv9s6ATkPiTZQcJK30n5u5yBo+zDiiAA
	 GUcES1DcrxkBLon6cIbfyofy5o+hj5oa5EucZ2+7QuY+PpHMkQioZXHIwx2mnP4zx5
	 0ERgJwBCORl8LHPY6+Ro6KKrWnlGZQjspeAZTWQF3wENzvDZDZ2Wr6TKRNAH81VL/v
	 6nZ/xeLGZv0pw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/6] iio: inv_sensors: convert to kernel types
Date: Thu, 26 Nov 2026 12:29:50 -0500
Message-ID: <20261126172925.2769957-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126172925.2769957-1-sashal@kernel.org>
References: <2026112539-smugly-stole-0816@gregkh>
 <20261126172925.2769957-1-sashal@kernel.org>
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
index 883cb08806be8..2fdb4cea8a54f 100644
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
 EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_init, IIO_INV_SENSORS_TIMESTAMP);
 
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
 EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_update_odr, IIO_INV_SENSORS_TIMESTAMP);
 
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
 EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_interrupt, IIO_INV_SENSORS_TIMESTAMP);
 
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

