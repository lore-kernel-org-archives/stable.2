Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188202D7DEA
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788474632; cv=none; b=mEjPg/dVCr+HAEogm40loMS7KRfBk2tKa3vVhRF8kECv/M9prSw9HDrbSMSd+Q4dFzAGnodjS8lH9BtsH77RU7o+nFhZHmgBlks+a592pqMVAdH8vdUg1tHAW3TdsfY1whhuNedK8Lw3mcBjayCPd+LLZiktMTyd/PntHzk+wu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788474632; c=relaxed/simple;
	bh=2h47qMjyxdS3T8zwojcPkFqvHK2NmEQMX3U4xK802z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYUtVFqmnPUGF0a2LkPc9GtIVlnAgBHD+LMFk45/DbmBXme6IK6TyhUFc75sVV8ftemE8wvSteukS44JkLfXa4ZSehJISY+TkkaAo+8MGLJYwUyZM3i0XB10eAGImgv/8mQMHkhFNSmydAoFb+x66HQDaEdSdYpzh9DIj9DHT/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tsiba3ax; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tsiba3ax"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C2D1F000E9;
	Thu,  3 Sep 2026 22:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788474630;
	bh=ec25fcjCHf9o9eX6mZ1KL/YcNwTGTI25vYGng/Ktjtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tsiba3axczYlRFlTixEA9tZtDEyQB1e/6k5/V8F5rdioUskIsZXn6UQXoCEQ4BJ5s
	 FzEdJzL2/UhRR2ZpKXBpBpHWKt+DrHLvXOZwKPDT7Y+wTBVfgKlMzhc2gwO8Arq1hN
	 R1Ff50WZqMH13d9hKwlX0khIPym42EWnLSALS0kxl1spJcXf9zaJItg7HnQOsLHiqz
	 1LfiuulWf/t4O9VXbKLxLNkpXah/HsCi7kaJuU0PCB7rkWd5ueNDX7hd5IqfiF90iQ
	 ln6cvhjHOt0y7liDNWSZO/61qHEqW9j9QNKHnybrJo8uURIfPEzkyXcMXNbUvs4rlO
	 CXZGq2Y2/tX8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zi Yan <ziy@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	William Kucharski <william.kucharski@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/huge_memory: use folio's memcg inside __folio_split()
Date: Thu,  3 Sep 2026 18:30:27 -0400
Message-ID: <20260903223027.1739434-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090357-tidy-granite-4a68@gregkh>
References: <2026090357-tidy-granite-4a68@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zi Yan <ziy@nvidia.com>

[ Upstream commit c299a2285d9d8bda4da024455de65e3d00de6f17 ]

Patch series "Honor XA_FLAGS_ACCOUNT in xas_split_alloc() and charge to
folio's memcg", v3.

__GFP_ACCOUNT is needed for xarray node allocation accounting when
XA_FLAGS_ACCOUNT is set. Commit 7b785645e8f13 ("mm: fix page cache
convergence regression") fixed a workingset regression with it.
xas_split_alloc() does not have it and needs to be fixed.

In addition, based on Sashiko's review[1] and Johannes' confirmation[2], to
charge the right memcg, folio's memcg needs to be active during folio
split. Add that before adding __GFP_ACCOUNT.

There is no workingset convergence regression related to missing
__GFP_ACCOUNT in xas_split_alloc() and the impact to userspace should be
minor.

This patch (of 2):

During a pagecache folio split, an xarray node allocation can happen and
needs to charge at folio's memcg instead of folio split invoker's memcg,
because for example folio split can happen during reclaim and reclaim's
active memcg might not be folio's memcg.  Switch to folio's memcg at the
beginning and switch back afterwards.

Link: https://lore.kernel.org/20260804-add-gfp_account-to-xas_split_alloc-v3-0-38cb3ff325c5@nvidia.com
Link: https://lore.kernel.org/20260804-add-gfp_account-to-xas_split_alloc-v3-1-38cb3ff325c5@nvidia.com
Link: https://sashiko.dev/#/patchset/20260727-add-gfp_account-to-xas_split_alloc-v1-1-9fae6bf64838%40nvidia.com?part=1 [1]
Link: https://lore.kernel.org/all/amtcBZ-_QVRgCd6b@cmpxchg.org/ [2]
Fixes: 6b24ca4a1a8d ("mm: Use multi-index entries in the page cache")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Barry Song <baohua@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: William Kucharski <william.kucharski@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ adapted the active-memcg scope from __folio_split() to split_huge_page_to_list_to_order() with shared out-path cleanup. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/huge_memory.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 29cbe43b60a4f..9e6df0a141621 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3418,6 +3418,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	/* reset xarray order to new order after split */
 	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
 	bool is_anon = folio_test_anon(folio);
+	struct mem_cgroup *memcg, *old_memcg;
 	struct address_space *mapping = NULL;
 	struct anon_vma *anon_vma = NULL;
 	int order = folio_order(folio);
@@ -3481,6 +3482,13 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	if (folio_test_writeback(folio))
 		return -EBUSY;
 
+	/*
+	 * switch to folio's memcg as xarray node allocation can happen and
+	 * needs to charge to it.
+	 */
+	memcg = get_mem_cgroup_from_folio(folio);
+	old_memcg = set_active_memcg(memcg);
+
 	if (is_anon) {
 		/*
 		 * The caller does not necessarily hold an mmap_lock that would
@@ -3627,6 +3635,9 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	if (mapping)
 		i_mmap_unlock_read(mapping);
 out:
+	/* restore to caller's old_memcg */
+	set_active_memcg(old_memcg);
+	mem_cgroup_put(memcg);
 	xas_destroy(&xas);
 	if (order == HPAGE_PMD_ORDER)
 		count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
-- 
2.53.0

