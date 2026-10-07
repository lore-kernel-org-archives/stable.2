Received: from c.mail.sonic.net (c.mail.sonic.net [64.142.111.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAF933FE05;
	Wed,  7 Oct 2026 07:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791358489; cv=none; b=gXdZ0tbab+JWuPD5F3V5qTk/JvTbspZI90C5RJM5fFdLOAognpq4Jn4uV+3dJ0qy6Cc7NrY+KLET6FlXoilyyCtk/A/wpp7f2yCoInvOFXi1Y4cSzTxht/lmOBf8/Dtc+xbt3mRxUt+kH/iG82GG1GNYwYt5rPZiobPUIPI6vOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791358489; c=relaxed/simple;
	bh=KFWCdC7F+yqj2Ovw/sONna8iCtQg6kTLqqcuDAhdyjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nM/chYgLgC6MoVHktXkFWPiJodJBn2YXKWnY48yaIvcomHj5gYlIXPiUSZMuklhrq5DIzo9Mh9erm2iCah0GbvsKRa3XbjBiGquo/mPRFV4kguyujc7OLrB7OjvbGact7pg0UslC1OQmXVriGQv2gVkl5ugLQAoMudDreAzCd/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=murgatroid.com; spf=pass smtp.mailfrom=murgatroid.com; arc=none smtp.client-ip=64.142.111.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=murgatroid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=murgatroid.com
Received: from fred.murgatroid.com ([70.134.61.105])
	(authenticated bits=0)
	by c.mail.sonic.net (8.16.1/8.16.1) with ESMTPSA id 6977O9qU013483
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 7 Oct 2026 00:24:09 -0700
Received: from murgatroid.com (shack.murgatroid.com [10.0.0.31])
	by fred.murgatroid.com (Postfix) with SMTP id 3BC612A60489;
	Wed,  7 Oct 2026 00:24:09 -0700 (PDT)
Received: (nullmailer pid 28315 invoked by uid 1000);
	Wed, 07 Oct 2026 07:24:09 -0000
From: Christopher Hoover <ch@murgatroid.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christopher Hoover <ch@murgatroid.com>, stable@vger.kernel.org
Subject: [PATCH 1/2] iio: temperature: hid-sensor-temperature: Use per-instance callbacks
Date: Wed,  7 Oct 2026 00:23:28 -0700
Message-ID: <20261007072329.27806-2-ch@murgatroid.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007072329.27806-1-ch@murgatroid.com>
References: <20261007072329.27806-1-ch@murgatroid.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Sonic-CAuth: UmFuZG9tSVZS79vPP/nV46EWbGZkBV8t3XI++KuEDF7PhE1AdM3Rv13U1dHOJOxnjYRJQvw3qcepWN7m0RAwX87EyREDkkidjZzUhv5dB3k=
X-Sonic-ID: C;NpE9FiDC8RGjxfEWvTXIBA== M;YgdQFiDC8RGjxfEWvTXIBA==
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
---
 drivers/iio/temperature/hid-sensor-temperature.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index 5e3262e461f4..35b8643305b9 100644
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
@@ -237,9 +233,11 @@ static int hid_temperature_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, indio_dev);
 
-	temperature_callbacks.pdev = pdev;
+	temp_st->callbacks.send_event = temperature_proc_event;
+	temp_st->callbacks.capture_sample = temperature_capture_sample;
+	temp_st->callbacks.pdev = pdev;
 	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_TEMPERATURE,
-					   &temperature_callbacks);
+					   &temp_st->callbacks);
 	if (ret)
 		goto error_remove_trigger;
 
-- 
2.43.0

