Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713362;
	b=5C2YAm/Ga/OHWXTq7DkzBFkd8ASYZHFat9Ka1wGNhREM2UqeDET8Z3bIr8c++hGdixY9
	 KniV7W7G5RB7cASElHGUMAAesNkSr/cfwGUiaov/h7fZxOcWjjovsfKX8f2qa4+uM772r
	 1wvAbTDHxewKN0d23KpP0uYAfcClzbqZBPRIgXsQqYEyTEBn4O3H85zUGctNtW/9k5zS7
	 HFsWo8asZeTfUDX+XpZ+h6O/UV3aLUEbNOMBJhylBzdEZ+0i1eJuAiythuYoLlkEqSj3R
	 Rydg0qw0VwfW81JqWs1j9LLyXzVr8/ZrMH/xrhFQMgOnY4Gnh54A4olSx0DELsuWoIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713362;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ffslj9cvBJykcChWTgR707wxjx/R6V1hlVBNLzQlMb0=;
	b=jyN3BbyaxTyArnt1KsAUTYszY+o7njdvGkn8PCXNcqORDabMMFrtN0BwfLkuLt3XAfzB
	 OaHMc1T5bG/Ks34Z/eDgXqNMEz3cp/o0KGgzQuPe8W6jX1FbHSPERMQ/B3LSk4coAV3X0
	 buUc0xzy64nUvdn98OnLD8lquziiiQWGW4rQ3Gb+pInJgKHI/9TN9ue6mqtG/vDnCOBPq
	 ROL4c9PkUG8lWfB3Aj30oU3kxjwZ+l9eV5WMNrBN4zeHig7Rv7vwrG8LsoDr2uz4U+blw
	 5Yyc3J/EEGgkKya0kdEQkkwdqWjNYNMkj09nLK8JgMpG+SI+GlVka2SakRNN1etNkYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fX+Kj6PC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BE5606A330
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fX+Kj6PC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C05B1F000C6;
	Thu, 26 Nov 2026 17:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795713361;
	bh=ffslj9cvBJykcChWTgR707wxjx/R6V1hlVBNLzQlMb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fX+Kj6PCw+yN/7YWsY23Z6uQUsIUUhJTn9H5gMQQ/eqLOugB6UtpEzKzeC1LiL+Vr
	 8/kITinghRJJ7hzijXU8AJ41yO4BSE97VDr2M8XAGeCNLH927hQ9RvaIzalaHpvVcP
	 obCj3Nvnl7gEmkhQBIlL+ea0CPtz+tvP/m5QDhiVMVfG9003rPcRcmMMbXKnIafs4M
	 mttDVylIvqIPAL5wualKdgIDXygwDR2aYxDLLa/0t9Hz+TaMOi7YTQhegBL3+YXqSZ
	 Ent9x8Q3tE7IGWJvuyQTxixklsqCKxxt5MwhOdYlQQmkbMu1DJ1jXNNkOSf/CCrU7g
	 8rsSnnY8b6A9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christopher Hoover <ch@murgatroid.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] iio: humidity: hid-sensor-humidity: Use per-instance callbacks
Date: Thu, 26 Nov 2026 12:15:59 -0500
Message-ID: <20261126171544.2742732-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112546-surround-spotting-142e@gregkh>
References: <2026112546-surround-spotting-142e@gregkh>
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
[ sashal: adapted aligned_s64 timestamp to u64 __aligned(8) and fixed whitespace/indentation context in the sensor_hub_register_callback() call. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/humidity/hid-sensor-humidity.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index d62705448ae25..9c336b81aa966 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -15,6 +15,7 @@
 struct hid_humidity_state {
 	struct hid_sensor_common common_attributes;
 	struct hid_sensor_hub_attribute_info humidity_attr;
+	struct hid_sensor_hub_callbacks callbacks;
 	struct {
 		s32 humidity_data;
 		u64 timestamp __aligned(8);
@@ -187,11 +188,6 @@ static int humidity_parse_report(struct platform_device *pdev,
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
@@ -241,9 +237,13 @@ static int hid_humidity_probe(struct platform_device *pdev)
 
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

