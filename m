Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792465498;
	b=pq/BEY30poh5B3UMWO0RRS9dOlYqjB0cH/Pv5xDiuZ8HF0QB/cQCFgoTPd82txvuG1Bw
	 UfUJHEl9NsWUoRQNIIOq7S4hZmY6beOYzaZLkwvgHSMmgC6sHtMPwcwOeD14bU2kPcoUN
	 TcJsnMw94NMY70G1TTZDxNPRkdVyT00p1WnNp54wDHNBQjCWYqGkF7glyflMlZOlUXyOw
	 IjilaZzKobhi+kyl0au/UloRk8SyhWzU4rJxZQQqf5RACPI35O80IF18RBZZuaDIy5GzR
	 eKNN/3FvXmJw+EQH1LWHDXKAhvRxNx3ZsjgWIQfnO3YpKIjsQalrtqmVeyacQ7RZd/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Pm54GtLoc9Ls0ofX4mP3XCN3sjH8BR9wUxBcQ7EXzFE=;
	b=EadoFGAkG6O0cfRF5HftdYx9IrslWIrM6kLnAtPbzLtIIx3oS+twGUBWWbke1aij+Dsv
	 7U/1qo58i9QH550PEE7YMCPONbAIikCanBBxjAE+Ol3uxK5yw3tOVqZYNG+slVQ8S1uRA
	 07bHgA1flUjwE4620wmFz0Jw36VC7cROsFeDhkBBau3Nhvbwp5ZD4OcXKv0OW4G8RC0Jm
	 sHnLsLaKYmIuuU4krm9yAGk4miWyrChgPbKtISp4gEgKdRwTVL/vo4Bqae9GvrLjflD+m
	 vK6faf/EAGArEnp0KdRVpJpfMoVZaVF8/33Q+Z/ofZL3A3BHK4lDJDrfylKuuv+aUnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fkj345uK;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DEE606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 03:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92DEE606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fkj345uK
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ab9268d90eso1618056a91.3
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 20:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792465497; x=1793070297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pm54GtLoc9Ls0ofX4mP3XCN3sjH8BR9wUxBcQ7EXzFE=;
        b=fkj345uKHxlY1zp+L646DsGbiQCi4nncGEY+opVpYR1ADxZ7pgziCLhYFDqttQU8d6
         odIEkEVwT/kQHCYYKNBAfksIGO0FiP9VKFgjHEn6YGa5X8+RwsuwOtdN201t+wnsHRyL
         6JUEzjUU3XYuMTpf+CJ/wFp9eu3qlMcDHjjeWDHt5o+rOrVxnhV1roP6liSGzS4knz89
         JpNFXTG7f6gAuoDRAI0PNDCGr/Y5F7rO5zVvqnbpA81oaPMGgVJOPegW/NtcklIg8Ffz
         mhajwchBAyRtR9wIOA/3w2yyGp6TUB9l8Xd65pY5ZBaLxCMO1Pk4u8gW3Q5nu/RUkcCn
         dlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792465497; x=1793070297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pm54GtLoc9Ls0ofX4mP3XCN3sjH8BR9wUxBcQ7EXzFE=;
        b=VEfMTLZGqIYs2kM8KlrFXwD3LZgrZuA+7lgniXDdnEU8dzZOowvBvKn63HxG7U+io6
         WcOKxh/Nz/GtDpK46t6uEi3kCt+lMTEo7va9P9BHjrxv1eW4Uczscl2L0js+Pcou81cS
         vD4VJG0OoQjjJS39e0BOOb8WFYq4yvqgTGSazDiVSaA7qfnuTu6liySsSZ9RJ1T6VRT2
         qnjLRngDJ7ZoVal3biBIKbB0mDVkJICdJHMJ+/z7yNZrSe6gmqzKGytSW/agooejZZHd
         qGUwOGaky/fgSwQw0GQH2oorTnJz9DrHj1ZqgEJE5DqRpncGlKIXQX073Np2b7lqe23A
         hNtw==
X-Forwarded-Encrypted: i=1; AKwUvBxf7EAXX+ZowOuC0kTu29359XKQifZr1UB7BMK1XCEbzIvKEuvPsgBRApA1VaNuCQQex6pCwNs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhVaTSlLTD7+tr55KYf44rbKL0vBnX8A00PdyCYYqdcT0+PfLd
	MR19EGtGyiRDZYQkGWgdrbnxNrdrsW5c5bgZhrKDhkh1kDg4gPplYgzS
X-Gm-Gg: AYBFou1DNzZmB6Na4etQhWZYpRli58fL6ZQBFFZ7Rbu0O9+6xGeGNfr7kg8dlvbVNe5
	RT9x8r6pH6k8db2y16TOXgJdAGcDXDPi5f42LE/yuG/2jRACM50zI0CsiTp+S0KVdrG3TughI9l
	CY/SE3PUQ4Q0BN5C8xPVM5d2TGldjf/VwSdlendFtvWSozsMFsWimIERuGqndnymIyro6+pOHdI
	858NqHwaDnQFl4R9z640s1aIF1XxlWcwJbnfLk16ejxM6V0zhtGcnL178SrT8hHQO1vkyjVISaH
	3SoIMIqzdXQk8Tk6OyKdIYOvTwYy6WP86jDQo3GxMugRxBDb3MTrwNFovHZNDycZ8XN7GTYZwBr
	6RNjHid4T0QOJjpfoqsGp2sRhHf+o5FqpGuQuiqFcVkWoBaaihxT2gWgtQtNDhHGJ5WxHjvku2/
	G9+I200iUv5vDnP/jchNxTQpeb0il+B4MQdF0zkT9AKv8jxqAQL8xPLuzwtLK5e1TrkDXmdnyfW
	5xxePAcJpUUl/b4iNLk5ew22a04+fwvaB8urqrYWSShRGznzSs1W3I9GcqQel4=
X-Received: by 2002:a17:90b:3b46:b0:3a8:c0cd:57f3 with SMTP id 98e67ed59e1d1-3aceebc55e4mr7918127a91.18.1792465496890;
        Mon, 19 Oct 2026 20:04:56 -0700 (PDT)
Received: from localhost.localdomain (ip67.244-167-222.hkg.ten111.net. [222.167.244.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd05c9255sm9545638a91.2.2026.10.19.20.04.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 20:04:56 -0700 (PDT)
From: Guoshuai Yang <yangguoshuai@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Guoshuai Yang <yangguoshuai@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] xfrm: esp: reset outer TCP GSO metadata on espintcp input
Date: Tue, 20 Oct 2026 11:04:50 +0800
Message-ID: <20261020030450.7170-1-yangguoshuai@gmail.com>
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

Furthermore, if a decrypted inner packet with a frag_list later takes the
ip_do_fragment() frag_list fast path, each detached frag_list member is
transmitted as a standalone IP fragment and would still carry the stale
outer TCP GSO state when reaching validate_xmit_skb(). And even when an
ESP record does not have a frag_list, leaving the stale outer TCP gso_size
on the decrypted inner skb prevents dev_gro_receive() from initializing
gso_size to the inner packet's skb_gro_len().

We cannot reset GSO state earlier in espintcp_rcv() / handle_esp() because
the skb is still a clone sharing skb_shinfo with the outer TCP skb held by
strparser. Instead, call skb_gso_reset() on both the head skb and each
skb_walk_frags() member at skip_cow in esp_input() and esp6_input(), where
the head skb and all frag_list members are guaranteed to be uncloned with
private skb_shinfo.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Cc: stable@vger.kernel.org
Signed-off-by: Guoshuai Yang <yangguoshuai@gmail.com>
---
v2:
  - Also call skb_gso_reset() on each skb_walk_frags() member at skip_cow
    in esp_input() and esp6_input() so detached frag_list members on the
    ip_do_fragment() fast path do not retain stale outer TCP GSO state.
  - Specify target tree 'net' in subject prefix.
  - Link to v1: https://lore.kernel.org/netdev/20261018005218.53267-1-yangguoshuai@gmail.com/
 net/ipv4/esp4.c | 8 ++++++++
 net/ipv6/esp6.c | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index e76db58..012b59f 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -900,6 +900,14 @@ static int esp_input(struct xfrm_state *x, struct sk_buff *skb)
 	nfrags = err;
 
 skip_cow:
+	if (x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP) {
+		struct sk_buff *iter;
+
+		skb_gso_reset(skb);
+		skb_walk_frags(skb, iter)
+			skb_gso_reset(iter);
+	}
+
 	err = -ENOMEM;
 	tmp = esp_alloc_tmp(aead, nfrags, seqhilen);
 	if (!tmp)
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index b1c9b36..b08cc1c 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -943,6 +943,14 @@ static int esp6_input(struct xfrm_state *x, struct sk_buff *skb)
 	}
 
 skip_cow:
+	if (x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP) {
+		struct sk_buff *iter;
+
+		skb_gso_reset(skb);
+		skb_walk_frags(skb, iter)
+			skb_gso_reset(iter);
+	}
+
 	ret = -ENOMEM;
 	tmp = esp_alloc_tmp(aead, nfrags, seqhilen);
 	if (!tmp)
-- 
2.54.0 (Apple Git-157)

