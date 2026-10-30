Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793357107;
	b=ErIBPKRNDWs+gbnrjOMNDWoKLkZlnevSyI/qe8nrle/Ifuijlen9tEPVDKPm5qovZMzJ
	 Z9Hd4roaZrkiRqrQYU41eV8K0Tb+e0tVBeYT7qPID2gSGzq2C44lswNKtvAjs6VOUXOqC
	 fcveCfkT3cVUhMod46GkKcwEQ0xzj+TNURpfPbgkXfP+UquAiWZ6RIhiaAC2ZRUyOM1l0
	 WzRj0u0VVufdILNQlXaguGkIPY+Ol65Z/zmUCdVHTLdRmKOgMbdV5j4WKBGJDgeqSktKw
	 0vq3Qnze7v8VtDI3sMFU0qrIHh3DQ0Nr+RpjnMe6z0TNlr0nJXCc71dW1H8dszGBZFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357107;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=f8muaMvEohnWdVCwWydWXsxhpEKxmxMi4NFL7jiEYvQ=;
	b=Mjp1EXHwBDLUiJy2m1azb5zgtmoJp12ck5huQK2vgaE8P1/lzxFsYLBIqFd06NDxduUO
	 Rel5HoLVbWTg9zURFsWumHjQXifbz9WLGdEWA9kzu2XYd2N9jYEFgHKcUlw/xGCUX8F6L
	 o2AlpQOZO7Y5wokbB4vGVfDjS3qgonhetMldosGQts5a12rtsWQc8D/YeR+sonJylR9et
	 2RCi1dPRqznMXdC0z4hwoMOe5XcYtkwSavOapSPvyFSaPL0ReDUo06pPMT/iKHU1oA2TW
	 8wznHWpLdCkip0DWImZXFdPl2M03mY3y/szlnngVYGBxcPtsOOcQv6p5uUHYGXZnkyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CRxPpZdM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64026606A335;
	Fri, 30 Oct 2026 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CRxPpZdM
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793357107;
	b=NwonGrmrhqud1iLfYUotQdBiUT+EL36KIK349s0vjLWYcwGCGYPf8AvvQqc7fe1XNRs3
	 PcG27fcQkODcXe68+RE1fSI/3A5/scq92fWsvGJcjMjCCW9x3zZ62V3Wr2anfgMIrBrGo
	 LIhVOx/ULIGv2g0iOdFUscA3nYBYG1EtvjccZP591CLX9WaVBr9t/6YsgoGmstmfYLCvI
	 mszJplsRc36Q5rYzI3BeiB5hO1p8pm6qbtbfR+1GtoD5RVWoyaMyIRFG8r9rF1tGnX0ID
	 Z/XrOTF9vB5x6wCxMT9BmmElJUgf6xPbrCh9jkZDcVkVdmexcA+8fIq8gP12A3cOHQw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793357107;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=f8muaMvEohnWdVCwWydWXsxhpEKxmxMi4NFL7jiEYvQ=;
	b=ErHrTxkDPTnlD2TbDMsQ9SHZwzsiBUZNL7WwfUf5S5d2cJUPi24YuMFRTKyZtx8RxkLN
	 CRltlETy66x/ZYphOF0dKgoW8Bf8gOeMLJWEOLFyZsSz70C3AZYCSMyDstzT5HjyoY6RC
	 VJQwV+3m6DLH6aVOUI0bMTKzVjynnVcgj2fe8S6KC9yc37PurUNkF3ERx5F1RR6mS9mTa
	 rQKTuCs61tKuEBvhXVPoNWeEKkiYiuBwsQ2eCEZbyNPuVVdfyhHwKfK7GWrAf8CW7ENfl
	 wHfDpVh6yZJzZc9uZKO8qP2h7EUHGzeZDlN9uzWIMZoLeRCmCL3RtwwiK34Kf8rd1qg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 76FF81F00A02;
	Fri, 30 Oct 2026 10:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357107;
	bh=f8muaMvEohnWdVCwWydWXsxhpEKxmxMi4NFL7jiEYvQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CRxPpZdMmRXJppc5vQoGfqdmYs+KrjNRShgRuO+65KfRh7AWSB0yMS1mf7EjZJwJF
	 l82KHMqgfkDVFrMd4XReix2L2Ps9M18Myo+kZ3nwAPcYUxCKHuSmfA3x3yPCxwfwHp
	 aXeI++B16Oy9fkWfc8BJ+uZJh90lKWSECKpftXzsqXXmWOwUhRRtRRTAJLaLQ7CVuV
	 Yq7eO7YnbdYAQB7OibfngdXjCEmXY+wI1WTr6BAaCqGxK/mh/CNHih9xFANpCPHl8N
	 CM+pIjsNPJLLSZF+9uxB2Qz/2PDZyElR3er2wzXGPNS4pveTzUoDwi8dBACDKH5JLO
	 6WwlfqSBXU1Iw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 99D084374E;
	Fri, 30 Oct 2026 10:45:04 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Fri, 30 Oct 2026 11:44:56 +0100
Subject: [PATCH v7 07/13] can: peak_usb: fix RX cursor desync for
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
Message-Id: <20261030-canfd_check_channel_idx-v7-7-fc4a3faf3acf@peak-system.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793357103; l=2690;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=7iowm2Ync/QfAvJoNemyRJAkNEBzGpoLl9V/NPwbe3Y=;
 b=faEX5VcF40yIRWHradmC+AYyOzMaoqTGugPuDtU+lON4lkOo54x+lTkIL6N1KFcMm1UrTfEu6
 MQRKmMAlsJoA+UjJ1tdxz5RUGaZMCGF6wc4oFTK7Qg+B5ALp39d80ZP
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
index b9cd6cbeb912..4c93aa060fea 100644
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


