Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792578485;
	b=e0kzIUUIzun+PePbLO+M+sDvXiq4LJSTQyrDaHBpqF6fcboGFpnfTxq4nu2H61rXWBQu
	 MyDQjGsin5VvGSJkSyW7P/gucuJFHGLSAy7aRPnvQM8nfe6MP8YvRDz/cqVBPzvHDRFWs
	 sdktvdjToTqZ52zMO6o8TBS8AQXE1Ye7wI6OL9ot2AvL+TP4ND21aWXVLwCxhNLFR19UI
	 VU3pHbDFkFS1wvcsWBYXomkFUS28TxQ+pbARHVpfvFCMlvdoVKzIi8JEDhHAXPIROJx0L
	 qVeUoU5URbTUD3QuzlP0Rie1fsel8HO4FQSwLTrVmJb4aEKlqUiUbGYwKvQsO4LSrOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792578485;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Rd5lSezKIyW/9dcGa/xeP6YPWeM5EbHyXW3FSFeJnHo=;
	b=ZMIAL6+L7j869Q51XdlnM2bUIe6/Z3/sQ7o5owL+HmEJXbLrKsKaKfVKW+XLrABilY4s
	 8eMJwLjhsN5gXvfTDpPrs/+oTGDD3+CdapkxAhE+Kk+JadqtgQJCvoBAlMZxYhoks+I2T
	 0crgorTIrh/pHxmy799LnTWDIEXioC74QhCdSZL6yNOB95DIZ6srTyLsZZZiVSeLje+xT
	 KjisFKfXru8OR44QoOsqPRgIlksnMrHGUeky/LJ2x+d99gx12zBHnW3sX0pIOlJ+Jo1kN
	 pfNEM03ixjwGpjV5aKvmO4i70+PC7b4T1PnFwpN+JO6SQ0BkXqfdtxz6S4K8WgT6CkA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=UipT9w1a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447D0606A32D;
	Wed, 21 Oct 2026 10:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 447D0606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=UipT9w1a
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id CE176202926;
	Wed, 21 Oct 2026 12:27:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792578479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rd5lSezKIyW/9dcGa/xeP6YPWeM5EbHyXW3FSFeJnHo=;
	b=UipT9w1aX6kXAg6BbQMqCnZBBT4DQcKJ4nwu4O20EiUeXgKb2rvN8RRuR4Vz0LM+Lew1ju
	NdnhHn4xrP1v/HwnX8L47m0IJ2WKuqvWi4VnLjcnIlJGmxU3DHx6dLnmJZBaF5TdM0C0E4
	gdfiWnTsv/2/xirfg9QOzNNPbYWKkVdPIoUcWm0KaaJMtCdKV6RqKB9uda1u9vhuWlu17g
	LF83/8wH60qwbiO2L/TNhS/95waAzwHDmEOWez5j0zOJikuQ53Mu8a+VBWKGPx3t2zoHa/
	jy7LWmPPaDXf/bOMEFrbgIo0M88T1AqQy+9TrLdbegTIqJ9NffHDQqKN9wX+bg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792578479; a=rsa-sha256;
	cv=none;
	b=XBZwRjN+OdUpsYzAhAXjbla6utHAylIRjqrbHloetF6F7c/A3W9exOCS/83+ti7NbE9HAd
	s3DhNwNWumSfnwFD+kl4YK7fREQMyaLUgjBkWTjXM4pElu217eR6JwdmEhi3flyNwdxBM7
	4G9j360k/JbjsYNPMygHarbLV9ehxsKA5mDnG+/q6ZivokOWmx5vXZBvMEKn5EbzhJp3nM
	qGowtqQ6/fYzIJ4Hc25PRegCVXY0y4jAl+6sLLs8qHP56yUbPOgnqrHMx6ETdUELCNJvPs
	TXCGYI3oHdLladj4qJcPE5gSwmo5doHYC3ethjKLh0+wVxLdzmjkVnhKRlCKiQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792578479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rd5lSezKIyW/9dcGa/xeP6YPWeM5EbHyXW3FSFeJnHo=;
	b=TcWuK2dTiuOdfgNOBPaIb37NAlISx0DMnQoHXIr/AXcrOJn7iSzqBON5H9w+sCx1ybXYA0
	9fU1x8Q2yBrySP2I3iZBoDrAzGdNOFbgOif0fYQ2CXAPgs0LfRvQ0ouVtA7h7RB1FrBd4X
	brgB0N2dXj0iFoj/ehJOvaWVuA4x46GjLib38BxpKFBUilutDLN/e4DQPQPjazjHiqkwm2
	wNoJpaq5DT3Vke5Tizl95TW4PO4XzEejRTTw/I+EGs/y2hFizfrNsw3JRwuc9OvlWqc2Vg
	Vy6PfkqYgR8GxEgMf/otKpvsfrzB7MC8PGoXzd9K6dX67kYI1rkQHhGAjmJQnw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJTY7-000Xk7-2M;
	Wed, 21 Oct 2026 12:27:59 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7487A5CAFE1;
	Wed, 21 Oct 2026 10:27:59 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Cunhao Lu <1579567540@qq.com>,
	stable@vger.kernel.org,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 10/11] can: dev: can_put_echo_skb(): free skb on invalid echo index
Date: Wed, 21 Oct 2026 12:24:41 +0200
Message-ID: <20261021102756.1900679-11-mkl@pengutronix.de>
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

From: Cunhao Lu <1579567540@qq.com>

can_put_echo_skb() consumes the skb on all paths except when the echo
index is out of bounds. This leaves ownership with the caller on -EINVAL,
unlike the other error paths, and can leak the skb if the caller expects
consistent semantics.

Free the skb before returning -EINVAL so that all return paths consume it.

Fixes: 6411959c10fe ("can: dev: can_put_echo_skb(): don't crash kernel if can_priv::echo_skb is accessed out of bounds")
Cc: stable@vger.kernel.org
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Cunhao Lu <1579567540@qq.com>
Link: https://patch.msgid.link/tencent_683AA16E643DE00211CD2FB62991264DC605@qq.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

---

FAQ:

Q: `can_skb_init_valid()` directly modifies `skb->data` without checking if
   the SKB is cloned or shared. Is this violating SKB shared buffer rules and
   causing data corruption?

A: The finding about can_skb_init_valid() modifying skb->data on a
   potentially shared buffer is not relevant for this (correct) patch.

   The FDF-flag write in can_skb_init_valid() only matters for PF_PACKET
   use: PF_CAN allocators already set CANFD_FDF. The write exists to
   normalize frames for PF_PACKET observers (tcpdump/Wireshark) so they can
   distinguish classic CAN from CAN FD at the netdev level, and to
   compensate for PF_PACKET senders that omit the bit. That normalization
   is functionally required.

   The shared-buffer concern only becomes realistic through a specific
   chain: a PF_PACKET sender injects a CANFD-sized frame, the CAN driver's
   loopback puts an echo skb back into can_rcv(), and cgw (without
   modfuncs) clones it for forwarding to another interface. Only on that
   second can_skb_init_valid() call is the skb cloned. By then the bit was
   already set on the exclusive skb during the initial xmit path, so the
   flags |= CANFD_FDF write is strictly idempotent for any parallel
   consumer of the shared buffer - no memory-safety or
   information-disclosure consequence. It's a formal violation of the skb
   sharing rules without an observable effect, so the current code can stay
   as-is.

Link: https://lore.kernel.org/all/54a3cc01-abcf-4a33-b932-39bb1f68cdd5@hartkopp.net/
[mkl: convert Oliver's mail to FAQ section]
---
 drivers/net/can/dev/skb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 3e36c0368bae..738d5968dfa6 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -55,6 +55,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 	if (idx >= priv->echo_skb_max) {
 		netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
 			   __func__, idx, priv->echo_skb_max);
+		dev_kfree_skb_any(skb);
 		return -EINVAL;
 	}
 
-- 
2.53.0

