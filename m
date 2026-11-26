Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795711909;
	b=nY8Ptt8XZEkwhmKLDrSOfmZXL8XhXwlbtIzv9cgmVxPFPNwcludTiefGZfycC5hp5K4f
	 XJuqSwcGJjVlpog8RonavT/o2w9VBTTs9EV36U13rsmV/ZDXaurznvLJ+OP3E3wFQeCkR
	 /3GiojjyQhvSg7ErhP25z9J1Iop22KUfyCWFolv9NS5KteyeARqdd45/m8THlMZ6bX3Te
	 OZhki27WUO3cngI3JXkX6tVlZR8sP2i3zdHlk3K/NSWnchxaxIR4x6MGxBmEHn6vYVoid
	 SIv2YnSmd6twZuOYP4ndM0BESdzETv95iDeRcYXNUThGzBrwBwzOTv1nP72ISgAS8UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711909;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gPZzmTvQ28r5cAcfyOxGZuE4D/6Q/iiZzfwll5qWjb8=;
	b=YDLHYcL3iG6JwVB2v1ratmGdHjpFYSWyhtWMkQRfyTzenpUFRo022HRZ57y2mMNhzivO
	 M+my3gWw6RKl3oRcNIQ0ICoCpsNkvX1NsiE1+HGkyC3JV5ThhipFJBY4tdZf0aYKAVtjd
	 elTSZlN7wfRLFXqyfQgKYUxKjFShwqA3whD871AVC0ovXLuKTUpyuqJcQckg8HEeMT+JJ
	 UzBL3K9QVdQQR/vSGNdm63CN6SLJAAJWlgJqDxzV08ol7yg9H1LotMXibYNWEf7ixsJds
	 J1SAuf36LAGQLPrS7cFqMCVmMpwb3M1aj1wJH0p6jEwVYAddk4lmWIYzZwkRBX2mXpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VfVx14l0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14C0606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VfVx14l0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29D21F000CA;
	Thu, 26 Nov 2026 16:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795711908;
	bh=gPZzmTvQ28r5cAcfyOxGZuE4D/6Q/iiZzfwll5qWjb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VfVx14l0oQ4yyk0FxE0HcjypV73/PSsnOcUlwMUAPbYz2HtUHetf53syfBT3gEFmo
	 J1RVNO/Df6n8WGEw+3AGAblwJ6KcRLGXNhz/5UPN3TDW+wKfqmLmYK+8dZsmARCzgi
	 V80diKmfM4US6QBE8RSwucuC7KditNvBaHLqCImhys2dP/HSh3pzDvPYrpVe+k4tJc
	 43mXyFB10wWj2LtAmU64Z+7MLbINfBLbXyqk5YAX7eXUuGKMZ7SZsZwzqEeW5eEaZb
	 zW78FlcWim4/5jmc2JT6jIEf+nyL5i5+Wa/AoiWG5Uoj9atInzJXLJsvIA8+UXMXJa
	 ENWB+fi/y1apw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christopher Hoover <ch@murgatroid.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iio: humidity: hid-sensor-humidity: Use per-instance callbacks
Date: Thu, 26 Nov 2026 11:51:46 -0500
Message-ID: <20261126165136.2661051-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112544-defection-extending-3aa2@gregkh>
References: <2026112544-defection-extending-3aa2@gregkh>
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
[ sashal: Adapted the padding of the timestamp field from aligned_s64 to u64 __aligned(8), and fixed the continuation-line indentation of the sensor_hub_register_callback() argument. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/humidity/hid-sensor-humidity.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index bf6d2636a85e7..7c9ae77f33f49 100644
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

