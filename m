Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BBD435504
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 23:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787353888; cv=none; b=ngmTLBLBrWONsrLev55LGEgylpx2ACw+D73T2x8mCfiyKIs7PUl4gJ96mUrHolG7DapWezuD71UMvsx2c0XAY8OwOQn9Ms9EBJvKzGjhevbfio3S3Qp78QcZsFtTeKBRn5zKVEnasuQLnm9GCUNaLksq9xXBW0w3lz2+clkRy6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787353888; c=relaxed/simple;
	bh=6qe1iAGAsLrYt2MjeIu0rGq9Jwn+VYrMKSyy84PHn7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qyXlmVWkzpzv7q4rQAAwjgllgVC8GHqXNqz1JKoqxihp8ieHWbuHhwrKYuVVIfCAE+Dcg/uEFUQTAAQORGGK/HQ6DxPQUJbGSs60kGTDDA+80fYrFhwi+NXhnKAX3n2NEIf64b96EDV5Ow7B2RJZ2RcpsFXjHbSDHmG2Og0FxNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBeF0OqT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBeF0OqT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496BA1F00A3D;
	Fri, 21 Aug 2026 23:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787353885;
	bh=dwXc0V/saIdyS/qoEzPFV/AKuQrwLIXRr+5xzdY2BQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OBeF0OqTBkp8PuxZTujhp8SCYRf1CDfegW+0WOOiovN8U4du+k8mAUCSe1RfuGbsp
	 M9DHb5L6byRj1JXC7BFZ9uTo1OlaaI8OGuAP2MW3w8kTht3Bjg2ALSLwj5FKQYAIV0
	 nqzske4kNgRViStk4SOyTw3U5vGjKH0dQDhUqthecy9ZzD29uyTnvinVnMmdkmE5mI
	 ThYmp96KVD5mEspuJKL6PRiqr6OxM93CG+8igpi45ljrUiGtRFE9Gf5/Mad2SQdE2P
	 bSx61soNBh5ghbtStCyOeFazhzrBrFedOz+x828odrdubHeRZRB2LpRwdkxnDQz1lp
	 Jhtij64zVwPLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qihang Tang <q.h.hack.winter@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] packet: use consistent hard_header_len in non-ring send paths
Date: Fri, 21 Aug 2026 19:11:24 -0400
Message-ID: <20260821231124.123510-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081702-flagstone-product-2e6e@gregkh>
References: <2026081702-flagstone-product-2e6e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qihang Tang <q.h.hack.winter@gmail.com>

[ Upstream commit 03390aa32e669cc4ecd7d34108e2e1afc13d689d ]

packet_snd() reads dev->hard_header_len multiple times while allocating
and constructing an skb. Device reconfiguration can change this value
concurrently, for example through bonding device type changes.

For SOCK_RAW, packet_snd() can save a larger value in reserve and later
allocate headroom using a smaller value. Moving skb->data back by reserve
then places it before skb->head, and the following copy from userspace can
attempt an out-of-bounds write.

packet_sendmsg_spkt() has the same issue because it calculates its
reservation and header offset from separate reads before dropping the RCU
read lock to allocate the skb.

Add LL_RESERVED_SPACE_EX() for callers that already saved a header length.
Read hard_header_len once in packet_snd() and use it for allocation and
construction. In packet_sendmsg_spkt(), preserve the allocation-time value
through the device lookup retry.

The separate SOCK_DGRAM consistency problem between hard_header_len and
header_ops->create is not addressed here.

Fixes: b84bbaf7a6c8 ("packet: in packet_snd start writing at link layer allocation")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang Tang <q.h.hack.winter@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20260805125729.19220-3-q.h.hack.winter@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Kept 5.15's `bool has_vnet_hdr` / 3-arg `packet_snd_vnet_parse()` spelling instead of the upstream `vnet_hdr_sz` form when applying the `hard_header_len` changes. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/netdevice.h |  6 ++++--
 net/packet/af_packet.c    | 26 ++++++++++++++++----------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b847c45c45c82..d3a2234c736c3 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -269,9 +269,11 @@ struct hh_cache {
  * We could use other alignment values, but we must maintain the
  * relationship HH alignment <= LL alignment.
  */
-#define LL_RESERVED_SPACE(dev) \
-	((((dev)->hard_header_len + READ_ONCE((dev)->needed_headroom)) \
+#define LL_RESERVED_SPACE_EX(dev, hlen) \
+	((((hlen) + READ_ONCE((dev)->needed_headroom)) \
 	  & ~(HH_DATA_MOD - 1)) + HH_DATA_MOD)
+#define LL_RESERVED_SPACE(dev) \
+	LL_RESERVED_SPACE_EX(dev, (dev)->hard_header_len)
 #define LL_RESERVED_SPACE_EXTRA(dev,extra) \
 	((((dev)->hard_header_len + READ_ONCE((dev)->needed_headroom) + (extra)) \
 	  & ~(HH_DATA_MOD - 1)) + HH_DATA_MOD)
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index f73e2c3b813d9..4aa1976695a8a 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1968,8 +1968,9 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 	struct net_device *dev;
 	struct sockcm_cookie sockc;
 	__be16 proto = 0;
-	int err;
+	int hard_header_len;
 	int extra_len = 0;
+	int err;
 
 	/*
 	 *	Get and verify the address.
@@ -2012,14 +2013,18 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 		extra_len = 4; /* We're doing our own CRC */
 	}
 
+	/* Keep the allocation-time header length across retry. */
+	if (!skb)
+		hard_header_len = READ_ONCE(dev->hard_header_len);
+
 	err = -EMSGSIZE;
-	if (len > dev->mtu + dev->hard_header_len + VLAN_HLEN + extra_len)
+	if (len > dev->mtu + hard_header_len + VLAN_HLEN + extra_len)
 		goto out_unlock;
 
 	if (!skb) {
-		size_t reserved = LL_RESERVED_SPACE(dev);
+		size_t reserved = LL_RESERVED_SPACE_EX(dev, hard_header_len);
 		int tlen = dev->needed_tailroom;
-		unsigned int hhlen = dev->header_ops ? dev->hard_header_len : 0;
+		unsigned int hhlen = dev->header_ops ? hard_header_len : 0;
 
 		rcu_read_unlock();
 		skb = sock_wmalloc(sk, len + reserved + tlen, 0, GFP_KERNEL);
@@ -2049,7 +2054,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 		err = -EINVAL;
 		goto out_unlock;
 	}
-	if (len > (dev->mtu + dev->hard_header_len + extra_len) &&
+	if (len > (dev->mtu + hard_header_len + extra_len) &&
 	    !packet_extra_vlan_len_allowed(dev, skb)) {
 		err = -EMSGSIZE;
 		goto out_unlock;
@@ -2962,7 +2967,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 	int offset = 0;
 	struct packet_sock *po = pkt_sk(sk);
 	bool has_vnet_hdr = false;
-	int hlen, tlen, linear;
+	int hard_header_len, hlen, tlen, linear;
 	int extra_len = 0;
 
 	/*
@@ -3003,8 +3008,9 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 			goto out_unlock;
 	}
 
+	hard_header_len = READ_ONCE(dev->hard_header_len);
 	if (sock->type == SOCK_RAW)
-		reserve = dev->hard_header_len;
+		reserve = hard_header_len;
 	if (po->has_vnet_hdr) {
 		err = packet_snd_vnet_parse(msg, &len, &vnet_hdr);
 		if (err)
@@ -3026,10 +3032,10 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 		goto out_unlock;
 
 	err = -ENOBUFS;
-	hlen = LL_RESERVED_SPACE(dev);
+	hlen = LL_RESERVED_SPACE_EX(dev, hard_header_len);
 	tlen = dev->needed_tailroom;
 	linear = __virtio16_to_cpu(vio_le(), vnet_hdr.hdr_len);
-	linear = max(linear, min_t(int, len, dev->hard_header_len));
+	linear = max(linear, min_t(int, len, hard_header_len));
 	skb = packet_alloc_skb(sk, hlen + tlen, hlen, len, linear,
 			       msg->msg_flags & MSG_DONTWAIT, &err);
 	if (skb == NULL)
@@ -3045,7 +3051,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 	} else if (reserve) {
 		skb_reserve(skb, -reserve);
 		if (len < reserve + sizeof(struct ipv6hdr) &&
-		    dev->min_header_len != dev->hard_header_len)
+		    dev->min_header_len != hard_header_len)
 			skb_reset_network_header(skb);
 	}
 
-- 
2.53.0

