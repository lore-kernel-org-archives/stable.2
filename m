Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795714195;
	b=wjB91x2LLLpvUX027D/pY8O3gcxuyqFIm1Q0akT2g0sbwdKvczMqeqsxcJ7cF0dclkOJ
	 iBASbBGw8rdaSc21lyS1rF2T93smJ+xwF3+Dn0ln76vuXzHo72s/m47WD3NcWcaxJpVZZ
	 J1+ppdkC6Oz+S1ZTEQRVUlKyX2LLIZCbKgZofvPPtr7uJt3henhUtFQAEKUWuqJiBo/U6
	 U0GTjWhahYCGseRU7o5F5uPaCtdmn6oIqDfm8BggqOlZycbaYI8HWhARAaArFnoyIlYzN
	 y+IyG+PmOYoRccerVz3rLH9LN6d5ixgqwES3Swbn3gENJj8a6HDO69Jiq/2r26gMTSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795714195;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DzFHvLgDyY2Uy1GF4lb5EKHirWOwIsgeGfYY4JG/iaU=;
	b=VG0ZdsQz3d+t4ch6MTrBbW7KSBR0YUPb0euXB1ufHNUJ+6i6pIIZV+RH3t4747eK5YSh
	 /FHUnspyHgDP7U7krTBC5qZ3Oigkn4+gEmgh+om6Qe1+mXWW5IIRMypEeTfmSZ+J72JEv
	 +Tm0O1AdcBeFIUmLKOriMZcimiJSCnzELRgJUJ/wiqekKFfnrQQ6EHZMvXZOaDXGZb497
	 j8UDp0PIuOqF6aM3C/pRXU8hTsEcKeXHQxzfxvtPZPL1FqKL2YBDye1y3BOnTG0T7UG5r
	 edb/7HLb/ytQYsIYM04IkLzqJ16Sw8dcuFwyepwwTbCJF5sGwdI/eQrC6BPSWzs2dFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AeqfTivl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61E9606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AeqfTivl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042D61F000C4;
	Thu, 26 Nov 2026 17:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795714195;
	bh=DzFHvLgDyY2Uy1GF4lb5EKHirWOwIsgeGfYY4JG/iaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AeqfTivlqke0bTXXTqVkBSCa/aKn31ebiBRkjSZ6p9sx8wmD044lEhPGTMnDJ/riK
	 Mt/Lv+Fio9Ihoe4Q2sjNs2/vb2/OSYKrE8dRLljJZZbNhNjcHaNnjWSXFWtk3Rvgnt
	 qpnQzBNZlj/HXqgCvJa+qcELeqmdGlICWH/6kD+swFcHvbUkL8VsHcTT+OHj5wjTQv
	 q1YaNSYVLgYoGTJEHvcee1gvApNUKpzV3IPrbhIql6N4kdgiiP5YSRSfZHXDGsf8fx
	 PMr5AOfsrK8gxdSPpVFmyHQMsoBUEbFfAQF0815RZUXQjBYyAikt+rWv4b3n/bS2uO
	 yTyndv8+7s7YQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shi Hao <i.shihao.999@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/6] iio: common: fix spelling mistakes in comments
Date: Thu, 26 Nov 2026 12:29:49 -0500
Message-ID: <20261126172925.2769957-2-sashal@kernel.org>
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

