Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793738599;
	b=nqMixgg1msU3x6kvqzW9O+Yg+P/hCmOD3/P1K9mG7LmKX8j9S3yWS/sl4oQY1XIqZvz7
	 lbJraUgSSajYpb8/gEzPVwiWhY9wDlTJhIBCa5q5PpzvYquSLGEYuxrFpNpJkPeNiGm3j
	 +PPFi9ErY3Hn+OgQP+xyjC+1K+4jnLpCFpR/IKPSkumZirSWliefqcmrWbVRUFV93rTgK
	 NSealt1LiIn0MF24XSJUGbSvsCe1LXo+HEQ577U+YGzqwTEGSoahEjfM1i56/emaF1WAb
	 AxsYKOrPYz5Wbu2b0NHyK4RYDoTGhW4Ucsd7JCr+UXO7sOIas/LjSDqN3F14M0dsXeQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738599;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eALao68/H5C/VsMyz1IjAZA3Cs8TeVJx3ISpy1cycgI=;
	b=hUeU1lCgNS/+qgaNTSOY8pPXdnB+Ou+o3w//DTgn2zlBUp75pZRrREIl29T0D81zQpoC
	 k8Q0WFIZMEEX0M6xdWpPTHby8DMPyqJ0rGn1DXi4Zl2PUonoYG4rFZG8y/HUIRaIkgxM6
	 M0KxNoaH/SzccmUOFVFKFzuTGAknYg57TvKq1q2xeGLIn7bzys7775QX9VxH4J7/DupeQ
	 9pXQ4Fyo5QrQHA4l42LRhJlVEYTewF5CDTMWklsaf+t31PJumsfvbY1tjp8QMstVCFiEE
	 h+h2+niOfhbBLWslu5aUMU2jtAfiOxQlB97LENc7NLPwAh3yqgxd/I37+O34IsYc7Fw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=MVIJWxsa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C5A606A324;
	Tue,  3 Nov 2026 20:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3C5A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=MVIJWxsa
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B797420177D;
	Tue, 03 Nov 2026 21:43:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793738592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eALao68/H5C/VsMyz1IjAZA3Cs8TeVJx3ISpy1cycgI=;
	b=MVIJWxsa1bi2Ob3AKNd2d+FotlGCMvU/6u0cZQ10I31ek3tmVq6/ZQUBukx4fhnkKNKJ0C
	tMSboYAeeWBXwLsIvUPil9SALxC2WvotRM9yA5vcYFHxA38+Ehxge/XJ9LsL/o1ekmBOyg
	QHVxPfzjF+pa9SUle2OvOntM9PHG8iH2KMM2s22a/AW3deyivGRONdviC0jEOVWbpOPPKQ
	DJe5vO+Unv8LTr/Gb6xLczk/ZXQKN9qsQZeXQIJ8QsgqLsU+GB6qBdrNzyjrRor/0rE22N
	VbE1oKZwt4RA6H7+Q2a23VUj8jsIP+kivd88zLJ/BCfI7MI18qn8Lq9UksD4cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793738592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eALao68/H5C/VsMyz1IjAZA3Cs8TeVJx3ISpy1cycgI=;
	b=Wp+H24N8Ber+M6gB9y2u1MZQqMjjEFUam1bJz6P+MVPgwFCQpD2rOeWDRrEyhrqjAdYw3L
	xiGPKJAd+aDupN788Vb5EM2z5+7BVEGrpJl07k8eUojCIQUjSLkAxFJZFswR+Gtcwv6jC+
	Yir3ED1xQ/4vm7Pd5yb02cIRrQunjhhx9002Jc7raLEjJ98ggOsi2ME8rdOliFhAlJ+LtZ
	nM2+ykkcd8+npCUAdvudwZ6CjcLYHAKCqZdWb6BQAeQvmVbS/MujO1KE8b3MVXtShEaL6n
	vXP18sDzOd6rlOrAEBaEPgLL0d12eRXTw7VK4ay4U4AolrZiW0yrEYSB8JOZdg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793738592; a=rsa-sha256;
	cv=none;
	b=XFm7S9fGYmXzNilIlShxFbVcogpqU6TzT6U+zfpOkoX0gjNaoWKGUs5f0rE6TTTYQncZvY
	sVLAHTw1cI9AtTCFJ1v7Y+l/KhwlLlvPwtUmeDKAF3vO8fDyFuWiDGsIsjIPjvJZ/95m4i
	ZjNvB4w+cy+NzZwE7B/Or8PmtnBBdJrTHR0Ro6wtHodgqullMXmbs1pVDhZeMgZB0+nZ8G
	5LEagwOyM5tJOAK85TgUtQbx+HdZvbd/iRst1s3U1M/zAlsmCqgqwahKpZ2UGIr1s6W5ms
	tmmvuN4RARba6xgsiqOv+G9/bGDtxV7sCD9CxHlbMY1legsQEaPzLZCORa1VVw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xOLLc-002V8J-1y;
	Tue, 03 Nov 2026 21:43:12 +0100
Received: from blackshift.org (unknown [IPv6:2a00:20:73c1:227f:2cd5:5d72:938f:f03c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 46F7F5DDEB9;
	Tue, 03 Nov 2026 20:43:11 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Kaixuan Li <kaixuanli0131@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Quchaosheng <quchaosheng000406@163.com>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 02/15] can: isotp: check the frame type, not just the length
Date: Tue,  3 Nov 2026 21:30:23 +0100
Message-ID: <20261103204305.3211144-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103204305.3211144-1-mkl@pengutronix.de>
References: <20261103204305.3211144-1-mkl@pengutronix.de>
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

From: Kaixuan Li <kaixuanli0131@gmail.com>

isotp_rcv() separates Classic CAN from CAN FD by skb->len alone:

	if (skb->len != so->ll.mtu)
		return;

	cf = (struct canfd_frame *)skb->data;

A CAN XL frame with cxl->len 4 is CAN_MTU bytes, so it passes, and is then
read as a canfd_frame whose len comes out of canxl_frame.flags: at least
0x80.

Of the paths that follow, only the flow control one uses that length
without bounding it first, so check_pad() walks to 255 over a 16-byte
frame and the caller reports EBADMSG on an unrelated socket.

bcm_rx_handler(), j1939_can_recv(), can_can_gw_rcv() and raw_rcv() check
the frame type here, and can_dropped_invalid_skb() switches on
skb->protocol on the transmit side. isotp_rcv() is the gap.

Fixes: fb08cba12b52 ("can: canxl: update CAN infrastructure for CAN XL frames")
Signed-off-by: Kaixuan Li <kaixuanli0131@gmail.com>
Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Reviewed-by: Quchaosheng <quchaosheng000406@163.com>
Link: https://patch.msgid.link/20260920035626.2581040-1-kaixuanli0131@gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/isotp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index f5dc9d04bd68..d3e43ab48425 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -755,6 +755,14 @@ static void isotp_rcv(struct sk_buff *skb, void *data)
 	if (skb->len != so->ll.mtu)
 		return;
 
+	/* check for correct CAN CC/FD frame content */
+	if (so->ll.mtu == CAN_MTU) {
+		if (!can_is_can_skb(skb))
+			return;
+	} else if (!can_is_canfd_skb(skb)) {
+		return;
+	}
+
 	cf = (struct canfd_frame *)skb->data;
 
 	/* if enabled: check reception of my configured extended address */
-- 
2.53.0

