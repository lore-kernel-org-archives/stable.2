Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E14B41930E;
	Wed,  8 Jul 2026 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783503293; cv=none; b=SmQcYZ5lpLIVI/+pnmmd5hACRastqzgXfqf7TMUlmDOORzMWDTFEtrWkF8b5rb3P3u2hSnK4G+maXypqOYDNzSYVOpSyQxUAnF9XIqwTs4ZxVJXZie79Ob7TubNaU6P3fOYasqsudZpyrP48q0QWhFKjUccUIavvarsov7DWakI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783503293; c=relaxed/simple;
	bh=eazOWd/wi6jkw/oNcSkZH3sqMlRgJEXntkkAH48BSkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cXp2hsPzSzxryGInhskqenplDnjHJW62uACtubat+ZwRqrxYa4Ji0lNsht/Z7lZiJLKlRaoeUHk2hNWSqA8ADNAiTneQT60+K8iYgtpSrXiZnsR8piad0WtWEV60HKTPV8NgxHycCLOqjNFFvpGi3Y54z7DqEJ+abz/dyvtHUqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=DDP1QmsH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VVnbUFBm; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="DDP1QmsH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VVnbUFBm"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E085C7A016F;
	Wed,  8 Jul 2026 05:34:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 08 Jul 2026 05:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1783503286; x=1783589686; bh=354C8DBsR7
	lF4EpLDAAJWqKRblHNIMZkSshlcNBNqWs=; b=DDP1QmsHSKXfn+JLx1agr/0Br/
	A+F/4v6HskCmvd2Eyg5wDuy57ZjuCMMlzBbAyffSZeTlVrPrQVwPibdh+6kJUpo6
	dYay1yDzhbngbTo8Rsst1g0aHWR8I2CPgUt+67vYK+/0NS3YeoKTVny+l8L57wmE
	E5KOMVE6t2tPFdbybzkLJukRVl9BQsgJhTxRzPyELZhm158E2iGfaHS5NZUZNpzn
	80H5SCg/VQGd/JObaAFRsv9tp+Ed3DbjpIa4Bz9Aqp/AwN81FLrtRV/R7UAECVab
	PrzYeOzueDC8zx5Ly59ZnUsXtzMKC7lhUFNDG9a78NIpo6rnG+rlBl1gV6xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783503286; x=1783589686; bh=354C8DBsR7lF4EpLDAAJWqKRblHNIMZkSsh
	lcNBNqWs=; b=VVnbUFBmvmynrC163RNbdyGqOsznuZJig/23T+WeDM/mjlSMF6A
	nN/TJxSOs8VORjUDpvSCz5LQr9oT5RsDK3eSLYEVhyiQ9rdmGlfTdmrVOxE5/A7K
	1jPzhaNhg5SeoGXbwyHC21uwr7TRE7MItYqBv9cKFPwLEgACOP5Pn0JdbcJHBCQZ
	BJOxjIZTF39W10BEskVm/88Rt2dMqS8Peg0zPToiyZRVu3qBHb2gl/OLJQ4ZBL00
	lyYBPr+blwbLucwW64p86wGAFfV7DEea6ok3HWs9rpkbZoyH+DWULAg5sGNn6SWm
	L95TA3btdxfq7eHsW3L13o6qFO0aFasMusA==
X-ME-Sender: <xms:tRlOaohLueCyGgg-gIJURW8Cdn_DrAinYwof4vuDK5Q36PmvnbsDhw>
    <xme:tRlOan-2BM9bsXgAFXbKED1YJIZcKjA9h52FWzIhnW4Nh4SsRnlovKDP8NoPg0KUV
    mmRCdOZv_kEojXOfSi4Aheu_FWmaC6bptawN2ojBmAp_yCdYjN-wRJS>
X-ME-Received: <xmr:tRlOalIg-3EL4QcLpQcm1Po4uOflLkinBjuzFdeFxpXz3DbFEDIpDfv0vOjg2Q>
X-ME-Proxy-Cause: dmFkZTGULlKgltsBsg1+Gkf5WdAiwxiXDitmE7/sdEIta7s7Oo3eqRsLH4S/mjncebxwRa
    ZYAO8ntGqM7qKllzMHbJtsYbhHNGvLryo9pRwYkwcxImXh2E/Jx1iiKBCbvnS1nBpa7aog
    oIhqm7fzmz6L7PkMEgLVXaPFmx4u1aXn8I5/z17/cXbd08ie/mxiKrD3XUaEtslYZ+VYpW
    RV/dHfpjb3ztmmD83Lw7kUv/rLHqW3jXBoN2ATNGg6KVIepMybVHLQV08XTJCYKIdR/1As
    nDe/9GsxHmmg+GGmva+HMeWmsC3i7RL07p4pi8Itc5SE9CBuyfg5zUn7Sx3k34NO6S9Wkb
    WfQiBYbS6dRJdMNF/2IKvZW267kCHTezGJnbTInJNnvNeLcD4npAVpJ8NsEwrc/A2XsvkO
    wF55pCrephlyAVW8I5g4q9TylrIAuZs6weZ4WJTL/i7Owg2k3ImqvTFqC+ZZU463DSai0R
    NcScZqBAVRb/oArOEkd/Hsl/VjFftsqqJWLNRKX+SpDz8XcOEZiYZXQyH8pUk79Kcr8eba
    nalYud8HhW8gIYwXonLK0EKsE1KsnPSZ/jUkvnpGa7hTtwGABj8U2QBRz6csTQ4tHFcu/q
    L9GQdOzNCYYbzqgX6BHCf+PBfwKnlIWDLWHCc7U/aUKHowq/z6pZs/4PMfpQ
X-ME-Proxy: <xmx:tRlOaganRDOo4bWmuWWMT1B7OWrjyAz2lrnpb1gH4-7otSNzqLelSw>
    <xmx:tRlOagh2McqZiEO1xgALwFW-y63b_fG1MLI0Kg906Nqg_0hv_Pj2Qw>
    <xmx:tRlOat5ITMPKcUfQBHUpcTLc-CTQPz-KYvltZ2Mr6dqJywxLeP0WTw>
    <xmx:tRlOagrD5pSI95arKBK8wXc9KmuiqH8inwmP7nP66vCn-BiU2NZHgg>
    <xmx:thlOapVcPNmQt3Zie5hC76MHY4Z0pmbUg0eHkhiZW2Iz3ECc8ljU5CfP>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 05:34:44 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: akpm@linux-foundation.org
Cc: usama.anjum@collabora.com,
	peterx@redhat.com,
	liam@infradead.org,
	ljs@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	david@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	shuah@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH] fs/proc/task_mmu: fix PAGEMAP_SCAN written state for PMD holes
Date: Wed,  8 Jul 2026 10:34:44 +0100
Message-ID: <20260708093444.145566-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

PAGEMAP_SCAN reports an unpopulated PTE in a uffd-wp VMA as written
(pagemap_page_category() and the PAGE_IS_WRITTEN fast path), but a range
with no page table at all -- a PMD hole -- is skipped.
pagemap_scan_pte_hole() evaluates the hole against p->cur_vma_category,
which pagemap_scan_test_walk() builds from only PAGE_IS_WPALLOWED and
PAGE_IS_SOFT_DIRTY, so PAGE_IS_WRITTEN is never set: the hole is neither
reported nor, under PM_SCAN_WP_MATCHING, armed.

This is reachable. An anonymous THP is write-protected in place as a huge
PMD (change_huge_pmd(), anon is not split), and a full-PMD MADV_DONTNEED
clears it to pmd_none. A WP-async consumer such as CRIU then misses the
2MB drop -- the range is not reported written and the next incremental
dump keeps stale data. (A file/shmem THP is split on write-protect, so a
later DONTNEED leaves a populated page table of pte_none entries, which
are already reported; only anon THP reaches the hole path.)

Add PAGE_IS_WRITTEN to the categories evaluated for a hole in a uffd-wp
VMA, matching the pte_none handling in pagemap_page_category(). The
existing PM_SCAN_WP_MATCHING path then also arms the range:
uffd_wp_range() allocates the page table and installs markers under
WP_UNPOPULATED, so the next scan sees it clean until re-written.

Add a pagemap_ioctl selftest that forms an anon THP, drops it with
MADV_DONTNEED and checks the resulting PMD hole is reported written.

Fixes: 2bad466cc9d9 ("mm/uffd: UFFD_FEATURE_WP_UNPOPULATED")
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Assisted-by: Claude:claude-fable-5
---

Follow-up to the pte_none fix [1], which is a prerequisite (this touches
the same pagemap_ioctl selftest). [1] handled populated-then-dropped PTEs;
this closes the remaining anon-THP PMD-hole case.

[1] https://lore.kernel.org/all/20260707151349.92143-1-kirill@shutemov.name/
 fs/proc/task_mmu.c                         | 20 +++++++-
 tools/testing/selftests/mm/pagemap_ioctl.c | 60 +++++++++++++++++++++-
 2 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index d45c729ab6bb..6a4725ecb780 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -3049,12 +3049,28 @@ static int pagemap_scan_pte_hole(unsigned long addr, unsigned long end,
 {
 	struct pagemap_scan_private *p = walk->private;
 	struct vm_area_struct *vma = walk->vma;
+	unsigned long categories;
 	int ret, err;
 
-	if (!vma || !pagemap_scan_is_interesting_page(p->cur_vma_category, p))
+	if (!vma)
 		return 0;
 
-	ret = pagemap_scan_output(p->cur_vma_category, p, addr, &end);
+	/*
+	 * An unpopulated range with no page table -- e.g. a 2MB anon THP
+	 * dropped via MADV_DONTNEED, which pagemap_page_category() never sees
+	 * -- reads as written on a uffd-wp VMA, matching the pte_none case
+	 * there. Reporting it also lets the PM_SCAN_WP_MATCHING arming below
+	 * install markers (uffd_wp_range() allocates the page table under
+	 * WP_UNPOPULATED), so the next scan sees it clean until re-written.
+	 */
+	categories = p->cur_vma_category;
+	if (userfaultfd_wp(vma))
+		categories |= PAGE_IS_WRITTEN;
+
+	if (!pagemap_scan_is_interesting_page(categories, p))
+		return 0;
+
+	ret = pagemap_scan_output(categories, p, addr, &end);
 	if (addr == end)
 		return ret;
 
diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index 550d1f2c059b..c0e45d0f7478 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -25,6 +25,10 @@
 #include "kselftest.h"
 #include "hugepage_settings.h"
 
+#ifndef MADV_COLLAPSE
+#define MADV_COLLAPSE 25
+#endif
+
 #define PAGEMAP_BITS_ALL		(PAGE_IS_WPALLOWED | PAGE_IS_WRITTEN |	\
 					 PAGE_IS_FILE | PAGE_IS_PRESENT |	\
 					 PAGE_IS_SWAPPED | PAGE_IS_PFNZERO |	\
@@ -1102,6 +1106,59 @@ static void unpopulated_scan_test(void)
 	munmap(mem, mem_size);
 }
 
+/*
+ * A 2MB anon THP dropped with MADV_DONTNEED leaves a pmd_none hole with no
+ * page table, which pagemap_page_category() never sees. PAGEMAP_SCAN must
+ * still report it as written on a uffd-wp VMA, via pagemap_scan_pte_hole().
+ */
+static void unpopulated_thp_hole_test(void)
+{
+	long npages, written = 0, ret, i;
+	struct page_region regions[16];
+	char *area, *mem;
+
+	if (!hpage_size) {
+		ksft_test_result_skip("%s THP not supported\n", __func__);
+		return;
+	}
+	npages = hpage_size / page_size;
+
+	/* Get a PMD-aligned range so the range can be a single THP. */
+	area = mmap(NULL, 2 * hpage_size, PROT_READ | PROT_WRITE,
+		    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (area == MAP_FAILED)
+		ksft_exit_fail_msg("%s mmap failed\n", __func__);
+	mem = (char *)(((unsigned long)area + hpage_size - 1) & ~(hpage_size - 1));
+
+	memset(mem, 1, hpage_size);
+	if (madvise(mem, hpage_size, MADV_COLLAPSE) ||
+	    !check_huge_anon(mem, 1, hpage_size)) {
+		ksft_test_result_skip("%s could not form a THP\n", __func__);
+		munmap(area, 2 * hpage_size);
+		return;
+	}
+
+	wp_init(mem, hpage_size);
+
+	/* Drop the whole PMD: it is cleared to a pmd_none hole. */
+	if (madvise(mem, hpage_size, MADV_DONTNEED))
+		ksft_exit_fail_msg("%s MADV_DONTNEED failed\n", __func__);
+
+	ret = pagemap_ioctl(mem, hpage_size, regions, 16, 0, 0,
+			    PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
+	if (ret < 0)
+		ksft_exit_fail_msg("%s scan failed\n", __func__);
+	for (i = 0; i < ret; i++)
+		written += LEN(regions[i]);
+
+	ksft_test_result(written == npages,
+			 "%s pmd-hole reported written (%ld of %ld)\n",
+			 __func__, written, npages);
+
+	wp_free(mem, hpage_size);
+	munmap(area, 2 * hpage_size);
+}
+
 int sanity_tests(void)
 {
 	unsigned long long mem_size, vec_size;
@@ -1610,7 +1667,7 @@ int main(int __attribute__((unused)) argc, char *argv[])
 	if (!hugetlb_setup_default(4))
 		ksft_print_msg("HugeTLB test will be skipped\n");
 
-	ksft_set_plan(118);
+	ksft_set_plan(119);
 
 	page_size = getpagesize();
 	hpage_size = read_pmd_pagesize();
@@ -1790,6 +1847,7 @@ int main(int __attribute__((unused)) argc, char *argv[])
 
 	/* 18. Unpopulated pte scan-path consistency */
 	unpopulated_scan_test();
+	unpopulated_thp_hole_test();
 
 	close(pagemap_fd);
 	ksft_finished();

base-commit: 9795ad96d277c4af049fe30de1cebd4e39d7bcbe
-- 
2.54.0

