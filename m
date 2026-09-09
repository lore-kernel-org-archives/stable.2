Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D892739DBD0
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981420; cv=none; b=VVFyvCUBmsi9QqJjiNz965a4N6E/2yPT8OFNW2sJdw8uJacJsrNR+o3YRqRfb4Xbanqpu6R/ypZdENsJ3Pi0Bvw9yI5NgB45Wed6LZMP6aKGo98+KTY4jXN8mRYqEaVBn1Fcmh2z4+/pqpvxQRZPVOax7ADfCqs7rPqJyDFHQhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981420; c=relaxed/simple;
	bh=HcyzVnfOO/4/298uMSVDLIB2g3xt11+zwSUpyLsHgOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIIB3px9Nx5v1oL969ww+hLfyNhpi9zfrMSPLdybeRa9TymrFWQkfTFAMs0xH9IILMyaDNcBYgGdezzsPAk0xurckEvBwA9kusc3eUHekdi987UbOBfdcutXI7qk2SG9C1772NcsWtDmUfwmcApoFc+3rb5rPcBmP95OPocH7x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=gimguyZD; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="gimguyZD"
Received: by dvalin.narfation.org (Postfix) id D3128200A3;
	Wed, 09 Sep 2026 19:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788981416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aUJccs1YOBQKykxsx+rpfvaTAGZTmTK7ntiI1NJ/uh0=;
	b=gimguyZD/KLayVbrFOXOft3AfeFmLQJsaSAzHndvMa4n5Km2QePmmKcBo7YqoF5k0RrMsB
	0DagObATs+e0i6my7e4fbTr1l8D9D2SOqDp5RdwJZ7Q/Egn0MpRkMBjJno74AinB/Gl+PF
	RmKxFX/vey8dQZm1PDbsF707xUULvM8=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 5.10.y] batman-adv: dat: atomically update mac addresses
Date: Wed,  9 Sep 2026 21:16:52 +0200
Message-ID: <20260909191652.1174815-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090934-jarring-washstand-3211@gregkh>
References: <2026090934-jarring-washstand-3211@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit e6de568d3eda3e3c01c868fabd7a9535d5ee4a73 upstream.

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
[ Context ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/distributed-arp-table.c | 58 +++++++++++++++++---------
 net/batman-adv/types.h                 |  2 +-
 2 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 5b63048fbfbcd..49168027ffd15 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -373,18 +373,19 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
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
@@ -395,7 +396,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 
 	dat_entry->ip = ip;
 	dat_entry->vid = vid;
-	ether_addr_copy(dat_entry->mac_addr, mac_addr);
+	atomic64_set(&dat_entry->mac_addr, u64_mac);
 	dat_entry->last_update = jiffies;
 	kref_init(&dat_entry->refcount);
 
@@ -411,7 +412,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	}
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv, "New entry added: %pI4 %pM (vid: %d)\n",
-		   &dat_entry->ip, dat_entry->mac_addr, batadv_print_vid(vid));
+		   &dat_entry->ip, mac_addr, batadv_print_vid(vid));
 
 out:
 	if (dat_entry)
@@ -923,6 +924,8 @@ batadv_dat_cache_dump_entry(struct sk_buff *msg, u32 portid,
 			    struct netlink_callback *cb,
 			    struct batadv_dat_entry *dat_entry)
 {
+	u8 mac[ETH_ALEN];
+	u64 u64_mac;
 	int msecs;
 	void *hdr;
 
@@ -935,11 +938,12 @@ batadv_dat_cache_dump_entry(struct sk_buff *msg, u32 portid,
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
@@ -1216,6 +1220,8 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 	struct net_device *soft_iface = bat_priv->soft_iface;
 	int hdr_size = 0;
 	unsigned short vid;
+	u8 mac[ETH_ALEN];
+	u64 u64_mac;
 
 	if (!atomic_read(&bat_priv->distributed_arp_table))
 		goto out;
@@ -1243,6 +1249,9 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 
 	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
 	if (dat_entry) {
+		u64_mac = atomic64_read(&dat_entry->mac_addr);
+		u64_to_ether_addr(u64_mac, mac);
+
 		/* If the ARP request is destined for a local client the local
 		 * client will answer itself. DAT would only generate a
 		 * duplicate packet.
@@ -1251,7 +1260,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 		 * additional DAT answer may trigger kernel warnings about
 		 * a packet coming from the wrong port.
 		 */
-		if (batadv_is_my_client(bat_priv, dat_entry->mac_addr, vid)) {
+		if (batadv_is_my_client(bat_priv, mac, vid)) {
 			ret = true;
 			goto out;
 		}
@@ -1261,18 +1270,16 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
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
 
@@ -1315,6 +1322,8 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	struct batadv_dat_entry *dat_entry = NULL;
 	bool ret = false;
 	unsigned short vid;
+	u8 mac[ETH_ALEN];
+	u64 u64_mac;
 	int err;
 
 	if (!atomic_read(&bat_priv->distributed_arp_table))
@@ -1342,8 +1351,11 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
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
 
@@ -1435,6 +1447,8 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 	u8 *hw_src, *hw_dst;
 	bool dropped = false;
 	unsigned short vid;
+	u8 mac[ETH_ALEN];
+	u64 u64_mac;
 
 	if (!atomic_read(&bat_priv->distributed_arp_table))
 		goto out;
@@ -1463,11 +1477,17 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
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
index 790f62abfe030..49cef1a85639a 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2387,7 +2387,7 @@ struct batadv_dat_entry {
 	__be32 ip;
 
 	/** @mac_addr: the MAC address associated to the stored IPv4 */
-	u8 mac_addr[ETH_ALEN];
+	atomic64_t mac_addr;
 
 	/** @vid: the vlan ID associated to this entry */
 	unsigned short vid;
-- 
2.47.3

