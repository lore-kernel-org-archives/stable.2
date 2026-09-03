Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B54D4AF9C0
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788460027; cv=none; b=qCOtvvCUKnrl0bJrV/OPhrR0YfyJveGoJULULiNDFFWh3dyOZM2Xk+fX3tjcaoBau14PhPkQd5g0+mQ98dt3NeO2IK9rHQ+GdvVzeRWEWSCZ6aNflDy7u3RcfO+Vq8J6QtN85DxCH29An12vnAxDtVHXqwuaxpuF+KtT2bCx/tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788460027; c=relaxed/simple;
	bh=IiUyYLlO+FDW0jEQUyogmgDiGkJzdZhAmlmd6j4DJf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=irE+06oPEAljrJV8wkntKilGgwd67EsgclVc0uExTmhqpoalnhMXU5YcKgrHv+pCuWpmWKU11Ugr2C3BZu8v/ohYr4DDbuSSQVtRm+UDUbul5Ycx8oOvjIeD8vSA2nhQYgrIc2rlL4PJYpUUz13R6nv7u9kz4SV20Q+FPDtlOzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0tQXJkl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0tQXJkl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE3D1F000E9;
	Thu,  3 Sep 2026 18:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788460020;
	bh=hgSw9gfMir1JzuFS3IKZnThBxyJ9tHoUtEh9BthIy04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y0tQXJkl+10z/iPOx8JVDanoxvre+Hl8IMuh0xjGjMNY85Nt26SGQBkTFfa90Tovy
	 +bdBQtcuWEPZmTs3cpNadx4B9Q47qigAF61xT4pYlmgsnkX9Fifr3rJBQOZ07IN4ic
	 Kfssh6tK4XFUrydujhJR5FobXv3lIXYywvImUwgspNF4WXTLBxaNXbzY3t7AdoUUuV
	 vt8Mb0wEn8s2z6d13B190A8n20C6XmH2Ap3jhy7c6Z6fNVUUt33ln+0mXHBKBzQETY
	 nclyIuOOBfm4l9Mk+/K8ZVVrb8FbThejOybkK6Fse+PfsRMVWKc6LQWoV61LdVUtZo
	 jFBkSeMMxQsNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zi Yan <ziy@nvidia.com>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	Liam Howlett <liam.howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/6] mm/huge_memory: replace can_split_folio() with direct refcount calculation
Date: Thu,  3 Sep 2026 14:26:48 -0400
Message-ID: <20260903182650.1451393-4-sashal@kernel.org>
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

[ Upstream commit 5842bcbfc316738cbfcbdb4def5a7592aa03ebf2 ]

can_split_folio() is just a refcount comparison, making sure only the
split caller holds an extra pin.  Open code it with
folio_expected_ref_count() != folio_ref_count() - 1.  For the extra_pins
used by folio_ref_freeze(), add folio_cache_ref_count() to calculate it.
Also replace folio_expected_ref_count() with folio_cache_ref_count() used
by folio_ref_unfreeze(), since they are returning the same values when a
folio is frozen and folio_cache_ref_count() does not have unnecessary
folio_mapcount() in its implementation.

Link: https://lkml.kernel.org/r/20251126210618.1971206-3-ziy@nvidia.com
Signed-off-by: Zi Yan <ziy@nvidia.com>
Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: c299a2285d9d ("mm/huge_memory: use folio's memcg inside __folio_split()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/huge_mm.h |  1 -
 mm/huge_memory.c        | 35 ++++++++++++-----------------------
 mm/vmscan.c             |  3 ++-
 3 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 9bafcdb4d66ac..b55a4a342f578 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -364,7 +364,6 @@ unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long add
 		unsigned long len, unsigned long pgoff, unsigned long flags,
 		vm_flags_t vm_flags);
 
-bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins);
 int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		unsigned int new_order);
 int min_order_for_split(struct folio *folio);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index dc53a92308513..7df0a1380738c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3326,23 +3326,6 @@ static void lru_add_split_folio(struct folio *folio, struct folio *new_folio,
 	}
 }
 
-/* Racy check whether the huge page can be split */
-bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
-{
-	int extra_pins;
-
-	/* Additional pins from page cache */
-	if (folio_test_anon(folio))
-		extra_pins = folio_test_swapcache(folio) ?
-				folio_nr_pages(folio) : 0;
-	else
-		extra_pins = folio_nr_pages(folio);
-	if (pextra_pins)
-		*pextra_pins = extra_pins;
-	return folio_mapcount(folio) == folio_ref_count(folio) - extra_pins -
-					caller_pins;
-}
-
 static bool page_range_has_hwpoisoned(struct page *page, long nr_pages)
 {
 	for (; nr_pages; page++, nr_pages--)
@@ -3715,7 +3698,6 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	struct anon_vma *anon_vma = NULL;
 	int old_order = folio_order(folio);
 	struct folio *new_folio, *next;
-	int extra_pins;
 	int nr_shmem_dropped = 0;
 	enum ttu_flags ttu_flags = 0;
 	pgoff_t end = 0;
@@ -3803,7 +3785,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	 * Racy check if we can split the page, before unmap_folio() will
 	 * split PMDs
 	 */
-	if (!can_split_folio(folio, 1, &extra_pins)) {
+	if (folio_expected_ref_count(folio) != folio_ref_count(folio) - 1) {
 		ret = -EAGAIN;
 		goto out_unlock;
 	}
@@ -3827,7 +3809,10 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 
 	/* Prevent deferred_split_scan() touching ->_refcount */
 	ds_queue = folio_split_queue_lock(folio);
-	if (folio_ref_freeze(folio, 1 + extra_pins)) {
+	if (folio_ref_freeze(folio,
+			     (folio_test_anon(folio) &&
+			      !folio_test_swapcache(folio) ?
+			      0 : folio_nr_pages(folio)) + 1)) {
 		struct swap_cluster_info *ci = NULL;
 		struct lruvec *lruvec;
 		int expected_refs;
@@ -3896,7 +3881,9 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 
 			next = folio_next(new_folio);
 
-			expected_refs = folio_expected_ref_count(new_folio) + 1;
+			expected_refs = (folio_test_anon(new_folio) &&
+					 !folio_test_swapcache(new_folio) ?
+					 0 : folio_nr_pages(new_folio)) + 1;
 			folio_ref_unfreeze(new_folio, expected_refs);
 
 			lru_add_split_folio(folio, new_folio, lruvec, list);
@@ -3936,7 +3923,9 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		 * Otherwise, a parallel folio_try_get() can grab @folio
 		 * and its caller can see stale page cache entries.
 		 */
-		expected_refs = folio_expected_ref_count(folio) + 1;
+		expected_refs = (folio_test_anon(folio) &&
+				 !folio_test_swapcache(folio) ?
+				 0 : folio_nr_pages(folio)) + 1;
 		folio_ref_unfreeze(folio, expected_refs);
 
 		unlock_page_lruvec(lruvec);
@@ -4465,7 +4454,7 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		 * can be split or not. So skip the check here.
 		 */
 		if (!folio_test_private(folio) &&
-		    !can_split_folio(folio, 0, NULL))
+		    folio_expected_ref_count(folio) != folio_ref_count(folio))
 			goto next;
 
 		if (!folio_trylock(folio))
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 95b1179a14e78..6d563563cecfd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1317,7 +1317,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 					goto keep_locked;
 				if (folio_test_large(folio)) {
 					/* cannot split folio, skip it */
-					if (!can_split_folio(folio, 1, NULL))
+					if (folio_expected_ref_count(folio) !=
+					    folio_ref_count(folio) - 1)
 						goto activate_locked;
 					/*
 					 * Split partially mapped folios right away.
-- 
2.53.0

