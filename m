Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804F846D570;
	Fri, 21 Aug 2026 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305719; cv=none; b=acxx8LzlJ+LZswFqyMku5ZKEQAtYZdR3FoehiqamGnyTXHpzh9BPZerf0kyzG0yaYL0DxTKCZfPdqcWII40d9pOafhHUcG71O9OVbWieWhJVrFJw8nzn0/OeK9eL86xMicwmv5xUoqz9UXL6siK2JrlYB4uYUPzzKzWsliOp9Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305719; c=relaxed/simple;
	bh=xSMbntVD8LbZCBD97cs0pkumgTzeXPSYvoPYfhN456E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6zrk0SrwYTJtjWAkASPX9lSdRJ6IB69fi1NHf+jBPpalnMQLZRa4sTM79jB6grSolbVyUVoyqjdSLVResVBJ+EgIcgHo/wo4lyIpM0W8EWBLo2YCjnH3fjQdKJg7RNnSnC/SsHQmYWxenydTNlzGCu/kZ/enpm03U4off7Tu/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=VIgEtKAb; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="VIgEtKAb"
Received: from kero.packetmixer.de (p200300c59714FcD8EC8C87C354003fed.dip0.t-ipconnect.de [IPv6:2003:c5:9714:fcd8:ec8c:87c3:5400:3fed])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id C96F7FA154;
	Fri, 21 Aug 2026 11:48:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1787305702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZuErQ3cxKr3SogMZj3GKBsaBSwY81i74yvWwVU+ZPU=;
	b=VIgEtKAbBkzOI4pZ+xVR2XS1EQRajR5/zbHZzHf/AX1gTdOh0YooS6+gvUAbPKIMTzKNCD
	drimB/Y6QKubO+ULjqv4oEwV0zPmyhGtGV2Y4f9NI+k8xBpDklDpN2p17t0TK58OenwguF
	fEqfhQfyOuGNmVo7j/s0JE7BNm3i+OTQRmQ2PFOwLue+nU/jQZcL8fLp2yYWT/WhEROxuc
	sZ92/dcHk6dEBm70yNscKiYud9ujkGeL9Va28/OybwmgWG+dHecgB30iGTIC2i40S+25IZ
	3A+TGEHPzH6pSdx5XlL/Ngssx/+4DoY55qOqjTabcvmElHByJneG5JBTvFc1ag==
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
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 8/9] batman-adv: mcast: linearize skbuff for packet generation
Date: Fri, 21 Aug 2026 11:48:12 +0200
Message-ID: <20260821094813.201800-9-sw@simonwunderlich.de>
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

batadv_mcast_forw_packet() and batadv_mcast_forw_scrape() is not only
called (indirectly) by the unsharing+linearizing batadv_recv_mcast_packet()
handler. When it is called (indirectly) by batadv_mcast_forw_mcsend() then
it will be unshared but not linearized. The SKB_LINEAR_ASSERT() can
therefore cause a fatal BUG().

The linearization should happen during the expansion of the head because
the scrape function can be hit already during the initial
batadv_mcast_forw_mode() selection code:

* batadv_interface_tx
* batadv_mcast_forw_mode
* batadv_mcast_forw_mode_by_count()
* batadv_mcast_forw_push()
  -> calls batadv_mcast_forw_expand_head() before everything else
* batadv_mcast_forw_push_tvlvs()
* batadv_mcast_forw_push_dests()
* batadv_mcast_forw_push_adjust_padding()
* batadv_mcast_forw_scrape()

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 90039133221e ("batman-adv: mcast: implement multicast packet generation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/multicast_forw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index 3927d28dcbb89..ac97cd8b81dc9 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -1108,6 +1108,10 @@ static int batadv_mcast_forw_expand_head(struct batadv_priv *bat_priv,
 	if (skb_cow(skb, hdr_size) < 0)
 		return -ENOMEM;
 
+	/* batadv_mcast_forw_scrape() + batadv_mcast_forw_packet() require linearized skb */
+	if (skb_linearize(skb) < 0)
+		return -ENOMEM;
+
 	return 0;
 }
 
-- 
2.47.3

