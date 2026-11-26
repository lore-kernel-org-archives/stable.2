Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795683714;
	b=u52AOc1CKCYhMUK/lfnVmCsqto+JTDC/LcpogBcbdyzFnA9c/mS6W98l4MrVbsVnfiIZ
	 eIOmhXeXpaZd/cMOUh4n/9JhkCBlzII9SFgnA2mow+NjV5A0y+gxYObZax+AF5hzbxymB
	 Gyhsq24m9waraPtctqkCh6j5TqzFQx34ME1Dik3sGoOSX9z6d43yKgmJYhtUWoDBnwvtN
	 xJl+tis1m+u1gMsPP73U1zer8iCZQeM4XVpQe69RylXxeKQ8Cm1ulDnxVSGHDnpxildgv
	 9kNtTckEYQ5E2cRDGwSBSA8wluJJsUqHadmJNmYeANJAP248EyT6h/ETRxbYsGV4jeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683714;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iSyv5QQCZMuxDCBvBCU2Dcf16LijdNeO408HdwTICyw=;
	b=db24o+YOJEpNoPGNaZdGwn1B6i3hhJKz3Wh+t6h2iS7+vcO/RuH8vCVOM2PCfSBig7uq
	 rpVWGAEKUlYknZcF8+72gH8CQeRJzhL+Fk+b9hnXSQ7k5xnUx6DZAXswmjSOxVYOiMBNF
	 lTAGQE3e6mUIDtIQs8r9VNHyXaM4glt92DZsLc0U6Hlq2+q786Kdo5Jc6dw8N3zUOH2iW
	 WReBe3+eKQZOKh2hzp4AlQSsXOe5llZ6UVZwedeY1fJsIXQT3CSSsCzE2uOhhZhJP//RA
	 NcI7ijw1g6nkN7M9Bdc49+gQ9FW95dZSF9l3NuoAwomK6xPXnodX5jark0ytS6SZ4Wg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ufd9jiEQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D418606A32D;
	Thu, 26 Nov 2026 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ufd9jiEQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795683713;
	b=GupMmheK0fNStjparELKuQpIyiDtxNmJpzVPrn7DZLRD2Yz5smIGxW0nsce/yMEjCCay
	 3m1+q91WbRC6v54NHkXhtfzmZylfFXmD4EF+opF8DFIHYaUxDZI9DTbBfVRbdaMi8xqMg
	 eMPrF+jPs0xtId+bQVe1hkbk7IJjk3NzqwGLb+qakgLzlLPqc0hCU6BPBIymcrwmfR4L8
	 V5zmCcTmOB1qtUffvzdHpPnfZ6t5NRxFRUrYvAZCaETanp2bUl430y8J/af0fU8siZ/0L
	 yOl0c9JQEj1vcLDY/MSv65UrqRGJk+wtSk66qLd/FAoQAUq2qFIPpmguI133nw4y9ag==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795683713;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iSyv5QQCZMuxDCBvBCU2Dcf16LijdNeO408HdwTICyw=;
	b=c1CsTw3xvoieKNM5yolj3o7WlpApNotBGJS2vhFClJ6WBzhOiudDuuvUbJFmTzj7ctQt
	 ytZ5rJFLgI+68VvTRkUCwgiwLZfXNEG4rYCcJIv0+pw2s1T5LCtezMv11gMkswDFkBbsX
	 mVMB5R+ggk/YalHvj/oFZPJnrQ2EmEeZuvt7au2ofxaeW+qPuQm7uGnGJWaMNiefi/1mf
	 MnM76/ClFWDb1POSQTqf+RL/+FPgkIww+vlIBsG54wDOMqvNvtH2uTuVFwtdUrHkXMXkm
	 6iYArn8Y7ue42hGbwtKX01HggiD2GvA6/ZeYn5QGLO0TB4O/4bnsaA9tTH/geLBdpsQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 441611F000D3;
	Thu, 26 Nov 2026 09:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795683713;
	bh=iSyv5QQCZMuxDCBvBCU2Dcf16LijdNeO408HdwTICyw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Ufd9jiEQukbE/gDE0AJlxr9XZetgEeecZRumippSyreoS5I+Tr698VJL9cX8MggyA
	 mlB87HwWUlORduGI0Ijj/YVTwrH8kOpi5HUkPJWKz0CKuC8PS41ZLT/BBb/lhaIENg
	 z0/+OkDFnNxJdStsiR5U1+43PkOy0h0gdGuGS+wUeUy/3eplEzBNfAwJ9n6wZvTUwL
	 qqSB3Ev+KLPDd2LbbOajk5DVUvxTJir3H1Ocy0LDqW9kmEIsiZWPgCAHJbpQM855bG
	 RtdRJ9c5aL1DVJBWJIK5F/nTY/bvSpjEPwqmX+CHb7Fc4wylHquK7jXMkfbR1DEf0B
	 X/TnWlmY5uLGg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 43B864D33E;
	Thu, 26 Nov 2026 09:01:21 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Thu, 26 Nov 2026 10:01:13 +0100
Subject: [PATCH v9 12/14] can: peak_usb: pass the dev_num argument of
 PCAN-USB Pro GETDEVID
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
Message-Id: <20261126-canfd_check_channel_idx-v9-12-abe0099b4585@peak-system.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795683678; l=2050;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=Ik7L4M6nF06Q+SDmhDTB8AMYB40CZOhjzaUTkkjkX3c=;
 b=E/vSaQOP5/cFTY8FPOlBkAAFUm+CkMiaGUddGCwJW0j6p9DgHpNHCO84Hl4wywoGp1VQOOanO
 7YmqTlhZ9h/C6yuQ3+PLl7tIgVFrOhJTNeXBQvs7Fq3M/luSyXhCDkS
X-Developer-Key: i=s.grosjean@peak-system.fr; a=ed25519;
 pk=bP7QV2zvvAKAfConZlUOGKGEcXL64SNUpVUm++Ai+/c=
X-Endpoint-Received: by B4 Relay for s.grosjean@peak-system.fr/20261020
 with auth_id=1250
X-Original-From: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Reply-To: s.grosjean@peak-system.fr
Content-Transfer-Encoding: 8bit

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

pcan_usb_pro_get_can_channel_id() builds its GETDEVID record with
pcan_msg_add_rec(), passing only the channel index. However,
pcan_msg_add_rec() handles GETDEVID together with SETBTR and SETDEVID,
and also reads a second argument with va_arg(), to fill the dev_num
field of the record. Reading this missing argument is undefined
behavior: in practice, whatever value is left in the corresponding
register or stack slot is written to the request in dev->cmd_buf.

This value is sent to the device with each GETDEVID request. Moreover,
peak_usb_disconnect() clears PCAN_USB_STATE_CONNECTED before it
unregisters the netdevs, and once it is cleared,
pcan_usb_pro_send_cmd() and pcan_usb_pro_wait_rsp() return success
without any USB transfer. pcan_usb_pro_get_can_channel_id() then
returns the dev_num field of the request as the CAN channel ID, so an
ETHTOOL_GEEPROM request handled in this window makes
peak_usb_get_eeprom() copy that value to userspace, and cache it in
dev->can_channel_id.

Pass 0 as dev_num, so that the request is fully defined, and a null ID
is returned in that case.

Found by Sashiko AI review.

Fixes: d8a199355f8f ("can: usb: PEAK-System Technik PCAN-USB Pro specific part")
Cc: stable@vger.kernel.org
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 840658723648..0d014f4c08a7 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -435,7 +435,7 @@ static int pcan_usb_pro_get_can_channel_id(struct peak_usb_device *dev,
 	u8 *pc;
 
 	pc = pcan_msg_init_empty(&um, dev->cmd_buf, PCAN_USB_MAX_CMD_LEN);
-	pcan_msg_add_rec(&um, PCAN_USBPRO_GETDEVID, dev->ctrl_idx);
+	pcan_msg_add_rec(&um, PCAN_USBPRO_GETDEVID, dev->ctrl_idx, 0);
 
 	err =  pcan_usb_pro_send_cmd(dev, &um);
 	if (err)

-- 
2.53.0


