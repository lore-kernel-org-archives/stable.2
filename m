Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795683696;
	b=efqj9eKUhDaI84QW2g9JNGh0icAbDxilO7F5Wv3mUvEz9hZy3ltGoT708r2pJqTNCAyZ
	 YyiXpNZ7Dtu9zhfMleaXp1uUfyO0fckL7YXb+R/CAKpAJOfLOrnKyJrRb74AOe4wy0l9R
	 Fr1hzB0iQSNMhxlLtTTM7jboD0/9W4hNhB6mksx9I5ILzhUvGTPon78SALrx0ymlIWj4P
	 lIctHoPua2/W9iauq+ZBrHzrKRqvgLd2yQO599AQhqJ9nws3g3DLo8wbR0l0upA2ZjCGB
	 I98Wal1yC/1bKnRhjNipHV/F9vnczJzKnqT6KllTQKO9sATa/inJSiZNj6+8mnDjspw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683696;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=v0dhsrT/I9+8qpUZ94JgNB5YnEzY1NrbWsCWC7wZPOc=;
	b=JxpCsrIpIeAbAcIR5xrNqNo+mXV1bIk6Yasfzj9P8R5hs3apFB5F2FAAhld2xg8kRGCA
	 9g3YCW8orYvl2HsDq4YGZD4Ns2mobD1HUdiSO0CjW1USxyh1FZmksO6qvqOrgehAM60hT
	 LjVBfeyRc6XVyZaHnZzEnojib/Vbo3r/8vurLN07neeDsdkCDTMbWIg/qnq2HeiTdIGav
	 2FZImAktLuuEXjRQfv9o6McRdyK+eb1SeOHY5ZTc/J42kc3oV6jOBVcgJ/OHqXJn0v9PQ
	 hf9UOZjKK10x6YKULLiLgLqrAXs02WLkSMy4yuD28cOpOUf3QjH+xSVUjIW84HjwI2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XGU6ZGnG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7075E606A6AA;
	Thu, 26 Nov 2026 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XGU6ZGnG
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795683695;
	b=uS+uRyUMjIahPIORgdVAmzlOnugMhuhxtHovaUY05j/NhI74MXQF6xqvKjI0ktkRnTdg
	 zV1T7d8ukUk8L0qR0B6Wnsjovqz6KwiktL5eLtXjo1lKx35gKK5l0dlXfA8X67dD73Uy+
	 GZXjPRb630cU4mFj3fwBSdN2++7SJ12tqzDh5oL8sj/qOAByC4MAb6Il/r93mEakY1rhb
	 hP0EH1opaoZQpijDSIvkopRSWMEQY5jpODmbLJwjnE5W+zAvnhcMn2CVT/7774hL4IG5W
	 1un0QGoBZc10x4I9wPOnl81ZWqrCq4aLvrRCkQWE/4lA0RZ4Pf+FMvzwKE6QnipeWMg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795683695;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=v0dhsrT/I9+8qpUZ94JgNB5YnEzY1NrbWsCWC7wZPOc=;
	b=vosLTgjAn9/GFuIJc1y01sQhLb/b27Fnyf4AipsprOehRcomWzFG1FeEds+YRxT+d/RR
	 Oes4rFCxGkQ6E6l39C2bWn0I0unUVL2RrbiPY34+P4HJ2bm77KAbCT9sWdvIZD2ck217s
	 e6fz6yJYd6jCeMym6NHh4h86HVrve1D7VLJ9renSApKlnN0q7i7NQVxNJy5D24DBVs7yb
	 TppvT5CtdQv6Wvr6IdebpgbTASlb/MB0JmbL1L6pnvFtg70AMDNHBg97RAHJh11gsXs8s
	 uUoraGOH04bZ003+Z+YkMawjetrJE3DaWrnVGhxNvKLP+TnMIpcHT1G5t5FrKr53MPA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 626431F000C6;
	Thu, 26 Nov 2026 09:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795683695;
	bh=v0dhsrT/I9+8qpUZ94JgNB5YnEzY1NrbWsCWC7wZPOc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=XGU6ZGnGXaQ9YKgJ5y8d/r0zR9dhF5FA50eCry/ne/AZQqbjj7Yi+9Q7+UoExxzv9
	 q24s9FWpW/9I59Gqt7ie3l8JsqPyiyAGV/OlFCo+6Nq3INIbXEYiHRzE2hNOAct+gy
	 YggelSdhYLhehycF+Fb0vBPAKxZFyuV3mZhURrrCmeR2zjlyUdBiq4sPyG6WnjzrQl
	 raLXOjL6PHCYu3Ccr9XKTe0885dNrEyEYEpxd9c70F0VaUPXV43eHi8j3K1WUDljFk
	 jE9lGdX5V1g2xLdcfzxYu+C3DiS8IF/KAoBMv9lpp0wqPhkY0tjit46ZgofZmlv18j
	 M9f7Nw2DplJxw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5D9064D322;
	Thu, 26 Nov 2026 09:01:20 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Thu, 26 Nov 2026 10:01:06 +0100
Subject: [PATCH v9 05/14] can: peak_usb: fix RX cursor desync for
 self-received RTR frames with SRR
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
Message-Id: <20261126-canfd_check_channel_idx-v9-5-abe0099b4585@peak-system.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795683678; l=2672;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=2bU+smWIlcRKasB2Ab5ZW5mrNpaLA/T8gUfImqDNab8=;
 b=AlrSrs5YVZPBdEGFFsIS+MUPayU2wMyt4NY9dkicQPRGpl9hiCUmmWRrEHxxI6crO6mr1fmCp
 I0CziaxaTUQBIJCVtqKDpxWZwWy4R0v3Qf88dCYA4etc6PGfYAHiOJC
X-Developer-Key: i=s.grosjean@peak-system.fr; a=ed25519;
 pk=bP7QV2zvvAKAfConZlUOGKGEcXL64SNUpVUm++Ai+/c=
X-Endpoint-Received: by B4 Relay for s.grosjean@peak-system.fr/20261020
 with auth_id=1250
X-Original-From: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Reply-To: s.grosjean@peak-system.fr
Content-Transfer-Encoding: 8bit

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

pcan_usb_encode_msg() appends a one-byte "writer id" whenever
PCAN_USB_TX_SRR is set in can_id_flags, for both RTR and non-RTR
frames: the data block and the SRR writer id byte are two independent,
unconditional steps.

pcan_usb_decode_data() only consumed that extra byte in the non-RTR
branch, inside the same conditional block that reads the CAN data
payload. A self-received RTR frame with the SRR bit set (e.g. a
loopback echo with CAN_CTRLMODE_LOOPBACK) therefore left the RX cursor
one byte short, causing the private id byte to be misparsed as the
next record's status/len byte and the rest of the URB to be misparsed
or rejected.

Move the private id byte skip out of the RTR/non-RTR branch so it is
applied whenever SRR is set, matching the encoder's layout.

Since a frame can now be dropped when this byte is missing, update
rx_bytes together with rx_packets, once the frame has been fully
decoded.

Fixes: 3a7939495ce8 ("can: peak_usb: PCAN-USB: add support of loopback and one-shot mode")
Cc: stable@vger.kernel.org
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 76cf042a9f11..90f69afcba97 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -655,6 +655,7 @@ static int pcan_usb_decode_data(struct pcan_usb_msg_context *mc, u8 status_len)
 	struct sk_buff *skb;
 	struct can_frame *cf;
 	struct skb_shared_hwtstamps *hwts;
+	u8 rx_bytes = 0;
 	u32 can_id_flags;
 
 	skb = alloc_can_skb(mc->netdev, &cf);
@@ -696,18 +697,21 @@ static int pcan_usb_decode_data(struct pcan_usb_msg_context *mc, u8 status_len)
 
 		memcpy(cf->data, mc->ptr, cf->len);
 		mc->ptr += rec_len;
+		rx_bytes = cf->len;
+	}
 
-		/* Ignore next byte (client private id) if SRR bit is set */
-		if (can_id_flags & PCAN_USB_TX_SRR) {
-			if ((mc->ptr + 1) > mc->end)
-				goto decode_failed;
-			mc->ptr++;
-		}
-
-		/* update statistics */
-		mc->netdev->stats.rx_bytes += cf->len;
+	/* Ignore next byte (client private id) if SRR bit is set.
+	 * Note: this test must be done even when the frame is an RTR frame.
+	 */
+	if (can_id_flags & PCAN_USB_TX_SRR) {
+		if ((mc->ptr + 1) > mc->end)
+			goto decode_failed;
+		mc->ptr++;
 	}
+
+	/* update statistics */
 	mc->netdev->stats.rx_packets++;
+	mc->netdev->stats.rx_bytes += rx_bytes;
 
 	/* convert timestamp into kernel time */
 	hwts = skb_hwtstamps(skb);

-- 
2.53.0


