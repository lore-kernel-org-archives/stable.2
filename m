Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795714198;
	b=jU/3tWj0+pNdGLNHlz+IAKsncE6OI8Ayj5RpzZmPDqaRHEUsk528BMuccMrzhp7hijuo
	 kCVeKMog6X+99QD085QJJebV+wSLPKoIKN6WRP1hL+OXABEXBBVw7tdWVYdgED+GsiKXP
	 YnZNz+Knmllv4imKcNYBFIpUDyulW+YL4RqlLUbte8aBEp54XRVsvNEmPq+GR1wMeafgU
	 3C0XZpAbezRpJuJgXOwgYRD2zOPAjI3FPlOf3PxLvVeeYrrse41Aaj8oEAyaA1vqSgUcy
	 rOBjzumi0P9ZxJWK0hrR3RgAdJqDsl3xH7E4vIMvHvWLEazpptZWl2nceX4jI+IX5Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795714198;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gWoI7Du3SAuaVNfkd4/4oEH0MNdvzidJgWyLcfCaWhg=;
	b=MzDXZ1/g1bxccwDKchNH8eF7bHqPDEfKd8LS274AfKGX5kRHzUv1mxSNaTyf1BNoy3wC
	 YGdXoTp8cQtNmmTHoF+o+BHFVyxkknhkqE8h5TTwWbMCUnTOwQ6xj/jM4qb2LjuNYwsoa
	 TzxOCz5LsxNsbDeIe3ASeFBuvXo83tv69FBSSNWjNTgVh7/PYsfjcPh64FHSwjdHwZ4SC
	 Hf6ZON+w5ggdNfUAEmGNJ6oYYKaOLr05etBzNd6P7LV1EKhPdLmlXGYHlemrB+k5Fx0xU
	 dG/uqL5TQyGagZgM0rgCwpW2uxHWS+jXIHrWI/eCXQM2YG2sIxBgS4JBm4yFsij3v7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b5pxuubR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBD9606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b5pxuubR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1551D1F000C6;
	Thu, 26 Nov 2026 17:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795714198;
	bh=gWoI7Du3SAuaVNfkd4/4oEH0MNdvzidJgWyLcfCaWhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b5pxuubR+gWtKzBTxE9TCmE4U8IzwECW3M1jaro2phs5beSt40aKDYAZDGZANkp6j
	 Vh6peQZxDvw9sgiyj0RqHp+MrX45ulCPhFFviwHp890f8RdNbEda3t1vYpIlOLUdkD
	 e/c7FBPjBiZAkKXZ84+QtgkjHthsFY/tF7GhMj/0PMSkie8qknVUvkOszrFmNr9CDr
	 0TsmCNvMh1/9hWlJHi/dV5AtOtuGp2CLgJJQvZZnDSlVQEWisUVkHKQMvj+kZbS/Ri
	 +pOw1W/VKATGHxP3f34RoOxwIXRiMFost2irGprfxvjyf4rfUqqfjsdbKPSluMswTP
	 E98HEn8WETYfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 6/6] iio: inv_sensors: prevent timestamps going back in time in transitions
Date: Thu, 26 Nov 2026 12:29:53 -0500
Message-ID: <20261126172925.2769957-6-sashal@kernel.org>
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
index aacc56d1a2c77..4795a24171af0 100644
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
 EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_apply_odr, IIO_INV_SENSORS_TIMESTAMP);
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

