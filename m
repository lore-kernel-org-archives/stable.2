Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72B73F58E5
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570399; cv=none; b=DdHsEM30LBv/IRLw2bIfu2MlqdcxPnLvz/TvZO8myMBzKMmoRNkujoxqvz/4KFShCetj+A6LU6AmSU7qjM1Maeh3HdL1LphIR8z6n+AopF9ZlGhKjBFNHABSxo6uSBsz9hwxo1EkkA7iKEPzKHfhIn0AJA4p/BgmIk7WN+RZnZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570399; c=relaxed/simple;
	bh=MwXjXKzmNiIkV3RifNZIu5TYX0eiFkzj/WozPklzINs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mvBwAxuKq+RFw2sizVvRx391RqFoZHCUy/olprmVniQ/aF4zo2B6BFYpfBHp2Kh+p769CFzN2kPIZ+NAWUYvCyAYURWfiyDZ3HgBCceCCBXIx+YQQ9gyFq0ytUNdGLw7XH3LQsiVj2fQO8V8ykNXy2h0FmfQPLGNd7h11pGaSWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pf5OmeA9; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pf5OmeA9"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66c70cbd49aso398250d50.0
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 04:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787570396; x=1788175196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T13rKDf01IVg0gpjIDieJc2bCTTY4gP5nImnjH/r5+4=;
        b=Pf5OmeA9QSY2IKPw95jshRY43ba6Hdj5o69mMX+4rpFxnbR1bPyn1edWe3GZOh9sZO
         VAGJe5f/hYJjxxRu2zlYFz8BbSbfck7A+1XW/qtC2jswR/3T2i+4UGnJbkWk+djIceGD
         hcrzvPMgyJ7h+6DvX3eRbwifE0wytePCxH8KYbBIBGLnueg6X8L+YskY3j+vVhcvcM+l
         il5KWmBxBrdBnk5BrMV6G4Xzc/2fxeLAFh+VarriDKNIJZmKUaAZr/ZVGWXyx/B2gviN
         nFXrKGq0+AJZnmXtPlI4fHDiSdA0uTiqGRRjtg4MTIuHy5ESDg6Q6rqeeSLTiSvXuTLS
         txIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787570396; x=1788175196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T13rKDf01IVg0gpjIDieJc2bCTTY4gP5nImnjH/r5+4=;
        b=hO82jHjuKfDmEwB7O6reLjh5l4VRF5b5IuQXB3/4tHHXz9lxdJq2PR2pPTD5Zg7ea2
         4uyrwJdavHDnC6Qz8dwfoN1eqbWEAOVmmDLMprfsN2SEc01iJk5QylXvfzcQb9eRkOef
         dzcRDcMZsJyuQW5gLFCSjm9b/y39hQj3lM01ts48cS/r8ThA0S372OZ5c6lmtVtrBkHf
         5lBLVYb2EKB3PbNTl9MaBztM9ovDK9oOgoaZdD+TB2CJVSWXziq8W2RAWMcsWU8WVU9G
         icXmDksfQQNkc57ykErOicT9DQPD2P+JAWpMGskIATjT4WZOlcZdafqRLcG6dnBBJdyE
         7K/w==
X-Forwarded-Encrypted: i=1; AHgh+RqxmaQv4umlHFmdGWhSeJzJtyJQZgvXpaqODrufdjPJrysXoINZQwYwL/ERuOIKWeiLSFu7qsM=@vger.kernel.org
X-Gm-Message-State: AFuF++kzWVwbrH9H97CWlDRzPs3Oo0q8wgNTTYgpPEtD602kaTv/M5Ja
	ul0SNIY0/H5/kHo2jCcpWPbnRzsGqlsCtVE09LTZfKlSzAMHClGExY1y
X-Gm-Gg: AR+sD12pj4gzM6PZMx9c8M7CIHScuGXHm/h3m5+g/LvsHdBh3h/pPoCZ8YVkx6CUEb6
	w0GWC8APSI5HXFuqL9ku18eWgIgX35nnUtonvTCoHNCJSdfxKZ9dKBykynZqIS7CxfuLFlIbG41
	sN7PHp7b/CVcph3a4nzJ/fzSfeMod+mBFQEw5WcHfsRHqZ7sFtCLJ2F4BoORIBExOe/iZAhWqBK
	Nf0PbVLsKuu6XGCmG0ryYnH9Jgh5SWcS5nsN7AzFilZm0nypKnkbaNqISPvGSgRGRUXYNwfQMlD
	HOOwxASMwyaI/fRvkwjm1fW/JAW2J6XoRqy9iIxk9/kbUPjgT8U1niSP1virIRVYN9wVt3tZbVz
	fxuJbI5gZl+9YRmpqDj5ScvmQkqFDU8/EV/SCDbzPnY6CQjIEHGRsxbJ+JZEcl7BWeJ8DHdYC4l
	481uT48rQYRjf7vWvIpHpz4tzw0rRa6B2vVugkMPmTHsi/h6C0Yya5cT9Kj3l+Ch/pbHJ58JurM
	z40SbAP6cIhKgjGls9Zy3ZTCg8/NwHAnX1Iy8YEhX6kDny06a8I++Y=
X-Received: by 2002:a05:690c:6e0d:b0:80b:d006:6436 with SMTP id 00721157ae682-849f5df5f1dmr104720337b3.4.1787570396427;
        Mon, 24 Aug 2026 04:19:56 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84ca5d252f0sm30623677b3.13.2026.08.24.04.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 04:19:55 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Xin Long <lucien.xin@gmail.com>,
	William Tu <u9012063@gmail.com>,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3] ip_tunnel: reserve FOU/GUE headroom before encapsulation
Date: Mon, 24 Aug 2026 19:19:44 +0800
Message-ID: <20260824111944.187200-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip_tunnel_encap() expects its callers to reserve headroom based on
ip_encap_hlen(). Unlike the IPv6 tunnel transmit paths, the IPv4
ip_tunnel_xmit() and ip_md_tunnel_xmit() push FOU and GUE headers
before they grow the skb headroom.

That becomes visible when ipgre_changelink() publishes UDP
encapsulation before it updates the device headroom. The transmit path
does not serialize with RTNL, so it can interleave as follows:

  CPU 0 (ipgre_changelink)        CPU 1 (ipgre_xmit)
  install GUE encapsulation
                                  reserve the old needed_headroom
  publish larger GRE flags
  update tunnel->tun_hlen
                                  push the larger GRE header
                                  push the GUE and UDP headers
  update dev->needed_headroom

With REMCSUM, the new layout can push 16 bytes of GRE and 20 bytes of
GUE/UDP headers into an skb with only 32 bytes of actual headroom. The
final UDP push writes four bytes before skb->head.

With the update window widened, the kernel reported:

  skbuff: skb_under_panic: ... len:128 put:8 ... dev:gre0poc
  kernel BUG at net/core/skbuff.c:214!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  Call Trace:
   skb_push
   fou_build_udp
   gue_build_header
   ip_tunnel_xmit
   __gre_xmit
   ipgre_xmit

Use ip_encap_hlen() up front, route and perform PMTU handling first,
then reserve the final headroom before ip_tunnel_encap() builds the
UDP tunnel headers. This matches the existing IPv6 pattern and keeps
ip_tunnel_encap() as a pure header builder.

Fixes: dd9d598c6657 ("ip_gre: add the support for i/o_flags update via netlink")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
Changes in v3:
- Move the headroom reservation into ip_tunnel_xmit() and
  ip_md_tunnel_xmit() instead of growing the skb inside the FOU/GUE
  builders.
- Use ip_encap_hlen() to reserve the final caller-side headroom before
  ip_tunnel_encap(), matching the existing IPv6 transmit pattern.
- Drop the IPv4 raw-pointer refreshes that were only needed when
  skb_cow_head() could run inside the encapsulation builders.

Link: https://lore.kernel.org/netdev/20260808005956.3761487-1-nicoyip.dev@gmail.com/ [v2]
Link: https://lore.kernel.org/netdev/20260801060115.3538849-1-nicoyip.dev@gmail.com/ [v1]
---
 net/ipv4/ip_tunnel.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 9d114bd575f9..5d5e7db11b3d 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -578,6 +578,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	const struct iphdr *inner_iph;
 	struct rtable *rt = NULL;
 	struct flowi4 fl4;
+	int encap_hlen;
 	__be16 df = 0;
 	u8 tos, ttl;
 	bool use_cache;
@@ -601,11 +602,11 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 			    tos & INET_DSCP_MASK, tunnel->net, 0, skb->mark,
 			    skb_get_hash(skb), key->flow_flags);
 
-	if (!tunnel_hlen)
-		tunnel_hlen = ip_encap_hlen(&tun_info->encap);
-
-	if (ip_tunnel_encap(skb, &tun_info->encap, &proto, &fl4) < 0)
+	encap_hlen = ip_encap_hlen(&tun_info->encap);
+	if (encap_hlen < 0)
 		goto tx_error;
+	if (!tunnel_hlen)
+		tunnel_hlen = encap_hlen;
 
 	use_cache = ip_tunnel_dst_cache_usable(skb, tun_info);
 	if (use_cache)
@@ -645,7 +646,8 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 			ttl = ip4_dst_hoplimit(&rt->dst);
 	}
 
-	headroom += LL_RESERVED_SPACE(rt->dst.dev) + rt->dst.header_len;
+	headroom += encap_hlen + LL_RESERVED_SPACE(rt->dst.dev) +
+		    rt->dst.header_len;
 	if (skb_cow_head(skb, headroom)) {
 		ip_rt_put(rt);
 		goto tx_dropped;
@@ -653,6 +655,11 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	ip_tunnel_adj_headroom(dev, headroom);
 
+	if (ip_tunnel_encap(skb, &tun_info->encap, &proto, &fl4) < 0) {
+		ip_rt_put(rt);
+		goto tx_error;
+	}
+
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, proto, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
 	return;
@@ -677,6 +684,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	__be16 payload_protocol;
 	bool use_cache = false;
 	struct flowi4 fl4;
+	int encap_hlen;
 	bool md = false;
 	bool connected;
 	int err_count;
@@ -765,7 +773,8 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 			    tunnel->net, READ_ONCE(tunnel->parms.link),
 			    tunnel->fwmark, skb_get_hash(skb), 0);
 
-	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0)
+	encap_hlen = ip_encap_hlen(&tunnel->encap);
+	if (encap_hlen < 0)
 		goto tx_error;
 
 	if (connected && md) {
@@ -834,7 +843,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	}
 
 	max_headroom = LL_RESERVED_SPACE(rt->dst.dev) + sizeof(struct iphdr)
-			+ rt->dst.header_len + ip_encap_hlen(&tunnel->encap);
+			+ rt->dst.header_len + encap_hlen;
 
 	if (skb_cow_head(skb, max_headroom)) {
 		ip_rt_put(rt);
@@ -845,6 +854,11 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	ip_tunnel_adj_headroom(dev, max_headroom);
 
+	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0) {
+		ip_rt_put(rt);
+		goto tx_error;
+	}
+
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
 	return;
-- 
2.43.0

