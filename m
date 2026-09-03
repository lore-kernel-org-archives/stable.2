Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE279417BDE
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788454760; cv=none; b=kVQnVbbgBASCuDm8YU8YK+adNgdZ28iBpKifQY9aTXiLQ1AIgg/VAHbd7ye23fpudiKbvknuv4aj1IHrVHhwyTdKLNllGtoBHq7eodpKKNJLscG2I0D1Bt95MPUNLxF26RPkNO2BTCnZXkeEGmp6O4bxjborsNoWJ6M0YbEF7a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788454760; c=relaxed/simple;
	bh=p859Lz4LPfKLU6LdoDYS5PEI9yeo/6mUdQf6jc4IY4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5YvX+xQD2cbBzNeXR7PWGuu0Zld4lihh67uKupUE+YgN9lX50Sto6d37MhKWURu7IRKQLsK9BC8dGiNgRf8lkV4TW8bWEs+twRhSEYiOon75hUhtSAATL+UJYenZGVsBr2ryWJ0i+22WIzK2mAaMMHeoZkhGug1N0KUSfoeETA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGn3uJwK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGn3uJwK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38F51F000E9;
	Thu,  3 Sep 2026 16:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788454758;
	bh=9049f1KBINPLMHFoqZ/ZvJzDObZgoflSLTzySpGKXRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TGn3uJwKAhtBDQ5B587m97T/oVJZ+W+PICveAAefS+iamqRPHIy+pEKW8vhyAHv7W
	 eKEfC8zTTq/WpAXS0Q9LK9J6SR/j/qcR6+bCqWo1Yd2I6E8nviCTLUx/LLjihsKtnr
	 HOayTrNHbhUd613G+IzmDjd3XOPhvh+IOXFzOv2KnQRP5hMwjXOXU8xylb19QboQGW
	 +PHT7zb3dcsxNvq+au6FF088rtz1oU6VBHR7bd6bCI5FQqZCYkF7LugGq1Fj0HZq5u
	 3z3tBN/2/aSIi2PDS2veTTqLJIrhSTe/YNunRu2AZL3Zfo6JOpGAqwkE3zX1ZV4f9n
	 rVvOP7l7ZbbWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kiryl Shutsemau <kas@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Usama Arif <usamaarif642@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Baoquan He <bhe@redhat.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Frank van der Linden <fvdl@google.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	WANG Xuerui <kernel@xen0n.name>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/5] mm: rework compound_head() for power-of-2 sizeof(struct page)
Date: Thu,  3 Sep 2026 12:59:10 -0400
Message-ID: <20260903165914.1085906-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090320-cufflink-ambitious-4582@gregkh>
References: <2026090320-cufflink-ambitious-4582@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kiryl Shutsemau <kas@kernel.org>

[ Upstream commit 8c846c879e226c312c2c7a7bc1e323779903530f ]

For tail pages, the kernel uses the 'compound_info' field to get to the
head page.  The bit 0 of the field indicates whether the page is a tail
page, and if set, the remaining bits represent a pointer to the head page.

For cases when size of struct page is power-of-2, change the encoding of
compound_info to store a mask that can be applied to the virtual address
of the tail page in order to access the head page.  It is possible because
struct page of the head page is naturally aligned with regards to order of
the page.

The significant impact of this modification is that all tail pages of the
same order will now have identical 'compound_info', regardless of the
compound page they are associated with.  This paves the way for
eliminating fake heads.

The HugeTLB Vmemmap Optimization (HVO) creates fake heads and it is only
applied when the sizeof(struct page) is power-of-2.  Having identical tail
pages allows the same page to be mapped into the vmemmap of all pages,
maintaining memory savings without fake heads.

If sizeof(struct page) is not power-of-2, there is no functional changes.

Limit mask usage to HugeTLB vmemmap optimization (HVO) where it makes a
difference.  The approach with mask would work in the wider set of
conditions, but it requires validating that struct pages are naturally
aligned for all orders up to the MAX_FOLIO_ORDER, which can be tricky.

Link: https://lkml.kernel.org/r/20260227194302.274384-8-kas@kernel.org
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Usama Arif <usamaarif642@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: Baoquan He <bhe@redhat.com>
Cc: Christoph Lameter <cl@gentwo.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Frank van der Linden <fvdl@google.com>
Cc: Harry Yoo <harry.yoo@oracle.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: WANG Xuerui <kernel@xen0n.name>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

[ stable: Drop the original compound_info conversion, which depends on
  preparatory interface changes absent from this tree and is not needed by
  the target fix.  Move the stable-only HVO static-key increment ahead of
  the target's context without changing its behavior. ]

For tail pages, the kernel uses the 'compound_info' field to get to the
head page.  The bit 0 of the field indicates whether the page is a tail
page, and if set, the remaining bits represent a pointer to the head page.

For cases when size of struct page is power-of-2, change the encoding of
compound_info to store a mask that can be applied to the virtual address
of the tail page in order to access the head page.  It is possible because
struct page of the head page is naturally aligned with regards to order of
the page.

The significant impact of this modification is that all tail pages of the
same order will now have identical 'compound_info', regardless of the
compound page they are associated with.  This paves the way for
eliminating fake heads.

The HugeTLB Vmemmap Optimization (HVO) creates fake heads and it is only
applied when the sizeof(struct page) is power-of-2.  Having identical tail
pages allows the same page to be mapped into the vmemmap of all pages,
maintaining memory savings without fake heads.

If sizeof(struct page) is not power-of-2, there is no functional changes.

Limit mask usage to HugeTLB vmemmap optimization (HVO) where it makes a
difference.  The approach with mask would work in the wider set of
conditions, but it requires validating that struct pages are naturally
aligned for all orders up to the MAX_FOLIO_ORDER, which can be tricky.

[ sashal: Reduced backport -- upstream 8c846c879e226 touches 3 file(s), this
  backport carries 1. Not backported here:
  include/linux/page-flags.h
  mm/slab.h
  mm/util.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 6e25c6a9c7ef ("mm/hugetlb_vmemmap: fix __hugetlb_vmemmap_optimize_folios()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb_vmemmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 96ee2bd16ee15..dd3f8438a9b64 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -664,6 +664,8 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
 		unsigned long spfn, epfn;
 
 		if (boot && folio_test_hugetlb_vmemmap_optimized(folio)) {
+			static_branch_inc(&hugetlb_optimize_vmemmap_key);
+
 			/*
 			 * Already optimized by pre-HVO, just map the
 			 * mirrored tail page structs RO.
@@ -675,7 +677,6 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
 			register_page_bootmem_memmap(pfn_to_section_nr(spfn),
 					&folio->page,
 					HUGETLB_VMEMMAP_RESERVE_SIZE);
-			static_branch_inc(&hugetlb_optimize_vmemmap_key);
 			continue;
 		}
 
-- 
2.53.0

