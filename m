Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795714099;
	b=afWyEcfKUQ004hmlc/9pN3GFMeyUM0W8r70m3DOZUnFlOEoLokry8WKxiyCKFsD6Fdia
	 CEtHaoe/Y7TitSuOMXpGcn5c9HEPMfBsHI5Qn3235Ag0SJ4pY4xZaKx0Eu2sDHA5U5ozZ
	 thj/jrQY4KkbgCpk2IDzcDRTh8ZDfSM//tY1ZBqhQPu9M9mTug8boCvUY4+7u1o4ks/VD
	 g8M/4HhRCUxM0XZZOjJcvC8olwdVyaUyTApyDktLcxqJy4evgwM1tdy6p2jTouzUQti6L
	 j2jqGyd07awI2dK6WSb5KJvs+Oa0YzSWseii0y8af+3dpGlMzf5nrE7l92rhlM6lOTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795714099;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Vs1GkSloMY1BOP5YhSVkh69f27m+Heff+jj2OUk7H8k=;
	b=IHaLTACEz1+IiiTG9X90+VCVG6PG3gCzh9N+yyx2LKhgXZe0m65Hglma0l/EsGyX61o3
	 eZsrGSy4ZVOIq8KS/NyqL/qBH5Z1W+a/4qB6W0tdgY5fpR2WU9VRwQ6rnlzFUPcwZE+dr
	 EM0MGg3tPPdx/1IewJWVW7+inUwkPl+wo4kQCZS8grcdHMj6GCNBWAnx0S0ukUUBXSzSe
	 xIQkocC5N7xQUo5zVQXlsjrY21gbmKDqVmacr9zkYEnHkdnTG5/5Xz/XnSLx0WdyDmLUb
	 bu7FFepy6ryhLmRxcGSJ4xRANxXG0ZP2pD/UTXGY15538XCes0vJMzyfxa1+dsu2qWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HCBNtUtN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AB3606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HCBNtUtN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638321F000C4;
	Thu, 26 Nov 2026 17:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795714098;
	bh=Vs1GkSloMY1BOP5YhSVkh69f27m+Heff+jj2OUk7H8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HCBNtUtNoNIifpaYh/gYUkczLJlnZqLAbqSKJDPPUIH6CU3uO0r/xvP0Wyx2VDGWH
	 eG40z5ZPSDbQe4OEBkGsBGqB7gdQVyZK++QdpRyvJp9MXmlEiBg0Fsa0hPOliub3pk
	 1AJDI7bLWgZp3fn3+VSR2DdAURMGnRF/dR+MuUXOnspc506rBKIIy6b8mAa1LHxUsM
	 zWV4lP3Hp7xk/QqK4ehgTt2ITBy65iqv3yRR9VzA7lOK2pQ4ELdqTkDWNhqNkjg2sG
	 ahmmNJw3CyswrhSlgjeI+O4lHeir70mYDOq6/i9gnSGHf7yd87v16RySjAhyU7kQqR
	 X1r35mQ5j2Hpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christopher Hoover <ch@murgatroid.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iio: temperature: hid-sensor-temperature: Use per-instance callbacks
Date: Thu, 26 Nov 2026 12:28:16 -0500
Message-ID: <20261126172804.2774636-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112550-handcart-squabble-25a3@gregkh>
References: <2026112550-handcart-squabble-25a3@gregkh>
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
[ sashal: adapted to the older tree by using u64 timestamp __aligned(8) instead of aligned_s64 timestamp in the context, with a whitespace difference in the sensor_hub_register_callback argument alignment. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/temperature/hid-sensor-temperature.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index 3cfd51236e4c8..546f50f0cc6f8 100644
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

