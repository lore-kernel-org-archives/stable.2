Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795714197;
	b=fuaAm8plA+Iy/to1evBycjSiolkaxUtyEKku540EUbIa9Dp5wurOZuw+SLuIuO4pjsnM
	 921AlkZsLbnhLgZxRw/d3yQMuBaapLxwx3YsBdQC1b8ZGoAO8QhxhFQyh+s6++Zm0gH7j
	 TowrQv3L1Q2LGJCWn/Rv4SxIHv/Nc5+AGliyarfyP7p1bwM9VkB6NOubyqR7VFzmOz9m5
	 r2hUHhM7Nk7epuI1iRzUGGGLoK1jlIQCEtgoEmPF9MKdLTElDPKj+7Aw1WSaNBCpL+djE
	 1uAe94MYQvSR4j5azTSt8Kg4XinDBHHWQLJXjJ8iMOMeWv/KGoBA04flTCLY0R8/0Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795714197;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GvqgKFTSbzQtmejz9dUoOXA6bWcX78F+r5g1vt+AAxI=;
	b=R3/fo9Oih8NAKgFwfd5B2xhUEBNRfX1NuCnjyp0b5qyoFx4UD6rUw4+LHxmqfFi4VIgv
	 eu93Ty+vjFewJVHCvw0zCHEzDce2KbyEPAGFEGs/Xs6gRMePzGHMWt1hmDEXxi/vcPuFX
	 FtEAr8MMzppIqnL/ThN7D5t/W8JE3zwTo+cbwLRSA76+/woK+q3RbUwNdQlX4XS0rLEK6
	 O/RrASJlLYTBsoLkQ7VAtX75bceSgzjZVxVcHjIVAvn9TkZP+II6zwP7ObRK9h46XIK+8
	 k9JdmCWQWO1Omko19yBwzDkUWP/KWZ17Q8nvmsfVmVVtvBB5I5FPVf+7xt4wtFagrFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=juAIEiX3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EE4606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=juAIEiX3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9804A1F000CF;
	Thu, 26 Nov 2026 17:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795714197;
	bh=GvqgKFTSbzQtmejz9dUoOXA6bWcX78F+r5g1vt+AAxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=juAIEiX34v4rFrEca29Z6SkLZxOISseFe56RDLh0a1RmYXnnY+ck9kwDljCW6T89j
	 gg0Xap/fxNUMVFh+LFM4ZcLCTtehU5/BByChqE65qkKhX/rzz8CbP2pifLsm8FydId
	 LLqh6hj4xu/R0m0fo7alUz3VapiNNmykdL/AKxZymVUjoipxIqL+X3Y9Wo6GKjBpf2
	 pKr7Npj8JEKXtf0wXWzcOzulBUh71jk3tFSM+BdWDoXznslZKWuro1j+c236BxCBLB
	 JDNqXOdg5L8iTYq653Mwd9l+FJG4AyF5NOPVQ/KEHqMAicIBvAW21r1W4cG4HWH8C5
	 EUEB0BKqvyh9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/6] iio: inv_sensors: better timestamp alignment when using watermark
Date: Thu, 26 Nov 2026 12:29:51 -0500
Message-ID: <20261126172925.2769957-4-sashal@kernel.org>
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

[ Upstream commit 8f4b627656fa1767d8337a95849fe7c895b6f68a ]

Current interrupt timestamp alignment only changes the final timestamp.
When the watermark is in use, we have a batch of samples for each
interrupt. The current code doesn't manage to align the timestamp
because the jitter is too high.

Instead modify the estimated inter interrupt period and use that to
adjust the timestamp alignment over the batch in a linear fashion.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Stable-dep-of: 3785dffc7c68 ("iio: inv_sensors: prevent timestamps going back in time in transitions")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../inv_sensors/inv_sensors_timestamp.c       | 51 +++++++------------
 1 file changed, 19 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index 2fdb4cea8a54f..88ad439ac14c6 100644
--- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
@@ -10,9 +10,7 @@
 
 #include <linux/iio/common/inv_sensors_timestamp.h>
 
-/* compute jitter, min and max following jitter in per mille */
-#define INV_SENSORS_TIMESTAMP_JITTER(_val, _jitter)		\
-	(div_s64((_val) * (_jitter), 1000))
+/* compute min and max following jitter in per mille */
 #define INV_SENSORS_TIMESTAMP_MIN(_val, _jitter)		\
 	(((_val) * (1000 - (_jitter))) / 1000)
 #define INV_SENSORS_TIMESTAMP_MAX(_val, _jitter)		\
@@ -102,34 +100,22 @@ static bool inv_update_chip_period(struct inv_sensors_timestamp *ts,
 	/* update chip internal period estimation */
 	new_chip_period = period / ts->mult;
 	inv_update_acc(&ts->chip_period, new_chip_period);
-	ts->period = ts->mult * ts->chip_period.val;
 
 	return true;
 }
 
-static void inv_align_timestamp_it(struct inv_sensors_timestamp *ts)
+static u32 inv_align_timestamp_it(struct inv_sensors_timestamp *ts,
+				  unsigned int sample_nb)
 {
 	const s64 period_min = (s64)ts->min_period * ts->mult;
 	const s64 period_max = (s64)ts->max_period * ts->mult;
-	s64 add_max, sub_max;
-	s64 delta, jitter;
-	s64 adjust;
-
-	/* delta time between last sample and last interrupt */
-	delta = ts->it.lo - ts->timestamp;
-
-	/* adjust timestamp while respecting jitter */
-	add_max = period_max - (s64)ts->period;
-	sub_max = period_min - (s64)ts->period;
-	jitter = INV_SENSORS_TIMESTAMP_JITTER((s64)ts->period, ts->chip.jitter);
-	if (delta > jitter)
-		adjust = add_max;
-	else if (delta < -jitter)
-		adjust = sub_max;
-	else
-		adjust = 0;
+	s64 new_period;
+
+	/* compute new period aligning last timestamp with interrupt timestamp */
+	new_period = div_s64(ts->it.up - ts->timestamp, sample_nb);
 
-	ts->timestamp += adjust;
+	/* ensure that period never overflows the jitter */
+	return clamp(new_period, period_min, period_max);
 }
 
 void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
@@ -143,6 +129,13 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
 	if (sample_nb == 0)
 		return;
 
+	/* no previous data, compute theoretical value from interrupt */
+	if (ts->timestamp == 0) {
+		/* elapsed time: sensor period * sensor samples number */
+		interval = (s64)ts->period * (s64)sample_nb;
+		ts->timestamp = timestamp - interval;
+	}
+
 	/* update interrupt timestamp and compute chip and sensor periods */
 	it = &ts->it;
 	it->lo = it->up;
@@ -154,17 +147,11 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
 		valid = inv_update_chip_period(ts, period);
 	}
 
-	/* no previous data, compute theoretical value from interrupt */
-	if (ts->timestamp == 0) {
-		/* elapsed time: sensor period * sensor samples number */
-		interval = (s64)ts->period * (s64)sample_nb;
-		ts->timestamp = it->up - interval;
-		return;
-	}
-
 	/* if interrupt interval is valid, sync with interrupt timestamp */
 	if (valid)
-		inv_align_timestamp_it(ts);
+		ts->period = inv_align_timestamp_it(ts, sample_nb);
+	else
+		ts->period = ts->mult * ts->chip_period.val;
 }
 EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_interrupt, IIO_INV_SENSORS_TIMESTAMP);
 
-- 
2.53.0

