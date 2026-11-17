Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794953353;
	b=tyZxZSL5YO27KMNRjozU9aN0Y94cIiodGMyADFj4iz5utYAeydnKAG6zJr3ZwFoqLB/H
	 CCa0XEotqTswTu8ZWdSR5EGZ8uZQNViQk7v98RP7gPomGOw0U+d/RwvDYxSHTuSqOyfq7
	 Out2NknMfnsmX4y6GqZu5vDufSFle3H0/V72CdrvzRHA0JMPl012zMa4y2WSQ/KymlVVc
	 /80zXpTA/HNmSOxy26aMop2rIa6166lepN616OGOJFNw5HgM56w/wzGDGuyBiwKCJFZ1W
	 sEIHiYQJLNPZVtnZuosYJnBebnQMeEgLwS+dvkuasGRnCexElbr+OlzB6CzSACV6SQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953353;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jRPz6s238TSnenkSdbnl7BRmhJz1YdcSv4oi8jRDggQ=;
	b=fO3ev0jJqt4jICMV1MOOYaVVFqp+nVOY9Fr+y7fSgANOF3B+n3LAAER/si3A7dSu0Xd7
	 1bYdWHirHdYIgLkulmcmxdPj3CKtTITDJmmENbj2q8jdLW03aDUdlkwtVDEqMDp4DzJxK
	 zCwKCSQhnucY8HdBgdRtakdHrThSTIw54yl6zfPkfXUp9+vVULdJWBqhNLUCgtqSWjuaV
	 vp1fp2yxzA17OVhyPNp8aW6i0TcmOZpYenpa6hAgewqj4zNq0wgoxL++XzyfXU4oFhOXZ
	 TRSg6K2nBeF/lgh61bB1MhSvjOYPTZTSpaWmHp5q3mke/gTUTroJmqFKtfcnNcaqBww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=AJyuRSgm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9245606A330;
	Tue, 17 Nov 2026 22:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9245606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=AJyuRSgm
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0E892205A5B;
	Tue, 17 Nov 2026 23:09:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794953347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jRPz6s238TSnenkSdbnl7BRmhJz1YdcSv4oi8jRDggQ=;
	b=AJyuRSgmdhTueZ2jZDdwNEmuNTwQvYwjBOpl2b93HEhZorG6oIsYKjWWzu4I5DYHuQV63K
	I3vj044G7XJPzriwQg6Jns2IRXrH0MpK6Fts+0kW5c8J3qb7yEEAMSVY4y4e5pnYG49SB+
	AHSxLJ7NkzCqwYfFEMKzm2WRnUyhTwTJ+LuRzz9QPZrcGWJyJDtiT00DWCMEUgISVX57AA
	cu4HBXiL2bslD2jrQ1G9zRWRaNr/OPxQiNB9kCUXR331pv5hLax5LFkM5A0C59P9ilYGw0
	Ir0nZkN3T6PpxAqshpjBY0+SsSwmno/3Gz9N4J62XIaXaDZ35HDF9+g6OtEtww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794953347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jRPz6s238TSnenkSdbnl7BRmhJz1YdcSv4oi8jRDggQ=;
	b=eDTEIs/axJqjFNot4dl0qPiesWpLO3SfwT1Rqh58wQ/j8Ry6n8J1NpV3BMHDLkCCuzgSlu
	EFLKPoWMI7nUQh+EdePuldIDFnyzKLB3EfzBApeGTerfAJHkKH7zwbCT67b/eqJ60Tve3J
	fnGHtyD6JGj5ymPxNCLcF57xKx+2FwlDoRUHjx+1BuPd/c2GgtA42hB6k/eGmNWuQGlptD
	RyIaNvfGrEtQNln4w0DQ7NhKQPigunD2VJYMLpROAiFGl19STHj4+NHhYxcLTzrw8ybJng
	FPE377z0BFHDA0Lxsj2S0616cQcEbfDW0f8SgePn5MkvHMgUYyY64LPEuaTrKg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794953347; a=rsa-sha256;
	cv=none;
	b=CaUW8ql8xNNojhIKeMugrNENXMLnl1GFvmNBBb+kCpSUY8Zy8L0XP1iyAWfBfsTINmdFw2
	rR+jXXK7g8Ru21ZFpzEb4rL6Nmfk+ENIx18k8hXYOqQUPXdV413fCa3zeL6pv/Oy2dEWWr
	CG21JzW3yEDETolzXvfAtD1dkgj424RpVdM+fGpJ1vRQHbmeoa2EVuwfin+Zj0uVupsWlg
	bXS5BNM2bZB1mzbIhfsIJw1Zw6AYswmmsCAxC0VWzDZPafuSgpl4F446GA2ipAXR+EAcZA
	dO//q5iqmUCAtiiyN5Z8OR5YvgCSVi1Xgaa0Aa8Sx3rYhUruV/JJhPDhLVuFBg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xTRMQ-000Fmk-1S;
	Tue, 17 Nov 2026 23:09:06 +0100
Received: from blackshift.org (unknown [192.145.8.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 943CA5EDA2A;
	Tue, 17 Nov 2026 22:09:04 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Zhu Ling <zhuling0805@qq.com>
Subject: [PATCH net 07/11] can: isotp: reject socket options while a transfer is active
Date: Tue, 17 Nov 2026 23:03:12 +0100
Message-ID: <20261117220818.1142581-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117220818.1142581-1-mkl@pengutronix.de>
References: <20261117220818.1142581-1-mkl@pengutronix.de>
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

From: Oliver Hartkopp <socketcan@hartkopp.net>

isotp_setsockopt_locked() only checks so->bound before it changes the
CAN_ISOTP socket options. When the bound CAN device is unregistered,
isotp_notify() clears so->bound, but a transmission or reception that
is already in progress is not stopped and may still be draining.

isotp_sendmsg() claims so->tx.state and rechecks so->bound. After that
it can block in sock_alloc_send_skb(), while the device is unregistered
and so->bound is cleared. A concurrent setsockopt() can then change
so->opt, so->ll and so->tx.ll_dl, before isotp_sendmsg() reads so->ll.mtu
and so->tx.ll_dl again to build the CAN frame for the skb that has been
allocated with the former so->ll.mtu.

isotp_bind() already rejects a new binding while so->tx.state or
so->rx.state are not ISOTP_IDLE for the same reason. Add this check to
isotp_setsockopt_locked() and return -EAGAIN, so the socket options can
only be changed when no transfer is active. As the transmission and
the reception always end by their timeouts at the latest, this state
is only temporary.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-d1d3ef49-c24e-4f3a-91ce-20f8fb222684
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20261117-can-bcmlock-memcg-v6-7-6826a6227d36@hartkopp.net
Cc: Vincent Mailhol <mailhol@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Zhu Ling <zhuling0805@qq.com>
Cc: linux-can@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/isotp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 0293d590186c..32c88749d75e 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1725,6 +1725,14 @@ static int isotp_setsockopt_locked(struct socket *sock, int optname,
 	if (so->bound)
 		return -EISCONN;
 
+	/* A transmission or reception that outlived a previous binding
+	 * (unbound by NETDEV_UNREGISTER) may still be draining and uses the
+	 * socket options, see isotp_bind().
+	 */
+	if (READ_ONCE(so->tx.state) != ISOTP_IDLE ||
+	    READ_ONCE(so->rx.state) != ISOTP_IDLE)
+		return -EAGAIN;
+
 	switch (optname) {
 	case CAN_ISOTP_OPTS:
 		memcpy(&so->opt, val, sizeof(so->opt));
-- 
2.53.0

