Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620722;
	b=xsZgWIdXlayTsgPACx8b6qtC1pYKl9ZsSbGDkTBtHvn1voMgwGVqpRgzhgZnBMsVGe2I
	 DWTWCGEbiAHlRVW5SbvDBvvB6Cw//nNKtZbtfHqEWnqDeGdW4uOpCXaOafcM6GaN5ELCo
	 7pb5xr7KCBLoi6OispMLW1cs+FPCFIWqJkvDmcDqQWuox0lffNyIimq9TV8K22IMwEzb7
	 gZB+ZVz3AQh/RcHEl6agKHuz5gn5LGKo1hyHM1GgrRy4mQ/7gHRnLT+MNytMeq+Q4/4dM
	 aF8atCsa8StrvkSN6tbN9Vt3cUKKOy1QoT1lkAUQybMG1JBCDci9SkRRSvOxwgQym8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620722;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YEUNxabqxuujhP9vq3XBG6wCTxxNzcBb0BKFgPsRItY=;
	b=EkLH3vhvImVAKE3R7LaXZLowqIn3P+cWCZHDaArqsP0nEK00NSgi5iWMtI3H7qYNpbRw
	 mlSfIPnR9t1tmhq5pEvf8oAj8RPetyaqkIpcIFnYzjme5B4yE5B09BwV0CN8P4xBy5Tp9
	 0GszZ7ovq3uzP1ijTrHfz27IIazoiBXSPcEeinxckZH0nrWmNYDOXoclhtnEv49RRta5T
	 731Hst+aBaEPlA0GlsX++ycrKEATMNrs/DWdgz8BZqqJ8ZYdvc+wsW7wmKKMKC89iYYR1
	 QAR23jg3A9d4BX1HSc1N+3iIwDFhqlbkuiKrwZxxLz4S1E+fm4LlZOi4glXaEUpJ+GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PtGdHL1Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2E4606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PtGdHL1Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB561F000D0;
	Wed, 25 Nov 2026 15:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795620722;
	bh=YEUNxabqxuujhP9vq3XBG6wCTxxNzcBb0BKFgPsRItY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PtGdHL1ZtXg0wxJrxtVg4dEHFHmQbBWpv9Q808OLLp1dghr/CrG/55QlIru6JMmjx
	 NXhPmaCR56KvjCPwgG+wSP5XUOGOxI9ZypmxdIaaJ+j9B/wAZ64xFGMl2cVsozdPFv
	 p9nsqQbRB1tin0US+REftEE70HTsxwNVGSyMqbO/RZ5g8VjEX97rtt7psp2cow8bLR
	 uYfT4fesWhoddHAIy41exHXJzNHoUGrRRiHf93gRnEVDx5mwPiiCFnvOnUaJ3I8U8R
	 ot0HDjbdU8KjegWJdQ+HYoqBs1wUcvtd24BpKjut/EndiPw61+UQ/Zp9Tjde79/bgX
	 PgHK/XZJ/y6gA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] net: gro: do not undo remote checksum offload on merged packets
Date: Wed, 25 Nov 2026 10:32:00 -0500
Message-ID: <20261125153003.350541-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112509-unpadded-abridge-f87f@gregkh>
References: <2026112509-unpadded-abridge-f87f@gregkh>
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

From: Eric Dumazet <edumazet@kernel.org>

[ Upstream commit c817ec1b06875b98460fbd19591be541bc3fa924 ]

skb_gro_flush_final_remcsum() calls skb_gro_remcsum_cleanup() to undo
the checksum adjustment done by skb_gro_remcsum_process() when the
packet was not consumed by GRO.

When the inner handler merged the packet (NAPI_GRO_CB(skb)->same_flow
is set), grc->offset can no longer be trusted:

- skb_gro_receive() either gives the frags or the head of the skb
  to the held packet, or uses __skb_pull(skb, offset) before adding
  the skb to the frag_list of the held packet.

- skb_gro_receive_list() uses skb_pull(skb, skb_gro_offset(skb)).

grc->offset is relative to the original skb->data, so the 2-byte
read-modify-write done by skb_gro_remcsum_cleanup() can land in
the payload of a packet which now belongs to the GRO packet.
pskb_may_pull() can also be called on this frag_list member.

With fraglist GRO, this can also be a use-after-free:
pskb_may_pull(skb, skb_gro_offset(skb)) in skb_gro_receive_list()
or udp_gro_receive_segment() releases the first page fragment if it
only contains headers. NAPI_GRO_CB(skb)->frag0 and frag0_len are not
updated, so skb_gro_remcsum_cleanup() takes the fast path and writes
through frag0 into a page the skb no longer holds a reference on.
The non merged case, where frag0 is used after this pull, is handled
in the following patch.

For skbs merged by skb_gro_receive(), the cleanup can be skipped:
the skb is freed, or its headers are rebuilt from the head skb in
skb_segment().

Fraglist members keep their own inner headers, as skb_segment_list()
only copies the link-layer and tunnel headers from the head skb.
Their checksum can not be right in all cases: a packet forwarded with
its tunnel header needs the original value, while a VXLAN packet
decapsulated locally needs the adjusted one, as vxlan_remcsum() only
adjusts the head skb. Make skb_gro_receive_list() refuse packets with
skb->remcsum_offload set, so that fraglist members never carry an
adjusted checksum.

This affects VXLAN (VXLAN_F_REMCSUM_NOPARTIAL) and GUE
(FOU_F_REMCSUM_NOPARTIAL).

This was found while fixing a report from Taesoo Kim and Cen Zhang,
who used LLM assisted code analysis and provided reproducers.

Fixes: 26c4f7da3e41 ("net: Fix remcsum in GRO path to not change packet")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Link: https://patch.msgid.link/20261104151042.1157782-2-edumazet@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ sashal: Dropped the early pskb_may_pull() check from the context in skb_gro_receive_list(); the hunk context here is the frag_list assignment instead. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/gro.h | 8 +++++++-
 net/core/gro.c    | 7 +++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index cc12df2009978..09919434b0ca8 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -334,7 +334,13 @@ static inline void skb_gro_remcsum_cleanup(struct sk_buff *skb,
 	void *ptr;
 	size_t plen = grc->offset + sizeof(u16);
 
-	if (!grc->delta)
+	/* Once merged, grc->offset can not be trusted: the frags or head
+	 * of this skb now belong to the GRO packet, or skb->data was pulled
+	 * past the headers before adding it to a frag_list.
+	 * skb_gro_receive_list() does not merge packets with an adjusted
+	 * checksum, other merged packets do not use their headers anymore.
+	 */
+	if (!grc->delta || NAPI_GRO_CB(skb)->same_flow)
 		return;
 
 	ptr = skb_gro_header(skb, plen, grc->offset);
diff --git a/net/core/gro.c b/net/core/gro.c
index c71cb2ff960e4..c5656fe528aa2 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -307,6 +307,13 @@ int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 		     NAPI_GRO_CB(skb)->flush))
 		return -E2BIG;
 
+	/* Fraglist members keep their own headers. Their checksum can not
+	 * be right both for a forwarded packet and for a decapsulated one,
+	 * if remote checksum offload adjusted it.
+	 */
+	if (unlikely(skb->remcsum_offload))
+		return -EINVAL;
+
 	if (NAPI_GRO_CB(p)->last == p)
 		skb_shinfo(p)->frag_list = skb;
 	else
-- 
2.53.0

