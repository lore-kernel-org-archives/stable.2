Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F2E5013A4;
	Mon, 28 Sep 2026 19:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624009; cv=pass; b=OZ94PXU/S69ULLTbmOVCKQiP7VEYoSHp2S0mPr8osLd/bj5V5oUCgDyBjoGpuXALErncaDmUsGZMQBQGSQK1FVNbs5mNTMqyNCETaTFBJFHUXwJyhJUcIox1K14zGH0BY79cwNBUYA+HrPk7T41EE9uSCGfAlstRLilT9DvjyUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624009; c=relaxed/simple;
	bh=nArqHc2m+24XrlritmPUh47M0hDA0KT+FtUgdD0/Saw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxfWf51A6EUJTcsKa/ZAKiAeUj4E2XiKusRPQoBKOA3th0NKX4l/Zs/LrnTGDrIiAHcXMiDMa9ye7YHhYdPOOVolngg/ZsMobFiwbLx7AhDVij//ZhxkXfuqHzFljexK2XxJEbYsKwxqBTL3s4esLwh5ejKx2W4Yx6+YoaaNCDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=DspFrtmk; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="DspFrtmk"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C6401201F24;
	Mon, 28 Sep 2026 21:33:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WrVm8dfG8EonS9t6k+AS2DXED7dXmRTi8LHEaxXCN/s=;
	b=DspFrtmkDo6d5jgsuRQOi7DJ9HxwFvB8DP8GVBElHzGtTurehzowJ4ox039kd4PEXxO1tI
	+QwUn5AFyzfX8GTBDu2JWVKxuRPYH/SlL9orqpEaQjS8vSjSmBBWv+M4negUnlBFd3rIj7
	g985uDVj/N93ZLs2QVZ7ESxJU2Cax2IrVjWtuP4gDGiZ8+RPqAWTS1XzZmoYKaTv3HpW2U
	/jC9PBVeEOm+v5MsQMUC/b7bcLHrWOCGXoQ2SOW8sBDu/VPwk/qdc/JkzqrC0fYcSJzAAO
	8H+I/TjeQV0qmRISH/1xsrRJWsMk/scK0Nacq9VssK3rYCWG8kVnMMXtcA9p0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WrVm8dfG8EonS9t6k+AS2DXED7dXmRTi8LHEaxXCN/s=;
	b=borjB9hIk5tuxMAYd0zjxOFCLwRBUTyDopb+LDTIYERB1JBh+ONPQJBM6nu5/eieDkqHOD
	WWrM9MddbuqKkes3OuGcYOv64hjX0rUO/EBV5LHasB6E8QlqrnGOqKfAkmUVAorKS9ACzr
	Ja35gkkmfczn5Gty10Mf0LOjVu8tCVAaqgiL364yVb4xK59PewY60Ci5hPU7JbYaQjXQRU
	JL8JCffQT+Etm45g3+wwGfi6p6i5hmaGWmpmb4Wf01Mmf4on/v+pUjqug3LQwJrHBGWqfw
	E1KEkwv7VShHni3Z1TehsuMd9gvKqny0umpDj8Yn6dKt/CI1VTlKpi0rTr7m1g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790623995; a=rsa-sha256;
	cv=none;
	b=Vc3d76XsVeZgyTRzAsHOJwwE0X9DM9sXLwPKuePs5rjWDOtZRnRTkKlFDUL5DIqRG9yKHs
	KXfidz7fJKnd/fvXwtSUV2ofwGReUsYFM2JITWjjz3ye3Idcn+ZaiZVjODifU1hk8hScuV
	+TfaKGhhAoD23gkeegTGxmLgXd4tOOXdWTdh3XRW6WmQFB1/+Pi2lHrKkjk8M7oRwdrgD5
	hwgVOcsx9JKN0kADkBgW0hEl2pubQHUWSWOivl5byjk3htabusO5WLHEJEvGjAqHZwyH1G
	X5qhEBHekXnQDw+zwcygNMzQXOxoxh/VjNqwFODNWSDIOO1m7enxUS9GxBKE3g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBH6B-003H5y-1t;
	Mon, 28 Sep 2026 21:33:15 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 547E85B154C;
	Mon, 28 Sep 2026 19:33:15 +0000 (UTC)
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
Subject: [PATCH net 05/22] can: dev: init_can_skb(): restore skb header initialization
Date: Mon, 28 Sep 2026 20:45:12 +0200
Message-ID: <20260928193312.553632-6-mkl@pengutronix.de>
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
index f414b75b5c0d..738d5968dfa6 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -212,6 +212,10 @@ static void init_can_skb(struct sk_buff *skb)
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

