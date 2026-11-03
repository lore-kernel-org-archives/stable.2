Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722619;
	b=c/a7sbYSwuSIQ/S8LKEh8KjRNBfEVlybQF/GbFPLyCDU5qjqaA+eBwUvuzECk5XOFvuC
	 KuHN74983dR1PkSc+Iz3aitXNx+EhrMAHAR7drtb8bw7AJDUPnPCZPOKt+Q5woCGc00If
	 M135dSxdYsEErGMBXBK6bZu6xcE/kY9x3XzES7uAbfotXskyw14KJmEK507qM+9jOOBzh
	 l5URbAOb9WBiELXoooNMX3b6uCzwOZsZgTI9A+B9ACmpgTo1HpWImBRJ5pud5mIefp9mB
	 8HR8v1RhTt6cgRt4CPTVhnW3le7iVm1SAZJ8zbXSYPF9Y2KNAojUAxUc6s/8c8X6I1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722619;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=whRKP2FIGGX9uO7u5NRY0O5dJxVmBW+dlYUy2EeY3q8=;
	b=LyWXXQdh34u58mGcf+j/bgCfsz/5Nuvqv/oH/yS9yXSx1mdBVA3An1pQUm3/0xAY0aCU
	 VlU6UFWs34pcCPornYfIis8nWUpClt8Cy5Ku0tq7C5BibrrTRLXVxNQHZuCmD7y8rmud1
	 0dMoBQzoazTjvWRQ3IFQHEZKTCwFF3OPGhfd0IFojCem1IQkTG13ULpmDhsaD2Xk0u0dJ
	 x5ZxzoWPAvLZlu5Tos3sxi2oqqGi271F2HPuLu34oLPs7hCvGMKQbC4WmYEu3fiIMymKK
	 T0yiKgVk6yFCjFIA3apic5eXqzuyD/a93tuZ//0+5mLaiErmatgknXZjkAEZDcWGv6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMQWjn2H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06625606A336;
	Tue,  3 Nov 2026 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMQWjn2H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898111F000C1;
	Tue,  3 Nov 2026 16:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793722617;
	bh=whRKP2FIGGX9uO7u5NRY0O5dJxVmBW+dlYUy2EeY3q8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eMQWjn2HbyxpTB7teUSNvegEuUtHnNd+JtCXX81m2/Ivw32z4Hya1W4geoX9WP+5S
	 Zga728/RneF5FODP6/UVGz78KzTily9N+wqwZWE6YI0IAqFVPAXL+HJg5DNahQMwBp
	 JY3hYQ4Q0NPAGYzi44qYRtbnqVsdKNXLkR3ane9RVlY7CZq65xKxkraiZqV+ToYjey
	 b5e6owRmFxG4+RmiAno4IMIGpdn9ZxOlTtxXkrC+oWDrRmHddZVw43lk7dsJOvVZPv
	 2C+qK4SITdRHhtjeZw/pEWRh7fxEP+fBv0S1FojyIJvZ9Vb/D8MZ2mTaNxc6C9E25p
	 DM2EIV3YMNibQ==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Tue, 03 Nov 2026 17:16:47 +0100
Subject: [PATCH v2 1/5] mm/page_alloc: clear ->private of deferred free
 pages
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
Message-Id: <20261103-pgalloc-ai-hotfixes-v2-1-e0d2890ab74f@kernel.org>
References: <20261103-pgalloc-ai-hotfixes-v2-0-e0d2890ab74f@kernel.org>
In-Reply-To: <20261103-pgalloc-ai-hotfixes-v2-0-e0d2890ab74f@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>, 
 "Gregory Price (Meta)" <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0

From: Josef Bacik <josef@toxicpanda.com>

free_pages_nolock() and free_frozen_pages_nolock() put the page on
zone->trylock_free_pages if they get neither the pcp lock nor zone->lock.
add_page_to_zone_llist() keeps the order of the page in page->private.
The next free_one_page() which does get zone->lock passes these pages to
split_large_buddy() with ->private still set.

__free_one_page() writes ->private of the head of the resulting free page
only. If the deferred page is merged with its lower buddy, it becomes a
tail of that free page and keeps the order in ->private.

All other free pages which are not the head of a buddy have a ->private
of zero, and since commit 819bfbd47e49 ("mm/page_alloc: remove
set_page_private() in prep_compound_tail()") the allocator relies on it.
When the stale page is allocated again as a tail of a larger page:

 - prep_compound_tail() hits VM_WARN_ON_ONCE(tail->private);
 - with the page checks enabled, __free_pages_prepare() reports
   "BUG: Bad page state", "nonzero private", and leaks the whole page;
 - without them the value is seen by whoever uses that page next, e.g. as
   folio->private of a folio which is split off a large folio.

Only pages of an order above zero are affected. Those can be freed
through _nolock() by the stack depot (order 2) and by SLUB (a new slab
which cannot be added to the partial list by kmalloc_nolock()).

Clear ->private when the page is taken off the list.

Fixes: 8c57b687e833 ("mm, bpf: Introduce free_pages_nolock()")
Cc: <stable@vger.kernel.org>
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 55bd558306f5..41fd80c0c762 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1562,6 +1562,8 @@ static void free_one_page(struct zone *zone, struct page *page,
 		llist_for_each_entry_safe(p, tmp, llnode, pcp_llist) {
 			unsigned int p_order = p->private;
 
+			/* It may end up as a tail of the merged free page. */
+			p->private = 0;
 			split_large_buddy(zone, p, page_to_pfn(p), p_order, fpi_flags);
 			__count_vm_events(PGFREE, 1 << p_order);
 		}

-- 
2.56.0

