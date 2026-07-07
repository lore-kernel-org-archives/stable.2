Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEB337B02D;
	Tue,  7 Jul 2026 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437235; cv=none; b=ucF9hm0EtlKUN2f5fewpb6mI27eSdJFWi8Om+BBQyG2lq+529lz9pBWHyzW4vSeDDrNohNqf0mbJQ+qGtYQuLL/5/pal14igA3+H6Pe3MIJau6rgbhrKg9L6Y+6BJ1mNkjwoS2Nis2G5yLvpiqm41VpsgfpY48qsdIqYH+zsj7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437235; c=relaxed/simple;
	bh=P5shd4uher+LOoJ0dutjD1ui0rDX8pkfvhcm56OtTKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CX0HGJeoP5V+S8UDI/U4S1PB2oPLY73yN4CtW3nKVKD7rrRcU8ZCpEFoZmnedi+DwmyNiCRkkb/rWGKGmIzvim+V/4Adbxm62KhlFnU7ba3MFOfI5FJxPkh7mqsjv9oUIN6h5mZ7WkMBGHaRZG14/+7u2SscjSidjJ5igkxYAmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=y2D7U56W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A66O33Om; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="y2D7U56W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A66O33Om"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D32ED1400060;
	Tue,  7 Jul 2026 11:13:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 07 Jul 2026 11:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1783437232; x=1783523632; bh=yHnAHFidDo
	8khkFB9/mnK79nGDjqLvmK8s2Lu6YNrRs=; b=y2D7U56WVBDMlVcDzkgqSe6iKR
	e7AQUoz61t1hrh63gYk6Yj7Sz9d18qx71ARnOEDBQjMYdLORasIoVcSX6RfdTuPp
	GDSRPhGMh5ZE5R4bRnlKpz5Bbi9KnRcFzUyea+u0LsqGB+kd2ZwHg70iquTSB7J9
	0iG2V5D/Mt5czH123UjK2P0X4pg9xXuEtaaLK89OPilePHyTHcfOEIXHjoSWaJaq
	zN6wfg/3lpKuTKz3RorO2DrYzs1BIWZt3eqBv8BRUCHEa8dcTpCMM/3ABuhI70h5
	ahH862/XE9JLV2IKinfNByyc5l0LD7wIXcgvJ59H0oXBKsNIRheExFPEbaqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783437232; x=1783523632; bh=yHnAHFidDo8khkFB9/mnK79nGDjqLvmK8s2
	Lu6YNrRs=; b=A66O33OmsHTi6Doh2SSYWo+yPNwdtdfNPgS7NfQAYlSzrjbEcFO
	Bjm/ysBPVxPycknpsCqZg6UnhTBfAn/IdH5vAQq3K3Jng3jWCv34bJvA56oYfk/n
	NT40kmBDgTzxq7dLxHNSCObZDrFV2Jip15W29KgszzXJjOapHtooB3ekwqE/QjNh
	sKvEYY1l31Jpcs76ad8JLQsG9zAaQk6DnAGPRWWkpjjk2HLs7r0RAVE0lfTcUTrF
	7BqfN9JZiTyB164PjNkPwm7x3vryPZ67gTPss/m4qjn+LgZPNovzM1BYiGeI7BZS
	IJBCc8IxV1oO7AThCwSdWTW+jzjZc8v7rvQ==
X-ME-Sender: <xms:rxdNaqWubJlzNtUGhx1wVQ4VQZgvbwrUZANDClSPY0Xku3B1a4xLHw>
    <xme:rxdNatj3LSPPGJ7P84BieoAQVBzc6dHLrYEj-JNsUOpsda7RIJ73hi6SLabeM-1Yx
    8Brvhwwdp8zlMxUGQTYhzMSB2E0pzLJ97yjBqLa-NtRBF9HEBg2tyiz>
X-ME-Received: <xmr:rxdNajfpTcRiKYdxBFqUA233bKF7SXj45KcYU8vi_xeizaOyxyOO1ujPVX4nZg>
X-ME-Proxy-Cause: dmFkZTEiLljjhqgaKKNY5aZiI+jEvjyU81SjON7V5vxdWCBsAwiOWcMHlYKbwS5Zrkx5gR
    gCjHbuYgokG++jJItBiQhtpm+cB6FDJvAvsG3q/4/1cmcnN6cGUCTkXyE0xgArRFzlE5El
    kS57rEdf6c7FRigb6EVHz5I8NgITm5hE9uU5jJ7Yy0irnbojHwrL3UqHqCzYahdFhlp3Rn
    t7tNdtwaznApTVOOTQhMcpm/4Ym1ibGsImDL4LHR+9hUOdo4v2M8+/Y81ukPPhJYW+fMNY
    pv5tppNMfiOEsQWUahBzzxe4IAVuG3YnCsItoPUwYN+1xRunHaMkQ+CwbvNWVkKR95zlPt
    YCT+F1FZFKCD5Tg3l0hb4zMza38/aDkkI3ZK6OPxjcDlPI0/0JKJ9UmdqBCu4jaBnupI46
    Ztsv6YbM2s/pnJVI+tQ2H9trktCIKFhZ1JM0yX70Z2AsAYadbPwRWrshFkNMsl//LcWKw8
    bFIY/9QtE3iqHzYDXJHUVBmv+8jE88fejHKnxY8Qtkpu3BPG3XDETKgib08Zak+XLSNQxD
    nydTe/Gvou4YUXtei3MSI5dAhhZr7CSiu9HSAwXmthzvyvnEMaGbomJyZ7sRCzyylZeLwq
    4PwUVXGvwBNLB8rTsbYk+4evVXYRmejH+51UsudB+RAaGK2gN+Z7tMhn7V0g
X-ME-Proxy: <xmx:rxdNaofuHWpKuAMadg7GdAasb6KLzqSzA5nVG19B2zpJcaXo0VHerw>
    <xmx:rxdNavXN3iO5BThnNRlkyC6GbyzxCDrntc7wXLA8A9ERf740pKgiVw>
    <xmx:rxdNasemlUMOaGffimLQbepO2jFqLJRe1OBYd4OqfZD6wBJnuIWkkw>
    <xmx:rxdNaj8VT7-LKy3y86yuBhs_CCUY3256GQ3-JD7lAqPoJQGXTz8OAQ>
    <xmx:sBdNatrWZXAHxK-M-H1KwytAJTNxX4CVK9ujGU-u9tp6uVAvi2p_mHRS>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 11:13:51 -0400 (EDT)
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
Subject: [PATCH v2] fs/proc/task_mmu: fix PAGEMAP_SCAN written state for unpopulated ptes
Date: Tue,  7 Jul 2026 16:13:49 +0100
Message-ID: <20260707151349.92143-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

PAGEMAP_SCAN reports an unpopulated pte differently depending on which
path serves the request. The PAGE_IS_WRITTEN fast path in
pagemap_scan_pmd_entry() reports a pte_none as written (and, under
PM_SCAN_WP_MATCHING, arms a marker); pagemap_page_category() returns 0
for the same pte_none. A request that cannot take the fast path (an
extra category bit, category_anyof_mask or category_inverted) therefore
reports the pte as clean and skips arming it.

A range that was populated and then MADV_DONTNEED'd reads as written via
one mask and clean via another, and in the latter case is not re-armed
for the next round -- an incremental-dump consumer (e.g. CRIU) using a
richer mask drops the zapped range and stops tracking writes to it.

Report pte_none as written in pagemap_page_category() too. A pte_none
carries no uffd-wp marker, i.e. it is not write-protected -- the same
condition under which the present and swap cases already report
PAGE_IS_WRITTEN. The fast path applies no VMA test, so neither does this.

The hugetlb and fully-unpopulated-PMD (no page table) scans have no
PAGE_IS_WRITTEN fast path, so they do not exhibit the per-entry
divergence and are left unchanged.

Add a pagemap_ioctl selftest that populates a range, drops it with
MADV_DONTNEED, and checks that the fast path and the generic
(category_anyof_mask) path both report every page written.

Fixes: 12f6b01a0bcb ("fs/proc/task_mmu: add fast paths to get/clear PAGE_IS_WRITTEN flag")
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Assisted-by: Claude:claude-fable-5
---

Changes since v1 [1], addressing Sashiko AI review:
  - Report pte_none unconditionally instead of only on userfaultfd_wp
    VMAs. v1 left the fast vs generic path mismatch in place for
    non-uffd-wp VMAs, where the fast path applies no VMA test.
  - Strengthen the selftest to assert both paths report every page
    written (v1 only checked the two counts were equal, which passes
    vacuously if both are 0).

The hugetlb and fully-unpopulated-PMD scans have no PAGE_IS_WRITTEN fast
path, so they stay self-consistent and are out of scope here.

[1] https://lore.kernel.org/all/20260706104308.34741-1-kirill@shutemov.name/
 fs/proc/task_mmu.c                         | 14 +++++-
 tools/testing/selftests/mm/pagemap_ioctl.c | 56 +++++++++++++++++++++-
 2 files changed, 67 insertions(+), 3 deletions(-)

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
index 762306177ad8..550d1f2c059b 100644
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

base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.54.0

