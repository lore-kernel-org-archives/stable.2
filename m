Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FB146EC98;
	Fri, 21 Aug 2026 09:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305721; cv=none; b=oTHMZ17AqFomKRoyLJ+ZN9lqvCuOfjKCQu8EjcDx503ozqCIgDBQJNC+mF1H3ZiWwc5JvLE9AuL/3BzCuThd7HBHIdNxaPPc4wwGRi/5u+pJIDaCmWTWhBpiewsOgI/LW2YWhS1UeRRXZmNKh+i6QyBcsFoFDU894Zvl6cHhKks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305721; c=relaxed/simple;
	bh=qBou/9q/4P+LXDnBKBPThOj+BbOgX4ntufr6J9pBuYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mRRBcDf9apRReuNvJbfZxzBUPFgAFIkGW9Bcft7IIyEIyz9OrEOHgvtXXAvtwkEKcwhjpayXW8oa8gIdiV8ZmNpqtqPh9C7LxiGTmipXIFHYhEy7Fhwyu/tM0QXiPKcQHjuKiB4+fMOx5PNap5AjpYXVJ4w0SY317r4SZqXpv/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=nTwTEwuF; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="nTwTEwuF"
Received: from kero.packetmixer.de (p200300C59714FCd8eC8C87C354003fED.dip0.t-ipconnect.de [IPv6:2003:c5:9714:fcd8:ec8c:87c3:5400:3fed])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 09CB6FA129;
	Fri, 21 Aug 2026 11:48:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1787305701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vqgv0Tes2Yz0v/vPnY3yHC0lKow8M7VXDU1MEf8roLU=;
	b=nTwTEwuFlkPxWdJFvO204NpCTDo6XwnyFJ+jMDd9elijRgulWAa5UK/JGx50oxW7MUeVMc
	Yo9ERGhwb+UKOF71f5IcJkNAiBNBcvD/lQmfbtJcDPrp7QjzrQGKD5JJfuar7cUfidEDh2
	ClhZEYb8FDPBoLSjVlhkzYyPyGpgC/X9AKnyR8TwKJFUNKcXH1TCWsiygpBrPaNGNhFUCa
	0mGZrryVCagTaEdP6b4J4vgUYr5YfcLsbf2VKsmnO1TOGA++nC9XP2bqZq76a0nlA7Ec1L
	cQrp2H9/Q09nSP+t8Alvof8arUmUwv9QjdtZTfPelCd4qk/FRlYfgsQV43oy/g==
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
Subject: [PATCH net 5/9] batman-adv: dat: atomically update mac addresses
Date: Fri, 21 Aug 2026 11:48:09 +0200
Message-ID: <20260821094813.201800-6-sw@simonwunderlich.de>
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

When a MAC address is updated in batadv_dat_entry_add(), it is done using a
simple copy function. A parallel reader might only see parts of this
update. In worst case, the reader is transporting the half updated MAC
address over the network or is creating an ARP response using it -
poisoning the ARP cache.

atomic64_t can be used to store the 48 bit of a mac address. A reader will
then either see the old mac address or the new one - never a mixture of
both.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 2f1dfbe18507 ("batman-adv: Distributed ARP Table - implement local storage")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 58 +++++++++++++++++---------
 net/batman-adv/types.h                 |  2 +-
 2 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 76fd23db926c7..011cfdc47fab4 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -444,18 +444,19 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
 static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 				 u8 *mac_addr, unsigned short vid)
 {
+	u64 u64_mac = ether_addr_to_u64(mac_addr);
 	struct batadv_dat_entry *dat_entry;
 	int hash_added;
 
 	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip, vid);
 	/* if this entry is already known, just update it */
 	if (dat_entry) {
-		if (!batadv_compare_eth(dat_entry->mac_addr, mac_addr))
-			ether_addr_copy(dat_entry->mac_addr, mac_addr);
+		atomic64_set(&dat_entry->mac_addr, u64_mac);
+
 		dat_entry->last_update = jiffies;
 		batadv_dbg(BATADV_DBG_DAT, bat_priv,
 			   "Entry updated: %pI4 %pM (vid: %d)\n",
-			   &dat_entry->ip, dat_entry->mac_addr,
+			   &dat_entry->ip, mac_addr,
 			   batadv_print_vid(vid));
 		goto out;
 	}
@@ -466,7 +467,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 
 	dat_entry->ip = ip;
 	dat_entry->vid = vid;
-	ether_addr_copy(dat_entry->mac_addr, mac_addr);
+	atomic64_set(&dat_entry->mac_addr, u64_mac);
 	dat_entry->last_update = jiffies;
 	kref_init(&dat_entry->refcount);
 
@@ -482,7 +483,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	}
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv, "New entry added: %pI4 %pM (vid: %d)\n",
-		   &dat_entry->ip, dat_entry->mac_addr, batadv_print_vid(vid));
+		   &dat_entry->ip, mac_addr, batadv_print_vid(vid));
 
 out:
 	batadv_dat_entry_put(dat_entry);
@@ -939,6 +940,8 @@ batadv_dat_cache_dump_entry(struct sk_buff *msg, u32 portid,
 			    struct netlink_callback *cb,
 			    struct batadv_dat_entry *dat_entry)
 {
+	u8 mac[ETH_ALEN];
+	u64 u64_mac;
 	int msecs;
 	void *hdr;
 
@@ -951,11 +954,12 @@ batadv_dat_cache_dump_entry(struct sk_buff *msg, u32 portid,
 	genl_dump_check_consistent(cb, hdr);
 
 	msecs = jiffies_to_msecs(jiffies - dat_entry->last_update);
+	u64_mac = atomic64_read(&dat_entry->mac_addr);
+	u64_to_ether_addr(u64_mac, mac);
 
 	if (nla_put_in_addr(msg, BATADV_ATTR_DAT_CACHE_IP4ADDRESS,
 			    dat_entry->ip) ||
-	    nla_put(msg, BATADV_ATTR_DAT_CACHE_HWADDRESS, ETH_ALEN,
-		    dat_entry->mac_addr) ||
+	    nla_put(msg, BATADV_ATTR_DAT_CACHE_HWADDRESS, ETH_ALEN, mac) ||
 	    nla_put_u16(msg, BATADV_ATTR_DAT_CACHE_VID, dat_entry->vid) ||
 	    nla_put_u32(msg, BATADV_ATTR_LAST_SEEN_MSECS, msecs)) {
 		genlmsg_cancel(msg, hdr);
@@ -1235,10 +1239,12 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 	struct sk_buff *skb_new;
 	unsigned short vid;
 	bool ret = false;
+	u8 mac[ETH_ALEN];
 	int hdr_size = 0;
 	__be32 ip_dst;
 	__be32 ip_src;
 	u16 type = 0;
+	u64 u64_mac;
 	u8 *hw_src;
 
 	if (!READ_ONCE(bat_priv->distributed_arp_table))
@@ -1267,6 +1273,9 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 
 	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
 	if (dat_entry) {
+		u64_mac = atomic64_read(&dat_entry->mac_addr);
+		u64_to_ether_addr(u64_mac, mac);
+
 		/* If the ARP request is destined for a local client the local
 		 * client will answer itself. DAT would only generate a
 		 * duplicate packet.
@@ -1275,7 +1284,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 		 * additional DAT answer may trigger kernel warnings about
 		 * a packet coming from the wrong port.
 		 */
-		if (batadv_is_my_client(bat_priv, dat_entry->mac_addr, vid)) {
+		if (batadv_is_my_client(bat_priv, mac, vid)) {
 			ret = true;
 			goto out;
 		}
@@ -1285,18 +1294,16 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 		 * the backbone gws belonging to our backbone has claimed the
 		 * destination.
 		 */
-		if (!batadv_bla_check_claim(bat_priv,
-					    dat_entry->mac_addr, vid)) {
+		if (!batadv_bla_check_claim(bat_priv, mac, vid)) {
 			batadv_dbg(BATADV_DBG_DAT, bat_priv,
 				   "Device %pM claimed by another backbone gw. Don't send ARP reply!",
-				   dat_entry->mac_addr);
+				   mac);
 			ret = true;
 			goto out;
 		}
 
 		skb_new = batadv_dat_arp_create_reply(bat_priv, ip_dst, ip_src,
-						      dat_entry->mac_addr,
-						      hw_src, vid);
+						      mac, hw_src, vid);
 		if (!skb_new)
 			goto out;
 
@@ -1340,8 +1347,10 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	struct sk_buff *skb_new;
 	unsigned short vid;
 	bool ret = false;
+	u8 mac[ETH_ALEN];
 	__be32 ip_src;
 	__be32 ip_dst;
+	u64 u64_mac;
 	u8 *hw_src;
 	u16 type;
 	int err;
@@ -1371,8 +1380,11 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	if (!dat_entry)
 		goto out;
 
+	u64_mac = atomic64_read(&dat_entry->mac_addr);
+	u64_to_ether_addr(u64_mac, mac);
+
 	skb_new = batadv_dat_arp_create_reply(bat_priv, ip_dst, ip_src,
-					      dat_entry->mac_addr, hw_src, vid);
+					      mac, hw_src, vid);
 	if (!skb_new)
 		goto out;
 
@@ -1464,8 +1476,10 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 	struct batadv_dat_entry *dat_entry = NULL;
 	bool dropped = false;
 	unsigned short vid;
+	u8 mac[ETH_ALEN];
 	__be32 ip_src;
 	__be32 ip_dst;
+	u64 u64_mac;
 	u8 *hw_src;
 	u8 *hw_dst;
 	u16 type;
@@ -1497,11 +1511,17 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 	 * this frame would lead to doubled receive of an ARP reply.
 	 */
 	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_src, vid);
-	if (dat_entry && batadv_compare_eth(hw_src, dat_entry->mac_addr)) {
-		batadv_dbg(BATADV_DBG_DAT, bat_priv, "Doubled ARP reply removed: ARP MSG = [src: %pM-%pI4 dst: %pM-%pI4]; dat_entry: %pM-%pI4\n",
-			   hw_src, &ip_src, hw_dst, &ip_dst,
-			   dat_entry->mac_addr,	&dat_entry->ip);
-		dropped = true;
+	if (dat_entry) {
+		u64_mac = atomic64_read(&dat_entry->mac_addr);
+		u64_to_ether_addr(u64_mac, mac);
+
+		if (batadv_compare_eth(hw_src, mac)) {
+			batadv_dbg(BATADV_DBG_DAT, bat_priv,
+				   "Doubled ARP reply removed: ARP MSG = [src: %pM-%pI4 dst: %pM-%pI4]; dat_entry: %pM-%pI4\n",
+				   hw_src, &ip_src, hw_dst, &ip_dst,
+				   mac, &dat_entry->ip);
+			dropped = true;
+		}
 	}
 
 	/* Update our internal cache with both the IP addresses the node got
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 42b6315735123..9bdc5a3e799e2 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2176,7 +2176,7 @@ struct batadv_dat_entry {
 	__be32 ip;
 
 	/** @mac_addr: the MAC address associated to the stored IPv4 */
-	u8 mac_addr[ETH_ALEN];
+	atomic64_t mac_addr;
 
 	/** @vid: the vlan ID associated to this entry */
 	unsigned short vid;
-- 
2.47.3

