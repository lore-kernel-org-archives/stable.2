Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792679278;
	b=z7h64t0hUcnG/n2Lu9H05Y85YHfUIrHjj/oDd8N40ofoMM81+FtJPSueU/A1zcw24nz8
	 QNV9RU2XLznT1tqW1n/tiBFhBf4QCXh1NrLpLqlfjmxJy8S9m3388OhwO95Daj6Ir8xuY
	 gYFrCVFf/fZEZ9oMOusGU9BjDprlLUb+9EC4Zbz+ETfNFcc+Yn8XqdAPyRixJbn9FMFxH
	 nTwjr/iUfVaOlwGPMxgQf3cxuoitSOujr6XHg2UtpLZSfrvSFDklhvxrFoNNPnx+LoOlj
	 dYptxsIUYAEsQM6VsTfNkFGNBpRYZ6VYoe88yo6s8+862ssMGOAaSh+CC4ovUx+paFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679278;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=z3Q/F1hKo12UzltDcxktZvkpVgU/i8MT+AakMBaj5g0=;
	b=nW7pSLkcIoZ6cV0NzWUEx3WVv3BSN/TFvINqXCKWGjd76p0r6v8iWlonEUvoiR9xijgp
	 6ay5UfPbflh40RNh8lb6Hv4tmz2kM4JfzHVQb9wsBr0rfWBQBY86SfyqOu9WvpATzfRoc
	 feWDBUSGhoaq2x8A+S9PEIQvEhT0/2X0uhd/+JIs4HgObyAJlAx8DARUv1GGMX0L42wib
	 eAjAU3xXRH2FApZX/li6HPTRCAeao2LZRqj5n5IZiPaCkR0oU2B/2FPGuD1OGjnmbF/ZM
	 c0vaEwc+JpVKRWQalCB0f9iE45x1C0B6bdKQ5WGAoxt/x9mH3GS+Bt6crVvrNgXsGng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m8K7QvRz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C244606A335;
	Thu, 22 Oct 2026 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m8K7QvRz
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792679278;
	b=RazUV1nBm1+7v+YkPNL+o8to8f5brIFyyzyPF78ywTMHPuf4O5i7LB7o3/dkaYOZPvKk
	 z19oskSue0bVsIqgaB3rWaKeZzGhGmxu1Io5oqSM8lHHbOvaCssTEkAhE0Gsix9L/rwTb
	 S8k0OpdOjIeti3nns5FC8dqNY9w1IQJTC3zVEd37NJEEat1raV/ACGnT1MWMrcVKbgVih
	 O0SKVTVlblj/dC58p9n5Rto95/xOn1smTjfhujBjUrjqZa/ga8WE2rkmdC2U31otKPpJ4
	 nzZm2RVIWiPeOxhOU3JyPUlQESvsSoZXPtkXx+ivdNzOwZTRg+B01yd+c5fS8RN1Wng==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792679278;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=z3Q/F1hKo12UzltDcxktZvkpVgU/i8MT+AakMBaj5g0=;
	b=NAdnfovWjyIXi0r7GFCUT/YdaQPP5LnhbbG+v1eqAcZ57eC0mQPeKwQFPJfoMhSYT+o8
	 ljAV+O4xzpGASDQ37eb2YN2O4yeA3mhcIbR1OXDUZzyoED9bxmgFm/H6qlNscdKdc0w2E
	 NygBETATEWpXQb0/liPR/HkBIm4AAAwYxy6FR/MyCXk2H3hM6Vm3xLY8IMAXJW/o/s/U8
	 KWPUdYznEXmX2IwkGlt6oZzOCjojkhCjcIdm4n9rVjYifwXvHvy3/tRzO604CoE6JkiuQ
	 csAliyuHGXOBzcJ3UpvyUxLkM3P+eUNE00NlABEQ/w+Mr/Ol4EcNo6XQU8gnyj/RH3Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B6BBB1F000C5;
	Thu, 22 Oct 2026 14:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792679278;
	bh=z3Q/F1hKo12UzltDcxktZvkpVgU/i8MT+AakMBaj5g0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=m8K7QvRzU0agRS6eJMVeWU946U7gnkGQ3FKJXPbrBg00ESb+bmjLnWjWF6Kei/uqE
	 l6UtjnLP+CRwS4nshtBlyus1Xc1At+CqV4s73ifDU09hdvdyZdqhro1v0NN2z+UFPn
	 hRQOi7mBs2D1bH11Rkwoj1AFmjf16Z1ISATOmodT5zmYqmsrW2Z0z6cbPd7i0+vOFo
	 U5nu10doakCtGgGcD9uXUSyzA3IEwv4Ds9nVyTPBwMuWTueRzQ6FnzbWi18mPLwbuN
	 Uo7qZBaouKdLyvrAH61tQNfd4v282tQOGyZ1AQQb9wDPDC888aCq22AHe0v0NP/F2C
	 qEcSK2Wmd5PJA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BBACC435C9;
	Thu, 22 Oct 2026 14:27:54 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Thu, 22 Oct 2026 16:27:52 +0200
Subject: [PATCH v6 07/13] can: peak_usb: fix RX cursor desync for
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
Message-Id: <20261022-canfd_check_channel_idx-v6-7-197704231551@peak-system.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792679273; l=2690;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=mApkAfccXTsPiO3L4GSVDt6kudt+4wswdWbEh4fUo1E=;
 b=29W3wbxGi5Gosh7OwQt1vDZwmWwDhheAnVVits9FZd23vH5Yw2jXmD5MpKuRtIU6KN/vdbBc2
 wLV9Eab8KJwDvnVpGzDNcSbhwcB96eXPSSOB4Ngh6a4f/YqjtYTsK+k
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
index 93da0fd4f10e..6a5ecb10c4f3 100644
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


