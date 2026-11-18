Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794994337;
	b=pC1Fw95CmexaXiTfWtMowJBHLdN57I9EllwmVw1hjZ+gnki3FbWHzuDfMfHer3l2rh05
	 os/x5QOO/Y2iJ/hGFQpUwhY+MXlx/DkrdGaK9unV8gvlDb0ip3laoKZyyGAEbYRxfeCfx
	 w4p6xHfCQziaIKGc56lDnMZcFyBfE3xKCRY5JXhBXP8iXdbjaastzsCa+cOljAxU2LD4y
	 VliMDFl2Hk+M2+YbglS7O3fCz5Vkb/2iSjEa2Nw1X7IzeotfBzdgR0TLnFC89Injng9sy
	 F5G0sQYFE566r0JnfyqCt77dCydbVizQcNTJDVR/nVFahKCybFuX3Z+cPQUA6UfL9IQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994337;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KEN5ZypB40P0YfGkq38aJE4BdtSzLwnZcBL5dNs54wM=;
	b=SI2QX7KdFUB35uihOocfVMODRIhScatn0XKHuCGSgLFUEFa0wZm4jwiYfFidgsIEJctu
	 WmPqp5hPJ0iyvfp+lkA/iiHfK3DC0QqhbZz1hvcjyifuozRvs6c+7e/l5pMZcITjM5Ai1
	 9ffDwmBUuM6G3oKhNu2Aj5jMbKYhqbblfjxqJDRpTnbdhFIDAnrjD6+f+j2VO9uyoq69g
	 tnv13cSyctYaplor1f2A8482/AMYPFh2Vyh1nUenJNz5dHni12Nk71uKRtHuju79Q6nZw
	 PFwfznN/e8JhHvNmG4uihWGGu0gpE3jftadqS3Hhv/GCryrx7+XQvzvYG9dguBNWYqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=GjuBL4tA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284FD606A325;
	Wed, 18 Nov 2026 09:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 284FD606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=GjuBL4tA
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 20AEA20581E;
	Wed, 18 Nov 2026 10:32:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794994334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KEN5ZypB40P0YfGkq38aJE4BdtSzLwnZcBL5dNs54wM=;
	b=GjuBL4tAiXHbJKbS4OQALtKDWreqsusOIc7rCQuzogU1OBdmjGpsGqDo2iyZPqAzO3R7M0
	rvntf0EBnYVNAoMqXJiLC8DPtR2McTv5MYgG9df6usSrKCFQMuojuvrj7kfDAVbBZ5qbvC
	I3iQ2iyMjamrqqvnn0RXKlhaKoiR0Fsd6zo7+kWYuswXJzFWoWXhRddYizK6epySTPO8C6
	Ojenmteesoc8G3dDDVPgbglsYdXkmKHInCYOeBn2w74rL/IAVvav4vEter2/bMMKMaNqTS
	numI9dJHglDn6sk0LbyrqsG+Mx6X/74oovEMjWd6e7oVAnzOXRGNLqyx6z0M3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794994334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KEN5ZypB40P0YfGkq38aJE4BdtSzLwnZcBL5dNs54wM=;
	b=W5F0nAz7H8ofjZ3vXcBKVNMP0/aKwI35MiUOc+fVBc7ddkqevMhL5axBjQI5g4Stv7W0nN
	qqL0g/++vAXmO2gEbCF5gQ5K6P33ZPxeORO4Fop55NExGux1bfa7AGdJFCWOkkUCE6SDyg
	TFiaSNop6/QqqBiZ2XKEmvcrB0xbjTrNf5aYWfqhZWfj3mrRTb+FZkbfHm8nQ8fy5WyHiL
	dYKa2m5gqnUHg0gUjoW8VfPqMf45/F9TkAg+3l0kniRMWXp5+fIjObO5sDU0FL5Vc7r3v8
	6CfrxOwaT1wAsiEAk0QkHJL8YMWVfjNfeQfFc5iLeLzaTmQqeTCfF+1Q3WrjbQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794994334; a=rsa-sha256;
	cv=none;
	b=NoW/35QYQVmyCWy01WC/E26uCphaSvxTrK4Nf5CeYMvr5ouFZfdf4NtAcEakTWLwca35B1
	CiuXFo3MYv23iPZevbA2UCm9TrgcCm0K1tiZAXt8nWmZ7h3aTO1OURDwf43bQGGDGRsHzI
	9KgfHIHbvZTx/m1V3tahPQPgzPD0nXMRoWgPP9WWQ/m5pBXpQPfKd6jBbfleYpH/QsDsRW
	gyf9OL8evbQkGzxXrwE5RgfJbQA+tU1uEQ0R0uU3ifMS8uJYIEk9VamEKUQN06fs+u04to
	a2GGAJQmrK/tAQiGlNZdqsSsHI1TC1RUyW0QgbQK23bUqC2LzyUdh4Puphp+Qg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xTc1V-000KHw-1V;
	Wed, 18 Nov 2026 10:32:14 +0100
Received: from blackshift.org (unknown [185.109.152.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1711D5EDC9C;
	Wed, 18 Nov 2026 09:30:04 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Maximilian Zimmermann <maxz@spacecubics.com>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 12/12] can: xilinx_can: set CAN FD flags on received frames
Date: Wed, 18 Nov 2026 10:11:45 +0100
Message-ID: <20261118092955.1283165-13-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118092955.1283165-1-mkl@pengutronix.de>
References: <20261118092955.1283165-1-mkl@pengutronix.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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

