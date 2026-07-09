Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF15420E87;
	Thu,  9 Jul 2026 12:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783599394; cv=none; b=aOd2E7nIGrf1Ru6se15buq2NTlGHt3jO3lk9vQ384Bcd4cS65/YJzkGhxYmV5Tgw0spTvaOS6YoqIB0tVHylLSqzdbXZ116ctKqhS4/Lv3LkX9z6yWwqSWpzo2+b3QVI7PFprlgVyV2Xog7zTZP4SeHSV792Ry8TIDew7/h88hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783599394; c=relaxed/simple;
	bh=WIrDpyLWtrRY1e0Ac94I6P88L8bda7EJhq15cqc+dNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b6EwwiLldgA4/YB+QXZhcaY4WcBYT4/8N6Jfe3GBWyiitRWfVpLWRcyeNATcLnu5uffl4pQZa+8/RGAiI0v1oQSEtdjuBaFgJ0VRuzHg54JBgvJ9fUJe3zm614kqeWWaAv5Ay4X+9woMKorC7U7SndxTJp7MO/9y1SYmMmxahyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=RaOb4PrC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VawiVj7X; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="RaOb4PrC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VawiVj7X"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 68A607A00AE;
	Thu,  9 Jul 2026 08:16:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 09 Jul 2026 08:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1783599391; x=1783685791; bh=hEK13WQWeA
	5ZwXQid57FnwbvuSZ4wKnTcJfZBsCwn1g=; b=RaOb4PrCyjy7SpIM8G6dbPD1su
	cWCIM58P9O1ioUagMnuYs0qg6dOaO2ORYxlDcXyBQH1g+cXH6KDuc3ifwhq/UdcL
	4vHix+g3h692IXoYv4FHNcgcwccN5O6s+j9gnwfwRFxMmGFRnGr4pDrcgVc39iuU
	jmH+yaDh8iXUqg1bqsOySZeCnKpUrkTwK7s+aF362URcIJk0aORpeOhl08FxkCBf
	4dvCcgF7FnxP+bSE794OV6l8cDNF6lftJ/jl/tCmxuqqL+CMskWVRb1r1a7Cgyi0
	ATdafHZFGperFQPd8jfyC5Qhn3HLJqZx1+/wGEClG4Ut8oR9eMJaoK4DRaLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783599391; x=1783685791; bh=hEK13WQWeA5ZwXQid57FnwbvuSZ4wKnTcJf
	ZBsCwn1g=; b=VawiVj7X0FHuqwIxai9RfnMk/O3DyvqxhrWY6R4UENVayH+fNPk
	fgTCjdpvm3SWSVxAyTp4F84zCAkC9nfeM9YsNXzNg30jbQyFVSnl+yFha2l0EIqI
	reIijW1qd1PjyuAUUkmg8XkKDARvPqv6BFEg18qKsnDZamBBPZ4dRIFEPcXncfuC
	OYuHV4m+GZNwkNBnftuF1bHgXyfSDj17H2+F5nIDtCG6MjRIeXdKbdT584NOU7/o
	MXWNUV3g7CwuIzUsPD5pxDaAXBpqARzIp66tsL/pRrL5+AhE+lQjGSgejp+uXAc5
	FMCtUwhP4b5dDm0u45d54c9pEpoj0QVqRKg==
X-ME-Sender: <xms:HpFPalSZp4DLZjZjLmlfXGrkWJK7Wd-E5Oy9BXhPTzNs4DfcY1Cd6w>
    <xme:HpFPalsecaEyh2ctWJ8mv1Rd1msg98gC6GyM7AU0sTfUov3NJhK_Uux47-LbA0nkB
    G_jsaCKWEJ06rcs6agcIpVWfrnpABEfhBkdDR90p3HLY2H67ECVyNg>
X-ME-Received: <xmr:HpFPav4AQ_ZGamdCHcGkU5a13wd1pX4aW1oxuD_jp38sUl3ppatNeHTGfRhcBw>
X-ME-Proxy-Cause: dmFkZTFnh0a4DmHDBAHfJT6epMK+/J3A1HQhCntMiAF0QwbbbcPW8f71gxvjyIJwQP37pS
    BFvjCsK8ULXrO/FtdkuprFHp6cb/XCg6cydWcltNhUI6oLT1nd2AnziV90SYwWxfExly52
    wu+542vsAzOeVeCwMVs0nV4CNiTBAI3kRd4E/9ansCVIoDeuwGDBipM1I16+p2LN82OKzR
    MjqUSVS71MKxK3REj3IRTT1t6VBtI7aoyg8AJcY0O30w7nZw28IQ1+dBAmKWL8L3jk8mi4
    ggx0Q4e0IErxk7B8EQ7SgXToF7hYnedW4eyCUhnwTn4k15B3wV7imE3v6WKbBMVPvAlxS6
    al6t/Ic676gaa77h5ZWvWF0OTBcMogaNAntC6DA0j4QBsvxVYZ3tlMPGT6eXpOHB2B1nR2
    ynYRL5hWTE13VlxYs08fQDwrBRGXaZ1flgEVeSPkXq5tJ9a3iyDriFH1ULsx31xgcXv7E4
    M64kp/pcsHk3XRJLOc1UXw4jP9roszvlwxMHT0vCCqVZbu5dBSnb5Lw4hgiS+1zUCeWtor
    JgkuCjKP1yvvSv/l9kMPEU+Mq3UzHuuXxiVT7HBXY6LUwrSW+OI2UhLFZAUP49YB4/Jizo
    ykA2JQVnbzhA432Jf7C8FSnSx4A/wfMJ9Wi7Cs7zwe13128zOvSyF2qol78A
X-ME-Proxy: <xmx:HpFPakLYSWA-AEiCX1d0jVBSy3t1bqwKtvpdBKgGGwPoVpep3EQJWg>
    <xmx:HpFPapRU8wru2OGFck22y3HgF2Pyr6mg8m5wFKeC_FjWBdc-527z_g>
    <xmx:HpFPanrS2RRG_c-JUNdpU9WHBxrulLSM_0JBKHMxjyA4wGI-pQhl6w>
    <xmx:HpFPanaCnJukfanbmjKE1ulX8D92nMRuXxKihUMpXI-WW29pwCCwJw>
    <xmx:H5FPahHxQFXpYdU1Be5xkso9GDOU9C5OHT7pWy1-taaO8E3tBXi36_Uc>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 08:16:30 -0400 (EDT)
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
Subject: [PATCH v3] fs/proc/task_mmu: fix PAGEMAP_SCAN written state for PMD holes
Date: Thu,  9 Jul 2026 13:16:29 +0100
Message-ID: <20260709121629.205562-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

PAGEMAP_SCAN reports an unpopulated PTE in a uffd-wp VMA as written, but
a range with no page table at all -- a PMD hole -- is skipped:
pagemap_scan_pte_hole() tests p->cur_vma_category, which never carries
PAGE_IS_WRITTEN, so the hole is neither reported nor (under
PM_SCAN_WP_MATCHING) armed.

MADV_DONTNEED has fill-with-zeros semantics: it changes the contents of
the range to zeroes (a subsequent read maps the zero page), which write
tracking must report as written. An anonymous THP is write-protected in
place as a huge PMD, so a full-PMD MADV_DONTNEED clears it to pmd_none --
a hole -- and the zeroing goes unreported. A write-tracking
checkpoint/migration tool (e.g. CRIU) then treats the range as unchanged
and keeps its previous contents, so after restore or live migration the
process reads stale data instead of zeroes -- data corruption.

Report a hole in a non-hugetlb uffd-wp VMA as written, matching the
pte_none handling in pagemap_page_category(); the existing
PM_SCAN_WP_MATCHING path then arms it via uffd_wp_range().

hugetlb is excluded: pagemap_hugetlb_category() reports an empty hugetlb
entry (huge_pte_none) as not-written, unlike pagemap_page_category(),
which reports pte_none as written. pagemap_scan_pte_hole() fires for a
hugetlb slot only when it has no page table; keeping that not-written
matches how an allocated-but-empty hugetlb entry reads, so the hole and
the empty-entry cases agree within the VMA.

Add a pagemap_ioctl selftest covering the anon-THP PMD-hole case.

Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260707151349.92143-1-kirill@shutemov.name
Fixes: 2bad466cc9d9 ("mm/uffd: UFFD_FEATURE_WP_UNPOPULATED")
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Assisted-by: Claude:claude-fable-5
---

Changes since v2 [1], addressing Andrew's review:
  - Describe the user-visible effect: MADV_DONTNEED has fill-with-zeros
    semantics, so the range must be reported written; otherwise a
    checkpoint/migration tool (CRIU) keeps stale data and the process
    reads corrupted contents after restore. Add Reported-by/Closes.
  - Reword the hugetlb carve-out to rest on the category functions:
    pagemap_hugetlb_category() reads an empty hugetlb entry as
    not-written, unlike pagemap_page_category().
  - Drop the redundant MADV_COLLAPSE fallback #define; it is in
    <asm-generic/mman-common.h> and used directly by other mm selftests.

No functional change to the fix itself since v2.

[1] https://lore.kernel.org/all/20260708103429.150655-1-kirill@shutemov.name/
 fs/proc/task_mmu.c                         | 27 ++++++++++-
 tools/testing/selftests/mm/pagemap_ioctl.c | 56 +++++++++++++++++++++-
 2 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index d45c729ab6bb..03ead4184546 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -3049,12 +3049,35 @@ static int pagemap_scan_pte_hole(unsigned long addr, unsigned long end,
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
+	 *
+	 * hugetlb is excluded: pagemap_hugetlb_category() reports an empty
+	 * hugetlb entry (huge_pte_none) as not-written, unlike
+	 * pagemap_page_category(), which reports pte_none as written. This
+	 * path fires for a hugetlb slot only when it has no page table;
+	 * keeping that not-written matches how an allocated-but-empty
+	 * hugetlb entry reads, so the two agree within the VMA.
+	 */
+	categories = p->cur_vma_category;
+	if (userfaultfd_wp(vma) && !is_vm_hugetlb_page(vma))
+		categories |= PAGE_IS_WRITTEN;
+
+	if (!pagemap_scan_is_interesting_page(categories, p))
+		return 0;
+
+	ret = pagemap_scan_output(categories, p, addr, &end);
 	if (addr == end)
 		return ret;
 
diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index 550d1f2c059b..560499eb4737 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -1102,6 +1102,59 @@ static void unpopulated_scan_test(void)
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
@@ -1610,7 +1663,7 @@ int main(int __attribute__((unused)) argc, char *argv[])
 	if (!hugetlb_setup_default(4))
 		ksft_print_msg("HugeTLB test will be skipped\n");
 
-	ksft_set_plan(118);
+	ksft_set_plan(119);
 
 	page_size = getpagesize();
 	hpage_size = read_pmd_pagesize();
@@ -1790,6 +1843,7 @@ int main(int __attribute__((unused)) argc, char *argv[])
 
 	/* 18. Unpopulated pte scan-path consistency */
 	unpopulated_scan_test();
+	unpopulated_thp_hole_test();
 
 	close(pagemap_fd);
 	ksft_finished();

base-commit: 9795ad96d277c4af049fe30de1cebd4e39d7bcbe
-- 
2.54.0

