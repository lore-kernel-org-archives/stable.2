Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792509967;
	b=01qENe8nMwjR49ul3MBqCsheBs0gtb/Nxq6KUpuQn0abFdnQceZU1jxOTFZhpOMJoG/o
	 G+1gz8nZ4yOek40rit8wCB2HrAzA8HneZQFaOk11HK2NnUdx1CfoKG5oPiOYGPsneRDeQ
	 RSxT6onNpIppwsX6f/R87SRhB+Swxl2tVFiYC7igPRK1kthVnrQRXljbj26tFTQlbGGQ6
	 tzWo0wlKNUtTT+vtc5tBq3pVXTPyooOBLdtJGKTNBtCNF54411oU42s1DxZrfOjIa4Svp
	 sUx7mBTd+IKDsP4eh3DcB68pWSzr3de2CuSRUgd+CKa3QKMtQQ6sgk9InSFEXqyFZvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509967;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XB+26I9RQacuPIWnRjHF6pEOgxNT2RHWSFWP6LggIsg=;
	b=BGKQWtp62g6M4O3Cb33PlrfWEU5xaiZN0l1KDy65B0IafyG+0Xxhd+MkPWR4UJiAQsLz
	 tiSxBcxdUg7iRR0qGL1i8lAu9U2soJpSoAxdocD1GrjUCu5ehD3oy1h8Ndwh9uGv/hAwK
	 iwJrwzPbf68GviEVHZDPS9bWgNQg3Rmb9QtZ0I1y9ws9mTYNHT1RSF3SISQ8Q+bBiLp0r
	 pruCAJ9fVr8L21YBsw2bhwWcZZ6107gEajV9rbjRf1YlpXnDA/J/8imUQHyYhNQpKkLeW
	 QTrOBCV7N+RZsNG1r7isMZaFYl1Bo49y7OtyjzSPzHz199In9i2ixQZLcNMiiG2CN6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=axKbDNdI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66663606A31B;
	Tue, 20 Oct 2026 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=axKbDNdI
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792509965;
	b=pxVmygMeW6h9dNfxNAIllE4BSwN3qxc0cUoOb4ZIivM64cT3jV2Kze2IvBAW/DsCG2Hk
	 QB5tcPWHvrHMbZ6eeZcR9faMaJoPWqj6ClnXcd9WZy5oCDfcP1MeoXKerdmgsAOCACrK7
	 WMxSzu/VfToJqlut0QKmWe9xEEFmQiiqI+8JrWOuNjW8LVsRwvyIZ5qdtt0tyAJMF/xAr
	 oSsaeQ11uIgxjwQcpfFcvCEmHL1Utu1S2raqtlL8+6xxgAHVJQTAaj2OJGXMybwGfHKxy
	 dA+pN2mz/kZgeHfLp9G5koVXcHoV98btlHw06W/UVPoreJMvgzqYvy3BeH3ilKtNkrw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792509965;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XB+26I9RQacuPIWnRjHF6pEOgxNT2RHWSFWP6LggIsg=;
	b=S4DnTk3apJnHs2Xu9W0Y1TFqzlRpKPXFF2XXkU9wFImEPJAyqEgGUKcbMHKWsPdXGlex
	 1/GB1e2lkJ7dhoinsHW93t3HT9oM1GMzGDIZVi8NxO5nav645A+sNRkGMl6SPWapZzEhp
	 30X79tHlvHkEnEJXG6Aw32Hl6MfJa77qC8nGd/2S5MatlHo8QAPrtrgzKvblJQbZEUIYx
	 q7LRn8rJVEP7nbgjhMO58vh0VARoVqG8mlYab24MhrhJYfs6Aj4/ejTvukB7lUv2UABy+
	 I3QObBW0g0foW2BKtTa8PVm3+aIt6pNxl4gOLVPlQNXqKJxOW9POB1JyFHOoqqKTBhQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 569161F000C4;
	Tue, 20 Oct 2026 15:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792509965;
	bh=XB+26I9RQacuPIWnRjHF6pEOgxNT2RHWSFWP6LggIsg=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=axKbDNdIrE6PWnixL1ykpsDc5q3vPLtw6R6WkhOfCC5DljXxKczVbQwkGU2AoKKZK
	 B9gFHWZnlMCWSH2XN19rnNeLoezBOe1nrUmA780/2Yf/oGjjqwzuJ4QnyKeUAGaG7A
	 blbeSoMCLK4O63rkHHNQhRDdZnKVGdY0EJMTXAdKXuhioJEhbQ4wJmNsXsbk7Xboid
	 eZnc3gKEB3GlYLROKzRrU+ZhnF0EatS5+j588WQhVoU1wPzceAoTduS7wsqybE5aoF
	 POHDs8wbpr0+RpblHwUmCTJZWOqiyw7Kf+o57no8+cKifeidtQV+eAs4a7nrc5OK/2
	 PfXW5HlkkxR5g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AB4BF405FF;
	Tue, 20 Oct 2026 15:26:04 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Tue, 20 Oct 2026 17:26:00 +0200
Subject: [PATCH] iio: inv_sensors: prevent timestamps going back in time in
 transitions
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261020-iio-common-inv-sensors-fixes-for-preventing-timestamp-in-past-v1-1-c27be451b287@tdk.com>
X-B4-Tracking: v=1; b=H4sIAAeI12oC/yWNwQrCMBBEf6Xs2YWkSon+iniI7baukE3IxiKU/
 rurXgYezMzbQKkyKVy6DSqtrJzFwB86GB9RFkKejKF3/eBd75A545hTyoIsKyqJ5qo485ssc8V
 iNySNZcHGibTFVKyKJWrDMEV/nodwdOEE5rDyb2mK6+3P+ro/aWxfKez7Bw3903GhAAAA
X-Change-ID: 20261020-iio-common-inv-sensors-fixes-for-preventing-timestamp-in-past-8da19f683084
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, stable@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792509964; l=3507;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=SKRCGdHQ3/TSi0j/AnCYzWp+4z8JacqTdI3yvmeaYFE=;
 b=3UVAS7YsWlCyaqey1MfHrpDdIzft+npqsEh1GeWkEd2LHGvRRicxbJ6cP/WTedQI8XG/1r7Je
 bIuNz3L6ALlDMF1GPQQDjK3cbMM+RejEYNDuerAtpznFcRniqE6AtJ6
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com
Content-Transfer-Encoding: 7bit

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Ensure when computing first timestamp and when applying odr change,
that the next timestamp will not be lower than the previous one.

This way there is no risk to have a timestamp going back in time, meaning
being lower than the previous one. It already can never happen without
a transition because we are generating timestamps by adding the period
to the last timestamp.

Fixes: 0ecc363ccea7 ("iio: make invensense timestamp module generic")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 16 ++++++++++++----
 include/linux/iio/common/inv_sensors_timestamp.h       |  3 ++-
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index 8c9e81a77e68..9040da80f0c7 100644
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
@@ -184,7 +189,7 @@ void inv_sensors_timestamp_apply_odr(struct inv_sensors_timestamp *ts,
 				     u32 fifo_period, size_t fifo_nb,
 				     unsigned int fifo_no)
 {
-	s64 interval;
+	s64 interval, timestamp;
 	u32 fifo_mult;
 
 	if (ts->new_mult == 0)
@@ -207,7 +212,10 @@ void inv_sensors_timestamp_apply_odr(struct inv_sensors_timestamp *ts,
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
index 4f08204ede3b..91690778ae88 100644
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

---
base-commit: 43ffda3c7f8456bbe641ae8249a077a361b97880
change-id: 20261020-iio-common-inv-sensors-fixes-for-preventing-timestamp-in-past-8da19f683084

Best regards,
--  
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>


