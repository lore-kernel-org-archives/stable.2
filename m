Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792679278;
	b=Qr8Akyj6UATAF+IJPlGefr0CWv77nb6uEvfVwSmR9byWDgV08rdY5XXNFlTV4+rrAfkN
	 fsSEQokHOKBLnlczOXS9wcmRbGGySZswkCbwuwee2xzj0COMOQR381QNP8y2mufAOKxaz
	 DEXY5dERgqOZTrkphoJWyVeno74CYXJoRjf5NX1sXbjGrW/f48X7Wx940R8NfRLBfB6vg
	 uxlwZdEhag9HYuTcUJr83an1E4ZHdZPGQoMv7ZarxdA7H6A5mFrF0GTn6KzSuPpoITUp2
	 d0fSEn7Q9EyYYVYUXJmaKYf5ToLiOpcMTHTVErA4lQFFWLe7nMl6puy7sbX2gVZz4dw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679278;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kPB5YzBpcOpwtk+wXDdd834zs1tNE0uiB6x7DaxSC8g=;
	b=Md+pEbV7krvNYC9K/DN/VbfM06I8peIKX6F3ONQy8e99EDF403CA+hmTLG61hwgZQmHq
	 MDwcwj+n2BWASGlp7pBZY7aSI8RYErkV/xLXXXZIDwSxDD5tzBjV2eeTXSlp5DfZQOMpX
	 DkzJlvgh4tuN9LnbEA9Ypi1+K5k+b+xhrVWNbKwJ+69IyLE2Yo5ihknL90IEWKc/nMcPQ
	 YW+1DrBpSLOtwYW6tA5djdq/dIt/4P6pmMlicLKQLJNa05NBKSeVYRXkagt9t/Gwhxy6D
	 csY78I33jFr6dx5Si7KXU1CtgZSa0PmHarDiTUOpKHP0fbPm2VhP35XyBXDk6IOqVJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eewBn5U5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50354606A319;
	Thu, 22 Oct 2026 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eewBn5U5
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792679278;
	b=lh1O61a1orJq17Euo25qjLYpwU/PJAoBi6Ept9w9uYixCmtcPOLdVFYYBnzlLSdrZJAw
	 Rb5Id6esFyxCnSlG2zZaS0ph/5iyNPq5gdeRO7MZrJQSTrzc6CkKY0RAS3U1pZl5uj8eC
	 kwiTCBdx8oqNLeWY0ypEdj1fjAs4o8aAbmQxdsOekl9uvfO4Xa1fHimHsHrk7TexHdOww
	 wSwf8xa9Ri8Fk1g86rpgntalm94SN+AwgajOgG/PzQl3V1As6BiN9pZkk78RMyLZt1Ovv
	 CuQDgFmlqBlcALIDhlaaStFg/kJg7KLDfjpIFnjE1teyKHbJC4BiCuQBdmgKyMDAUyw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792679278;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kPB5YzBpcOpwtk+wXDdd834zs1tNE0uiB6x7DaxSC8g=;
	b=vOY0/cGQ53fkwNeMFDp9sroSbcVuMGjm3Wyt6CloMeNsiiRWPIan56oSYpWQib8aDI4u
	 o3+HUqBx8nlZZPkzXbU9B58Aubqo/T6Lzl3LycFPMxt+U65Rc2+aqr9srjEyOtBI8flAF
	 dbBwHbGLXe3qIY/Yd6BvsMmmZOULoIlwKh66U/w0PFBsEnMJTc1g4ATz2PtREkHQI05pZ
	 ecTkgEf0djUItVz9waO0rSUV+JBDZWcYh5W7UTuc6suQwX9MiEmqjNdhikwMcqExUFRFT
	 1OOYg7tcDbbeb5D1XmhW8jTnGS+0ulj9Jf8EHE9oRf2z6ZdadRiatUyz5oI2mgSNW3g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E83A71F000C7;
	Thu, 22 Oct 2026 14:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792679278;
	bh=kPB5YzBpcOpwtk+wXDdd834zs1tNE0uiB6x7DaxSC8g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=eewBn5U5JktlKnPVgOibuna5Wdoh2+Sb69GuTz7Z2LJB5In3AEcBMx2HN3KWP8mEo
	 W4sfkUi0xbKqGYEwxN2nzFexaVqG4o9joZNqgpJmSwOzU5iyHl4dvatFitA6hnrKiv
	 oHWp+DosFFM/QE1R1wo5prTaogJ902FlhLv57wQv4pEaQMNdKDkCgZS5brtKgEtZdb
	 nobeG/LEFSq1qXDxO87uuj2HMIGB9NJtk2Iv1isYyksk1LAEWjtbxv013SfIsuE8jl
	 IDWNVGgjBbLi44/r4KnFjpuXRbRy+IMmxe4R0bzftJb+r+H0Gt+WP+oXsnZYOntljL
	 MOBpWwxvEyShg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D497F435D6;
	Thu, 22 Oct 2026 14:27:54 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Thu, 22 Oct 2026 16:27:55 +0200
Subject: [PATCH v6 10/13] can: peak_usb: validate the data length of
 PCAN-USB Pro CAN records
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
Message-Id: <20261022-canfd_check_channel_idx-v6-10-197704231551@peak-system.fr>
References: <20261022-canfd_check_channel_idx-v6-0-197704231551@peak-system.fr>
In-Reply-To: <20261022-canfd_check_channel_idx-v6-0-197704231551@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792679273; l=2800;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=uWnLgjcp0YwEkIOkw0lEbASAJSKQMUMnptlEDyOVxgg=;
 b=SO1mGWOkijP/tip1RJwH8OnpB4Y9E8OKRH4uOghZmHBIOesKX8TSRvYSy9iKdAvH6onnsvPGb
 uuvunv+580ACFs+FrljXD4q+/DNqBDL0D7QNgH4kTeDK2Pmu2S7QOiR
X-Developer-Key: i=s.grosjean@peak-system.fr; a=ed25519;
 pk=bP7QV2zvvAKAfConZlUOGKGEcXL64SNUpVUm++Ai+/c=
X-Endpoint-Received: by B4 Relay for s.grosjean@peak-system.fr/20261020
 with auth_id=1250
X-Original-From: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Reply-To: s.grosjean@peak-system.fr
Content-Transfer-Encoding: 8bit

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

The PCAN-USB Pro decoder takes the data length of a received CAN frame
from the 4-bit DLC field of the record, i.e. 0 to 15, and copies that
many bytes from the record into can_frame->data. This length is checked
neither against CAN_MAX_DLEN nor against the size of the record, which
depends on its type: RXMSG8, RXMSG4 and RXMSG0/RXRTR records carry 8, 4
and 0 data bytes. pcan_usb_pro_decode_buf() only checks that the record
fits in the URB, according to its type.

A faulty or malicious device can therefore make the driver:
- copy bytes located beyond the record into the frame, i.e. stale bytes
  of the RX buffer or, when the record ends the 1024-byte buffer, bytes
  beyond it, and deliver them to the CAN sockets;
- write up to 7 bytes past can_frame->data[] with a DLC of 9 to 15;
- deliver an RTR frame whose len is greater than CAN_MAX_DLEN.

Convert the DLC with can_cc_dlc2len() and reject a data frame whose
length exceeds the number of data bytes of its record type, as the
other malformed records are.

Found by Sashiko AI review.

Fixes: d8a199355f8f ("can: usb: PEAK-System Technik PCAN-USB Pro specific part")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 151c5ea2859b..f94494e01f4a 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -534,6 +534,7 @@ static int pcan_usb_pro_handle_canmsg(struct pcan_usb_pro_interface *usb_if,
 				      struct pcan_usb_pro_rxmsg *rx)
 {
 	const unsigned int ctrl_idx = (rx->len >> 4) & 0x0f;
+	const u8 len = can_cc_dlc2len(rx->len & 0x0f);
 	struct peak_usb_device *dev;
 	struct net_device *netdev;
 	struct can_frame *can_frame;
@@ -543,6 +544,12 @@ static int pcan_usb_pro_handle_canmsg(struct pcan_usb_pro_interface *usb_if,
 	if (ctrl_idx >= ARRAY_SIZE(usb_if->dev))
 		return -EINVAL;
 
+	/* the number of data bytes depends on the record type */
+	if (!(rx->flags & PCAN_USBPRO_RTR) &&
+	    len > pcan_usb_pro_sizeof_rec[rx->data_type] -
+		  offsetof(struct pcan_usb_pro_rxmsg, data))
+		return -EINVAL;
+
 	dev = READ_ONCE(usb_if->dev[ctrl_idx]);
 
 	/* reject records for a channel that is not (or no longer) set up */
@@ -556,7 +563,7 @@ static int pcan_usb_pro_handle_canmsg(struct pcan_usb_pro_interface *usb_if,
 		return -ENOMEM;
 
 	can_frame->can_id = le32_to_cpu(rx->id);
-	can_frame->len = rx->len & 0x0f;
+	can_frame->len = len;
 
 	if (rx->flags & PCAN_USBPRO_EXT)
 		can_frame->can_id |= CAN_EFF_FLAG;

-- 
2.53.0


