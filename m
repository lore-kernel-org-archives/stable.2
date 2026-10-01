Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E55526AB3;
	Thu,  1 Oct 2026 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867958; cv=pass; b=Uw2bakZj2FrRIufVpYMMRgMFlu8hOgED/phCnILs8H8qIITsACcCujCgXYrNVETvDynfFZEpZ+oRPI4dbBvu/3xcQp2dz3X40p4kbiXdVku1mt/icLbgOrN3H99xXgO7PVqK720nwiRyQFDccA+Am4ZR3jLw9zYW1BAfPLtmE7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867958; c=relaxed/simple;
	bh=Fep/gWHwnYVMEJLkNg/UdCAT+6Pm8SNEGWWsePd11Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6whRpnNjTo0nj+7Xu3HvDwLdLpXuqSO+nS+Pe5NxsexyDMdx5Zw9FwH51xOvQq8J40V01I6XRdcxrKGc5VxICUavqT6rPtAxBmAprur3NHjCI+idl4wAQKEPwy1FxWP6OuI+ySfuLaO/xA5depKbHdlrMZt7CCPplo9ZKO3WPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Aqbwlr4o; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Aqbwlr4o"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9AB0520233E;
	Thu, 01 Oct 2026 17:19:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790867947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/xZybu5trsVvGfWp/yFbFfJrU/RBZXaO9c7oZieWl68=;
	b=Aqbwlr4o+LJaX7dR4Q7hPOBKJdPFEz+8lGMcq0cYBl/DXxbwTz747CkENonYWVWfwuX76P
	BPKx/5es3Q51OZWHnqino20f8if+JYyN+BBd+gXUTRoydywODvPqmqPfCZJNlAyPosaao5
	t42M1wfV+zAIkmgwVV0L1RmTiIkpk72IObDmmfExuNFDg4z2957uYrNcf01/UyiX0MdIun
	wk4ID4/W/ibK3SQ60A2z/NTVyAI7PPCIU3eZqoeAR1n0OOJaD+kFEKlwOgI11IbRIUIezi
	SiR0cZdFP5KeBopQ0MR0uJt1qdUyWyllaYY2Mnle8X9tSEX6sRaU5J6SaTmOjQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790867947; a=rsa-sha256;
	cv=none;
	b=XEaUsYdU+DtPaeOP42Z7+ZgYM24gxOH4FNWNtmU+iu3AVrqxOHzYcrdau7b95J9FXosKX3
	wZ/VWDtBfHNkbD6y9RhkiQoLWhpBlhzsC/TKdi6knRizJPALg8MS6HrGMr0zH+fxLmke2i
	CG0Z1Yn70GvmySvlanibYaA+2wWBgs4cMd2udjXTrY97uEnXOf2JP9M0+sgG31BW6yt06+
	HP+6aOWeSLUDcnnuFbVif0e+kEiIHGgmzBjNn77FC0Y356wiB94yMl5AXi9WBlEdJZH4Ai
	rAjuRyFDYgXU9cowKQgDc4bfJ2D4W+JbaInXoekLb904NH5VOA3ygRlDjrMFiw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790867947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/xZybu5trsVvGfWp/yFbFfJrU/RBZXaO9c7oZieWl68=;
	b=VS2Wq8j+Udpt5HlLxff9q8Gjz3+FRZmChH5OZDKNE7XMYbYreFYjWNnKkTk+84JJJ/9X/W
	cPEwVkGb40fZswmj4f9yQvlNA/RZMH4trYlqye937AYl8J4kqKnxTkbMhbwB6L3tOT6fs6
	h3i0pJ6rxRBv9EwYibdvJwFSEPyU6zvvZO0oTiAgq8b734nUord48ePcJWRHy3/ppIWsVz
	gW+4lpcn/ziymmuAd4V4Uwubd+FW+ftwMwkQLx5trajRrL8NZtdCXyDp6zasSjhTJQls5v
	4s9AMvo7pDKi9r9so8iEqMfiwW/WgLmLPONGqyDiYBYSZntgD6mCyQJHAL2PoA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xCIYt-003kSd-1g;
	Thu, 01 Oct 2026 17:19:07 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 38ACF5B7981;
	Thu, 01 Oct 2026 15:19:07 +0000 (UTC)
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
Subject: [PATCH net 1/3] can: dev: init_can_skb(): restore skb header initialization
Date: Thu,  1 Oct 2026 17:14:23 +0200
Message-ID: <20261001151905.1556270-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001151905.1556270-1-mkl@pengutronix.de>
References: <20261001151905.1556270-1-mkl@pengutronix.de>
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
index 95fcdc1026f8..14edec5afb57 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -210,6 +210,10 @@ static void init_can_skb(struct sk_buff *skb)
 {
 	skb->pkt_type = PACKET_BROADCAST;
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	skb_reset_mac_header(skb);
+	skb_reset_network_header(skb);
+	skb_reset_transport_header(skb);
 }
 
 struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)

base-commit: e23a64eb244356ee47c0620f0722d51bd88db522
-- 
2.53.0

