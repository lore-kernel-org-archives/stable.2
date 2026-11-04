Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807873;
	b=Fi3JOOs8VKzhF9/zAAEblv4qD1HIh28ewSxEwDeSG6S89QugxNWBrrjRPpHhyMEH/CgZ
	 YYPgDK5kQ67tHy83kKbt8ZFivACMl3Q2G6a25GuIVrYdo7HlJEROd7UlN+Cgn7AoWRw4X
	 AXY6xaGN7g1nOrwQ8S8+7HhXvmj2R3CVrAobg89YJEqNxZqANWt7uDDQGdDPFfaG2BExb
	 5rZWX5sZ7DzvaCKg4iaNWR7TWqtkQzpseiUoNygkHYUXOsjYF/Kx6CIrQ54Sg1Z+8rYzL
	 MXNHs7zNlEQwcJOm8jkEg3XCQYB5vZsnBYI6YUjs/R8AtjrKL2s1owDj5xlGlWrFyRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807873;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PjKfK9lFpy8OfPJsRfQH6HcluTUTVSvczIy7XWdUbDs=;
	b=trJz4XlpOPBY82ASvfE+hoY8i8eagCo5jxATBONfy9fTT1NjrKZllyYza/k4/LGorS87
	 zmMIwlFx3otPdGblXvfAofh1kB8H0OCo+BrxL59K9NdXnWgdS31MsboWYFb9VJ52hyGqL
	 uXZSCT0V3Th8uIZMNJSGpV+KUlMzhPLeQOUlxN14FEyn+1sTPxxK93COmxY59op7rTSDL
	 kIR5to0/F6UscbKVsgUJ1Xm/6wdK5vDO1g6EpQNgwFNoJk3QaaPyHqw6JBHxw5oJb0Aq9
	 k8ne38TslmGgN5OanFVsUIAiHBcy00qU1mQjx7WSUQeNSRtKY6inpGsqBmBghAWFb4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OM4+o8lU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE556082BC1
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OM4+o8lU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23ADC1F00A1B;
	Wed,  4 Nov 2026 15:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793807873;
	bh=PjKfK9lFpy8OfPJsRfQH6HcluTUTVSvczIy7XWdUbDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OM4+o8lUpuXN7sIk2JZajFny5tyZe73jrJTzXEJYusMa7fZZ+iO21Rl7LJIwOC3NQ
	 NW+ATF2ozQ7vxda5etYnJEu/JPUTrX8WQOFNmWNPa2d8J0B5JUKJScpqhs/Lc0UNBN
	 uKT2uuMBVIxngkJpXDIAhE2IqYAD7QGeIy9e4ASyeDr8/TIxZ+5xAtIONrzW76Vfnb
	 t749k0FYa97Ig2HWl29Br93NJee48f9DFegZNIdOl8o4E1gvqbotMXpSnEOk9Z6woP
	 vxKlRtN/eYlnoELWBEAYWZ8jodfoHXVtuYQvosCnJX0N3HPMOM5vBPdc/MMvLG7Hlc
	 L4mvte3+2QXow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Lance Yang <lance.yang@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Oscar Salvador <osalvador@suse.de>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Adam Litke <agl@us.ibm.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Rik van Riel <riel@surriel.com>,
	Peter Xu <peterx@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/hugetlb: fix use-after-free in hugetlb_mfill_atomic_pte()
Date: Wed,  4 Nov 2026 10:57:49 -0500
Message-ID: <20261104155729.3920030-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110446-swimmer-stimulate-cc19@gregkh>
References: <2026110446-swimmer-stimulate-cc19@gregkh>
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

From: "David Hildenbrand (Arm)" <david@kernel.org>

[ Upstream commit d8a9cd7fd2fb01211430c933932da58839b8ca65 ]

Let's fix another instance where we use a folio after dropping the PTL,
where someone else could e.g., MADV_DONTNEED it once we drop the PTL,
making us trigger a use-after-free on the folio.

Link: https://lore.kernel.org/20261015-urgent_fixes-v1-3-42796911043b@kernel.org
Fixes: cb6acd01e2e4 ("hugetlbfs: fix races and page leaks during migration")
Fixes: 1c9e8def43a3 ("userfaultfd: hugetlbfs: add UFFDIO_COPY support for shared mappings")
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Adam Litke <agl@us.ibm.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: <stable@vger.kernel.org>
[ sashal: Adapted folio operations to the existing struct page API in hugetlb_mcopy_atomic_pte(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fc26639f87dc5..de805b385d06b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6428,11 +6428,16 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
 
-	spin_unlock(ptl);
 	if (!is_continue)
 		SetHPageMigratable(page);
 	if (vm_shared || is_continue)
 		unlock_page(page);
+
+	/*
+	 * Hold the PTL until we're done with the page: the page table owns the
+	 * page reference now.
+	 */
+	spin_unlock(ptl);
 	ret = 0;
 out:
 	return ret;
-- 
2.53.0

