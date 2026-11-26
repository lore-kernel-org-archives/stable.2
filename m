Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795683717;
	b=oBk0/OYk09nONBMCyUP+LQGx3JwzEcZ101uVOpC7maFC/qyZzDIX2dOm+Mkp0Ws9sU+F
	 /9nnPluu9RMidPHjIsifDbNwB2Jrrms8KmJRh8CrKRWTmN9R8ybXCa/uPrAEZNotj0S3x
	 a4O060ao+TfCdeCQQq0IPuirHFUL5CMujRhILIK0o5ZXz62cPIyVyqJ8n+MyLQm0xZdZF
	 kLBzlck2tY1NeauFLvufsxlmOcc18JOcaJpXfml/+N/owbztSbE22InlaXMYm5PsJgoBN
	 dfV7PFomUWA62Pn9G9fMGRKkB9K7KIq32pIlikoZwXA93s5tc9vvZ0CFhVWhXE8pvzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683717;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=urQT0GkzINIeKBsEUFE8TOfW4ukEBaxJ3yBYTAduYs0=;
	b=ysvY0Rk9OnSeG3wkqTCiSGeaE7MBdTF32CZCHEYu5mIOHl20rOG24EvTuDdcf8UINAls
	 peymc+RDookc2ezRH0ko+MVn+u5ZPRLSttrQQoJM69xBDTIcySN/wAPiNWHaENegNHyc4
	 89Unq9QoxoXP1ktZpmdJMH+S4kGTyVazqRSjyOBOTF0ZlrT+6iAr/rOX4sv0ik19Eui8g
	 GQCFh/LlTu0SpbytPh1/GZehFkgXc28yHS+ytNLsuf/KFar3Bt3IjHuYu16QMg+SWlP6c
	 m9iGmZ+JX7o7y0Cl4SpwMegKkHkVVFreeAayMJufqrwRDBoy5WifaezsMSVsHvpWKWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e0xTtdRZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2867606A691;
	Thu, 26 Nov 2026 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e0xTtdRZ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795683717;
	b=hmhA7vXi0aeR9UjCOB+A7fJkCHg0Jhjgh7gvpnJYBCFEXIkZmy454iOdbywYtsk6RWjP
	 uMfmX9wnI1CFF6mb5MDp2REIBoGs3c7d9JeB+wF3BsGX21gbgIWQDqchB3vCAOYypl9CM
	 lJ3BcdRpW7rJ194kDtaWQ2/RrACOSGJzpCfLY16GMVwSOHNiu+aL4quklUcpqsyVZBDEQ
	 wPmTEXqY2xFFvNyhRxHnz6DnXMZMj1PFSsfKpbsIcP6ilEMvpISDkcbkRaarJDXcOLv3M
	 hx9lO3yrGxlAq7ljrBRcFX0RecjPPYnwLLbgVsuHITVOoqd6XTbRsu1P3QJwJxIZYtw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795683717;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=urQT0GkzINIeKBsEUFE8TOfW4ukEBaxJ3yBYTAduYs0=;
	b=G4lIb9siF0VJ315dgOa4A49cUzwh0WXZHxsA+9jr++GzWRgaW8iAyOAXLv/z3MdRD2eo
	 35ZtGCNGInhRAIhrhUOsDyLVfiuQKGKAjoncJRNxJBVKrSYDRyKVWX+KsRKgiP53m/HUi
	 oNjdIR+QgKYMNG5nGK9F0pDoKrGqbKk2yWJM3GnDpi7v8OhJd5tsyNjTfQGMn2AzCjNiA
	 K/YZtQ39z9zr0qjWvyhW6n9v1M0JLzQ/7tiEKZwVsEM5PUrxyROpzS8kQlFvRqRQ6DvbQ
	 4yMZrgWXVoOeARdyCKzxj7deTWi1ZWWyCPVZ6VmO+JWRi7IMAvhCg1C1MDzyboqQlyw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 419C31F000CF;
	Thu, 26 Nov 2026 09:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795683717;
	bh=urQT0GkzINIeKBsEUFE8TOfW4ukEBaxJ3yBYTAduYs0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=e0xTtdRZEV3jCeikrIWDmXwKnDfRhh+EWWwjkqLAiC1K2KJTJP96I2knfdMnwmtPW
	 N67bp4dCBRhQ1jUwOBKcqJttzMgMQX6WpQ4QPHqOQ46h8+v1u5wlSoPPaKe3gn0EqY
	 fHX3/wJ9mP6YmoUEGnK+6d77o3Xn55IQ/eekhMGvFQh4ou0cVnVz4arBA779ygECmW
	 i4WxiTOCxd0IisgDRO+tgHNTYc4GnbjZaWBNWTbeRMIyNXthm0jWhjoctPCkS1OYZ+
	 dpR8KqK8OXEdS8f3ZYbystmOobxr3OR5Rp2DCpKmrzRZyK0C2MrpHaZks94nSFDsLC
	 yo8yFhKYWKsKQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 634514D342;
	Thu, 26 Nov 2026 09:01:21 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Thu, 26 Nov 2026 10:01:14 +0100
Subject: [PATCH v9 13/14] can: peak_usb: don't send uninitialized stack
 bytes to PCAN-USB devices
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-canfd_check_channel_idx-v9-13-abe0099b4585@peak-system.fr>
References: <20261126-canfd_check_channel_idx-v9-0-abe0099b4585@peak-system.fr>
In-Reply-To: <20261126-canfd_check_channel_idx-v9-0-abe0099b4585@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tristan Madani <tristmd@gmail.com>, 
 Joas Antonio dos Santos <joasantonio108@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795683678; l=1921;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=jlhgS5JaKaHZWAPKo+58DKqTvVR0iwbvuP1f/7kMmTo=;
 b=OeJqK4vY9A78+k+2csktpoeBzenmhxJSfwhaLTZq5EKS36pvx2z8XGg2h0cKile5wyCAVS/9e
 t/X7cgvX0nhArNDtJl3EvVWsj+8OAwzqkPfcaBUNCCZGA6Nbj2wNYq8
X-Developer-Key: i=s.grosjean@peak-system.fr; a=ed25519;
 pk=bP7QV2zvvAKAfConZlUOGKGEcXL64SNUpVUm++Ai+/c=
X-Endpoint-Received: by B4 Relay for s.grosjean@peak-system.fr/20261020
 with auth_id=1250
X-Original-From: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Reply-To: s.grosjean@peak-system.fr
Content-Transfer-Encoding: 8bit

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

pcan_usb_send_cmd() copies the PCAN_USB_CMD_ARGS_LEN (14) bytes of the
args[] array of its caller into the command buffer, and sends the whole
command to the device.

pcan_usb_set_bittiming() only sets the first two bytes of its args[]
array, and pcan_usb_set_can_channel_id() only the first one. The other
12 or 13 bytes of these uninitialized stack arrays are thus sent to the
device each time the bitrate or the CAN channel ID is set.

Zero-initialize both arrays, as the other setters of the driver do.

Found by Sashiko AI review.

Fixes: 46be265d3388 ("can: usb: PEAK-System Technik PCAN-USB specific part")
Fixes: e7a7b3d22503 ("can: peak_usb: allow flashing of the CAN channel ID")
Cc: stable@vger.kernel.org
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 83cf6fe7d258..2838e4ea2b4e 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -274,7 +274,7 @@ static int pcan_usb_set_led(struct peak_usb_device *dev, u8 onoff)
 static int pcan_usb_set_bittiming(struct peak_usb_device *dev,
 				  struct can_bittiming *bt)
 {
-	u8 args[PCAN_USB_CMD_ARGS_LEN];
+	u8 args[PCAN_USB_CMD_ARGS_LEN] = {};
 	u8 btr0, btr1;
 
 	btr0 = ((bt->brp - 1) & 0x3f) | (((bt->sjw - 1) & 0x3) << 6);
@@ -405,7 +405,7 @@ static int pcan_usb_get_can_channel_id(struct peak_usb_device *dev, u32 *can_ch_
 /* set a new CAN channel id in the flash memory of the device */
 static int pcan_usb_set_can_channel_id(struct peak_usb_device *dev, u32 can_ch_id)
 {
-	u8 args[PCAN_USB_CMD_ARGS_LEN];
+	u8 args[PCAN_USB_CMD_ARGS_LEN] = {};
 
 	/* this kind of device supports 8-bit values only */
 	if (can_ch_id > U8_MAX)

-- 
2.53.0


