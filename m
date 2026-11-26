Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795727958;
	b=oOOkyOBwTjFI+K6Y5GO7wC3LY7btbDlSzQ/A8KF49J0HGSYzN2zoTCahAmKqHQHtm1Um
	 iMLTWTu5F1yZdtGLKHnDQLw4d9TFueALYFafgpZbOksmgKwxTeTLU5YDTU+DVN4YFdeLo
	 WDSGOK/kMz+mqycmdC/BTeZCQMvAdylK5j2JJOP5oiVlIN6y7yyoibw3E/NH7JpjFLIhG
	 kWEfolLs37un44rlJBE3OrKMNKz2BCEcM6rMec5ghUEu1pcrPLAVocaYV0Ud2jCMsmqG8
	 fn9UJhlVkEQh2zh2+4E1k7wkwg7fZSrJ6766Yl+ySuLX7NDbPSuJWx5IYnH3/Q8PpXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727958;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=T7g0PF2rhm0R9Xo1OcuGfmkKtp0vvqib29xJ2PkeRIE=;
	b=dOQc8p7oHANomJUW5rmkbB6oZ+RpAJ9mGkWhtTwvqqcmtohd6QGKDo/Ew8LWJ+Bvtovu
	 2QrOfOOGjYRgL3Ong8tnF10QhcHcmLIRcX5kIO3n6rGtNCWH8IyFkmoQ28iVaM/YviNye
	 WS19pSTaQ2TKomgshXq1vaO1ejQlxlg9v/3diRyJYvEbxkLMro69x+iiQPabubs8KEAnb
	 5hcvpW8yXcVar39oW61dgrAQH+GKEOwAqfJ1XERXFbvsxYW1Q6EkP9cZcNp5d5NkaTPR1
	 Vsx+twmeW/8iUm2wUQC+dMSiYWdemy+1Uhp1P6N7UMmSjo/DGawuwR04Z4HtrvLhv1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nmK+azDo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B29606A323;
	Thu, 26 Nov 2026 21:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nmK+azDo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4602E1F00924;
	Thu, 26 Nov 2026 21:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795727957;
	bh=T7g0PF2rhm0R9Xo1OcuGfmkKtp0vvqib29xJ2PkeRIE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nmK+azDom1PHTU7H8yvB0f4RqUfCdgs859IwtodDz2vMV5vCV1NX8WTon4Q0KNF5f
	 Z94d27mzbKCejbI/EnAqTIDZtThR5A9bWEl2TW3tqxmmysJRjOWINwCOIX182tvd+2
	 bBIbkRRXJkSy7F6206Y2qFGAazvL/zsW7lw8udwjnG5h/vnqY9ei3A4rTYovvAWnUl
	 ubuW/k1yG2LmG5zX3X84Lh+YQixDMb55SpGD4lYqTfqvQU8xOS1stQtRo3aFdc4EhT
	 D96Tzk4dxDiVGxTCC69KqQ5dEBvrB60eXjhBZAv44sr/vFOHbBFp0RnYatUOb6KI9l
	 D2qsHxnZR5Inw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 26 Nov 2026 22:18:40 +0100
Subject: [PATCH net v2 4/4] net: skbuff: limit folio refcount when splicing
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
Message-Id: <20261126-skb_refcount_overflow-v2-4-a6f600a5634a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5778; i=david@kernel.org;
 h=from:subject:message-id; bh=T9uhC/xEmr2tuYoZB/8o6f641B8j3fTWqS2TXzJ8NJU=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLI5Fpl9Slk7v/Na4NTqfarWO1YmNxwXTrn0IkH2zUPfL
 Q5XGgOMO0pZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZjIbgmG/zWacwIKHqlvzj/E
 sVL303ruyLkLE14FGa14vlU3YVvf5lJGhleCX1LldmRrZZuyRSiKBiSFed+uupO8QG+//tl5C5+
 78QAA
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
-EFAULT if that fails. To propagate the error, add an "err" output
parameter to spd_fill_page(), __splice_segment() and __skb_splice_bits().

If we could not splice anything, return the error from skb_splice_bits():
returning 0 would make the callers (TCP, AF_UNIX, KCM, kTLS) report EOF,
although data is still queued. The callers already handle errors.

Use -EFAULT, consistent with splice_folio_into_pipe().

Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 net/core/skbuff.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 957335bcc5961..ca5e27545b46b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3162,11 +3162,12 @@ static bool spd_can_coalesce(const struct splice_pipe_desc *spd,
 }
 
 /*
- * Fill page/offset/length into spd, if it can hold more pages.
+ * Fill page/offset/length into spd, if it can hold more pages and we can
+ * take a page reference.
  */
 static bool spd_fill_page(struct splice_pipe_desc *spd, struct page *page,
 			  unsigned int *len, unsigned int offset, bool linear,
-			  struct sock *sk)
+			  struct sock *sk, int *err)
 {
 	if (unlikely(spd->nr_pages == MAX_SKB_FRAGS))
 		return true;
@@ -3180,7 +3181,10 @@ static bool spd_fill_page(struct splice_pipe_desc *spd, struct page *page,
 		spd->partial[spd->nr_pages - 1].len += *len;
 		return false;
 	}
-	get_page(page);
+	if (!try_get_page(page)) {
+		*err = -EFAULT;
+		return true;
+	}
 	spd->pages[spd->nr_pages] = page;
 	spd->partial[spd->nr_pages].len = *len;
 	spd->partial[spd->nr_pages].offset = offset;
@@ -3193,7 +3197,7 @@ static bool __splice_segment(struct page *page, unsigned int poff,
 			     unsigned int plen, unsigned int *off,
 			     unsigned int *len,
 			     struct splice_pipe_desc *spd, bool linear,
-			     struct sock *sk)
+			     struct sock *sk, int *err)
 {
 	if (!*len)
 		return true;
@@ -3212,7 +3216,7 @@ static bool __splice_segment(struct page *page, unsigned int poff,
 	do {
 		unsigned int flen = min(*len, plen);
 
-		if (spd_fill_page(spd, page, &flen, poff, linear, sk))
+		if (spd_fill_page(spd, page, &flen, poff, linear, sk, err))
 			return true;
 		poff += flen;
 		plen -= flen;
@@ -3226,11 +3230,12 @@ static bool __splice_segment(struct page *page, unsigned int poff,
 
 /*
  * Map linear and fragment data from the skb to spd. It reports true if the
- * pipe is full or if we already spliced the requested length.
+ * pipe is full, if we already spliced the requested length, or on error.
  */
 static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
 			      unsigned int *offset, unsigned int *len,
-			      struct splice_pipe_desc *spd, struct sock *sk)
+			      struct splice_pipe_desc *spd, struct sock *sk,
+			      int *err)
 {
 	struct sk_buff *iter;
 	int seg;
@@ -3245,7 +3250,7 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
 			     skb_headlen(skb),
 			     offset, len, spd,
 			     skb_head_is_locked(skb),
-			     sk))
+			     sk, err))
 		return true;
 
 	/*
@@ -3262,7 +3267,7 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
 
 		if (__splice_segment(skb_frag_page(f),
 				     skb_frag_off(f), skb_frag_size(f),
-				     offset, len, spd, false, sk))
+				     offset, len, spd, false, sk, err))
 			return true;
 	}
 
@@ -3272,10 +3277,10 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
 			continue;
 		}
 		/* __skb_splice_bits() only fails if the output has no room
-		 * left, so no point in going over the frag_list for the error
-		 * case.
+		 * left or on error, so no point in going over the frag_list
+		 * for the error case.
 		 */
-		if (__skb_splice_bits(iter, pipe, offset, len, spd, sk))
+		if (__skb_splice_bits(iter, pipe, offset, len, spd, sk, err))
 			return true;
 	}
 
@@ -3284,7 +3289,8 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
 
 /*
  * Map data from the skb to a pipe. Should handle both the linear part,
- * the fragments, and the frag list.
+ * the fragments, and the frag list. Returns the number of bytes spliced,
+ * or an error if splicing failed.
  */
 int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
 		    struct pipe_inode_info *pipe, unsigned int tlen,
@@ -3299,12 +3305,14 @@ int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
 		.ops = &default_pipe_buf_ops,
 		.spd_release = sock_spd_release,
 	};
-	int ret = 0;
+	int ret = 0, err = 0;
 
-	__skb_splice_bits(skb, pipe, &offset, &tlen, &spd, sk);
+	__skb_splice_bits(skb, pipe, &offset, &tlen, &spd, sk, &err);
 
 	if (spd.nr_pages)
 		ret = splice_to_pipe(pipe, &spd);
+	else if (err)
+		ret = err;
 
 	return ret;
 }

-- 
2.56.1

