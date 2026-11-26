Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795712830;
	b=YsKUvH6/L8Ijzy1jbOxl7jV5WuLmZrIzZKVy/w/6T69MNnWIUCl/AOOnrE57GBqlLLut
	 YcH5eyWbJCZxnpzFgt8xbXZ8GLRvhK2ARVdFUNSsy7UWeRJtiHvt+XJYgL1NcwEJ8du4Y
	 wf8Z8gNaENg6l4DytVsP7kgVV/9vaCIB1kn9ZsiDsMINGFkt1jNUjY8MEaHRbg0CqKgeG
	 JrO6R+gNZcMc5bvRfU5s414Ji8SaANO5UtlmIhdRsspjJ+R0d4rHMbnRuMZjcDgsnRmMa
	 BBVZP+WvmoB0epAr3255QDo2wogmXcI2C5OmgZYLaQfOxIx/tA/UIYgKJpO2YOLZ4Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795712830;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vwwlzg/PGrX621tlTyyfLTCkyaI9KWd3dyDFg6V+/q0=;
	b=CRG0iys6uhdau7QbQFeTCf10u6cG7kW1w/ZKzQeTayHYS4HkgGu7llQmX8cq+FM7ScHc
	 8s65Pz/SiWnobdLSRHFu5NTE1n8MOxHIoVhK7XfuBz0Kh3E1nVHxAcLXr3kkGeqqywyIU
	 hOlH/Efi7R4oG9g4sYnBBRLl8FRptb7z4Wzt/FTaB0d9GyLNfk2uKzI+Xp9sxVlDW2tiK
	 djxkilNwrIV4PXl8ABn6wmRaH/Yrmd8AlPFEpmq3cHg9nOOvVkVIS9rDb5Zpve7x+MF66
	 6xGyjWG5r5cXQjajeQd6jT8bxBTLcwT8n3ve0KaxktII9kP2R4mSyW8fnG1UYri7ruQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G2Ihgqlm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28964606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G2Ihgqlm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1851A1F000C6;
	Thu, 26 Nov 2026 17:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795712829;
	bh=vwwlzg/PGrX621tlTyyfLTCkyaI9KWd3dyDFg6V+/q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G2Ihgqlmk7TrDlCUhJEmvLzOxH3K+aDeZKVFYHesPYrBKjONI9FTdnJ+GGtT3nRHq
	 mTH25gF0wsji9Ii25Bn09cUZHzB0D/ds7jBwKLrV4+C9xIFTTkXfJfV8bOBGBVzUXR
	 WV7iYjnGnCSraZvuZny/GgzqPxWopuF+UWlp5TeasvnmFkRcQclPFtW8lVqVfl+17x
	 50rMEVr+952c4KmisIbEfpUd98GWkO29sCdNuM+j3Q+U4qlHq7EyK78PtoG3RBX58r
	 c9rchDzdk1V7sHVLhPggrgvRUO0AgvuRVJQDjTUWD0/3CCtKpPa3NCqo5YFNQeC69w
	 a/8jj5CfaSv1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 5/5] iio: inv_sensors: prevent timestamps going back in time in transitions
Date: Thu, 26 Nov 2026 12:07:03 -0500
Message-ID: <20261126170626.2690323-5-sashal@kernel.org>
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

[ Upstream commit 3785dffc7c68751a8429ae6dd75804c14a5a7c7a ]

Ensure when computing first timestamp and when applying odr change,
that the next timestamp will not be lower than the previous one.

This way there is no risk to have a timestamp going back in time, meaning
being lower than the previous one. It already can never happen without
a transition because we are generating timestamps by adding the period
to the last timestamp.

Fixes: 0ecc363ccea7 ("iio: make invensense timestamp module generic")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../common/inv_sensors/inv_sensors_timestamp.c   | 16 ++++++++++++----
 include/linux/iio/common/inv_sensors_timestamp.h |  3 ++-
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index 88a82d1370c50..c6699fc9248ae 100644
--- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
@@ -133,10 +133,15 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
 		return;
 
 	/* no previous data, compute theoretical value from interrupt */
-	if (ts->timestamp == 0) {
+	if (!ts->init) {
 		/* elapsed time: sensor period * sensor samples number */
 		interval = (s64)ts->period * (s64)sample_nb;
-		ts->timestamp = timestamp - interval;
+		delta = timestamp - interval;
+		/* prevent next timestamp to be lower than the last one */
+		if ((delta + ts->period) > ts->timestamp)
+			ts->timestamp = delta;
+		ts->init = true;
+
 	}
 
 	/* update delta timestamps and estimated period */
@@ -179,7 +184,7 @@ void inv_sensors_timestamp_apply_odr(struct inv_sensors_timestamp *ts,
 				     u32 fifo_period, size_t fifo_nb,
 				     unsigned int fifo_no)
 {
-	s64 interval;
+	s64 interval, timestamp;
 	u32 fifo_mult;
 
 	if (ts->new_mult == 0)
@@ -202,7 +207,10 @@ void inv_sensors_timestamp_apply_odr(struct inv_sensors_timestamp *ts,
 		fifo_period = fifo_mult * ts->chip_period.val;
 		/* computes time interval between interrupt and this sample */
 		interval = (s64)(fifo_nb - fifo_no) * (s64)fifo_period;
-		ts->timestamp = ts->it.up - interval;
+		timestamp = ts->it.up - interval;
+		/* prevent next timestamp to be lower than current one */
+		if ((timestamp + ts->period) > ts->timestamp)
+			ts->timestamp = timestamp;
 	}
 }
 EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_apply_odr, "IIO_INV_SENSORS_TIMESTAMP");
diff --git a/include/linux/iio/common/inv_sensors_timestamp.h b/include/linux/iio/common/inv_sensors_timestamp.h
index 4f08204ede3b4..91690778ae88b 100644
--- a/include/linux/iio/common/inv_sensors_timestamp.h
+++ b/include/linux/iio/common/inv_sensors_timestamp.h
@@ -66,6 +66,7 @@ struct inv_sensors_timestamp {
 	u32 new_mult;
 	u32 period;
 	struct inv_sensors_timestamp_acc chip_period;
+	bool init;
 };
 
 void inv_sensors_timestamp_init(struct inv_sensors_timestamp *ts,
@@ -94,7 +95,7 @@ static inline void inv_sensors_timestamp_reset(struct inv_sensors_timestamp *ts)
 	ts->it = interval_init;
 	ts->delta = interval_init;
 	ts->delta_counter = 0;
-	ts->timestamp = 0;
+	ts->init = false;
 }
 
 #endif
-- 
2.53.0

