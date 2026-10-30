Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793357108;
	b=qLLp6XYBTxKxzEbPlE/hi5iTjTNYErkzw42qoHz4v3adlZoX/AxXKrY1QREiio6QPZl0
	 pn25vE64I6nc3h6yjlAYC/HhgUNo5zpj0KnmUtOuSSv6+ki99yYJ9XHvNo+88VWAkOi3P
	 Q2kN7Tms6rXp6XmVltbD1/H7rMBd3fzxlrhkQtHpw7M6JjYwQ9lVLWbLNbyIFWenyy8MY
	 h1f8LRFFjXgRL2e1OoLHpI1O+JvaujiLYgM22ONeKveXOyewcE6Zul6VzPd3L/JVU2vW9
	 jXgEO1jx/YJ+fqkTQDitIDHmc1whQ8KG56a7CkNrmkVP81zyKrkfcZexSRbKTRqt4Rw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357108;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kPB5YzBpcOpwtk+wXDdd834zs1tNE0uiB6x7DaxSC8g=;
	b=085Umlc2Uy2WEUsigZVo7u1syqdiaFhxnX87BHhKUQfjslfqexwzRpGXROBMK/Hs9JHf
	 VU9i6/L10mcqK6M2JrT+4c4xW/ZZ4dxAQtz5KqD1NHYcIdBjT3HbbVoUzoUxogdhSMO0+
	 J47x3d6avY3mviT7jOpEH3/8xVqyKXVdaoHRiaQACuzeCpgHuhUu5t+C+jI3n/Ng5LVwU
	 K6Cps1nyWb4QBe+ZKhxITPzgN0Qm4NS503ZLjdS2UuDKP2nXS90Ob5RJjwc4d8PSkhMZg
	 zCjE0w5ljZDYyGei05F7AmIKNAxpkq6ugmLprbCiRK+bTAyu2mHldwEFsUP8g+YlKpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZlrI3hvc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF0360A260B;
	Fri, 30 Oct 2026 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZlrI3hvc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793357107;
	b=AP3Ku0dA/ttok+0A5UmHIZkzIh3S3l0WMuZg8aqQiZM2T0TCvEymZbC/2lM05v8vqe27
	 miZO3BUIAE2+Jvt9bNlqJg1B+UBJIPU+00pBNMCOTA5K9ruddIrwie4U0ydCQgxrviL3l
	 6Fo4egxrh1QshbKF5kx01u/qL0i1h8SambQEkAQsoLNnY6oQ03lVXvqKlfUTJnnUb/D2P
	 /s2DQ5wSl7O3whYwRYLS5IRkrAqoRdIu7O0pAMghsfAc48xpWuflyD6KcDbM1GP0Wv7k0
	 lCbr/Ghb2FjXvjuMMCvrTLFAQoZ1teN0bU3hKWSeeoyjKxucqn4l5ImffN2+4YvBGtg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793357107;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kPB5YzBpcOpwtk+wXDdd834zs1tNE0uiB6x7DaxSC8g=;
	b=pHySf+DN2wS5W1dPBwnWj7nBmbKzqEyb7p1BzGHBTrJg2fpf+/ThLFGa+EnBhqVGILYh
	 eIfvDYujivCfMbKxV97aosafuqOSHqQTJkAMjTZFs3U7YLzql7pzfP/2+3DMrI4Vt8Dfy
	 x2PqowCGrXQ8vBCVh/TfhQ7C+wH5MdbDgatIhCasQPB14qa1lu3Uc+JOQrH75HjR5BdSm
	 Nheeg7rDzwC/Kt28DIBtWb8RDosUoRh54hHM7ARPwNQsT9FlWbQ+wcgU8MXWsSvTji6Bi
	 1vnj+JJCJHQPrSfMaeCg/ysw/TxDa7koFqomV3wds+4avXHTnIDsHzuaCYvsgwg18RQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BC3501F00A20;
	Fri, 30 Oct 2026 10:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357107;
	bh=kPB5YzBpcOpwtk+wXDdd834zs1tNE0uiB6x7DaxSC8g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ZlrI3hvc8DOEEpKNK4J3ch81ldzX4WqbyrUNA8aTsUjF1lvJVe2gYfIL9qW0pTqXl
	 4Ho6sFaaYSzBoYV80nYIgIWIK6YZT3UxHcYzhirhc10aKn/QoWicB0ET+xqBJBVhHe
	 Dq2iC/tyIPgShTo9jk42alSslkd4HkXRKgbk/+PdR3nbVidv0r8cY6D2HydxYZV+T1
	 +WMj7MpCKVfSCelCPzOr30rigUeUFquppMTIqUInXJ4fUMrRGXlVg1/AB3cMuWA3Xq
	 eC4MgG9QnQ66aQHPzd0Yy7vsIZpDKjhx01jdmZpiqLj6seHyLbD8OgPfWss+Mn4UMf
	 RDK0G+29HIlkA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BAB4B4375A;
	Fri, 30 Oct 2026 10:45:04 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Fri, 30 Oct 2026 11:44:59 +0100
Subject: [PATCH v7 10/13] can: peak_usb: validate the data length of
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
Message-Id: <20261030-canfd_check_channel_idx-v7-10-fc4a3faf3acf@peak-system.fr>
References: <20261030-canfd_check_channel_idx-v7-0-fc4a3faf3acf@peak-system.fr>
In-Reply-To: <20261030-canfd_check_channel_idx-v7-0-fc4a3faf3acf@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tristan Madani <tristmd@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793357103; l=2800;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=uWnLgjcp0YwEkIOkw0lEbASAJSKQMUMnptlEDyOVxgg=;
 b=2f/qI5QCxbBWLVMtmTgGa443hFqtPEkbROaVsfe3D7usxeYZJsVTPNeYv0IK+DA53G2kDamvQ
 OmR7URp6fZWCdicauVNSehIRzCSodnF7Qf8wfjL34/FlhIBLPUmScZk
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


