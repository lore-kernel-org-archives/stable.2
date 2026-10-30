Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793365205;
	b=TaKjCLe1KOvNKJhdWNnHghzHXkaiWCX71xjvpTbhJHt30jbiyufvr5eoi68NgQNagVZG
	 Zd6h5Id88NoiGFwuWiGaJoTbMESgsxN6KVlcpeFZ8LTPnofYVOimk1Fd+olNDfNOJMOCp
	 pESEUN7Mz50PXkxwYlsgmSjDjx/vYmXu9axa0jK3b4io/kEBkCH9sk+jUgaz/HH7TGU8M
	 n7PAslLsT2TnQeWz7ebdFSf69YVFLJPf7mvxTXCKMRX2W4qxY9yeYLBKLQnDk9BhXFeHv
	 20rS+E9enVjo4W+OW/U/+0B/QA31z2nI8m58FFxHb4ZXt8H8zefOf37YJD6Xmg+AO8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365205;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ykRLx0xtV2JFezn1qE46TAjktQ1p07zr3t0RG2JR5nM=;
	b=2zrsnQrZKNf2UiW5QXHIOqRu2txiVwtltypBjS4dOXzWzr9L579hVP4pW6+9bbzglVrj
	 9T52DEER4PJ0izFV5JOso2zLFywQg5s5/d3M8ei0hY4mCMTtnU5RYPtmHEx7PmoCMBqyV
	 pAmF6TUS1WHxICrbTggH2Ixn7rFlUY8WSsem4R6vhM8lLfAHwEfONt4Fm6JpSg8gkeHGw
	 wZyAzE3btf9PUyn8Rz4Eh9brcerWzSnCqQS/K4lzCUI59wUlea5CAILfnYvYhhGlitcSa
	 vv4nvb0ttEy6yoVuDVjpGkG8UIRML8O34q3ayRbehylJZbFALFDHMyh0IXB83VnxJ7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hjaRT9Lk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01AF606A325;
	Fri, 30 Oct 2026 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hjaRT9Lk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A911F0093A;
	Fri, 30 Oct 2026 13:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793365204;
	bh=ykRLx0xtV2JFezn1qE46TAjktQ1p07zr3t0RG2JR5nM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hjaRT9LkhjOPVXAZdpiSupdBB6Xj1ZQOFns0UppLlH/L3/NTTYItUHKaAaExfFpxY
	 CF8GKilC+6zJUjV6v06tflu1A/sskQ5jzOB0X9qQ1SJWXDKh/kIAvv6BzQIR0AZ8q2
	 5qGZq6IOhjYVAWcWA3L3QEoE+l/DXkigv9tmYPG8XUxVtxPA1CBpM47u33qIEYsjfb
	 56LhAwto5cgr0PLzI0xIR+teLzG2JOoJUGbTgZ8v9c7gAUaa/oqdlbSvwk6G7r+owr
	 kvCqnRnQzUryrt9qJMlCEodcSf1+OiTRhkwyYyQty169q09mH5V+RDXneMEC6aqhRJ
	 VYOiQjvx2DFLA==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	edumazet@kernel.org,
	Willem de Bruijn <willemb@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Tom Herbert <tom@herbertland.com>,
	Cen Zhang <cenzhang@linux.microsoft.com>,
	AutonomousCodeSecurity@microsoft.com,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] net: gro: do not undo remote checksum offload on merged packets
Date: Fri, 30 Oct 2026 13:59:54 +0100
Message-ID: <20261030125955.3107383-2-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030125955.3107383-1-edumazet@kernel.org>
References: <20261030125955.3107383-1-edumazet@kernel.org>
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

Skipping the cleanup for a merged skb is correct:

- With skb_gro_receive(), the skb is freed, or its headers are
  rebuilt from the head skb in skb_segment().

- skb_segment_list() only copies the link-layer and tunnel headers
  from the head skb, so fraglist members keep their own inner headers.
  grc->delta is only set with VXLAN_F_REMCSUM_NOPARTIAL, where
  skb_remcsum_process() writes the same adjusted checksum in the non
  GRO path. Keeping it is the intended result.

This affects VXLAN and GUE with remote checksum offload enabled.

Fixes: 26c4f7da3e41 ("net: Fix remcsum in GRO path to not change packet")
Cc: stable@vger.kernel.org
Tested-by: Cen Zhang <cenzhang@linux.microsoft.com>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 include/net/gro.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 2300b6da05b2..00b49b6b9e74 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -351,7 +351,13 @@ static inline void skb_gro_remcsum_cleanup(struct sk_buff *skb,
 	void *ptr;
 	size_t plen = grc->offset + sizeof(u16);
 
-	if (!grc->delta)
+	/* Once merged, grc->offset can not be trusted: the frags or head
+	 * of this skb now belong to the GRO packet, or skb->data was pulled
+	 * past the headers before adding it to a frag_list.
+	 * Fraglist members keep their adjusted inner checksum, which is the
+	 * value skb_remcsum_process() would have written.
+	 */
+	if (!grc->delta || NAPI_GRO_CB(skb)->same_flow)
 		return;
 
 	ptr = skb_gro_header(skb, plen, grc->offset);
-- 
2.53.0

