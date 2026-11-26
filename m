Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713682;
	b=bIG47Pk+Ze4R527Mp639Qsa5Zw+uk7lirWT5eEEHlVfyOfQ/PFsmVagRyoTou4m/EEqu
	 zKTE3i7vwrqSs8SgrzEES+YGvRroDMp4pjpTr4sE8IpXrsclyLU4eSVxobT4hzmynb6ae
	 lcDEeIPw625pzvVzCCjUD0Zb7GHRY3yDydeqJ4DzeFWB15lbJkS5O1pZdy2pJMDlrsShj
	 HuTRbUc/AUAQrm4gWzHuHjMaKQL5wFJzfPY2QtMLcXj0fRvpqRUyUsqZk4zEgioj3WFYU
	 +atnK+pf5JTvUO3PEj+CD8qfOpAgeGKeDRRfoqb9HyOps7AwSLT3xiKTU2ASuSiNHig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713682;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XrMHoJvj01dfZrLo2CMmP0QJOMbZ25H8wfplKgbBUd0=;
	b=mVNnE+lgv1xv+beU3oalibVWM6LcsEDZmhRVTKnrroomJxtA0Yw8jLpGqXwDrtjkFh3x
	 IAki9mRimDkxjbR0Yx0eulP3zX60bLjrkwcfzicMiXto4CuYFSz7PKcpzvZIFse6dYnmD
	 yavnLOlhQKAsm0gUNJM7IRbcq6iEpIlvgkjPJT2rnvKH2XmF0dhHtZBKdJMVLJypDOCUF
	 fbAWYsKxupepYbeaHGD17jd25d1HOdTA7IGG/Mkw/URAiZV/9nMCGROh73E2bwEK1MLdG
	 nEdu/ojFP80Be3+2kOpkID/sxIUkB1PsT7RJ+Q9l1KpQjzJeKn6m8rsRpztFF5kha6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KWqEAeQi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162D6606A32C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KWqEAeQi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F19E1F000D4;
	Thu, 26 Nov 2026 17:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795713681;
	bh=XrMHoJvj01dfZrLo2CMmP0QJOMbZ25H8wfplKgbBUd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KWqEAeQiR6Ddy9OhhkFrCT2VBNvfieLTxbq7HtkmizAT0cgmkFb/plcAU0XaXxnCg
	 dsiFBYdoeb+oRJzhj7569dB++rCwONe0nLqcth0hWhNII1JJvkwfqR867xBrTkQps0
	 siJ7BjfZb3tHBSrNNtiTJY5nZjwa7VNVv76z23qVNse63vspOwQrfVqXfdRbC0paRU
	 7whV1L7ECCaRfkTAVvupzfGY5jS4A0/KZyg0m68KC6nEDJ3ttGoP5Xx+ozvdTMMOEg
	 RHegFqUBKNTq193Zq1HZzLnGjtjkflL9hIVcr5l1IQ32uWO4E59QFBsmH8aI85a418
	 +liWaWjX3NVgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christopher Hoover <ch@murgatroid.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] iio: temperature: hid-sensor-temperature: Use per-instance callbacks
Date: Thu, 26 Nov 2026 12:21:19 -0500
Message-ID: <20261126172108.2744914-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112550-remote-flakily-39a5@gregkh>
References: <2026112550-remote-flakily-39a5@gregkh>
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
[ sashal: Applied cleanly with only line offsets and a re-indented removed context line (&temperature_callbacks);) because the base file differs; the resulting code matches upstream. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/temperature/hid-sensor-temperature.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index 34bff7e9f3a33..2b3478c6902cc 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -16,6 +16,7 @@
 struct temperature_state {
 	struct hid_sensor_common common_attributes;
 	struct hid_sensor_hub_attribute_info temperature_attr;
+	struct hid_sensor_hub_callbacks callbacks;
 	struct {
 		s32 temperature_data;
 		aligned_s64 timestamp;
@@ -182,11 +183,6 @@ static int temperature_parse_report(struct platform_device *pdev,
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
@@ -238,9 +234,13 @@ static int hid_temperature_probe(struct platform_device *pdev)
 
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

