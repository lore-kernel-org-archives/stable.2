Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32AF4FE2CD;
	Mon, 28 Sep 2026 19:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624010; cv=pass; b=q2YDqYzs5W5MaH00l8+XNQ3tINOEzaeSzq3D/jlx2lJCor7vy0dF7gQ1Xbg8Rs++Dve5enfbkzg+vD0Ugio1R47VK0qyezSQUZmrTIRA+ED5u3Rg98HvHchDcizaofqF2hUQW/4cZOMELsa9aCpXK4ICBCBfV5DyzjFNK8X9OTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624010; c=relaxed/simple;
	bh=WznmPzS3kmlshSKozxwxItT+ZETCx3pNmeQ+aS7nSPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnOpdAve93A+InjZRehUq8T0AxxlYcz8vIP+/mtE6vkEpt4G0qB6mXKVV0H9qoPbxeiv8HyBceIv6AjLyShKsWoLh5i1jjdy2Be5yRWTAGdeqiGGbhzgt/5R+6AEoq+EP+hI/Us0v3lVxq73i8/YgjtZxbHWyu99TRj5N9b1KJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Q3VVE5Kb; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Q3VVE5Kb"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 79C8720216E;
	Mon, 28 Sep 2026 21:33:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KEN5ZypB40P0YfGkq38aJE4BdtSzLwnZcBL5dNs54wM=;
	b=Q3VVE5KbJuPALxqXfePU6l8/NHJ3xjHWqKzstoas+ZcKM1kKR2QrwMIo5DAwdxdvbHM2FV
	1Jx4wd0AH06jfQXI8B7bPA69OJOIis/9A8QnJBU6JU16qi/keQUd12nBJouPikN6kB4jZ+
	fD4CW5OIsXiP1EMrtxWu3NoLURNrLV4IHk50XDxuVMFJd3DdBTtUmEXgy83LWhFBYB9LI5
	x4LEr7CByepoIBJeR3E1EILg3bOWFd31gx5vwK+7+66SmGjxo6pOZRMqxL03Kf5aguCyNc
	0PU3jgAefQtLXbh3HNRa7bzBzq+EOLhiJrw1uoxc/cC7KCR3Kg9SnjNqF5eH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KEN5ZypB40P0YfGkq38aJE4BdtSzLwnZcBL5dNs54wM=;
	b=Ejs4ndTVV6M37sjBbORFthBwyuBiaUnpXXeNbAf+DDaM++A6YnjacgpRuhocMsxnJAoMTv
	HaejHT4sYSi5sLUtE5uML4jr1GYwoITVqSf5d7pVO+LWZNUG7+RmegMh06B0NPKxs+o3H5
	jGlRMviSIbkt8Z76/W9fdrRaMBJ645t+IHAOUBags5g0lfrFdB/ysYE50VNX/8e2621izW
	Rk4X0LjKUmkgbqTI30vb1sR10k0WObE76XVFriKtWFfBumELyjXpXrnAeKAl5+ABuMieGY
	VLxF5lAymBSj+j3r52JRxR3GM4ppYDkfRmvl72b1Gwfgqjg0WdRMwkolYzSYHw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790623996; a=rsa-sha256;
	cv=none;
	b=GheWKRZ7bkbD6gUd5ME38jH19E0QVPqwQ0vsnqT2xDAR4NKdUlW1d9lX3Goir4S4JRlMuJ
	M0Sfe9Y/0+Tp9f1bUWGKn/R5IZcZMCq5gls8+Vk4sWeClulMdV3l77yXhy9qjVtaSyJE2v
	QFfgvHomnvKzP9tgtS9lNnlGtdl7Z7op2XSPwq+wTLkyecj0vPym0UCnrgWbMbbWv/YaFb
	Cg0aqQtsX/466sYv7ijcMbuj9MX4HItJC9VEzTahn1YZkaAGMX9i6KX5F/EIiNO3jp/7ae
	nou0xnpi5ADDgtXtcm5W4qP6d4OnbjPCt+gzp7yPVt6LdXbd7TkDheQvHNNSHg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBH6C-003H6O-0z;
	Mon, 28 Sep 2026 21:33:16 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0C8325B1555;
	Mon, 28 Sep 2026 19:33:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Maximilian Zimmermann <maxz@spacecubics.com>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 14/22] can: xilinx_can: set CAN FD flags on received frames
Date: Mon, 28 Sep 2026 20:45:21 +0200
Message-ID: <20260928193312.553632-15-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928193312.553632-1-mkl@pengutronix.de>
References: <20260928193312.553632-1-mkl@pengutronix.de>
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

