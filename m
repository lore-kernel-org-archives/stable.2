Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD6E3E40E5;
	Tue, 29 Sep 2026 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716049; cv=pass; b=eWtaT01Gbq040+HckbOOd8Lp22A0VEq8M6XgZXe6yEQtPUXHZ94jHb9TQvXV3MrXkrbr2PHJtcF+KUdg2f7phjqQPoF8M96CydZpXL6trz6PcfxsklVryOPRdVSJOadHzTzbBrIXG9YJba0nPhueVnBpHav73NDA8ZtMm3SNFoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716049; c=relaxed/simple;
	bh=4m1GHYZs4yHUYPqk/s3amlDV2W4fnGfneG4Dy304HZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPpdRXPFLM/VX0w417pL0ho870ltvpMt2FycftkgFJQpAIHcs/mhWInzrDvp9Mmx6W11iS4/NzxDAyukOSV4w0Ub2YKQoqRx2lLk4ydKpMuvkp/XeD1m/llK/v+Ow+Lh28wnvTLmFziAV7qYvxNwhMLy6x1Uaq5Ze9FlVErRZWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Dfqoo1Vk; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Dfqoo1Vk"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id AC2952007E1;
	Tue, 29 Sep 2026 23:07:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kK24u6GzlnEjaQ2mQDYh4Z81JGvRRGNCchob5d0lgLc=;
	b=Dfqoo1VkM3QqahhEz9mz9IJXPPkhHI2wFYnyeeSHzXua7C8sYDV82Q8LRxir3aw4wffhyG
	QjlBLm/G7Yz3BexjQ0XbePafHFat9zyUiV5uPn0Hju68mnv03Dbp0fUNxVXG5iJOfx37F3
	5+xKPtNZe5+odPYLgnQGTrbbZhiIwrdPce2Ye7d133oXJTZ2XqT6UwMCkEE9vfydW78qjq
	LpuOaN7ypl9PRy/+9qQ60f9fwphCiolP7+TMhRMvCpbeoif2D1McFRcIZ53EicbOCQJEIM
	uJxpnKa+UkvUacJU0hIvA+qDVsq6ZilBdQFxymIlsPCHs1A13ds293NlGScLUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kK24u6GzlnEjaQ2mQDYh4Z81JGvRRGNCchob5d0lgLc=;
	b=B/LquQeUadSiQCuVP2LtFz7j5ZEPJ8L5YtuTn+/p/eSTpw9KWhqhyLP+vuupSzvcVPmcHA
	0zd5034nyVvwdazLF5UdqCXc3gERxAsUvBFDAW/v2q2xG/2yfuBA2PjhZNQXJP3kIVWFEA
	/lSLh3HV7So/qgwVuT1mo0lbrbH70riQIc8j+/E3rPkjpN22l9PYeRRjQGOnJys43XBT9T
	nd+S1K6seu3w9M9ektgwpUe5ncLL864n/Q7/i+0eISUZObPVe1V2b3ninhKj51cNl/+uA0
	ntcFiY3KvbYW0oCusvA3kuZrbC3BxIq/zwssl+HiCEMGRkRDKk/cQAWKiDePkw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790716023; a=rsa-sha256;
	cv=none;
	b=BeDf0GaPXK3xAL30IiI1Gaz4RlXPcJ/Vh2pMF3xD5x20mBTRYUOEh48Y03vUN9fOgf/YYQ
	3nR+Cwfh/hDfJOxho8zGAaC4nb+YfyMdDixUvMGkxovryMUTM9CU2g3rlLFSrLZEgsYjtf
	FTFx5B9CHwJcbi4zMz+K529loIBby6oIZ4/VvbQnpLLTMJnPYmHzMD0lecbTjp7XlFivkt
	y6UmEanPedhm/+t+8GBV9jmlegxAb0KsbXhFxYwQgt8qWcRuu7S9XdQ6uP+V2BbJwPj2eF
	30vlBVeZ7bpLk2rekhad0e7MteC6/CVMCNYekYg4IQwqw6yqjbSnbazo2qsexw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBf2V-003S3k-1p;
	Tue, 29 Sep 2026 23:07:03 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4881E5B4CD6;
	Tue, 29 Sep 2026 21:07:03 +0000 (UTC)
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
Subject: [PATCH net 06/16] can: isotp: check the frame type, not just the length
Date: Tue, 29 Sep 2026 22:43:56 +0200
Message-ID: <20260929210700.1183036-7-mkl@pengutronix.de>
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
index 860c5221e299..e2dc10c5d11e 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -756,6 +756,14 @@ static void isotp_rcv(struct sk_buff *skb, void *data)
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

