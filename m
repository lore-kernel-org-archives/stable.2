Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8D63FCB1C
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490308; cv=none; b=NRFuvTwgEfmmwqnZXdXygbKr2uBbSntdYBCnz7qaoiQWCR9KxLyneZiHe4bkfXh2wH+vydLzlI4W4IAc9pU24UjKm/OHXqrNQiiS7KLqtdd2AMoCaDDFTD3+/fiq/+W8KUDFJ8AltvaRYrfoNLP2fTfXuynGOaj/4wHTJCiqrq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490308; c=relaxed/simple;
	bh=cZLDkykEdDEfQW0oydxiZu8W7SowqJRbLVagFpHi42o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wpo9pcLJZVZngc5Hv14mhXYtApiLSOtiY1zhfw33mY+05CC/jA4iJhxv93/bFr8rjshJxH8s0zraSvmVaI94CeH7oQ1/1hz8lTOL+ARr8XWhEL973I4Wn+mNFqGsNIuUFAOwp1clGQZyUrwqcSGTNO+aSCg5iT4WvIeCTxEhQFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=pzsfNSN7; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="pzsfNSN7"
Received: by dvalin.narfation.org (Postfix) id 8D5AF20019;
	Fri, 26 Jun 2026 16:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pqWgrp9z7OlSCHr3Je4iRGUCcIjkzZ4qEMrZzikzLBk=;
	b=pzsfNSN7MYO8lJMLzfqXddYQYwF/AS6zk+0FZ8ffiLvpjn0RPnw5a3kA/BbUA/26+KFWWc
	78IhpWAz85Cg8ICOxOsVwo2EMBUjeRdy3GYVascSQufbqNFMxQqABjsfooAwfrunkPYC9J
	/wtYaogu1CgFlJI9NO6ZkoaUIAfKQLY=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.6 13/25] batman-adv: fix (m|b)cast csum after decrementing TTL
Date: Fri, 26 Jun 2026 18:11:27 +0200
Message-ID: <20260626161139.124425-14-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161139.124425-1-sven@narfation.org>
References: <20260626161139.124425-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit e728bbdf32660c8f32b8f5e8d09427a2c131ad60 upstream.

The broadcast and multicast packets can be received at the same time by the
local system and forwarded to other nodes. Both are simply decrementing the
TTL at the beginning of the receive path - independent of chosen paths
(receive/forward). But such a modification of the data conflicts with the
hw csum. This is not a problem when the packet is directly forwarded but
can cause errors in the local receive path.

Such a problem can then trigger a "hw csum failure". The receiver path must
therefore ensure that the csum is fixed for each modification of the
payload before batadv_interface_rx() is reached.

Since all batman-adv packet types with a ttl have it as u8 at offset 2, a
helper can be used for all of them. But it is only used at the moment for
batadv_bcast_packet and batadv_mcast_packet because they are the only ones
which deliver the packet locally but unconditionally modify the TTL.

Cc: stable@kernel.org
Fixes: 3f69339068f9 ("batman-adv: bcast: queue per interface, if needed")
Fixes: 07afe1ba288c ("batman-adv: mcast: implement multicast packet reception and forwarding")
[ Context, Drop change for non-existing mcast handling ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/routing.c | 55 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 747c3ff1c253b..36e9df0cca0b2 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -8,6 +8,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/build_bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/compiler.h>
 #include <linux/errno.h>
@@ -205,6 +206,58 @@ bool batadv_check_management_packet(struct sk_buff *skb,
 	return true;
 }
 
+/**
+ * batadv_skb_decrement_ttl() - decrement ttl in a batman-adv header, csum-safe
+ * @skb: the received packet with @skb->data pointing to the batman-adv header
+ *
+ * Supports the following packet types, all of which carry the TTL at offset 2:
+ *
+ * - batadv_ogm_packet
+ * - batadv_ogm2_packet
+ * - batadv_icmp_header
+ * - batadv_icmp_packet
+ * - batadv_icmp_tp_packet
+ * - batadv_icmp_packet_rr
+ * - batadv_unicast_packet
+ * - batadv_frag_packet
+ * - batadv_bcast_packet
+ * - batadv_mcast_packet
+ * - batadv_coded_packet
+ * - batadv_unicast_tvlv_packet
+ *
+ * Return: true if the packet may be forwarded (ttl decremented),
+ *  false if it must be dropped (ttl would expire)
+ */
+static bool batadv_skb_decrement_ttl(struct sk_buff *skb)
+{
+	static const size_t ttl_offset = 2;
+	u8 *ttl_pos;
+
+	BUILD_BUG_ON(offsetof(struct batadv_ogm_packet, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_ogm2_packet, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_icmp_header, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_icmp_packet, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_icmp_tp_packet, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_icmp_packet_rr, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_unicast_packet, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_frag_packet, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_bcast_packet, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_coded_packet, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_unicast_tvlv_packet, ttl) != ttl_offset);
+
+	ttl_pos = skb->data + ttl_offset;
+
+	/* would expire on this hop -> drop, leave header + csum untouched */
+	if (*ttl_pos < 2)
+		return false;
+
+	skb_postpull_rcsum(skb, ttl_pos, 1);
+	(*ttl_pos)--;
+	skb_postpush_rcsum(skb, ttl_pos, 1);
+
+	return true;
+}
+
 /**
  * batadv_recv_my_icmp_packet() - receive an icmp packet locally
  * @bat_priv: the bat priv with all the soft interface information
@@ -1204,7 +1257,7 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 
 	bcast_packet = (struct batadv_bcast_packet *)skb->data;
 
-	if (bcast_packet->ttl-- < 2)
+	if (!batadv_skb_decrement_ttl(skb))
 		goto free_skb;
 
 	orig_node = batadv_orig_hash_find(bat_priv, bcast_packet->orig);
-- 
2.47.3

