Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794238008;
	b=d7IkhZQkLNjNpVnkpOhIsO6NVlkPsAY+Y3lOCQL/HdcRNbxgdp2zuyYZLNEdgK6eQUOP
	 4RalTOM9PAED06vtAZsM1pjJ/K6Pko4d+xSd7tMP67Q4pc31cgdqztRVAjuZDaqQX4nHD
	 Si/Pa9OSp0N+rAJ4bUBnkr83a89rI6x0IB5iy0I7olB0AG3ruXpJGjnchNbVF8jlUvHyH
	 xj+dn1AZgMhOG8u4ggSg0p3SwL0Zrm7NUh5WUvy6dY+iZT+xKPJg7aOeWU2EvB+b3wLYC
	 QeSXPbXAJEafA4Fr3R1LTRVA6EjGKQr9xxUU4PWqBG/ehbZs08kFc4pyDFUUCAwfevA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238008;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=asWzf2+UXk4RswQoUFEg3HcDx7Ooefood5koUbks5Pw=;
	b=5rgRWy1GdsxLGJJcPHXnKjwyvFQm49vNSTRpp9GyrEpNa8UKZ/vdZZhmMRrXI9FImedY
	 qhAwNeuirA9S7x//PFPh0cwR9VkBEGF/pYpJOCVWvjmyXSTBFwkdkRQTm7QTWZJ5zzbXE
	 kzT2KS2xMgaJP5Oapa4ISie8mCOYiAYvPHWi2Y7hkqYM/idq1Ufl+5htvw+xWIzuu1tGT
	 aD8k92LxXkjyW4aHCVdf5mFVkj7YoPX1l2EIksn9CuHTbdAGHMVH8YZRnHh8U7B4GykvJ
	 yWUGcSCTBZ9bZ0cDO9ap1zeTPXxhtS91RR7YsXN5hHn871XWQMtg0kXcenewM0CWL3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D63BpG3L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053C1606A321;
	Mon,  9 Nov 2026 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D63BpG3L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6771F0089F;
	Mon,  9 Nov 2026 15:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794238007;
	bh=asWzf2+UXk4RswQoUFEg3HcDx7Ooefood5koUbks5Pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D63BpG3LlxVxyNM9vrDuoWlOnfevHgN2GeyBpkEg4Nb2i8d0rtnvuBdKwx382gfiU
	 L/VPXdlcMJCqd3q3arwoLzHEmP4/E0bNdoWsLuraMEvdWbs03Hhfb0wx+p2hwBh1Cs
	 dNMvfrZ1CAK8+RtA+u17BVvq5cAL35cTdS2M5rbuOPmy3w1hu7GU0k5+gyldsI6tR1
	 Z+L6URWnXctpBOlcs3Nv7TU/XP0/3drWDqhf7AV6PpUxnqAmEIPMKcqk9QeMLDdNOq
	 WWNpEl4km/aENbJpOdAbTbhCL0VmFD1PfeQLusedm/RFZWpgXt9roJPrW4+k4fkxEH
	 DH+J5ukDw5org==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id 69F59198003A;
	Mon,  9 Nov 2026 10:26:41 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 09 Nov 2026 10:26:44 -0500
X-ME-Sender: <xms:MObxaj3HuNElXR88n2fGY8f18V5fMs1ReeNXEzVOb9TXJBRMa41jHA>
    <xme:MObxarR4phJyHNKXVDt2aSVmBvW6TtWbJ95ey3izxgMxoL6hLgjIJXEZJUaYSnm2J
    jueqem3Z_Sw8Ti13ZlFKFloQ42r6xxRc6GA7-Khl7spjGHpq__QawU>
X-ME-Received: <xmr:MObxaoJPMHwFovSeKyBGLLIFqADFqQS4oqF7Xpk0wDfhd4ebAoMRPG3Kj5g>
X-ME-Proxy-Cause: dmFkZTFsB1wl+SZijovTOdQmTWcJflC0w37VJalRRewiWniznqePFWh2dph+ba66rHa3rp
    UY3KjOfMosjnWlCDYVkl/UEar8H8ytgzKVGrpzw3Oa05+uXuJKbkavCb6L4z4wwQg8jIQW
    sOtqku/3BHy42OpLTIyypz9+RzjjkMPkx9ODI7ystBB193bd+XwdneWq6uyDZLqXUvKfE8
    7ME4WecH9YMmoW/iNOZjEkz7yJhfjRyvyo8B1YMlgzL/mx+Nz1cZQDR/lvRr/b9xVeTaYF
    51emEKpnAMhOLN9MQlOWZny+gEBpyGKNdafaxzSRx9xyfC4bJ4xinSD8o/kVCYE5dAUWRv
    AyhC1+uSa51AGck/rdqkaCW02T0UqJeyvYprzmgmvtBiUpG8keo+fsSKuGnUpdy74zI4ag
    4XhWnxgZK8a3kEpUPY5yIElxaLLfcM0pLElYTpPrDTef3C6R9SrpJ8z6h4yeidEB/nWtw+
    XAGKEV1wCL5blcfEW0AHcy2bUnwrmD32nqhVhbrx4+wjSxf+Jjv5H+82io4DWhFpXG6pR6
    I999cy/qGVf8apauXHSfT6SpErnDD3CUmuI7m01bz9u/iLOQXstE2Vgk1AL4hD/qhSOVOs
    d2VdiHOyQyKuy4sFHwZ88yD4p+4xhOF0ekQ8FtAPMAL2+SuH3U9cS4qFZt1A
X-ME-Proxy: <xmx:MObxaumoQF9TLCdX1x-FyLti5FLln9oZZnt1YgCkrKyWxjurK3R-2g>
    <xmx:MObxahh4RDmzTkFCHQz3n4GQyl6RW_oRa46XL6f6plR1YcM9j0S-hw>
    <xmx:MObxakqm3NwEiPt5uZoKeRrDj4NatGB_QI7McgERiudmtO--IDuNNg>
    <xmx:MObxagvZSwSdkW63tN_kcHRVYFVWV1QGbfxl4ImgS7xUZaLb35pVZw>
    <xmx:MObxases-Bn1IqbGqOJ1DEEhY1BxA3tWEgKS9lranEJGaC1CA7Z5lM0l>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 10:26:40 -0500 (EST)
Date: Mon, 9 Nov 2026 15:26:39 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Brendan Jackman <brendan.jackman@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Ye Liu <ye.liu@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/huge_memory: prevent losing PG_waiters in
 __split_folio_to_order()
Message-ID: <avHktSBkWvQSakji@thinkstation>
References: <20261106-fix-split_folio_to_order-race-v2-1-1b59c67b8af3@nvidia.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106-fix-split_folio_to_order-race-v2-1-1b59c67b8af3@nvidia.com>

On Fri, Nov 06, 2026 at 01:28:46PM -0500, Zi Yan wrote:
> __split_folio_to_order() calls prep_compound_page() on each new head page
> to create a compound page after clear_compound_head(). prep_compound_page()
> uses non atomic __SetPageHead(). It is mostly OK, since the folio is locked
> and frozen and no one else is supposed to modify the folio's flags.
> 
> However, code calling migration_entry_wait() can reach the folio by PFN,
> then access its flags. It is because softleaf_entry_wait_on_locked() used
> by migration_entry_wait() sets PG_waiters concurrently without taking a
> reference and the frozen refcount during split cannot block it. Meanwhile,
> __SetPageHead() does a plain read and write, so PG_waiters atomically set
> by softleaf_entry_wait_on_locked() will be lost if the set happens after
> __SetPageHead()'s read and before its write.
> 
> One example code interleaving:
> 
> CPU0: __split_folio_to_order(new_order>0)  CPU1: do_swap_page()
> 
> 1. clear_compound_head(new_head)
>    new_head->compound_info = 0
>    (page_folio(new_head) == new_head now)
> 
>                                            2. migration_entry_wait()
>                                              softleaf_to_folio(entry)
>                                              page_folio() -> new_head
>                                              (not the old head any more)
> 
> 3. prep_compound_page(new_head, new_order)
>      __SetPageHead(new_head)
>        tmp = new_head->flags.f  <-- load; PG_waiters == 0 in tmp
> 
>                                            4. folio_set_waiters(new_head)
>                                              set_bit(PG_waiters, &flags.f)
>                                              enqueue on waitqueue, sleep
> 
> 5.     new_head->flags.f = tmp | (1UL << PG_head)
>        <-- store; overwrites step 4, PG_waiters == 0 again
> 
> Later, folio_unlock(new_folio) sees no PG_waiters, skips folio_wake_bit(),
> and CPU1 can remain blocked indefinitely.
> 
> Fix it by adding the atomic version SetPageHead() and
> prep_compound_page_atomic() using it. __split_folio_to_order() uses
> prep_compound_page_atomic() to avoid the issue without adding an atomic ops
> to other prep_compound_page() users.
> 
> Reported-by: David Hildenbrand <david@kernel.org>
> Closes: https://lore.kernel.org/all/DMHE8BEEER1H.2BIY52NXATPIA@nvidia.com/
> Fixes: c010d47f107f6 ("mm: thp: split huge page to any lower order pages")
> Cc: stable@vger.kernel.org
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
> The issue was raised by David when reviewing Ye Liu's "mm/huge_memory: use
> READ_ONCE() when cloning folio flags during split" [1].
> 
> [1] https://lore.kernel.org/all/20261029-data_race_huge_mem-v1-1-112e331291c1@linux.dev/

Sorry for late reply, I only now got to this.

Setting PG_head atomically on its own looks odd to me. The comment above
smp_wmb() already says page flags must be visible before the page becomes
non-compound. prep_compound_page() writing PG_head after
clear_compound_head() is what breaks that.

Can we build the whole flags word for the new head, PG_head included, and
store it once before smp_wmb()?

After clear_compound_head() only the tail and head setup is left, and it
does not touch new_head->flags. Then SetPageHead() and
prep_compound_page_atomic() are not needed.

This was option 2 in your analysis[*] on Ye Liu's READ_ONCE() thread,
but I don't see a barrier problem.

PG_head gets the same ordering as the cloned PG_locked, and
softleaf_entry_wait_on_locked() already relies on that through the same
smp_wmb() and page_folio(). The new head carries PG_head for a moment
while it is still a tail, but page_folio() only looks at compound_info.

Reading the old head's flags with READ_ONCE() while building the word
would also cover Ye Liu's KCSAN report.

Something like this, on top of the v2 base, compile-tested only:

[*] https://lore.kernel.org/all/DMHE8BEEER1H.2BIY52NXATPIA@nvidia.com

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bd44d58e8684..53786b2abe89 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3714,6 +3714,7 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
 		 * Don't pass it around before clear_compound_head().
 		 */
 		struct folio *new_folio = (struct folio *)new_head;
+		unsigned long flags;
 
 		VM_BUG_ON_PAGE(atomic_read(&new_folio->_mapcount) != -1, new_head);
 
@@ -3730,8 +3731,8 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
 		 * unreferenced sub-pages of an anonymous THP: we can simply drop
 		 * PG_anon_exclusive (-> PG_mappedtodisk) for these here.
 		 */
-		new_folio->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
-		new_folio->flags.f |= (folio->flags.f &
+		flags = READ_ONCE(new_folio->flags.f) & ~PAGE_FLAGS_CHECK_AT_PREP;
+		flags |= READ_ONCE(folio->flags.f) &
 				((1L << PG_referenced) |
 				 (1L << PG_swapbacked) |
 				 (1L << PG_swapcache) |
@@ -3749,7 +3750,16 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
 #endif
 				 (1L << PG_dirty) |
 				 (1L << PG_dropbehind) |
-				 LRU_GEN_MASK | LRU_REFS_MASK));
+				 LRU_GEN_MASK | LRU_REFS_MASK);
+
+		/*
+		 * Set PG_head here, not after clear_compound_head(): from then on
+		 * softleaf_entry_wait_on_locked() can set PG_waiters on new_head
+		 * without a reference, and a plain write would lose it.
+		 */
+		if (new_order)
+			flags |= 1L << PG_head;
+		WRITE_ONCE(new_folio->flags.f, flags);
 
 		new_folio->mapping = folio->mapping;
 		new_folio->index = folio->index + i;
@@ -3779,7 +3789,7 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
 		 */
 		clear_compound_head(new_head);
 		if (new_order) {
-			prep_compound_page(new_head, new_order);
+			__prep_compound_page(new_head, new_order);
 			folio_set_large_rmappable(new_folio);
 		}
 
diff --git a/mm/internal.h b/mm/internal.h
index aeebb3e49ed1..4ce67ce2f3fb 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -807,6 +807,8 @@ static inline void prep_compound_tail(struct page *tail,
 	VM_WARN_ON_ONCE(tail->private);
 }
 
+void __prep_compound_page(struct page *page, unsigned int order);
+
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 
 /*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 143776e671ab..37768fa5341b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -683,11 +683,17 @@ static inline bool pcp_allowed_order(unsigned int order)
  */
 
 void prep_compound_page(struct page *page, unsigned int order)
+{
+	__SetPageHead(page);
+	__prep_compound_page(page, order);
+}
+
+/* Set up the head and tail pages of a page that already has PG_head */
+void __prep_compound_page(struct page *page, unsigned int order)
 {
 	int i;
 	int nr_pages = 1 << order;
 
-	__SetPageHead(page);
 	for (i = 1; i < nr_pages; i++)
 		prep_compound_tail(page + i, page, order);
 
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
