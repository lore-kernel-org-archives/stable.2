Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343160;
	b=U0hgfeWYNMPYT0qqmQtHyYZB9KO4F8/ZHsGsk8jRox4ZZjTcGZRksak+fcoDLkdfBgb3
	 Drj5AFVdJCDxjgHxJwoV/YCBxeLpscB14hqE75N9Nz6leqHjOx8tPN04kcc+dwxXDikVv
	 ZRstP2fB3Kj2tuxRMmMzqzLiRT8qxhjOkfJg8p5S5ODbENX54ItXUd+FX9lZWakHaYY5V
	 4CgcaDYdCs4uTWagoyZzsy8D1oUr6zEkqde2Ob+3rEg8bJkF/X6kBxaVeKYlCnkOc9AC6
	 oh1xkIfOpVC0JfxUfk6kLRkpAF60R7x9he2sTKRH4n2NHstrOVBfbBbCUrsadD1qlKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343160;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=E4m8FHiFLO/x9oCUsb/0QhI25EqM9VOH8L9QKYaqiGI=;
	b=kYIbHUwe+QdmuqCeEH068UZj+SrQd2Zz2uZforAbc7Gm33xo7oZB23utehtmr68gBsum
	 lFWlQ/EXzyloVmXtX6RrBjTIvvIC0fu19g553YM8DDPUDadITcQgKCrjET1abn3Rx6N0+
	 thbjh6jb9a/l6rOsLWXj6KDNOXqZDAEo2FXEtU2hFaBw+9F7UnfPtrA17g+yb5M0pLUA+
	 0neLeXMisBCeEdapyGsXxn3kXcD3PxUOPHZ3YvTN/7NHCKdF+G2kzpXQ+gXeoDv8jfJUy
	 UxeBgFEf7qW8lwmVfWpOG7HyXaC4mWKJS6KwYPHFybr/m2qLFFUbwO4VjmM0BPnMFWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XueGupk+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772C2606A334;
	Tue, 10 Nov 2026 20:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XueGupk+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5717A1F008A3;
	Tue, 10 Nov 2026 20:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794343160;
	bh=E4m8FHiFLO/x9oCUsb/0QhI25EqM9VOH8L9QKYaqiGI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XueGupk+w46vm31HshZ994aUeALrLRk8y8MBQ8Q9oq+/3qNVtObmjbbCMHw8J3+NE
	 IvI7thyLKfeStaGvlSjWctdHhb4fdnxEQFPWM+b1LjsKP/9jgcEmVRJTvLLcEd0D7E
	 XjrgMAN5nTFuaubozZWvYrPfomZG7p6gMlcYc3HjkmYCJdL6A9Ig6vhirsbJ0VWgVn
	 bIoega0W4nIGhuK0FO4auZzSFv67DeTB3fxajcVatfrzqn+qSPNdJdElB/SYW+vHfq
	 tBia6nwWwoY4N+86U3Qa4WTPqCXyC9f13xibpGmZRpWE0wBL3gt6w4nVVv5ZZCujvl
	 kgdbgY75ITQPg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 10 Nov 2026 21:35:49 +0100
Subject: [PATCH v3 9/9] RFC: net: limit folio refcount when splicing from
 sockets
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
Message-Id: <20261110-refcount_overflow_stable-v3-9-318625d63a98@kernel.org>
References: <20261110-refcount_overflow_stable-v3-0-318625d63a98@kernel.org>
In-Reply-To: <20261110-refcount_overflow_stable-v3-0-318625d63a98@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Song Liu <songliubraving@fb.com>, 
 Rik van Riel <riel@surriel.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Hugh Dickins <hughd@google.com>, 
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 John Hubbard <jhubbard@nvidia.com>, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 fuse-devel@lists.linux.dev, linux-arch@vger.kernel.org, 
 iommu@lists.linux.dev, netdev@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7544; i=david@kernel.org;
 h=from:subject:message-id; bh=7U/DzXjI5miBDV0MKGmDg4W99Jxg9rPtkaZjscX+PzU=;
 b=kA0DAAgWwCT9yb1uzcsByyZiAGrzgFiiqTYoJ7KhL9HQt6QX1ehBy8uc7NZ/aOoBOxJXqkITc
 oh1BAAWCAAdFiEE1q5sZVOshUF2WjFGwCT9yb1uzcsFAmrzgFgACgkQwCT9yb1uzcuBYQEApbjm
 98Lr+UljqcvxLAuMTM//qYqizwl8F+GZG8XeTMcBALNkfASxO4rGDKK5xo0XZjKq/lh46csayNB
 1VebjCgYN
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
bool. If we could not splice anything, return the error from
skb_splice_bits(): returning 0 would make the callers (TCP, AF_UNIX, KCM,
kTLS) report EOF, although data is still queued. The callers already
handle errors.

Use -EFAULT, consistent with splice_folio_into_pipe().

Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 net/core/skbuff.c | 90 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 51 insertions(+), 39 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 5e3f910eeea0b..a5965f8fa1b00 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3150,11 +3150,13 @@ static bool spd_can_coalesce(const struct splice_pipe_desc *spd,
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
@@ -3168,7 +3170,8 @@ static bool spd_fill_page(struct splice_pipe_desc *spd, struct page *page,
 		spd->partial[spd->nr_pages - 1].len += *len;
 		return false;
 	}
-	get_page(page);
+	if (!try_get_page(page))
+		return -EFAULT;
 	spd->pages[spd->nr_pages] = page;
 	spd->partial[spd->nr_pages].len = *len;
 	spd->partial[spd->nr_pages].offset = offset;
@@ -3177,12 +3180,14 @@ static bool spd_fill_page(struct splice_pipe_desc *spd, struct page *page,
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
 
@@ -3200,8 +3205,9 @@ static bool __splice_segment(struct page *page, unsigned int poff,
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
@@ -3213,28 +3219,30 @@ static bool __splice_segment(struct page *page, unsigned int poff,
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
@@ -3248,10 +3256,11 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
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
@@ -3260,11 +3269,12 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
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
@@ -3272,7 +3282,9 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
 
 /*
  * Map data from the skb to a pipe. Should handle both the linear part,
- * the fragments, and the frag list.
+ * the fragments, and the frag list. Returns the number of bytes spliced,
+ * or an error if we could not splice anything because we could not take
+ * a page reference.
  */
 int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
 		    struct pipe_inode_info *pipe, unsigned int tlen,
@@ -3287,14 +3299,14 @@ int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
 		.ops = &nosteal_pipe_buf_ops,
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
2.56.0

