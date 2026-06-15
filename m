Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1919B396B7F
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 19:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552565; cv=none; b=brwiOltFPfZvoYc0SNXSRjz40D8GRLZny8jobhrQcW9K2cO2TsNrjkCRPGRub9IGLySTcUNkOiOk5FI3w5ILffvWquuswm1rU6g95xEKKMfR96ngAzrqyO1W5zUZpl+AQOpHCFbzOY6F9JOZGPMQ7w5zx1jCxqWupvqr4L4J3Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552565; c=relaxed/simple;
	bh=cENpEHxl2IdKusJHhzLTJYUvbudxFPodBVfUt83MWTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSrsrD7lZv1KIe+xjjSo/pkFl3kQPMXf5yE/IdKyI2M4GJRuDjUGmtRe5Id9JNhLweFH/Ium4qZM4xWCpaR/crWkocx/gE3BMOXIKKQF6S4YFLJC2+0wxqQwYTIVGdh1pKmGISRBMkYGW/X79XEhlf4So2MivUbvOrOh940snf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtGK2b3l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtGK2b3l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102031F000E9;
	Mon, 15 Jun 2026 19:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781552563;
	bh=KRpgL5Yt22xL82bU5pmKORk93JAxx6UZeqTC72fGt88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jtGK2b3lNeGCQMdXVCK8/oCH5HcSSmlM5QZ//P7fnqe2a2RAhlLzGbrZXFe4XlGla
	 5q2ZyMcmAwf52KOsI9b0exD1XeuGWd+P5sr9ISvcggH2t/k7HVH/JYpGvLvtuJhHTB
	 FAvO6Uris+hHrzDa4TuU8W9gUHoH68erhSI8dy0QRKyMw2xhOqdvN3ii3RrtmsW35B
	 fwsCh5dS3Vlc50q02oSo4KWx4pQkj3lZDTZrxmBCkjJ0KOK1xfqbOu4WgtTmXKL0Yc
	 /9amoK7bJ7ZD/96IosWuILffRZenJxivXjP/F5vYn82W6DNIw9FJ3aKsshOutMdqjk
	 wrHEcEwaxbEtg==
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
Subject: [PATCH 6.1.y 4/5] mm/memory-failure: fix missing ->mf_stats count in hugetlb poison
Date: Mon, 15 Jun 2026 15:42:36 -0400
Message-ID: <20260615194237.2391157-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615194237.2391157-1-sashal@kernel.org>
References: <2026061514-giblet-unsworn-8735@gregkh>
 <20260615194237.2391157-1-sashal@kernel.org>
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
 mm/memory-failure.c | 71 +++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 28 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 109703dc39080c..1d39bdb434e734 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1730,12 +1730,22 @@ static unsigned long __free_raw_hwp_pages(struct page *hpage, bool move_flag)
 	return count;
 }
 
-static int hugetlb_set_page_hwpoison(struct page *hpage, struct page *page)
+#define	MF_HUGETLB_FREED		0	/* freed hugepage */
+#define	MF_HUGETLB_IN_USED		1	/* in-use hugepage */
+#define	MF_HUGETLB_NON_HUGEPAGE		2	/* not a hugepage */
+#define	MF_HUGETLB_FOLIO_PRE_POISONED	3	/* folio already poisoned */
+#define	MF_HUGETLB_PAGE_PRE_POISONED	4	/* exact page already poisoned */
+#define	MF_HUGETLB_RETRY		5	/* hugepage is busy, retry */
+/*
+ * Set hugetlb page as hwpoisoned, update page private raw hwpoison list
+ * to keep track of the poisoned pages.
+ */
+static int hugetlb_update_hwpoison(struct page *hpage, struct page *page)
 {
 	struct llist_head *head;
 	struct raw_hwp_page *raw_hwp;
 	struct llist_node *t, *tnode;
-	int ret = TestSetPageHWPoison(hpage) ? -EHWPOISON : 0;
+	int ret = TestSetPageHWPoison(hpage) ? MF_HUGETLB_FOLIO_PRE_POISONED : 0;
 
 	/*
 	 * Once the hwpoison hugepage has lost reliable raw error info,
@@ -1743,13 +1753,13 @@ static int hugetlb_set_page_hwpoison(struct page *hpage, struct page *page)
 	 * so skip to add additional raw error info.
 	 */
 	if (HPageRawHwpUnreliable(hpage))
-		return -EHWPOISON;
+		return MF_HUGETLB_FOLIO_PRE_POISONED;
 	head = raw_hwp_list_head(hpage);
 	llist_for_each_safe(tnode, t, head->first) {
 		struct raw_hwp_page *p = container_of(tnode, struct raw_hwp_page, node);
 
 		if (p->page == page)
-			return -EHWPOISON;
+			return MF_HUGETLB_PAGE_PRE_POISONED;
 	}
 
 	raw_hwp = kmalloc(sizeof(struct raw_hwp_page), GFP_ATOMIC);
@@ -1804,41 +1814,38 @@ void hugetlb_clear_page_hwpoison(struct page *hpage)
 
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
 int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
 {
 	struct page *page = pfn_to_page(pfn);
 	struct page *head = compound_head(page);
-	int ret = 2;	/* fallback to normal page handling */
 	bool count_increased = false;
+	int ret, rc;
 
-	if (!PageHeadHuge(head))
+	if (!PageHeadHuge(head)) {
+		ret = MF_HUGETLB_NON_HUGEPAGE;
 		goto out;
-
-	if (flags & MF_COUNT_INCREASED) {
-		ret = 1;
+	} else if (flags & MF_COUNT_INCREASED) {
+		ret = MF_HUGETLB_IN_USED;
 		count_increased = true;
 	} else if (HPageFreed(head)) {
-		ret = 0;
+		ret = MF_HUGETLB_FREED;
 	} else if (HPageMigratable(head)) {
-		ret = get_page_unless_zero(head);
-		if (ret)
+		if (get_page_unless_zero(head)) {
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
 
-	if (hugetlb_set_page_hwpoison(head, page)) {
-		ret = -EHWPOISON;
+	rc = hugetlb_update_hwpoison(head, page);
+	if (rc >= MF_HUGETLB_FOLIO_PRE_POISONED) {
+		ret = rc;
 		goto out;
 	}
 
@@ -1854,6 +1861,12 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
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
@@ -1865,23 +1878,25 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 	*hugetlb = 1;
 retry:
 	res = get_huge_page_for_hwpoison(pfn, flags);
-	if (res == 2) { /* fallback to normal page handling */
+	if (res == MF_HUGETLB_NON_HUGEPAGE) { /* fallback to normal page handling */
 		*hugetlb = 0;
 		return 0;
-	} else if (res == -EHWPOISON) {
+	} else if (res == MF_HUGETLB_FOLIO_PRE_POISONED ||
+		   res == MF_HUGETLB_PAGE_PRE_POISONED) {
 		pr_err("%#lx: already hardware poisoned\n", pfn);
+		res = -EHWPOISON;
 		if (flags & MF_ACTION_REQUIRED) {
 			head = compound_head(p);
 			res = kill_accessing_process(current, page_to_pfn(head), flags);
 		}
 		return res;
-	} else if (res == -EBUSY) {
+	} else if (res == MF_HUGETLB_RETRY) {
 		if (!(flags & MF_NO_RETRY)) {
 			flags |= MF_NO_RETRY;
 			goto retry;
 		}
 		action_result(pfn, MF_MSG_UNKNOWN, MF_IGNORED);
-		return res;
+		return -EBUSY;
 	}
 
 	head = compound_head(p);
@@ -1890,7 +1905,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 	if (hwpoison_filter(p)) {
 		hugetlb_clear_page_hwpoison(head);
 		unlock_page(head);
-		if (res == 1)
+		if (res == MF_HUGETLB_IN_USED)
 			put_page(head);
 		return -EOPNOTSUPP;
 	}
@@ -1899,7 +1914,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 	 * Handling free hugepage.  The possible race with hugepage allocation
 	 * or demotion can be prevented by PageHWPoison flag.
 	 */
-	if (res == 0) {
+	if (res == MF_HUGETLB_FREED) {
 		unlock_page(head);
 		if (__page_handle_poison(p) > 0) {
 			page_ref_inc(p);
-- 
2.53.0

