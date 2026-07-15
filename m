Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1123A2EEE9C;
	Wed, 15 Jul 2026 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123226; cv=none; b=kflW3jryHynAUM9QGahP5PZCh7lBu9fB0IqUblsini0viHCpXmW4bFq9iWbq2TwQFvyIWMmHxZ5/zmtp9LGY1IyQDQ/WaR7e2HSX4vAgGP1i7IFAUX6sR72dth0M1PEipIW6j3NJQWxFGA+6GUeF23Ed6lVelfZ7DQ73YaZc5Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123226; c=relaxed/simple;
	bh=utAqGF14IqKAmxjlrml7biHbjSk3cLLaKYMyaFWHUyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l6DDSM6MImKKmvQEPtj6KP02Ak2vBvMxp3o/Kbg08MJrn14qklzHDqiOxl8JzzwmheIDpTLQxmPqDl6ejee4yW5rCBu+EIRnxzOkd3iFQxeaYEAhl9d+NhmohqmqloblmU9ZhKTns0GtbMZUU0vUGozAlT/NH1DoY4I4bgNbzag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7A+mev9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7A+mev9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82731F00A3A;
	Wed, 15 Jul 2026 13:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784123224;
	bh=aP96cxQwNvwA5luy8u1o+ZF1ybuDilkkCbV3IS4N/IM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=i7A+mev99IMS5NhE6uoqCpYFn8cTH9RCK3VXAifzAqJko4VXnsfJJ2QyNF/9FbLmg
	 bfYcMMLi8C/1x5jYcmfAIVmT/xR+MdEBlZdY/UvFqW2FnveSNimZEiwQsW5jSB2QXD
	 443E3IRIBWtO3tp89gm5EIGg3ewoscj0YmL3760CBlsvewBg+HxCZ126RCKGGePX1z
	 clxKAGTwC/O8HXnLUgJfbK3Q6WEGrcKw95n8SzjNdhjQNsHXfDJgDQydx+Mt8Q/jas
	 BQmayOGJMQCo0JDWjHOvKENRGXmyALfcFtCC5C8/afg3/o6MhIj18J99RgWb+vbjk1
	 ooTQo2V8YBGVA==
Message-ID: <f5700c45-9eab-47e1-946c-47d9a531bfeb@kernel.org>
Date: Wed, 15 Jul 2026 15:47:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] fs/proc/task_mmu: fix PAGEMAP_SCAN written state for
 PMD holes
To: Kiryl Shutsemau <kirill@shutemov.name>, akpm@linux-foundation.org
Cc: usama.anjum@collabora.com, peterx@redhat.com, liam@infradead.org,
 ljs@kernel.org, vbabka@kernel.org, jannh@google.com, pfalcato@suse.de,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, shuah@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org, kernel-team@meta.com
References: <20260713091710.206548-1-kirill@shutemov.name>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260713091710.206548-1-kirill@shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/13/26 11:17, Kiryl Shutsemau wrote:
> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> 

Reading this, some of the details how this fits together are missing. You
capture some of that in the comment.

> PAGEMAP_SCAN reports an unpopulated PTE in a uffd-wp VMA as written, but
> a range with no page table at all -- a PMD hole -- is skipped:
> pagemap_scan_pte_hole() tests p->cur_vma_category, which never carries
> PAGE_IS_WRITTEN, so the hole is neither reported nor (under
> PM_SCAN_WP_MATCHING) armed.

Okay, the reason is that UFFD_FEATURE_WP_UNPOPULATED will make use of uffd
markers when protecting a range.

Seeing that marker gone translates to "MADV_DONTNEED was used". At least on
anonymous memory, looking at zap_install_uffd_wp_if_needed().

> 
> MADV_DONTNEED has fill-with-zeros semantics: it changes the contents of
> the range to zeroes (a subsequent read maps the zero page), which write

Only in MAP_PRIVATE | MAP_ANON mappings.

For e.g., MAP_PRIVATE file/shmem it will fallback to the original pagecache page
and there are no such guarantees.

> tracking must report as written. An anonymous THP is write-protected in
> place as a huge PMD, so a full-PMD MADV_DONTNEED clears it to pmd_none --
> a hole -- and the zeroing goes unreported. A write-tracking
> checkpoint/migration tool (e.g. CRIU) then treats the range as unchanged
> and keeps its previous contents, so after restore or live migration the
> process reads stale data instead of zeroes -- data corruption.

With UFFD_FEATURE_WP_UNPOPULATED, uffd-write-protecting a range without a PMD
table will end up allocating a page table (pgtable_populate_needed) that will be
filled with uffd-wp markers.

So what needs to happen is getting a THP collapsed there, to then zap the THP.

Or, of course, zapping a THP that was uffd-wp'ed. (which is what your test case
does IIUC)

> 
> Report a hole in a non-hugetlb uffd-wp VMA as written, matching the
> pte_none handling in pagemap_page_category(); the existing
> PM_SCAN_WP_MATCHING path then arms it via uffd_wp_range().

About which memory backing are walking about? Anon? Shmem? Something else?

> 
> hugetlb is excluded: pagemap_hugetlb_category() reports an empty hugetlb
> entry (huge_pte_none) as not-written, unlike pagemap_page_category(),
> which reports pte_none as written. pagemap_scan_pte_hole() fires for a
> hugetlb slot only when it has no page table; keeping that not-written
> matches how an allocated-but-empty hugetlb entry reads, so the hole and
> the empty-entry cases agree within the VMA.
> 
> Add a pagemap_ioctl selftest covering the anon-THP PMD-hole case.
> 


Do we really want to backport a test case? Usually we split them from the actual
fix.

> Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260707151349.92143-1-kirill@shutemov.name
> Fixes: 2bad466cc9d9 ("mm/uffd: UFFD_FEATURE_WP_UNPOPULATED")
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Assisted-by: Claude:claude-fable-5
> ---
> 
> Changes since v3 [1]:
>   - Include <linux/mman.h> for MADV_COLLAPSE; <sys/mman.h> lacks it on
>     older glibc (e.g. 2.34), breaking the selftest build. Same approach
>     as fd5295afae91 ("selftests/mm: hmm-tests: include linux/mman.h to
>     access MADV_COLLAPSE"). Reported by Zenghui Yu.
> 
> [1] https://lore.kernel.org/all/20260709121629.205562-1-kirill@shutemov.name/
>  fs/proc/task_mmu.c                         | 27 +++++++++-
>  tools/testing/selftests/mm/pagemap_ioctl.c | 57 +++++++++++++++++++++-
>  2 files changed, 81 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index d45c729ab6bb..03ead4184546 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -3049,12 +3049,35 @@ static int pagemap_scan_pte_hole(unsigned long addr, unsigned long end,
>  {
>  	struct pagemap_scan_private *p = walk->private;
>  	struct vm_area_struct *vma = walk->vma;
> +	unsigned long categories;
>  	int ret, err;
>  
> -	if (!vma || !pagemap_scan_is_interesting_page(p->cur_vma_category, p))
> +	if (!vma)
>  		return 0;
>  
> -	ret = pagemap_scan_output(p->cur_vma_category, p, addr, &end);
> +	/*
> +	 * An unpopulated range with no page table -- e.g. a 2MB anon THP
> +	 * dropped via MADV_DONTNEED, which pagemap_page_category() never sees
> +	 * -- reads as written on a uffd-wp VMA, matching the pte_none case
> +	 * there. Reporting it also lets the PM_SCAN_WP_MATCHING arming below
> +	 * install markers (uffd_wp_range() allocates the page table under
> +	 * WP_UNPOPULATED), so the next scan sees it clean until re-written.
> +	 *
> +	 * hugetlb is excluded: pagemap_hugetlb_category() reports an empty
> +	 * hugetlb entry (huge_pte_none) as not-written, unlike
> +	 * pagemap_page_category(), which reports pte_none as written. This
> +	 * path fires for a hugetlb slot only when it has no page table;
> +	 * keeping that not-written matches how an allocated-but-empty
> +	 * hugetlb entry reads, so the two agree within the VMA.

Can that all be shortened?

"In a uffd-wp VMA, any unpopulated range is treated as written, as uffd-wp
registration populates page tables and installs markers with WP_UNPOPULATED. See
pte_none() handling in pagemap_page_category().

hugetlb handling differs, see pagemap_hugetlb_category().
"

> +	 */
> +	categories = p->cur_vma_category;
> +	if (userfaultfd_wp(vma) && !is_vm_hugetlb_page(vma))
> +		categories |= PAGE_IS_WRITTEN;


[...]

> +/*
> + * A 2MB anon THP dropped with MADV_DONTNEED leaves a pmd_none hole with no
> + * page table, which pagemap_page_category() never sees. PAGEMAP_SCAN must
> + * still report it as written on a uffd-wp VMA, via pagemap_scan_pte_hole().
> + */
> +static void unpopulated_thp_hole_test(void)
> +{
> +	long npages, written = 0, ret, i;
> +	struct page_region regions[16];
> +	char *area, *mem;
> +
> +	if (!hpage_size) {
> +		ksft_test_result_skip("%s THP not supported\n", __func__);
> +		return;
> +	}
> +	npages = hpage_size / page_size;
> +
> +	/* Get a PMD-aligned range so the range can be a single THP. */
> +	area = mmap(NULL, 2 * hpage_size, PROT_READ | PROT_WRITE,
> +		    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	if (area == MAP_FAILED)
> +		ksft_exit_fail_msg("%s mmap failed\n", __func__);

Why exit the test? unpopulated_scan_test() seems to do that, but that is also
rather suboptimal. We can easily recover and continue executing tests.


> +	mem = (char *)(((unsigned long)area + hpage_size - 1) & ~(hpage_size - 1));
> +
> +	memset(mem, 1, hpage_size);
> +	if (madvise(mem, hpage_size, MADV_COLLAPSE) ||
> +	    !check_huge_anon(mem, 1, hpage_size)) {
> +		ksft_test_result_skip("%s could not form a THP\n", __func__);
> +		munmap(area, 2 * hpage_size);
> +		return;
> +	}
> +
> +	wp_init(mem, hpage_size);
> +
> +	/* Drop the whole PMD: it is cleared to a pmd_none hole. */
> +	if (madvise(mem, hpage_size, MADV_DONTNEED))
> +		ksft_exit_fail_msg("%s MADV_DONTNEED failed\n", __func__);
> +
> +	ret = pagemap_ioctl(mem, hpage_size, regions, 16, 0, 0,
> +			    PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
> +	if (ret < 0)
> +		ksft_exit_fail_msg("%s scan failed\n", __func__);
> +	for (i = 0; i < ret; i++)
> +		written += LEN(regions[i]);
> +
> +	ksft_test_result(written == npages,
> +			 "%s pmd-hole reported written (%ld of %ld)\n",
> +			 __func__, written, npages);
> +
> +	wp_free(mem, hpage_size);
> +	munmap(area, 2 * hpage_size);

There is quite some overlap with unpopulated_scan_test. Primarily the THP
allocation differs.

Couldn't we make the sequence similar by

(1) mmap
(2) wp_init(mem, mem_size); -> Populates page table
(3) memset(mem, 1, hpage_size); -> Allocates all entries
(4) MADV_COLLAPSE -> Get a THP
(5) MADV_DONTNEED -> Drop the THP

So couldn't we reuse most of unpopulated_scan_test in a reworked way?

> +}
> +
>  int sanity_tests(void)
>  {
>  	unsigned long long mem_size, vec_size;
> @@ -1610,7 +1664,7 @@ int main(int __attribute__((unused)) argc, char *argv[])
>  	if (!hugetlb_setup_default(4))
>  		ksft_print_msg("HugeTLB test will be skipped\n");
>  
> -	ksft_set_plan(118);
> +	ksft_set_plan(119);
>  
>  	page_size = getpagesize();
>  	hpage_size = read_pmd_pagesize();
> @@ -1790,6 +1844,7 @@ int main(int __attribute__((unused)) argc, char *argv[])
>  
>  	/* 18. Unpopulated pte scan-path consistency */
>  	unpopulated_scan_test();
> +	unpopulated_thp_hole_test();

Any reason this is not a unpopulated_thp_scan_test ?

-- 
Cheers,

David
