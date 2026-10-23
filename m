Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792738400;
	b=F84zH0+xGdd5Q4vm4MrPLf8cnHRr+zBVeADQ3XEcWGxeCu1EGm0AXt+ZUDTLB2fQi49M
	 jZ92jCVVokRuI2Mh9Nq0uRleVDD42lJYPFBsti41drXq0UaVXP1jeY7YG4nglGHOPgIxu
	 XA3Xv2qoTH68irKwEYAlA6L/X2VELTAQ5zdRXCUEgvfp33kXV5FkEJFchz1/tsvuZpQoB
	 /OC9P7q5mIoZWUCXbPPzXa7fIi4mm/iBOCpW8wAkF72pvsAUWr0K8RjZSy90MZivX5jOu
	 G0r7sjZv8B47BGzRgvj1wq0qhxvYvYgjLOqb6g0FWEYuDbCVojF1SYqC84eD8r02k2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792738400;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rVRNnDLDDIW+sRfhuCbABetubfb2eyFKmWznRnHIsoc=;
	b=Z5fSyxf3RDn+yp+8zO2y1/jBoItt3NdJxi8Dabi83Qn0Qy8LtV59YokuyIiJdEQ5jKek
	 3wA8URMwma/EdhC5aFNuBhTEqmJezngXFjCQPZVEDmM/tpIh4LXtKHOH4g7V1rrqqNkM9
	 SAoWpcvESWHS7xqNqZB/GsY5IMze089rBCyB0E15dHc4tc2Fd2l2jG2WRlb4ahCbscffp
	 M/5SAE0LK3jCLAAuhjcgXpzzuZn71yQZ0L+c5QMatvsS7OOnpA1KHn+f6TXJixjG+Lta8
	 NUUgLJX0GHqnPXAfKedDjswUSQw3DYxU1+/iuZuV8L5G1OzedRQ3VVxmZnO7y+a6Fmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="U/EOK7fA";
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6102606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 06:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6102606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U/EOK7fA
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso3217615ad.1
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 23:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792738399; x=1793343199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rVRNnDLDDIW+sRfhuCbABetubfb2eyFKmWznRnHIsoc=;
        b=U/EOK7fAC66nKGMcSF6e7r3Hz7zvk1fQrc/o+kdyEjDojVsyNAft4iQXkXF8NY8WZJ
         IJv5ioTxgYXHL1vYgTITBcaVDczXsGhNgs5IYuhXcY+8D7bfuw/qhSqoTtwu1t3WOzv3
         WaOdBEO+QbNnAAJTIxtFTBLKaqa1RY53q/sohUEW0MDv+kxY6HcwTQeo1uGXrMnLRzvH
         hCCEe8mMYLUfiJUGbPo4WGYoEEwq6VWKR/DmG2hr/D/t/SfenYYyMAQUC+coUbYnulwr
         8f8dESYeUSlTnqdkg9F2phM5nKYIgBeR3O1Gy/Uyl8c1LSbFAaHifxfkdWXXLA+6g8IO
         DHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792738399; x=1793343199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rVRNnDLDDIW+sRfhuCbABetubfb2eyFKmWznRnHIsoc=;
        b=h8ZIQHl+U0LZxl5vU4mX7UxekDeJlkC/MbxLK114aHwHKTeRUNCvtukth0HICiKzq2
         GjqMhSRTz4rKAEXmR92/V7YrH5XP8K5Kb2LhhAqrUJiC0CCJ8sYheq8mHlfdG8cutUEa
         4GPBhhFQFhItbbDI73clveWqobsJpFngd1UHd6W4HsTWoeuFBF+GtD1akiywwHa9n0FD
         6SIwuA5Vuss3+aKP8ttzD8LVYHoINlzdM/n4bfCPbHh27PKVlDYpaLHKSkIf5l8TMxMU
         YYq9DRyioWkQwfRRgu0FwvOyO91IZSYBwiKA2VgwoCefelOgpYXb0zkqCWp4QfF9ieMy
         O4Rg==
X-Forwarded-Encrypted: i=1; AKwUvBz7lRSeVEFZMUuA4C4Tu/9/9hHLbb8BrTZXjY7aX7EDaBEm5JicPW1DkxZctXcS7ob8Fkk6pT0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLxQMTuB5v0sV13zaj9GYcpQ3Ccra33FaSVlcb/ggycwYK/C60v
	tfbc0hgnOkPPb7byVmOLBbxvz6DHdgXuCUw/P834ri04rLK8RA/b1mEa
X-Gm-Gg: AYBFou3W6a+HyfzxzHFg2pvr2CMt2Ye0o29bgGFjii7jC9hq+HCDmCEa1XQIlm4ORLl
	6YgaPC2r9PHRzc5EhiugFXVss74Ee39qQ+UuJHM8/r6HIZN0JvN6QxyJZre0z9TRsnvZ5B57a8t
	b7nKniNh7pDVOWlrZAiwqx4g9807f4K4vZAT3N/pwwX+2QzaqgLfFA/nTDXDjNwnYSona6/9Z3x
	H089eShFHERSqyZgNzdS7a7kLpn/y5RxMLRbzadhvyEBbZf6dZ8j5mqf+WwwhgaCRyBgUdkaZ9M
	NiB/a59q0i03M0oTxDKbejV8Aig6ac9JXFFqC2nB0vnaUkThWFhx+XKx8IXxvnyUtj1urdr2ap1
	ZY9i+e+dh8OfNFML73LhU34BHX14eRkckkAvcxmTz77d7i3O6HwwZnvIHpieE1ftdvRCAKtxW1v
	T2g5oIQzRWGGt8StKbrbZbZfyNFNqmi7gAC3IbD0C7NKRphl295f0hAocgJzifEQ3l9VWfJt/ia
	D5gn4TPtOwDDooHT+r0FqT31EzLwd/pTie2NGd+62JeNE1lMLODWzwW7BuZVfYvRITr9ByWDVdt
	QPYdyontiD3mD/AeZohD/5DgBoNj7Id/hKoL2loSb/E5wA==
X-Received: by 2002:a17:902:ce82:b0:2e8:486d:fa00 with SMTP id d9443c01a7336-2ea7c153a0fmr16407985ad.29.1792738398990;
        Thu, 22 Oct 2026 23:53:18 -0700 (PDT)
Received: from localhost.localdomain (ip67.244-167-222.hkg.ten111.net. [222.167.244.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea7b3dd597sm6164065ad.62.2026.10.22.23.53.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 22 Oct 2026 23:53:18 -0700 (PDT)
From: Guoshuai Yang <yangguoshuai@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Guoshuai Yang <yangguoshuai@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3] xfrm: esp: reset outer TCP GSO metadata on espintcp input
Date: Fri, 23 Oct 2026 14:53:11 +0800
Message-ID: <20261023065311.65031-1-yangguoshuai@gmail.com>
X-Mailer: git-send-email 2.54.0
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

When ESP packets are received over TCP (RFC 8229 espintcp), strparser
slices individual length-prefixed ESP records from the outer TCP stream by
cloning the incoming TCP skb(s) in __strp_recv().

If the outer TCP skb was GRO-coalesced before reaching strparser, its
skb_shinfo carries the outer TCP stream's GSO metadata (gso_size, gso_segs,
and gso_type). When an ESP record spans two outer TCP segments, strparser
chains the spillover clone onto skb_shinfo(head)->frag_list.

Subsequently in esp_input() and esp6_input(), skb_cow_data() unshares the
head skb via pskb_expand_head() (preserving the outer TCP gso_size and
gso_type in the new private skb_shinfo) and calls skb_copy() on each cloned
frag_list member, which copies the outer TCP GSO fields via
skb_copy_header() onto a linear frag_list child skb allocated from slab
with head_frag == 0.

Furthermore, if an outer TCP GRO aggregate carried SKB_GSO_FRAGLIST (e.g.,
when rx-gro-list is enabled) and was chained onto
skb_shinfo(head)->frag_list by __strp_recv(), skb_cow_data() invokes
skb_copy() / skb_copy_expand() on that frag_list member and hits
WARN_ON_ONCE(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST), failing with
-ENOMEM before decryption even begins.

After ESP decryption and header removal, the resulting single inner packet
still has skb_is_gso(skb) == true with the stale outer TCP gso_size, while
skb_headlen(head_skb) is now smaller than that gso_size due to stripping
the outer framing and ESP header. When this packet passes through
gro_cells_receive() (which flushes frag_list packets via GRO_NORMAL
without resetting gso_size) and is forwarded, validate_xmit_skb() invokes
tcp_gso_segment() -> skb_segment(). Because head_skb is shorter than the
stale gso_size and SKB_GSO_DODGY is not set, skb_segment() attempts to map
the slab-backed frag_list member as a scatter-gather page fragment and hits
BUG_ON(!list_skb->head_frag):

  Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
  PC is at skb_segment+0x574/0xd20
  LR is at skb_segment+0x884/0xd20
  Call trace:
   skb_segment from tcp_gso_segment
   tcp_gso_segment from inet_gso_segment
   inet_gso_segment from skb_mac_gso_segment
   skb_mac_gso_segment from __skb_gso_segment
   __skb_gso_segment from validate_xmit_skb
   validate_xmit_skb from __dev_queue_xmit
   __dev_queue_xmit from ip_finish_output2
   ip_finish_output2 from ip_output
   ip_output from ip_sublist_rcv_finish
   ip_sublist_rcv_finish from ip_sublist_rcv
   ip_list_rcv from __netif_receive_skb_list_core
   __netif_receive_skb_list_core from __netif_receive_skb_list
   __netif_receive_skb_list from gro_normal_list
   gro_normal_list from gro_cell_poll

Similarly, if a decrypted inner packet with a frag_list later takes the
ip_do_fragment() frag_list fast path, each detached frag_list member is
transmitted as a standalone IP fragment and would still carry the stale
outer TCP GSO state when reaching validate_xmit_skb(). And even when an
ESP record does not have a frag_list, leaving the stale outer TCP gso_size
on the decrypted inner skb prevents dev_gro_receive() from initializing
gso_size to the inner packet's skb_gro_len().

We cannot reset GSO state earlier in espintcp_rcv() / handle_esp() because
the skb may still be a clone sharing skb_shinfo with the outer TCP skb held
by strparser. Instead, in esp_input() and esp6_input():
1. Prior to skb_cow_data(), unshare/unclone and reset GSO metadata on any
   frag_list member carrying SKB_GSO_FRAGLIST so skb_copy() /
   skb_copy_expand() inside skb_cow_data() does not hit WARN_ON_ONCE() and
   drop the packet.
2. At skip_cow, where the head skb and all frag_list members are guaranteed
   to be uncloned with private skb_shinfo, call skb_gso_reset() on both the
   head skb and each skb_walk_frags() member.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Cc: stable@vger.kernel.org
Signed-off-by: Guoshuai Yang <yangguoshuai@gmail.com>
---
v3:
  - Unshare/unclone and reset GSO metadata on any frag_list member carrying
    SKB_GSO_FRAGLIST before skb_cow_data() so skb_copy() / skb_copy_expand()
    does not hit WARN_ON_ONCE(SKB_GSO_FRAGLIST) and return -ENOMEM.
  - Move the shared espintcp GSO reset helpers into include/net/esp.h.
  - Link to v2: https://lore.kernel.org/netdev/20261020030450.7170-1-yangguoshuai@gmail.com/
v2:
  - Also call skb_gso_reset() on each skb_walk_frags() member at skip_cow
    in esp_input() and esp6_input() so detached frag_list members on the
    ip_do_fragment() fast path do not retain stale outer TCP GSO state.
  - Specify target tree 'net' in subject prefix.
  - Link to v1: https://lore.kernel.org/netdev/20261018005218.53267-1-yangguoshuai@gmail.com/
 include/net/esp.h | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/esp4.c   |  9 +++++++++
 net/ipv6/esp6.c   |  9 +++++++++
 3 files changed, 69 insertions(+)

diff --git a/include/net/esp.h b/include/net/esp.h
index 3229507..09ed682 100644
--- a/include/net/esp.h
+++ b/include/net/esp.h
@@ -28,6 +28,57 @@ static inline void esp_output_fill_trailer(u8 *tail, int tfclen, int plen, __u8
 	tail[plen - 1] = proto;
 }
 
+static inline int esp_reset_espintcp_fraglist_gso(struct sk_buff *skb)
+{
+	struct sk_buff **fragp;
+	struct sk_buff *frag;
+
+	skb_walk_frags(skb, frag) {
+		if (skb_shinfo(frag)->gso_type & SKB_GSO_FRAGLIST)
+			break;
+	}
+	if (!frag)
+		return 0;
+
+	if (skb_unclone(skb, GFP_ATOMIC))
+		return -ENOMEM;
+
+	for (fragp = &skb_shinfo(skb)->frag_list; (frag = *fragp);
+	     fragp = &frag->next) {
+		if (!(skb_shinfo(frag)->gso_type & SKB_GSO_FRAGLIST))
+			continue;
+
+		if (skb_shared(frag)) {
+			struct sk_buff *nfrag;
+
+			nfrag = skb_clone(frag, GFP_ATOMIC);
+			if (!nfrag)
+				return -ENOMEM;
+
+			nfrag->next = frag->next;
+			consume_skb(frag);
+			frag = nfrag;
+			*fragp = frag;
+		}
+
+		if (skb_unclone(frag, GFP_ATOMIC))
+			return -ENOMEM;
+
+		skb_gso_reset(frag);
+	}
+
+	return 0;
+}
+
+static inline void esp_reset_espintcp_gso(struct sk_buff *skb)
+{
+	struct sk_buff *iter;
+
+	skb_gso_reset(skb);
+	skb_walk_frags(skb, iter)
+		skb_gso_reset(iter);
+}
+
 struct esp_info {
 	struct	ip_esp_hdr *esph;
 	__be64	seqno;
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index e76db58..92980cd 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -893,6 +893,12 @@ static int esp_input(struct xfrm_state *x, struct sk_buff *skb)
 		}
 	}
 
+	if (x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP) {
+		err = esp_reset_espintcp_fraglist_gso(skb);
+		if (err)
+			goto out;
+	}
+
 	err = skb_cow_data(skb, 0, &trailer);
 	if (err < 0)
 		goto out;
@@ -900,6 +906,9 @@ static int esp_input(struct xfrm_state *x, struct sk_buff *skb)
 	nfrags = err;
 
 skip_cow:
+	if (x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
+		esp_reset_espintcp_gso(skb);
+
 	err = -ENOMEM;
 	tmp = esp_alloc_tmp(aead, nfrags, seqhilen);
 	if (!tmp)
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index b1c9b36..65470d3 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -936,6 +936,12 @@ static int esp6_input(struct xfrm_state *x, struct sk_buff *skb)
 		}
 	}
 
+	if (x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP) {
+		ret = esp_reset_espintcp_fraglist_gso(skb);
+		if (ret)
+			goto out;
+	}
+
 	nfrags = skb_cow_data(skb, 0, &trailer);
 	if (nfrags < 0) {
 		ret = -EINVAL;
@@ -943,6 +949,9 @@ static int esp6_input(struct xfrm_state *x, struct sk_buff *skb)
 	}
 
 skip_cow:
+	if (x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
+		esp_reset_espintcp_gso(skb);
+
 	ret = -ENOMEM;
 	tmp = esp_alloc_tmp(aead, nfrags, seqhilen);
 	if (!tmp)
-- 
2.54.0 (Apple Git-157)

