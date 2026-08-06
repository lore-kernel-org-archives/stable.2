Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9FD1B87C0
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 03:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785986447; cv=none; b=O8+llipM6eTr+50cMKMpGoMj8svhJi7qREleMLOJuy0Vy8oQkjNgyHZayH3j9jjbvkK3bS+ddsfi9Z4HZjeXwk/9wpFQOzvxMAAhCBhj0nUue1OzaHblpB2smRkgDd3kMFQCdYL9rg+3HNAFpz+i5ySrxHYNK1h8xlNPjYGZm4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785986447; c=relaxed/simple;
	bh=BGubs82lXdw6XGaSnUEyvVowZLrwm8NUyrBkuJHUhm8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tzY+5TytBl3dAYvdhW/KN4R6wYCnFjxa9476YHAV9EvX5k9GmN1chaP0d0DPOfSmZp02LVUkJxVxvSoJTLWhm4TbnnIKPeZlSGzNGweijjcGBwgpjWDY6Aqi8MxO+bt+PvMhD5yvt1gNBAOgLoDXC9Kp53A6LIPFMkrrFvFg1yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hMe8ULBo; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hMe8ULBo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+t
	N2nQUKNMtF9bMzyMSoWC1FoDapFVFMZi642VWa5xg=; b=hMe8ULBo7+63iS+sbD
	YiiIeEqznGM0bgesEtH87S8G0FAnHO7fhNTHGwdL3TcqYmlhZEDBwmxJmp2U5WBZ
	S0Bu4r+tuLIUa9tHjG375D0GkBSfcX6QUcO+p+0p38nDD9mx5GIYLhn8wlPeKhrr
	TfaovKDJUcoa4aPPA3yTntNtk=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgA33Shf_XNqkg3FKw--.36393S2;
	Thu, 06 Aug 2026 11:20:00 +0800 (CST)
From: dayou5941@163.com
To: akpm@linux-foundation.org,
	linmiaohe@huawei.com,
	david@kernel.org,
	ljs@kernel.org
Cc: nao.horiguchi@gmail.com,
	linux-mm@kvack.org,
	ziy@nvidia.com,
	Li Youhong <liyouhong@kylinos.cn>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v4] mm/memory-failure: fix folio refcount leak and locking in soft/hard offline
Date: Thu,  6 Aug 2026 11:19:58 +0800
Message-Id: <20260806031958.677935-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgA33Shf_XNqkg3FKw--.36393S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gw4DZrW3KrW3Cw47urW3ZFb_yoWxJF15pF
	W3KwnxArWvqrnI9r47Zw4vyr1Yy398Way5Ca43Jw1fZ3ZIy3WjkFWIqw4rZFW5Gry8AF4x
	Xa1UXF1jgan8JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jn3kZUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC3QIPvWpz-WJsyQAA3O

From: Li Youhong <liyouhong@kylinos.cn>

The min_order_for_split() function accesses folio->mapping without proper
synchronization. In memory_failure(), the folio lock is dropped before the
call, and in soft_offline_in_use_page(), the lock is not held at all. This
means that while min_order_for_split() is executing, the value of
folio->mapping may be modified by a truncate or invalidate operation,
leading to a torn read or use of a stale mapping value.

Additionally, the soft_offline_in_use_page() path fails to release the
folio reference taken by get_hwpoison_page() when new_order != 0, causing a
reference leak.

Fix these issues by:
- Moving the split operation logic into the callers and holding the folio
  lock around min_order_for_split() and split_huge_page_to_order().
- Removing the try_to_split_thp_page() helper to simplify refcount
  handling.
- Ensuring the folio reference is always dropped before returning on the
  soft-offline error path.

This refactors the code to be more maintainable, fixes the locking issue
reported by Sashiko, and also addresses the folio reference leak on the
soft-offline error path.

Fixes: 689b8986776c ("mm/memory-failure: improve large block size folio handling")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260803060001.800638-1-dayou5941@163.com
Cc: stable@vger.kernel.org
Co-developed-by: David Hildenbrand <david@kernel.org>
Signed-off-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
---
v2:
- Dropped the approach of caching folio->mapping inside min_order_for_split() in favor of adding the folio lock at the callers.
- Added VM_WARN_ON_ONCE_FOLIO() in min_order_for_split().
- Updated the commit message to clarify that the real issue is the callers not holding the folio lock, rather than a TOCTOU race.
  v1: https://lore.kernel.org/all/20260804035828.2684059-1-dayou5941@163.com/

v3:
- Fix author name and Signed-off-by format as requested by Greg.
  v2: https://lore.kernel.org/all/20260805072625.2437636-1-dayou5941@163.com/

v4:
- Rebased on David Hildenbrand's refactoring patch.
- Added Co-developed-by for David Hildenbrand.
- Supersedes the standalone refcount fix:
  link: https://lore.kernel.org/all/20260804035356.2615408-1-dayou5941@163.com/
- The VM_WARN_ON_ONCE_FOLIO() check in min_order_for_split() will be sent
  as a separate follow-up patch.
  v3: https://lore.kernel.org/all/20260805084224.2597547-1-dayou5941@163.com/

---
 mm/memory-failure.c | 49 +++++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 31 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 51508a55c405..665f5b444fb7 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1649,26 +1649,6 @@ static int identify_page_state(unsigned long pfn, struct page *p,
 	return page_action(ps, p, pfn);
 }
 
-/*
- * When 'release' is 'false', it means that if thp split has failed,
- * there is still more to do, hence the page refcount we took earlier
- * is still needed.
- */
-static int try_to_split_thp_page(struct page *page, unsigned int new_order,
-		bool release)
-{
-	int ret;
-
-	lock_page(page);
-	ret = split_huge_page_to_order(page, new_order);
-	unlock_page(page);
-
-	if (ret && release)
-		put_page(page);
-
-	return ret;
-}
-
 static void unmap_and_kill(struct list_head *to_kill, unsigned long pfn,
 		struct address_space *mapping, pgoff_t index, int flags)
 {
@@ -2440,7 +2420,6 @@ int memory_failure(unsigned long pfn, int flags)
 	folio_unlock(folio);
 
 	if (folio_test_large(folio)) {
-		const int new_order = min_order_for_split(folio);
 		int err;
 
 		/*
@@ -2457,24 +2436,24 @@ int memory_failure(unsigned long pfn, int flags)
 		 * page is a valid handlable page.
 		 */
 		folio_set_has_hwpoisoned(folio);
-		err = try_to_split_thp_page(p, new_order, /* release= */ false);
+
+		lock_page(p);
+		err = split_huge_page_to_order(p, min_order_for_split(folio));
+		unlock_page(p);
 		/*
 		 * If splitting a folio to order-0 fails, kill the process.
 		 * Split the folio regardless to minimize unusable pages.
 		 * Because the memory failure code cannot handle large
 		 * folios, this split is always treated as if it failed.
 		 */
-		if (err || new_order) {
-			/* get folio again in case the original one is split */
-			folio = page_folio(p);
+		folio = page_folio(p);
+		if (folio_test_large(folio)) {
 			res = -EHWPOISON;
 			kill_procs_now(p, pfn, flags, folio);
 			put_page(p);
 			action_result(pfn, MF_MSG_UNSPLIT_THP, MF_FAILED);
 			goto unlock_mutex;
 		}
-		VM_BUG_ON_PAGE(!page_count(p), p);
-		folio = page_folio(p);
 	}
 
 	/*
@@ -2776,6 +2755,9 @@ EXPORT_SYMBOL(unpoison_memory);
  * soft_offline_in_use_page handles hugetlb-pages and non-hugetlb pages.
  * If the page is a non-dirty unmapped page-cache page, it simply invalidates.
  * If the page is mapped, it migrates the contents over.
+ *
+ * The folio refcount has been incremented before entering this function.
+ * This folio reference must be released before the function returns on all paths.
  */
 static int soft_offline_in_use_page(struct page *page)
 {
@@ -2793,8 +2775,7 @@ static int soft_offline_in_use_page(struct page *page)
 	};
 
 	if (!huge && folio_test_large(folio)) {
-		const int new_order = min_order_for_split(folio);
-
+		lock_page(page);
 		/*
 		 * If new_order (target split order) is not 0, do not split the
 		 * folio at all to retain the still accessible large folio.
@@ -2802,8 +2783,14 @@ static int soft_offline_in_use_page(struct page *page)
 		 * preferred, split it to non-zero new_order like it is done in
 		 * memory_failure().
 		 */
-		if (new_order || try_to_split_thp_page(page, /* new_order= */ 0,
-						       /* release= */ true)) {
+		if (!min_order_for_split(folio))
+			ret = split_huge_page_to_order(page, 0);
+		else
+			ret = -EBUSY;
+		unlock_page(page);
+
+		if (ret) {
+			put_page(page);
 			pr_info("%#lx: thp split failed\n", pfn);
 			return -EBUSY;
 		}
-- 
2.25.1

