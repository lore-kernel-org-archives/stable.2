Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795712394;
	b=JRLqAVxuCrgCwSgpo9A59TQf5BH956KbhJFtpPNaa0YazL77L94sY8U95o/DYTxa81xW
	 YirxlSpp23oXDAaltWaySjSH42BJswrj2v4pEtFxnbbYr9P1jSH47BXGUbqZW5k9nEvwJ
	 QdqzsS4M29Pvri/2KytyYIrPncYaT6EkbskQM20DoheV/oagIug5CsB0vHe/3pD/DnJeB
	 ALUJpFKyTzV0+7MRKEycQEjVFK0qfe8mR8x+RDTD/a2z977tXhwBd69EXPTZB9NPxLk9p
	 gCrTBZ3NacKuKxWTHMbKmM9KGaABBj2mqMLL43bz4fTytT2m/uCy9HjEZhzOUiiU5hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795712394;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=r/nNEz2eJjWF638dhR6ZN9ytCIBiNk3aCoLpUSRGDtM=;
	b=CqyKHJDRB952+/WRp7pSSGKkFMXutYdvaUD54QpgKqv8O552bFAoJ1Rr1k46exWArS+1
	 PRChFZGdFJ3njW1Kr6GhDlTXs2pxG1FWrv2KXOMAUEekaEiNjS98zQnggkl7WDMRHbrXb
	 e7u/i7XzhHMpdN9CeW5wSfnmck8byiU4UWZ3VAFJeOLcDHUEsN3hCto+jdhu1m+Dg59WP
	 1ULI3bShZq7obVuEyB5B5tWa7NzzHATtmaPCSO0KeghsxBx95fNf8Bz/KiJpr/uXX31hl
	 /oKV9QOcquOM5mR6vkipXydcMxqZypw8XPDN3gpxQXSygVSPxzFeJooiEtoW8rFzHHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ETZFaCqk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EC8606A326
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ETZFaCqk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9A61F000C4;
	Thu, 26 Nov 2026 16:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795712393;
	bh=r/nNEz2eJjWF638dhR6ZN9ytCIBiNk3aCoLpUSRGDtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ETZFaCqktw6GJdIfZTNn2aObJUq6v7kjXFAzjVzz/1UhGzE0BfisA63s2XRCAplj1
	 Q9cPXnTR1TJij3GBPAWigxFRb0uXueFlt2uIN4ka2v61yrqJSQpzjgmX6uq7KfHghR
	 BMHerth6PxvF+nfrKcsApq4QaLrelmN51vkjHnziPVXgphFFRvdAwFzXtv3pm+BZop
	 xiHjosm1dw/s919SnwnppnIA8nO+op/9+apN84ao2JqRaDE7eskjQLf2hI/I30SRwV
	 DiNpzacrNnTkj6nko7S71Fc67eSExmFUmrBod9XNcpovSIEygkTa3OCjf3tKBUr07L
	 jt7TzD948Kttw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christopher Hoover <ch@murgatroid.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iio: humidity: hid-sensor-humidity: Use per-instance callbacks
Date: Thu, 26 Nov 2026 11:59:51 -0500
Message-ID: <20261126165941.2680179-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112545-shakiness-blitz-8284@gregkh>
References: <2026112545-shakiness-blitz-8284@gregkh>
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

[ Upstream commit bbe4f3f668babc9443fc1f075695e43e17ca7976 ]

hid-sensor-humidity keeps a single static struct
hid_sensor_hub_callbacks for all instances and overwrites its pdev in
every probe, so with two humidity sensors, input reports for one are
delivered with the other's platform device, and a NULL dereference
follows once that device is removed.  The same bug was found in
hid-sensor-temperature, which shares this code.

Keep the callbacks in struct hid_humidity_state, as the other HID
sensor drivers (accel, gyro, als, ...) do.

Fixes: d7ed89d5aadf ("iio: hid: Add humidity sensor support")
Cc: stable@vger.kernel.org
Signed-off-by: Christopher Hoover <ch@murgatroid.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
[ sashal: Adapted the timestamp field from aligned_s64 to u64 __aligned(8), and fixed the whitespace in the sensor_hub_register_callback() argument alignment. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/humidity/hid-sensor-humidity.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index fa0fe404a70a2..b13b20a36ddfd 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -16,6 +16,7 @@
 struct hid_humidity_state {
 	struct hid_sensor_common common_attributes;
 	struct hid_sensor_hub_attribute_info humidity_attr;
+	struct hid_sensor_hub_callbacks callbacks;
 	struct {
 		s32 humidity_data;
 		u64 timestamp __aligned(8);
@@ -184,11 +185,6 @@ static int humidity_parse_report(struct platform_device *pdev,
 	return ret;
 }
 
-static struct hid_sensor_hub_callbacks humidity_callbacks = {
-	.send_event = &humidity_proc_event,
-	.capture_sample = &humidity_capture_sample,
-};
-
 /* Function to initialize the processing for usage id */
 static int hid_humidity_probe(struct platform_device *pdev)
 {
@@ -240,9 +236,13 @@ static int hid_humidity_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, indio_dev);
 
-	humidity_callbacks.pdev = pdev;
+	humid_st->callbacks = (struct hid_sensor_hub_callbacks) {
+		.send_event = humidity_proc_event,
+		.capture_sample = humidity_capture_sample,
+		.pdev = pdev,
+	};
 	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY,
-					&humidity_callbacks);
+					&humid_st->callbacks);
 	if (ret)
 		goto error_remove_trigger;
 
-- 
2.53.0

