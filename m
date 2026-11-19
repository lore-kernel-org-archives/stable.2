Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795126299;
	b=MuhrscHfWIvJGFBcfilflUkbnWHzv8lYvw1Hx8DvLWkYm7cSD8P4aZWY2280S10zxMna
	 OdySfp3v4qPGKJwx06pExtmaXrgeY6186HhRCJb7V88s140TMFtzoDr/39ObU+qyedMY5
	 zWXbwxcAAUFOZckDpuyh4qzMG1aZGIKx9Zwa51AowkgDYedHp7LDsJxVeD68q4daOOOVK
	 S7syCToRAqA2jkptYWsg8/jv0fQdWB8ukQUJ3NgdYCR+OohzVxOxWWpdSANUBNnt8aRoP
	 TTS9q2PKAYmlzAmm0MtOge1/aQRdQXFlV8+YREdN/EXo2MSBWpvpBH13hyhPkwuXAlw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126299;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KEN5ZypB40P0YfGkq38aJE4BdtSzLwnZcBL5dNs54wM=;
	b=haq1ViTVeyjhuY4E6+Ja65uZf9qpYvVRuBGTFy8qt4vET06DioaM/NYBHSGoyx8GmdvH
	 Z/B9FNpqYu9S+ccT0iXxDpkwM/lkoLD2h6n8L9SFrMTI/rjdVRcqFU+QQrL3LGGeXj3o7
	 3QJIhbYO2a4Ok45P4z6mUAMtZJqY9W0ABKiSW0Y1sXQK39s8EnaOH+s8DAekPE8CgNjC2
	 eGvG6XMAWyA6+bkgq/rgVOEVDmafILuA1hYUU5dnfAEdl/XyW8oo9ypAGJC1LifJPb09p
	 AIcBHcuNk7F7HwfS5C4pmnwCL1qca8+InyyfEPmHycLZbyCv0FkwvWH8K8qP7A8je1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="MVfz2/5I";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6154360A3810;
	Thu, 19 Nov 2026 22:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6154360A3810
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=MVfz2/5I
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9A91B205B48;
	Thu, 19 Nov 2026 23:11:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795126288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KEN5ZypB40P0YfGkq38aJE4BdtSzLwnZcBL5dNs54wM=;
	b=MVfz2/5IPLgz7qXkSZVd4+K7+MHckZWq9bitugEELRD1xZtkst9HpjkyEm1GE17rMWs2gB
	5BbpQgE6jGcIHyckvajy8weh4ZWyCtTUJibiZYww0vPIzB4DatQ/Q7aZ8w66b32SizHRtt
	C7eFOiaew639hm6sI0p5gmtIJ7fhNuyc/A/Lul0vaHcRWAL8rOWWvfKyBXcB0ThPqLYzh5
	lUqbJxiqNr6vIdMjhaXbwBfCXGEMgXoINf3FH9YhPRdzVt+0rMQLYiDX2IQagB8Uh3p4/J
	jDIn+E9YMEozjpJM6P76U0oLoEUulXZXt+xoUNAHxcV8lkK7z4hSIVH8iA2d1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795126288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KEN5ZypB40P0YfGkq38aJE4BdtSzLwnZcBL5dNs54wM=;
	b=cunWV5HKTuxG9qWE34J2C9OeGqFVp+pvVhgx4bOTepcJq02yuTAq49gx6SevutP7vNy4ag
	qyO/fmGwKgp5iFOsxC2+3tmdcyVmgJwHdSdAU2YgUUDlNPMQNM9L6y3cbzUOHwwTbfT9iH
	pEzg/+m2CKGeWnL5m9L2tsTxrBXzC29IbWFntLW0lOLWPV2VKZg4Jsycg261XDmgtdVMv3
	vf72F9pSP8bP6SvtS60qx8yRY8rAfNswme00F0v0o0funGVfCS5XEPsJ16OR+I4jHjSKHN
	E+FHPiwVHCqARWe6oWV7TvxSAOiL9oGwNyozziF8cj8N64J+DXlAfxPna8ICEg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795126288; a=rsa-sha256;
	cv=none;
	b=IKMdWMyIS+XsXB1KkPBNb3JcFlcoGwpsUvz0M93geY2MDTpbKhKAovVOiAUdbHGEDkNsIz
	9k1r5XdeHyStQXH6S0IQQ5mUXri9bXXVRKr0DWTCyBEOo/gI4QFPwODWaun0nr03osPBRQ
	k1qYloong8pnfQvS+f6hvjm+AnFBm/ppVIyNUoanWxV/Rh4bYXJeTSP8JBUua1GOZxF3HF
	mlIqLINy+vyLZvHP0lDPYmPnwOjMd4rVg71E15w76/IaCzGoQnVzSyAa/h2ocr2zwSgJyr
	OjdXSfWpj5bSAqvzXQTLbKPLCV1L2ZrfbAvnfXb3vN9q2SjwW0t1pPoj0IL8Pw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xUALn-000Z6a-3A;
	Thu, 19 Nov 2026 23:11:28 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 45B585F09A0;
	Thu, 19 Nov 2026 22:11:28 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Maximilian Zimmermann <maxz@spacecubics.com>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 13/13] can: xilinx_can: set CAN FD flags on received frames
Date: Thu, 19 Nov 2026 22:58:49 +0100
Message-ID: <20261119220936.155728-14-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119220936.155728-1-mkl@pengutronix.de>
References: <20261119220936.155728-1-mkl@pengutronix.de>
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

