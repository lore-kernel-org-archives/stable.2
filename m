Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795712825;
	b=hNGOzhR5RVQF7NcqH3BC6hmm/KdfRv3H0u9m/brCqTm5eqRJIBmGP2hCDZ/JE+rDHB0R
	 HzLVLeUZ5B9PuU/p9R8tmoQCRn0C51vLBViqJoAmlHoGngq/IMOKaaBtoMjwGBnIAtCGa
	 gfKhQIQeYiS1TjaYcK2ENUeTFVgLht6l6GvviLuu3Wr3R6swdVjnV88uROjydCvFEvw8i
	 l3n3OAjv9PpqFf9iCMHqNdEEhqWZfVMFOn3QLvsdh+VMo5c2Qk2BDsKomKZAbqOdw6L01
	 WkmRi7DNsa+1/Z2OKHMZ9PYWLg3TJ2/nhRS/3OPNwOoc5THnoEgkf4pAbUczxjQoYYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795712825;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fMaiQzafklIaHRP/Gt9XmIAuTSsgAe/iOnm/EdUtfDE=;
	b=hCgcmoP2qb/u95PDLYkD8JGnZoIuHQhMxKgSBVmvarahdEJaqRGC0dxoS1loj0sULjtG
	 B0+1HS34v1bdo/d9AoiwM+5oRfZxcGD+7bim8bTG+v7DgCqwPS+Mwpp8g8o/6dPSy23GO
	 1YIZ9xhFDXi7vM+RLJ/naetyIvD943k+jqSz+vj0WaxGNv+9UZkqoYLTnhvlreMpicWwy
	 d3V3AHulLi1FaYLSRPW8ljGnOOSNLLc8Re6VrBc877435zvm6Xkj5Bfnnq3tlgWTn2J5r
	 ZIiSAyIsdzE4jnfyweJ5JcIgmNnZhCOYzJ9xv4tQkhyvA79UP5GLBOCZuX7z0XztAwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HE5aFaVq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3746606A326
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HE5aFaVq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AE51F000E6;
	Thu, 26 Nov 2026 17:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795712825;
	bh=fMaiQzafklIaHRP/Gt9XmIAuTSsgAe/iOnm/EdUtfDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HE5aFaVqP6WzwsqKzilCiZE1n3m9cHwYQKQcQAbnRSZWIPfd06g5F4rHL5/vDeS3T
	 umcDHSeYOS0iSal07Al13V0w6SCQGYrGIaZSIj09eXY1QwYVJLSNUC+kb4sMYSH/18
	 kko8R0jdVtXTBmoDPLvXpNbPaHGcGmkQqI8z4jj26uaG4YLw0hKtJfNXvtpszhDm4s
	 y2f7O39pas8bFTpxq8Bu+F1zD0TnMJj9d2ksR5GmWweYRUO+UGsVLhWHWR686t9fJj
	 qVqSlmQqGj8P3/2ZidCVXbeqszoFnagBPDLsljWyTIigLYRZXRGdkfIOUc4E1M19a/
	 3hdgR6y2tPuOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shi Hao <i.shihao.999@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/5] iio: common: fix spelling mistakes in comments
Date: Thu, 26 Nov 2026 12:06:59 -0500
Message-ID: <20261126170626.2690323-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112538-browse-ascertain-b38c@gregkh>
References: <2026112538-browse-ascertain-b38c@gregkh>
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

From: Shi Hao <i.shihao.999@gmail.com>

[ Upstream commit 96f46405219d9bf62d9fab76e055e3b6059b0bd5 ]

Fix spelling mistakes in comments.

- exepects -> expects
- fuction -> function
- theoritical -> theoretical
- appopriate -> appropriate
- iio -> IIO

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: 3785dffc7c68 ("iio: inv_sensors: prevent timestamps going back in time in transitions")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c   | 2 +-
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 2 +-
 drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 4 ++--
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c         | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index 82cef4a124427..f34e2bbba2d1e 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -106,7 +106,7 @@ static int cros_ec_sensors_read(struct iio_dev *indio_dev,
 		switch (st->core.type) {
 		case MOTIONSENSE_TYPE_ACCEL:
 			/*
-			 * EC returns data in g, iio exepects m/s^2.
+			 * EC returns data in g, IIO expects m/s^2.
 			 * Do not use IIO_G_TO_M_S_2 to avoid precision loss.
 			 */
 			*val = div_s64(val64 * 980665, 10);
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index 2e3f3f41fdaaa..3fd661b1f42f6 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -356,7 +356,7 @@ int hid_sensor_write_raw_hyst_rel_value(struct hid_sensor_common *st,
 EXPORT_SYMBOL_NS(hid_sensor_write_raw_hyst_rel_value, "IIO_HID");
 
 /*
- * This fuction applies the unit exponent to the scale.
+ * This function applies the unit exponent to the scale.
  * For example:
  * 9.806650000 ->exp:2-> val0[980]val1[665000000]
  * 9.000806000 ->exp:2-> val0[900]val1[80600000]
diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index 97526ba87b934..e0b10366ed2bf 100644
--- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
@@ -154,7 +154,7 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
 		valid = inv_update_chip_period(ts, period);
 	}
 
-	/* no previous data, compute theoritical value from interrupt */
+	/* no previous data, compute theoretical value from interrupt */
 	if (ts->timestamp == 0) {
 		/* elapsed time: sensor period * sensor samples number */
 		interval = (int64_t)ts->period * (int64_t)sample_nb;
@@ -185,7 +185,7 @@ void inv_sensors_timestamp_apply_odr(struct inv_sensors_timestamp *ts,
 
 	/*
 	 * After ODR change the time interval with the previous sample is
-	 * undertermined (depends when the change occures). So we compute the
+	 * undertermined (depends when the change occurs). So we compute the
 	 * timestamp from the current interrupt using the new FIFO period, the
 	 * total number of samples and the current sample numero.
 	 */
diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
index 5884708636818..1960a2ce82a8b 100644
--- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
+++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
@@ -96,7 +96,7 @@ EXPORT_SYMBOL_NS(ms_sensors_read_prom_word, "IIO_MEAS_SPEC_SENSORS");
  *
  * Generic ADC conversion & read function for Measurement Specialties
  * devices.
- * The function will issue conversion command, sleep appopriate delay, and
+ * The function will issue conversion command, sleep appropriate delay, and
  * issue command to read ADC.
  *
  * Return: 0 on success, negative errno otherwise.
-- 
2.53.0

