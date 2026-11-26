Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713631;
	b=oM98JTR7PTSOzVciZ3N4t0q82UiqULm6Y8wHxjRxXV2TDNzB4p/0OXfZ27Tpy4ojQKNG
	 OzZeP1vlcgB58vt6aNWogoVyw55xQDAaXTokynCFk+YVg9zaQaTUtAE+VSNcnd4Y4ZRZF
	 lB9uRTMSxM4gBCfJgohXhAYzgrl+6o6AbwHAm2oe/qmyIenexWCloabRGyiep5NRbWrsf
	 bOaq3//50xD2MzUUc6NcDRE/+fzo4kiGduvD1lnokQ3uMTO9SNy1eGdbd93oaOwySfjj9
	 dmxJ1B9TmuBHhs7J+CwcLKWa6Ah/KyvC0q9O2/XqynsgNllFLSgrD6Iawm6B0uSe6gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713631;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gWoI7Du3SAuaVNfkd4/4oEH0MNdvzidJgWyLcfCaWhg=;
	b=I3uXbhpdeW9S9VOknM84w2qlmcZEwDWDXshZiDRtUSUEWeZQhYtjShuwV2Cpbi/mK6NU
	 UAfbwj6FHu5oM7y2jUL1I4HcbaPhd8HSM4nEcl8Qysyw9gFurTmGsUpfbavMl/oNuWlYE
	 XcdhXdNGDGc8mCah716tIhOGMYmQ1OCoEwfBnaOiGxSkhcTSH3Hwd6P9mKJOjyJF9je6G
	 G6cdrIHpBXgEUyM9YYrSMDka5cbu1WRiOne6VwqhcZdbfbSg4SoX0/N1J6d2NmRngMPnX
	 R8Mr8sn6JzP7zVzKIei0ERsVOLeH5b1hazyMXKcXi23RkXlRBbi7r/l0RqgHIHsPv9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i4BBeC4+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A6A606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i4BBeC4+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3E11F000C4;
	Thu, 26 Nov 2026 17:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795713631;
	bh=gWoI7Du3SAuaVNfkd4/4oEH0MNdvzidJgWyLcfCaWhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i4BBeC4+UhPAo9ouxBzlgBKODYBnHdGDocAzb5OpTFvk6nYDZCjMTgS1KWzmvevM1
	 ddlfGibqoJXNsqv77sLRwb4NILbAhiVEZlUkel2ZbDCse90tkxZve0CimgEVBPdJD3
	 lFLZPs8EYLbDaFkV0qEoZVBCwxnGNHB8J6u0vQq9oNbfGOPZmKF0a41Y/7I74fB8UU
	 BxiQpYjmzbk3+edGBVnq3mURLY7K17vkDX/w2WoNcLhPbu3kG9VrL93c3J7wvr3kdg
	 jXcQgSyHUBr2TG1Ui6Q7gUHgh78IQKeSgt6d5RLTodmZ4ofGIUrWZJklOUOR6K/HCI
	 7xP4d7N6Ha3kA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 6/6] iio: inv_sensors: prevent timestamps going back in time in transitions
Date: Thu, 26 Nov 2026 12:20:23 -0500
Message-ID: <20261126171945.2727003-6-sashal@kernel.org>
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

