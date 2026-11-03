Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793738611;
	b=dfzTSDnbiic/7dSwaldy4yaPKd3h1NUbRTFEIAHIyldDWfH3ZvkH4//fnW3eoz9nCC0L
	 lZN8DDvq+z8p+yrAMCCHI7XTxvtWtTV4NmqyePurX7mENUvLD2k3hoAMpzNtQsImOSR/a
	 fw1h0N80Tn2wNrKJKdNvmOKsU7KCBZ07ZhY0NzdoTQSeJREJ1+dR1GhtaIAEr5/kImsYQ
	 bV0qAlDSTa9yGcbxxCOZk/RqFvNJxxIFHSzaVFU1edbWZw880uNAuBMyJRn23byMVA0ks
	 LGpagndptPpmJjG7l+bOqL9bnn4LAh8hWB5LTGdeKafYTSQnTxsiVVn2pyXUakgnJZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738611;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uBL+TaD0bKQsormvsgU184GjxDs1/LgdMFn1uQvrKP4=;
	b=jtfhY00SnOaC3tXa9I4dLd9DAmmUwneCsslJaVfoaoqdYA5WZbVwHsUCNS9tpmoEOii7
	 NnjEcrcYsWCZJQoy6BBLX/fcurevW4AMUo+6ZCQtajyoR7gBZI/b4fZyUnIuyQhAFfhxe
	 YLSLPqfhn2VxE/8Z5ALZtSqjnnxoiiK1W3bz+biL+o20dRIML2gNOSaELuJUGGcHeZb+s
	 HOFStJsL2ChF0jh62op/zANBMJ9qHYN8BHTC8OQakO9i3aRH58fBBCcsOyaqOXlgf7Fw2
	 aeozXzgXbZfZVyrHamcDPqMFiwqTkCzBS12U7bxgpwFZIyA1vZqcZt0fZ4VzbSmb5hw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="es0A/AO8";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C9B606D820;
	Tue,  3 Nov 2026 20:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6C9B606D820
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=es0A/AO8
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3D6482022C1;
	Tue, 03 Nov 2026 21:43:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793738605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uBL+TaD0bKQsormvsgU184GjxDs1/LgdMFn1uQvrKP4=;
	b=es0A/AO8fuAKNjQOSeh68QI7Fk2Uy2BiwxbIMenLix6rRs5nTjLNp+1VoVJI9zr0Mh9pey
	ITVA0k1l3UEKoBxYamrK1dM7Oz6cJtLxeZYHusY1VZaXzU2z8qdHRDbBCRJ4SdMsiftPpx
	t9DqHpX0Pc0VX31rm4O0Fa0zRVaEdmjnw7E5q4rcTVTb0MGWiM99AVWADja0QJtMvGStm6
	FaHLG0dd7f6zQm/yukUzewyG3aUFPnOy70GGhRklc/XFzXDlTSzSmjuMu46rn3RywmCOdO
	QThkKa9KpmtxvR4SdX0b111ZR8br5Uo7dFGfZGlThik2tMYEpsYCy/elGFqGBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793738605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uBL+TaD0bKQsormvsgU184GjxDs1/LgdMFn1uQvrKP4=;
	b=NaUjh4PvwlFhivHsKA/hEzcBzsUV8EGaEXYG62jctxxSHqfSSj0kQ5/lIOEXmoMH7Vrv6a
	84BfT+Revt2sBNWcsoU1+TV/pc2PKeTeRNJEWc8dtbswjFCPR1ncwWvXFMGbjQeIFL6vwC
	mItQfMBbGWvdUR3pMLhcbEI3L1uOOw3I8wyLLOZBZ5cZKusPIbcBH0w630FLIuDBogNaUl
	LSru4VUzW2PrHtR2+8Pfz10oPdfTezAo/kljq3WmLFG08pPp9jsXBn3ylbbsUxzFnLv9Ql
	Or4KHlEWqjVuMhyTYbwdY7RxfzVWQGNBFYCl11nBKfoEsodWSTyyPr4j8awCcQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793738605; a=rsa-sha256;
	cv=none;
	b=FMhdMVrYILOcUHgIzqXtoc8kDh40C4SKxXHT+71kN9SgcBsX2qYBQBkBJlgsA/LfEdmNFC
	Qo2lILj2zdciftPdk0aRuCNNynhTpeHzfvylOFeNoywS5+scvnq8LHXt6Hz957mShfo+gP
	A+bAQsAKlq2aP5o7nnXQkC+ZuZUiYY7uRMdgyLX2fyf/t7Xiy3jQ0FZ2tQw0+gYRPM6bCw
	IpPJTYR+zENMQ7iJFD7T7Za8Vzlb4l/oqUAnz7/mVr7U1mQUQlUxV9ayeX9EbHivxE7ZQr
	UO7dktpy3/Hxqo5p3vW6oindz2RGBddVfsY/YfWOHj5ambnPKHASCCUEntU+4A==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xOLLp-002V8z-0Q;
	Tue, 03 Nov 2026 21:43:25 +0100
Received: from blackshift.org (unknown [IPv6:2a00:20:73c1:227f:2cd5:5d72:938f:f03c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DED605DDED7;
	Tue, 03 Nov 2026 20:43:23 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>,
	stable@vger.kernel.org,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 13/15] can: dev: can_fill_info(): don't wake up controller if interface is down
Date: Tue,  3 Nov 2026 21:30:34 +0100
Message-ID: <20261103204305.3211144-14-mkl@pengutronix.de>
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

From: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>

If the interface is down, the CAN controller might be powered down and
its clocks gated. Don't call do_get_berr_counter() to read the bus error
counters if the interface is down, and adjust can_get_size() to match.

This removes one trigger for a synchronous external abort seen on
i.MX8QXP when "ip link show" is run on a flexcan interface that was
never brought up. The underlying cause is platform-specific: on i.MX8QXP
the CAN clocks are gated through the SCU LPCG and the subsystem shares
the IMX_SC_R_CAN_0 power domain, and there is a window after
pm_runtime_resume_and_get() returns where the clock has not reached the
module yet. This patch avoids the netlink query path while the interface
is down, but does not root-cause the LPCG window itself.

As a result, IFLA_CAN_BERR_COUNTER is no longer reported for down
interfaces. Userspace must treat the attribute as optional.

The issue was triggered on an i.MX8QXP board by running "ip link show"
without ever bringing the interface up:

    Internal error: synchronous external abort: 0000000096000210

    pc : flexcan_read_le+0x0/0x18
    lr : flexcan_get_berr_counter+0x4c/0x8c
    Call trace:
     flexcan_read_le+0x0/0x18
     flexcan_get_berr_counter+0x4c/0x8c
     can_fill_info+0x1f8/0x434
     rtnl_fill_ifinfo+0x8fc/0xbb4
     rtnl_dump_ifinfo+0x364/0x448

This is the same class of problem fixed for m_can in
commit 91a55c72a821 ("can: m_can: m_can_get_berr_counter(): don't
wake up controller if interface is down").

Fixes: ec56acfef2af1 ("can: flexcan: flexcan_get_berr_counter(): switch on clocks before accessing ecr register")
Cc: stable@vger.kernel.org
Signed-off-by: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20261027065012.191348-1-chunyuzhiqiang@yinhe.ht
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 766d455950f5..b958c04d53db 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -812,7 +812,7 @@ static size_t can_get_size(const struct net_device *dev)
 	size += nla_total_size(sizeof(u32));			/* IFLA_CAN_STATE */
 	size += nla_total_size(sizeof(struct can_ctrlmode));	/* IFLA_CAN_CTRLMODE */
 	size += nla_total_size(sizeof(u32));			/* IFLA_CAN_RESTART_MS */
-	if (priv->do_get_berr_counter)				/* IFLA_CAN_BERR_COUNTER */
+	if (priv->do_get_berr_counter && netif_running(dev))	/* IFLA_CAN_BERR_COUNTER */
 		size += nla_total_size(sizeof(struct can_berr_counter));
 	if (priv->termination_const) {
 		size += nla_total_size(sizeof(priv->termination));		/* IFLA_CAN_TERMINATION */
@@ -1006,7 +1006,7 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	    nla_put(skb, IFLA_CAN_CTRLMODE, sizeof(cm), &cm) ||
 	    nla_put_u32(skb, IFLA_CAN_RESTART_MS, priv->restart_ms) ||
 
-	    (priv->do_get_berr_counter &&
+	    (priv->do_get_berr_counter && netif_running(dev) &&
 	     !priv->do_get_berr_counter(dev, &bec) &&
 	     nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)) ||
 
-- 
2.53.0

