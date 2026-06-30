Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5419D368D60;
	Tue, 30 Jun 2026 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827084; cv=none; b=OZMvidtN364mzTeWJEFcojT+YF6z3+u0cTynZfEBcU7R/fuxs7ljVeKOwBJWvlyK7GO6U0OE/X4+HCMlEPsJvoyj6fQKcYJn6fmvV6ai7yTetALVwzZ1pJavtqFTmyV+JXe632BXBG3bvqHOZlz7BlaLRI0RyTGR53YfArnKkPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827084; c=relaxed/simple;
	bh=5El3Fpw6SdnsYd+rTnstSfn7EKz53ikBSpU2BVqf9c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEvmjEf8ahw2b8FPizwpoUt4uasDc3c1DLrc754t5FqTsXOwuoJLS3KEPDiC9c04F5ZsDDZaWWsOrMvTTLcxUHukkUribd0dxZb0ClwctyxtozAnpWee02FDgJIs8/oJgEEHfRkxTTRjrn9YcO3LJqf50DmP1bm8BS5JOk6Fwfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=g+0RlvV8; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="g+0RlvV8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782827076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fb4AHoI005tpjwAxxp5lWW56BRhiNymjwDtZfAu8jEY=;
	b=g+0RlvV8yBF2crQjVDHmRqFFschJXsFVx44giWbgrqsDnmShE3tEpkEOsFDukpYXml6HqP
	i7i9dYvGONYp7EYBWrfdZOcMmYHJknExhD3WMLO63XjTbG8tywc0YaVrDlmRSJXWeOz+Wy
	J4YaOfbfOYWVIcQZNw8sTHHaBfOlQz9uw3YPrGVAWH5Ae8a+9ijvkZNA32O9mitBPjYNgQ
	LNl4rRTimaVZS8eVIP4uuDSNgEY7ocetUmAgbhgcbVnsLcT23uaBet7xpJJftVtUK2SrXD
	hWKQTXHsIn7u053j/Fy5NirQAc6SOcy23cZARG8pnBYBlYHg8HSujFRKd6XbFw==
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
Subject: [PATCH net 6/6] batman-adv: dat: ensure accessible eth_hdr proto field
Date: Tue, 30 Jun 2026 15:44:30 +0200
Message-ID: <20260630134430.85786-7-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630134430.85786-1-sw@simonwunderlich.de>
References: <20260630134430.85786-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

When batadv_get_vid() accesses the proto field of the ethernet header, it
is not checking if the data itself is accessible. The caller is responsible
for it. But in contrast to other call sites, batadv_dat_get_vid() and its
caller didn't make sure this is true. This could have caused an
out-of-bounds access.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: be1db4f6615b ("batman-adv: make the Distributed ARP Table vlan aware")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 23 +++++++++++++++++++++++
 net/batman-adv/main.c                  |  3 +++
 2 files changed, 26 insertions(+)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index ead02c9e08484..c40c9e02391be 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1066,6 +1066,9 @@ static u16 batadv_arp_get_type(struct batadv_priv *bat_priv,
  * @skb: the buffer containing the packet to extract the VID from
  * @hdr_size: the size of the batman-adv header encapsulating the packet
  *
+ * The caller must ensure that at least @hdr_size + ETH_HLEN bytes are
+ * accessible after skb->data.
+ *
  * Return: If the packet embedded in the skb is vlan tagged this function
  * returns the VID with the BATADV_VLAN_HAS_TAG flag. Otherwise BATADV_NO_FLAGS
  * is returned.
@@ -1148,6 +1151,10 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 	if (!READ_ONCE(bat_priv->distributed_arp_table))
 		goto out;
 
+	/* first, find out the vid. */
+	if (!pskb_may_pull(skb, hdr_size + ETH_HLEN))
+		goto out;
+
 	vid = batadv_dat_get_vid(skb, &hdr_size);
 
 	type = batadv_arp_get_type(bat_priv, skb, hdr_size);
@@ -1243,6 +1250,10 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	if (!READ_ONCE(bat_priv->distributed_arp_table))
 		goto out;
 
+	/* first, find out the vid. */
+	if (!pskb_may_pull(skb, hdr_size + ETH_HLEN))
+		goto out;
+
 	vid = batadv_dat_get_vid(skb, &hdr_size);
 
 	type = batadv_arp_get_type(bat_priv, skb, hdr_size);
@@ -1305,6 +1316,10 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 	if (!READ_ONCE(bat_priv->distributed_arp_table))
 		return;
 
+	/* first, find out the vid. */
+	if (!pskb_may_pull(skb, hdr_size + ETH_HLEN))
+		return;
+
 	vid = batadv_dat_get_vid(skb, &hdr_size);
 
 	type = batadv_arp_get_type(bat_priv, skb, hdr_size);
@@ -1353,6 +1368,10 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 	if (!READ_ONCE(bat_priv->distributed_arp_table))
 		goto out;
 
+	/* first, find out the vid. */
+	if (!pskb_may_pull(skb, hdr_size + ETH_HLEN))
+		goto out;
+
 	vid = batadv_dat_get_vid(skb, &hdr_size);
 
 	type = batadv_arp_get_type(bat_priv, skb, hdr_size);
@@ -1807,6 +1826,10 @@ bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
 	if (batadv_forw_packet_is_rebroadcast(forw_packet))
 		goto out;
 
+	/* first, find out the vid. */
+	if (!pskb_may_pull(forw_packet->skb, hdr_size + ETH_HLEN))
+		goto out;
+
 	vid = batadv_dat_get_vid(forw_packet->skb, &hdr_size);
 
 	type = batadv_arp_get_type(bat_priv, forw_packet->skb, hdr_size);
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 3c4572284b532..4d3807a645b78 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -580,6 +580,9 @@ void batadv_recv_handler_unregister(u8 packet_type)
  * @skb: the buffer containing the packet
  * @header_len: length of the batman header preceding the ethernet header
  *
+ * The caller must ensure that at least @header_len + ETH_HLEN bytes are
+ * accessible after skb->data.
+ *
  * Return: VID with the BATADV_VLAN_HAS_TAG flag when the packet embedded in the
  * skb is vlan tagged. Otherwise BATADV_NO_FLAGS.
  */
-- 
2.47.3

