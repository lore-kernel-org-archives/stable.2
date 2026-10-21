Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792565750;
	b=wDTIt/ZE2ptPLurd33Dfc8B8e3snvZ3ByBnurz7DgUa2ZPuB2OiaVUNdeY+qS/vJg5zV
	 0VtXoqtwwRNqyVTdqs6s3yxhumeUUVsuK3fXqZA1LbYmfLuAPPI5N6yRniTuHRKdph8IQ
	 zXc2qrkbOLBc5cUcikx5t677k4EInqKWLQC0/5WAGxWlNziZygGxW42oHfKBulN0JCBvi
	 ze3T02p+UDinQKQigzB2VKeNJKVL367c5O6av9fOkOv3dGb641D8UtaG0+GmhpZCTzzto
	 HGWY8qzlYGEmFWH12tV2MA+IYjqTf/VQY3on2FqCG8qz3VKdppqq6yCxpODyhOKyy/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792565750;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V+R4YF/y9X5+PnJYN2y3x8HJLwi28vjcGLuJXKxuZzw=;
	b=oIDPT6Qpog6qPx/jnHQGtFE2NaDH7QQY2W5pU2RC9q4Xt/Dxsa/PIRAbaV9ZasuhyAfx
	 LqnHvcOR8oCYPOFx4oGqKuoF+/BHsOEiVPY/iHalUOhMGDTW/TX6jY9uAvRQKD/eScgXR
	 ELzIcW17JZssnQ3PH8B4RDtKwYbFvWnZeRZSrMMRoobjGboD+2q8YcC37nPZCakAbymOY
	 xbt1E3M/jF0iTSyQ54heS7xiOI4xm08L8f5Gk0cwI6JJYPKDhHHhnoSZ/IenM5MRFr/wT
	 qmXc2WDXqPR6VChTqXSvBpC7O3Uu1pLO3NoQAlVHdr2kmvIILagvzDVSoXcV+T9gSUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CvvqXYrV;
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84EF606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 06:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B84EF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CvvqXYrV
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b3dc272dcfso407025a12.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 23:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792565748; x=1793170548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V+R4YF/y9X5+PnJYN2y3x8HJLwi28vjcGLuJXKxuZzw=;
        b=CvvqXYrVhzzPQkSFPnwn0++FTGgQkvh80qkMneWETr+RUvhHd8xfNiO0gZOIA3UkB4
         /HU53j2ToGqS7ek2++CHZl7FxkmR0lNPLtFSwQfwLT9+eP/f0gAVXAuaxeJKD5B8eyph
         81gV80/1gvzU3UbsJbbpAo7UfuHKPJGxU2G0JYdeeSYHJZlZp+iRNoN4b9fvkdT5LTEC
         ROAZJdxeieGTPYAxhtcIP/hzIetVpY2czlf8aTHdw5csogJNsPh2JZadvxopL2JiGc4v
         PGqWi/GbRS2w8S7/jgBNyaCL/DidZamOmTuf4slpO9+K0i2I5tvZ1y4dlWeEgea1blhz
         k7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792565748; x=1793170548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V+R4YF/y9X5+PnJYN2y3x8HJLwi28vjcGLuJXKxuZzw=;
        b=GCsOycqAQHBBVfw19FN6F319/AaHWbIkoebPQQsV4g9SCgWGt5ELUh8INOzEGZLPVC
         zkjJAQSDy4U/HGZnYeFwqm+Kt2l22UQ/kxwqQHZEkcr5w7JRonGYndxmRyk9xD2jPd7j
         vKaXYuuysIc71mDJ43J4OEd7WlW3qlZubhXaigU4IDjb/gXXLS8CyWEB19Sz49ZrbhJ5
         3XDX9bzcYTBeJACO0XaEe7zb/GGlDd/CG0gF65ysMfyVtXUX5tpqWLsnSYxQDJF+60C9
         OSFnEVbkxTaGrZuqsuM10nGExDlRH+qkrjFtTVWDGMe9yO7bBmntvLDODm7x7jc1ljED
         SFZw==
X-Forwarded-Encrypted: i=1; AKwUvBwvERLX0rFjukQAshdP/WLkOUe3eXSjZar2dzGTHKvCTXBR2FXngVJQnRiINC3i58p1E7FDvoY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxQ9R+2RUdv4+blcCjR69rOVqwokB7+IjN7oa8VfVSyhCgJBKS
	QV52yz0Fwh8c8oPlslL2Y645FT13Vxz4rzUOOARz3q1lmhryUPzqAXHB
X-Gm-Gg: AYBFou3ZmMJmDWNPsPwXR/x8sDKY+0/6ZFay50d6Ggr8xyukpveSgwl0/FuHYR+hnqh
	VWx0IrgI3nSWPNQKnN8/cp8bU2oPFOuJOuzHKUk6GPbmLpD3miPaDc81B3aRi0M05sbrQmUZCfj
	fEJfGvQlKNsVAJFvwK2CGznSYGc7jzkG/GMoZMJVG9TpjbwTqPh9LBCVLIYyeF5ZH8WMGsmp2hE
	fcgbxifHip0AVQqv2yDqT92g2XttnuSJuPsxGnXRqoLBGPMt4ExQOtEM5PxYsBXjnTp+tuXJVUV
	Qc5/8Hi6xV75UwoZjafpxVb1W2lrUkeH6Mjq56BuydOWK9d6SoAzb9tTBDPT/xBDXbwMorDhByk
	ibQ3n6vGgtSBYIAPIrAwIi2ZmmlrLflEqR9y+7KMlgW4FvERI9gZpkPIu04WFLhN5KRRbGJrNvC
	4OxylAe7lVEcCC0hzbmx3X7nK6C7lKRMA7lVBcm3FgPgyjq80J6MYPN9FfSGSEp4llbqNTH4o2E
	KjmJjqO7EuAkPUlR/ad1Os6VynBfPMVgbDi8Rmpoe69hDVcm7oOZEnsOKscsL3TW8asd+m4HPTK
	w0GxLKq1d/7v
X-Received: by 2002:a05:6402:52d3:b0:6b1:d2d6:4013 with SMTP id 4fb4d7f45d1cf-6b408eb8292mr521517a12.17.1792565747740;
        Tue, 20 Oct 2026 23:55:47 -0700 (PDT)
Received: from theodors-laptop.. ([5.255.118.7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b402f2b8f9sm543690a12.3.2026.10.20.23.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 23:55:47 -0700 (PDT)
From: Theodor Arsenij Larionov Trichkine <theodorlarionov@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Theodor Arsenij Larionov Trichkine <theodorlarionov@gmail.com>
Subject: [PATCH net v2] fou: reserve headroom before pushing the encap header
Date: Wed, 21 Oct 2026 14:55:17 +0800
Message-Id: <20261021065517.198322-1-theodorlarionov@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip_tunnel_xmit() and ip_md_tunnel_xmit() call ip_tunnel_encap() before
reserving headroom. A packet redirected into the tunnel (tc mirred, nft
fwd) has only the headroom of its original device, so fou_build_udp()
hits skb_under_panic(); with a mirred mirror the push overwrites the
Ethernet header of the original packet.

Reserve the headroom in fou_build_header() and gue_build_header(). GUE
sizes and builds the header from one copy of the encap config, which
can change concurrently. As the skb head may move, ip_tunnel_xmit() and
ip_md_tunnel_xmit() reload inner_iph after ip_tunnel_encap(), and
ip_tunnel_xmit() reads tnl_params before it: for GRE with header_ops,
tnl_params points into the head.

Fixes: 56328486539d ("net: Changes to ip_tunnel to support foo-over-udp encapsulation")
Fixes: ac931d4cdec3 ("ipip,ip_tunnel,sit: Add FOU support for externally controlled ipip devices")
Cc: stable@vger.kernel.org
Signed-off-by: Theodor Arsenij Larionov Trichkine <theodorlarionov@gmail.com>
---
v2: move the headroom reservation into {fou,gue}_build_header(), reload
inner_iph after ip_tunnel_encap() and read tnl_params before it, which
the Sashiko review of v1 pointed out.
v1: https://lore.kernel.org/netdev/20261010223601.1193655-1-theodorlarionov@gmail.com/

Chengfeng Ye posted an earlier series for this bug; this takes the
builder approach Paolo suggested.
Link: https://lore.kernel.org/netdev/20260904165544.1362052-1-nicoyip.dev@gmail.com/

 net/ipv4/fou_core.c  | 15 +++++++++++----
 net/ipv4/ip_tunnel.c |  6 ++++--
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index 076fdca44f51..896e63adf698 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -1059,6 +1059,9 @@ static int fou_build_header(struct sk_buff *skb, struct ip_tunnel_encap *e,
 	__be16 sport;
 	int err;
 
+	if (skb_cow_head(skb, fou_encap_hlen(e)))
+		return -ENOMEM;
+
 	err = __fou_build_header(skb, e, protocol, &sport, type);
 	if (err)
 		return err;
@@ -1071,16 +1074,20 @@ static int fou_build_header(struct sk_buff *skb, struct ip_tunnel_encap *e,
 static int gue_build_header(struct sk_buff *skb, struct ip_tunnel_encap *e,
 			    u8 *protocol, struct flowi4 *fl4)
 {
-	int type = e->flags & TUNNEL_ENCAP_FLAG_CSUM ? SKB_GSO_UDP_TUNNEL_CSUM :
-						       SKB_GSO_UDP_TUNNEL;
+	struct ip_tunnel_encap encap = READ_ONCE(*e);
+	int type = encap.flags & TUNNEL_ENCAP_FLAG_CSUM ?
+		   SKB_GSO_UDP_TUNNEL_CSUM : SKB_GSO_UDP_TUNNEL;
 	__be16 sport;
 	int err;
 
-	err = __gue_build_header(skb, e, protocol, &sport, type);
+	if (skb_cow_head(skb, gue_encap_hlen(&encap)))
+		return -ENOMEM;
+
+	err = __gue_build_header(skb, &encap, protocol, &sport, type);
 	if (err)
 		return err;
 
-	fou_build_udp(skb, e, fl4, protocol, sport);
+	fou_build_udp(skb, &encap, fl4, protocol, sport);
 
 	return 0;
 }
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index e6bcf01411d0..742c2b309608 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -606,6 +606,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	if (ip_tunnel_encap(skb, &tun_info->encap, &proto, &fl4) < 0)
 		goto tx_error;
+	inner_iph = (const struct iphdr *)skb_inner_network_header(skb);
 
 	use_cache = ip_tunnel_dst_cache_usable(skb, tun_info);
 	if (use_cache)
@@ -749,6 +750,8 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	}
 
 	tos = tnl_params->tos;
+	df = tnl_params->frag_off;
+	ttl = tnl_params->ttl;
 	if (tos & 0x1) {
 		tos &= ~0x1;
 		if (payload_protocol == htons(ETH_P_IP)) {
@@ -767,6 +770,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0)
 		goto tx_error;
+	inner_iph = (const struct iphdr *)skb_inner_network_header(skb);
 
 	if (connected && md) {
 		use_cache = ip_tunnel_dst_cache_usable(skb, tun_info);
@@ -799,7 +803,6 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		goto tx_error;
 	}
 
-	df = tnl_params->frag_off;
 	if (payload_protocol == htons(ETH_P_IP) && !tunnel->ignore_df)
 		df |= (inner_iph->frag_off & htons(IP_DF));
 
@@ -821,7 +824,6 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	}
 
 	tos = ip_tunnel_ecn_encap(tos, inner_iph, skb);
-	ttl = tnl_params->ttl;
 	if (ttl == 0) {
 		if (payload_protocol == htons(ETH_P_IP))
 			ttl = inner_iph->ttl;
-- 
2.34.1

