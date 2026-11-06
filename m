Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793981392;
	b=V99VKgNaX0ygC5WDgav40GTnTC1EfFcEuGtORaV5MDaW+6WSd4uuqACfS8A0XQb8326z
	 KJ+vcBZejqSSoDKClMtVKFnh8cLHu9ybtCBNmqoOmeEXP8cwY5M4/7iKLqGUsFNpGHKQQ
	 67REDx/oULdHM5DlGGYB49Orl6mGWAAlDOKByp1FurDYr2knAEwGyXWpVzO8zIf7gL9AN
	 jximUvMQaExio5ERSmphN3TfHu/6H9I7F0Fp0DvFey1n2FoLZ/5sq5btGLBEmutWGAFvu
	 m69n3BmlnXQBBshIaa6bTUy30U+WcJHQjrAWIDwGKCiu21G9jZzslOlN8OoE9kuA1UQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981392;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iHAhjf3lUh4MXY8ZNRJ1tkNwvR+RRey9UEkMvDbTWYc=;
	b=4VPLK9G3tMeUZ8bJMyGpIMxGImmtcCsBZwaBbYlaczHx2yYcdUtbAAEilRrPOY9jE9mL
	 bZTyCg8GMODrwtVIJfbBCC8lxlHMFZtsoowplU7pu19tyGj388fZLanTEYDp5vfGWmWR7
	 LDOXoQ2munhK229qY5+DzRxB10GtX6XcCrR9WuXVaWvB6xNyIQLuU466PBr6jnKq0W2hp
	 t2wTOByaWIwYisLzM7zy4shxW3a/fIpPNn/4LiK4abO2B0xErb1D6SQrSTWVdje+6Evfs
	 JfzyHRAwtd0Od/cwdCS3mM41JePpPnvlbMXyDI0omlLdzLtPfE5RE2ZiBnsC/t8LyHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iprBwukv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04040606A326;
	Fri,  6 Nov 2026 16:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iprBwukv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793981391;
	b=e0SwC5MWn2Mk1bP6pbhCqrEjCeT96Ga2qcHnQDWcFbUUACkvyjI+NhyJcs5MYEftIR2z
	 qIUXhHnOCuU0WyeLmnKNIn2uOoKugaT5lGWuwOPgyMT+QrQ93gNeLtv6Mkaahc7VxbPDV
	 UvLYkSmDWMR/JmWnQQngMoHW3F1H/m1jGmWyz1GDiSmqn2SVKnrmYfifRutIRwiFKCkdU
	 0brbdpDEsvefcbJGVxrVhkc5oq7uP2FV5e/L6lRLehRpRxRPpExGvkJDbg4zJ9lBX20Hc
	 ELToto4TLmUONkVSk43NwNd/hAVdsf4d2WrY4EaE7dtnuaBOiOTVKo4nM+tD/xQ97Qg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793981391;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iHAhjf3lUh4MXY8ZNRJ1tkNwvR+RRey9UEkMvDbTWYc=;
	b=YuvFMwlnTRuZeX4GNrXwrw+ad08CHVMPdY2vbSAUlPa29wQWbNP1zlZQQLEGOzhe0rzg
	 LxuMpZ9MMKSXPAo6MfWw5OBOVyrVDqmaq648XFK6flPvY8LhmaUhM+xj1W/DFc/GngH0i
	 hRSwdEwQwLb4ppRrFDNBhUcuO3FHBChsy3OuDGYAWsN1Tll59wVU6f2RHx/kcwbjrQqXY
	 qXa2aL7fREVg49CgAMexaAIS5IHo58/N7uRfXpg188VCAtL2/nFOO1BUOU4AWrvJBP5VJ
	 emPZFLI8ggmj7evg6klloTMtEPaHBQHAH1O1TFCYfk+M20sDAl62TLS2slZPsY2aJbw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9E61B1F0089F;
	Fri,  6 Nov 2026 16:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793981391;
	bh=iHAhjf3lUh4MXY8ZNRJ1tkNwvR+RRey9UEkMvDbTWYc=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=iprBwukvwNRVXyRmLt2lMuFS78KX3gFUf5nCMKTsONFUeQCJwmCK6WPK8GS1PT6zd
	 BjBksBRa/fhpLnw7pRAa3Uu6Fv29s/FQlPwvU3U08nSeedAxnH3FgJQOES8+hN/p9B
	 CZDL8ZObx6yQ0DNICz6woAPAohAKCEoHGeH9Wdv7S7pyfF8SXJ/iadeJ3nygAbHp03
	 Rp3yuLJ7QsQ40Rx5iWpNf9CGe2d7UxEylygOY17o4Q+R0CAZH8X0I1bH4yTFIoeNRw
	 oK1DcieLfs6nX3RImNySnHsCZta1Agzu6iMq4D72ZoAS4zitzY2Wq1kN7zZAD7odFp
	 WEL41p2zh0PYg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id F140845DD4;
	Fri,  6 Nov 2026 16:09:49 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Date: Fri, 06 Nov 2026 11:09:50 -0500
Subject: [PATCH v3] mm/memory-failure: set PG_hwpoison of a non-hugetlb
 page under hugetlb_lock
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
Message-Id: <20261106-hwpoison-hugetlb-ro-v3-1-c11186963647@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBQFr0K6tqa/QEVX3sO4aMsv1CAlLaCGc
 HcpbIxhOcl7MxMJ6C0Gckkm4nG0wbp2gfSQEF3LtkJqy4UJZ1wASxmtX52zwbW0HirsG0W9o7k
 pigKkYNKcyfLsPBr7Xq23+8ZhUA/UfVTFRW1D7/xnzY4Qd1sBGOwWRqBAZcZLkQFoJfKrds3wV
 FYesRxIjIz8V5Pua/iiydLiJIw+Ixr408zz/AUKFzS2EgEAAA==
X-Change-ID: 20261030-hwpoison-hugetlb-ro-5f8881a60af9
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 Miaohe Lin <linmiaohe@huawei.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Kiryl Shutsemau <kas@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Mike Kravetz <mike.kravetz@oracle.com>, 
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, tz2294@columbia.edu, stable@vger.kernel.org, 
 Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793981389; l=7705;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=4mYpqbe5yZuGOdKLJjklC3p4pfwaTTfwNH4P644WDrQ=;
 b=7cLniYvj1nhdM8oOCBlGo8YfVygKibaXuEecSzGukzuSkpFrAMk2x1jB+DKSfbHTHsVB8moUM
 FdvsQSiI8OuC0hWJnLVzI//wRzUWJWhdoXAG7+wMxv5HDeIQhLa9cQX
X-Developer-Key: i=mt4022@columbia.edu; a=ed25519;
 pk=gljCMQDuxyKPmd5y37CRpEJGSPXDV1MyAnHBhCgXl0I=
X-Endpoint-Received: by B4 Relay for mt4022@columbia.edu/20261026 with
 auth_id=1322
X-Original-From: Mani Tofigh <mt4022@columbia.edu>
Reply-To: mt4022@columbia.edu
Content-Transfer-Encoding: 7bit

From: Mani Tofigh <mt4022@columbia.edu>

memory_failure() checks under hugetlb_lock that the page isn't part of
a hugetlb folio and sets PG_hwpoison only after dropping the lock.  The
page can become a tail page of a new hugetlb folio in the meantime.
With hugetlb_free_vmemmap=on its struct page then lives in the tail
page that all such folios in the zone share, so the flag lands on tail
pages of every one of them:

  Task A (memory_failure)              Task B (nr_hugepages write)
  get_huge_page_for_hwpoison()
    /* P not hugetlb */
                                       alloc_fresh_hugetlb_folio()
                                         /* P becomes a tail page */
                                         hugetlb_vmemmap_optimize_folio()
                                           /* P's struct page now in
                                              the shared tail page */
  TestSetPageHWPoison(P)

The error on P itself is ignored, while healthy pages of other folios
stay marked and are never reused once their folio is freed.  After
freeing the pool, /proc/kpageflags shows them as hwpoisoned.

This is the allocation side of the race that commit 32c877191e02
("hugetlb: do not clear hugetlb dtor until allocating vmemmap") fixed
for freeing.

Set the hugetlb flag of a new folio under hugetlb_lock and set
PG_hwpoison of a non-hugetlb page inside the locked check, so that the
vmemmap can't be optimized in between.  The retry path clears it under
the same lock, unless the page has become part of a hugetlb folio in
the meantime and its struct page isn't in the first vmemmap page of the
folio, which HVO doesn't share.  The retry then knows the flag is its
own.  With the fix, no healthy page gets marked anymore.

This bug was identified and confirmed with the help of a deterministic
hypervisor currently under development.  The C reproducer below however
hits it within about 35s.

Fixes: f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated with each HugeTLB page")
Cc: stable@vger.kernel.org
Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
---
Changes in v3:
- Keep the flag only for a page beyond the first vmemmap page of the
  folio, and fix the comment that said a head page is never remapped
  (Sashiko)
- Don't take a flag kept by the retry path for an earlier error (Sashiko)
- Rebase onto current mm-new
- Link to v2: https://patch.msgid.link/20261103-hwpoison-hugetlb-ro-v2-1-43876fc9eef1@columbia.edu

Reproducer: https://github.com/manitofigh/files/blob/main/linux-repros/hugetlbro.c
---
 mm/hugetlb.c        |  3 +++
 mm/memory-failure.c | 47 ++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4eb7a8c1f7f6..da4ae43de9f7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1792,7 +1792,10 @@ static void account_new_hugetlb_folio(struct hstate *h, struct folio *folio)
 
 void init_new_hugetlb_folio(struct folio *folio)
 {
+	/* Pairs with get_huge_page_for_hwpoison(), see there. */
+	spin_lock_irq(&hugetlb_lock);
 	__folio_set_hugetlb(folio);
+	spin_unlock_irq(&hugetlb_lock);
 	INIT_LIST_HEAD(&folio->lru);
 	hugetlb_set_folio_subpool(folio, NULL);
 	set_hugetlb_cgroup(folio, NULL);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 78f0a13349cb..9795f07b26f5 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -61,6 +61,7 @@
 #include <linux/pagewalk.h>
 #include <linux/shmem_fs.h>
 #include <linux/sysctl.h>
+#include <linux/vmemmap-optimization.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/memory-failure.h>
@@ -1957,6 +1958,7 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
 #define	MF_HUGETLB_FOLIO_PRE_POISONED	3	/* folio already poisoned */
 #define	MF_HUGETLB_PAGE_PRE_POISONED	4	/* exact page already poisoned */
 #define	MF_HUGETLB_RETRY		5	/* hugepage is busy, retry */
+#define	MF_HUGETLB_NON_HUGEPAGE_POISONED	6	/* not a hugepage, already poisoned */
 /*
  * Set hugetlb folio as hwpoisoned, update folio private raw hwpoison list
  * to keep track of the poisoned pages.
@@ -2041,7 +2043,11 @@ static int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 	spin_lock_irq(&hugetlb_lock);
 	folio = page_folio(page);
 	if (!folio_test_hugetlb(folio)) {
-		ret = MF_HUGETLB_NON_HUGEPAGE;
+		/* Mark it before it can become part of a new hugetlb folio. */
+		if (TestSetPageHWPoison(page))
+			ret = MF_HUGETLB_NON_HUGEPAGE_POISONED;
+		else
+			ret = MF_HUGETLB_NON_HUGEPAGE;
 		goto out_unlock;
 	} else if (flags & MF_COUNT_INCREASED) {
 		ret = MF_HUGETLB_IN_USED;
@@ -2092,7 +2098,8 @@ static int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
  * PageHWPoison) should be done in single hugetlb_lock range.
  * Returns:
  *	0		- recovered
- *	-ENOENT		- no hugetlb page
+ *	-ENOENT		- no hugetlb page, now marked hwpoison
+ *	-EEXIST		- no hugetlb page, already marked hwpoison
  *	-EBUSY		- not recovered
  *	-EOPNOTSUPP	- hwpoison_filter'ed
  *	-EHWPOISON	- folio or exact page already poisoned
@@ -2111,6 +2118,8 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags)
 	switch (res) {
 	case MF_HUGETLB_NON_HUGEPAGE:	/* fallback to normal page handling */
 		return -ENOENT;
+	case MF_HUGETLB_NON_HUGEPAGE_POISONED:
+		return -EEXIST;
 	case MF_HUGETLB_RETRY:
 		if (!(flags & MF_NO_RETRY)) {
 			flags |= MF_NO_RETRY;
@@ -2170,10 +2179,32 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags)
 	return identify_page_state(pfn, p, page_flags);
 }
 
+/*
+ * If the page has become part of a hugetlb folio in the meantime, HVO may
+ * remap its struct page unless it is in the first vmemmap page of the
+ * folio.  Keep the flag then, since the retry takes it as its own.
+ */
+static void clear_non_hugetlb_hwpoison(struct page *page)
+{
+	struct folio *folio;
+
+	spin_lock_irq(&hugetlb_lock);
+	folio = page_folio(page);
+	if (!folio_test_hugetlb(folio) ||
+	    folio_page_idx(folio, page) < VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES)
+		ClearPageHWPoison(page);
+	spin_unlock_irq(&hugetlb_lock);
+}
+
 #else
 static inline int try_memory_failure_hugetlb(unsigned long pfn, int flags)
 {
-	return -ENOENT;
+	return TestSetPageHWPoison(pfn_to_page(pfn)) ? -EEXIST : -ENOENT;
+}
+
+static inline void clear_non_hugetlb_hwpoison(struct page *page)
+{
+	ClearPageHWPoison(page);
 }
 
 static inline unsigned long folio_free_raw_hwp(struct folio *folio, bool flag)
@@ -2451,12 +2482,14 @@ int memory_failure(unsigned long pfn, int flags)
 try_again:
 	res = try_memory_failure_hugetlb(pfn, flags);
 	/*
-	 * -ENOENT means the page we found is not hugetlb, so proceed with normal page handling
+	 * -ENOENT and -EEXIST mean the page is not hugetlb and is now marked
+	 * hwpoison, so proceed with normal page handling.
 	 */
-	if (res != -ENOENT)
+	if (res != -ENOENT && res != -EEXIST)
 		goto unlock_mutex;
 
-	if (TestSetPageHWPoison(p)) {
+	/* On the retry, the flag may still be set from the first try. */
+	if (res == -EEXIST && retry) {
 		res = -EHWPOISON;
 		if (flags & MF_ACTION_REQUIRED)
 			res = kill_accessing_process(current, pfn, flags);
@@ -2487,7 +2520,7 @@ int memory_failure(unsigned long pfn, int flags)
 			} else {
 				/* We lost the race, try again */
 				if (retry) {
-					ClearPageHWPoison(p);
+					clear_non_hugetlb_hwpoison(p);
 					retry = false;
 					goto try_again;
 				}

---
base-commit: dba8aba0a9a00ff781c03d82ae534fc6f8c2e263
change-id: 20261030-hwpoison-hugetlb-ro-5f8881a60af9

Best regards,
--  
Mani Tofigh <mt4022@columbia.edu>


