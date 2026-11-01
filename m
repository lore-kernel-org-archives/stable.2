Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793558223;
	b=Zy3q25uBO+JmrSfzHvFjWoqbcvYQD02ulk5HE1taFDZoUskFVgsmUj6zruhQeZAMvZv4
	 hzw+BPcGEi4OLf834bGSsMye5vpmSaKM06Ls9qdNDGFbNUMXgYtXoWn1bSM2klA61tJCd
	 IajrBK4ghrjyrumcbgimjm7MTaArqa2Ng9T0yyYA/IXiOTaUndvvo6WCdEvp74lQUzyiE
	 UQiJMK+SZQOFtgHmnzErROkySnldWpWl58kJ3YxRO4Cr2fxzhCZjA1yP0GIkKuKMl23K3
	 psLdgGUTiyD2KcRgLkMAL3DF0pIGs94SSN09r7Spd7HWPNetW32YDAkbFj+NvzfYdSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793558223;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Jxx/xd6pCWHtMs9q1hQKO+mSAAQUnWlajC1KDUBk9TQ=;
	b=BjRjYotoYa36/poCtncvOhybRMiYoDxHcP8gUUCRfYOPRFcRBAOIrs9xu44uM3zyrTKX
	 g7s2udgQOn/5BlCRyOUm3qSEDSN4tzpr+3H4p2Gv7tI54CGd/63lCrRuyGzEoBMTTc8ux
	 IYlNMvx0JROq6o/GItNKAtIFo+kk8RQP/IObN1TS60VFXzJmeVAJdvK7ayfca4WEvtbEQ
	 QA+XtHlGjDU4+IdpuFKVZRg95hahtLhd+NMto3O5+xka6asgDB/oYiYnMuBpi60SBcafF
	 myAmk7CGOu1LO/jNsZWvvxim+mUUOr7wj8H94JaQvRQkIA8jEzb3b+s2L9LTjr/8w2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KZyqzvaD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AA5606A326;
	Sun,  1 Nov 2026 18:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KZyqzvaD
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793558222;
	b=AyekSGmPeS7CbstnkeXvV1MJw21JXjji/Q+QY+YnePFBRJfm4q2o6ZZnCa1Z7KDHa/5c
	 KAvTe30gbwvGr6p4auD5ymCDoKiwUvxddFRr4DteNl+PzhToqaS1NVx57ApTe5zWDTefy
	 CgtP16hjL2mgloKhBGHdtsKLc2vkhBbZrQYqhXYLHphvQB+n84L6aHmAskVyMzZZ0DR3p
	 CyU//TTzxBhAg//X9rbvgwhRMrg6/GnR+b2pIPvsOpUbdB4mmUXz3NiLFHhrBblSdkTX4
	 3a6Bh2BJ/W6oyTVtS/vusv/ttaXhKm81cqCilIvQjd2qfpCRBz7+zIAhCW26WwnQQpw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793558222;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Jxx/xd6pCWHtMs9q1hQKO+mSAAQUnWlajC1KDUBk9TQ=;
	b=emMHHqmdfWVzkvhURwhBkHbTra3iOSPELpY62SBKlYsMh31MFrlJQz1s4Vit++TVfggd
	 pETwk7/hXd0TEGOunD/y2T0qvKb5HKfjhiMCQYq/o1qsFEiYS1U8rgHc9DdPmIFDCXv+l
	 1f5YbEbeAGIyUW6swJu4V5S71ReIWI17ISduWMyh81oCzIkFdQdPW6NKjqwdIHoAgOoyB
	 QFUZE0tmjK8twki4oYrYSGjCIc35qv/RXwN8LC8nL7P4P+1t1frRu6cTzfC5IIbKC5CyX
	 upzWRQbD/tuPs3GzkVW0ecZoTp7mFzirGeJ98aho2fwAKCxBkpEQS+UArxHJO8kMCtA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7D98D1F000C1;
	Sun,  1 Nov 2026 18:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793558222;
	bh=Jxx/xd6pCWHtMs9q1hQKO+mSAAQUnWlajC1KDUBk9TQ=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=KZyqzvaDuNOPUw1sylWUyDAZpFRFw+p0beV0ZZbziqGxvwbJKOXGH4iZQTxUVRVki
	 rYH2nDZazPLGdAVU2ruwWjayn45jiL40aJR6j/rR05IMlC19ql9Q5pB0olwVNXenlY
	 jdx2GCEgbCfgUwXk7/LkMZolg5hy1UZrCT5p07zs7TMH90G5MpWDoj0mvfVx+9uJGi
	 E6hgUIV5dHhYhJj6g5S33gxmxeciah/oFSDw0ANuzoRmDOlFkQxUU9PnjdgnOq9E3G
	 z5pfeYeMPq2qQ8CSYJiFAWxkDKDnKILW5+OlMkv/KE0Ly2mK/JGm2XTMxoNyAuu6Ua
	 1Vw0SRAlHuFPg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CA2A24622F;
	Sun,  1 Nov 2026 18:37:00 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Date: Sun, 01 Nov 2026 13:37:00 -0500
Subject: [PATCH] mm/memory-failure: set PG_hwpoison of a non-hugetlb page
 under hugetlb_lock
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
Message-Id: <20261101-hwpoison-hugetlb-ro-v1-1-a42d6411cb65@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDuQWJTUq0gXUSdmpCSSUVsQ7
 96oy7f4fwehxCTQFDsk2lg4hgz9KKD3NoyEPGRDqcpaq6dC/50jSwzo15GWT4cpYuWMMdrWyro
 X5HJO5Ph3Xdv3bVm7ifrlXMFx/AH/N+LpdwAAAA==
X-Change-ID: 20261030-hwpoison-hugetlb-ro-5f8881a60af9
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 Miaohe Lin <linmiaohe@huawei.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Kiryl Shutsemau <kas@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, tz2294@columbia.edu, stable@vger.kernel.org, 
 Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793558220; l=6529;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=vY4HPfMnuH6pA4pu5hK+iTt0s/Q+jMXoy6cASM5sNGg=;
 b=BJZtadvt5YuVcWGhuFJ00T8dPa/oJPXlWu1Wz1QVyyt6FBAJ+lLQ/sG8Utr4BPh/1ygdTKDfM
 fVpY5oVI+boAN4a2XqYq7k1+iYM8E6KiGtqYDNzR+LG2E2/GDm+slCG
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
the same lock.  With the fix, no healthy page gets marked anymore.

This bug was identified and confirmed with the help of a deterministic
hypervisor currently under development.  The C reproducer below however
hits it within about 35s.

Fixes: f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated with each HugeTLB page")
Cc: stable@vger.kernel.org
Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
---
Reproducer: https://github.com/manitofigh/files/blob/main/linux-repros/hugetlbro.c
---
 mm/hugetlb.c        |  3 +++
 mm/memory-failure.c | 37 ++++++++++++++++++++++++++++++-------
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ff9dbfbc7a96..eab0d9c5758b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1770,7 +1770,10 @@ static void account_new_hugetlb_folio(struct hstate *h, struct folio *folio)
 
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
index b705f9f97f42..087b385aa060 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1976,6 +1976,7 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
 #define	MF_HUGETLB_FOLIO_PRE_POISONED	3	/* folio already poisoned */
 #define	MF_HUGETLB_PAGE_PRE_POISONED	4	/* exact page already poisoned */
 #define	MF_HUGETLB_RETRY		5	/* hugepage is busy, retry */
+#define	MF_HUGETLB_NON_HUGEPAGE_POISONED	6	/* not a hugepage, already poisoned */
 /*
  * Set hugetlb folio as hwpoisoned, update folio private raw hwpoison list
  * to keep track of the poisoned pages.
@@ -2060,7 +2061,11 @@ static int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
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
@@ -2111,7 +2116,8 @@ static int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
  * PageHWPoison) should be done in single hugetlb_lock range.
  * Returns:
  *	0		- recovered
- *	-ENOENT		- no hugetlb page
+ *	-ENOENT		- no hugetlb page, now marked hwpoison
+ *	-EEXIST		- no hugetlb page, already marked hwpoison
  *	-EBUSY		- not recovered
  *	-EOPNOTSUPP	- hwpoison_filter'ed
  *	-EHWPOISON	- folio or exact page already poisoned
@@ -2130,6 +2136,8 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags)
 	switch (res) {
 	case MF_HUGETLB_NON_HUGEPAGE:	/* fallback to normal page handling */
 		return -ENOENT;
+	case MF_HUGETLB_NON_HUGEPAGE_POISONED:
+		return -EEXIST;
 	case MF_HUGETLB_RETRY:
 		if (!(flags & MF_NO_RETRY)) {
 			flags |= MF_NO_RETRY;
@@ -2189,10 +2197,24 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags)
 	return identify_page_state(pfn, p, page_flags);
 }
 
+/* Keep the flag if the page has become hugetlb in the meantime. */
+static void clear_non_hugetlb_hwpoison(struct page *page)
+{
+	spin_lock_irq(&hugetlb_lock);
+	if (!folio_test_hugetlb(page_folio(page)))
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
@@ -2470,12 +2492,13 @@ int memory_failure(unsigned long pfn, int flags)
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
+	if (res == -EEXIST) {
 		res = -EHWPOISON;
 		if (flags & MF_ACTION_REQUIRED)
 			res = kill_accessing_process(current, pfn, flags);
@@ -2506,7 +2529,7 @@ int memory_failure(unsigned long pfn, int flags)
 			} else {
 				/* We lost the race, try again */
 				if (retry) {
-					ClearPageHWPoison(p);
+					clear_non_hugetlb_hwpoison(p);
 					retry = false;
 					goto try_again;
 				}

---
base-commit: 5e6c45aaaf93343c7f8a1cde9797080238af5c1b
change-id: 20261030-hwpoison-hugetlb-ro-5f8881a60af9

Best regards,
--  
Mani Tofigh <mt4022@columbia.edu>


