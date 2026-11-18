Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794990790;
	b=QHZUhnbW/vzp3IRDDgGAEbFLjoIxuB96u5O6pOPtNXBZuM+dcGg8nC7yf/VM6gLx2aNG
	 TEgzjiyvkkmtp07GjVWYIw3vVR8eHzXQAelKyLCmMNgPoijt3O5IpfvbQ5guOqotMmWKZ
	 sD9/ic/dBDd/cHsvrP+em358qU7aK/cWh6UaXFrkAXVbR4s8/Vy7Nqj2gSuFNGx5+AEg/
	 Pt1P18jYDq0S/3JvQNat8lnnvryH6KuYWfVju0MrosURnWgqiFnYCb8tDQjg5YdIq+Mja
	 RIGdLLjfp4TwyghcFHUMKiaECGSMUpM5IPsSyzSjwKOeI0iNcTIIStW71VsfGJTV93w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794990790;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=tNPg0ACmVQdDcbUvahoJ+sX2NLYiOTZE/5SlqvfFlLo=;
	b=ThdLV32PF1UDPtGNSEvJ6RKo9ptULr0IcSGuu7IxjCfCu6BMW+oWHFBmct6ayXvtntPN
	 WDxnvxLxwzFPYdgsJ0MWVc+b9Xh7tGztfwh3Etumm3KBx1jF0BIuJoD1ySSWiWYD37E4k
	 x8J9EjC8vhMeoce1tG/F8wflaQmT6YOIFv1TkHSRXuXffWN2yGaZeP6SoM5tTRfW9xvPu
	 sicxzfxGBXSYHs/uoZQFoINdXfwEgIN9jJ0x8Y0XnR7dRzAo/0IKAuNK49P4ksolDJu/7
	 iFUiWAfmZYHgcxAvAqEMD6S07iH2hqgVVi9OtLZilZJ8bEdtgI7obzq0OU+ha9t5qUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iovxfvO0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F35606A33F;
	Wed, 18 Nov 2026 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iovxfvO0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AD21F000C5;
	Wed, 18 Nov 2026 08:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794990789;
	bh=tNPg0ACmVQdDcbUvahoJ+sX2NLYiOTZE/5SlqvfFlLo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iovxfvO0Xz1ORd/v3dwYcwfajxh+hupUCrkqoNdJc/YiYYuz02pVptDqZY3MokE2U
	 Hw8f4MKhRX7BtTItkijvVUxVFwZ0cNxxJJl9Fm+dFcKEfsLJMOB1R0aGwwD1ixwZ8I
	 9ScDBkhMiRXtJjjE1VabhNWWvKXuY46JjIZq5sZkjGfkDT6EmdvYj/OQ7VCf5QM138
	 2daTDskmGranbE7KArDs1j5HHfHeUggjnOkmApltTYKiUhsbR+tX5OS+l3cYN8Li1G
	 AsQJ5BhqwBqotMh7paO9Va6MUl7REQP49T5miDehA1QE1GE9TxpPVWfdJP3MRZumdR
	 0TI1XMudHx+Cg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 18 Nov 2026 09:32:39 +0100
Subject: [PATCH net 2/4] net: skbuff: limit folio refcount when rearranging
 skb frags
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
Message-Id: <20261118-skb_refcount_overflow-v1-2-5551b4954c3f@kernel.org>
References: <20261118-skb_refcount_overflow-v1-0-5551b4954c3f@kernel.org>
In-Reply-To: <20261118-skb_refcount_overflow-v1-0-5551b4954c3f@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Kiryl Shutsemau <kas@kernel.org>, 
 Song Liu <songliubraving@fb.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Rik van Riel <riel@surriel.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Pedro Falcato <pfalcato@suse.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, "David Hildenbrand (Arm)" <david@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5075; i=david@kernel.org;
 h=from:subject:message-id; bh=2F4qM0zZmhIpBb9Mf21D4ViNEGscC/lfRDW/fzP+9Hs=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLL+Jm17Y3kx9+lKbbWF+/YXF/xgSox8cWaP0Ys3Bwp2u
 fItzNHN7ChlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAicfMZfjJqzVi45tP+hw/S
 NqzsVd6zieNYzbKAwDkW27Qt1U+a7ktnZOh9N4fz7ASJa3/90hqYuhb39300ihB+LOvVJRucYLN
 tBQMA
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
index 447099b39deeb..bed1c8c4c6b99 100644
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
2.43.0

