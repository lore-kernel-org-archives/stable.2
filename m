Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795727945;
	b=s70LtoYnaVM87m2/N1Vi3nNkPUHbytmSPxJUpYx4q/mZIcztybxOSNm7rzsrWHPSsRPl
	 twtT3MvvaE0IKs9PYkDfnz5VNundCLzrkRiFYDuGqRMQywF1+Pck6nscFT9Od/Ea4ITw6
	 mlE3/IYiUQ7AHzDJy+2M0jWSdnXHZ82BJPApS+WDxWfI6vRV9MCBxIvQJMOQPVKS/xxDQ
	 TE99UAbQVmoW62PT2euj0nQvYSovv/diSKi/ei/AyG89f3JM14D8ZVO1sNoge6xRVIB0p
	 JD0ufZmqrrIrbjm8f8Nwc0rfuCwrmpc76tsLZ4bJOC3Nc3doCQcnPt76hLLGckjZvUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727945;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=BECvhQRh4+2QJTSzh2eae5Yl1mGEIFIrnDajqcoZhJU=;
	b=T5LS8kvdnQXIFjvKD18XZSs2R8f7W20ZAj99fcMH+a28UsnQPABoEqNuIHfYgWA3AE/X
	 CnunVwyl48g4BznK5l2Nz4l66zmRdiIIeVB2/lUJxWuSXOkN4wGH2G5Fkz99uj1XNJWZS
	 y29INueZn64c6b5ufcH4QyGfKr5rC44ajiH1/LDPjZyISVzgnrdxcnXWiyyXNNVI4TMrR
	 2qAmskchlZQlKWmVI/yfm2RoR7iNMv2OOy8LBD5KqatPJS/eR3laoSXdPSa/l2sYpoQnJ
	 vYo3+Vt9m8+iP0e9QnRofv3yGQ3APONoK3j3sVfwfaMeMS9RjCWEBDq4jc6AsvlSKWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oc03qaVB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBA8606A32C;
	Thu, 26 Nov 2026 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oc03qaVB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1F51F0089B;
	Thu, 26 Nov 2026 21:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795727944;
	bh=BECvhQRh4+2QJTSzh2eae5Yl1mGEIFIrnDajqcoZhJU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Oc03qaVB7N0zm8Q/tLoPqxT6wZstxIs8tp3UpFlIph5ls45TzCK+u5tV8qBhasSSJ
	 NSfGzhJG5z+mY/tV6zUunyW1NwVu/amoolNAkZJi4cPqqX4bhVdfAgvu6D/4qRB08M
	 BRG3ycg8q0IAm4H0pn3+bmCBQI9sjsZoJu7Ur9BlzZkdwphNEJBuyOqBtXkK2BtJoC
	 c50SqZswM0ROynDR6jab5vd961bjbLuGjLbDhI6dfZjhEwWKdYZ68l+hRHM+MG4UrG
	 m7xve5i1IDuU7zPUAz8dITMuPsApFbAY/urRzY5WDj1LXb8GFmG6QMsK9RhqrLEbeB
	 ZP7zu8XgLbwzg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 26 Nov 2026 22:18:38 +0100
Subject: [PATCH net v2 2/4] net: skbuff: limit folio refcount when
 rearranging skb frags
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-skb_refcount_overflow-v2-2-a6f600a5634a@kernel.org>
References: <20261126-skb_refcount_overflow-v2-0-a6f600a5634a@kernel.org>
In-Reply-To: <20261126-skb_refcount_overflow-v2-0-a6f600a5634a@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Stanislav Fomichev <sdf.kernel@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Kiryl Shutsemau <kas@kernel.org>, 
 Song Liu <songliubraving@fb.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Rik van Riel <riel@surriel.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Chuck Lever <cel@kernel.org>, 
 Jeff Layton <jlayton@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, "David Hildenbrand (Arm)" <david@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5075; i=david@kernel.org;
 h=from:subject:message-id; bh=WAffQyLBI6rfibJehelEzcOeB9e8IRQYJFfmSALfK30=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLI5Fpmlb32dL5eW4GActVHu8VWLlzkHKgRnap8y6fvn5
 rzm2b37HaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAExk1w+G//5f1bn85VcpbtZ0
 3Vsd7Dl/W2nyiqIWo2VKmlNvbHORzWb4K/b6XvD+j14fI5fkHpVkEvnx/fGjC0uC/mxd+/2Fd9u
 TfFYA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Various networking features take additional references to frag pages
that are still referenced elsewhere when rearranging skb frags, for
example software GSO segmentation, TCP receive coalescing of clones, SACK
shifting and MTU probing. This is an effective way for multiplying folio
references held by an skb, allowing for exceeding folio refcount limits.

This is not specific to large pagecache folios, but with them it is a
lot easier to reach the refcount limit, as page table mappings can cheaply
create many references.

Let's use skb_frag_try_ref() and skb_frags_try_ref() in skb_segment(),
skb_try_coalesce(), skb_shift() and tcp_clone_payload(). All of these can
already fail, and their callers handle that.

skb_split() can still add one reference when splitting a frag. But each
split also allocates a new skb that is charged to the socket, reaching
the refcount limit that way would require a lot of socket memory, and the
references go away once the data was acked, so it's not that relevant in
practice. Making skb_split() fail is more involved, so let's leave it alone
for now.

Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
Cc: stable@vger.kernel.org
Acked-by: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 net/core/skbuff.c     | 32 +++++++++++++++++++++-----------
 net/ipv4/tcp_output.c |  8 +++++---
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 05626d9622b3d..6da51ad8fd440 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4338,7 +4338,8 @@ static int skb_prepare_for_shift(struct sk_buff *skb)
  * the length of the skb, from skb to tgt. Returns number bytes shifted.
  * It's up to caller to free skb if everything was shifted.
  *
- * If @tgt runs out of frags, the whole operation is aborted.
+ * If @tgt runs out of frags, or we cannot take an additional frag reference,
+ * the whole operation is aborted.
  *
  * Skb cannot include anything else but paged data while tgt is allowed
  * to have non-paged data as well.
@@ -4421,7 +4422,9 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
 
 		} else {
 			skb_frag_page_copy(fragto, fragfrom);
-			skb_frag_ref(tgt, to);
+			/* Nothing has been committed yet. */
+			if (!skb_frag_try_ref(tgt, to))
+				return 0;
 			skb_frag_off_copy(fragto, fragfrom);
 			skb_frag_size_set(fragto, todo);
 
@@ -5160,7 +5163,10 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 			if (!skb_shinfo(nskb)->nr_frags)
 				nskb->pp_recycle = frag_skb->pp_recycle;
 			*nskb_frag = (i < 0) ? skb_head_frag_to_page_desc(frag_skb) : *frag;
-			skb_frag_ref(nskb, skb_shinfo(nskb)->nr_frags);
+			if (!skb_frag_try_ref(nskb, skb_shinfo(nskb)->nr_frags)) {
+				err = -ENOMEM;
+				goto err;
+			}
 			size = skb_frag_size(nskb_frag);
 
 			if (pos < offset) {
@@ -6301,7 +6307,8 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 		      bool *fragstolen, int *delta_truesize)
 {
 	struct skb_shared_info *to_shinfo, *from_shinfo;
-	int i, delta, len = from->len;
+	int delta, len = from->len;
+	bool cloned;
 
 	*fragstolen = false;
 
@@ -6374,6 +6381,15 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 
 	WARN_ON_ONCE(delta < len);
 
+	/*
+	 * A clone keeps referencing its frags, so we need our own references.
+	 * Nothing was added to @to yet: we only steal the head of @from above
+	 * if it is not locked, and the head of a clone is always locked.
+	 */
+	cloned = skb_cloned(from);
+	if (cloned && !skb_frags_try_ref(from))
+		return false;
+
 	memcpy(to_shinfo->frags + to_shinfo->nr_frags,
 	       from_shinfo->frags,
 	       from_shinfo->nr_frags * sizeof(skb_frag_t));
@@ -6381,15 +6397,9 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 	if (from_shinfo->nr_frags)
 		to_shinfo->flags |= from_shinfo->flags & SKBFL_SHARED_FRAG;
 
-	if (!skb_cloned(from))
+	if (!cloned)
 		from_shinfo->nr_frags = 0;
 
-	/* if the skb is not cloned this does nothing
-	 * since we set nr_frags to 0.
-	 */
-	for (i = 0; i < from_shinfo->nr_frags; i++)
-		skb_frag_ref(from, i);
-
 	to->truesize += delta;
 	to->len += len;
 	to->data_len += len;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index cf3ddc055d48d..043838d996404 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2710,10 +2710,12 @@ static int tcp_clone_payload(struct sock *sk, struct sk_buff *to,
 	}
 commit:
 	WARN_ON_ONCE(len != probe_size);
-	for (i = 0; i < nr_frags; i++)
-		skb_frag_ref(to, i);
-
 	skb_shinfo(to)->nr_frags = nr_frags;
+	if (!skb_frags_try_ref(to)) {
+		skb_shinfo(to)->nr_frags = 0;
+		return -ENOMEM;
+	}
+
 	to->truesize += probe_size;
 	to->len += probe_size;
 	to->data_len += probe_size;

-- 
2.56.1

