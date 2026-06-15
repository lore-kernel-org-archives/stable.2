Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDEF4014AB
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537951; cv=none; b=CWy16fkUyNTscoSwMVM4wjdoQuZgoOF2n6KATPNvaDSuywYYmlnnfFM68I1g0YY7TQUozsD61Nic464SPtD/Qnx+XHn1xJWe0O/fUNkzQWsdUa3IPXHDpdxRm5MmLwY4gYCB9QkErVTX01bfe264FcGI7jPzDpqLfgPj83IKTJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537951; c=relaxed/simple;
	bh=eK++NLqjCXrm2vKh+/HIdhLl/Q89eM/goKS/Q/khYeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyA1UYFhwIXyOxqEmOdA3vfxntrwuDOLGEYK387kd1vaCfjRGdlfn0GR0+cFYtD4hgK9skk1eN01XfjrlFBfK25qC/v/QAr4oULyEYI1iLFiqnHSH9JwBLgL4jAkzF1TsqZ7/yg2AjBFUQ72KZNdoc7IaxyRuHSjsyiplJwRRT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqHRzzGo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqHRzzGo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE3C1F00A3E;
	Mon, 15 Jun 2026 15:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781537950;
	bh=pdepT4yCdY/BC9YPeTVDfsAJ5fBroN7WNwq8oC+lGvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PqHRzzGoZQqOtQsnir/mhJlQQeTWJhaPPTvsXHHtoI4qOqynCPh5zoPRN2bLL9Qxh
	 UOA8zrxoKsae+/WKaA8oMVrYvoF/ZrkON3v2zR2cbHOAGnU85hYEfHzSZM7y6FGWgF
	 2zB6sGfuTB9z5qp6yrSD+/M7JqtHpYjb73UdDQTl2gQnIZrkqLuv4EE9lTh0FcslYt
	 HU8xKUvi/Wv3UyH20Qif8yNmPho1VGTLoxOk/A8Htr2Ucc5/YX0t5smjEHsg/DoDRb
	 RG4JI6V7eR1B0zVERhADAj4p/QMEUUVModHbBdOuhymxRcAm31cwizRNhqwBdip/sY
	 7RjKq2faCAmWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jane Chu <jane.chu@oracle.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Chris Mason <clm@meta.com>,
	David Hildenbrand <david@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jiaqi Yan <jiaqiyan@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	William Roche <william.roche@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/5] mm/memory-failure: fix missing ->mf_stats count in hugetlb poison
Date: Mon, 15 Jun 2026 11:39:02 -0400
Message-ID: <20260615153903.2214102-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615153903.2214102-1-sashal@kernel.org>
References: <2026061513-untracked-crane-019d@gregkh>
 <20260615153903.2214102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jane Chu <jane.chu@oracle.com>

[ Upstream commit a148a2040191b12b45b82cb29c281cb3036baf90 ]

When a newly poisoned subpage ends up in an already poisoned hugetlb
folio, 'num_poisoned_pages' is incremented, but the per node ->mf_stats is
not.  Fix the inconsistency by designating action_result() to update them
both.

While at it, define __get_huge_page_for_hwpoison() return values in terms
of symbol names for better readibility.  Also rename
folio_set_hugetlb_hwpoison() to hugetlb_update_hwpoison() since the
function does more than the conventional bit setting and the fact three
possible return values are expected.

Link: https://lkml.kernel.org/r/20260120232234.3462258-1-jane.chu@oracle.com
Fixes: 18f41fa616ee ("mm: memory-failure: bump memory failure stats to pglist_data")
Signed-off-by: Jane Chu <jane.chu@oracle.com>
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: Chris Mason <clm@meta.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Jiaqi Yan <jiaqiyan@google.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: William Roche <william.roche@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 3c2d42b8ee34 ("mm/memory-failure: fix hugetlb_lock AA deadlock in get_huge_page_for_hwpoison")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory-failure.c | 73 ++++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 27 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 004e73eda8228b..9edd58cce31d50 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1912,12 +1912,22 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
 	return count;
 }
 
-static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
+#define	MF_HUGETLB_FREED		0	/* freed hugepage */
+#define	MF_HUGETLB_IN_USED		1	/* in-use hugepage */
+#define	MF_HUGETLB_NON_HUGEPAGE		2	/* not a hugepage */
+#define	MF_HUGETLB_FOLIO_PRE_POISONED	3	/* folio already poisoned */
+#define	MF_HUGETLB_PAGE_PRE_POISONED	4	/* exact page already poisoned */
+#define	MF_HUGETLB_RETRY		5	/* hugepage is busy, retry */
+/*
+ * Set hugetlb folio as hwpoisoned, update folio private raw hwpoison list
+ * to keep track of the poisoned pages.
+ */
+static int hugetlb_update_hwpoison(struct folio *folio, struct page *page)
 {
 	struct llist_head *head;
 	struct raw_hwp_page *raw_hwp;
 	struct raw_hwp_page *p, *next;
-	int ret = folio_test_set_hwpoison(folio) ? -EHWPOISON : 0;
+	int ret = folio_test_set_hwpoison(folio) ? MF_HUGETLB_FOLIO_PRE_POISONED : 0;
 
 	/*
 	 * Once the hwpoison hugepage has lost reliable raw error info,
@@ -1925,11 +1935,11 @@ static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
 	 * so skip to add additional raw error info.
 	 */
 	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
-		return -EHWPOISON;
+		return MF_HUGETLB_FOLIO_PRE_POISONED;
 	head = raw_hwp_list_head(folio);
 	llist_for_each_entry_safe(p, next, head->first, node) {
 		if (p->page == page)
-			return -EHWPOISON;
+			return MF_HUGETLB_PAGE_PRE_POISONED;
 	}
 
 	raw_hwp = kmalloc(sizeof(struct raw_hwp_page), GFP_ATOMIC);
@@ -1986,42 +1996,39 @@ void folio_clear_hugetlb_hwpoison(struct folio *folio)
 
 /*
  * Called from hugetlb code with hugetlb_lock held.
- *
- * Return values:
- *   0             - free hugepage
- *   1             - in-use hugepage
- *   2             - not a hugepage
- *   -EBUSY        - the hugepage is busy (try to retry)
- *   -EHWPOISON    - the hugepage is already hwpoisoned
  */
 int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 				 bool *migratable_cleared)
 {
 	struct page *page = pfn_to_page(pfn);
 	struct folio *folio = page_folio(page);
-	int ret = 2;	/* fallback to normal page handling */
 	bool count_increased = false;
+	int ret, rc;
 
-	if (!folio_test_hugetlb(folio))
+	if (!folio_test_hugetlb(folio)) {
+		ret = MF_HUGETLB_NON_HUGEPAGE;
 		goto out;
-
-	if (flags & MF_COUNT_INCREASED) {
-		ret = 1;
+	} else if (flags & MF_COUNT_INCREASED) {
+		ret = MF_HUGETLB_IN_USED;
 		count_increased = true;
 	} else if (folio_test_hugetlb_freed(folio)) {
-		ret = 0;
+		ret = MF_HUGETLB_FREED;
 	} else if (folio_test_hugetlb_migratable(folio)) {
-		ret = folio_try_get(folio);
-		if (ret)
+		if (folio_try_get(folio)) {
+			ret = MF_HUGETLB_IN_USED;
 			count_increased = true;
+		} else {
+			ret = MF_HUGETLB_FREED;
+		}
 	} else {
-		ret = -EBUSY;
+		ret = MF_HUGETLB_RETRY;
 		if (!(flags & MF_NO_RETRY))
 			goto out;
 	}
 
-	if (folio_set_hugetlb_hwpoison(folio, page)) {
-		ret = -EHWPOISON;
+	rc = hugetlb_update_hwpoison(folio, page);
+	if (rc >= MF_HUGETLB_FOLIO_PRE_POISONED) {
+		ret = rc;
 		goto out;
 	}
 
@@ -2046,6 +2053,12 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
  * with basic operations like hugepage allocation/free/demotion.
  * So some of prechecks for hwpoison (pinning, and testing/setting
  * PageHWPoison) should be done in single hugetlb_lock range.
+ * Returns:
+ *	0		- not hugetlb, or recovered
+ *	-EBUSY		- not recovered
+ *	-EOPNOTSUPP	- hwpoison_filter'ed
+ *	-EHWPOISON	- folio or exact page already poisoned
+ *	-EFAULT		- kill_accessing_process finds current->mm null
  */
 static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb)
 {
@@ -2058,22 +2071,28 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 	*hugetlb = 1;
 retry:
 	res = get_huge_page_for_hwpoison(pfn, flags, &migratable_cleared);
-	if (res == 2) { /* fallback to normal page handling */
+	switch (res) {
+	case MF_HUGETLB_NON_HUGEPAGE:	/* fallback to normal page handling */
 		*hugetlb = 0;
 		return 0;
-	} else if (res == -EHWPOISON) {
+	case MF_HUGETLB_FOLIO_PRE_POISONED:
+	case MF_HUGETLB_PAGE_PRE_POISONED:
 		pr_err("%#lx: already hardware poisoned\n", pfn);
+		res = -EHWPOISON;
 		if (flags & MF_ACTION_REQUIRED) {
 			folio = page_folio(p);
 			res = kill_accessing_process(current, folio_pfn(folio), flags);
 		}
 		return res;
-	} else if (res == -EBUSY) {
+	case MF_HUGETLB_RETRY:
 		if (!(flags & MF_NO_RETRY)) {
 			flags |= MF_NO_RETRY;
 			goto retry;
 		}
 		return action_result(pfn, MF_MSG_UNKNOWN, MF_IGNORED);
+	default:
+		WARN_ON((res != MF_HUGETLB_FREED) && (res != MF_HUGETLB_IN_USED));
+		break;
 	}
 
 	folio = page_folio(p);
@@ -2084,7 +2103,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 		if (migratable_cleared)
 			folio_set_hugetlb_migratable(folio);
 		folio_unlock(folio);
-		if (res == 1)
+		if (res == MF_HUGETLB_IN_USED)
 			folio_put(folio);
 		return -EOPNOTSUPP;
 	}
@@ -2093,7 +2112,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 	 * Handling free hugepage.  The possible race with hugepage allocation
 	 * or demotion can be prevented by PageHWPoison flag.
 	 */
-	if (res == 0) {
+	if (res == MF_HUGETLB_FREED) {
 		folio_unlock(folio);
 		if (__page_handle_poison(p) > 0) {
 			page_ref_inc(p);
-- 
2.53.0

