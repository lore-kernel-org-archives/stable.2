Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ED823395D
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 00:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792284749; cv=none; b=Vwz9xsFAGZ59RQkUBMLtwUS1NYsyAJDRIDDoJFSHv7wG6xVpMuqIRkP5RoiMsdE/DaN3T8RPBRKmR++3eqkIZ4+Qpbom13Pduheeje+AOlQ98kwCBs8u+MQSHkP4ey6nvveZYRf6iLv7x8ke8latp5HEFMXFr0emDh90g0PNyr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792284749; c=relaxed/simple;
	bh=ah13Vm6hJuN3cXWZju+dpXUkIv3aBCcDpzpa48LRO2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mv3dZlaC9/mTPdDXjqfe+6P5lW6296rUWaS7gPbTWKAzRCE5O5XygTIHYEKypyfwGniTtk2/Hoi9KaknGrdj9FnJz4yHXo1KMVjEtrW9Y0bnqN0UcZcMJmKY4xSlG4mmEHD5Ea9S/aLmQrKo8bzdOIuCxl56e5/Y+irIOSpH1vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGjJx0Qg; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGjJx0Qg"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-89f639ba307so338297b3a.3
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 17:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792284747; x=1792889547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EXX7xoGM3IbUcxsHLOmSjTE1gzsSPDLKJJL1mCpcc70=;
        b=NGjJx0QgvNwicysgOEKq1AS3iPd9sJXN056m+a8t0GRRK3gI7X7t+NUn6RAtgTXxmZ
         28HFYJmJ8RH9XU8m8OTz3hKldSPJ1ntOZrgaCpMIWn5ONff5FalurBEuhwxSwd09vCff
         iekRhHgf5otgkvTurlz+lNpZOONGxcqJ2fZS4cvzmY7PbwFu0vMqizGlqrVG6Q8JqGvI
         gDBhKz0X7N5KJaP/1OEmdk2aVLX1EfIW0p/iANGm/ULfZlCYIRtMmL4X7mXW6Jjy3Ptk
         mqfUKLTFQ1/ccdnzbez8/X2NSw/NNubcctebNMNrH6D2SeVVxtplinS7Ccn3UsgX9WM7
         XFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792284747; x=1792889547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EXX7xoGM3IbUcxsHLOmSjTE1gzsSPDLKJJL1mCpcc70=;
        b=eU249sCqQRtRKQIGhyeZ53/LT8FdrUwaBLdKlpTo2MERu4rE9jfmyK/3b+xOjYgR8T
         jraXSu3mkrXC6p0ah6oXNH0NiRb/BEfzkoBZzNT6KMfsmZfOQySUkxtKM8239WOdwrEu
         Hmn9HBawHgvOruQLvrReWEbGX5GwDFE7/w48g8YQwlNJVKQ1ykv3zb6CpMjeHoerqGh8
         leY7ZfhoB6VUy4kTfp9rLQvdKfItMMbLaxyvPxECgZCDof21MMqfPC4zY7UsfXbJCRK4
         ejwjx0EiywR1f2I7mXJo8OaikqxOyL3y9Ts17LzY2Ppa9IZlrOvD4hrUylyrHsSCf0HF
         r5xQ==
X-Forwarded-Encrypted: i=1; AKwUvByzExQqNS/y4oFqJ8echQszmabxKPM5WE/kHrxCNc2WWC9fp8iXjX2TFza+6PuZPar8wxvswLc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKLG3xhjv/NGx9Y0gYwMf1cDOYDBoUCzov8Q88Qr2CAfg4FUec3
	SLub2oqWyT2LcqbN4FLE6JpxN+eborJfqdh1vnxTeVlrZptf/lws3crO
X-Gm-Gg: AYBFou29P4n3NuMAeBlzRmV/K80IhOz+L9gNbmfZFzWedPHTv9+J3mTTH6I53xnMpEv
	WnPBFPxbKUuNjQAJmU0RvmrJtyBgsMA9sSShRlZl5YUK+n4DNkrLxx6tVixYdzEXHQtHWi8nEGm
	oeXXCkb2TjXnJxDJsohRpXUdM3wMrNo1TRG0dRqchXW9fAlt47DROnP84gHa0H+E2V4PG6JPsje
	aJsNX6dCFdPGsSHUneB5fnpmoqGzAIXhCmwxKb0imAoiweg0vLJM7T0ESr4xNM8o6RBFmd2qYBy
	UVvAjhec3f6t7WNHXI9bid6M9mMmNOWBsQvDTzWDfRUwPBbdiKdg0TrOx60LBMEp/LXL/LrUaO2
	SGVYK+uzOw/Trm3Qi3EHPAyEe/PegX8aSyNoITaJWQjbPKAVp9uLc+Uazbj3TkKTprsgXs6MeFl
	QKllZ4AYKiRjULpM9QukDpyskFNYkCuEm1AjUgb+L01ySHTJsOGLN6PHK9EA0YDPgra+Ur8Ri8u
	yyRnxihae8wDfkDjQDG2VuwRACWske/4uAUPPCJy8vqKQPfltXnRLI=
X-Received: by 2002:a05:6a00:2788:b0:880:cb86:fce with SMTP id d2e1a72fcca58-8a04cb29417mr2958012b3a.54.1792284746805;
        Sat, 17 Oct 2026 17:52:26 -0700 (PDT)
Received: from yangguouaideMBP.lan (1-162-28-193.dynamic-ip.hinet.net. [1.162.28.193])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f58208cc3sm2588891b3a.52.2026.10.17.17.52.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 17:52:26 -0700 (PDT)
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
Subject: [PATCH ipsec] xfrm: esp: reset outer TCP GSO metadata on espintcp input
Date: Sun, 18 Oct 2026 08:52:18 +0800
Message-ID: <20261018005218.53267-1-yangguoshuai@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
gso_type in the new private skb_shinfo) and calls skb_copy() on the cloned
frag_list member, producing a linear frag_list child skb allocated from
slab with head_frag == 0.

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
   ip_sublist_rcv from ip_list_rcv
   ip_list_rcv from __netif_receive_skb_list_core
   __netif_receive_skb_list_core from __netif_receive_skb_list
   __netif_receive_skb_list from gro_normal_list
   gro_normal_list from gro_cell_poll

Even when an ESP record does not have a frag_list, leaving the stale outer
TCP gso_size on the decrypted inner skb prevents dev_gro_receive() from
initializing gso_size to the inner packet's skb_gro_len().

We cannot reset GSO state earlier in espintcp_rcv() / handle_esp() because
the skb is still a clone sharing skb_shinfo with the outer TCP skb held by
strparser. Instead, call skb_gso_reset(skb) at skip_cow in esp_input() and
esp6_input(), where the skb is guaranteed to be uncloned and its
skb_shinfo is private.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Cc: stable@vger.kernel.org
Signed-off-by: Guoshuai Yang <yangguoshuai@gmail.com>
---
 net/ipv4/esp4.c | 3 +++
 net/ipv6/esp6.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index e76db58..416638c 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -900,6 +900,9 @@ static int esp_input(struct xfrm_state *x, struct sk_buff *skb)
 	nfrags = err;
 
 skip_cow:
+	if (x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
+		skb_gso_reset(skb);
+
 	err = -ENOMEM;
 	tmp = esp_alloc_tmp(aead, nfrags, seqhilen);
 	if (!tmp)
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index b1c9b36..02cfc85 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -943,6 +943,9 @@ static int esp6_input(struct xfrm_state *x, struct sk_buff *skb)
 	}
 
 skip_cow:
+	if (x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
+		skb_gso_reset(skb);
+
 	ret = -ENOMEM;
 	tmp = esp_alloc_tmp(aead, nfrags, seqhilen);
 	if (!tmp)
-- 
2.54.0 (Apple Git-157)

