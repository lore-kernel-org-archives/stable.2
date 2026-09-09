Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD38F36F8EA
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 18:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979758; cv=none; b=oe9PUDplkKdKqS2zfka7AgIO39T9bc/QuuxLVCxxQV9KKIAAZjo/XuaY5NjDeLOKrbqENSkbWa6Owm9fswmS3sBd4uc3LwCrz4Lngq/9zr+OmB2FVdjY5P1fGWi9roUKyT0TXCs7y2oohBdmam5luDiTSuGdcwnpbadUwgmWl2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979758; c=relaxed/simple;
	bh=s0oFyhgfaKKoY3F1nOGmM2SF/wfxUjDT8xTC0A68DxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGA9vhsVAXB2477U7X0RuZMdkOcgD0KfFHp6g/fVohDDkoVuh8bilmY3ZQqqLmkmgniz/WtTEm9jrw5zPCo4gKVXQ6EIqI7NAvrTp7xuT1KSExoycdgxMhppiLvVZXFTrSreQAcgkIOhuSWbcrocgSCp6PAuemKZJXrSpkfcHq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=MR8C6vZg; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="MR8C6vZg"
Received: by dvalin.narfation.org (Postfix) id 4D786203EB;
	Wed, 09 Sep 2026 18:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788979754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KIttLBlSzPiCs2f3cDpX18HiiWT3SFH1kcr4Fzw5JrY=;
	b=MR8C6vZguMRpaHsbzA6LkUjOCdFJ3ulMRLWLkNkGGPQ4b4uX0IJtVyd/CutXt8VqKNI7ue
	FE8WWXHx3zXxdjGz9YAAvUenJ2J7FwV9pvYAb5eG5EODS72lEts9fH7MaFNmoRapWuyz51
	VLRrHM4YlE9tnGZDRBT5VyktkKHN+YM=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.18.y] batman-adv: fix TX priority extraction for BATADV_FORW_MCAST
Date: Wed,  9 Sep 2026 20:49:10 +0200
Message-ID: <20260909184910.948787-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090932-implant-idealness-8a1e@gregkh>
References: <2026090932-implant-idealness-8a1e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 7aedb59b80993c912ab45ce24386a2775150962b upstream.

batadv_mcast_forw_mode_by_count() pushs the skb->data for BATADV_FORW_MCAST
forwarding via batadv_mcast_forw_mcsend(). But the
batadv_skb_set_priority() expects the ethernet header directly before
(skb->data + offset). With the moved skb->data, just some random data would
be accessed to get the priority data.

Move the batadv_skb_set_priority() before the decision about the handling
multicast packets and potential header modifications.

Cc: stable@vger.kernel.org
Fixes: 90039133221e ("batman-adv: mcast: implement multicast packet generation")
[ Context ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/mesh-interface.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 0d598bf39bfc2..3d49fd7ef3e62 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -258,6 +258,8 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 	if (batadv_compare_eth(ethhdr->h_dest, ectp_addr))
 		goto dropped;
 
+	batadv_skb_set_priority(skb, 0);
+
 	gw_mode = atomic_read(&bat_priv->gw.mode);
 	if (is_multicast_ether_addr(ethhdr->h_dest)) {
 		/* if gw mode is off, broadcast every packet */
@@ -291,6 +293,9 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 
 send:
 		if (do_bcast && !is_broadcast_ether_addr(ethhdr->h_dest)) {
+			/* WARNING batadv_mcast_forw_mode might add more headers
+			 * in front of the skb. and might even reallocate the skb
+			 */
 			forw_mode = batadv_mcast_forw_mode(bat_priv, skb, vid,
 							   &mcast_is_routable);
 			switch (forw_mode) {
@@ -308,8 +313,6 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 		}
 	}
 
-	batadv_skb_set_priority(skb, 0);
-
 	/* ethernet packet should be broadcasted */
 	if (do_bcast) {
 		primary_if = batadv_primary_if_get_selected(bat_priv);
-- 
2.47.3

