Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621721;
	b=Pms40Xvh1XmaxrRMh9eK7KlkQZrDEvUWyGlMGXGCOhPFyx4AnBrTyV6DuVY9+il1AsVv
	 K2Y1fquPwtX9wCjK4RV4xZDiZZKx15I/s5QtyyDbv6cpptq91UVeCyjmoFsjJqf9WUeyj
	 J08I97GoBA7mFFc3rpQ9kyDcQ++V1flDMD8wigpgXmWd7AUUOdwosoknKilmYjGc6wj1C
	 laBkdRCEcwlYIPpRJfVPddszLPB3tEhFrCogBxpqiPP5swnRd6FkFfHj0dUMrixpI7NFd
	 wsO1mH6Fj6DOP5Hl5eQoIhwWQRCz8FmX6GpM5Elcr/tn1P533smJ7mcx513tT+TyUbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621721;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Xqy/cnntJwhR5FQgS+mIMw/XKK5JM5UfQXSLF1KToqg=;
	b=ZLRQunolLsCTQCD6xAJWogXV0mDsvFN2IN8/IiDa5N9sAZGkMbEF2FYdXvrPQLZxWaAk
	 3MzYGP4OsnJyayhu2NajSn677s7vjJtgCIAbUp1RIuB7It4s3wxDTjvOOBxm+A5qcNnOy
	 uwC4N3swmjAVLx/TYLjoe+V40xFEFGclHk8+3pVsoZeD0oF4e4everkkAnShqJA4F0mAT
	 xVnw5LZ2b0SACNaZGTkrs0qWd31uZNAwHT8itfp0muVtv7xHV6MLXgenUg4w8XlCwytfe
	 UdUKJUL69YVB2iSBZ5unb9fCtKBwLrQV2jYBqX1RB9rjG9NahA98wJ0vvxEx7f906Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O1NQC95p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCEC606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O1NQC95p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3544B1F000C0;
	Wed, 25 Nov 2026 15:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795621720;
	bh=Xqy/cnntJwhR5FQgS+mIMw/XKK5JM5UfQXSLF1KToqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O1NQC95pnITtePkz3h8V+HR6XzTq45O5UWD52M7EIEk5q/Dk22P1vCbV9Tj2rPYPk
	 D8/ogghDqswcPuA7sETFasMNQG0agpeRKbRxxH5/h+9C+U2PCgZABCmuvPt6jUj8s0
	 Z258udTi/xDSbqwsh4P8CwH2ihUUpZ1SqoAN4Pj85v7Hr840mggDNRYibceLCRqom+
	 rXLAc6nh5d2indmXKAd2/MmjmPBe6SC/1CYOX/qOpacCyKWN3zbl/MqcBcENCOWule
	 bkkSe7//J65zuf/vDcQI43PasRCkOL8ufzMq3OKp+kt1MHNF38ba/moiA036rbDh5O
	 APbCw6aouvTDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] net: gro: do not undo remote checksum offload on merged packets
Date: Wed, 25 Nov 2026 10:48:38 -0500
Message-ID: <20261125154814.588118-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112510-gently-tweezers-f0da@gregkh>
References: <2026112510-gently-tweezers-f0da@gregkh>
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
[ sashal: adjusted the remcsum cleanup to the older tree layout: code lives in netdevice.h and skbuff.c, and uses skb_gro_header_fast() instead of skb_gro_header(), with different surrounding context. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/netdevice.h | 8 +++++++-
 net/core/skbuff.c         | 7 +++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 55be695d50532..34007d0cb68ac 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3125,7 +3125,13 @@ static inline void skb_gro_remcsum_cleanup(struct sk_buff *skb,
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
index 408e4b9935a10..bd0818d7f90be 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3895,6 +3895,13 @@ int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
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

