Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBD24E5356;
	Fri,  9 Oct 2026 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553428; cv=pass; b=gjXpAzikxHtftNUG5E2x/ocK+O06yGew6LoGzAQf83FzuLBpa4HDJ7BhtmEOgSvFFjeTgPDFJ0l2xqCftn9sZd0bojI/hP5mAPNMpeXeUxBlvQzr/WqAG7fjJ1pAamyFynZ/AdGrpo1rR1m5KowBdahyXOS/FBE2EbLBzznYv2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553428; c=relaxed/simple;
	bh=WznmPzS3kmlshSKozxwxItT+ZETCx3pNmeQ+aS7nSPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxzjxFdvKCx1oVKW6KjSbyrxG9j/bBMMYC7LgIxBs8x//GMbB0miPE5zZJCZuttEbdlm9b/RE7otGho1DDAIF405leJYFpZ7FPklp5mdqwCXrfIe6RK8J7+nkhUsstH9wsfJuVNkZTzDMxOdLLfDYOrLbuNoUe2oEQzpOhihFsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=eTw7b+zB; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="eTw7b+zB"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 769B1202666;
	Fri, 09 Oct 2026 15:43:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KEN5ZypB40P0YfGkq38aJE4BdtSzLwnZcBL5dNs54wM=;
	b=eTw7b+zBYL6gmgIFFDw0V0oKSLt6IcFiNTHhNxS7YM1IIQUZltftd1nn8D7uQgg7lcGqiC
	7XjxoYwPy6c30xuhZfjPMESweMrIA8rmOZC3JRU4XYlUW4rBgLAxBBLC5EN0TkTPUcxE9G
	q/tPLAZ5fv36YCY2NcXnTAT0AzmvHFv7yk+GiTIF+v69AvvJMuRR6mD29SdwMKchUaXm4z
	ohbaHS0Kh9AkWM6npcdBtav2xEfydE3uJWFE+0jL9DIuIwJA6eRGnE3HElMxbo3vw0NccM
	GaUzQ4LnxPv5bWyj09FDyZaKWKh1Qs7N1A/1U1B2+YkEDj/cGlsmq4+IzBkHsQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553422; a=rsa-sha256;
	cv=none;
	b=H72/e3W1gDHCoGYnyHBN+4fymo6ioTwDiVlLfdNxO2nkPt2K6220Sfmcc3gbPgd6yL8Gcf
	PnQoSmSgp7opnonYjGVx6ZY9XbVFrmnlS7qhalK2csXRBjDyTWhkjMHh+3LUANYi8fmIb4
	BMes0QpW6qx/Z4eTPKb5OoImproM9qp1lbAhQ1++Y2Ri44INWvi4vjVdjjTL5VnR7DFvge
	sGLy83pGUfh69jjPxpNen6mJ6Hzmdtnt2mwR0nra3Lt1PTi9oD1GRUbaY64FoT1tuFjMAu
	4WzUpqpeyVio6TXOdNN1bRpaHfw2ai1oU8YRSIWJrtHFmCQMfuc5oq3IdrxjXQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KEN5ZypB40P0YfGkq38aJE4BdtSzLwnZcBL5dNs54wM=;
	b=Md8j5aG5v/20AW+FgLk5DvuoqNbFYn6Y12X33gIrQ8slpgSiGVRTRBo1wGPeA55R2YYpL1
	aQn6KipVdVzgha5bxNMXzE7Q8pegK9lyccuIBSHTC378Zy/IkX24/pVR5k5pJfGzd7lL/I
	tNMrgURypvNbRc7fCKz+XyShcghJ0Vy9Am0cM5DuI/7hy7an24akxjuXg3oK+q7/l4FjsG
	xe3uk9SyC+wMusk1xw+7jUXCmT7oeCPSAjjJTnMB9A6+b4hchljTXiikrN+tZExif+U/RY
	F6XE+0kN8eRsnoIUwhigPeYkHwbAf7MrEpepoPPWEoIzh5+ApgS7iOX/NFFzQw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAsw-0053Ts-1F;
	Fri, 09 Oct 2026 15:43:42 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EB0C05BD8FC;
	Fri, 09 Oct 2026 13:43:41 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Maximilian Zimmermann <maxz@spacecubics.com>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 37/37] can: xilinx_can: set CAN FD flags on received frames
Date: Fri,  9 Oct 2026 15:28:09 +0200
Message-ID: <20261009134323.64064-38-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009134323.64064-1-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
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

