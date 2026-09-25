Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A49E2F8E88;
	Fri, 25 Sep 2026 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344972; cv=none; b=uM3J3t1hMf8GrEFIm+pjKVBe+mZ0RLBWDqFPXY3ti8EAz3DTkIq5G46CCsEubnfM9OVCfMaEZsZeVfCN5SFATmgzIqd87H6mO/p5k6bQcCGyL2ufx6J9G+Fo9B+4IvmkfuZT0I7tds7y0f+unbIavMO/GrCKOYjXnm6GtN4CmKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344972; c=relaxed/simple;
	bh=vJmM53T1gvLVt2GOugt91tr2ZoRcYIz6a2/D9x2PQuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OX1aA/QxMGkdtNOh8ddLRafAPlPz8vXd0ROZoppHRCUDPwHGNxJT7M98C3NdMHPV0FVwKm9j5b6hMSpw3PHPWM51R+4PJ4Kw6rWK1i1H77CZoWKBgB5lA3iApEPPRVWlmRPVbq66bkrr9gy8k1/mGQY9dku7TMKvQDCz5jmIAeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVd9KAcu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVd9KAcu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A503F1F000FF;
	Fri, 25 Sep 2026 14:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790344970;
	bh=NNCsrq1Pv4PJ3tCFfQhR0ITmItYI/b9/JCcKk5G3gR4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jVd9KAcuMu0TNXZeoByHF3KAzOSxm8XMBVZ6mQ6QBVKKxJTc7/cm529qR6DbrR8Io
	 rAoWeoJCZM+eN7ARUYqNxWblUf31m2r8SH6cjJX46DD/Ph0kY85iYkqO+a6eDEYMZC
	 faitM5TpGFrED073qp0WLAr9ejfunVcNc6wbGLBDwxjfqJ6mj9NfeZqPmKsVicfzjB
	 2cSe6opxwp84fTugfEwBHskJZj9y016emGRNn7jtQLkyaSHF38KgsAmK7vfWQHA37k
	 y0fbpezVJaTCm7/xo1L1ImRh6Rh1nLMVf8GNdqXYNgD2hNuaoKD6HTGx2FeZlD8QO4
	 5QAZSjCeKoROQ==
Message-ID: <d7460bcd-b9c2-4a83-8248-d13a9ac1678b@kernel.org>
Date: Fri, 25 Sep 2026 13:28:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] proc/task_mmu: handle special PMDs in clear_refs and
 pagemap
To: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, akpm@linux-foundation.org, liam@infradead.org,
 ljs@kernel.org, vbabka@kernel.org, jannh@google.com, pfalcato@suse.de,
 peterx@redhat.com, jgg@ziepe.ca, sashiko-bot <sashiko-bot@kernel.org>,
 stable@vger.kernel.org
References: <20260912122822.3348978-1-gourry@gourry.net>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260912122822.3348978-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/26 14:28, Gregory Price wrote:
> mshv_vtl_low can install a special PMD from a PFN supplied in the mmap file
> offset.  That PFN need not have a memmap entry.  Reading /proc/PID/pagemap
> or writing /proc/PID/clear_refs for such a mapping oopses the kernel.
> 
> With a test driver mapping the PFN at the 1 TiB mark:
> 
>   echo 1 > /proc/self/clear_refs
> 
>   BUG: unable to handle page fault for address: fffffb5b80000008
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   RIP: 0010:clear_refs_pte_range+0xb1/0x1e0
>   Call Trace:
>    walk_pgd_range+0x50a/0xad0
>    __walk_page_range+0x6a/0x1d0
>    walk_page_range_mm_unsafe+0x193/0x230
>    clear_refs_write+0x18e/0x3f0
> 
>   pread(pagemap_fd, buf, 512 * 8, addr / PAGE_SIZE * 8)
> 
>   BUG: unable to handle page fault for address: fffff57840000008
>   RIP: 0010:pagemap_pmd_range+0x3cf/0x6b0
>   Call Trace:
>    walk_pgd_range+0x50a/0xad0
>    __walk_page_range+0x6a/0x1d0
>    walk_page_range_mm_unsafe+0x193/0x230
>    pagemap_read+0x1dc/0x350
> 
> clear_refs_pte_range() passes the PMD to pmd_folio(), while
> pagemap_pmd_range_thp() uses pmd_page() followed by page_folio().
> 
> Both paths assume the PFN has a struct page and dereference bad address.
> 
> Use vm_normal_folio_pmd() and vm_normal_page_pmd() so clear_refs skips
> folio operations and pagemap skips folio-derived flags for special PMDs.
> This matches the PTE paths, which already use vm_normal_folio() and
> vm_normal_page().
> 
> User-facing notes:
>  - Pagemap still reports PM_PRESENT and the PFN to a CAP_SYS_ADMIN reader.
> 
>  - For a special PMD backed by a valid memmap entry and for the huge
>    zero PMD, PM_FILE changes from set to clear.
> 
>  - PM_MMAP_EXCLUSIVE is already clear in both cases.
> 
>  - The output for an anonymous THP is unchanged.
> 
> Tested in QEMU with the test driver on broken and fixed kernels.  Both proc
> operations oops before the fix and return 0 after it.
> 
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260912034833.2952750-1-gourry%40gourry.net
> Fixes: 3c8e44c9b369 ("mm: mark special bits for huge pfn mappings when inject")
> Cc: <stable@vger.kernel.org> # v6.19+
> Assisted-by: LLM
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---

Simple fix, let's CC-stable indeed (unless I am too late and this is already
upstream :) )

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
