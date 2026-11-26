Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795712827;
	b=yw7MecCTZtfk+GJ7MHBZJlnkdnjAo0VFqEPNgO1AxYPE72KR62SNqEgzrH/UCXbnz3KW
	 00y/LMZN87Viwlcvm+i8TaPrJmdka5glniW42n6REkXT7/uBuBwRk+twWlFsI4EbtG8O+
	 gI8fdQqGgkaUM2ZY884U2fMR/N+nKiUAw+PomgTqFR0gQH/sXS+ajKdaOHgGaforKRrb8
	 XJBz9FWwUndcxUFsQhtxXXYHUhjIYZUCZ18g41KQfA/qXyOSLtE0ERgb/pQlsjTFH5ifI
	 r2SHAWTn2xy5W4VbZJAqempFmOUsuJ844wzB8DfC8XhMoxSSqifbeeHHengr6fvQBYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795712827;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SzFtM+aEFpVAvLWXYNwY7OVMX6TCWmShYQupwc7vSrQ=;
	b=msAi9XU060K0oNTg7sv7VW6G/G+ZOOMpyvECmhF+syVMpySPsHeF8HeVCiF/EIQN5gXa
	 oIPPmUXVjIFMvctVeuGv8qmXRUJD2kQUlHCixYivruOLdF8dzM2sn9PJrcG3MUgmd5of3
	 RdYYRfBPSrFmtGCefc3TW/uyx6y/2Lf/OHnzQYG4d0Mah8LHXVk5G4uqxa7upGQcslWQW
	 G+rTV8ias6xMG2sQRtnCeko+yQPcaI/RG71Rrr6ubHWbW7qYM++PX9P7ej98lfpUHJceP
	 LIegZn2t3zQtG6XCcAKmZyH2Xxvk6vxqrnGkzRyMncvqoOaykDZs8U7F/CfQLINc/+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TgjOE4Rv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDC1606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TgjOE4Rv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E20C1F000D3;
	Thu, 26 Nov 2026 17:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795712827;
	bh=SzFtM+aEFpVAvLWXYNwY7OVMX6TCWmShYQupwc7vSrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TgjOE4RvaMMRFSg9UECyrgdCK0kDVoHMR8KBSj5IgFgsM5GE1wY5RkMnGVptEZzVc
	 BriMXbKAAxvhgf3Ox/kxIm6RRzrQ4q2noctfDRilE3IWm6dhLLipl+sZHPz79Vn1SE
	 nc4khoHFC/Vx6QwA/9gSYaJrLjuWnvg7CH1utqe6AdFb877nMSOTGiu5djkvceWQZy
	 j+TTG52lGkn4Xk/zpJVJgxLTaUeqDivIA3Pddl/tz/20KrAO586ZkDTNRPLGbDz3Io
	 ec6pUTA3iTiq6OwaQEtoyEzqen/B4aBd3sjJZ7Aeog53wepoI+xfeyG/zrI+OEhx9j
	 Xhf2nEbiemrRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/5] iio: inv_sensors: better timestamp alignment when using watermark
Date: Thu, 26 Nov 2026 12:07:01 -0500
Message-ID: <20261126170626.2690323-3-sashal@kernel.org>
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
index ecfd54ffe7e92..2aaaa8df6d03b 100644
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
 EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_interrupt, "IIO_INV_SENSORS_TIMESTAMP");
 
-- 
2.53.0

