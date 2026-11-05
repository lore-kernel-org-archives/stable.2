Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793842705;
	b=3SitAxwRXTQ+JpYDJCsyzNNjFdhRdbvl4NaIEG9dNiMr8RZWMT5by8nC9aSeWd+tX9oo
	 Dwu3CR9VrVI0BtrI9Mevap6QQO4nCQRxS8VOkHIDTqdocNUktxB9T9mV1OuEK/zPK/AV/
	 kNYKl4zevDpbIlW3FSanK42fnZI6r4wn49MIxgA1zhKaEwpW3vTg071j8jeQF0saXZLSj
	 tMEbDQIUNbqZl1CIkkoSV2ThtTykO/q+wifxxJtypdB9Y0wPqZtwH3jlXmpgSmWj7bF74
	 QDB8eqBxa+t7X8orTGEmNxxfYso78Y63Lz15YLoxLaOdJ7Hz5va4dJS7qYvbKChMfFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793842705;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=PYoK7IOx3F0nI2gfYwcMhkpLJaOilddpuA8ldS6uI+U=;
	b=g2buFKJFNf/edvK3l4I1HkR6r9wTV2/cMOFwAPyKUXuiPDoZjL1vaspjIsgVfLN05mWe
	 auuOEpt1L6TXFI3DLntTyw17E4ItixV1uiP63oNYM7oKtuaEZj3sfTK2rJvNfsxyqC21o
	 uNE1XG9PFmLS2wsDNVbi3Q7emarg90IXzXKhMJRA9rlzscEBVfjZP8/Paose2vQC7RLeu
	 0s87oV6YvxuEWhtXJr1vao9lTdQ2Q9GNeSCMhEFADZLrUE8IiTYr9X4cdalyFvmAzANYs
	 GTc9KiHHCiz46xKu/Un4WCSM2e10Mzpy5D6aWHO+a68SAfmr74iuhBe3OCc5XIG7/Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WsJcpGRF;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD9E606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 01:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FD9E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WsJcpGRF
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1ae18eb9b69so1338478c88.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 17:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793842704; x=1794447504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PYoK7IOx3F0nI2gfYwcMhkpLJaOilddpuA8ldS6uI+U=;
        b=WsJcpGRF04R9cZo/d1V2/ZMXEu0wWoVpRiloIGyDUvrw55q7nyOU5vOjDSuz4A0L1R
         Sb0ArZIU2IhDTBxz9ME2eg7MDcO8Kiq8sz3SabXem6+hsi1yw4X0HZqUzE/DB7PTtmGs
         72tIDfwh+sNgwHNJYLNRZC4/AehaoZkJazDjDmMQREoriJ6YfslXfBSyVmz05YFPSOEt
         TmY3tQH5Dg+fZQ6BkwhzH1T1ZMhX2JvgCAz86Rl5ETL83fekwa4e4ufBzgbs4BEKemdt
         W5HaB+r4NtJGTS4+zN7petizpaB1RrxIdWwVIlIili9ZIuLme5a+O40HlK1bvQn5jDXK
         WY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793842704; x=1794447504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PYoK7IOx3F0nI2gfYwcMhkpLJaOilddpuA8ldS6uI+U=;
        b=Axw8gIJm1NgO6T7Pj/0nUbVHtxe/+vmPX5yzzpUP7onc867xpc6z0Msd3DiuXEGA+X
         O5CSs2Tjx04Qd9rQ5D46EvdtMq0ZYbo7acs+xRCxk3cJegSxHg5mTpXdgGqg09uvggLG
         nNCZ1GHxOKds/L+x95CnCZoNprMHE5BT7id4fROvB9A0lOLWD+sFruiYnlBDhxJboLaO
         G3OqySoNYAqWMXJRNlN5SMUBqz9W9QQANMQpg+XkL5oSLLXB6DZwhrF1fS1JkI96jKNH
         8Vpa4k49/eznpwYg3FdL/7UG0h3GDuS5VhuZIbGgLZG44GQ2d24naOcu2ShlqDqFE074
         JarQ==
X-Gm-Message-State: APuU4Z/1S2NNLuYkzfw3y3V/Xpwjtl5LLI8DthkXM21HcBrfSjxJZcIE
	1pdW1W1Nk+MWQk/NjPd9VjmMWm8A4odVnkBnQGJtHwAM+Ihp6N/5i2d7Fx+cXo1n
X-Gm-Gg: AYBFou0L1eV+C6+Kowpp74vUgAk/17VKsvFnvOptG3eZ9MlYIbW/G+ud680OMNJnlKy
	MjJUaEmFaLKdTaXNc/JN+iRLjcY2ooelPkb0n7DnODy1rVRnbR0pgWzo57Q0KYh+nE4Bk0sXMsl
	bxAzpjVtuGtj2hSy6uqcmLybf/lZ7YmglTo8JiTbaqRMaUFlFgMSQm3Q3USZA1Hq2SjtipsX5Oz
	JNpxz3FP52u8G6mWeaEuuLqmUWJ8MzEquOljnuQii6TIYmGo60SO71J9paL441mKynNTUNBrnOJ
	NtQWqexh+FWXFyrjejXKYL9r3Nj0kn1uSj8pvmw4V6ku3sG/E6L8SycEOlaugRV3fiCiIDHIpET
	cMfnQuApg1WdNrSv0EROmUA5gumhS8qa5a1YBNpx5BY2Q5WQujWhehQ07XTDxvkuS1UKKiZf8QG
	NzHdHkHly87nlg2gLTfd+uXyouTbU+Mxlu22q+INvc52IQym4xnCqAI1SItZN8vkkaWSLD9G6TR
	3mkGqQ/WMHcNRuKMvqJ5XDyyiofsHCn9A0svRGfwk6hyhAlPc2br42Xh2u0gzqXbLGlcwfaQSZB
	Q15wSG5jcOVzsKhBznmppNOvm8fZXpMtjBk762xD21Ck+gcfg4Q=
X-Received: by 2002:a05:701b:42d1:20b0:156:6676:d0e2 with SMTP id a92af1059eb24-1ac5cb1aed7mr27544273c88.10.1793842704050;
        Wed, 04 Nov 2026 17:38:24 -0800 (PST)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c2de58sm11114180c88.12.2026.11.04.17.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 17:38:23 -0800 (PST)
From: Matt Vollrath <tactii@gmail.com>
To: stable@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	Sasha Levin <sashal@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH 6.1.y] net: extend IPv6 exthdr detection of tunneled packets
Date: Wed,  4 Nov 2026 20:38:15 -0500
Message-ID: <20261105013815.2613225-1-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit 5f0764cb1c81a9712bce605d38efe6d844a70b29 ]

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
Keep the skb_network_header_len() check when !skb->encapsulation to also
catch encapsulated packets without skb->encapsulation (e.g., virtio).

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
Link: https://patch.msgid.link/20260926140506.2335137-1-willemdebruijn.kernel@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ sashal: kept the !ipv6_has_hopopt_jumbo() exemptions; this tree still inserts the BIG TCP HBH jumbo header ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Matt Vollrath <tactii@gmail.com>
---
Please consider this for 6.1.y. It is the 6.6.y version of
5f0764cb1c81 (fdbd83c2d929e in 6.6.160), which applies cleanly to
6.1.191. Upstream's version conflicts because 6.1.y still has the BIG
TCP jumbo exemptions.

6.1.y has commit 864e3396976e ("net: gso: Forbid IPv6 TSO with
extensions on devices with only IPV6_CSUM") and c4336a07eb6b, but not
this fix, so its guard still decides "has extension headers" from
transport_header. For forwarded IPv6 TCP with a destination options or
routing header, ip6_rcv_core() leaves transport_header just past the
fixed header. The guard then keeps TSO6, validate_xmit_skb() resets the
header from csum_start, and skb_csum_hwoffload_help() calls
skb_checksum_help() on the GSO skb, which WARNs in
skb_warn_bad_offload() and drops it. The flow stalls, and with
panic_on_warn the first such skb panics the host.

This affects any egress device with IPV6_CSUM and TSO6 but not HW_CSUM
(ena, mana, hv_netvsc, xen-netfront, bnxt, tg3 and others). Any sender
whose traffic the host forwards can trigger it, including an
unprivileged process in a container on the host, since a type 4 routing
header set with IPV6_RTHDR needs no privilege. A reproducer exists and
is available on request.

Tested in QEMU on 6.1.191, forwarding through a test device with
IPV6_CSUM and TSO6. A TCP flow with destination options moved 2.9 MB
in 3 s with 10 WARNs and 410 drops before this patch, and 2.9 GB with
none after it. GRO-built and routing header flows behave the same, and
forwarded traffic without extension headers is unchanged.
---
 net/core/dev.c | 49 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 7c0d0905dd31b..ea6785052e8cf 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3592,20 +3592,36 @@ static netdev_features_t dflt_features_check(struct sk_buff *skb,
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
+	if (vlan_get_protocol(skb) == htons(ETH_P_IPV6)) {
+		if (__skb_has_ipv6_ext_hdr(skb, skb_network_offset(skb)))
+			return true;
+
+		/* Catch tunnels without skb->encapsulation (e.g., virtio). */
+		if (!skb->encapsulation &&
+		    skb_transport_header_was_set(skb) &&
+		    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
+			return true;
+	}
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
@@ -3654,7 +3670,7 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	 * so neither does TSO that depends on it.
 	 */
 	if (features & NETIF_F_IPV6_CSUM &&
-	    skb_gso_has_extension_hdr(skb) &&
+	    skb_has_ipv6_extension_hdr(skb) &&
 	    !ipv6_has_hopopt_jumbo(skb))
 		features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);
 
@@ -3757,8 +3773,7 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 		return 0;
 
 	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
-		if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
-		    skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
+		if (skb_has_ipv6_extension_hdr(skb) &&
 		    !ipv6_has_hopopt_jumbo(skb))
 			goto sw_checksum;
 
-- 
2.43.0

