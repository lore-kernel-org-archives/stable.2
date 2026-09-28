Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E734F96A0;
	Mon, 28 Sep 2026 19:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624008; cv=pass; b=pBnuhlcGcCwv3R31n/kw1ceg/1ayunHQ9bsSBHVFHnDWNSA5xA0SHVoZVjE4CRK5W1iQTSR8D2QR236GpI1laBFNHQYxS9fEy+eaE6hHSYTF3qAilnH7Z2eymrMgE0gJoEHp2boqRvJD4c39140fqb2MQ5wLzLSykmjhwTAHfks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624008; c=relaxed/simple;
	bh=Mp6K8AParuJ+9EYcRhUsGfZPll1OB/eDKdnlsLL4Uh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1wT9UP56dzHLYf4bwgl3kRDpSmakWNYiWNNGhWaasCyOgyjrtSjB4vzBaUWD0Mbs7JuUt3V1wLu0flDY2UEQ1uzRAN/3o6eMxuNVJ6Ui9kXj64Py9XqpBwYj64GFKNKsQQtQ7e3i+krOodvwavqdx3349oLcMVszAP+JPjRGJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=OIY8H0/F; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="OIY8H0/F"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id EC5C3201F49;
	Mon, 28 Sep 2026 21:33:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MDjo99PGrrdtguhsC94jbg8sJAQXoxXzsVRvThSM/iE=;
	b=OIY8H0/FP9yCZ/JCxXI5wzqP4C0Z2o75cp3h42iMo4Pm+lqqXxn6y+QkqZdcHvcTPfmkm3
	6AfZskmYt1YGHZb3DGeJJhuOKwtxw5kE8lgJc6JD8U9u7cKQcAR+C863DUFh/0qmuwelN6
	oPnXMXwJ18yO6fn/3yjXFEehPDVU3wLLcQPSxcImGlO4vpSaIXqqhdebw2JwfqXBcOnSuf
	Oz6Aleapg5BAqmwDnFeFXZJhTWvr7xaJps7bkx7nyvqK/PMLen99/BHTefYz9m3iB0oUdp
	jzkGAgLl9f+DoYl86OSZiGUHfnBVwxHA7zDq984jqQFH6PHqLyCcY9q+YjNI4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MDjo99PGrrdtguhsC94jbg8sJAQXoxXzsVRvThSM/iE=;
	b=fvvN0AnNGtp+R2fHxJUl/F9StLMqrUtmM5Bn9C54bPAQ6iMsdpgr3BhByApDj5mTKjDFOm
	V5Z8JHNll4SpLhKd3mt4qv0M5xLmtFL6sEalSgKCRQx+Q+BNTsndD3DgHmJnyVTt8ThGKE
	jF6MquG7Hp4brX0tkY0dGh7yCrjxsnn9wMICnpWZs3MCiDAfRqljI9828F8rVhNEjzBqZ2
	GEi9hijzBD9GUkQmltFFJKbMPUKoxyD0Qlb+lKJ39dzoKSa+qS5FJySig+Z37fEiw3y8MN
	+93ugyhgR2HM7RIOyoA59AxrIT8XAQhe5ERdbcTJylk/XCZUNhKSc9HXBtmAZQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790623995; a=rsa-sha256;
	cv=none;
	b=dkq8C0Hn83FGR/t8mJeWR2ZKcWcwunQprRbp723QGX8GvPcWkWnydZz6YYNu9GH4146txi
	LIJOXjt75reAg+Wbm0RpR1FJvXDfme9WVS9IMIc73sl2kolfe83DWk7JR0sqQQXFHe56dv
	LBN7zeorxuzipEFTx2FBMjWQPPnYe6Pk1wUc7vUzcEPF/tQF9/wn2ZGg5qGv6xynpirQdy
	1noP6JWIBlpjasbL8FoSDNbdMfvVBpGehu0i9RMwfn4EyevG9KXEIWHrXP1fZCwCa6MIlr
	1sK6qk7ndzxDVurjT2TnOAE2XPgcfwH5wzbX8xC61bs2WsrSe7E1o0Sk9HTz1A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBH6B-003H64-2b;
	Mon, 28 Sep 2026 21:33:15 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6D1855B154E;
	Mon, 28 Sep 2026 19:33:15 +0000 (UTC)
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
Subject: [PATCH net 07/22] can: isotp: check the frame type, not just the length
Date: Mon, 28 Sep 2026 20:45:14 +0200
Message-ID: <20260928193312.553632-8-mkl@pengutronix.de>
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
index 155530aedce2..1e80eb2a6bae 100644
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

