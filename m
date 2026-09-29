Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B0233AD8B;
	Tue, 29 Sep 2026 21:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716038; cv=pass; b=d4FpUGnU0ziBXxVcKDtnIajLwKxiPx04xNx6AMK3DZ8pFs9nJMgYS7W3/3ilaAv1nKk6wNojjextlgcZzCyR1FY1M2XyA7pCM5N8DaCn/S6XUUPG3EmPm66M3fF5e/MnWPKcRWOV90OQdulbahYfaWCkQtyuxSA5ri+uZHE2yUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716038; c=relaxed/simple;
	bh=PIRT41RQh/hv8YCCc0EZAjtenY4Hk3oqH52J+radMuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyAk2pxsZO+MJ2zsnyazPLcXZABkUzq4Zr3xkIjjGKqa95hiyL1aLDQRY7uWdEAFsltvVSZ3ePOXYj+V+YHgsaHov504CmO8lZIOfP22U3q0g4Ku3FcJVT/Se0Hl1m3xnnTqfrjuWjQf4vPTWKXSYkDEnP3sDtwtfGjgdp5NvgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=HX4l8Jxj; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="HX4l8Jxj"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6ABD92004FF;
	Tue, 29 Sep 2026 23:07:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XrYqReFkRSC1fu7Lp0bhsXTcDaMAEJZK3J13C7FHjR0=;
	b=HX4l8JxjHSZ7uGcKbQHt4SysW6q70/crYNIwxRyXRku/376Dwb+Z6mu0qIz5Zy3YL/d/KK
	KhXT87HljODAhbwkSkR7KZphNXDnm05LBrnBZnfRjPrtCr+8rQg0Dyy7w8enJbLD3iZ5Aj
	jcDY8L2vNAYF9TA98da7vi1AiXPGEg/fq5+RV5t1z6/LOmX0woJJ/DNNfMbfeqD62bNW5D
	vZ0CZcB6GClp1WB0cstuZc+00V9w1+zq5BmxcRPq0tu0w54byaCI648s0tsfbH1pypQCY/
	KGXAYXz/dZkh1ryzpBsXPCwAVTZXrOWsK+tvZHMQhv7E525wrKGbOtIgm5dlBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XrYqReFkRSC1fu7Lp0bhsXTcDaMAEJZK3J13C7FHjR0=;
	b=D2Vmo/xiEh+glHBSvfU+R8D7tzmmcxsRKMemGN27JtEv0RMe6UMaxQlJfzhP23ws++QHge
	wXq6iS0W9G2kPqTdLy5KYRJwv0mDrOqD0HUvSfIGmKCgZpxDlVJcqHxui3IjcXTz1sRz3z
	Nzgc2wCAvvbzsDKqMfHUc5gVxc6/ullPozGm7GPOY9Byz0EqdNcX381iw9yye7foY3ULjY
	mKYuoMGKtlRE26E3ZP+MltTJLvHsfMSsS5Vyex7LPh4+fqnxmJorhgmOtBdvs3ocffHgFq
	pgoR/8MHm7MNk5yN+KHq5miJkoj43tKSxi/UIoiiVNSIDF085wjvGHmcePUdBw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790716023; a=rsa-sha256;
	cv=none;
	b=G+dzmfChLtNSk+jbEIyscePLsVhHhFPGvD9sj2SEPcpOBO8BXophROU1kbbb3UQrEl0t2J
	Cn7fXGcmIOe7w6vGAP/hkyuYdm/zbQ7ibKjjdch6z3QSCFi7PLJjqe8MeX3Dq0Fcihia0N
	moexSo8EiaAcCdb43wMwia2IpFP7KupNzVnHlczHa0VkrCadKzghm0bQdrj6HOcv+vXY7l
	BmpqOz8AsHiDfVprGxJX/s9sNd2DwXQQ0KzFwXPRPI3CFeNtxeyIImKocutTXia6+zxH7l
	UWefyzWEiqTgoU+TAR1jPtj27eZLCjkOtZke5XxBqjsp+mToKrjTWR7Lqqr4rg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBf2V-003S3a-10;
	Tue, 29 Sep 2026 23:07:03 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 00AAB5B4CD2;
	Tue, 29 Sep 2026 21:07:02 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	zjamg <ndaugoing@gmail.com>,
	stable@vger.kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Quchaosheng <quchaosheng000406@163.com>,
	Shaunak Datar <shaunakkdatar@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 02/16] can: dev: init_can_skb(): restore skb header initialization
Date: Tue, 29 Sep 2026 22:43:52 +0200
Message-ID: <20260929210700.1183036-3-mkl@pengutronix.de>
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

From: zjamg <ndaugoing@gmail.com>

Commit 9f10374bb024 ("can: remove private CAN skb headroom infrastructure")
removed the skb_reset_mac_header()/skb_reset_network_header()/
skb_reset_transport_header() calls from init_can_skb(). As a result, RX
skbs from alloc_can_skb() and friends again carry mac_header = 0xFFFF.
When such an skb reaches packet_rcv_spkt() (SOCK_PACKET), the push length
calculation overflows and triggers skb_under_panic -> kernel BUG -> full
machine panic.

The same issue was originally reported in 2014 on linux-can and fixed by
commit 969439016d2c ("can: add missing initialisations in CAN related
skbuffs"). packet_rcv_spkt() itself has never been hardened: only
packet_rcv() and tpacket_rcv() gained dev_has_header() checks in
commit d549699048b4 ("net/packet: fix packet receive on L3 devices
without visible hard header").

Fixes: 9f10374bb024 ("can: remove private CAN skb headroom infrastructure")
Cc: stable@vger.kernel.org
Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: zjamg <ndaugoing@gmail.com>
Tested-by: Quchaosheng <quchaosheng000406@163.com>
Link: https://patch.msgid.link/20260917123716.63116-1-ndaugoing@gmail.com
Reported-by: Shaunak Datar <shaunakkdatar@gmail.com>
Closes: https://lore.kernel.org/all/20260918151606.765490-1-shaunakkdatar@gmail.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/skb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 4f7a189de265..bc0787535b52 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -211,6 +211,10 @@ static void init_can_skb(struct sk_buff *skb)
 {
 	skb->pkt_type = PACKET_BROADCAST;
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	skb_reset_mac_header(skb);
+	skb_reset_network_header(skb);
+	skb_reset_transport_header(skb);
 }
 
 struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
-- 
2.53.0

