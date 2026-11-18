Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794990800;
	b=Zrme3mOV5J9Mrpvo5Z8dYumgtc4ldVEp9C49043KQXLywerGl8VZ4piX8B8DQSAv5TPq
	 VjzZcLOJtweUFvCTd9mBSkc0WKO86bkDk6yJ9y8I+g+CKNU1pc5CJchbszFMxLlvrTaqH
	 BikezEQH7cRdwKED3zCXpN8q44ElsQtDmu8LauSlGRrE4UvQy1//yYIkliUpChXnfq9gu
	 rbb/JLpF92/nJLywszVwJvTIUcCp+idM3jQzdM14a44VkVySLRcfijdEEFeZqNQc0FLZF
	 ZHZbhfHr7KnpOXkJC9wE0Zolur9BCwZrjff16Hzy/ismVXtkl/rxP3XQO7EUXPxTcog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794990800;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=2DPYjQSpLLKGvu/CktwvaDUi/oogU/7rVXfO7DnoaPk=;
	b=AS2xxhniUzi+ECG+kc639G+UwJSBP2dljvtsMeUp+xw1BYvWf7NQr4zBidbJi3qzF6XE
	 LWXFT8EUQ4FOkdRfnfa8KR644FX7KRehRVksID/5aBFRmePnRPx4qzIaWfn3omc3lSvaF
	 BlHHMwVKBFRF+lR/ZCzca7Rd+0pNbzPgPxMIOY/++/RT77LnSk4ZwnsHbi3I6wIzj0r/w
	 fwEahQHDQYGSR5k7X6rKquEpKJyvBT2vRHady9t0vYxp36HsUb0ieL2QY94hlChfNw4PG
	 2rt0UOUZ9l7Bb1z0mDcvX7Pk1YUY7wzB3vwV76A99HTJVW8JOZQeiLSQlpVCVZZAFNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AhRyx/iR";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B68E60A3801;
	Wed, 18 Nov 2026 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AhRyx/iR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881341F000CE;
	Wed, 18 Nov 2026 08:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794990800;
	bh=2DPYjQSpLLKGvu/CktwvaDUi/oogU/7rVXfO7DnoaPk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AhRyx/iR8609PFZufMjUaQpeUjXIkXZ3CgtN0KGHLlCdFOm6Vr4kqWC2oU84YKGhR
	 ATCdXaKaR0MidjlxNwXp8KyTadBLuQW0z0gu9aMxakwRTfKU65kmpp5y17GxONTD42
	 sE1aEW+slkYcXdbNIJqTvrBRImFkq+/SX2kVgpm3BwfMtqr4PHGmzNoARauZoNgb0B
	 V09LTWfLzXcg+d4b1tNYM+hurES41ZlQ262NE6iphJ+GVncdTieDzTAzpMl1cr0kby
	 8HzIELXG/Kwbp1TLc/lkLEonpHZvV66g0npOhZO7OQ4uZboRuJpwEYdpW2AwEBujR5
	 kqUjG0NS16xSA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 18 Nov 2026 09:32:41 +0100
Subject: [PATCH net 4/4] net: skbuff: limit folio refcount when splicing
 from sockets
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
Message-Id: <20261118-skb_refcount_overflow-v1-4-5551b4954c3f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7665; i=david@kernel.org;
 h=from:subject:message-id; bh=OJSTu3EOnCJVKNCuHU2Z5gm29MaQJSf5tLrXQ6DteMM=;
 b=kA0DAAgWx+nLGEVVu3kByyZiAGr9YrajXVl/ZgZiJ03eOlSXnV9F5HIQsfWyvOHIGUC4Xzua+
 Yh1BAAWCAAdFiEEUlPfMOnprn17Rg4Dx+nLGEVVu3kFAmr9YrYACgkQx+nLGEVVu3kpEAD7Bu1l
 ySlp03zpckUvXtRG2XrlJc+HQRnbrS2meXXyVeAA/RVSQrlfyMBZTs6D/lBoHwbagpNm3OifvxL
 ngbF2yhUK
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Various networking features support splicing data from sockets into
pipes (TCP, AF_UNIX, KCM, kTLS), whereby spd_fill_page() takes an
additional page reference for each fragment, while the skb keeps its own
reference until it was fully consumed. This allows for exceeding folio
refcount limits.

This is not specific to large pagecache folios, but with them it is a
lot easier to reach the refcount limit, as page table mappings can cheaply
create many references.

Let's use try_get_page() in spd_fill_page() and stop splicing with
-EFAULT if that fails. To propagate the error, let spd_fill_page(),
__splice_segment() and __skb_splice_bits() return an int instead of a
bool. Keep returning true/false instead of 1/0 to reduce the churn in
this fix.

If we could not splice anything, return the error from skb_splice_bits():
returning 0 would make the callers (TCP, AF_UNIX, KCM, kTLS) report EOF,
although data is still queued. The callers already handle errors.

Use -EFAULT, consistent with splice_folio_into_pipe().

Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
Cc: stable@vger.kernel.org
Acked-by: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 net/core/skbuff.c | 90 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 51 insertions(+), 39 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index c937d74eed6ac..b73fef7a1b460 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3162,11 +3162,13 @@ static bool spd_can_coalesce(const struct splice_pipe_desc *spd,
 }
 
 /*
- * Fill page/offset/length into spd, if it can hold more pages.
+ * Fill page/offset/length into spd, if it can hold more pages and we can
+ * take a page reference. Returns non-zero to stop, or a negative error
+ * if we cannot take a page reference.
  */
-static bool spd_fill_page(struct splice_pipe_desc *spd, struct page *page,
-			  unsigned int *len, unsigned int offset, bool linear,
-			  struct sock *sk)
+static int spd_fill_page(struct splice_pipe_desc *spd, struct page *page,
+			 unsigned int *len, unsigned int offset, bool linear,
+			 struct sock *sk)
 {
 	if (unlikely(spd->nr_pages == MAX_SKB_FRAGS))
 		return true;
@@ -3180,7 +3182,8 @@ static bool spd_fill_page(struct splice_pipe_desc *spd, struct page *page,
 		spd->partial[spd->nr_pages - 1].len += *len;
 		return false;
 	}
-	get_page(page);
+	if (!try_get_page(page))
+		return -EFAULT;
 	spd->pages[spd->nr_pages] = page;
 	spd->partial[spd->nr_pages].len = *len;
 	spd->partial[spd->nr_pages].offset = offset;
@@ -3189,12 +3192,14 @@ static bool spd_fill_page(struct splice_pipe_desc *spd, struct page *page,
 	return false;
 }
 
-static bool __splice_segment(struct page *page, unsigned int poff,
-			     unsigned int plen, unsigned int *off,
-			     unsigned int *len,
-			     struct splice_pipe_desc *spd, bool linear,
-			     struct sock *sk)
+static int __splice_segment(struct page *page, unsigned int poff,
+			    unsigned int plen, unsigned int *off,
+			    unsigned int *len,
+			    struct splice_pipe_desc *spd, bool linear,
+			    struct sock *sk)
 {
+	int ret;
+
 	if (!*len)
 		return true;
 
@@ -3212,8 +3217,9 @@ static bool __splice_segment(struct page *page, unsigned int poff,
 	do {
 		unsigned int flen = min(*len, plen);
 
-		if (spd_fill_page(spd, page, &flen, poff, linear, sk))
-			return true;
+		ret = spd_fill_page(spd, page, &flen, poff, linear, sk);
+		if (ret)
+			return ret;
 		poff += flen;
 		plen -= flen;
 		*len -= flen;
@@ -3225,28 +3231,30 @@ static bool __splice_segment(struct page *page, unsigned int poff,
 }
 
 /*
- * Map linear and fragment data from the skb to spd. It reports true if the
- * pipe is full or if we already spliced the requested length.
+ * Map linear and fragment data from the skb to spd. It returns non-zero to
+ * stop: true if the pipe is full or if we already spliced the requested
+ * length, or a negative error if we cannot take a page reference.
  */
-static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
-			      unsigned int *offset, unsigned int *len,
-			      struct splice_pipe_desc *spd, struct sock *sk)
+static int __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
+			     unsigned int *offset, unsigned int *len,
+			     struct splice_pipe_desc *spd, struct sock *sk)
 {
 	struct sk_buff *iter;
-	int seg;
+	int seg, ret;
 
 	/* map the linear part :
 	 * If skb->head_frag is set, this 'linear' part is backed by a
 	 * fragment, and if the head is not shared with any clones then
 	 * we can avoid a copy since we own the head portion of this page.
 	 */
-	if (__splice_segment(virt_to_page(skb->data),
-			     (unsigned long) skb->data & (PAGE_SIZE - 1),
-			     skb_headlen(skb),
-			     offset, len, spd,
-			     skb_head_is_locked(skb),
-			     sk))
-		return true;
+	ret = __splice_segment(virt_to_page(skb->data),
+			       (unsigned long)skb->data & (PAGE_SIZE - 1),
+			       skb_headlen(skb),
+			       offset, len, spd,
+			       skb_head_is_locked(skb),
+			       sk);
+	if (ret)
+		return ret;
 
 	/*
 	 * then map the fragments
@@ -3260,10 +3268,11 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
 		if (WARN_ON_ONCE(!skb_frag_page(f)))
 			return false;
 
-		if (__splice_segment(skb_frag_page(f),
-				     skb_frag_off(f), skb_frag_size(f),
-				     offset, len, spd, false, sk))
-			return true;
+		ret = __splice_segment(skb_frag_page(f),
+				       skb_frag_off(f), skb_frag_size(f),
+				       offset, len, spd, false, sk);
+		if (ret)
+			return ret;
 	}
 
 	skb_walk_frags(skb, iter) {
@@ -3272,11 +3281,12 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
 			continue;
 		}
 		/* __skb_splice_bits() only fails if the output has no room
-		 * left, so no point in going over the frag_list for the error
-		 * case.
+		 * left or on error, so no point in going over the frag_list
+		 * for the error case.
 		 */
-		if (__skb_splice_bits(iter, pipe, offset, len, spd, sk))
-			return true;
+		ret = __skb_splice_bits(iter, pipe, offset, len, spd, sk);
+		if (ret)
+			return ret;
 	}
 
 	return false;
@@ -3284,7 +3294,9 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
 
 /*
  * Map data from the skb to a pipe. Should handle both the linear part,
- * the fragments, and the frag list.
+ * the fragments, and the frag list. Returns the number of bytes spliced,
+ * or an error if we could not splice anything because we could not take
+ * a page reference.
  */
 int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
 		    struct pipe_inode_info *pipe, unsigned int tlen,
@@ -3299,14 +3311,14 @@ int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
 		.ops = &default_pipe_buf_ops,
 		.spd_release = sock_spd_release,
 	};
-	int ret = 0;
+	int ret;
 
-	__skb_splice_bits(skb, pipe, &offset, &tlen, &spd, sk);
+	ret = __skb_splice_bits(skb, pipe, &offset, &tlen, &spd, sk);
 
 	if (spd.nr_pages)
-		ret = splice_to_pipe(pipe, &spd);
-
-	return ret;
+		return splice_to_pipe(pipe, &spd);
+	/* Returning 0 would make callers report EOF. */
+	return ret < 0 ? ret : 0;
 }
 EXPORT_SYMBOL_GPL(skb_splice_bits);
 

-- 
2.43.0

