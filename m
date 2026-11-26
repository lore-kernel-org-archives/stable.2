Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713626;
	b=gY2Y2Dm1zu/mPoyiqBN+iSgqSVeClkZQiVCwbJuz9360060hqh1CVnBMrF/0xW4pK6/8
	 j2M1edYL/AxIKiMr+7c38T/PLpmMg9Zu0m2r7OKYCclYyuuYz4+LXy50aJ6LdvkrjJQQB
	 yAKptSdGTzQeWpWNledQ+NPJhsqL92Tj8dH8UWeGaxdHMahkOxChHSdbRH+WrCQUzogAe
	 TgZwAnZreeuw5CUEricIMgTor7820Ao8ajReIwrqcHCUMbIEwwIDqKo+H5geDR6di1Skz
	 zt6B6QIi/+HSNA3lhLniwQXYBvBVhgKEppOCC7F41PfYZzRPVTdiLSPdd0qtxbGrOVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713626;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DzFHvLgDyY2Uy1GF4lb5EKHirWOwIsgeGfYY4JG/iaU=;
	b=B4G6G04JZ+wRUgJ2ulcRQqJTQC2Z+GT0y383gs6Lfuu03/ymPvI1vc66u/qoJzobkpau
	 cmlVsRvLcvpeQIL3QYt+SCcvGbnf7YEayzM/sd/1hF2EbKzoUozThbW+dnaEzqaEH8cSm
	 LCiZKpaggdC0aZ2AZWZfTKJsa1rnUcEzp+ghw6gOxIeXE20WobUBkPZJtHX0hpr5s9RdR
	 xo5oLaVu1gLW1yE2oKcaJC7rODgo3IZKq3KwxyOIZSfiM10zKMf0Q+uJLcAphuTAtxABK
	 eaqYlUtiGxKgXF0A0CD4j+LVZspDyPgS5hqdWTf89n+08dyWNnoOD7IwzJp44kSavxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KLmf57rO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEA1606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KLmf57rO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867961F000C6;
	Thu, 26 Nov 2026 17:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795713626;
	bh=DzFHvLgDyY2Uy1GF4lb5EKHirWOwIsgeGfYY4JG/iaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KLmf57rOr+sONVZWH2FhVwbGZtCNAoDYm1+MYcfRkWj8D8B7TkV3sa0kZxk1zGA14
	 oZ5IsOp369xYlUPe35GzAHKViTJczOx/1R9V4r4BHARVgJklJjp7Dxq8KEDma+SqrK
	 0s2yboonoIYhtnlVeHv2yGzIRHFkRe6Ms61UVbCRGhmUzgrvb5wUMrLCMPOoevFki1
	 ckuc3TV5F1c4IQRatjklZjcKIJaD9HEMt62JPpc6WcveeNGhXeRCRLi1045yKs/sen
	 SqarwggcxyjAO5a2YKolcTBwIPBUMTt4OHiOh/G4JdU6PAKZiV+W9Estyadmmd+A6G
	 +F1zkykOerLJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shi Hao <i.shihao.999@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/6] iio: common: fix spelling mistakes in comments
Date: Thu, 26 Nov 2026 12:20:19 -0500
Message-ID: <20261126171945.2727003-2-sashal@kernel.org>
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
index 66153b1850f10..58c935e182639 100644
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
index 650016e4a40fc..065efd1ecf476 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -352,7 +352,7 @@ int hid_sensor_write_raw_hyst_rel_value(struct hid_sensor_common *st,
 EXPORT_SYMBOL_NS(hid_sensor_write_raw_hyst_rel_value, IIO_HID);
 
 /*
- * This fuction applies the unit exponent to the scale.
+ * This function applies the unit exponent to the scale.
  * For example:
  * 9.806650000 ->exp:2-> val0[980]val1[665000000]
  * 9.000806000 ->exp:2-> val0[900]val1[80600000]
diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index 327f456b53c5c..883cb08806be8 100644
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
index 9c9bc77003c7f..b67453bd31f81 100644
--- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
+++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
@@ -96,7 +96,7 @@ EXPORT_SYMBOL_NS(ms_sensors_read_prom_word, IIO_MEAS_SPEC_SENSORS);
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

