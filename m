Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621173;
	b=lMMwzpVIIj+G8xLomyJeqLMgQUOFL/ANASdzgEdtxnz2vH9WYUfXfavvvXyAmWpmofzV
	 08iq1fUkcjMzkuuf1SNRf14UgAchyRLUwi8Rb86yC5SOxoJTGHA5pKstEp38r3Hmp6Nxh
	 GXy9kkXi7RU5TiokrZsCUZ34SQbveNZZw+PSmGCEVWJU+gWuI/v4An2smaIQhARA2+wVu
	 1ntmmbrG7PvfjXqFl/dpgzwC9wL9mUJnFSk4CT4juSDDcOt+REcl3B5DKWDSWp59uVC3l
	 kjitbkUTMHJ7bqLmkMBSuVka2CtPKIw8nkBTguqQNZmFjSzlXraMiABCuGrUfyyLokQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621173;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0OcnGPEFrX2zyiOfn/5yLBvqLxU9EbO1tLs2nb+X1pM=;
	b=AUfrC/siXDpOzd8UyAeWClxqSyGabg+n43RFi/nk+J7NnyZzCuHaIIzVG+2IBaIGlFoB
	 XZWWN/6i9mLL3+s6z7nwGroSRFCkj8yNt3WQq6qMiIGyxB+RwaLqQihIN8xLnpFF0vsFv
	 x82V27iHMUEBlSXTXz+gYIAe5v6NXBqkA5UEWtTGGB9yCna8gfjQCy1WgRdC6T1A7TrwX
	 FOLvW5/8RDHu3sIdEkQZiQE2CBN8Kx5rO6EilZFiYQx71EFlRQ86X2Y5zdP+sEdh13l0A
	 BUvkOPl++hY5VSPao8PUpDwo0v5kttMc4anjbLGE9NMYNcypysSR6dwSru839FMF9Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SQeASoB8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9725606A33C
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SQeASoB8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADAF61F000D0;
	Wed, 25 Nov 2026 15:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795621172;
	bh=0OcnGPEFrX2zyiOfn/5yLBvqLxU9EbO1tLs2nb+X1pM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SQeASoB84evxEhZkyJLhJP0cH/DGFJu1R3dA0ipD9lnVXYBrLgyKtmjS2RpnDYNSg
	 H4oC3cSttiY639sjJRO/POB6hwDKBlXYOBqXsAMYnHOBrHmrPrAtIQbVWtxr6Bi3Cj
	 cWDhhYGKtElh6p6i8rUuffUJAZEX+IOtC4WoSJtUWVr0Nj/VDY5DFfkK6WUD7RX8nM
	 i95rVKEGq12COZEga9XPftTl1n6KNFXgt/F0PwD30AvZkV5KlECaNUPMNjvhulW3Lj
	 G0VzdDUDMgqYw9jVghk109XthK6euEeI+2bDIQd8Vb5jA4CB6Y0xEFPTQBImDDkJdf
	 2Q7nLdUAZImBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] net: gro: do not undo remote checksum offload on merged packets
Date: Wed, 25 Nov 2026 10:39:30 -0500
Message-ID: <20261125153858.468228-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112509-cartwheel-untie-b740@gregkh>
References: <2026112509-cartwheel-untie-b740@gregkh>
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
[ sashal: Adapted to the older file layout (netdevice.h and skbuff.c), with the remcsum_offload check placed after the -E2BIG test since this tree's skb_gro_receive_list() has no pskb_may_pull(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/netdevice.h | 8 +++++++-
 net/core/skbuff.c         | 7 +++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5e5283487dc64..7080ed5c461d3 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3266,7 +3266,13 @@ static inline void skb_gro_remcsum_cleanup(struct sk_buff *skb,
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
 
 	ptr = skb_gro_header_fast(skb, grc->offset);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 7dc2498b544f6..3a7b16a4bd5a8 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4024,6 +4024,13 @@ int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
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

