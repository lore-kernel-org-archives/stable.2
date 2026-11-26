Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713627;
	b=Aob0rqo5BBpHxUqD1/TFpF7EiU81rSHhVf+d73iI35zuDjH2IYnlVo+GSuOYd0vGkGUP
	 nMU5FymSxum41aKhZZX/HxiR7kKAWrSLPDkmh2oeJ9pKTalyTitiy5k5KQZJiB/qmHxsI
	 otnzHG4VJKx0SsTVFEUgkg+7qSfaJE+4QF3eFaRX14g40S2mvT6fkcFFitRffAieGFe/8
	 tSEqNA2e/vfbdSvBBEZ0xjfwVjpTmYlNocLDEN+ccs6th+Yf99kuTJ1HoaohtWrskZ+3j
	 nerbMlTpfonK8Ckqv9gnWgqXL6sm6tD8S/L0dDluPt6KNlPBaaFyzyo81YA1g2t1F+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713627;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YZPZBWVWOSEodS6UorajtVzSytMqlv6Bhq5+mczWxag=;
	b=WXvzS7yPJIvxiE2GNYurdUQXKKYC0k7iNkEjxXctNDr5ieoooi6lUTIMh2h6B4J7IrIR
	 psdkeK2cn+rLrCZ9PQ0GHlfFxKCoouFSI6ErBwpD+DiN0eX8kX6fah+dh4cHgcBtNbEkc
	 /JkbMr0tCUA9rTbxNcSEfmxd8rommjC7JEsFS0x2xwfUwEkNCs1k94IEQItvh2DTKZN59
	 zxjobuPVlFmINxrwMfAjWVZ2ZAFi8tpLBT71GYnr1qrtxfZ2vhuOQDQwz5lP9myeCEJVK
	 dpNVl4taOxxP5C6tXJqurQbXLuYXg90vI6A79r3IgtQAbk6gbXAEjjEYSdRl07LRKFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PUqFsivH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6660606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PUqFsivH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88951F000D1;
	Thu, 26 Nov 2026 17:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795713627;
	bh=YZPZBWVWOSEodS6UorajtVzSytMqlv6Bhq5+mczWxag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PUqFsivHqS8zS/HAvUAp4fsy7u7w2LG9Sd0n3u7e2hF9sQlcmoPEbVXsYz5yw9ZTx
	 SPOvST1owym/ebtltDVrsHvPDET9YSHSZ+HNMb6BaoT6/u7wVQi9/6jaVY1xXKBeW7
	 ItJup+2YLv0DFfzj6yhw47kViwU5ASbIzIGAeOKk/WXWa2V/Q7k7uBesyXVlmtjPO/
	 KQhHwDGGgm0gswXGfOyfYSooOEhisj/in7/F881YjA4BIXYgiIPHJNt4u2FUoEauSo
	 8spqr/AxqxHaEan7cmutbqUWQPxWPiSVezROXjEDohAckTc9QsRBovVycOg2XoyPDV
	 cZc9k1IP0WFFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/6] iio: inv_sensors: convert to kernel types
Date: Thu, 26 Nov 2026 12:20:20 -0500
Message-ID: <20261126171945.2727003-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126171945.2727003-1-sashal@kernel.org>
References: <2026112538-supper-bakeshop-1212@gregkh>
 <20261126171945.2727003-1-sashal@kernel.org>
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

