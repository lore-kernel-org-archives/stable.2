Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795712727;
	b=AxMJzIZJqInG1qnyu8xljr1FTtQNCcJjv64akrolqia/1wqr0N49syGYt333biRe3CUa
	 59LidjwGpbflXoKJa82lS3dg4OhSNSbLVnR9YGIbEqzqEByxBCvD/QJH/ZjivPrA/cliW
	 hRZS2LCRM1zGQnpjmcHmeg/NGIdwcPchlPpTQ9GXN6Paj6ZYDrcJmowbw4NlPDtXiUVIA
	 ttkqtC9bZvWW3Qv51Wy5VWG93ugScgilD1mDRju9S6j1V23KFC2FRNuXHLjyf+6SnCpML
	 SolO39W536pHFRqtElPTNSlwo2WFwoytIfvFzNq+ijDIQRjYre7ypGiS91r5NipcBOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795712727;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XsrX+86ErukwT+djG4Psf33sigDWrdUb7wezRAylfYQ=;
	b=ugVGUB5ri+PlVjSrS2Tj7TuaYIakTqOcjaty91dhTxx7NMUs151VbIS2f3L7F4GsyPV6
	 fn10LbZLGHjcetgOzfD0G8JeHPkutj15evNQH1kQCQLVhNTHmaUz8ZZeLqC2lQGgfDXTf
	 UT7ig+xyZVMO2VpMGyEvh5cqh6ICi9Z1r8kpv1Rln0yeHFzvOhgE3O90z1C07bZ5NDdCh
	 i31UgvKMeagJ6Hb0Dv40YoZsbDUw0U5NXNrNQq/nr7MhfblPjXi+vcHOUDNaSeKBtH/5G
	 nSZayskuoM9vo5HFzVXgL14l5DhQfoubXZ4E0SgwiAsQQMgI6IMOFaTFPYrGm9tMKxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XpRsfQ+t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E434606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XpRsfQ+t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DED1F000C4;
	Thu, 26 Nov 2026 17:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795712726;
	bh=XsrX+86ErukwT+djG4Psf33sigDWrdUb7wezRAylfYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XpRsfQ+t4F3100K5CYavdP2TTCUrZW6+rUnTdqFkYOnMFPYI8OWumkuluMpJXluQ/
	 HEYLl7uznHA/T3lVRFGyEx1J2MANeMW9yqqYQVOW1i0/Swuzackru1fWOXJHa4Gvjc
	 IrgootLXIOfg0bZSzcXXbPtmRArQvlazcXLJWW/zYXwiZ4StW3hu2xpVKS5W8/juQK
	 EfHQToHHFd1rrpibQSyabzBsbITIKUrff/fsTQ1Yfwd8dnMveVA9hSzWvpcIPiRN0x
	 580UkQ15jFu4RlQQIpsEL4XOENER5INFuCGbrw+DacjAn6LOZyCPEDtgR1gY7F3YUZ
	 PorFfQ6GnW+ig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christopher Hoover <ch@murgatroid.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] iio: humidity: hid-sensor-humidity: Use per-instance callbacks
Date: Thu, 26 Nov 2026 12:05:24 -0500
Message-ID: <20261126170512.2705298-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112545-squatter-grain-d525@gregkh>
References: <2026112545-squatter-grain-d525@gregkh>
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
[ sashal: Adapted the timestamp field from aligned_s64 timestamp to u64 timestamp __aligned(8), and adjusted whitespace in the sensor_hub_register_callback() argument alignment. ]
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

