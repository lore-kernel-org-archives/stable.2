Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795036850;
	b=k9tysOZthNZu35zEEvbxvmkXRXMmSYfTLu2YtOzynmoLRoyjcRV3EU9N7P8z30iubUkU
	 3snS8SW8IL3pZoCWXdLXF6KDpAxZktIOXvSKU+Jh4aYqGR09E72toANyrcmTKDnEdtf0D
	 7L9cdvRMC/RgQ+ou9gQfPijalzDIRiZB9962xyZUCWXgjQqSFdje91lwYiiBQj3+wwQGr
	 X6hN+9Ev3RTkVhSHxX0jWAqUoASySIjgl/uIHMHUMqrfYKcWG1r7NGLB4jmOWwASmE7uQ
	 J26toLYNzgJYlFu26Sq9UQmgim1C3yIY/NWtzBC2CA8MdZdu0G9H9A/WypKExaNJY7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=BaCRLdzAuoi39HOKcNTVEIs412iZT+l2iPoEW0IR1dE=;
	b=j8oTN+zLvfoM+t/sZ+SOvjCSKqVc/UZLZ/9t7uGHuSsBOIYlgwyoU4XaLbzJQTdQU9am
	 CmYhGNoO4Ng9Tn4aAYCETna1H8jYaEnGNGtK+xw/l2zGlsEof1gpbtgKjaDHOViAqheb+
	 2t5nW8lmFvYIgY2h04tFw9vSUm97xqq4sLGxfJ0p5u0Z7emXaPTNgV5GHk/J3u2NrA4yE
	 HEaqKGc4rojwgufgXgVAAXp4Mwlb4PEy6vm/5zwxH/P0uCF0SrCax22C9MELvn0FVevMt
	 zUAq4Dvd3pQKLURwQhPlYXZbS4uDGBW/tA7575/nlTvL8uI53FkpPu1fXw+BdFN5QPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZbPmtjps;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935DD606A330
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 21:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 935DD606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZbPmtjps
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b0a13ae043so1655487a91.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 13:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795036849; x=1795641649; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BaCRLdzAuoi39HOKcNTVEIs412iZT+l2iPoEW0IR1dE=;
        b=ZbPmtjpsPpJY4jb+VoJmyW0c51SCPuyrYvtoBLhtLPR0e8zL7P6gQxmgNuG50p2DFF
         OgcuzSZIEdNWElALaQDmQMBEb/IbB3Rxm4RCHMX6HEMt5bXVLZLBby7AHyBhF5HEe9ye
         DsT2/7Xk2qG7qLwCovp5iwenD1yoFn/lMkrISjiYoFFQYEQIzOI4KfotITrMeoUaf7Lx
         NeYR4Dlimd30CqLdRK24JVwRodxxFC1EeLCp7gKm5K22LSoHnERccRmbh0RDAPBr5RLE
         9YSvlL7c2vjzoE/+YauQWwJk3Rg7etbZ0jGhgs8t+RGXpXDZ5kWx6HpwNFzzx4zZ0M7g
         SfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795036849; x=1795641649;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BaCRLdzAuoi39HOKcNTVEIs412iZT+l2iPoEW0IR1dE=;
        b=Dk7/Rnwg+VCtaGbEi96s135A0kG7WHQWXL45SZcyDVOeDLE/+nkZIYBiUQJi4gIohp
         iOuOJTvPZEZvdJltrGNxV/NRiJbOSz7769Zu99BDl6mqM7jk+6txQlgdWDYRYmsgXxdz
         IFuzJ8bQsoT4TJAllgftKs+pzQqHXSYPTh+p3bFJOdxqNzld3Zm1Etst8adeo4V59dHd
         6QDhxWG8QUw/cf1tJRyYxXfCSOmXsQXgS6hX7WpXdwzxbvN2ecy65NFecZkhwv8/oAzp
         Lnzssdmodv5VDb3+YSYIZSyZwAWYTiUm/obOj7mnraDRrNCzphXmZ3n8y/6W5oFtMf4T
         pqxw==
X-Forwarded-Encrypted: i=1; AL+hErHLHlSG0cd+flVH/IEGDtOb7J+mdVu/6OPcldim5/xozPPYVX/EDk09SLBBTPTqXGoslkWFob0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+eMrKumFdPeatc3Xf/M8IjUJSwa/2V2tsJINEWSXiCL6Lr8Hy1
	99OsUv+49ifouUwUktHlTDN9y6FkmmWCjO2QwweIPCTrH0bEGLHLZ7f1JE0nrA30gnx4OLsMpYM
	JzU2Zsi0mnyCitw==
X-Received: from pjbbb19.prod.google.com ([2002:a17:90b:93:b0:3b1:15d2:6bd3])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3b8a:b0:3b0:9e42:b67c with SMTP id 98e67ed59e1d1-3b3d07c727emr3909499a91.61.1795036848539;
 Wed, 18 Nov 2026 13:20:48 -0800 (PST)
Date: Wed, 18 Nov 2026 13:20:45 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261118212045.3575303-1-joshwash@google.com>
Subject: [PATCH net v3] gve: fix checksum state and gso_segs of HW-GRO packets
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jordan Rhee <jordanrhee@google.com>, Ankit Garg <nktgrg@google.com>, 
	Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ankit Garg <nktgrg@google.com>

With HW-GRO enabled, gve_rx_complete_rsc() turns a coalesced packet into
a GSO skb by setting gso_size, gso_segs and gso_type, but leaves it
CHECKSUM_UNNECESSARY with th->check as the device wrote it. Unlike
tcp4_gro_complete() and tcp6_gro_complete() for a SW-GRO packet, it does
not seed th->check with the TCP pseudo-header checksum or set
CHECKSUM_PARTIAL.

The GRO stack completes a HW-GRO skb itself only if it holds the skb for
merging (since commit 5eddb24901ee ("gro: add support of (hw)gro packets
to gro stack")). Otherwise the skb is delivered as is, e.g. with rx-gro
off or for a packet that is flushed immediately (e.g. with PSH set). If
such an skb is forwarded out of a TSO-capable device, netif_needs_gso()
accepts it as CHECKSUM_UNNECESSARY and the device segments it with a
bogus checksum seed, so every segment is dropped by the receiver. This
blackholes forwarded TCP traffic on VMs acting as routers or NAT
gateways and was observed on VMs in real use.

Fix it in a manner consistent with other drivers with HW-GRO: set the
network and transport headers and, for packets whose checksum the device
verified, seed th->check with the pseudo-header checksum and call
tcp_gro_complete(), passing gso_segs through NAPI_GRO_CB(skb)->count.
skb->data points at the Ethernet header on the napi_gro_frags() path and
at the IP header on the header-split and copybreak paths, so account for
that when setting the network header. Since the header layout now
matters, tell IPv4 from IPv6 by the EtherType, as qede and bnx2x do,
rather than by the packet type.

The device only coalesces TCP directly over IPv4 or IPv6, without VLAN
tags, IPv6 extension headers or encapsulation, so the IP header always
follows the Ethernet header and the TCP header always follows the IP
header. The IP and TCP header lengths are read from the packet, so check
that the headers are in the linear part before using them, and drop the
packet otherwise.

Also compute gso_segs from the TCP payload length. It was computed from
skb->data_len, which is 0 for a packet that rx_copybreak copied whole
into the linear part, leaving such packets with gso_segs 0 and a
non-zero gso_size. Such small packets usually carry a single segment, so
deliver a packet with at most one segment of payload as a non-GSO skb.

Fixes: e637c244b954 ("gve: Advertise NETIF_F_GRO_HW instead of NETIF_F_LRO")
Cc: stable@vger.kernel.org
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Signed-off-by: Ankit Garg <nktgrg@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
Changes in v3:
- Document that the device only coalesces TCP directly over IPv4/IPv6,
  without VLAN tags, IPv6 extension headers or encapsulation (Sashiko)
- Link to v2: https://lore.kernel.org/netdev/20261116224308.986555-1-joshwash@google.com/

Changes in v2:
- Check that the IP and TCP headers are in the linear part before
  using them (Eric Dumazet)
- Note in the changelog that the device does not coalesce VLAN tagged
  frames (Eric Dumazet)
- Do not mark packets with at most one segment of payload as GSO
- Link to v1: https://lore.kernel.org/netdev/20261113195553.2220562-1-joshwash@google.com/

 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 84 ++++++++++++++++----
 1 file changed, 68 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 82ed5e48b00a..b4dbfb1ba39b 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -13,6 +13,7 @@
 #include <linux/ipv6.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
+#include <net/gro.h>
 #include <net/ip6_checksum.h>
 #include <net/ipv6.h>
 #include <net/tcp.h>
@@ -1000,13 +1001,34 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 	return -ENOMEM;
 }
 
+/* Prepare a HW-GRO packet the way tcp4/6_gro_complete() prepare a SW-GRO
+ * packet, so that it can be resegmented by GSO or TSO if it is forwarded:
+ * seed th->check with the TCP pseudo-header checksum and set CHECKSUM_PARTIAL.
+ */
+static void gve_rx_fixup_gro_checksum(struct sk_buff *skb)
+{
+	int len = skb->len - skb_transport_offset(skb);
+	struct tcphdr *th = tcp_hdr(skb);
+
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4)
+		th->check = ~tcp_v4_check(len, ip_hdr(skb)->saddr,
+					  ip_hdr(skb)->daddr, 0);
+	else
+		th->check = ~tcp_v6_check(len, &ipv6_hdr(skb)->saddr,
+					  &ipv6_hdr(skb)->daddr, 0);
+
+	NAPI_GRO_CB(skb)->count = skb_shinfo(skb)->gso_segs;
+	tcp_gro_complete(skb);
+}
+
 static int gve_rx_complete_rsc(struct sk_buff *skb,
 			       const struct gve_rx_compl_desc_dqo *desc,
 			       struct gve_ptype ptype)
 {
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
-	int rsc_segments, rsc_seg_len, hdr_len;
+	int rsc_seg_len, hdr_len, nhoff, thoff, gso_type, payload;
 	skb_frag_t *frag;
+	__be16 proto;
 	void *va;
 
 	/* HW-GRO only coalesces TCP. */
@@ -1017,20 +1039,11 @@ static int gve_rx_complete_rsc(struct sk_buff *skb,
 	if (!rsc_seg_len)
 		return 0;
 
-	switch (ptype.l3_type) {
-	case GVE_L3_TYPE_IPV4:
-		shinfo->gso_type = SKB_GSO_TCPV4;
-		break;
-	case GVE_L3_TYPE_IPV6:
-		shinfo->gso_type = SKB_GSO_TCPV6;
-		break;
-	default:
-		return -EINVAL;
-	}
-
 	if (skb_headlen(skb)) {
-		/* With header-split, payload is in the non-linear part */
-		rsc_segments = DIV_ROUND_UP(skb->data_len, rsc_seg_len);
+		/* With header-split or copybreak, eth_type_trans() has already
+		 * pulled the Ethernet header.
+		 */
+		nhoff = 0;
 	} else {
 		/* HW-GRO packets are guaranteed to have complete TCP/IP
 		 * headers in frag[0] when header-split is not enabled.
@@ -1039,7 +1052,6 @@ static int gve_rx_complete_rsc(struct sk_buff *skb,
 		va = skb_frag_address(frag);
 		hdr_len =
 			eth_get_headlen(skb->dev, va, skb_frag_size(frag));
-		rsc_segments = DIV_ROUND_UP(skb->len - hdr_len, rsc_seg_len);
 		skb_copy_to_linear_data(skb, va, hdr_len);
 		skb_frag_size_sub(frag, hdr_len);
 		/* Verify we didn't empty the fragment completely as that could
@@ -1049,10 +1061,50 @@ static int gve_rx_complete_rsc(struct sk_buff *skb,
 		skb_frag_off_add(frag, hdr_len);
 		skb->data_len -= hdr_len;
 		skb->tail += hdr_len;
+		/* napi_gro_frags() pulls the Ethernet header later. */
+		nhoff = ETH_HLEN;
+	}
+
+	/* The header lengths come from the packet, so make sure the headers are
+	 * in the linear part before reading them and writing th->check.
+	 */
+	if (unlikely(skb_headlen(skb) < nhoff + sizeof(struct iphdr)))
+		return -EINVAL;
+
+	skb_set_network_header(skb, nhoff);
+	proto = nhoff ? ((struct ethhdr *)skb->data)->h_proto : skb->protocol;
+	switch (proto) {
+	case htons(ETH_P_IP):
+		gso_type = SKB_GSO_TCPV4;
+		thoff = nhoff + ip_hdrlen(skb);
+		break;
+	case htons(ETH_P_IPV6):
+		gso_type = SKB_GSO_TCPV6;
+		thoff = nhoff + sizeof(struct ipv6hdr);
+		break;
+	default:
+		return -EINVAL;
 	}
+	if (unlikely(skb_headlen(skb) < thoff + sizeof(struct tcphdr)))
+		return -EINVAL;
+	skb_set_transport_header(skb, thoff);
+	if (unlikely(skb->len < thoff + tcp_hdrlen(skb)))
+		return -EINVAL;
+
+	/* With at most one segment of payload, this is not a GSO packet. */
+	payload = skb->len - thoff - tcp_hdrlen(skb);
+	if (payload <= rsc_seg_len)
+		return 0;
+
+	shinfo->gso_type = gso_type;
 	shinfo->gso_size = rsc_seg_len;
-	shinfo->gso_segs = rsc_segments;
+	shinfo->gso_segs = DIV_ROUND_UP(payload, rsc_seg_len);
+
+	if (!IS_ENABLED(CONFIG_INET) ||
+	    unlikely(skb->ip_summed != CHECKSUM_UNNECESSARY))
+		return 0;
 
+	gve_rx_fixup_gro_checksum(skb);
 	return 0;
 }
 

base-commit: aa40afa831ebfe45e40a23721711059f2ac584d4
-- 
2.56.0.679.gc527c65306-goog

