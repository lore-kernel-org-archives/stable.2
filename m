Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975C441D107
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788460027; cv=none; b=AEKAWVEaw4XntRjYhze80nIV5dk+wH+i8SqTHPJKICb5cqxSwaf+vMOcQhS/tXYK25eDWHQ+SrTS+8UbWz5nDiWsNg+RtLKVsW117ZpLrvPmtCUZZQo1G22EugVxoNtjHxTwy6v5i9JZqYZRdcvol/jotCCNOwaiKwuT9YFHcnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788460027; c=relaxed/simple;
	bh=WesBX0Z3YeJAFaKj/ADVDFAZ4nBpYRBcDN18M52ne90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijpPw0tSGDBaWj51zrkMyOWzS+4vBxePTcBlZwhD3NrH/UzS17Vaqaf6JHzbHhhm63bu3QYSjju2xW2Vsq46EdHVXgTbbGyCpwy0ZwZr7acRsXS7G9h7gcl6zchbinpp/rt3SUilyPTcVvJWxxz745wiARMmIdQiJBPSFsRbuaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DafRXneN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DafRXneN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0EC1F00ACA;
	Thu,  3 Sep 2026 18:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788460024;
	bh=OB/9jYnmmXNpzz1AKne/njI9aQs0zqDqjQYZSrZYwBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DafRXneNXo9r2oC+u6aL1ukPf/ZcKw5Sgvf3QVSHK4tdHWRUNmLFy1xcSDoXBwQ7v
	 fGleEm0/9gwTBrTP2HM3s7oc4HEOGHLzXyJOJ0//aNYv5U4RBo2jdFNa7DK2Z+yMF7
	 imlkbx7o89rQW5yi84xjmuNtG2e3p4pXN+xZ7bRIh+XfSPdVDANYXGWyz+13f9pydo
	 XV5d9nL954Ftm7fvpGKmXPEVW/hjaUZFa+UERwy0wRxj+/YeUv3bqqGIFyS4FXwnZd
	 kwdK3AhjCs5Dl8PdrBxmcGtZevRXSSC6kkLxKPuS3TpKSWjNHpxcO/gw+bQGD9CX69
	 4MXLxVQ6G0Q3g==
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
Subject: [PATCH 6.18.y 6/6] mm/huge_memory: use folio's memcg inside __folio_split()
Date: Thu,  3 Sep 2026 14:26:50 -0400
Message-ID: <20260903182650.1451393-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903182650.1451393-1-sashal@kernel.org>
References: <2026090356-glacial-cornball-be8c@gregkh>
 <20260903182650.1451393-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/huge_memory.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4febfb980e2b0..1b4134c57d007 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3694,34 +3694,42 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
 	struct folio *end_folio = folio_next(folio);
 	bool is_anon = folio_test_anon(folio);
+	struct mem_cgroup *memcg, *old_memcg;
 	struct address_space *mapping = NULL;
 	struct anon_vma *anon_vma = NULL;
 	int old_order = folio_order(folio);
 	struct folio *new_folio, *next;
 	int nr_shmem_dropped = 0;
 	enum ttu_flags ttu_flags = 0;
-	int ret;
 	pgoff_t end = 0;
+	int ret;
 
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_large(folio), folio);
 
 	if (folio != page_folio(split_at) || folio != page_folio(lock_at)) {
 		ret = -EINVAL;
-		goto out;
+		goto out_no_memcg;
 	}
 
 	if (new_order >= old_order) {
 		ret = -EINVAL;
-		goto out;
+		goto out_no_memcg;
 	}
 
 	ret = folio_check_splittable(folio, new_order, uniform_split);
 	if (ret) {
 		VM_WARN_ONCE(ret == -EINVAL, "Tried to split an unsplittable folio");
-		goto out;
+		goto out_no_memcg;
 	}
 
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
@@ -3989,6 +3997,10 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	if (mapping)
 		i_mmap_unlock_read(mapping);
 out:
+	/* restore to caller's old_memcg */
+	set_active_memcg(old_memcg);
+	mem_cgroup_put(memcg);
+out_no_memcg:
 	xas_destroy(&xas);
 	if (old_order == HPAGE_PMD_ORDER)
 		count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
-- 
2.53.0

