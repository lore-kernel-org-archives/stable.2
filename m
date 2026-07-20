Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0561842B335
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555501; cv=none; b=I+0aXipYtc57ayn+DuOrJH+0BJ3q/2eqfquu4mFLxakKipSSBXwv8gpp1uCemh0cEPPv5wwa+cK/95fr0T3fWMXz2cUmgcASwt/Y2+1ux80se9fN2QaWhlb11ZaHssK2ToBbGWtDa29vEi5OSC/EmNjeoh3taO2jCD81rxkyM/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555501; c=relaxed/simple;
	bh=8aYCnPsa3nLlSzNbWTOJrHEKxPyvPSx1jpaInV1XADk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=A39K6GIHB2rfv72JBg9z1xudH5WSvojqLqK07+nMwE9ZyK9OpsGjYzOb9WftjpDjsVi/CYPjl+fd6hChQH/+xTJuJTKztIRuTnD20OZR1P9fvPcvL+BSStqWSSBSG4d+DXxLPpAqnRj2qwXlSg41CD4b2bMpY7Sh8CsEJhAgEI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WoRaF5EK; arc=none smtp.client-ip=209.85.160.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WoRaF5EK"
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51a8c689b5fso195210361cf.0
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 06:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784555495; x=1785160295; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KICH6+O2vVTAsaPbT0lNLJSSjrF/FuE3egZF4BaX0l4=;
        b=WoRaF5EKCAeFvABBj0JCdIzpzMbmqZlFr/CEO6/XhHDsceneMeqDwGsN9o7JCfx7BD
         EpRtNGjIaHXjoJHo0D9B/VpOy2uZMS0i0BLW7As/Ey/zaB5XjQSmQgySGe/hN5hCGFIw
         b8DamBqjAO6rFRSghHPG5l4+3UCvq8843m0XFR0YqgNj7aF42Y+xmYxZ81GGFMAOwdiY
         Ehp38kE8CrUiyvwGVxcTcoIhrjmZMaqr0TzgvBTKFqygkSqoGoq7r1bcEAFfzEUhnkhb
         YXObrmOIY9keAphyaek7hkKKUX8GaxCL4nUkTYFI2BwL0X/5D8Elcw/DZu28C9izFLIo
         haeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784555495; x=1785160295;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KICH6+O2vVTAsaPbT0lNLJSSjrF/FuE3egZF4BaX0l4=;
        b=BKE0CUaUzDyZL4VA60OmuedWNSMZqqsUo0Kh/+zJ0Ccm+1cydkUw2622ZJXtn832xG
         c1FXhB/VVH6EjD9eBZ7iup+S8w1hc/v+nZoMKW4ou3gl31CcDdAkdvzp6V9dWAGyIv9n
         9VcSz/XF3ST7wWJImVciHqWdYk4QJpvWzuqtiiDDl2I+mS68gWWOR5K/jY0yvPy/1CyZ
         FyHIQrXd7aclTm8W/UHeP2+bAcuqfBQE0GaOc4YpAZHoSTYBtCFPmo1w4ae5V4xepH7U
         w2PLRHZinWIyUIfgjkve56M5JdnBeG1fivoRisTpVqAQNdurIT+abADPQUPKE9LzATfL
         2/+w==
X-Forwarded-Encrypted: i=1; AHgh+RqsVI3/oZqj9OmSlDBLPO44Om/oc9JsLS1Z/+5+jY9BRPZbvCPsuWHyD4DqnEOnxVoHA31+bQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCs61FZICOpTs2DBEzS845/lY6MncA5iEjU+qDb2nYr9CAw5yf
	XVy6W6CSFH1APhMowlFZpnKOpr2W3R32a8pgxV3IqSEAJ649fFK9TUgqN5j37cXBAmX0Dgabe1C
	FsACaXI/J6XaUGw==
X-Received: from qtal17-n1.prod.google.com ([2002:a05:622a:e0d1:10b0:51c:9d78:8252])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5298:b0:51c:f3:34d9 with SMTP id d75a77b69052e-5213c9dfbdbmr120808951cf.27.1784555494361;
 Mon, 20 Jul 2026 06:51:34 -0700 (PDT)
Date: Mon, 20 Jul 2026 13:51:32 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260720135132.3957146-1-edumazet@google.com>
Subject: [PATCH v2 net] gre: fix ERSPAN o_flags race/corruption in xmit and fill_info
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For IPv4 ERSPAN:
In erspan_xmit(), the driver clears IP_TUNNEL_SEQ_BIT (for version 0)
and IP_TUNNEL_KEY_BIT directly in the shared tunnel->parms.o_flags
structure. Since transmit paths can run locklessly and concurrently,
this leads to a data race.

Furthermore, modifying tunnel->parms.o_flags permanently alters the
tunnel configuration. To work around this, erspan_fill_info() (which
reports config to userspace) was setting IP_TUNNEL_KEY_BIT back. If
erspan_fill_info (running under RTNL) and erspan_xmit (running locklessly)
race, erspan_xmit might see IP_TUNNEL_KEY_BIT set when it shouldnt,
leading to GRE header corruption (injecting a key field into the ERSPAN
GRE header).

Fix this by:
1) Snapshotting tunnel->parms.o_flags onto the stack in ipgre_xmit(),
   gre_tap_xmit(), and __gre6_xmit(), and computing the GRE header length via
   gre_calc_hlen(flags) instead of reading tunnel->tun_hlen. This eliminates
   TOCTOU races between flags, offload checks, and header length.
   Note: Since tunnel->tun_hlen is no longer used in fast path xmit, it could be
   removed altogether in net-next.
2) Using local flags in erspan_xmit(), clearing IP_TUNNEL_CSUM_BIT and
   IP_TUNNEL_KEY_BIT (and IP_TUNNEL_SEQ_BIT for v0) before passing them to
   __gre_xmit().
3) Removing the racy modification of t->parms.o_flags in erspan_fill_info().
4) Forcing IP_TUNNEL_KEY_BIT in the reported flags for ERSPAN locally
   in ipgre_fill_info().

For IPv6 ERSPAN:
ip6erspan_tunnel_xmit() was locklessly clearing IP_TUNNEL_KEY_BIT in
t->parms.o_flags even though it does not use these flags for building
the GRE header (it uses local flags). This permanently corrupts the
configuration and races with ip6gre_fill_info() which reads it.

Remove the redundant and racy modification.
This should remove false sharing in a fast path.

Add const qualifiers in ipgre_fill_info(), erspan_fill_info()
and ip6gre_fill_info() to clarify that these methods are not
supposed to write any live parameters.

Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
Fixes: ee496694b9ee ("ip_gre: do not report erspan version on GRE interface")
Fixes: 5a963eb61b7c ("ip6_gre: Add ERSPAN native tunnel support")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
v2: addressed Sashiko and Ido feedback.
v1: https://lore.kernel.org/netdev/20260615140333.3161072-1-edumazet@google.com/

 net/ipv4/ip_gre.c  | 45 +++++++++++++++++++++++++--------------------
 net/ipv6/ip6_gre.c |  7 +++----
 2 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 3efdfb4ffa2112db3b056169d02d28e8853873ae..442a2c9513e84e84013b4a6d447dd5e243428c5c 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -475,15 +475,12 @@ static int gre_rcv(struct sk_buff *skb)
 
 static void __gre_xmit(struct sk_buff *skb, struct net_device *dev,
 		       const struct iphdr *tnl_params,
-		       __be16 proto)
+		       __be16 proto, const unsigned long *flags)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
-	IP_TUNNEL_DECLARE_FLAGS(flags);
-
-	ip_tunnel_flags_copy(flags, tunnel->parms.o_flags);
 
 	/* Push GRE header. */
-	gre_build_header(skb, tunnel->tun_hlen,
+	gre_build_header(skb, gre_calc_hlen(flags),
 			 flags, proto, tunnel->parms.o_key,
 			 test_bit(IP_TUNNEL_SEQ_BIT, flags) ?
 			 htonl(atomic_fetch_inc(&tunnel->o_seqno)) : 0);
@@ -654,6 +651,7 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 	const struct iphdr *tnl_params;
+	IP_TUNNEL_DECLARE_FLAGS(flags);
 
 	if (!pskb_inet_may_pull(skb))
 		goto free_skb;
@@ -663,6 +661,8 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
 		return NETDEV_TX_OK;
 	}
 
+	ip_tunnel_flags_copy(flags, tunnel->parms.o_flags);
+
 	if (dev->header_ops) {
 		int pull_len = tunnel->hlen + sizeof(struct iphdr);
 
@@ -688,11 +688,10 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
 		tnl_params = &tunnel->parms.iph;
 	}
 
-	if (gre_handle_offloads(skb, test_bit(IP_TUNNEL_CSUM_BIT,
-					      tunnel->parms.o_flags)))
+	if (gre_handle_offloads(skb, test_bit(IP_TUNNEL_CSUM_BIT, flags)))
 		goto free_skb;
 
-	__gre_xmit(skb, dev, tnl_params, skb->protocol);
+	__gre_xmit(skb, dev, tnl_params, skb->protocol, flags);
 	return NETDEV_TX_OK;
 
 free_skb:
@@ -705,6 +704,7 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
 			       struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
+	IP_TUNNEL_DECLARE_FLAGS(flags);
 	bool truncate = false;
 	__be16 proto;
 
@@ -728,10 +728,12 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
 		truncate = true;
 	}
 
+	ip_tunnel_flags_copy(flags, tunnel->parms.o_flags);
+
 	/* Push ERSPAN header */
 	if (tunnel->erspan_ver == 0) {
 		proto = htons(ETH_P_ERSPAN);
-		__clear_bit(IP_TUNNEL_SEQ_BIT, tunnel->parms.o_flags);
+		__clear_bit(IP_TUNNEL_SEQ_BIT, flags);
 	} else if (tunnel->erspan_ver == 1) {
 		erspan_build_header(skb, ntohl(tunnel->parms.o_key),
 				    tunnel->index,
@@ -746,8 +748,9 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
 		goto free_skb;
 	}
 
-	__clear_bit(IP_TUNNEL_KEY_BIT, tunnel->parms.o_flags);
-	__gre_xmit(skb, dev, &tunnel->parms.iph, proto);
+	__clear_bit(IP_TUNNEL_CSUM_BIT, flags);
+	__clear_bit(IP_TUNNEL_KEY_BIT, flags);
+	__gre_xmit(skb, dev, &tunnel->parms.iph, proto, flags);
 	return NETDEV_TX_OK;
 
 free_skb:
@@ -760,6 +763,7 @@ static netdev_tx_t gre_tap_xmit(struct sk_buff *skb,
 				struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
+	IP_TUNNEL_DECLARE_FLAGS(flags);
 
 	if (!pskb_inet_may_pull(skb))
 		goto free_skb;
@@ -769,14 +773,15 @@ static netdev_tx_t gre_tap_xmit(struct sk_buff *skb,
 		return NETDEV_TX_OK;
 	}
 
-	if (gre_handle_offloads(skb, test_bit(IP_TUNNEL_CSUM_BIT,
-					      tunnel->parms.o_flags)))
+	ip_tunnel_flags_copy(flags, tunnel->parms.o_flags);
+
+	if (gre_handle_offloads(skb, test_bit(IP_TUNNEL_CSUM_BIT, flags)))
 		goto free_skb;
 
 	if (skb_cow_head(skb, dev->needed_headroom))
 		goto free_skb;
 
-	__gre_xmit(skb, dev, &tunnel->parms.iph, htons(ETH_P_TEB));
+	__gre_xmit(skb, dev, &tunnel->parms.iph, htons(ETH_P_TEB), flags);
 	return NETDEV_TX_OK;
 
 free_skb:
@@ -1560,12 +1565,15 @@ static size_t ipgre_get_size(const struct net_device *dev)
 
 static int ipgre_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
-	struct ip_tunnel *t = netdev_priv(dev);
-	struct ip_tunnel_parm_kern *p = &t->parms;
+	const struct ip_tunnel *t = netdev_priv(dev);
+	const struct ip_tunnel_parm_kern *p = &t->parms;
 	IP_TUNNEL_DECLARE_FLAGS(o_flags);
 
 	ip_tunnel_flags_copy(o_flags, p->o_flags);
 
+	if (t->erspan_ver != 0 && !t->collect_md)
+		__set_bit(IP_TUNNEL_KEY_BIT, o_flags);
+
 	if (nla_put_u32(skb, IFLA_GRE_LINK, p->link) ||
 	    nla_put_be16(skb, IFLA_GRE_IFLAGS,
 			 gre_tnl_flags_to_gre_flags(p->i_flags)) ||
@@ -1608,12 +1616,9 @@ static int ipgre_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
 static int erspan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
-	struct ip_tunnel *t = netdev_priv(dev);
+	const struct ip_tunnel *t = netdev_priv(dev);
 
 	if (t->erspan_ver <= 2) {
-		if (t->erspan_ver != 0 && !t->collect_md)
-			__set_bit(IP_TUNNEL_KEY_BIT, t->parms.o_flags);
-
 		if (nla_put_u8(skb, IFLA_GRE_ERSPAN_VER, t->erspan_ver))
 			goto nla_put_failure;
 
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 7c09a269b3521618e264655ad2b93586f7214b0b..9e68afec9dce41ab7f094093a8607f9f7ebca4f9 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -777,7 +777,7 @@ static netdev_tx_t __gre6_xmit(struct sk_buff *skb,
 
 		ip_tunnel_flags_copy(flags, tunnel->parms.o_flags);
 
-		gre_build_header(skb, tunnel->tun_hlen, flags,
+		gre_build_header(skb, gre_calc_hlen(flags), flags,
 				 protocol, tunnel->parms.o_key,
 				 test_bit(IP_TUNNEL_SEQ_BIT, flags) ?
 				 htonl(atomic_fetch_inc(&tunnel->o_seqno)) :
@@ -964,7 +964,6 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 	if (skb_cow_head(skb, dev->needed_headroom ?: t->hlen))
 		goto tx_err;
 
-	__clear_bit(IP_TUNNEL_KEY_BIT, t->parms.o_flags);
 	IPCB(skb)->flags = 0;
 
 	/* For collect_md mode, derive fl6 from the tunnel key,
@@ -2115,8 +2114,8 @@ static size_t ip6gre_get_size(const struct net_device *dev)
 
 static int ip6gre_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
-	struct ip6_tnl *t = netdev_priv(dev);
-	struct __ip6_tnl_parm *p = &t->parms;
+	const struct ip6_tnl *t = netdev_priv(dev);
+	const struct __ip6_tnl_parm *p = &t->parms;
 	IP_TUNNEL_DECLARE_FLAGS(o_flags);
 
 	ip_tunnel_flags_copy(o_flags, p->o_flags);
-- 
2.55.0.229.g6434b31f56-goog

