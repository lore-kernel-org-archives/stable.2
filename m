Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792429733;
	b=NmIkrX39qTjMRYXBIS99qc+oMQqs66uo13s7DPllEeOR7pUho6DXINJYTK7gxlgq9JtY
	 ht6OTuhXE94Ydy9Dy6fccGhSqcqcz3taxXn2HEhf4Ehey/1aKMI27iRW04D8BhfJ+V3dl
	 iDrquAG/2bnMXQbzSvAwtORAV7/AMSsfGkQS1WtkVXwr4LgClnnqKiGRSjQBZ+AalKbcf
	 ItvdHWAV4IsMSZUw03D1zAz0sDqCHuGv1VUpKJ1QGocIasdmjz2hlCHk6ORs0069vc+h4
	 b3ui1Udk4aqjrFTTCajjLZmW5ff+v74JKXlvKIo2HPnRRTXBORrCrAuEf6QNBHtqHlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429733;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eALao68/H5C/VsMyz1IjAZA3Cs8TeVJx3ISpy1cycgI=;
	b=JWaY84L1gxlhUK43J9nJZaZXITIHtn2yilIRCdyaj95+H9S7Jyc9fQV6RXxU8pkGTlVb
	 4kMozVcw068v24ftJxxCcraTLLkR/Zri7tF8iu12jfc9YjBj6aRx1xowfrQKam6WOqUiq
	 WgvMu0Z4bbHHAFWHCooF8qn8PFN++yKxlQ5e1HQrgBu099d/q8gA/ROT0n51KH1hrN35X
	 4Jw9aLTHsLNi5giKNmofyAF5IoOobjPROtOiPEqMtwCMS3CF6h5jgVHl3RQjAX1BGpjU/
	 i0uW1ALaq4weDnAd2KJTHnzoeUJb6ALEUOR+XSV1HFXx9iYy/K3uerq7LGlVhrCLptA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ZTp+5dhs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC02606A337;
	Mon, 19 Oct 2026 17:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BC02606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ZTp+5dhs
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 15DE3202855;
	Mon, 19 Oct 2026 19:08:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792429717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eALao68/H5C/VsMyz1IjAZA3Cs8TeVJx3ISpy1cycgI=;
	b=ZTp+5dhs40pCb8tfzCnJL6WafcRzplPTVkHDwPojAJeHx7qkIwHlt+eOtXL3KPC8eKaW+D
	8Gxr/+ozgoQf9f+7X2Z9jEL8da8Zw93yivQCQCRRsnxk9smvLhXYgJDTiz+1AvmBayi3aO
	fTSbnZxaeY1pfBrovvkwdu9pXl4UueldH4qomiCxG/akjNPwQgb+aDBkVC+9BhyX0N4/RB
	2UfTEy+Wsq5yqT6dfo1XUBmDnjY4hAx+suF+tNWuPO8vb5xOsPGoers6fbiTeuC+aIenGN
	D7oFGMiFpkDjs2N+FW55IkgoSg1yRtGlnvZNYvotyfaCb+cFT/fXKmzzjKcsEA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792429717; a=rsa-sha256;
	cv=none;
	b=JJaO1f+PCVdN1O465g5L6DrakxSkga3fJoMSvlW1XNEeLY+wLvrSghcCqdqrNApF8K2ptL
	7UySIKwAxHQWzmIa0lkQ8VGm2eClhuZLtRy3GZOVW5QaxRCN1AqqEssSwZQttWkiku1Wmw
	wzRz5zbwvGUsyRLWMc9Dx+bxoc0P48Q9dOlTusCbdEyR/5f1swnLaWzPBG0jKb7BUTcU5a
	v4RkOjnrzM/MuhgnhwQsJe1IshiWZJWhqhGE5C6NpL4OuWQGks/77CYBwmAk1lqDjgDzWU
	F1eWEjGaBGl0/Ejodyh7xpy+0jBo4jfSC50+ni7p8A+hFRdr1hOQLBNO2MaCOQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792429717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eALao68/H5C/VsMyz1IjAZA3Cs8TeVJx3ISpy1cycgI=;
	b=SzM696FwEGXCsyE7U5d+WBXQPtBKtp3g/pIAqtdvMaz5YV0KUvdGhEINaWZC5rE2R/fPWM
	HmzTn5B+trrIE/zhiteLRmzdcVxQbUb+GceQTDsLDkGE8F7/fcH9cbvSdxr3FlM2xuP9it
	NQ6qAQS1eOc+XJDr2nCk+ZDXax9H3oMR2dW35MA77l1K/R4nVCvPv/h6qG7QANZrGbgwG7
	KAeBG6rJEBXKX3Nyi8c3scvpSw5ZDFOOsQolYl5pWuJWeZlouXt2RMZdXn6HehJ4eg3LOS
	npcd/PyY1P2N8h/MobdYzthf7sf82TmDYHN1GytYgVNgZtJb62/QYnBUwjlzrA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xIqqi-000FgJ-34;
	Mon, 19 Oct 2026 19:08:36 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A20F35C9490;
	Mon, 19 Oct 2026 17:08:36 +0000 (UTC)
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
Subject: [PATCH net-next 06/11] can: isotp: check the frame type, not just the length
Date: Mon, 19 Oct 2026 19:01:11 +0200
Message-ID: <20261019170834.1727150-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019170834.1727150-1-mkl@pengutronix.de>
References: <20261019170834.1727150-1-mkl@pengutronix.de>
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

