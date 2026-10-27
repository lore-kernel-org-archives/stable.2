Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793141839;
	b=xmzaip1Rzwz7Vqs0x/mQ7CSftiLQo147smO7D9duMIru7qbU4pn9DzYwEhKaZ3AON2if
	 8KyDMfCthG3cZpUSLlbZKMgyql8ukPecfi3+I5+uNrM/2R691dP0Eex6s0DbCz3lInPYW
	 Zh7Mef0T9LyyDFBEezmKymsEMvrLwZHjmdilbi1NtVMCNCv5CANrQKTZOd8TqSfh+QJXl
	 9eZLUmKHP70J2DR9pocIJ8Y1FoaXzo3FnHxg6WY0L/MFYaBjRcK8DOYLYTHI3t/uOKGtD
	 Dr6YDGRX+nBDSBvSAvbc8h6TdEuHeVBUM0wJGxCALyC/8oBf00ooMute5HMqY0RiMzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793141839;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=x4Wb1nq3gFYdX6BA5R6X0Kbpi+TDs/uhIWeWQW5ffww=;
	b=eMPMgaej6DxZl3jfAnXLiwLlSxktUy0d9f6SUS6Ew7XvBc+hp4wqw3HME06RX8lm6VIg
	 mcg6/Wgfpii3NKWDuA0+YMXvkTBmWo6YiL6Cw7woIzvwBXIoVOGWLu2rAXM4yG0kClbIp
	 jaIDsOwuWM8CF4jjHlTojjShSqZLlBGHXcju54WJsN7G8cH+wc0Ujz5iXNGWeLYC5T7+S
	 FDb59i9CYSL4cWsTxQdGDG6gHZKk9Z69d7aXJ1LJdcVOrMxIOsC3geFAenzHWrFJNDfXy
	 w4q+YEtMatdSYAiQCUwbIfzQZB6RVIDOSgsj0E1D30qYUHm1KmwEv9EGkzclCQ+kxbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wgCH0ctU;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5C5606A31E
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 22:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E5C5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wgCH0ctU
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e5378b281aso1598485ad.2
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 15:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793141837; x=1793746637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x4Wb1nq3gFYdX6BA5R6X0Kbpi+TDs/uhIWeWQW5ffww=;
        b=wgCH0ctU69DCcoz3Ru9BWpJRF/qCvUOXZaq1XCXJ1mY+CrA71lhfiXobTbCAgjpBrk
         DyaxcIPqmt4+ye/6ixGQledSXjLCZRsPF5G8bzUZUp+e27MPNEmH65LnNlJLvMr2Et58
         9FQoB0qgzbGh45aAKAz1ywuxDNOmjfeeOIEF2KOld7xjB9gKcLc1Ur0b2fMUX5Lqj0+w
         Ra8L+RM/OPIkhQsMGjJL0fU8XfOeRal7e3+EFHTgd0ooyWqzBvQ82+5ozusU08AkL9Lg
         hYQSsUa9WPWkVUY0Hx0H0pInv+iykHsdHkYdpyLRUg1UA1Tqqg5VGBAuwDsbSna5P7GU
         dWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793141837; x=1793746637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x4Wb1nq3gFYdX6BA5R6X0Kbpi+TDs/uhIWeWQW5ffww=;
        b=mFFDKUF6/8b89o5D1RdOCUoKYGvmNiF2lAjLyjbIKjPxlLWYMrwHN6evG+XTsgyhFK
         udCDSEhNr4GmYZUm79mMlzWifw8Qvnph8gKC5i0k6ZkcO9Qpn0KTVGQ0N6VpUi7C1KzF
         Fj0iKigaj2ywmIe8TEjugHg4ubx55H05XGimad1bRDWHsLOmQ8pZngc1NINqCPL3dk9X
         l6BvAOHqDZKygZvYooW2whDIIUBQNMy8DOlOMj8IkBTkSDWekruRVEvuF3IWhc2gj9m/
         ttuigjyZuTxNu0w6JIpC7/+g7SgWQYHpyAQvcMDL6jpyb3CPCUlLOPN+9sS75BQPiaXj
         kneA==
X-Forwarded-Encrypted: i=1; AKwUvBwCnPPNhTTng2PrdPetAbcVRTKF0sm3pzzSVcBZf4zTxBYASp7y5+HZ5W/3tXNZyeMe1dWoYjI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLobl1ZDxYISyhjo8Z0bWP9LqrWco22dQXDuCDskwFWYg/jacU4
	wO7bs4E50GfC+fNwqNYQ25WRFScD28DiabGUZiY4Z60zhkT8qJTlmVNx
X-Gm-Gg: AYBFou3w1osyjTpedX1XOU6TbK8DTMNRGn7/NGkELYEzJDuXaexrrvrvLmSUu7NM9zS
	E/pFOBSCVUGCL3fDBxqpFff/6byEumV5mboqDo/6gNIS8vZPU4TEFsQGvpLg7YiVsCyQDZb5TZx
	S4k1XaXs4/anfdfVdaBWQ6jMx87B9G8uf5+YeHk4SS2zETC74XhdQGFY6SYS/x0NrRAPPNUkVr7
	WB6QgUkcIFLmOVB2LZQU6kriajSV7kRGyf53bYS01FcbC1Hu1gql/MWnKTJImWbmjxMyARwjfBE
	DOX+qzQCgd/POv/MzirVgw1du/X4hXh7lxbrqjMY36KFA1D5zb8qWc6J8FwKyUxJA/+9dWzvgut
	jkiYWe0YwSwu76PFF4nuPXuor4PoCOTW6/0/Bd6psWg22svqDBefbC9oVxtE6wsZyahbB416weK
	W5Cxx6LzmjgYqCWDLVg4DKG03d4OzdnlTgCmuVzomCU6d+VXigZXsvvEifM2gvLXQkx1JT/LHur
	KLdDSxPgSqCVMj4nfGg+EaSzgykJRbyKPkRpcW1W3cgrLua19MBjyuoUF9NchPvCTHGcmhEjfUD
	d6ZpWKZz0NwNLUrpSOg1rwA6YVCuGYyfsJGpAgg6x7VS
X-Received: by 2002:a17:902:fc87:b0:2e2:b7b8:abc5 with SMTP id d9443c01a7336-2eb0038e312mr6543085ad.32.1793141837445;
        Tue, 27 Oct 2026 15:57:17 -0700 (PDT)
Received: from localhost.localdomain (ip67.244-167-222.hkg.ten111.net. [222.167.244.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6b76df7sm15602385ad.14.2026.10.27.15.57.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 15:57:17 -0700 (PDT)
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
Subject: [PATCH net v4] xfrm: esp: reset outer TCP GSO metadata on espintcp input
Date: Wed, 28 Oct 2026 06:57:10 +0800
Message-ID: <20261027225710.51832-1-yangguoshuai@gmail.com>
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

Furthermore, on kernels with TCP fraglist GRO support, if an outer TCP GRO
aggregate carrying SKB_GSO_FRAGLIST reaches the espintcp socket unsegmented
(for example, when rx-gro-list is enabled on a device in an outer netns
where tcp4/6_check_fraglist_gro() finds no local socket and the aggregate
is forwarded across a NETIF_F_GSO_FRAGLIST-capable veth device into the
netns hosting the espintcp socket) and is chained onto
skb_shinfo(head)->frag_list by __strp_recv(), skb_cow_data() invokes
skb_copy() / skb_copy_expand() on that frag_list member and hits
WARN_ON_ONCE(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST), failing with
-ENOMEM before decryption even begins. (On older stable trees without TCP
fraglist GRO, the pre-pass is a no-op.)

After ESP decryption and header removal, the resulting single inner packet
still has skb_is_gso(skb) == true with the stale outer TCP gso_size, while
skb_headlen(head_skb) is now smaller than that gso_size due to stripping
the outer framing and ESP header. When this packet passes through
gro_cells_receive() (which flushes frag_list packets via GRO_NORMAL
without resetting gso_size) and is forwarded, validate_xmit_skb() invokes
tcp_gso_segment() -> skb_segment(). Because head_skb is shorter than the
stale gso_size and SKB_GSO_DODGY is not set, skb_segment() attempts to map
the slab-backed frag_list member as a scatter-gather page fragment where
list_skb->head_frag == 0. On current mainline kernels, skb_segment()
triggers DEBUG_NET_WARN_ON_ONCE(1) and fails with -EINVAL, causing
validate_xmit_skb() to drop all multi-segment espintcp packets. On stable
kernels prior to the removal of BUG_ON(!list_skb->head_frag) in
skb_segment() (such as 6.12.94 where this trace was captured), it crashes
the kernel:

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
   frag_list member carrying SKB_GSO_FRAGLIST (unsharing any shared
   predecessor frag_list members along the walk) so skb_copy() /
   skb_copy_expand() inside skb_cow_data() does not hit WARN_ON_ONCE() and
   drop the packet.
2. At skip_cow, where the head skb and all frag_list members are guaranteed
   to be uncloned with private skb_shinfo, call skb_gso_reset() on both the
   head skb and each skb_walk_frags() member.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Cc: stable@vger.kernel.org
Signed-off-by: Guoshuai Yang <yangguoshuai@gmail.com>
---
v4:
  - In esp_reset_espintcp_fraglist_gso(), unshare any shared frag_list
    member before checking SKB_GSO_FRAGLIST so *fragp = frag never writes
    through a shared predecessor's ->next pointer.
  - Clarify in the commit message that on current mainline kernels
    skb_segment() triggers DEBUG_NET_WARN_ON_ONCE(1) and returns -EINVAL
    (dropping the packet in validate_xmit_skb()), whereas the BUG_ON()
    oops trace was captured on 6.12.94 LTS.
  - Clarify the cross-netns veth forwarding topology required for TCP
    fraglist GRO (SKB_GSO_FRAGLIST) aggregates to reach esp_input()
    unsegmented.
  - Link to v3: https://lore.kernel.org/netdev/20261023065311.65031-1-yangguoshuai@gmail.com/
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
index 3229507..83c75ef 100644
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
+		if (!(skb_shinfo(frag)->gso_type & SKB_GSO_FRAGLIST))
+			continue;
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

