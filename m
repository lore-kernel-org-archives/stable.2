Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FC7403AFC
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490375; cv=none; b=E9EJJaW2UZYz/4jJqTPineI6juYicExgnin33JSaDa9YRv0HaChk/oyI8KqruC6sxeMXuQdAGqf/sxa76EBF5s5XZKrscbYEcmo7tDrYjklHOrnz545nVcZgSp0pHO0e938F4xEeLR+nPdP7sATY8WBKDaAeFuK5OXebhGASUZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490375; c=relaxed/simple;
	bh=7vflIcHjiDWXKYTF85/GMhcNUEV2bcI2G4OrttJBj1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmYaG17dRgWKabumdITIqdzmhpMTet7e6LSM7TGgK6iADxPPKAQ6JmKWfzuEmgfhTtZyo0PkiYpIy4WWIrr1qQiu+57Jlkmrtb1gbNLsY02tUMhzKG8mgQbhxeiskQUhDDPI7/b6qhsWhXbrQ1F8CFGtoRkzOCFXStjbLQ9MIgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=xf/tpPRw; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="xf/tpPRw"
Received: by dvalin.narfation.org (Postfix) id 6A39C203F3;
	Fri, 26 Jun 2026 16:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EC9j0YnPX/B/mxOQkKNj6XqeJATnpLfcGMj7nbGW7r8=;
	b=xf/tpPRwmNsEy1UagJZsX6LqJGGDyZVqbtUM2tu+EqSGUbOC32Isq9o5izUs1tU6vigqX7
	YZwtKsY0a1OqXTwptd0CXqCWhOUTEEurKoPXpzZV0imKHYBrXFD+6TA2OgEcZFXOkl6eBR
	gCma8yirBbA/gaNQHtLQz6of/o66IS4=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 7.1 15/26] batman-adv: frag: ensure fragment is writable before modifying TTL
Date: Fri, 26 Jun 2026 18:12:30 +0200
Message-ID: <20260626161241.124988-16-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161241.124988-1-sven@narfation.org>
References: <20260626161241.124988-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit b7293c6e8c15b2db77809b25cf8389e35331b27a upstream.

Before batman-adv is allowed to write to an skb, it either has to have its
own copy of the skb or use skb_cow() to ensure that the data part is not
shared. But batadv_frag_skb_fwd() modifies the TTL even when it is shared.

Adding a skb_cow() right before this operation avoids this and can at the
same time prepare it for the modifications required to forward the
fragment.

Cc: stable@kernel.org
Fixes: 610bfc6bc99b ("batman-adv: Receive fragmented packets and merge")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/fragmentation.c | 15 ++++++++++++++-
 net/batman-adv/fragmentation.h |  3 ++-
 net/batman-adv/routing.c       |  3 +--
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index e9553db423491..5c2a7629e4e09 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -384,6 +384,8 @@ bool batadv_frag_skb_buffer(struct sk_buff **skb,
  * @skb: skb to forward
  * @recv_if: interface that the skb is received on
  * @orig_node_src: originator that the skb is received from
+ * @rx_result: set to NET_RX_SUCCESS when the fragment was forwarded and
+ *  NET_RX_DROP when it was dropped; only valid when true is returned
  *
  * Look up the next-hop of the fragments payload and check if the merged packet
  * will exceed the MTU towards the next-hop. If so, the fragment is forwarded
@@ -393,7 +395,8 @@ bool batadv_frag_skb_buffer(struct sk_buff **skb,
  */
 bool batadv_frag_skb_fwd(struct sk_buff *skb,
 			 struct batadv_hard_iface *recv_if,
-			 struct batadv_orig_node *orig_node_src)
+			 struct batadv_orig_node *orig_node_src,
+			 int *rx_result)
 {
 	struct batadv_priv *bat_priv = netdev_priv(recv_if->mesh_iface);
 	struct batadv_neigh_node *neigh_node = NULL;
@@ -412,12 +415,22 @@ bool batadv_frag_skb_fwd(struct sk_buff *skb,
 	 */
 	total_size = ntohs(packet->total_size);
 	if (total_size > neigh_node->if_incoming->net_dev->mtu) {
+		if (skb_cow(skb, ETH_HLEN) < 0) {
+			kfree_skb(skb);
+			*rx_result = NET_RX_DROP;
+			ret = true;
+			goto out;
+		}
+
+		packet = (struct batadv_frag_packet *)skb->data;
+
 		batadv_inc_counter(bat_priv, BATADV_CNT_FRAG_FWD);
 		batadv_add_counter(bat_priv, BATADV_CNT_FRAG_FWD_BYTES,
 				   skb->len + ETH_HLEN);
 
 		packet->ttl--;
 		batadv_send_unicast_skb(skb, neigh_node);
+		*rx_result = NET_RX_SUCCESS;
 		ret = true;
 	}
 
diff --git a/net/batman-adv/fragmentation.h b/net/batman-adv/fragmentation.h
index dbf0871f87030..51e281027ab63 100644
--- a/net/batman-adv/fragmentation.h
+++ b/net/batman-adv/fragmentation.h
@@ -19,7 +19,8 @@ void batadv_frag_purge_orig(struct batadv_orig_node *orig,
 			    bool (*check_cb)(struct batadv_frag_table_entry *));
 bool batadv_frag_skb_fwd(struct sk_buff *skb,
 			 struct batadv_hard_iface *recv_if,
-			 struct batadv_orig_node *orig_node_src);
+			 struct batadv_orig_node *orig_node_src,
+			 int *rx_result);
 bool batadv_frag_skb_buffer(struct sk_buff **skb,
 			    struct batadv_orig_node *orig_node);
 int batadv_frag_send_packet(struct sk_buff *skb,
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index cdcea90db6123..4483f8d9c7583 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1168,10 +1168,9 @@ int batadv_recv_frag_packet(struct sk_buff *skb,
 
 	/* Route the fragment if it is not for us and too big to be merged. */
 	if (!batadv_is_my_mac(bat_priv, frag_packet->dest) &&
-	    batadv_frag_skb_fwd(skb, recv_if, orig_node_src)) {
+	    batadv_frag_skb_fwd(skb, recv_if, orig_node_src, &ret)) {
 		/* skb was consumed */
 		skb = NULL;
-		ret = NET_RX_SUCCESS;
 		goto put_orig_node;
 	}
 
-- 
2.47.3

