Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793709031;
	b=22kz9fLCPIan+m4PMYACDnHpOG8PtOqVRduKMWuna/apw3VDQPqSI2wbM35TYgqz4P51
	 s59ixXanbNDyypS6gNjyy6p+2CchS1cm5WbdjmfoPZ7EX90N+hMjuvM410DYkYEMOCvix
	 Jnq89BrAI0U7S6+ZPT6VakKDJwrGRS/Itx673IMoD5D+j9o2u8BGqEFffwr4XFnz3AHrm
	 OAFDZCLoYcJ4KYCNzEM2G19YD7sgNlyXaXU7/bZ3sjHLKbIr/pcJpNKvYMfJA6FfX0wP8
	 qgHLZHcq985aCngEIbvQ/OM9jjLO7RM3cq4tXgc8nfhQTwz8YLnQDsTzwtJ27pRpb0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709031;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7EDKTQcdONweGkDaui7sLyJkc3j3Yt6nWRNy16odzCk=;
	b=2yro6n3AxqUw4f+JWgHj6lIRSTaRvvMutEtIaAT7adqirsy1kM8SCExuNP4zFgDap+bH
	 fSud8MDSR1lr/IJ6oVPlSQndLvF+xwUQybnSTxjqbeTY/Tji0tGkxUP+sFQ0PtUiZgZoA
	 c7wk29AE7bdEvQEfJNwfG0KxqqJ+eJPqcJpeH/o9IT5A3Drj3KawIxdzPW05Y5i/f1t4N
	 isiMNm6La2WT8h+KuBnXgeDsQwJM74ktXZODpC9KAt4gh8aQgMg/EUpkzw783McRIjQag
	 hZSXUCox0w4OeSL3mHjeLGBRxI51IFjmL1t7bh15grdYSCZ36c5WvMAY+OQMn1xllOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kWoZ6PrE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E43606D804;
	Tue,  3 Nov 2026 12:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kWoZ6PrE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793709030;
	b=VGReP7NXtDTtwJWky6acJ9/4coLPlCwnCBG3jbDahCm+ZeI76gd9FFPaYhSajDuSl652
	 97vUJjtzzzwdx0/Kzgm0QbdqMQCIQ/kqi8rbEBxLlZyRrejQFdDlrqBSORNg8nySysxdA
	 OeNQUmmNJ4mFBTI0RUu1zd9reT6QnAuK8PTPRz3789SMurIdp6sWwB56yINKhCmv3GwYF
	 J3av0xKtluRCF33JZHst1IHTEaMg/sY7iBISErAbgfZJS1M72fQUvtY1OSFdUsGyPD8CY
	 D5NpA+642RnrFFx+u5ETMZ/wfFhbaUHvUKEDejb0Seh+r1R1qlhUaWYD3K3UrWwmUHg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793709030;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7EDKTQcdONweGkDaui7sLyJkc3j3Yt6nWRNy16odzCk=;
	b=01ew2kTW+sP4XaXrUgmNIORulOY1+d3IWqOaAZXmXvf+cJjSNIgUq+E7YhSwoyjfxhkq
	 8Rgu3XgeD/4KWb8o7rZHv3g0mA56EDwrNZz0KU54wG7z+BxO3R2+oHnch7WINqTXhgbHm
	 l5pbIzopXvdJZgsPqC1kqnQw7+4DRrelu26iFqt1uv48bIXnn8kr/POcY5h9nH866p7FT
	 rxPMG1Sdjpe3oCV0UJ37v1dAm4yVRGIL+hu6NEPHZAofvfa4EBFpLrpnaFPnxOL84Qwo2
	 zuyX+bnNOgQDpU+FmEnV6zmZDVrdE8dhEMO6rDYrxBd7Iz5VF1zS+l3k4ol6u+FaZEw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A864D1F000C1;
	Tue,  3 Nov 2026 12:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793709030;
	bh=7EDKTQcdONweGkDaui7sLyJkc3j3Yt6nWRNy16odzCk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=kWoZ6PrEZrQtl3O3dO3o14C0mWu8N9nrS1jL+rRMYPTpId8OWSqqLZu3G+zA7AEsx
	 mUEMt4fmwf1eqElO+k15Sxbm4AsWBdLO8y6Vbyj0ReHEpbZGZPf0UYC9YPG4+xVxO+
	 GSoKrqo5TDOES7aRCr6kuRJsaD3vpxf/dkvVypitvsbWseQ51Qrm0oZfEpT1LxssQw
	 zpjnpMMDh4MaNgUKokIsecQMrHNVt6RDp3y2spbxGCJVsvHydWO465KmiK6qPcJ540
	 PXaag1KJF5EZJ/nE6grxRgl1ZcHerMVHstI+ujEqLf2OHdXnNuXRt93RWJTEIG2osA
	 zYe+lh1s18Q8Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C69B846950;
	Tue,  3 Nov 2026 12:30:25 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Tue, 03 Nov 2026 13:30:28 +0100
Subject: [PATCH v8 12/14] can: peak_usb: pass the dev_num argument of
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
Message-Id: <20261103-canfd_check_channel_idx-v8-12-4e8b2c0a8806@peak-system.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793709024; l=2068;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=tg+9JBfly0WW6BZBreiuqI5/gaJiy/qaGWKpT4l/6/0=;
 b=Hdej+jVl3N0KAZ3gTV0AnBPXC0qFqNz0TAMjStt05xcW4nMxhTbYNdQah87mWrx6Q1wxj47Fg
 y4SbWW80aY8BE1NuyzI/RJwMvce8QRWwYlUQHdLrO/Nl+sVGl0fJXMS
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
Assisted-by: LLM
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


