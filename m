Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792492903;
	b=MYCryRbSFxvdVcruPtPpuMRmu+AksbR1gh0SGDbmYwUFru8LEykt/dg7iyElo1+KEdXO
	 u4hDnxbgjhU7vzconweUp0rD5OJl4Bsnw/F+yTbxA3YHnjmKp/cQ3i0TmuqtAjNWv8Pcx
	 meAhviQAOVIMrgIMwPe+hDg5/+oZjzbOb9bDkHSXhw0Dc3NtbOzbyRMtJHXV+4O+C4iI1
	 4CDT/ZcYarMs4Vmw9A1UjgkXjyexL6L0Dk6K/gNiGzQ7MBPPJzOIiFaijFtZp7KyIirJj
	 1ImLX2sdWIMDI5RazSLpz2VdmkvZCStKUj2+yYlinv/k8lflDHDsPEZmE8gzAktpvQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792492903;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=xxbuQ7YnwKJRiO0qCRVlDpGTsW4CQx/KBY872s2d53w=;
	b=xdhKx22MjRqqmKXVefUNgBkkcjiZYu+aMIpnVngTSmVYecIEJzk3YJTpHJ7RmQRrInGT
	 dKoorDOIkzBaj52kAb6Il4Jb5VWruOjmt35v6XxuJMfAVDTJQe62y3RFYc+87vPXGmzse
	 JJT0CUB3whpKXPIMORuHfrTfEzqZdPSs37O3ahUdjQUxzpgll1itqnXTdLq96l+6HTxkt
	 oPjyq0doYNGyzvvIO//4sQB7ZkbdDo3s3+djzdORRp4gFfV742AmsbpAz7/12nEuw7vIQ
	 FnkKO3PdB8d2QAzmO/QZRt4PoKUq66gc7cf9IYOldZLWSbtjVbmgk1Qw2zM940v3PNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b="FVvQ/Ubp";
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB778606A31C;
	Tue, 20 Oct 2026 10:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB778606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=FVvQ/Ubp
Received: from [127.0.1.1] (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 7457E780509;
	Tue, 20 Oct 2026 12:41:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1792492901;
	bh=tE3vJC0W8o3NwDoEDj1/qPH9HQAmDSOArZ3MVdoGzgA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FVvQ/UbpHcn8GSlZwPG6275AiMYLkJ4VLJ/JypQhqSg5UCHBQZnWX9gkqA7X9AB3A
	 eo8etTttCnFmcp+PmM/E6XgSEh/DMTyUVp1Rz9L6VNCzCa0sJwY8TGRgPDC2ZXyBkt
	 fTQoKaHFXjYeTPPsQu+XKqHHequYTZW4KtgUsreMorOC122haMApml1up+1aUQHmrO
	 7P5FZSOJuVYAbq4SS9F0c3Pt8AQvLGPAZV8WlYJfgsutrJK4jZ2tk/OUdK5HAkVZ/Q
	 jITyr07MRypwn1WGq/jPnw+6s9skNEnw8Z4fbrDuda42zQuFgLlJf1pY22PvrrzEno
	 JHe0wqQriQdQw==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Date: Tue, 20 Oct 2026 12:40:22 +0200
Subject: [PATCH v4 07/10] can: peak_usb: fix RX cursor desync for
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261020-canfd_check_channel_idx-v4-7-bfbde81f8bab@peak-system.fr>
References: <20261020-canfd_check_channel_idx-v4-0-bfbde81f8bab@peak-system.fr>
In-Reply-To: <20261020-canfd_check_channel_idx-v4-0-bfbde81f8bab@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

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

Fixes: 3a7939495ce8 ("can: peak_usb: PCAN-USB: add support of loopback and one-shot mode")
Cc: stable@vger.kernel.org
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 93da0fd4f10e..4c8cfed31634 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -697,16 +697,19 @@ static int pcan_usb_decode_data(struct pcan_usb_msg_context *mc, u8 status_len)
 		memcpy(cf->data, mc->ptr, cf->len);
 		mc->ptr += rec_len;
 
-		/* Ignore next byte (client private id) if SRR bit is set */
-		if (can_id_flags & PCAN_USB_TX_SRR) {
-			if ((mc->ptr + 1) > mc->end)
-				goto decode_failed;
-			mc->ptr++;
-		}
-
 		/* update statistics */
 		mc->netdev->stats.rx_bytes += cf->len;
 	}
+
+	/* Ignore next byte (client private id) if SRR bit is set.
+	 * Note: this test must be done even when the frame is an RTR frame.
+	 */
+	if (can_id_flags & PCAN_USB_TX_SRR) {
+		if ((mc->ptr + 1) > mc->end)
+			goto decode_failed;
+		mc->ptr++;
+	}
+
 	mc->netdev->stats.rx_packets++;
 
 	/* convert timestamp into kernel time */

-- 
2.53.0

