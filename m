Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745E6393DE0;
	Fri, 21 Aug 2026 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305717; cv=none; b=X4307UkuB3yfjX9rtJrPpo8041aVQ/u4d0lZCU1AUp65nTv/SiztfwkNsA3w5BKvISFq4E6Rz5q8HmjqWsGJ9JTdUzPWtIVgNXPj/fp/EH5DcFM6mQEh+lRJI9vINiu07E6euFxoonaN+cS8APidUaZlMuLMyG0o3Pg6oWWAlwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305717; c=relaxed/simple;
	bh=MSOr1+oKhVdvvfA/IaPEx54/pOEC1inYdnF4D/JmV80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1uLOZMdIsJy/5+e11XPWlEzPZo/dj4In7l1DO7q+A08SsW3N16RCCTqL/W886lHDeizIYu7osOI1Bd2Zl0wDNZ2Bl87v70QPs3pG/cKEexU+xGL1p11KLEoUUPfNjbQBuL13SlUy+iEtgSB+GGUHhat51rVqvhBHfppyBSudXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=mDalJkDI; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="mDalJkDI"
Received: from kero.packetmixer.de (p200300c59714fCD8ec8C87C354003FEd.dip0.t-ipconnect.de [IPv6:2003:c5:9714:fcd8:ec8c:87c3:5400:3fed])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 90A87FA12A;
	Fri, 21 Aug 2026 11:48:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1787305701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fG78UxU6xTQ7UwE1I43P2EtSWWeuhI9N9UOuRX8oqeA=;
	b=mDalJkDIUKyYN62BOeZ3cKQYabkLSqRpxO0Hoxcvhe2j/PhEPhzMzFA+MFDvRxWRxvldWb
	IzDBHMguJBe75FvbjIQ4pD3vwpm885jwvpUpnc8Jy2UHtwKqBf0HRBvXERqiIV7Dod5m2U
	KNtIgE926/QGSpvfpKByzFHEoxc67y+liAUiDaLTbSdinX2qPkVwXCzXSUTERPgaU/JEV9
	Zm6/HHQryz3Zl+dwyp5uEA2JVCQB12rBVp/WJbOijyCIBdnjjrvzAGrPRmOgCOkexlkTGf
	E1P6P35yltPY+8TDKyWDLzj8UV/cRYoLc6Wmlwt+NaTQYpy/rNGf2Pbc0xRcDQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 6/9] batman-adv: fix TX priority extraction for BATADV_FORW_MCAST
Date: Fri, 21 Aug 2026 11:48:10 +0200
Message-ID: <20260821094813.201800-7-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260821094813.201800-1-sw@simonwunderlich.de>
References: <20260821094813.201800-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

batadv_mcast_forw_mode_by_count() pushs the skb->data for BATADV_FORW_MCAST
forwarding via batadv_mcast_forw_mcsend(). But the
batadv_skb_set_priority() expects the ethernet header directly before
(skb->data + offset). With the moved skb->data, just some random data would
be accessed to get the priority data.

Move the batadv_skb_set_priority() before the decision about the handling
multicast packets and potential header modifications.

Cc: stable@vger.kernel.org
Fixes: 90039133221e ("batman-adv: mcast: implement multicast packet generation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/mesh-interface.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 8e55b61dd2a64..e202088cf1fd4 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -305,6 +305,8 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 	if (batadv_compare_eth(ethhdr->h_dest, ectp_addr))
 		goto dropped;
 
+	batadv_skb_set_priority(skb, 0);
+
 	gw_mode = READ_ONCE(bat_priv->gw.mode);
 	if (is_multicast_ether_addr(ethhdr->h_dest)) {
 		/* if gw mode is off, broadcast every packet */
@@ -338,6 +340,9 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 
 send:
 		if (do_bcast && !is_broadcast_ether_addr(ethhdr->h_dest)) {
+			/* WARNING batadv_mcast_forw_mode might add more headers
+			 * in front of the skb. and might even reallocate the skb
+			 */
 			forw_mode = batadv_mcast_forw_mode(bat_priv, skb, vid,
 							   &mcast_is_routable);
 			switch (forw_mode) {
@@ -355,8 +360,6 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 		}
 	}
 
-	batadv_skb_set_priority(skb, 0);
-
 	/* ethernet packet should be broadcasted */
 	if (do_bcast) {
 		primary_if = batadv_primary_if_get_selected(bat_priv);
-- 
2.47.3

