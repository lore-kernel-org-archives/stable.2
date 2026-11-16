Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794868994;
	b=TGiWUBLVkSh5u0Xr3hzQWOI7oJ5L7Q+5YgCxNQs+JyK2J9MsUb5lcaU8n5wbvSIFlkzl
	 ZGqt25lklkGpaJ03bbxGjLYWlrM4KwySBioZDee0tNo6XyL500R7sWqtDOaJjDUVaCxa+
	 Z9WZAd47BObpL0lorX6IFFxDyCFonOGGYVc2G2o/RdpXiMDE6dEQX9okXwi12wU4tXTvp
	 vWX4spRrx+1oDzGwoVcqL/Xjum9w7eApxiFGdJ3dsTGLeN4PH09IGkS9rU8VwY/sQH76e
	 GqcDsZxDP5bvH9AwgWmMKlTA80gtuaEIXb7Y55xHdt8fBA9/bkwg6GaM1Q8zR36eZyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794868994;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=kMpo0UJ75TruTVatPvi3CzUYgCxzkdWpyiDhvC9SSik=;
	b=MGcziWuVR6RvAt7WnYY5xAhKlsS115Vb4/Ry4EMW0RGkmIdMt8lehB3otGgs9zqYfdMp
	 Has1GTjeopWCFu158WF7Br9xt1RoJwK9KwwbU4QQMQPvjV+i4Url9ExwA1oiRjoHube7Y
	 xN8gR+xze2NUKse4kLuiuiwhGTIGblaK/jb0ysXmGx/0rvCIilR/0+exbGDEWJS9faAiu
	 AgyCL8OLXhVpVM46JrUoEgJDDooTxnD+SmzT5zM7acEpJTsUIaOlNWwY29BAFDgYhQaDH
	 r0Xr0xjU3Gdh0ocWpXxByVpxAMiGlJJ0EqLyQQFe1SJQbfdRIObrNIeUdt611h1OWnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oWveBScb;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2E2606A881
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 22:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A2E2606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oWveBScb
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ae19907a31so299840a91.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 14:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794868993; x=1795473793; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kMpo0UJ75TruTVatPvi3CzUYgCxzkdWpyiDhvC9SSik=;
        b=oWveBScboc2GJ2HTXjp7u0w8uDrmAAwCZR47rxj1Lx3GEz2TG5/4cIUouXtOKtgz8h
         2dXKlj5kAXkNT9v8j0rE7gieT80yiWm885QDC6j3oWtMytdrSuZRCtDir+3J6WukikJ2
         /bwh4IpXpReXYnVeBt7l2Ve3czfLB0ySnz3tgfD5GeawNYVGVnttaerAgGTOD9EPkFLW
         20mefIa6MM59Y5gZaLqCbtNNCojrJWlq4LaNDC6N7tXtECt07hsRJaN32CWpPmFi/2BE
         LKRyWmjEuhaJuJ/XWQ4S5+lH0P+f1ApX91CgE10Y8G3uIPEfNuqFKss8c/n4kXENohNO
         eYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794868993; x=1795473793;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kMpo0UJ75TruTVatPvi3CzUYgCxzkdWpyiDhvC9SSik=;
        b=RJVDUsHGtnncBOihsRKaVeFgQnGNZRYOCSLyneA1a/189D9x0p5Y9wA6xwV2SS/eol
         gkmsg/gbXhaj4j2qDsr3zvGiM4ShpcGiyUVbSSrhlHy4h3eH5z9ZyX7pn2OUAEbGH9lZ
         4kyb0WVwcZipi0mLLkzC8BafDBsAvXmCC0KxP6nHZk9fqwSeIARjfESfF9WTWa5/M/8U
         I6jK8KqsieiKxkLnUueDctU147I0hS3RnJ8o9S++WZYxfuGb3xzrGGsXpVMOn0j+Zo5g
         RWGSOBK03N559CXsWm/mTxvapnIqYE+5zAhT1rpWXeLvzWYxf8tZdPDqHA/88fCq46GU
         Pt0A==
X-Forwarded-Encrypted: i=1; AL+hErG4eZcABYXEiJt1WN9OWmAZWsB29OX2k/fqPM9Zh2/L8z2laaKMgR+PEDvqMBnLJJWGm2gbulE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+kz9jRso/l8zuRBEgYWjHf8MvcgifdDsHXR5kQZWLPdWiIOb/3
	PN600HXtfNQCSdBqGn9S8bi97lCEFvQA2VwAc82MOLYemApdp9c1sJEbf7c0FPzLEHOBWQNPhVC
	8cZPix5YuilnYvQ==
X-Received: from pjbgz6.prod.google.com ([2002:a17:90b:ec6:b0:3ad:9e7b:240f])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3805:b0:3b0:e388:d9c9 with SMTP id 98e67ed59e1d1-3b3abb360a8mr465559a91.12.1794868992419;
 Mon, 16 Nov 2026 14:43:12 -0800 (PST)
Date: Mon, 16 Nov 2026 14:43:08 -0800
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
Message-ID: <20261116224308.986555-1-joshwash@google.com>
Subject: [PATCH net v2] gve: fix checksum state and gso_segs of HW-GRO packets
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jordan Rhee <jordanrhee@google.com>, Ankit Garg <nktgrg@google.com>, 
	Tim Hostetler <thostet@google.com>, Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Praveen Kaligineedi <pkaligineedi@google.com>
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

The device does not coalesce VLAN tagged frames, so the IP header always
follows the Ethernet header. The IP and TCP header lengths are read from
the packet, so check that the headers are in the linear part before
using them, and drop the packet otherwise.

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

