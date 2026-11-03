Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793709031;
	b=Jw6+pR64NqSJ9RyhWI2K0WmL/ZZ7Og4uJ1RBO72oCHU7+kOsp9ZJA/DemtKGJbnJHlho
	 M/afSYQyDfANk186Uqz8Smc0+g3YJj/91nsLuyxPD7fthBZmZHlUybQehRZLHkMAwJF+1
	 CAh1/t5wZtWuTXbG0R2uEb7ak8waWi/QnYfbRZkrRD54dDBjkccuAWumOuJq9p8ZkKH86
	 id7GHunO2zW36dz/a3qXdZ3aF/rdIOQhPC44IWI0VKR4aBAGoBvq73CJGRax/Xwilsk+T
	 dAQLon15aj8RctcyN8FNVdUzqcG0NMU8Kt8VGtFO7VTCGTJ7lSeo70wzS261LX4dIgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709031;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fjMH7lK6RvOiB5UQ/DsZddaIbogBEzuCeRRrGZ/DOIU=;
	b=kcGveSCx1dX2y6Y/0qsyw+Rpr7I7UwDa8McYcl8Y4DwK2w3++4ouyvn+JEw7zrd3A89b
	 f4079TJz60wDo241akjIGYfF7eqTAF3iBDFugl1/364dpldlbIifVcdtV9ePgGop5lvTf
	 IndT1tZLQGvfGfCtWZ6TyhrqbqvrDT1a6kse08ssjligfQCPjyd9Cee93Or4dPJA5gfQj
	 y6MLAV3JWDRUujCMob28AXfEybouoRAyk4JJgXkDw80xDdQJadsNVXtt+caJXvbqZDLAT
	 CEUSexiljI7fqEGEVIPqovIACIAygwgkDmmvkmt8jRvVcEgDA6T4CTdkT4uARqnTUIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gb2A5XdX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFFA606EE8C;
	Tue,  3 Nov 2026 12:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gb2A5XdX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793709030;
	b=B1WTm+lUu1QS0t2uWHGG2RAev8BKUF7WDKS/UzVqOALDrsn1KWwQ9G7hzmObKdjAPGVC
	 2e9YAgzJwbAUt+C100eyZPhbsawvTn5UyTl8ozdGwPZepRtFWw6hGarOxeJqi0dVW8OF4
	 OWFVOVaA8pvDwzpifSbGVqM04LW0ox0RRDsgZzLNY9lmFi0smX1lqxtRIweSAal48rGv9
	 SVaIlb0fq+XP5hX9gkW/c2R55dEiPWaskALjIwdyUjBdYzaneEsFiGu74n/6NTYIPLm8F
	 0Pong65R4veMWL+HCdS8xFY3mDwjoePNTZPOBTW4/2wRHqd2A8WfuTchNFVOdtWJ1jA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793709030;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fjMH7lK6RvOiB5UQ/DsZddaIbogBEzuCeRRrGZ/DOIU=;
	b=J8HKEHQggRddVmLl+6NIdvQ/5pyOEp0oYjTEZKqKaWZ7DPVrOtsKO24AdcmkmsG9mxji
	 XwdrsAdDziCFm19nw4cy1lyuhyvmKsUSjrcr4vAMT0ppUIadxhQJKivXcT+iLF4P5x411
	 EAUKHDtitjD5bJ9XzmADHlLGvOa4lSXHJATH0ZUz3Em4xZNbyhwXAegv5brtxzOkUZJ71
	 +NVaftCosut9l4Xbt79lvdB0eh40pne3J6hWfNHC0X1BbEDeA8r+0Fl+LqVOndgsTsVDZ
	 syhmW4/ljXmhVJ95WKbodhbycYUPzHL8JFCxi4carDE7dM4OtHIItnKNfjBFlDrGUgw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 02E1A1F00A1F;
	Tue,  3 Nov 2026 12:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793709030;
	bh=fjMH7lK6RvOiB5UQ/DsZddaIbogBEzuCeRRrGZ/DOIU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=gb2A5XdX9lHWjf8ZcTg+yzCYmPyUs5n1uLOGQ7NXpnao+J1NF9CXs7Cq2UIefXjyO
	 4VjcCt6lbz+njc78q4PK1PlaYqRX3cZ46xkOxOmkPOSlWoE6IY30zNPIqlMRh8UY+n
	 Wuy0Z2p3eiK+uTpFclt7jT/DjdJZT8Jr01VIdEQOCnmzgRnU2XlLY9lT7D3Yz8JgpI
	 cTyg+35YOlwifWzWXZQq9lJ2JvNZFJVsYcok/wn/1JHva+gpsD1SNqDsKf/VYgSebl
	 Y3fScHxNqWdOH5ijFKvVQbBLWh16t+nFIhvMMVnO3iNMuEDrSx+UKwr7snbpl7T8A1
	 y0F2QVBhBCmKQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D401446954;
	Tue,  3 Nov 2026 12:30:25 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Tue, 03 Nov 2026 13:30:29 +0100
Subject: [PATCH v8 13/14] can: peak_usb: don't send uninitialized stack
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
Message-Id: <20261103-canfd_check_channel_idx-v8-13-4e8b2c0a8806@peak-system.fr>
References: <20261103-canfd_check_channel_idx-v8-0-4e8b2c0a8806@peak-system.fr>
In-Reply-To: <20261103-canfd_check_channel_idx-v8-0-4e8b2c0a8806@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tristan Madani <tristmd@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793709024; l=1939;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=F/qIBCSUbQKHAsdEyP2lkTE3sJagZw87jKmvA+lanFw=;
 b=DHWRmPaS3UQfJeuINhwExbK7iwB9i424Wwmg8OYQ6j/axgxM9npbr7EU3i4kcy5ONVSTYcbU2
 Uw+zbP8Q48rB/n5qt1MyTA8tzcjYOY2lkSUNpr4WvQlw5yOXSxi1toj
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
Assisted-by: LLM
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


