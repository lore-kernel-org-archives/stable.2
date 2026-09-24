Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A805C42047E
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 19:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277698; cv=none; b=u/OctgX+t2NYv0JzIT1lTLHZ880lvajFqhI3zXifDRn4sb/bctd+KakeGAPUAjU42qm4kTysycOdLyAOwA3S730RWaL7/EZ8Vr6lrN/b80O19a6i1ZafMStME2GheGcpbEcr70ChOMMTWvKHBKjOQh1nVEP10xHzAtwy3XNbveQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277698; c=relaxed/simple;
	bh=yn4sh0QsLzVpsQNp8F7VfIp7Hhvh2APAq+sRj1qbzlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a7NenZ7VEFALXFcd0LTU5K3OLHmczUu3g/KgMsuLhITO8MEg7szpJ8K6Jx+G+5WcrIoIemVCDMrjxL6dxV00ygYEVgotPKcLchQzYGOJ/QzUdyzZplefzGZU0+/FKKstLKvaw6ihtzjL/rPvWjAvOjlnPU2ML6boQ+Z9Whfg3pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1hZgs7Q; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1hZgs7Q"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-672f5240195so192576d50.0
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 12:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790277694; x=1790882494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yjCPlH/1xjSW8SlKJh+ObV99rbS33tV4zR6iR+FTnfw=;
        b=G1hZgs7QwMBwlT4F/nMi0CYe/0zhSqU1zJQ+Eml3t5zt61PhXyYl/BCYL5UgX7tpaA
         ANwBLf6fA9uvRswvTwEvTQppGXlYZktjqgVwRlrbGO5Mj/fzNGy1xVdDpJQvAY+iR1Vr
         PLCznbVenjj1PfQhh1Jy6X2JQh2QyUZAdXU4CtYnDwolO8YJoRiub0q8lihmA5C7fJuU
         duwn/ibVgxacXuP9ZWw+dkpzo9I0qFYDSk4v5hgtP3yb3jYZgkOPRlX1FJ+8V0fJrvtR
         aXz+Y9z7x054QiE2Dkwnj0RSqsxFPNZQoVBFIHutC7wwi4qto7OAblKiw+jl15IbFy6n
         4B+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790277694; x=1790882494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yjCPlH/1xjSW8SlKJh+ObV99rbS33tV4zR6iR+FTnfw=;
        b=UIv0hSPcBFOs7H4+BopcwctSjErbfpZY4Vvj+zqAByZkwYwFi3aWR9JA9RYgVFigVV
         SBcfa6P0ts+VTMPctF9QLlPAlyTuOWmv3a5duJ9NziTIGrlmpg3eyjuk9oxZgkvksCFF
         mQJwqfhXvaMlmElbzqFa5Il97SXLN/gb5UIMfy+UwFqS6ldzKs5Y+Qi5ghAeYb7FyXh4
         o8QL/iAgnhfx/350sUkA4whMZvGIlLCaNTITP1lP7FoSTDQjQJQK4XCvTiGtDumYkzXY
         WnDJAtBgQukKmCikEbyEGlcdkOyguK/0VSRX71le9qJcjiPNgDCoXYhRul4CJRc1cDKi
         eMvA==
X-Forwarded-Encrypted: i=1; AKwUvBw+0Ch78RlDVPgbzSHUfctv1nV1sUqdicFSIRmArikcyLlgJlvEVPLPyXXiAj4X+1C1b3eFgWM=@vger.kernel.org
X-Gm-Message-State: AFuF++mCqg+w+lnOJDS66OQQcU3SBkqlJCMqMc8s6I4sUHaG8hOxiUkI
	uGUBcOMFGQ1l2relg+C7x/rptX2CBzxtUE3Xlk+hVAtKcMTSVv8yIScL
X-Gm-Gg: AYBFou0KvCrNRkx1AmQd5sIWfSg+2nG8x8cL+vLawEurwGFb9/Ndxu0Kk6EPwk3ezKR
	SJaflxfcGBPJMtxJTVX91sbXcXA3rMzxH7LwfaBocMFvcveonpYCMNmztkDBrFmoreQGZL9zOIh
	FUb/5AaWLODyIacnClmK9Y/GTk670yYnA2WN6WXdbsGMRggVsNZCwQmOa3ysxgU++L0hDWVFvdI
	WJDamQv89Wd/TdRjwmvs7o0MbsL5/m4mFowoP3nrWKow9wKolZm0OZOe1RI6EuxeXUR3n6HgjV9
	5Tz+L9t5HxPzHRykMoKagUx8tN3d3M6j315cwLwGZBn55aUaXf6qqxpeeP7eRcnwq1M3ciO2pt5
	SC35e9oWaZL9wOQWxBIFtXNZ5o8Nl94TL3UMvOiIzW6Uv3JyKjoIgxQui12okx5IQ6LuE2gQLOK
	ZPKI99r11BTG+AY8jv5Q6vECJlDN/3Ep8rgJvyxfDsG2j4ddp1Ygoklw9Tbg9PFnwbV8LwNXGnP
	Mja65H7Mx1i5580XBCDvF2LHEeRKiYzgvfP35QfrB3H9MEClkv1dmNH1YCqaoDotRNKFhCbJ5o=
X-Received: by 2002:a05:690e:4893:20b0:671:3d20:c2de with SMTP id 956f58d0204a3-672ed40d03cmr1429476d50.26.1790277693938;
        Thu, 24 Sep 2026 12:21:33 -0700 (PDT)
Received: from willemb.c.googlers.com.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6740ef28dfasm26892d50.11.2026.09.24.12.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 12:21:33 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	xietangxin@yeah.net,
	Willem de Bruijn <willemb@google.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: extend IPv6 exthdr detection of tunneled packets
Date: Thu, 24 Sep 2026 15:20:37 -0400
Message-ID: <20260924192128.1197118-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Commit c4336a07eb6b ("net: correctly handle tunneled traffic on IPV6_CSUM
GSO fallback") split skb_gso_has_extension_hdr() into mutually exclusive
branches on skb->encapsulation. This did not yet address all paths:

1. With skb->encapsulation set, the outer header is not checked. IPv6
   tunnels such as ip6_gre and ip6_tunnel add an outer Destination
   Options header by default (encap_limit). Their GSO packets skip
   software GSO, then skb_csum_hwoffload_help() sees the outer extension
   header and calls skb_checksum_help() on the GSO skb, which warns and
   drops it.

2. Tunnels over IPv6 without an outer transport header, such as
   ip6_tunnel, leave skb->transport_header at the inner transport
   header. skb_network_header_len() then spans the outer IPv6, tunnel
   and inner IP headers, a false positive.

3. UDP tunnels without an inner network header, such as SCTP-in-UDP or
   PSP, have no inner IPv6 header to check. Decide on the outer header
   alone.

4. Directly dereferencing inner_ip_hdr(skb)->version without
   skb_header_pointer() is unsafe.

Instead, check ipv6_ext_hdr(nexthdr) on the outer IPv6 header and, if
set, on the inner IPv6 header. Read the headers with skb_header_pointer().

Use the same helper in skb_csum_hwoffload_help(). Its open coded test
has the false positive of (2) and ignores the inner header.

Background: checksum offload of tunneled packets invariants:

Non-GSO skb:
- If the inner packet is CHECKSUM_PARTIAL, Local Checksum Offload computes
  the outer checksum in software and the device offloads only the inner L4
  checksum.
- If the inner packet is CHECKSUM_NONE (e.g., SCTP-in-UDP, ESP-in-UDP,
  Remote Checksum Offload), the device offloads the outer UDP or GRE
  checksum instead.

GSO skb:
- A device with NETIF_F_GSO_UDP_TUNNEL_CSUM or NETIF_F_GSO_GRE_CSUM
  computes both inner and outer checksums per segment.
  The outer checksum is seeded with only the pseudo-header checksum.

A NETIF_F_IPV6_CSUM device must parse through the outer headers to
reach the inner ones.

Fixes: c4336a07eb6b ("net: correctly handle tunneled traffic on IPV6_CSUM GSO fallback")
Cc: stable@vger.kernel.org
Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Stable: trees before commit 1676ebba391d ("net/ipv6: Remove jumbo_remove
step from TX path") (v7.0) must keep the BIG TCP jumbo exemption on the
outer check, or BIG TCP loses TSO (see 68e068cabd2c):

	if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
	    !ipv6_has_hopopt_jumbo(skb) &&
	    __skb_has_ipv6_ext_hdr(skb, skb_network_offset(skb)))
		return true;

Tested with gre_gso.sh over veth with NETIF_F_IPV6_CSUM:
- GREv6 without extension headers
- GREv6 with inner dstopts
- GREv6 with outer encaplimit, and
- SCTP-in-UDPv6.

That needs a test-only ethtool feature to veth to advertise
NETIF_F_IPV6_CSUM (mutually exclusive with NETIF_F_HW_CSUM).

If no one objects (to test-only veth code), I can follow up with those
veth and selftest patches to net-next later.
---
 net/core/dev.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 0292a16e16c2..404ea7437b41 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3818,20 +3818,29 @@ static netdev_features_t dflt_features_check(struct sk_buff *skb,
 	return vlan_features_check(skb, features);
 }
 
-static bool skb_gso_has_extension_hdr(const struct sk_buff *skb)
-{
-	if (!skb->encapsulation)
-		return ((skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
-			 (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
-			  vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
-			skb_transport_header_was_set(skb) &&
-			skb_network_header_len(skb) != sizeof(struct ipv6hdr));
-	else
-		return (!skb_inner_network_header_was_set(skb) ||
-			((skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
-			  (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
-			   inner_ip_hdr(skb)->version == 6)) &&
-			 skb_inner_network_header_len(skb) != sizeof(struct ipv6hdr)));
+static bool __skb_has_ipv6_ext_hdr(const struct sk_buff *skb, int nhoff)
+{
+	const struct ipv6hdr *ip6h;
+	struct ipv6hdr _ip6h;
+
+	ip6h = skb_header_pointer(skb, nhoff, sizeof(_ip6h), &_ip6h);
+	return ip6h && ip6h->version == 6 && ipv6_ext_hdr(ip6h->nexthdr);
+}
+
+static bool skb_has_ipv6_extension_hdr(const struct sk_buff *skb)
+{
+	if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
+	    __skb_has_ipv6_ext_hdr(skb, skb_network_offset(skb)))
+		return true;
+
+	/* Tunnels without an inner network header, such as SCTP-in-UDP or
+	 * PSP, have no inner IP header and thus no inner extension header.
+	 */
+	if (skb->encapsulation && skb_inner_network_header_was_set(skb) &&
+	    __skb_has_ipv6_ext_hdr(skb, skb_inner_network_offset(skb)))
+		return true;
+
+	return false;
 }
 
 static netdev_features_t gso_features_check(const struct sk_buff *skb,
@@ -3886,7 +3895,7 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	 * so neither does TSO that depends on it.
 	 */
 	if (features & NETIF_F_IPV6_CSUM &&
-	    skb_gso_has_extension_hdr(skb))
+	    skb_has_ipv6_extension_hdr(skb))
 		features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);
 
 	return features;
@@ -3988,8 +3997,7 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 		return 0;
 
 	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
-		if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
-		    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
+		if (skb_has_ipv6_extension_hdr(skb))
 			goto sw_checksum;
 
 		switch (skb->csum_offset) {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

