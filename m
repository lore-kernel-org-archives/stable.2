Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713630;
	b=uEPQaLiadtTZMJUc5OKDdo0gqd3L91PZJy96iehYXNF5nNH8nRuWNmrvNWsOGcYSYzWN
	 Tw+x3kH6Jj8zOTvX58O7+/OgHWZzCLCALSExpiw+JuHT6BAHHbpEvdY7u8Y+nrkMRiw+3
	 ccYv1mCVGp8eWdAQi6LXMAuIn+4qdue1CYlxpYKp7v/OcFe7fP5clPXVCsH6z7PlrZfWZ
	 afYUQG7GOtKUKNSck9vTBG+CnA8iGAmDuA166KgNFKgyp2TFUZQHN2Ncm2uWUqGUBhUS3
	 PCljYg7AlaxXDqgnpOW/0M4ZKd0fI3vfmAQeJZfKi9MZswpw6caO6hAmBTWm/iyvaww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713630;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RLwvr2uKgGRdbvH8X/7v6vcrV0LQ8tKWPx2sQiYxjRc=;
	b=yEY6P4BKuo5dhUuqDDo6ieC4spdg7oXcouIDN0PyFk9n5kIJRXOsAgqu9+rq97eGsD9g
	 hPzH+f9oxWDzCrUS0K7n9TSUxzeDzUJWR94zrxTnzBER3Sg5JDXUPGaXRsz54Aj8pyyDN
	 nBA7tnuuNOoGXa3KIfJzAEgDiAcZwlmKlPmnlVkBbWkMlJfecMRtLAQeYV1wg0EWQpYN0
	 amLo3dXJqLzZzuX0eDoTR4b6OL7YP4VuXz1u981EenLp129ZwedkdSrIXoMMnaBtYl3NW
	 9Y2gsRAZxGfBHfk0FErkvBzQLkpgRUhh081TrP5ETqaXW/+ZB4J0NUlBZ05MgsiQJOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DG7A+24t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17515606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DG7A+24t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504121F000C0;
	Thu, 26 Nov 2026 17:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795713629;
	bh=RLwvr2uKgGRdbvH8X/7v6vcrV0LQ8tKWPx2sQiYxjRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DG7A+24ti8wh2PmZx5jTsVfkTlqzRABm8P7nc0FE1XY9Hgb28bFijTr+7yOPQIUif
	 A6Svqb6YumtoOlVuIss3dutwwgMiJ+K4V29NnlgHztfnuWmlHhNlomNu4NSjvRrZpQ
	 +UtYDU7SA858T+4S3q4VDICsBZkd7ojVsWsfVdGJ4jm9HfRoRUJdoyOcoogpZF1BSw
	 kQ2GkqMgkbIFJFbeo7jR9YD1eHhtEg7rhDZ/rtXLiEzve/Usm3ROgJhC+sPaqhMzvF
	 wL+m8wrkfKwuccEUWqHYPoXeUFZ3Agze9GMDKFxJGsJ2jQSP0kADRPG8oYq2uu5yuC
	 g9Fw5mECou7OA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/6] iio: inv_sensors: improve period measurement by using a longer delay
Date: Thu, 26 Nov 2026 12:20:22 -0500
Message-ID: <20261126171945.2727003-5-sashal@kernel.org>
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

[ Upstream commit 82bd09ce4fd3b15680735eaeafe2e688901e3b00 ]

Period measurement can be difficult when using high sampling
frequency where the jitter criteria is hard to meet because of the
system jitter.

This new version is using the delta time between 2 distant interrupts
to measure an interval of at least 20ms. 20ms is a good compromise
between the mitigation of system jitter and the delay to update
period. This way we decorrelate the period measurement from the
interrupt timestamps syncing using only the 2 last interrupts.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Stable-dep-of: 3785dffc7c68 ("iio: inv_sensors: prevent timestamps going back in time in transitions")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../inv_sensors/inv_sensors_timestamp.c       | 26 ++++++++++++++++---
 .../linux/iio/common/inv_sensors_timestamp.h  |  6 +++++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index 88ad439ac14c6..aacc56d1a2c77 100644
--- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
@@ -16,6 +16,9 @@
 #define INV_SENSORS_TIMESTAMP_MAX(_val, _jitter)		\
 	(((_val) * (1000 + (_jitter))) / 1000)
 
+/* minimum timestamp delta between 2 interrupts for measuring period (20ms) */
+#define INV_SENSORS_MIN_IT_DELTA	(20 * NSEC_PER_MSEC)
+
 /* Add a new value inside an accumulator and update the estimate value */
 static void inv_update_acc(struct inv_sensors_timestamp_acc *acc, u32 val)
 {
@@ -122,7 +125,7 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
 				     size_t sample_nb, s64 timestamp)
 {
 	struct inv_sensors_timestamp_interval *it;
-	s64 delta, interval;
+	s64 delta, delta_threshold, interval;
 	u32 period;
 	bool valid = false;
 
@@ -136,15 +139,32 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
 		ts->timestamp = timestamp - interval;
 	}
 
+	/* update delta timestamps and estimated period */
+	it = &ts->delta;
+	ts->delta_counter += sample_nb;
+	delta = timestamp - it->up;
+	delta_threshold = INV_SENSORS_TIMESTAMP_MIN(INV_SENSORS_MIN_IT_DELTA, ts->chip.jitter);
+	if (delta >= delta_threshold) {
+		it->lo = it->up;
+		it->up = timestamp;
+		if (it->lo != 0) {
+			/* compute period: delta time divided by number of samples */
+			delta = it->up - it->lo;
+			period = div_s64(delta, ts->delta_counter);
+			inv_update_chip_period(ts, period);
+		}
+		ts->delta_counter = 0;
+	}
+
 	/* update interrupt timestamp and compute chip and sensor periods */
 	it = &ts->it;
 	it->lo = it->up;
 	it->up = timestamp;
 	delta = it->up - it->lo;
 	if (it->lo != 0) {
-		/* compute period: delta time divided by number of samples */
+		/* compute period and check validity */
 		period = div_s64(delta, sample_nb);
-		valid = inv_update_chip_period(ts, period);
+		valid = inv_validate_period(ts, period);
 	}
 
 	/* if interrupt interval is valid, sync with interrupt timestamp */
diff --git a/include/linux/iio/common/inv_sensors_timestamp.h b/include/linux/iio/common/inv_sensors_timestamp.h
index e4e720e6f4b72..4f08204ede3b4 100644
--- a/include/linux/iio/common/inv_sensors_timestamp.h
+++ b/include/linux/iio/common/inv_sensors_timestamp.h
@@ -46,6 +46,8 @@ struct inv_sensors_timestamp_acc {
  * @min_period:		minimal acceptable clock period
  * @max_period:		maximal acceptable clock period
  * @it:			interrupts interval timestamps
+ * @delta:		interval timestamps between several interrupts
+ * @delta_counter:	number of data samples in the delta interval
  * @timestamp:		store last timestamp for computing next data timestamp
  * @mult:		current internal period multiplier
  * @new_mult:		new set internal period multiplier (not yet effective)
@@ -57,6 +59,8 @@ struct inv_sensors_timestamp {
 	u32 min_period;
 	u32 max_period;
 	struct inv_sensors_timestamp_interval it;
+	struct inv_sensors_timestamp_interval delta;
+	u32 delta_counter;
 	s64 timestamp;
 	u32 mult;
 	u32 new_mult;
@@ -88,6 +92,8 @@ static inline void inv_sensors_timestamp_reset(struct inv_sensors_timestamp *ts)
 	const struct inv_sensors_timestamp_interval interval_init = {0LL, 0LL};
 
 	ts->it = interval_init;
+	ts->delta = interval_init;
+	ts->delta_counter = 0;
 	ts->timestamp = 0;
 }
 
-- 
2.53.0

