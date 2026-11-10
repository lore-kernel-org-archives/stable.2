Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343144;
	b=ixmFlP3mp65RbY6dQZgEW8Q8EmFo0OSDVWGTB/VxFGGT5yDX6sfLYQnbKz8Jb1ZpfBzU
	 23Ar2N58osYQ/8PjPdFDKVhahlS1YLAW0y1gbWRHW422kWOXC9ZU7YMXrbMKEejLQI3YA
	 sjicSaZP8vOymiY/h8/mjqy9FYNfI7N6kPZGdHexyrczFS4dyJw0WRls1ORCW+3hdeDAl
	 3Knozs7yk4GCh0hA+6wF4iP1aBeCVMByqkhzBRTjaWF+SLTX5q+ywAFU+D4N7TagLTyph
	 Xucunae0QYbSL4MZt+aeNsOmDqRYupc9A3QUhvqoHcJKDinz86HlxvCqwXyQCuh/m1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343144;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=oGQPfOg6ypaB3MwmOwwiljkRXcAJPxgwK/FqKLjVxlQ=;
	b=CVYwNUkC2YJptdE4xc4/QbC9TevdAacN1ZPVYxr0qwtWsOpi+AxZ2WMoDFyuCFsXSLND
	 wGm9Kw+TQ1g96xGBMyYWuEqTXilLrsJyJO/1wGHQZgylnzX/3V4r7VBIJfpqctGC8Jn8O
	 9V2tcivV9+K95TznGFbtNzJNFFlOVMae9ikqzCp88NGpcOgJ0O005BxjpyUJO/qCxN1vh
	 D+uUL0oa6uvohmzSy/2P7UVdyWGHtEOSmPCcFh6tX50PSHyN3Aizqi3igfOdqCa3S5mo1
	 m+KhkMN1L8tYsw2LLCWSWUSoCyAnmms9Isr/YPat2sBdCLihrUYn/D0HNHYApRU8mow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MOGUErbv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFCB606A333;
	Tue, 10 Nov 2026 20:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MOGUErbv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B9D1F0089F;
	Tue, 10 Nov 2026 20:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794343143;
	bh=oGQPfOg6ypaB3MwmOwwiljkRXcAJPxgwK/FqKLjVxlQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MOGUErbvI0NvPlBiP+xxxwfFj1wVMhgr7y5RxYFEXlyXRLoxvIaIKVHnkiUdo9RvK
	 WzwmDenCUmqGgqM7XHmXxRoFjMXIuObHesj9LHJI30honJ+APfTMx9mXKt9hjvRfWc
	 wJ4Za7u1jgx07/Wl48rTasHVieQlc01YlGyCYUl+nvfPEijD16kvSpCx9Vse5CK0xp
	 cADxT6tpzyDgJ3sA3+wvz06Sm96tHhOhehudH7CPhHJ5kyQXb06ggzEpMAzCeYqViI
	 e31TkInsQIDQjuNExVGsUDwSnI322VWg+tdHiU1nsrwNaRHBndgceyCoeDSHdnpvxG
	 aHHxSSUgpweGg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 10 Nov 2026 21:35:48 +0100
Subject: [PATCH v3 8/9] RFC: net: limit folio refcount when splicing pages
 into skbs
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
Message-Id: <20261110-refcount_overflow_stable-v3-8-318625d63a98@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2393; i=david@kernel.org;
 h=from:subject:message-id; bh=ZTvUAfCXgF6VHkCx5yhusApI2I6MRRFPDQZm7ACvtSg=;
 b=owGbwMvMwCF2QOXvyb15Z08znlZLYsj63BARr2C5gT/TOFGtNsFcr8dkU0J8T/CVv7b3BARqy
 0K3M/7uKGVhEONgkBVTZLm2Lic1eE2rY1mUoRvMHFYmkCEMXJwCMJGjSgz/C2sz11hNsZiv+jX6
 puFJ90nRQTn1qR+czHUk/cs4Qn6wMjLcsW3Z+EH4X/zKc6xr01da3/bvq5e6efGt/DS2V9eYK55
 xAwA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Various networking features use MSG_SPLICE_PAGES to add pages to skbs,
whereby skb_append_pagefrags() takes a page reference for each fragment it
adds. Pages spliced from pipes were already checked when entering the
pipe, but in-kernel users like sunrpc pass pagecache pages directly. This
allows for exceeding folio refcount limits.

This is not specific to large pagecache folios, but with them it is a
lot easier to reach the refcount limit, as page table mappings can cheaply
create many references.

Let's use try_get_page() in skb_append_pagefrags() and fail with -EFAULT.
Don't use -EMSGSIZE, as TCP would just retry with a new skb. The only
caller, skb_splice_from_iter(), handles that.

Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 net/core/skbuff.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index f473c74956b8b..5e3f910eeea0b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4702,8 +4702,13 @@ int skb_append_pagefrags(struct sk_buff *skb, struct page *page,
 	if (skb_can_coalesce(skb, i, page, offset)) {
 		skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], size);
 	} else if (i < max_frags) {
+		/*
+		 * Don't use -EMSGSIZE, as callers would just retry with a new
+		 * skb.
+		 */
+		if (!try_get_page(page))
+			return -EFAULT;
 		skb_zcopy_downgrade_managed(skb);
-		get_page(page);
 		skb_fill_page_desc_noacc(skb, i, page, offset, size);
 	} else {
 		return -EMSGSIZE;
@@ -7575,8 +7580,9 @@ static void skb_splice_csum_page(struct sk_buff *skb, struct page *page,
  * possible, copying them to fragments if not possible (such as if they're slab
  * pages).
  *
- * Returns the amount of data spliced/copied or -EMSGSIZE if there's
- * insufficient space in the buffer to transfer anything.
+ * Returns the amount of data spliced/copied, -EMSGSIZE if there's
+ * insufficient space in the buffer to transfer anything, or -EFAULT if we
+ * could not take a page reference.
  */
 ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
 			     ssize_t maxsize)

-- 
2.56.0

