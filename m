Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5B33FCB1F
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922408; cv=none; b=R3ihZxd0feoZuzPsmgnxbOpS7aXENvur0660C33X85sacFJSqghwBaiAJ/6DzysueD7YkJ703dw8dcxKtL7BoVHdtybOMs+tkAcNnWR1wPMR3UigJ25K/+X2WhuoGlPBsFjbKJPjj1Tgy8KXlKr9q6pVa8ClGDSu+s4U1vdPsQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922408; c=relaxed/simple;
	bh=SKsnBcyhP1TTk8BI+tAf74ojyeBU2pMsM0PzpEpV5BU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a7gNzdx7YDbXrhirxvZm64uPOlaXo9plAjKuiOSgsUWgUqbu+yJsvlkuJAyj5y8T9/N0z4GTzae1rP0UCA7fJiZaNV9ekoFCKMVLuEmAhAXk4bLNilUTjQvIp4Sp5U4OTZYt8+JxKoAuMFLe241WliJWh9mFJy6NlloN712bUlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qN5Vo02a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qN5Vo02a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA051F000E9;
	Wed,  5 Aug 2026 09:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785922404;
	bh=ihe2EOrxHUhTjBkN4XvZ6VrnehLa/CjVvNchxgwwSzU=;
	h=Subject:To:Cc:From:Date;
	b=qN5Vo02aZ+XO19ry0pzxu0Awev192vyKK1rWSY9hqlr4wEkUAD8I9FlfiYfBrddwG
	 G9DJgVKCYaVYcTzV+OhtkmE3TVzTr/EKtMLoGCm55WZ2JSGCCkXsSGBBH+Xr76gp77
	 er4CUFNHACLKBnTJjpzo7oaw+oDWLaNGXG6trm3E=
Subject: FAILED: patch "[PATCH] fs/proc/task_mmu: fix PAGEMAP_SCAN written state for" failed to apply to 6.18-stable tree
To: kas@kernel.org,akpm@linux-foundation.org,david@kernel.org,jannh@google.com,liam@infradead.org,ljs@kernel.org,mhocko@suse.com,peterx@redhat.com,pfalcato@suse.de,rppt@kernel.org,shuah@kernel.org,stable@vger.kernel.org,surenb@google.com,usama.anjum@collabora.com,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:33:03 +0200
Message-ID: <2026080503-unpaired-outclass-9b75@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 07b4377bdbe74a3ec0c8da5849d014f70e003384
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080503-unpaired-outclass-9b75@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 07b4377bdbe74a3ec0c8da5849d014f70e003384 Mon Sep 17 00:00:00 2001
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Date: Tue, 7 Jul 2026 16:13:49 +0100
Subject: [PATCH] fs/proc/task_mmu: fix PAGEMAP_SCAN written state for
 unpopulated ptes

PAGEMAP_SCAN reports an unpopulated pte differently depending on which
path serves the request.  The PAGE_IS_WRITTEN fast path in
pagemap_scan_pmd_entry() reports a pte_none as written (and, under
PM_SCAN_WP_MATCHING, arms a marker); pagemap_page_category() returns 0 for
the same pte_none.  A request that cannot take the fast path (an extra
category bit, category_anyof_mask or category_inverted) therefore reports
the pte as clean and skips arming it.

A range that was populated and then MADV_DONTNEED'd reads as written via
one mask and clean via another, and in the latter case is not re-armed for
the next round -- an incremental-dump consumer (e.g.  CRIU) using a richer
mask drops the zapped range and stops tracking writes to it.

Report pte_none as written in pagemap_page_category() too.  A pte_none
carries no uffd-wp marker, i.e.  it is not write-protected -- the same
condition under which the present and swap cases already report
PAGE_IS_WRITTEN.  The fast path applies no VMA test, so neither does this.

The hugetlb and fully-unpopulated-PMD (no page table) scans have no
PAGE_IS_WRITTEN fast path, so they do not exhibit the per-entry divergence
and are left unchanged.

Add a pagemap_ioctl selftest that populates a range, drops it with
MADV_DONTNEED, and checks that the fast path and the generic
(category_anyof_mask) path both report every page written.

Link: https://lore.kernel.org/20260707151349.92143-1-kirill@shutemov.name
Fixes: 12f6b01a0bcb ("fs/proc/task_mmu: add fast paths to get/clear PAGE_IS_WRITTEN flag")
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Peter Xu <peterx@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Assisted-by: Claude:claude-fable-5
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index d32408f7cd5e..d45c729ab6bb 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2432,8 +2432,18 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
 {
 	unsigned long categories;
 
-	if (pte_none(pte))
-		return 0;
+	if (pte_none(pte)) {
+		/*
+		 * An unpopulated pte carries no uffd-wp marker, i.e. it is not
+		 * write-protected, the same condition under which the present
+		 * and swap cases below report PAGE_IS_WRITTEN. Report it here
+		 * too so this generic path agrees with the PAGE_IS_WRITTEN fast
+		 * path in pagemap_scan_pmd_entry(), which reports pte_none as
+		 * written and, under PM_SCAN_WP_MATCHING, arms a marker. The
+		 * fast path applies no VMA test, so neither does this.
+		 */
+		return PAGE_IS_WRITTEN;
+	}
 
 	if (pte_present(pte)) {
 		struct page *page;
diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index 6f8971d5b3ce..f9bcff8e78fa 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -1051,6 +1051,57 @@ static void test_simple(void)
 	ksft_test_result(i == TEST_ITERATIONS, "Test %s\n", __func__);
 }
 
+/*
+ * A range that was populated and then MADV_DONTNEED'd is genuine pte_none
+ * with no uffd-wp marker. Such a pte must read the same regardless of which
+ * PAGEMAP_SCAN path serves the request: both the PAGE_IS_WRITTEN fast path and
+ * the generic path (reached e.g. via category_anyof_mask) must report every
+ * page written.
+ */
+static void unpopulated_scan_test(void)
+{
+	int npages = 16, i;
+	long mem_size = npages * page_size;
+	struct page_region regions[16];
+	long fast = 0, slow = 0, ret;
+	char *mem;
+
+	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (mem == MAP_FAILED)
+		ksft_exit_fail_msg("%s mmap failed\n", __func__);
+
+	wp_init(mem, mem_size);
+
+	/* Populate, then drop: the ptes become pte_none without a marker. */
+	memset(mem, 1, mem_size);
+	if (madvise(mem, mem_size, MADV_DONTNEED))
+		ksft_exit_fail_msg("%s MADV_DONTNEED failed\n", __func__);
+
+	/* Fast path: category_mask == return_mask == PAGE_IS_WRITTEN. */
+	ret = pagemap_ioctl(mem, mem_size, regions, npages, 0, 0,
+			    PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
+	if (ret < 0)
+		ksft_exit_fail_msg("%s fast scan failed\n", __func__);
+	for (i = 0; i < ret; i++)
+		fast += LEN(regions[i]);
+
+	/* Generic path: same query expressed via category_anyof_mask. */
+	ret = pagemap_ioctl(mem, mem_size, regions, npages, 0, 0,
+			    0, PAGE_IS_WRITTEN, 0, PAGE_IS_WRITTEN);
+	if (ret < 0)
+		ksft_exit_fail_msg("%s generic scan failed\n", __func__);
+	for (i = 0; i < ret; i++)
+		slow += LEN(regions[i]);
+
+	ksft_test_result(fast == npages && slow == npages,
+			 "%s unpopulated ptes reported written by both paths (%ld, %ld of %d)\n",
+			 __func__, fast, slow, npages);
+
+	wp_free(mem, mem_size);
+	munmap(mem, mem_size);
+}
+
 int sanity_tests(void)
 {
 	unsigned long long mem_size, vec_size;
@@ -1559,7 +1610,7 @@ int main(int __attribute__((unused)) argc, char *argv[])
 	if (!hugetlb_setup_default(4))
 		ksft_print_msg("HugeTLB test will be skipped\n");
 
-	ksft_set_plan(117);
+	ksft_set_plan(118);
 
 	page_size = getpagesize();
 	hpage_size = read_pmd_pagesize();
@@ -1737,6 +1788,9 @@ int main(int __attribute__((unused)) argc, char *argv[])
 	/* 17. ZEROPFN tests */
 	zeropfn_tests();
 
+	/* 18. Unpopulated pte scan-path consistency */
+	unpopulated_scan_test();
+
 	close(pagemap_fd);
 	ksft_finished();
 }

