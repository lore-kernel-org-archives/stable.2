Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795715100;
	b=bd73uFMsZSHOCiVSoVkkKLRBzh7TsI2dn/QCN2X37N5f82ZRaK3h92Oz6Gw/fUYOfvoG
	 OaZtVqgLML4DBLJkrvwmPtCvknQTOBPU1yuXxaWCPH92M/BRcMt8qIeH4dhUzGbl/IFUW
	 UiVboI71irMBXjHK441/HkldqnJ4PA3PkC5FZV18tNx+C/+vLP+irlAtWUcMptSohTiat
	 M2U/NzyQbzMSbeeOg7ksvsjRBnuOhg1i2Otnf8O5RCFAzPnqyXQ4PsRwouI2OIoVPUE2a
	 ToRA6rR0czyYIwEtqdB34lUY9kxUY8qIdTwfI2zMu3nxTX4hr0a5W3UDa87B+rigrNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795715100;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0MTNa7U3eTjhKPADVUt0ILFr8VtoCEczmNpzhN+XDdA=;
	b=i16B/Cpm0farOwHSEKhxOW/eLG8uYo4d1VDBwEMZRqtRvB5EoNwWkrDqBGy1OnbNugeq
	 k46vRhmY84/13SCJ0lxhzbUOLp1IY/WJz6itdlVhjYJuD7zRbDUJrFY+dZI21LI+c2Qsb
	 XJ5eSa0kK1brLWaLn99TrqYVjqhnqpxBcjPkvOhJL+0aBdrjSWHPcIBHmKjn86NhyXics
	 +qTI0PWXGnU/2cOwzfVPzYRF4re1tOFW0Gvj5VDDKU2w7kyUoFkeySYefoiOx/YDWWByI
	 Xdrr3kGSXii4fn3FXYP4PCibarGbX9yEl+GTKyU34o1T6KET72qGP37s9+NCuAtli7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+tgJaIw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21ED606A323
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+tgJaIw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE8D1F000CA;
	Thu, 26 Nov 2026 17:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795715099;
	bh=0MTNa7U3eTjhKPADVUt0ILFr8VtoCEczmNpzhN+XDdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m+tgJaIwIbBgY0wxRrqGxOBSIc16GIM2ew/dNG50yn4XvgZp9p3/E7UiFWzT7jLxJ
	 hAP0Do3WTtUUNCGr7VYjzGrCwFX8w5+BE4wd6gdQMsmpKsj7XkwyEZmkJe9LLUyagN
	 yqU9X7o8xWcCF6jxrSsjD9/zlVTbUrB2KPi7QsR/UQbDXdTVRLeqOdCisy4NitnaKW
	 zfvScVYkjhzwEA9HVgoqrDchu2vywqY5zCccDxV/TSgiC+3fO4ODWykh+lE331xCSQ
	 IyeuvHQcFOOGoYsUo/yV+h77KDweaALM2gXjmAxsrLuUL9mojrImxQ103ylZZguLzS
	 uLtDu8zl9l61g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christopher Hoover <ch@murgatroid.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] iio: temperature: hid-sensor-temperature: Use per-instance callbacks
Date: Thu, 26 Nov 2026 12:44:57 -0500
Message-ID: <20261126174444.2832914-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112551-uncloak-darkened-c821@gregkh>
References: <2026112551-uncloak-darkened-c821@gregkh>
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
[ sashal: adapted to older tree: u64 timestamp __aligned(8) instead of aligned_s64, and context whitespace differs in the sensor_hub_register_callback argument alignment. ]
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

