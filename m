Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875D23FE359;
	Tue, 29 Sep 2026 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716048; cv=pass; b=cFKSM0lmYRfEIWBJmaItgh2nPo+Zy2S5K+1/WfrPPfyoCtM9IFIPOB8CD5CGPmjxbeP0CRkBspZbhswzHlBlzcuhe86NWAtoSJBNPTTmjljMZubBpRc4m8dK8hu1NMgG+jrcoclSuTxdLWq2ua9w2W8kXAnfyGWfWLXQg5CONP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716048; c=relaxed/simple;
	bh=WznmPzS3kmlshSKozxwxItT+ZETCx3pNmeQ+aS7nSPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLq6r7fvieHw/egfDaefalHSdkiKm7zJgywsfPaVTFKRQirOAN1zqveuwizXCdRVkqYQoBAF1XYcfe56rAo/9sNOOe/SnKebOEF9iFXB4osHuCe/GE2AKjqBP3kO6l8tKPTTOWHgIX0tHzxwmGOC3u43E4dPADKP5BtvY3bHKuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=bsRYrj1w; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="bsRYrj1w"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C7321201551;
	Tue, 29 Sep 2026 23:07:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KEN5ZypB40P0YfGkq38aJE4BdtSzLwnZcBL5dNs54wM=;
	b=bsRYrj1wAGLOHDQg5wDdyMuo/wu8X5WgXTJ6cde7MW+OOp//OovRzYFfjFUPGDnFknX8bq
	J2rDlXPCO9bOMnhEpF5pEPLvrharqkUxS5gIm751doOUkEpYkVp8WOv0+jKtErAPGlgR03
	6xAmwO7XBKlHAsz2WHdGnXXMX3HH6ZHQ2y40hBKruLTfPGZf47B+fmonBx7dYO2dBxcYq9
	DHhEqzBbPq1Pe5Q8KQghHJHmEZlOqvxl39K96eHWVP6PsDGuMT50zL1Ewa/mpffs/vD2ft
	nNfS7vonM6moLjNpiHrwzlKz2KjSIIoDQwxoGkumjxdZeUvNMSkL7hqyU6LJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KEN5ZypB40P0YfGkq38aJE4BdtSzLwnZcBL5dNs54wM=;
	b=bWyCEQi3tohrgoJIbp8d7RJhMFindbkdBgtYcUJlFl/RpXr0lC0/g/Nwd4kR1WkkSNklWo
	cCMl/9vMQ5bMgmVqSKiPtrrUL7WHyBFpYwg0bD8RT46B8Lkl86XkuoAC9hbextNwSPY8tX
	prvStLnfIO0nXw2/ydjUgVVPTi70oF9VFf+2DpykPnaIL27ZZsEdWHpffLxszlZDjhvfsU
	nsvONBTdLAoyjGMDC23hLZB4J91QuFP96QLYNkggiWY0N3ESKMSCoYW9lFNUJPQtcrcih3
	UpiXv50o8FOZN8CKgS4WRhdka4fHbPzwcpHiotUpJquApGVGuVm9z5P9SHrI0g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790716023; a=rsa-sha256;
	cv=none;
	b=IpcFmgOGiqLIH502k11+9tUoXb5eZMnA+NEz10E2kwFIUgj6j8RXJITRFsDHZ7xxIxrrDl
	rVflyeinVYPZz/ymTEdAXq2XCdq5PXg/m7l2eClY+B+yYnivKKFeccB2i3pn491p1w5fqM
	4v2CGwj8HAKW98kWGoc2mWkwCSyya7B7TQl2NCL9LE0E5Hlyi1TrYbmXmb4doN0kHUvhgx
	Af/d1ZXo+ddlAGT2zSVc0KRU5NpD6d2tvzSBq+tJmCRnMHdk8Sv+o5InXp6HnvKJg7k9Xd
	SqhIrnh1jjv6IwwHUSIGpLUyF/7Fm7fWGjhuRbXoAJrqOcEBuuOS4h9nNafnkQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBf2V-003S3o-27;
	Tue, 29 Sep 2026 23:07:03 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6531E5B4CD8;
	Tue, 29 Sep 2026 21:07:03 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Maximilian Zimmermann <maxz@spacecubics.com>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 08/16] can: xilinx_can: set CAN FD flags on received frames
Date: Tue, 29 Sep 2026 22:43:58 +0200
Message-ID: <20260929210700.1183036-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929210700.1183036-1-mkl@pengutronix.de>
References: <20260929210700.1183036-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maximilian Zimmermann <maxz@spacecubics.com>

The Xilinx CAN FD controller reports the bit rate switch (BRS) and error
state indicator (ESI) in the receive buffer DLC register. The receive
path currently uses this register to determine frame format and payload
length, but does not set BRS and ESI in struct canfd_frame::flags.

This results in applications being unable to receive the BRS and ESI
flags, even when the controller correctly received them.

Add the ESI register mask and copy the controller flags to the
corresponding SocketCAN canfd_frame struct.

Fixes: c223da689324 ("can: xilinx_can: Add support for CANFD FD frames")
Cc: stable@vger.kernel.org
Signed-off-by: Maximilian Zimmermann <maxz@spacecubics.com>
Link: https://patch.msgid.link/20260921-fix-xilinx-canfd-flags-v1-1-a371c90b4e7c@spacecubics.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/xilinx_can.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 43d7f22820b8..52661e088205 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -157,6 +157,7 @@ enum xcan_reg {
 #define XCAN_2_FSR_RI_MASK		0x0000003F /* RX Read Index */
 #define XCAN_DLCR_EDL_MASK		0x08000000 /* EDL Mask in DLC */
 #define XCAN_DLCR_BRS_MASK		0x04000000 /* BRS Mask in DLC */
+#define XCAN_DLCR_ESI_MASK		0x02000000 /* ESI Mask in DLC */
 #define XCAN_ECC_CFG_REECRX_MASK	BIT(2) /* Reset RX FIFO ECC error counters */
 #define XCAN_ECC_CFG_REECTXOL_MASK	BIT(1) /* Reset TXOL FIFO ECC error counters */
 #define XCAN_ECC_CFG_REECTXTL_MASK	BIT(0) /* Reset TXTL FIFO ECC error counters */
@@ -959,6 +960,11 @@ static int xcanfd_rx(struct net_device *ndev, int frame_base)
 
 	/* Check the frame received is FD or not*/
 	if (dlc & XCAN_DLCR_EDL_MASK) {
+		if (dlc & XCAN_DLCR_BRS_MASK)
+			cf->flags |= CANFD_BRS;
+		if (dlc & XCAN_DLCR_ESI_MASK)
+			cf->flags |= CANFD_ESI;
+
 		for (i = 0; i < cf->len; i += 4) {
 			dw_offset = XCANFD_FRAME_DW_OFFSET(frame_base) +
 					(dwindex * XCANFD_DW_BYTES);
-- 
2.53.0

