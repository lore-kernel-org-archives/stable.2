Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460CD41D230
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817789; cv=none; b=A5kR2Pp/4OxDr2l8rrjkfl5l1ayZKYURp8aEZ3XGJpxQaJtiaLRnzWGn+HWr/qzzXcmldyBgodO0sjbH7zF3EaQ2KCcivKvC7bCPeOaKo61FvEtWMa873t9d5cTLknyYLtuXQKLrUANljT6yBbiwsQU8FLFJ+6IqHdk1ega9pjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817789; c=relaxed/simple;
	bh=id0x1+vqYq0JfWCsEJkuN9CBDGj5grW0GZvAlSld8+w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mTCd8viKx1V7Fk+vA1xcHsVIH55k9mUkV51bsPkrIWJMS37bdVg6Xp2ECYifhMyokrMFrRx5dnWqA4DMHCttON8wScGi5abJHm0NeIFWe3I+1QaNV1ZFJiOcfJL9wVmJp+3YHW5iaMCZJso9NjoRn8MhFsTkLYJ0pVnm3bA/4dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k5ozZF6+; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k5ozZF6+"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-930f5da3467so121923785a.2
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 07:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784817779; x=1785422579; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DhLyU+MmRgEs+mxbSRCBMIMJkBf7ZfuAhsP2vrhwsSA=;
        b=k5ozZF6+03+HnLLVk5+t2YYFq03j+UqHuMfjslc1EjyER8/HzMZrpSldC0C2m/NVgb
         95eK4y2fYGim7TKejo6eg29qYaei4zsDTKj0PPjWRInCEkXj2iHQrz58U1tDCXLAa2JI
         vUfe/gX46acD5wVFZfsN9GIUis9cw2iyWv/LuAZdb+wnqNnhrjGIosU1GtcjNU12PY9e
         VmvXqCbiVRDS2WGip5qq6FhZPX2OlNdVqzHgTPZ9+UQ2Qa9/EBq+y29UZ0pJYfvhxh3S
         IyRJ31P1fm2vAuxQfMiGfyACmxpWzTPqb54KJsifDhAhHIUHXFaEmk+VERgudNN0xS3v
         oDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784817779; x=1785422579;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DhLyU+MmRgEs+mxbSRCBMIMJkBf7ZfuAhsP2vrhwsSA=;
        b=PXs1aiEeHxUzmDIgjlbZ1en0h30T1DAEB1gQBWcQJnPVjTXGyQWhrOePWH184kBrri
         OVouQYqLigMNKwMEPQgc0rv8NAsGCgMaoSoSbHcwU8Gg0LhYbWNFsCVzdU6bbtrmSImv
         ElXmfta54ao49awhQKm2KGA6+waX+5eE8jKV9nYesCyXa80UpiuxUFTo1Q9F1siUU2c6
         1474ynkNsJC3WO756H7xigeaYX+RmPXnxNttE1xN+tc0zKFgvcZSgc+h8ArsAhfqQT37
         8MCuY/zjmSOygQLHR7lGiOCJMh8sZaUdS/IWB4igfGFPN6tUJbvo2kzHYLy0IXBqkauO
         A1KQ==
X-Forwarded-Encrypted: i=1; AHgh+RqcX/X0vtluNbFy6BaQV9zHJCOis6SyuPHSZz0KWkwiXfPWb5DZgA9XjGesjs7jpeucJwVyxSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1z7bb/zKU4IPnPOhHmAoGeC0mPkG2eYfJuNZXJnM9HTEBrhKl
	GC0yZDbeaDi0tG3Y+cYw+0ufZhSWfR5bzCESCf0af2M7tbfqeEk+foUUyMU2tSoI5Uo+CFvLw/J
	qS4COniza2fDa9Q==
X-Received: from qkbe19-n1.prod.google.com ([2002:a05:620a:a413:10b0:92e:555e:f52e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2951:b0:92e:de68:a288 with SMTP id af79cd13be357-931038eda19mr326623285a.48.1784817778355;
 Thu, 23 Jul 2026 07:42:58 -0700 (PDT)
Date: Thu, 23 Jul 2026 14:42:49 +0000
In-Reply-To: <20260723144249.759100-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260723144249.759100-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723144249.759100-6-edumazet@google.com>
Subject: [PATCH net 5/5] vxlan: use pskb_network_may_pull() for transmit path
 header pulls
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In vxlan_xmit(), arp_reduce(), and vxlan_mdb_entry_skb_get(), pskb_may_pull() was
being called to verify the availability of network layer headers (ARP, IPv6/ND,
IP/IPv6 MDB keys).

However, during transmit skb->data points to the MAC header, so skb_network_offset(skb)
is ETH_HLEN (14 bytes). Using pskb_may_pull(skb, len) only checks len bytes from skb->data
rather than skb_network_offset(skb) + len, which can leave part of the network header
in non-linear frags.

Replace these remaining pskb_may_pull() calls with pskb_network_may_pull() to properly
account for the MAC header offset.

Fixes: 465016142711 ("vxlan: Add ARP reduction support")
Fixes: 9e061a50a116 ("vxlan: Add IPv6 Neighbor Discovery reduction support")
Fixes: 4e94f09d84bf ("vxlan: add MDB support")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: stable@vger.kernel.org
---
 drivers/net/vxlan/vxlan_core.c | 6 +++---
 drivers/net/vxlan/vxlan_mdb.c  | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 9ccbebda860480f8378918ff360deee1c46f3f7d..eff17987c5b531ecb1e2943b6274d20c1827d299 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1850,7 +1850,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 	if (dev->flags & IFF_NOARP)
 		goto out;
 
-	if (!pskb_may_pull(skb, arp_hdr_len(dev))) {
+	if (!pskb_network_may_pull(skb, arp_hdr_len(dev))) {
 		dev_dstats_tx_dropped(dev);
 		vxlan_vnifilter_count(vxlan, vni, NULL,
 				      VXLAN_VNI_STATS_TX_DROPS, 0);
@@ -2763,8 +2763,8 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 			return arp_reduce(dev, skb, vni);
 #if IS_ENABLED(CONFIG_IPV6)
 		else if (ntohs(eth->h_proto) == ETH_P_IPV6 &&
-			 pskb_may_pull(skb, sizeof(struct ipv6hdr) +
-					    sizeof(struct nd_msg)) &&
+			 pskb_network_may_pull(skb, sizeof(struct ipv6hdr) +
+						    sizeof(struct nd_msg)) &&
 			 ipv6_hdr(skb)->nexthdr == IPPROTO_ICMPV6) {
 			struct nd_msg *m = (struct nd_msg *)(ipv6_hdr(skb) + 1);
 
diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index af7a0d7f95a57a17486a8ecc277b7bb9d921a061..9a9038ae90c18c5f0e4362b2b254b0c48dfdad0e 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -1631,7 +1631,7 @@ struct vxlan_mdb_entry *vxlan_mdb_entry_skb_get(struct vxlan_dev *vxlan,
 
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
-		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+		if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
 			return NULL;
 		group.dst.sa.sa_family = AF_INET;
 		group.dst.sin.sin_addr.s_addr = ip_hdr(skb)->daddr;
@@ -1640,7 +1640,7 @@ struct vxlan_mdb_entry *vxlan_mdb_entry_skb_get(struct vxlan_dev *vxlan,
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case htons(ETH_P_IPV6):
-		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
+		if (!pskb_network_may_pull(skb, sizeof(struct ipv6hdr)))
 			return NULL;
 		group.dst.sa.sa_family = AF_INET6;
 		group.dst.sin6.sin6_addr = ipv6_hdr(skb)->daddr;
-- 
2.55.0.229.g6434b31f56-goog

