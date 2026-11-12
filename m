Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794524157;
	b=dvmjddT6yg0xMQZgaeSanANAdq+WjNiCaZzJQknlnbbNiQvYmh35QrycNtKdm+vzjYm+
	 IopjXpk4ozWW6z+mLvup88oYFhO96avU71UQ0hv0ssjfUjFKqVwKwfFH6actcRqc5POoe
	 tufZMaqL4elx1nWu5Bd3MFlBx1sf90VnRYiZMvFGzYjN8NNyw3Y22Jf9mK6f175QqxOwL
	 itMuwQ23+7wWwPLbWRmxYMztwVUEhSDsgavXl4d2pxh2tNiZ970/96tY8EfvnVzDW3hmF
	 WQMB1FjHkbVgKcWhhQYyalHQ6Y0qqBs62m7pdkD1o3AVBXJn9PzetRrY+/s0oBjnp0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524157;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=WzTgpej2ncx6QIZIb4B0vfziYK/NSwfzxDGBK1Sb5Mo=;
	b=uCWuRiqok6tLO/YiBqAfoVsEMIILe+yuh9sPRg5QC2ZtbXwlYigvL8HWGtpnxJ/KexiF
	 MZ5IubpF1MVtGQrqwoClaK5xZYnzUkKY8e4bLJLvI0xgswcc1GUXcsoM0Ns7l2U9YIymP
	 VH/iyhaI93ej/nrhP6IzFUfJW4bh3WoDW30cXEDlrneEnI5lbVt+J+OtP0d+6hglgEWxN
	 suyhEUAtRX1d03w0PO6vFGcmj55Z7/XtNRo21dFd1y1cUpSY9bbBtOGhVGHysDdar7mtb
	 ntHHK6dgZ5BB9M2RrI2glH8Kmv1Wl1SpueMHOeFvONRFxqHEzYmtgstAKVVQtbZyKlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RV3Wjhhc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762B7606A32A;
	Thu, 12 Nov 2026 22:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RV3Wjhhc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15E11F000C5;
	Thu, 12 Nov 2026 22:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794524157;
	bh=WzTgpej2ncx6QIZIb4B0vfziYK/NSwfzxDGBK1Sb5Mo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RV3Wjhhc6lK7WFK/QqSJvzulZIbg/SvBnBx3dyr9yRolSAvY3JdrvpiEnkiJ2eN0U
	 o05/7nm33X6FanTpy7kc3vyq9bk/2PhRyP/p+BZb1niT77XpJEcvwat/0ct5n/T7Rn
	 NsZz18nRD3HcHHk4LdQulo3PpHsGxk34auD9+CyT6v2t8FKZeH19domrRGbxmq+bhL
	 HG5ocw1khCU97pHVNr6E8jbS02KxXxxNO4EmaNBRfHnkTu/LSNSAkScZDyqesbSVD9
	 7jRaG9/mJ4otNeg3G3zH0R4+YFmT06VN2pkTwXjAiH5E3wfkDKg6fjOv97gXkrNWj0
	 fJn/jSlaeuKeA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 12 Nov 2026 23:53:27 +0100
Subject: [PATCH v4 8/9] net: limit folio refcount when splicing pages into
 skbs
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
Message-Id: <20261112-refcount_overflow_stable-v4-8-ad3deef0bd23@kernel.org>
References: <20261112-refcount_overflow_stable-v4-0-ad3deef0bd23@kernel.org>
In-Reply-To: <20261112-refcount_overflow_stable-v4-0-ad3deef0bd23@kernel.org>
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
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 fuse-devel@lists.linux.dev, linux-arch@vger.kernel.org, 
 iommu@lists.linux.dev, netdev@vger.kernel.org, stable@vger.kernel.org, 
 Pedro Falcato <pfalcato@suse.de>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2437; i=david@kernel.org;
 h=from:subject:message-id; bh=2HIVuRJemzSar8UdUmReSo7kyB3JDSJ5ToRfjKbRBOI=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLK+OWf1PDr6KcJKb/52PYHbuw2PHj399hVnfKbJfLaef
 HXVC64WHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEzEJIrhD5eqTtHJ0jVXewXm
 m3DxrJ/HxcBz0OObysLvTItenzivx8XwT32S4UHWfZdm7bnYtaXSeO+j//xK9fN0b1deez8h1t7
 gGwcA
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
Acked-by: Pedro Falcato <pfalcato@suse.de>
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

