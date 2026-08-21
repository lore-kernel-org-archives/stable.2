Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5175A437471
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324367; cv=none; b=pGE1P87YjvsjeCBb8FnkGrzO/nAXrqyyazgOC+Dou0Qh5plgOZQAtzjPM4mFd6EZvW1yFnCIyZMnBMQ2TC4UmgfLgTBZMIy4qex4tbu+CHXYaSLFAdwTfTu+5u5ZP5VzMU1u4SMvqQ7IjpOUkMEOUZZXs3GEGvLfj3rJaA8zJa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324367; c=relaxed/simple;
	bh=9UAgssvecrVXWSUZ3HKmo++SEpqBeEK+3PCiqAJaBEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bf9usLqnAmFf/fsmSpXNd3BWf77kOL+bpbf61ktVbZlEoeIAsMklxBJNWoHel5Z1K4nK767an3M/n82F/HvggHkmbTehLnfdCgrzI8E1hpfTsiqwM+4fi9be+LdBR3snT0m+iJNS1OEE5nLOHJr4iIbaJVRiamfTAyJP4kGOXIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLVGPbxt; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLVGPbxt"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84862aaa8bfso19860b3a.2
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 07:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787324365; x=1787929165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JxkK2AwMbV+bDh0AmqGiE2O8c66u1593CZT2vdt564k=;
        b=HLVGPbxtHGiKM1OFqM60UjqcwIHDhJGtgnkMiy3XJJGdLPj9TwhwzAjfG1J2KRV9w0
         agqSvhqevQ6PegLYjkI2e7rZFX5W/wBjr6vniyQzWIPELQDebwL49wxr078z+NbGylsc
         EgQGiYrRtKNWPfkMi7URLYuofY+XFvZco4ZInHPugP4JJIG69F3PJroAi/FWxiNwt05h
         yrhYConc2o422Ar+WvK2Tke0lpW+vrgduGODboR6/fpfzbkgI1NRXoIpCxbvk1s/n8TE
         6Z8VOQcXqiR0Fe+G2DXrtOUD/UKjn0HlKN5xii2D7d6yrlV6NXBjprac3Cvvvm6Gz4mv
         C1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787324365; x=1787929165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JxkK2AwMbV+bDh0AmqGiE2O8c66u1593CZT2vdt564k=;
        b=M1C6gk0vmwPX1LN4nMrQCOngpleOgNtC6ozo3gPTdQfDgJEh1tzX0+wcaY1wiWlmJF
         wzaiWip96f/+g7D2tqb+ZJyt44u4Kat4FPuObj94nmeBC1llrzw27oucLrZPZQjxOK+B
         4N6pyVsBJr7073zPcFcJCRro+uPPm/XlIRWvKKY+hf70hhRJvN4wLj49V5aw6kVXQrLy
         3MrPzbpBJESiB2TxJEhZBNbT14pW9ZeLn4mlkf7tdjrf8J2Bhf6Qa1uxCgwUOjOV6NFR
         lwlk/JZQBV3enf53s3Px5oZ0Ai519aJ9RaELfqMF99UpUKXUDuQry43nhECaXFgSMdkD
         tJPQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq0g2JIt2VZ2lSpIW/mkCp415Zvxc0re4OxfVUr4/TXKJ1jZvVD5YVPzyMoXB2TGh4bVtdHdZ4=@vger.kernel.org
X-Gm-Message-State: AFuF++kx8EOPCb9ubyuKAGTBiBQpifD3hHJP6KtVcpE+sht6gE9x/doS
	C3D5S0rpSL3J07Y5+hkBH4tsjF8W/PZOj4ttx3lejjttfYE4BneSAr45
X-Gm-Gg: AR+sD12Jk3YgL8VmfRPg8J7bAqd/Ku06x6x8mxaLvWRzo0u276hsbow5l0bOlZv1Nkg
	0scIiLisAsNLB1M2w6JsMSX/Zs4/NeP4z40pyk1AYxrtpaHfLN1tbvm0csx83oWKu+JuBD+mkFI
	RF1nRPu316SBC0hayPYW1T4eoh/9Iu377IGXyXgbdld2Bj3wZeSElP1Dzqh/aE7s1+Hkt8Rb4Ch
	3UgSfvCeY5nIoMg/HuxTZs+Q2Xch3HYEsWFZpCDzmd3+Ig8OyBjiqPq51MsUdW4NrNRwFGHhATw
	Bh2arsXn58U0DMRFtEBN9+f//NZ4QBkgyp3GABEmq5g36IDiYc03Wo9RzI6AEpjfEaqIvx0FQVv
	WngILKxkQWz2tiVsXMvBC95IUU4EHEf2G41vb162m0F81LMAWF9k8W4rx5NSKSNjo21xtzvwutz
	U1HieuNNeho2VP3n5h/jp7C1E15DfE8tfX2Dk1VqacLdqtIdjF7QlGKQaTYWFNRdObNe1Z6ut/7
	SW+7lc3U+4nBBF13OsTRf2f6hNQ9QISusKndzeQtxu/hcRYW1gKGgA=
X-Received: by 2002:a17:90b:4f45:b0:38e:91a8:fb85 with SMTP id 98e67ed59e1d1-395c35e7049mr5672279a91.3.1787324364562;
        Fri, 21 Aug 2026 07:59:24 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ac3d1bfsm25248400c88.0.2026.08.21.07.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 07:59:23 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: netdev@vger.kernel.org
Cc: Antoine Tenart <atenart@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] fou: ensure GUE headers have enough headroom
Date: Fri, 21 Aug 2026 22:59:08 +0800
Message-ID: <20260821145908.2829132-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801060115.3538849-1-nicoyip.dev@gmail.com>
References: <20260801060115.3538849-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipgre_changelink() installs GUE encapsulation before it publishes the
new GRE header length and updates dev->needed_headroom.  The transmit
path does not serialize with RTNL, so it can interleave as follows:

  CPU 0 (ipgre_changelink)        CPU 1 (ipgre_xmit)
  install GUE encapsulation
                                  reserve the old needed_headroom
  publish larger GRE flags
  update tunnel->tun_hlen
                                  push the larger GRE header
                                  push the GUE and UDP headers
  update dev->needed_headroom

With REMCSUM, the new layout can push 16 bytes of GRE and 20 bytes of
GUE/UDP headers into an skb with only 32 bytes of actual headroom.  The
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

Make __gue_build_header() ensure space for both the GUE header it is
about to push and the UDP header that follows.  On normally sized skbs
the check is a no-op.  If configuration changes race with transmission,
skb_cow_head() expands the head before either GUE write, or returns an
error without modifying the packet.

skb_cow_head() may move skb->head.  Refresh skb-derived inner_iph
pointers after encapsulation, and read the tunnel fragment and TTL
fields before ip_tunnel_encap() so ip_tunnel_xmit() does not dereference
tnl_params after a possible skb head reallocation.

Fixes: dd9d598c6657 ("ip_gre: add the support for i/o_flags update via netlink")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
Changes in v2:
- Refresh skb-derived inner_iph pointers after ip_tunnel_encap() and read 
frag_off and ttl from tnl_params before ip_tunnel_encap(), because the new
skb_cow_head() in the GUE builder can move skb->head.

Link: https://lore.kernel.org/netdev/20260801060115.3538849-1-nicoyip.dev@gmail.com/ [v1]

 net/ipv4/fou_core.c  | 2 ++
 net/ipv4/ip_tunnel.c | 7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index ab09dfcdecbd..8cf0d43acb41 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -980,6 +980,8 @@ int __gue_build_header(struct sk_buff *skb, struct ip_tunnel_encap *e,
 						skb, 0, 0, false);
 
 	hdrlen = sizeof(struct guehdr) + optlen;
+	if (skb_cow_head(skb, hdrlen + sizeof(struct udphdr)))
+		return -ENOMEM;
 
 	skb_push(skb, hdrlen);
 
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 9d114bd575f9..2bd684eb2ba2 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -606,6 +606,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	if (ip_tunnel_encap(skb, &tun_info->encap, &proto, &fl4) < 0)
 		goto tx_error;
+	inner_iph = (const struct iphdr *)skb_inner_network_header(skb);
 
 	use_cache = ip_tunnel_dst_cache_usable(skb, tun_info);
 	if (use_cache)
@@ -765,8 +766,12 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 			    tunnel->net, READ_ONCE(tunnel->parms.link),
 			    tunnel->fwmark, skb_get_hash(skb), 0);
 
+	df = tnl_params->frag_off;
+	ttl = tnl_params->ttl;
+
 	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0)
 		goto tx_error;
+	inner_iph = (const struct iphdr *)skb_inner_network_header(skb);
 
 	if (connected && md) {
 		use_cache = ip_tunnel_dst_cache_usable(skb, tun_info);
@@ -799,7 +804,6 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		goto tx_error;
 	}
 
-	df = tnl_params->frag_off;
 	if (payload_protocol == htons(ETH_P_IP) && !tunnel->ignore_df)
 		df |= (inner_iph->frag_off & htons(IP_DF));
 
@@ -821,7 +825,6 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	}
 
 	tos = ip_tunnel_ecn_encap(tos, inner_iph, skb);
-	ttl = tnl_params->ttl;
 	if (ttl == 0) {
 		if (payload_protocol == htons(ETH_P_IP))
 			ttl = inner_iph->ttl;
-- 
2.43.0

