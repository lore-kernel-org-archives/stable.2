Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6705739EF14;
	Thu, 15 Oct 2026 01:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029235; cv=pass; b=agzq5Ac7jksHL5qnHirh5TwY45f4/j54eaSkxU85T8rpGw+kpLTlIw1lSmcoLlWth0QBfDLcfRf8wlgG5dzshB3s6tRj3/ELeMxyO3vPhudnGe7jFwIGo8grlLlrA0Qb6PqzfbHij9BtCadj31Sq6sphlNT6eE9pK6cmBRFTAaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029235; c=relaxed/simple;
	bh=WznmPzS3kmlshSKozxwxItT+ZETCx3pNmeQ+aS7nSPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Voo/JB4+/Eiv2StWkHOTg1HiZWu9wju83u2CtTo2eXT/cNxvOR5Z9ycQ17muxSHymhBKUNS78BgsBAKkoImsALYbMRpp3Y49MWCX11dxT3fcelf8g5Jl1wopAp0ecpTbOjcIvSxVC0YK6g8oM6eJvqpyb2xOelWuoa3qbpcNjIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=T8NqWZFw; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="T8NqWZFw"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E9EF12027EF;
	Thu, 15 Oct 2026 03:53:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KEN5ZypB40P0YfGkq38aJE4BdtSzLwnZcBL5dNs54wM=;
	b=T8NqWZFw9iJDtrbQhw1HcBxWOa1WwGSzngT6RRm8IwSV25My6gSaVvvjWx0zTnpf3rol45
	nbRySPt2bfFi1RqvoXDRay/N1u7gcaXHRZonE9RZQzvlyKjBTeCF6OHdTgw0fYN44m6tfi
	jQIFEa6iOb0chrxCpRcD+6xQLElcz+7l4+Mn8IJvj+lRZ7T8KTcZ2ZMRr8862dSRbNdZS+
	cDN3qQgEJjno91gAoGyGVYMRl2jpacHJ8HQS2y5BndRyu0D0Bt4v2rIbo8J6DedberjTl7
	WmqZb27qCmnbxr24NX51SlfC0DcTpwRy3PCU3Y0BJyArhfbuMVDWzsETxkzsOQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029222; a=rsa-sha256;
	cv=none;
	b=KfVXouylCpyQVNfv7uP+4z1Tyz4CqZjhJocH1DpUyQrfjcnHJJ8Z9ISz3hmCgW/YBaoQW3
	ByYlfzgKiI4tW3dpj4CcrscS48FMHu7R8V0Ii+enkxZH8/WdbFpXeneVYKT8cPI2xKaIXz
	DPnbBxp+HZljJnzgaqBC2XaXgqds3hHN+e2L+1SPBAnrxzuzIoN9GwIcew0cBO71cJIh28
	FVAsstF1BFhYDmckCAik/etkxEgM6TKU8KvxRrXMSaF0ooPr0sckX+Zvso5h/m+4HQYizs
	HJUfCK5KUEmNmLA4KXxLxhQs6x9oLlZHAqhCSV5gl0OmTRuyfieKowN2BvLCog==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KEN5ZypB40P0YfGkq38aJE4BdtSzLwnZcBL5dNs54wM=;
	b=R/eKDV1rbwWWm5/mkysA1N5KY0BlFoVUKWoIi6+oHxJuWdCvIkUQIQuvRW4XPMO8h8G0MK
	/3qX//vXczyKEd4zHkGgjlF/gjdfEe8Lj+MDZutThf2PAeJSFElEWqgz4pHtcjXARg0mU0
	l4CEjsS2fbANvsdq4hYeOFvg8jp4kwteL7Bq7+j9hpoewfASa5jfxSV1z+mJVdp7PYglJA
	sOQ4SLnPY/vGhOkXCgCGjoLqr7pIo8kRzs7YD7C8C9f3DRErCgz0CD8l275N+JdibeX9x1
	WfRio9aHFVjIXXg+JHbeOy4ApDw1T2MraQjxrNqnmYP2NW3RzOy6SA41p1hS/g==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf8-005wry-2l;
	Thu, 15 Oct 2026 03:53:42 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9DBD75C47C3;
	Thu, 15 Oct 2026 01:53:42 +0000 (UTC)
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
Date: Thu, 15 Oct 2026 03:40:35 +0200
Message-ID: <20261015015336.816543-38-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015015336.816543-1-mkl@pengutronix.de>
References: <20261015015336.816543-1-mkl@pengutronix.de>
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

