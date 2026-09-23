Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC1E3B8BD1
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 03:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790135555; cv=none; b=az4qj43mQIxI3qOcuGQp+YSDzxW/Enel/iTV1K2wu8WMnwOR3C3gt1JvAn8lq/ZjzhX1vb3l9kOjo+Ate9HtNqxmo/Y5sOGqaRV/YvSuBnf3o+eQa0uxcmJlPjZF+Y9IbL+DQi9+XBGuOz45Kpep0QIFpL0/Shwk6tIj0bTKDkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790135555; c=relaxed/simple;
	bh=Dl/7sLT48SGnsqc02ginEt6412z6YI6qpdUrXPg08q0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KV20e+IL7x451l+cy0EJiR5C8WzyANfpGeXz1s1g6pW6imOGryyHPl6ve0NZOd80FSR2IyK17BMtTyBVp/BjY8nX58SKW+o5U5z9JrOLkZIztxjKIFbRejjRtSg977y/zJ7o2zJXR+UywjR4ct1mUxw3fntp1SzT4Ryl/QEvVRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f63gSroa; arc=none smtp.client-ip=209.85.219.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f63gSroa"
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-90e8135d7eeso9079506d6.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 20:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790135552; x=1790740352; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7dGWsyugkeBiAvstwI3BqXWrM8JznyumSObXzLvLvUU=;
        b=f63gSroac+Q00agYD3WqF+XZZcwBEve/LtPKzN8O9xYfwuvs7uNYudh1w3vGj0+JBD
         mdp6ZvCVqq7hChrOGCQK7xY0MVh1iBxDYSKZymsOJEa5jvPe/ucfXTqYVhvV6id1ttak
         rjdHvkNU8K0SOUHC3Wf0Ze7l/KbeFNWUOMJvNZPj+NLHr0tINq3t3rvotF04PKyD2WQr
         xI/Wh1PIcMD6kkrz82rOTPBou4iUBFCv0z3b5jgLYLSIcP3mfyWLBnRq6MPXFsl3fjyx
         uhNeg/IRW5pleOlXRi/w+7/buiDDrzo8xotvPROoPwdGj5SYWloZn9YkflU+JW5S9Hdm
         sg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790135552; x=1790740352;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7dGWsyugkeBiAvstwI3BqXWrM8JznyumSObXzLvLvUU=;
        b=n9tD7g0mOopfZI/FBKtPht2Wwr6jK5TLkRigmUK/JjuBR850t3rlZATx27gdGrMeZ7
         3/zhStRIZIax8chJSE85peckFM9nwcEnkz5lBN8u/wbEzjOhnkv1DlrsuE4rJr/O6qVr
         GyZAseGmFAdHSYUwVFv/jGqTCqjdb7ooK3crbTsfCn/+QDU4/JIXaRUw6UmqbLAqk2lb
         R3SAIUq16/rrPil2FBQVEKHlsPem4mLmQyVvEAstKqtkSYNfruGXNRmkUzJWD4JVpvbx
         z0WG+EgPrn+NEc7O90D40GMFHMo9ouxWcVnoAnmo6GYntj1yr1Wv76XQe5vQOmx3mQi1
         YMLA==
X-Forwarded-Encrypted: i=1; AKwUvBzKl5Z7RlJ4QelWbn5YXLrTj4vZ+12nR3vgDz7gb2066hEA3V/wts/9SjBXNp0tn8Ry3Pk18ts=@vger.kernel.org
X-Gm-Message-State: AFuF++kIfJhCaOqzlfTGJFm+IMwP3UZccr4myjfk8sMqPDFbg1m38wPW
	kveZ6aDu2eCQckHxCDKi55VUeOqeucTfcEgcRKw3ISyBIxfXo2PFeJj0ydUunDch0MlQ3Y26Huf
	IEtfmYa6IElDnEA==
X-Received: from qvc3.prod.google.com ([2002:a05:6214:8103:b0:912:53a1:3e84])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:3197:b0:912:4653:9a80 with SMTP id 6a1803df08f44-9140c41f94emr21645756d6.24.1790135552070;
 Tue, 22 Sep 2026 20:52:32 -0700 (PDT)
Date: Wed, 23 Sep 2026 03:52:17 +0000
In-Reply-To: <20260923035217.179102-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923035217.179102-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923035217.179102-6-edumazet@google.com>
Subject: [PATCH net v3 5/5] gre: do not read inner frame as erspan metadata in
 collect_md mode
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, William Tu <u9012063@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

erspan_rcv() and ip6erspan_rcv() copy the ERSPAN metadata out of the
packet for collect_md tunnels:

        pkt_md = (struct erspan_metadata *)(gh + gre_hdr_len +
                                            sizeof(*ershdr));
        ...
        memcpy(md2, pkt_md, ver == 1 ? ERSPAN_V1_MDSIZE :
                                       ERSPAN_V2_MDSIZE);

Both read 8 bytes at 12 bytes from the start of the GRE header, assuming
an ERSPAN version 1 or 2 header was pulled. Because
__iptunnel_pull_header() with ETH_P_TEB linearizes an extra ETH_HLEN (14)
bytes beyond @len, this does not read past skb->tail, but when
erspan_hdr_len(ver) is 0 it copies bytes from the inner Ethernet frame
into md->u.md2. Two ways to get there:

- An ERSPAN type I packet has a 4-byte ETH_P_ERSPAN GRE header and no
  ERSPAN header at all, so erspan_rcv() sets ver = 0 and only pulls the
  GRE header. It still falls back to a collect_md tunnel through
  itn->collect_md_tun, and there the ternary above picks ERSPAN_V2_MDSIZE
  and reads 8 bytes of the inner Ethernet header as ERSPAN v2 metadata.
  Also check tpi->proto == htons(ETH_P_ERSPAN) in is_erspan_type1() to
  match gre_parse_header() so a 4-byte ETH_P_ERSPAN2 frame is not treated
  as Type I.

- A packet with an 8-byte GRE header (or IPv6 ERSPAN) and ershdr->ver == 0
  is malformed, yet neither erspan_rcv() nor ip6erspan_rcv() validates the
  version before using it, so erspan_hdr_len(0) pulls 0 bytes (leaving the
  4-byte ERSPAN base header inside the inner frame) and copies inner frame
  bytes into md->u.md2. A version above 2 also stores a version that the
  transmit side (erspan_fb_xmit(), ip6erspan_tunnel_xmit()) rejects.

Reject a base header whose version is neither 1 nor 2, and skip the
metadata extraction for type I, which has none: ip_tun_rx_dst() hands
out a zeroed option area, so md->version = 0 alone describes it.

Fixes: f989d546a2d5 ("erspan: Add type I version 0 support.")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ip_gre.c  | 43 +++++++++++++++++++++++++++----------------
 net/ipv6/ip6_gre.c |  2 ++
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 7385d66a94bf49c84bc674ded51ed3f9f5352e28..a00df7bda0012b03aed50fd569cfd0611a67ce9f 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -255,13 +255,13 @@ static void gre_err(struct sk_buff *skb, u32 info)
 	ipgre_err(skb, info, &tpi);
 }
 
-static bool is_erspan_type1(int gre_hdr_len)
+static bool is_erspan_type1(int gre_hdr_len, __be16 proto)
 {
 	/* Both ERSPAN type I (version 0) and type II (version 1) use
 	 * protocol 0x88BE, but the type I has only 4-byte GRE header,
 	 * while type II has 8-byte.
 	 */
-	return gre_hdr_len == 4;
+	return proto == htons(ETH_P_ERSPAN) && gre_hdr_len == 4;
 }
 
 static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
@@ -274,7 +274,6 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 	struct ip_tunnel_net *itn;
 	struct ip_tunnel *tunnel;
 	const struct iphdr *iph;
-	struct erspan_md2 *md2;
 	int ver;
 	int len;
 
@@ -282,7 +281,7 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 
 	itn = net_generic(net, erspan_net_id);
 	iph = ip_hdr(skb);
-	if (is_erspan_type1(gre_hdr_len)) {
+	if (is_erspan_type1(gre_hdr_len, tpi->proto)) {
 		ver = 0;
 		__set_bit(IP_TUNNEL_NO_KEY_BIT, flags);
 		tunnel = ip_tunnel_lookup(itn, skb->dev->ifindex, flags,
@@ -294,6 +293,9 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 
 		ershdr = (struct erspan_base_hdr *)(skb->data + gre_hdr_len);
 		ver = ershdr->ver;
+		if (unlikely(ver != 1 && ver != 2))
+			return PACKET_REJECT;
+
 		iph = ip_hdr(skb);
 		__set_bit(IP_TUNNEL_KEY_BIT, flags);
 		tunnel = ip_tunnel_lookup(itn, skb->dev->ifindex, flags,
@@ -301,7 +303,7 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 	}
 
 	if (tunnel) {
-		if (is_erspan_type1(gre_hdr_len))
+		if (is_erspan_type1(gre_hdr_len, tpi->proto))
 			len = gre_hdr_len;
 		else
 			len = gre_hdr_len + erspan_hdr_len(ver);
@@ -318,6 +320,7 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 		if (tunnel->collect_md) {
 			struct erspan_metadata *pkt_md, *md;
 			struct ip_tunnel_info *info;
+			struct erspan_md2 *md2;
 			unsigned char *gh;
 			__be64 tun_id;
 
@@ -334,19 +337,27 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 			info = &tun_dst->u.tun_info;
 			info->options_len = sizeof(*md);
 
-			/* skb can be uncloned in __iptunnel_pull_header, so
-			 * old pkt_md is no longer valid and we need to reset
-			 * it
-			 */
-			gh = skb_network_header(skb) +
-			     skb_network_header_len(skb);
-			pkt_md = (struct erspan_metadata *)(gh + gre_hdr_len +
-							    sizeof(*ershdr));
 			md = ip_tunnel_info_opts(&tun_dst->u.tun_info);
 			md->version = ver;
-			md2 = &md->u.md2;
-			memcpy(md2, pkt_md, ver == 1 ? ERSPAN_V1_MDSIZE :
-						       ERSPAN_V2_MDSIZE);
+
+			/* Type I has no ERSPAN header, thus no metadata to
+			 * extract: pkt_md would point into the inner Ethernet
+			 * frame just pulled by __iptunnel_pull_header().
+			 * ip_tun_rx_dst() zeroed @md for us.
+			 */
+			if (!is_erspan_type1(gre_hdr_len, tpi->proto)) {
+				/* skb can be uncloned in __iptunnel_pull_header, so
+				 * old pkt_md is no longer valid and we need to reset
+				 * it
+				 */
+				gh = skb_network_header(skb) +
+				     skb_network_header_len(skb);
+				pkt_md = (struct erspan_metadata *)(gh + gre_hdr_len +
+								    sizeof(*ershdr));
+				md2 = &md->u.md2;
+				memcpy(md2, pkt_md, ver == 1 ? ERSPAN_V1_MDSIZE :
+							       ERSPAN_V2_MDSIZE);
+			}
 
 			__set_bit(IP_TUNNEL_ERSPAN_OPT_BIT,
 				  info->key.tun_flags);
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index e61cb10b50dc96295c14aa6da4c9c0fe47151335..774975955747ec4d822b66b8aaaee824c8d331df 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -503,6 +503,8 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 	ipv6h = ipv6_hdr(skb);
 	ershdr = (struct erspan_base_hdr *)skb->data;
 	ver = ershdr->ver;
+	if (unlikely(ver != 1 && ver != 2))
+		return PACKET_REJECT;
 
 	tunnel = ip6gre_tunnel_lookup(skb->dev,
 				      &ipv6h->saddr, &ipv6h->daddr, tpi->key,
-- 
2.55.0.1082.g2b9226bbc0-goog

