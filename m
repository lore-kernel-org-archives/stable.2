Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795714653;
	b=P9MxS4hpQPxTek24hmz49imQbVayJ89S93aSkxBTS6O9FcnOj6xNvkUywj9CBvPd145P
	 CxEpbFxXFNFzE2ufySvBMOP52sAmX1RjJj/yhxQp4KJAD77LLtIwhZgVaKl4Tb1e369p6
	 JymTu0HsGUkVCnmVsboIx+U5cgM+1ZIS4loa09VpBrNzG2v6CyyQVr880gwaIG0gdGdy9
	 TtzjzFFlZiVVeifHrPKg0QdfANzHVHe8dCLmhw58UOk3nwlHa6tkazTYv3RqD9k+K96Tv
	 wqLLgbvoNJjMEYg2TLGwyG4UQ6SwAM15DfquvXUh8hKW7Pd58i9oCLvaQR0KgrSKkZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795714653;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=D0fgPLR1z4/EVTuFRqQ4PMJkOfinqO6QGlNPYA6x+go=;
	b=Q8DE+yZ2aSyemaXuaFuLjAXRT1zTmxs/wUPYgDjzxsbWc/BrM91In6ehXbMbod+c9t12
	 Rvn8jyUTaaJ7liM9X4HDVa3tUoRk42JQLIDkCfbTWBy68f4MtkRfU1MlpOpdWSmXpKH02
	 uyCLUzDVvVibnb2G2tzRnWG/W2al6VoSLNOeobNIdb+NHwpPKibqGwPAt1LsewQEtJ3Mc
	 6qwS9O1mcxJWoUaC8V8ymC9KFELu7ndqjS727C6vhOhdRQvExS3kWb+GvFMVbmgjRIlLV
	 M3klANEtjsi26riNuw8ZSRINBAcGIlHNAx11Ka5XSK+TDkgZYxgo+MdABonv2bjXSnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bkAZKHBJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC272606A323
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bkAZKHBJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054841F000C0;
	Thu, 26 Nov 2026 17:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795714652;
	bh=D0fgPLR1z4/EVTuFRqQ4PMJkOfinqO6QGlNPYA6x+go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bkAZKHBJwBv9DOBBl0YvB4d1MlhI4vE8d8w3sa35Uzpu37wEatvQ7oJAuQscFs0ny
	 DgBcJ+jt7sFgjOIitrk0CBsQb77mLlxv3bEOPQwBVZI/zBFzUk/aH2cHEsL0CKN9sJ
	 OcXyz+DO8E9SzP5f5u/N7Eqo8M0g8HVt2shjlqGdPyex+6Kvy4up8xNBhQcT4IwQHy
	 5/f4Da7sJBULd3+JW0OhyKYZTzWC4Ymzx0wHzmbn/WemZQJloMfcjR+G1CbmO73FBe
	 ULj5WtKjtbEG+ifG4rgUzFcI/oMJAXdu/QbjR05caurqp3c9Jns5ac+tBsh3ma6wBp
	 4YDutOFA/P8qQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christopher Hoover <ch@murgatroid.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] iio: temperature: hid-sensor-temperature: Use per-instance callbacks
Date: Thu, 26 Nov 2026 12:37:30 -0500
Message-ID: <20261126173719.2825273-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112551-dawdler-operator-d4db@gregkh>
References: <2026112551-dawdler-operator-d4db@gregkh>
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
[ sashal: adapted to older tree: used u64 timestamp __aligned(8) in the data struct and adjusted whitespace alignment of the sensor_hub_register_callback argument context. ]
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

