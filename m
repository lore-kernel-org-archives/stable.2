Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793709028;
	b=A80W9/3p0CNZT85K/MOksGTJQ7Sg4CHhuwDH05zg5gT8eo2g6f73bEnm1d34vGip7Dop
	 QVDPN7NDzchjz8KAkFOeI278uhb9nR0JoiAf6sG6qOfbNUaxhpak4fbstu4fQvYH/qkQI
	 wji2jkPv+s1mXvGCr9eM5rY1ScZATWOG0WGRQkhbCAzVDtLiYcx9TKfXnvmbf8U1xhha8
	 P8UqXeeOEost7QtJNjJmtQ1HoLWxqSqMBWDJ9JNTCf4h6+h8aGhPttRonEDKzjE4i0Xmx
	 I46TQ6tbTXMmasRgchPysOPyVolxnYhiXZfOUA1+nUIwtml3QQ1E419hwVQ5RNnm1fw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709028;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=BsHJyN3+6AnljBLWUwEP2B8vKhFpiMU81sNB1C+P2eA=;
	b=B+rVKkQQKC3Uzspajnkh74HARkdLshPXnR0nC7hazOhtLMrqSinQUz91mVNrbq5z4bqn
	 AkhxqMe4JEnnBYNzQCDqAlievpeqjR054ZuaUAUZ9ri1sOx1KofxODeVYkSH93wsJ68Pg
	 gdTECuF2QUFGg1glkQ+tbELapJboiMXaBWDUs86oLudLANfk7ZoO3e6DY1oN4k2IK1aq4
	 bpkZ9VC1CGEYZEYUpEz9f21iAs4iktEnbwYHjFm6QUn0xwqkfCHthTsZxzbdribDmz6JE
	 yifdgSVE5MEgPu8tJBcUPHPGs6cBn9GR4NUDTUeH/Cn7DysRFhBm1ov4vRQ53kiaulw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hn+owhOC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42284606A339;
	Tue,  3 Nov 2026 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hn+owhOC
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793709028;
	b=Iz2KFB4I/dE7Q6deQeQvSEvmCjsYvs031ZG5nAPlIHAez59sQl68D7h/4N2lCPZ2gCx2
	 p/GjTfFhX03rWD0cGQdY6u6BCHwe9QwXSM6XDqAl3G97JUYnQZTYxKrlBWduFpgq5wu2A
	 eRdx0jkfh3PDT58wMkVAkw3ruXNkGr7DahRAoEkJuyT3V8yY0qbr5ntG05Qod+ZDZSE7U
	 1HyeT2raQvEsje1Lf8myqmabExJhxyggfmWsmai5jHcPhiWII4cbH5M9v676Cy+1QklRo
	 nI8Owg+b+1cbAIbt3KrwrSJRQJonw2N1Z6uIlZ1CLkbFm8exinBKLa8OTvZ5pESZWFQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793709028;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=BsHJyN3+6AnljBLWUwEP2B8vKhFpiMU81sNB1C+P2eA=;
	b=I4UcaeMjRi9HePqLJlxjNT75szaqcTrioP7U1+5U7WvLVAkYhoh2xrVlUNqqKpz2PqJZ
	 6RK64wOgXdKtWEoWlJvS+GbMq8k8NepQHZAed/MFREUmQpBMPC7Jeyd3qTJypIm8p15c4
	 Ne4jFg6eNkrNI68m/I5tbLLzWtX8E26+1SzVoumfGR61KFRKDHYqIq/0jqbEhUlioj8al
	 eXtotBz/G89XA7dAGrkqsYbuvhI1VNylHtzIpfxgvfVC5dIiaYlJMrcGKDBC7+ovUJfO6
	 t6//kt9PMm5rzMGA7ocPAH5jV0IrG2SpPKnFiGJhbMMpegXMZ9UkBIBWortaqbt38pg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0E1441F000C1;
	Tue,  3 Nov 2026 12:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793709028;
	bh=BsHJyN3+6AnljBLWUwEP2B8vKhFpiMU81sNB1C+P2eA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Hn+owhOC1qsDrOOY/SlF1B7gnW1drL53S8EQJLW2FgF/lWGHZRz5xuaM+H/xvYrhQ
	 ltaIElMhyAJfUcSL+lwaGnEqWhRpOBM8STCG5vlRGDQlkOcaQSgxwC9qAQpW1aJtKK
	 rKSi1PzRGF4bbx/2NWSatdmjszuFE0jqVJajmAgQY7qf2lVh6rwoUA/tCPk3013sfS
	 tcFUii97rrYn7J1obKOa3KglDFy/A1/XjijaY+J+Cl3ANqRXLwzGn+LoxtkCIbjN6m
	 LhJndTM0EvuwH09M0NvfQZAJtKCShBGC/3/HLu/8NxUL3Kfok219er7ee2DhoYiTeb
	 BpxoVnkRIynuQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6227846934;
	Tue,  3 Nov 2026 12:30:25 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Tue, 03 Nov 2026 13:30:21 +0100
Subject: [PATCH v8 05/14] can: peak_usb: fix RX cursor desync for
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
Message-Id: <20261103-canfd_check_channel_idx-v8-5-4e8b2c0a8806@peak-system.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793709024; l=2690;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=bMaMiYg7Aa53raR4nLWnwOut0XwLvLqO7fLCGj0Opvg=;
 b=9Laxp+eXaspq79v9yPKyhXbU2HkzFej0Ipn+b3QBadmkgP+A15tEQQHmabEn1l4WiMcj/RWgo
 +ydteYy1GfiCvBeDWYqFhwCLzs3SVMSn6spN4NrLAqmV4OPH55gMrxC
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
Assisted-by: LLM
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


