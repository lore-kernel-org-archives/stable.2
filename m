Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792578484;
	b=JVPWWob6vwAmZQytuxOyKASV6kTmpgQVAKP52s66IU7GhM6wsQzyIoehLtSUEoo2cnQg
	 toGF4AH9k1N5unxroFlD0Lr0HGaGUCzsiSuRQTcFVCNxj+yshjXn4LY0mT315x4utQSqQ
	 AQfW+CH67l8S6n2zmZCNosCvuge3Hy+BSUJri+CNdXtLADfqg31UOR1XLHT+seRGCS2Q9
	 7DHMn76FfIdoobjqbHT0hbQaWBvrWZMsIcreVEnxVFJJWgyYIp3WYRsZGMEBr2iSnKVyW
	 SczmQvaqjIrEqS6C3x3ZCd6ap+RB69R5iEODgTurjAWKuyoWpiNHcS9qbdQvmQ8wIfA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792578484;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eALao68/H5C/VsMyz1IjAZA3Cs8TeVJx3ISpy1cycgI=;
	b=JacTH2U0kMCmFLK+j/XW7eDR7CHwWIp7A9H/Lt1rFcNWIdsvaqjUqyFbbAQI++eoRQuX
	 PKzJqisZ4M8WJOYbUuWJN2uN+rPoR4IEmFR+iYS0Z99iCqq0jbbTrPqSMGW7RRaw7joP1
	 xqutfiqf3FBmOK0skbwwtiSBna12pMhMxMNLwFNYdgsSyZ7DLN2/r89pOUZjDOyu1Pe5I
	 ml593UOcrHY/fGyUWthdBXUWoGlkWajsNH7Zj762taLF0Oo17P5dQ2dqO51/45b/7mo9O
	 pD4sjHhJ6UuLABhP+mWvRIUcbqjrlWuDUP/lidxXahKyKH9DyDvV9aWKtmfgLjR0MoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=C2rmy71d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0629D606A31B;
	Wed, 21 Oct 2026 10:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0629D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=C2rmy71d
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7CA1A202921;
	Wed, 21 Oct 2026 12:27:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792578479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eALao68/H5C/VsMyz1IjAZA3Cs8TeVJx3ISpy1cycgI=;
	b=C2rmy71dWSchwn+PnMJkOq2YtF+8SO+OOqqsWL3QpL3oi6ioxTAQERdN0yVTDU/rVqCrrO
	jdwnBjdw9j0GkHq6TM3xd/u/b9YPhB3GtJ4FnYK3OYGi86Qwvur8X4sGH27uVypj3J6Wmu
	T5FoDE3tp+R19JplTAOc5XcvOxVNNpEc3JPWzA6NmQYoW1heke16UQ/2w+R03MKEe8H9QI
	HnAP2fgttuBjDWu/ogAOuJ/lE+HVcSH1mmHP9KcItbd51wu25SB0nyNvziZqcZARXh3lGn
	AVojyMy9D/lBtRGqJizlC/W3YbLSEm08yfxnRxNcl8Gz9mBgyZEd1Ii/KApPtg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792578479; a=rsa-sha256;
	cv=none;
	b=F36aI7gP3JXujlATdaWhlD43d3YyxpeqXWJtPSO2/WRdeSPQYR6kgIQyoFjElEVd/QB3gl
	1gCDU1hB5vIJkyFu1g8IHONyHFtC3U+kSb0x0eqhkafNTFEzrBmz7f4P2zifndKzQvTPHM
	KxVGGAoLXqFil59D92xwCWYsRCXMqv6vurN/qDrgfSyOw5N/yXGB1i0V+JVIzCsjgwDbsO
	KknlK25eJ3OeMS3nDwNTwOFUDWu44cFXcKUR1V3cQ2ylkrrGlnsAJyOILNKVjDaL2uVlLr
	0UerS1o5gzo+SjCHyACDGdTLJwS0SeJD2hlm4jCvS4w+Pji+wZLf0XTgl9qJTA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792578479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eALao68/H5C/VsMyz1IjAZA3Cs8TeVJx3ISpy1cycgI=;
	b=RTFbKFkptD8XRR2FNhlOGsuC2D9MIj5ykEeYOdx+N5C3WwU6hhZ6Pc045DVptSOdr+vRiz
	kg5ufvK3axALmD1IzmnavoNsgmGQ57RGnsq67HrQH2UKpXNsWE0hCZusMatkrlyCyQ0gzk
	HKSn2uKGmp3aAZONU1IGHzVGDD87A2CeGcfT3Xb1ZjZhxDTiE4R9KVTw5eDj91qXh28rrd
	Imhi2LY4dhvGz/Tk6k6haNhPe3k01X+lR1bf5VNF/Prrt3uJA+uJqFkbnxvbKSCZJ4rGZK
	8owIv4VYyVkXc5QMtLEY+z9iUaT73lE0uIJapMFyk7Q7Kzf/HodwV3lUSf1u2w==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJTY7-000Xjl-1G;
	Wed, 21 Oct 2026 12:27:59 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 24F595CAFDC;
	Wed, 21 Oct 2026 10:27:59 +0000 (UTC)
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
Subject: [PATCH net-next 05/11] can: isotp: check the frame type, not just the length
Date: Wed, 21 Oct 2026 12:24:36 +0200
Message-ID: <20261021102756.1900679-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021102756.1900679-1-mkl@pengutronix.de>
References: <20261021102756.1900679-1-mkl@pengutronix.de>
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

