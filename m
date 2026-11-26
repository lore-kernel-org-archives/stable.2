Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795714367;
	b=RV5lSA2i693fazCj0aD8Q14KEzCjREDirSqQcv4mkWQpYU7RpdEIvLMjC7+aLblQq9sR
	 AvF8k62EMwsS2qixrClQWNbvOJwuKsdxQQUR4VWXsAXAMz17x4QxxB8fHTLD03P7vws/B
	 0d4fHhW7RJtyArvdqy6ePvWqehgjtemJbmYPlK7m74d5d2vJ4xAM2BYqVkVQTXeqWC7Ri
	 txnUUaEv+Crvx7lptMX5PVV8f6M3OFh6J3MEVG/VQjFE3OVhPpXoNKDMMbAFPJY7B4SFI
	 e95Q0cpjtG3NmFsRlka8w2R+3NwyWM6OM9DiYnE7enasmXkXmsun1YicGiYSwYzbHMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795714367;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mlUO+WVAxLOzu+o9hGrnbwmco6qWz8VA6LcwiCErpBc=;
	b=fUiMQltPnEF3rP0lX9b082q3WAweIar002B3sp53LR3DTdwvA2gFCg2RmxqyfSOZIh52
	 LWo4dTX5HZK9U8W8TpmtHypcilJTzI+9PdRSZkOB7yaD8GlCCQDAEzyySzlEstjia3mRV
	 tzo6E1/EefI6VxLt65ienT59kLkq5ZS3D+CTrHuJB8wzjahNR/UKfUW/ZE26lP2v0+uHY
	 d4E41JuRKcH6H0QWzXsCDf9QBBkAtiaC1ybYzAsimjsTZGBhy2QTJ0QzkQYDkdZhr9iZm
	 pjEIuVstP0FHiEK5BIVpwfKwDaE0tfSI+h+dn/YpHFj9xKHgDQLlIx4j3CvDibzmhNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hlCI3pXt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED884606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hlCI3pXt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B041F000CF;
	Thu, 26 Nov 2026 17:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795714366;
	bh=mlUO+WVAxLOzu+o9hGrnbwmco6qWz8VA6LcwiCErpBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hlCI3pXt+Abb0FPsaIlvgnhOkhxZTFk/7F7qpAcfuXVLjJNW7TwCDsYaJLSInpbDF
	 Jim6zglqUvn4u+wXlT8YyaYp7fN5ufN2YTESxwBgjW9XOGFmmIvCmwRyno56Xzl1rB
	 s0E7UGID2zP6l3gW/rr46RqiCF9hJpjA1kbSmTiaDpT4zmwt/IsalCH8smMUIdhed8
	 liugWm7hz8RqDu5gpKUB9KE8VjUOl3ZZ2dCN0QNxH2xr1iscthzD23GqOK+y+PPrMr
	 VtFqJCra2fX+bbyt9V14aGAe7LTrytLKARLPKdNoCP7yDAfKCkAbQoQKwlS3n2mIR6
	 X0Oaamd4/UiGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christopher Hoover <ch@murgatroid.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iio: temperature: hid-sensor-temperature: Use per-instance callbacks
Date: Thu, 26 Nov 2026 12:32:44 -0500
Message-ID: <20261126173231.2809777-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112550-kindly-shone-5215@gregkh>
References: <2026112550-kindly-shone-5215@gregkh>
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

From: Christopher Hoover <ch@murgatroid.com>

[ Upstream commit 36eeb26031e90eeb81bbac3d3acad61d23fcbdf3 ]

hid-sensor-temperature keeps a single static struct
hid_sensor_hub_callbacks for all instances and overwrites its pdev in
every probe.  With two temperature sensors, input reports for one are
delivered with the other's platform device; once that device is
removed, platform_get_drvdata() returns NULL and
temperature_capture_sample() dereferences it:

  BUG: kernel NULL pointer dereference, address: 00000000000003a8
  RIP: 0010:temperature_capture_sample+0xd/0x50 [hid_sensor_temperature]

The oops happens in sensor_hub_raw_event() with the hub's spinlock
held, so the hub's removal then hangs.  It reproduces with two uhid
devices that each declare a temperature sensor, one destroyed while
the other still sends input reports.

Keep the callbacks in struct temperature_state, as the other HID
sensor drivers (accel, gyro, als, ...) do.

Fixes: 59d0f2da3569 ("iio: hid: Add temperature sensor support")
Cc: stable@vger.kernel.org
Signed-off-by: Christopher Hoover <ch@murgatroid.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
[ sashal: adapted to older tree: aligned_s64 timestamp is u64 __aligned(8), and the sensor_hub_register_callback call had different argument indentation. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/temperature/hid-sensor-temperature.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index ba735d758cb44..a96d9a5e35790 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -16,6 +16,7 @@
 struct temperature_state {
 	struct hid_sensor_common common_attributes;
 	struct hid_sensor_hub_attribute_info temperature_attr;
+	struct hid_sensor_hub_callbacks callbacks;
 	struct {
 		s32 temperature_data;
 		u64 timestamp __aligned(8);
@@ -181,11 +182,6 @@ static int temperature_parse_report(struct platform_device *pdev,
 	return ret;
 }
 
-static struct hid_sensor_hub_callbacks temperature_callbacks = {
-	.send_event = &temperature_proc_event,
-	.capture_sample = &temperature_capture_sample,
-};
-
 /* Function to initialize the processing for usage id */
 static int hid_temperature_probe(struct platform_device *pdev)
 {
@@ -237,9 +233,13 @@ static int hid_temperature_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, indio_dev);
 
-	temperature_callbacks.pdev = pdev;
+	temp_st->callbacks = (struct hid_sensor_hub_callbacks) {
+		.send_event = temperature_proc_event,
+		.capture_sample = temperature_capture_sample,
+		.pdev = pdev,
+	};
 	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_TEMPERATURE,
-					&temperature_callbacks);
+					   &temp_st->callbacks);
 	if (ret)
 		goto error_remove_trigger;
 
-- 
2.53.0

