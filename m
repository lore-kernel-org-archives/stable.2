Received: from d.mail.sonic.net (d.mail.sonic.net [64.142.111.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071243921DB;
	Wed,  7 Oct 2026 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791399331; cv=none; b=HFw7Qg0ySayNnRyVCvTc6z/nn7WQ0HGUTV8Xgls5CzN/QfmPahRS+rn01SbZNDYAm7j0jhsxHiRlbmeab0R7m6KJOA01MDouhihuTwA/FOWgf4rErKblUuTwRhiAMx/tF3uCucn3GNN8PAkEBxjfDK+/8+UOKdwNFofuh9PUfrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791399331; c=relaxed/simple;
	bh=KFWCdC7F+yqj2Ovw/sONna8iCtQg6kTLqqcuDAhdyjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1l2SnY18tPS+HmGlqFl7X8tiR8TO10nBfIVAQFK69hT+guu7qsNRv5P0Iq8ybYhfA52DEpOqSCoxb+MsDzfuVmOIdhpqnjNkNHq3/c2HMHZN5YEc+ki8ZMnBDWmdbGVAl2rvjHmy5Pb9PD1HCwK6WZlO6LW048f9Iq5l8U7/Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=murgatroid.com; spf=pass smtp.mailfrom=murgatroid.com; arc=none smtp.client-ip=64.142.111.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=murgatroid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=murgatroid.com
Received: from fred.murgatroid.com ([70.134.61.105])
	(authenticated bits=0)
	by d.mail.sonic.net (8.16.1/8.16.1) with ESMTPSA id 697IiSJo011993
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 7 Oct 2026 11:44:28 -0700
Received: from murgatroid.com (shack.murgatroid.com [10.0.0.31])
	by fred.murgatroid.com (Postfix) with SMTP id C5ACE2A6038E;
	Wed,  7 Oct 2026 11:44:28 -0700 (PDT)
Received: (nullmailer pid 622530 invoked by uid 1000);
	Wed, 07 Oct 2026 18:44:28 -0000
From: Christopher Hoover <ch@murgatroid.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com,
        Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christopher Hoover <ch@murgatroid.com>, stable@vger.kernel.org
Subject: [PATCH v2 2/3] iio: temperature: hid-sensor-temperature: Use per-instance callbacks
Date: Wed,  7 Oct 2026 11:44:22 -0700
Message-ID: <20261007184423.622445-3-ch@murgatroid.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007184423.622445-1-ch@murgatroid.com>
References: <20261007072329.27806-1-ch@murgatroid.com>
 <20261007184423.622445-1-ch@murgatroid.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Sonic-CAuth: UmFuZG9tSVY6GaOTSycqD4J8b1kPMALoPokGwAkNZbJFoAzhcR8AhKATBoqx/2t3e7qT4bpWHVpjTglg6lktAxHSNeHvGL3lRr5hVQp3DzU=
X-Sonic-ID: C;Gl6WIH/C8RGin5cllaD8vQ== M;LKWmIH/C8RGin5cllaD8vQ==
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

