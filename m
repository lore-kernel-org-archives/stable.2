Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049010;
	b=RI910UZpdV6i5ZhGWmXq6fFnft2+cg9q4SvZA+wFLO9Ko+PVwrGB8WB51GCR9a9IIB/b
	 p3GIsnZrNbyiGrTgDWhdr1IcmYIfxecV2Qc/SHXNaxhLajOS24OLnUQl2IjeWJVQ5oeoT
	 nVYMCIaj/roriPinzgpZTp187MKvTOep1KpokUBa7NRxQ5v/h3U3Z2FWuY+WbtVm21HDd
	 t2xved6O0EfqIlc1xcz5vSd/volTp0PYnnqF8UzGtQmw3hch3JHlVyirRnpijqG80TlOQ
	 fU/fAILCAA5Z659eDQ5ELKj4RYBKPq9utRGdlSVzNch8ep9qXD46uvXc/cKf14mpEIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049010;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=V4pT3J7xf2s1CygPBwrVGhzTyq1W2+Yo2ohspomtUIE=;
	b=ck35i8PkAhmqRGCtUUkMJmbwoc3Y5toe6Vx/2eQVoVWXKNw+uD3OHdkuwrf9pvOghGbp
	 hn4+twzE7tSKzjum8nEbcTLU0j+6pMFnM+RRGuD5HLq0wvC2AirlhAJE7qQyBpWFgh85C
	 AK2IBuNh3JsLUbuYVOcskFdqs1mzON14ExV9RIKKmBZBhey2CCoY+Ob22ZDOdfVGzCJAi
	 XbHumNATO1VRkeSDGMOES2MSbpO0m9RIkB2jlmX12O25g/lkULIn+8/YsATMomrBnq7JL
	 stNhvHKpwkvJz9KyDlSPN5rhexOWzi7kX7ihSOR6aUId0y6CmfLqiunUWa+DFrKxTLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ThLyEkxJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1008606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ThLyEkxJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4DD1F0089F;
	Sat,  7 Nov 2026 10:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049009;
	bh=V4pT3J7xf2s1CygPBwrVGhzTyq1W2+Yo2ohspomtUIE=;
	h=From:To:Cc:Subject:Date;
	b=ThLyEkxJz8C6aLhfvM7/XDT/6VsfSZqzQXAyTsAlJlAxaNlvo4kmO9i1JphLPxkJ6
	 OltdxQNdVQeVLt94SdSq7WTMNu1qxMJmDBXEDJ2V4dC7zgelsCL/NcKBlQ7yx+N08G
	 Jm+2y6QpXcBp9EEvTJeX0YFIMFW/oYbci2xomi17/PrCM8no2+IHV3pCQUY2OuBEwL
	 pvU71yw5crySsqdSQKbCnQdwG3rpsMXREvYNNo/73Rc+X1V2JDddv2xMmtmQpXq6YB
	 RPmju+beN7l1UViVla0Dp3dbgZEZaq6bLRgzkK4r6PgxaliNNuaBi0GI2wKvwCwOa3
	 HxI+ZtNZoPdwA==
From: Sasha Levin <sashal@kernel.org>
To: kylebot@openai.com,
	willemdebruijn.kernel@gmail.com,
	edumazet@kernel.org,
	willemb@google.com,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] net/packet: check TX_RING fragments before memory accounting" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:56:47 -0500
Message-ID: <20261107055647-failed-6.1-dc4dd12f80e4@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x dc4dd12f80e499dc034710cd8195489abcf0b059
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055647-failed-6.1-dc4dd12f80e4@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From dc4dd12f80e499dc034710cd8195489abcf0b059 Mon Sep 17 00:00:00 2001
From: Kyle Zeng <kylebot@openai.com>
Date: Wed, 28 Oct 2026 19:14:50 +0100
Subject: [PATCH] net/packet: check TX_RING fragments before memory accounting

tpacket_fill_skb() adds the full non-linear payload length to
skb->truesize and sk_wmem_alloc before checking MAX_SKB_FRAGS. With
PACKET_VNET_HDR, userspace can submit a ring-sized frame even when it
greatly exceeds the device MTU.

A near-INT_MAX frame can saturate sk_wmem_alloc before the fragment
loop rejects it. A subsequent refcount_add(0x40000001) can temporarily
turn REFCOUNT_SATURATED into 1. A concurrent TX completion can then
drop that apparent last reference and free the still-live packet
socket before refcount_warn_saturate() restores the counter.

Check that the remaining payload fits in MAX_SKB_FRAGS pages before
accounting it. Include the initial page offset in the calculation,
and move the existing -EFAULT handling out of the fragment loop.
This preserves the accepted packet sizes and error code while
preventing an invalid frame from injecting an oversized byte charge.

Fixes: 69e3c75f4d54 ("net: TX_RING and packet mmap")
Cc: stable@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: Kyle Zeng <kylebot@openai.com>
[edumazet: use net_warn_ratelimited() instead of pr_err(), add a Fixes: tag]
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20261028181450.2221013-1-edumazet@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/packet/af_packet.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 823e0911c910f..cf6429f094772 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2655,6 +2655,12 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	}
 
 	offset = offset_in_page(data);
+	if (unlikely(to_write > MAX_SKB_FRAGS * PAGE_SIZE - offset)) {
+		net_warn_ratelimited("Packet exceed the number of skb frags(%u)\n",
+				     (unsigned int)MAX_SKB_FRAGS);
+		return -EFAULT;
+	}
+
 	len_max = PAGE_SIZE - offset;
 	len = ((to_write > len_max) ? len_max : to_write);
 
@@ -2666,12 +2672,6 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	while (likely(to_write)) {
 		nr_frags = skb_shinfo(skb)->nr_frags;
 
-		if (unlikely(nr_frags >= MAX_SKB_FRAGS)) {
-			pr_err("Packet exceed the number of skb frags(%u)\n",
-			       (unsigned int)MAX_SKB_FRAGS);
-			return -EFAULT;
-		}
-
 		page = pgv_to_page(data);
 		data += len;
 		flush_dcache_page(page);
-- 
2.53.0




