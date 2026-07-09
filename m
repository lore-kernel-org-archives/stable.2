Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E507F28CF5D;
	Thu,  9 Jul 2026 03:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783566527; cv=none; b=F9lBRzNqNhgrEpzB0fis0BfJww4AuhTN2+fw+0yRsC+e4uY+QLGmFdHOCZ/fX2GVQcDmhuWy8Ni/qPTX8gsw9hBq9edeDPlgeGnXPMdwqJOIdZ8dCfsSIzT+Lj+Svw4snqkJBMNII1nT/dWrnnhC00lseEBkrdtSGPx6RDiAmac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783566527; c=relaxed/simple;
	bh=NLc4X44T9Vce74ZKNgbX4isMukjGLWN6HzsJ+ZFZyl8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AUHzXIagCotnik6To7+n8vtpXQnYUE71tsCmh7j5sbv+0JCMWBRxN9rI2JyNzjv9yPi+iM/GVdaX0N0ASBhSB6XdkWCidwbBibyNfBQasrCEaaG7Qc0NVA/dOn1T4fE69rsTfgenwSQ1ibfp6AHEG7CRC/rx7i9HFrSWQGxdjDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=vnxP+MdO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vnxP+MdO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1ADE1F000E9;
	Thu,  9 Jul 2026 03:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783566525;
	bh=0C50gLb1Rx6vC8vebMbmFW9FfipWim9v9MXHOz8ZbLA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=vnxP+MdOVlsjmHdBRs/H3ZPG+GDpJbCcjRF7ezT70sAgYv93ijEZxuZWrm8S0+ANX
	 FbaMuA0+VH2nxPVMoyyzfLg/UhgWU/OdctHjIpZ8t33pWjwEQCCd/zM6pj/e7oilT3
	 ZKTtxEKk3Nem7wh4ixtq6Uc8ZA7wIn8oc7jimZo8=
Date: Wed, 8 Jul 2026 20:08:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: usama.anjum@collabora.com, peterx@redhat.com, liam@infradead.org,
 ljs@kernel.org, vbabka@kernel.org, jannh@google.com, pfalcato@suse.de,
 david@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 shuah@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2] fs/proc/task_mmu: fix PAGEMAP_SCAN written state for
 PMD holes
Message-Id: <20260708200844.09b42937d19bf733849d2886@linux-foundation.org>
In-Reply-To: <20260708103429.150655-1-kirill@shutemov.name>
References: <20260708103429.150655-1-kirill@shutemov.name>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 Jul 2026 11:34:29 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:

> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> 
> PAGEMAP_SCAN reports an unpopulated PTE in a uffd-wp VMA as written
> (pagemap_page_category() and the PAGE_IS_WRITTEN fast path), but a range
> with no page table at all -- a PMD hole -- is skipped.
> pagemap_scan_pte_hole() evaluates the hole against p->cur_vma_category,
> which pagemap_scan_test_walk() builds from only PAGE_IS_WPALLOWED and
> PAGE_IS_SOFT_DIRTY, so PAGE_IS_WRITTEN is never set: the hole is neither
> reported nor, under PM_SCAN_WP_MATCHING, armed.
> 
> This is reachable. An anonymous THP is write-protected in place as a huge
> PMD (change_huge_pmd(), anon is not split), and a full-PMD MADV_DONTNEED
> clears it to pmd_none. A WP-async consumer such as CRIU then misses the
> 2MB drop -- the range is not reported written and the next incremental
> dump keeps stale data. (A file/shmem THP is split on write-protect, so a
> later DONTNEED leaves a populated page table of pte_none entries, which
> are already reported; only anon THP reaches the hole path.)
> 
> Add PAGE_IS_WRITTEN to the categories evaluated for a hole in a
> non-hugetlb uffd-wp VMA, matching the pte_none handling in
> pagemap_page_category(). The existing PM_SCAN_WP_MATCHING path then also
> arms the range: uffd_wp_range() allocates the page table and installs
> markers under WP_UNPOPULATED, so the next scan sees it clean until
> re-written.
> 
> hugetlb is excluded on purpose: an allocated-but-empty huge entry reads
> as not-written via pagemap_hugetlb_category(), so reporting an
> unallocated hugetlb hole (which also reaches this path) as written would
> be inconsistent within the same VMA. hugetlb hole handling is left as-is.
> 
> Add a pagemap_ioctl selftest that forms an anon THP, drops it with
> MADV_DONTNEED and checks the resulting PMD hole is reported written.

hoo boy, that was heavy going.

> Assisted-by: Claude:claude-fable-5

OK ;)

But what do our users see?  afaict the result of the bug is "the next
incremental CRIU dump keeps stale data".  Why is this a problem?  How
would operators look at a user bug report and figure out that this
patch will address it?  Is there some Reported-by/Closes?

In other words, (please train Claude to) always describe the userspace
visible effects of a bug when fixing it.

>
> --- a/tools/testing/selftests/mm/pagemap_ioctl.c
> +++ b/tools/testing/selftests/mm/pagemap_ioctl.c
> @@ -25,6 +25,10 @@
>  #include "kselftest.h"
>  #include "hugepage_settings.h"
>  
> +#ifndef MADV_COLLAPSE
> +#define MADV_COLLAPSE 25
> +#endif

Why would this be undefined?  It's right there in mman-common.h?

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
> +	mem = (char *)(((unsigned long)area + hpage_size - 1) & ~(hpage_size - 1));

Do selftests not have ALIGN and friends?  Seems not, given how many of
them have own implementations.

> +
> +	memset(mem, 1, hpage_size);
> +	if (madvise(mem, hpage_size, MADV_COLLAPSE) ||
> +	    !check_huge_anon(mem, 1, hpage_size)) {
> +		ksft_test_result_skip("%s could not form a THP\n", __func__);
> +		munmap(area, 2 * hpage_size);
> +		return;
> +	}
>
> ...
>
