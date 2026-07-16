Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE16A422E0C;
	Thu, 16 Jul 2026 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784207029; cv=none; b=YungopaTklJuV1QQNfa9cuA8aFecpcO6GOAKI8iC0j8zRoRXYERlQK5eaDo2V2auqdsIBW6Dvsiy10L8URsHEISzQ3kJkw1z+d+I8LRICuuVskTZ943K0z11c6j02evv00AHUtu1oXob/kTYF5qNkQEpWaFiOrmCAfcLlz/zz4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784207029; c=relaxed/simple;
	bh=/vTNrttTzHCT3PwUllbzwEdmFPZ2HL3FX2d/1DO4zhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMokQg/VcGUtJKsS2c8cbfI5r800rCrp5ksExWBRdb4CsWr8CI/Kv7TMdXp+84I/3gnnX+us9qGYx1SWq0gYIcPSR6LblJhbcwpFi1nkIK2H9zJhpm5OYVLsTJaMotNx1qXE1Bu+wIaRuh/Lwx8wQiKERFPvCTgwSBjCXOD7LRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=jTYnDFj5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ow5lc6kz; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="jTYnDFj5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ow5lc6kz"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D2A31EC0067;
	Thu, 16 Jul 2026 09:03:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 16 Jul 2026 09:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1784207025; x=
	1784293425; bh=P4sPOn37OCBYFsXI0lvLOBbwI6X5nF8OaGmm6rn9AWM=; b=j
	TYnDFj5l/0k7n7PZwMoqsOgQ4u4i/hW4zdZFItnbM629AIDubwH3b5BtNRe+OEIv
	uamf9S0WOpPHFgwol0F9ue4funs2FQV6lL/3Wc9GvWlHJ5iOHRhVKKZV5e/qq5Ub
	8eEiGAYqXffNj9spaH4mN9UuTuBhC1C9jqUqomGZt0mC1Admy+LXUnnhuUjJdcNJ
	nqSiSbJjcvXdNZU0LK57u/q4lpbYxqYnl3nvTbU77pfI+yH8c5Z8UvwuCldjZamU
	3eCaBz8ZvvX1rDCbi/o7BlxCi1Rz9hq085VFMEEJKDYTtndb1LvYblo/UvYmQw+e
	sRSFkxQkG89y0F7iBgT4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784207025; x=1784293425; bh=P4sPOn37OCBYFsXI0lvLOBbwI6X5nF8OaGm
	m6rn9AWM=; b=ow5lc6kz+SWys7geQb2rl9HIYyQN0kVKxnJTqtcbFQJlS+ZjY1W
	KciOlDa2gjbiC94b671dEASbSWxtVmfzznTAuIAQpEMVz6paw4IfgnA+Jg7yVd+X
	rBhbIeiIoxgTAgyGM42yUX5fU8/vsvCso55BH+HA/m7tJ4YnOCf18NUAdnQmWOHO
	0CdDXgPx2pjFC01ZxsJ77a9YJZ9xOyuVM9ZS6XxSLqiZl1Nx6eFd9mstcF5pdAmV
	8LPvptocKdPMipdTr6JjGuSV/q8To5799Z6W5FoyLHFOsDzGwycWPRi3ZAxQt2Cc
	82F7eS3VfY8zFKsY9P+f6hryVjIQkuEnC1w==
X-ME-Sender: <xms:sdZYaoZDwq_r20f9uYAxPBXBWJ5gN2Kf75SdKFI1VAAbRjM_aS-dfA>
    <xme:sdZYapgHdM9dBoECMOaHVkHw6KLubVaSu6MlCNoj85ohsjVKPxJ_8_6nQRGa7igzb
    x39VPS8U0S58-CKSiSI2Wsd9VFEwio6IWv79ziGDcFceK1eBPDaDsI>
X-ME-Received: <xmr:sdZYapd9iy0fmgyetcUkYijNjtL7TjawVMyumobgbL3hj_c3N_D7QnoQ6BlpQA>
X-ME-Proxy-Cause: dmFkZTGHiYKfxGpE1R0pHf/Rslp7BzHpXTJCYOqmlxtwcXGk43FrFfU5piPux8EZF8hSz3
    LqiC4rKTBdoYR3TxWLCFn/tSr178V8YFCLbeAi0Ho7nRsg2ZdvOK7Wov5he7YY93S6h/SM
    V1CWg/B8B6c5OEdsoFFSnuxXOVLag+/HcaMqGRmPCAtk7JIJSTnlfhkptC1paC1SolajWL
    O0jTVTY6EjGDxU1XOtWb0aA6A95L+VnA7XjKwZUT3LFjbHOAhUkhnfdKhCHn8XNvHMHxvr
    JOaPIggA4Ck3RaXTG1JhceF+fF1a/C7hplt7Rj4M/4mTINyTqla1LzzlN+NU92gNZKgCOW
    hYUQ1HIwC9KYiKVAKgco/LdwrgVzH6sbDKmwrkdaX48l5IXWfvCkAq9i+pS/Gc3h+Hnuxi
    TCTpfKfzq6nrgcO/ZNpXiOva60wN6S/bS5M8KBc5uweVI02nsxh6Oze7Efx1Tv9kkJ/vE5
    j0uyTm2mvWd+zwYJE1zdMeVjXhY4QW8ny5OiYmix+4WZBVEpUyM/Igc+c4Paw4OiHvdEMJ
    SerdkM4Y+7E8uamTtXZAFaSttr9BMd5LiF6GI42Pj7s2UFaOD1uyi58+upZrPxi3UwechH
    CaVqsliLnNgu/PLagGAt9kN8KM6JZk20bHMHrsxzh3mtnvJa2EnIKgcA0nXA
X-ME-Proxy: <xmx:sdZYasq4BkH5khn6G8vzsFc9UYh_6aIsyYGSik-njYkEjRzKCNASWg>
    <xmx:sdZYanRJIRMXdWEmF_P1cr0jK-B3eqi3HXO-8BW0tczBxtMyeXo0FA>
    <xmx:sdZYaj7njaC2Wa3IK3Y7OearxWnU2rsWz50BQc_EGs6qcPJHEIL6QA>
    <xmx:sdZYajPQAl7LdMohp-DDxcjAI6e4e2LPB5ny0SPkjtOEgmen6uaY0A>
    <xmx:sdZYahqRATdttG8IF8P7cMVCABOEBKZhhFPgl-TcL3JVvZ3_JmZSC6md>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 09:03:44 -0400 (EDT)
Date: Thu, 16 Jul 2026 14:03:43 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, usama.anjum@arm.com, peterx@redhat.com, 
	liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, jannh@google.com, 
	pfalcato@suse.de, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	zenghui.yu@linux.dev, shuah@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v5 2/2] selftests/mm: add PAGEMAP_SCAN test for THP PMD
 holes
Message-ID: <aljWYfPRCVc6IB2b@thinkstation>
References: <20260715144234.442721-1-kirill@shutemov.name>
 <20260715144234.442721-3-kirill@shutemov.name>
 <714bdcbb-92cd-4dde-820c-e3761cbbaf07@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <714bdcbb-92cd-4dde-820c-e3761cbbaf07@kernel.org>

On Thu, Jul 16, 2026 at 01:25:22PM +0200, David Hildenbrand (Arm) wrote:
> 
> > +	/* Fast path: category_mask == return_mask == PAGE_IS_WRITTEN. */
> > +	ret = pagemap_ioctl(mem, hpage_size, regions, ARRAY_SIZE(regions), 0, 0,
> > +			    PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
> > +	for (i = 0; ret > 0 && i < ret; i++)
> > +		fast += LEN(regions[i]);
> > +
> > +	/* Generic path: same query expressed via category_anyof_mask. */
> > +	ret = pagemap_ioctl(mem, hpage_size, regions, ARRAY_SIZE(regions), 0, 0,
> > +			    0, PAGE_IS_WRITTEN, 0, PAGE_IS_WRITTEN);
> > +	for (i = 0; ret > 0 && i < ret; i++)
> > +		slow += LEN(regions[i]);
> > +
> > +	ksft_test_result(fast == npages && slow == npages,
> > +			 "%s pmd-hole reported written by both paths (%ld, %ld of %d)\n",
> > +			 __func__, fast, slow, npages);
> > +out:
> > +	wp_free(mem, hpage_size);
> > +	munmap(area, 2 * hpage_size);
> > +}
> 
> Sorry if I wasn't clear. I think unpopulated_thp_scan_test() can actually reuse
> bits of unpopulated_scan_test().

Ah. Make sense.

Here's my take on this. Looks good?

-- >8 --
Date: Thu, 16 Jul 2026 13:24:29 +0100
Subject: [PATCH v6 2/2] selftests/mm: add PAGEMAP_SCAN test for THP PMD holes

Add coverage for the PMD-hole case fixed by "fs/proc/task_mmu: fix
PAGEMAP_SCAN written state for PMD holes": a MAP_PRIVATE|MAP_ANON THP that
is uffd-wp'd and then dropped with MADV_DONTNEED leaves a pmd_none hole
with no page table, which PAGEMAP_SCAN must still report as written.

Factor the populate/drop/scan-both-paths sequence out of
unpopulated_scan_test() into a helper, and add unpopulated_thp_scan_test()
that reuses it with a THP.

Include <linux/mman.h> for MADV_COLLAPSE; <sys/mman.h> lacks it on older
glibc (e.g. 2.34). Same approach as commit fd5295afae91 ("selftests/mm:
hmm-tests: include linux/mman.h to access MADV_COLLAPSE").

Cc: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Zenghui Yu <zenghui.yu@linux.dev>
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Assisted-by: Claude:claude-fable-5
---
 tools/testing/selftests/mm/pagemap_ioctl.c | 118 +++++++++++++++------
 1 file changed, 83 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index 550d1f2c059b..693030f1e631 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -8,6 +8,7 @@
 #include <errno.h>
 #include <malloc.h>
 #include <linux/types.h>
+#include <linux/mman.h>
 #include <linux/memfd.h>
 #include <linux/userfaultfd.h>
 #include <linux/fs.h>
@@ -1058,50 +1059,96 @@ static void test_simple(void)
  * the generic path (reached e.g. via category_anyof_mask) must report every
  * page written.
  */
+/*
+ * Populate @mem (optionally collapsing it into a THP first), drop it with
+ * MADV_DONTNEED, then check PAGEMAP_SCAN reports the whole range written via
+ * both the fast and generic query paths. A dropped THP leaves a pmd_none hole
+ * with no page table, exercising pagemap_scan_pte_hole(); a base-page range
+ * leaves pte_none entries.
+ */
+static void unpopulated_written_test(const char *name, char *mem, long size,
+				     bool use_thp)
+{
+	long npages = size / page_size, fast = 0, slow = 0, ret;
+	struct page_region regions[16];
+	int i;
+
+	wp_init(mem, size);
+
+	/* Populate, optionally collapse to a THP, then drop it. */
+	memset(mem, 1, size);
+	if (use_thp &&
+	    (madvise(mem, size, MADV_COLLAPSE) ||
+	     !check_huge_anon(mem, size / hpage_size, hpage_size))) {
+		ksft_test_result_skip("%s could not form a THP\n", name);
+		goto out;
+	}
+	if (madvise(mem, size, MADV_DONTNEED)) {
+		ksft_test_result_fail("%s MADV_DONTNEED failed\n", name);
+		goto out;
+	}
+
+	/* Fast path: category_mask == return_mask == PAGE_IS_WRITTEN. */
+	ret = pagemap_ioctl(mem, size, regions, ARRAY_SIZE(regions), 0, 0,
+			    PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
+	for (i = 0; ret > 0 && i < ret; i++)
+		fast += LEN(regions[i]);
+
+	/* Generic path: same query expressed via category_anyof_mask. */
+	ret = pagemap_ioctl(mem, size, regions, ARRAY_SIZE(regions), 0, 0,
+			    0, PAGE_IS_WRITTEN, 0, PAGE_IS_WRITTEN);
+	for (i = 0; ret > 0 && i < ret; i++)
+		slow += LEN(regions[i]);
+
+	ksft_test_result(fast == npages && slow == npages,
+			 "%s unpopulated range reported written by both paths (%ld, %ld of %ld)\n",
+			 name, fast, slow, npages);
+out:
+	wp_free(mem, size);
+}
+
 static void unpopulated_scan_test(void)
 {
-	int npages = 16, i;
-	long mem_size = npages * page_size;
-	struct page_region regions[16];
-	long fast = 0, slow = 0, ret;
+	long mem_size = 16 * page_size;
 	char *mem;
 
 	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE,
 		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-	if (mem == MAP_FAILED)
-		ksft_exit_fail_msg("%s mmap failed\n", __func__);
+	if (mem == MAP_FAILED) {
+		ksft_test_result_skip("%s mmap failed\n", __func__);
+		return;
+	}
 
-	wp_init(mem, mem_size);
-
-	/* Populate, then drop: the ptes become pte_none without a marker. */
-	memset(mem, 1, mem_size);
-	if (madvise(mem, mem_size, MADV_DONTNEED))
-		ksft_exit_fail_msg("%s MADV_DONTNEED failed\n", __func__);
-
-	/* Fast path: category_mask == return_mask == PAGE_IS_WRITTEN. */
-	ret = pagemap_ioctl(mem, mem_size, regions, npages, 0, 0,
-			    PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
-	if (ret < 0)
-		ksft_exit_fail_msg("%s fast scan failed\n", __func__);
-	for (i = 0; i < ret; i++)
-		fast += LEN(regions[i]);
-
-	/* Generic path: same query expressed via category_anyof_mask. */
-	ret = pagemap_ioctl(mem, mem_size, regions, npages, 0, 0,
-			    0, PAGE_IS_WRITTEN, 0, PAGE_IS_WRITTEN);
-	if (ret < 0)
-		ksft_exit_fail_msg("%s generic scan failed\n", __func__);
-	for (i = 0; i < ret; i++)
-		slow += LEN(regions[i]);
-
-	ksft_test_result(fast == npages && slow == npages,
-			 "%s unpopulated ptes reported written by both paths (%ld, %ld of %d)\n",
-			 __func__, fast, slow, npages);
-
-	wp_free(mem, mem_size);
+	unpopulated_written_test(__func__, mem, mem_size, false);
 	munmap(mem, mem_size);
 }
 
+/*
+ * Same as unpopulated_scan_test(), but the range is a THP: a full-PMD
+ * MADV_DONTNEED leaves a pmd_none hole with no page table.
+ */
+static void unpopulated_thp_scan_test(void)
+{
+	char *area, *mem;
+
+	if (!hpage_size) {
+		ksft_test_result_skip("%s THP not supported\n", __func__);
+		return;
+	}
+
+	/* Over-allocate so a PMD-aligned, THP-sized range fits inside. */
+	area = mmap(NULL, 2 * hpage_size, PROT_READ | PROT_WRITE,
+		    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (area == MAP_FAILED) {
+		ksft_test_result_skip("%s mmap failed\n", __func__);
+		return;
+	}
+	mem = (char *)(((unsigned long)area + hpage_size - 1) & ~(hpage_size - 1));
+
+	unpopulated_written_test(__func__, mem, hpage_size, true);
+	munmap(area, 2 * hpage_size);
+}
+
 int sanity_tests(void)
 {
 	unsigned long long mem_size, vec_size;
@@ -1610,7 +1657,7 @@ int main(int __attribute__((unused)) argc, char *argv[])
 	if (!hugetlb_setup_default(4))
 		ksft_print_msg("HugeTLB test will be skipped\n");
 
-	ksft_set_plan(118);
+	ksft_set_plan(119);
 
 	page_size = getpagesize();
 	hpage_size = read_pmd_pagesize();
@@ -1790,6 +1837,7 @@ int main(int __attribute__((unused)) argc, char *argv[])
 
 	/* 18. Unpopulated pte scan-path consistency */
 	unpopulated_scan_test();
+	unpopulated_thp_scan_test();
 
 	close(pagemap_fd);
 	ksft_finished();
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
