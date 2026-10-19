Received: from c.mail.sonic.net (c.mail.sonic.net [64.142.111.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD1E35A398;
	Mon, 19 Oct 2026 02:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792377890; cv=none; b=FRhCcRmEROJ0dHMF4b30vTXKt7dG9HeiFRJoZgl/DYNom6Yhp3wmcmRA3/Q5J6qyHe+bxVa/7wcjf0D+5618ZeDSFWywYM3KUIj25L/XOSvrH96S/9ivV9RtxKbPRAomGGzdFou+MFzNmN+gCPWFWGVS1vYqyO54LaEt41lo3BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792377890; c=relaxed/simple;
	bh=lKRdjN1LnFRrLgCWBQD6HasQoii1meKrsL2OjbyDdBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcliWbemSVDWJYp5Gf9mWYigB5ARcsk2x/0QhZNbIyDxNW0urt8Jy23e3/fThPT7UHtToe7BsAzbf8oxFlY7OPf8ogAksX/AdPZ0z8e8PbyQ3Z+siN8y2Q9MbvPflyjWPI/Ek5k27hw97hQbSK2YfS2sINZmq32C8bY0r9EZFVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=murgatroid.com; spf=pass smtp.mailfrom=murgatroid.com; arc=none smtp.client-ip=64.142.111.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=murgatroid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=murgatroid.com
Received: from fred.murgatroid.com ([70.134.61.105])
	(authenticated bits=0)
	by c.mail.sonic.net (8.16.1/8.16.1) with ESMTPSA id 69J2YKVM005970
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 18 Oct 2026 19:34:21 -0700
Received: from murgatroid.com (unknown [10.0.1.185])
	by fred.murgatroid.com (Postfix) with SMTP id 9D3DA2A6048F;
	Sun, 18 Oct 2026 19:34:20 -0700 (PDT)
Received: (nullmailer pid 84001 invoked by uid 1000);
	Mon, 19 Oct 2026 02:34:20 -0000
From: Christopher Hoover <ch@murgatroid.com>
To: Jonathan Cameron <jic23@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <bentiss@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Lixu Zhang <lixu.zhang@intel.com>,
        Joshua Crofts <joshua.crofts1@gmail.com>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christopher Hoover <ch@murgatroid.com>, stable@vger.kernel.org
Subject: [PATCH v3 2/3] iio: temperature: hid-sensor-temperature: Use per-instance callbacks
Date: Sun, 18 Oct 2026 19:34:19 -0700
Message-ID: <20261019023420.83976-3-ch@murgatroid.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019023420.83976-1-ch@murgatroid.com>
References: <20261019023420.83976-1-ch@murgatroid.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Sonic-CAuth: UmFuZG9tSVZ0SxVvhNTiBLz81PD/nrDu50/hhhPGREDGAzaaeDKCotX38q+fxtsiJH7MKq0SAXXCEPyQxQOvFhayH6S/tKeIa6YjwZVPf3w=
X-Sonic-ID: C;XlbMlmXL8RG92OXouUKo1g== M;4uT1lmXL8RG92OXouUKo1g==
X-Spam-Flag: Unknown
X-Sonic-Spam-Details: not scanned (too big) by cerberusd

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
---
 drivers/iio/temperature/hid-sensor-temperature.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index 5e3262e461f4..4bc9d42a0301 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -14,6 +14,7 @@
 
 struct temperature_state {
 	struct hid_sensor_common common_attributes;
+	struct hid_sensor_hub_callbacks callbacks;
 	struct hid_sensor_hub_attribute_info temperature_attr;
 	struct {
 		s32 temperature_data;
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
-					   &temperature_callbacks);
+					   &temp_st->callbacks);
 	if (ret)
 		goto error_remove_trigger;
 
-- 
2.53.0

