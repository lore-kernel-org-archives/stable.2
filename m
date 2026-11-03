Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793709034;
	b=SpDqCpDm7bOvKncz97RH1rdzmXRqqVKGUu89r89v7tAID/rBh32h8KwApNs/E+QJsCrO
	 zvbVMZi4ReAipgwaPuDGG3PKHjQblyo7KKnnf2SwE2ZL/eoJ2K2fZTLz8YFs+NrubqChf
	 Nfk6KZ7yzFWzLoIQfjfk67IXsFYnsI9esPyRjApEW9lPcVBkldytbZq05erx3HoLOLQKv
	 cMJCykDQLuUa/Wxp/IChoFVrF45mVbNPiSTWq6aHIlPg6Uh7jFGeeEmCBBDjioZRuBpvW
	 Sd+ypjJX5rn9oEqJaiTYEjmsHbI1YhwnQtHRsF0hUlanomyNA+4hXTspD/x8LCf6WGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709034;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iPqh36xVaTCosNjtsthxS/QaGj5JDX44IFA6embAc9g=;
	b=PKyA0LYs+T3fV8RImM/MYFUCIyP/fTSR1/JtksuyKO64Uc18qePzLXIb1vhMqf+4vg3x
	 O/iWmVvlYPlgJ++9aRH5OffighmwMdlWwIWm1I1thL+uOPAyY3iHqTKHdT4yoMS212nMW
	 xf5T6I6Zrz9gOLcaEFMRHQJ6EdELePJ3Lnon40rrgOoFiAitajxaQW96kd5aGfUOqCKab
	 A42M2q3MN6n4fAN0wR8apk1DA8cQ3BadY7e0Id201oCjlfvBGkGO0wyPK1qkhue3VBFbO
	 KALKxx0tQpmFIZTABe83emVvdXu63JXRtmOqDXtaxRPfsrePvoxiB4fECtRMBb779tQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SACZGqj/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0345D606D806;
	Tue,  3 Nov 2026 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SACZGqj/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793709028;
	b=eQre1175PTMWluQPeeA5yhqIyOlV60wPInqP4qPI7dJ/o2pywixMwlCjmPxxJIZ4vPXz
	 B+xCo8OptHgPvqoZOj1AMNLrX5QYxaIBPnjA1o95NW7b1FH+UcvQmDp04vuRSu9kkC3S+
	 4eFZIr1ngv9u0Sx100wcap9Wup45IRxO442zLVXtvIT3eUyKy2DeA+ye+djYulwWTxWaj
	 btII+XOz81N6FGi7PNohE423BTxq4jrHYfEJf7yYa2b1/wJUibxOMkpM2bq0u/WDiiAmn
	 snmqPlCHuaCgLFrmBEYa/bhi7pynnBzcb9TSJq1fOMV5AA8jynkH+c4Q0oGNORc+Sgw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793709028;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iPqh36xVaTCosNjtsthxS/QaGj5JDX44IFA6embAc9g=;
	b=sVyRitJQwP6zZ5p2KIgAIgP6xC/W3hEl6W1AOAa5koImtBxYf7aoLp92Zog73h9XGe+1
	 RrQxo7Da6TCBe/rXHus6niwd5J+xTXbDEOogZydJlSv2+Afkd8LcLLut7pppVYaahbjOZ
	 jN1ljbI42a6cUGItyL4jIurWh0W76ydWLXOpaqPNJi+qLnv8o6iM2eyHGjFUVTWZrIeBT
	 SvXev6bxQw7nVgJ/yxF60jcNaVhIXcY7FaSCtkKfHOaRjlaxFdBA/QPRU0S9RKYzyJ5uQ
	 P22CNZ+yK6tWSkEHFSbzYOB/smpZApanvvFsomhhfdzSXXks6a0MPSXcXqys6tDXasA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8E4E01F00A18;
	Tue,  3 Nov 2026 12:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793709028;
	bh=iPqh36xVaTCosNjtsthxS/QaGj5JDX44IFA6embAc9g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=SACZGqj/6NQwiLCnpuPjFJmgNm7mW1y3LcpTIdzsGGIL7deGphv0ve8Hp5zYeWlpZ
	 XSUkyvQRPhrsK5wY7XGMlX3RLwyTLRvlf2mOw3ww471wr05Rd6ZGW770E97lVmq2oY
	 Z2pKWf5m/MkVSBJCLZ26rt44DhGVbVsW2ubVjbP9mxX2sg9tGSn1+LCRWXnHUXVEi5
	 lDHxK4z9+BBFpdEkQLpfqp9LahS8Gg590pcQ0nigbalWDkyuDn5v+zaMLcZtl0W8Qn
	 WQsGz5TmHHeMuRwfnqDnRq+gZ15IeMVR1CTnAffGc6b5gxYHO0LdTJcuttgJPgaTPw
	 YFTkL5snUFRQg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8D6CD46940;
	Tue,  3 Nov 2026 12:30:25 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Tue, 03 Nov 2026 13:30:24 +0100
Subject: [PATCH v8 08/14] can: peak_usb: validate the data length of
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
Message-Id: <20261103-canfd_check_channel_idx-v8-8-4e8b2c0a8806@peak-system.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793709024; l=2800;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=JjxyM/KiPAiDjN4DrO2PnFVJnmhDFwF8g0hNc4FqXlk=;
 b=ivRYKaMOPmQwqAAtQHWRHPLhGbMrmKdtwVcnYf3ZFoL0B5wp1ioReaP30a2BNbFHA13vGFPjP
 BaE83uCrYi5Dxyn1upU8xgaYfoyPqVsaMX/jPFhOMDzp5fAkRMA/iqz
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
index 9e2f48683a9d..38307d452a5a 100644
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


