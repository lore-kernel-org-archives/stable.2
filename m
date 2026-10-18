Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744083E6DD0;
	Sun, 18 Oct 2026 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341871; cv=pass; b=U0vSO23K1FJOX3mcLgMgQSWuRY6AdbQ/NFbS7k1gehZsTPiP6lqXjw70LRiv40f6tEErhyKMEnDfnUU+FP5cKfjDgsxuPQ/SgGmeTowB8e868JYzISIw63LZg9SGPIrxZp3HBRFG/w+Xtvxwyf2UMMqcVK9kyKQzby52leYf8MY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341871; c=relaxed/simple;
	bh=lN+w9Hb50Sosh/5aDDQ9VPpOvAOfZv4llV6ijMEIaow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCPSoIqReV1LeEs4kWvmozdCBFuPMHRsmDVIGGU96WYwNEkEPtzcEANkB063rztIOZWBvwuLNqNpMTgDt/Hhpd/Nb7sUV3ezELSE19waOUr+CMUXIUagLOttSJDAKMvYCSF26gYSng6taKkuCini3Ys18NBm6G4PohN3RPVTKpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=D9GG8fxa; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="D9GG8fxa"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 59A3C20283C;
	Sun, 18 Oct 2026 18:44:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792341860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VDV5MA7YZtqhfRoQgg1SF3NmmVl5fJKMmfmIpU00WlM=;
	b=D9GG8fxaBz1K8GRSj5yJJrBEaQFN7OSn3yW9Y/aSSeMQXAzUVbTQha7bTL1pq37qDeEilM
	2c6p8UzBSxYDVEwrj5lhDpzwbPEE6HZeQ3Xy/J1EDnFVUmbZnA9WcwYO66+RlmQsimNb5e
	NT3Z/EJsIet1kZvo8uyNFPG+9OMQe95DRVqsHZqbDsio4+2L9TMH6Dp17ANoUXT1x1oO7j
	l1BVdbD7A8eKdXdi4q7WSOAgHsBcg8Bz0WXOalBYi72D9EAF6j2uQK1mkqA6/qrLLAI0Eq
	+4/dMfzQH4wBMcT3deNIA3doDjMoKbJnDF2cDe5uH4A4vIBcr3m4fcDTmoNuRA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792341860; a=rsa-sha256;
	cv=none;
	b=akhXmtjQ81dXSpSE9oj13giIC/Nk4zXqGP/N6plM3Sc+1xiIc5CNkr4AeeehK8vH65EoCd
	mIFDUzp0rv8mUKf/EOUV5qrvBA4imEQjhRe7QmGJ8V7m2hQGsSzep/jE82P3BMRGhnUWY5
	T8nUzsU/sGWhLIcKAmWJQhjj/r6nKej4eMSWK1PjYVUfecl8kPQCoyM62ANTcmnckDu0Ay
	CluCV/d5V737yyY5ZJEoRVHjWiXWZDTWpvnZ1Fd2JFPPS4ILqfsHpXelz4CLdPxhJ64mwi
	jjSDVKx5dWvgOx9aZK22JAYp7yOU0kWQ5CJjxN0MA6PkSQ6TZKiWLqmwRoonrQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792341860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VDV5MA7YZtqhfRoQgg1SF3NmmVl5fJKMmfmIpU00WlM=;
	b=NqKv4RCkIrgHyv/hmYabAOGyRmLf/BV6uEazpztG8KrzfK44GoyRr89VvWshFgNNA2I82B
	OUViOgybnmRPEQsieK8Bm49qnFlI4oTd5TpI7OA9w1Xij0b3a6RXcco6hSVGP/A48f1uih
	5HOF25qB/dgv32zQCRGy5je5v3vMWhMbEX1ofrvl9/XoLc2UU9wy9jgKQWVV7SldnXDxHy
	VFzzRqT0NDPVcNdYuRhxHP12vM9r5NKoRhTy8c0G7gJbwoOpThkVAQ8EaXn+jw/faJkWDu
	9w76wVWq7qA/9JpGKPDVvgeF9EC9wUt7uSueLHX0wj750ECmu3NtkhIegnEQZw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xITzg-0006Sf-0q;
	Sun, 18 Oct 2026 18:44:20 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 03A045C7D99;
	Sun, 18 Oct 2026 16:44:20 +0000 (UTC)
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
Subject: [PATCH net-next 09/12] can: isotp: check the frame type, not just the length
Date: Sun, 18 Oct 2026 18:41:45 +0200
Message-ID: <20261018164417.1540449-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018164417.1540449-1-mkl@pengutronix.de>
References: <20261018164417.1540449-1-mkl@pengutronix.de>
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
index 1a272ce6a2bd..5e1c3971ebfc 100644
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

