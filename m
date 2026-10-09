Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D403B331A61;
	Fri,  9 Oct 2026 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791568859; cv=none; b=CmwHv/Bh//nzWwTFjsW38SW9UuvQ2jTQA4YpQqmzUUbCEl40o1Jx/q24exCWQY8jGvgClmPvMpuFC1zvjtitZrCYNtz0hWYhSwNfyUNVqecc12de2hkK5SmZjbo6jndT4hPUSVvla9/bjS6J1HeAXmJpRjj3vfV+u7tKMvgTA7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791568859; c=relaxed/simple;
	bh=a19n9BGRcuFVkg5Gk4SBfmtopyOgzvmAYzjjWMeCkEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=reynOA1F0dkrZILmcQP/JfmJL5vEh5AyTMxEo9Sbo25vMhq0dltVrhJW7zLlz49Fl0alCo6eaB1en09wtykIdjRU3mgDtVV6ee0lSfRl3K0CZ8REf6eNZQqzEJKxn/H/JTmx8awp0rQtGPzXp3ysNtkJqm4WPMh0VDlTAbcyzkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpnCNeDk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpnCNeDk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79C41F00893;
	Fri,  9 Oct 2026 18:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791568858;
	bh=UAqgduf0BQOvueONoyBqpc3wCA4v82uCh+xQrLLFBpI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TpnCNeDkFmKf8caNwk0vroIg025H+aS+gYvM6CtupjAtLu+gXm/BExjdya8nvjpWB
	 t+ckV8jBREMsltwvhamM2VNB7rNhmEodT7Be0ZnXinw6l8X+JH67BSNgGcub1ombmp
	 hbW8neetl2m2yRHXCi0UYPIgnzZrPGpoe6/dKcQ5mbRxaJM3PhMEi9/PxFHwJMdabN
	 yVSH39t/34uF1d1e2fhRIiZqz3hfHe8nPVbCCa6eo/Ua1aHszkZGqI10ZzHw9KKAD/
	 h9FyFTGX4r4NpQ07MmS2w1RJVj4hw8e+PSnpFz8D5L1qB/XaOvfoxipGgMNwxaayDq
	 37G8bUkgklBRA==
Message-ID: <54b5a63d-34fc-4bd8-beaf-19673c8b6ad7@kernel.org>
Date: Fri, 9 Oct 2026 20:00:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: avoid transient none PMDs during lazyfree
 reclaim
To: Kyle Zeng <kylebot@openai.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, stable@vger.kernel.org
References: <20261009165214.40212-2-kylebot@openai.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261009165214.40212-2-kylebot@openai.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/26 18:52, Kyle Zeng wrote:
> __discard_anon_folio_pmd_locked() clears and flushes a huge PMD before
> checking whether the folio can be discarded. If the folio was redirtied
> or has unexpected references, it restores the original PMD. Reclaim holds
> the PMD lock and the anon_vma read lock, but not the owning mmap_lock.
> 
> Both zap_pmd_range() and mremap's get_old_pmd() can skip a none PMD
> without taking its lock. A concurrent munmap() or whole-VMA
> MREMAP_DONTUNMAP can therefore miss the PMD and later unlink the source
> VMA from its anon_vma, leaving a restored mapping behind. The anon_vma
> write lock taken by unlink_anon_vmas() waits for reclaim to finish, but
> does not repeat the skipped page-table walk. Once the remaining VMA
> links are removed, the folio's positive mapcount no longer guarantees a
> live anon_vma. Racing lazyfree reclaim against MREMAP_DONTUNMAP as an
> unprivileged user reproduces a KASAN use-after-free in
> folio_lock_anon_vma_read().
> 
> Use pmdp_invalidate() to keep a recognizable, non-none huge PMD while
> the discard can still fail. Concurrent unmap and move operations then
> have to synchronize on the PMD lock instead of skipping the mapping.
> Clear the invalidated PMD only after the dirty and reference checks have
> succeeded, before removing the rmap and withdrawing the deposited page
> table. The full invalidation retains the TLB flush required for the
> dirty and GUP-fast checks.
> 
> Fixes: 735ecdfaf4e8 ("mm/vmscan: avoid split lazyfree THP during shrink_folio_list()")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-6-astra
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---
>  mm/huge_memory.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 1e5d68acf62a..20262195385a 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3569,11 +3569,17 @@ static bool __discard_anon_folio_pmd_locked(struct vm_area_struct *vma,
>  		return false;
>  	}
>  
> -	orig_pmd = pmdp_huge_clear_flush(vma, addr, pmdp);
> +	/*
> +	 * The discard may fail, so keep the PMD non-none until we're
> +	 * committed to discarding it. Otherwise, concurrent munmap() or
> +	 * mremap() can skip the PMD without taking the PTL and later unlink
> +	 * the VMA from its anon_vma despite a restored mapping.
> +	 */

You can drop the entire comment. This is what we should do in most cases where
the mapping might be restored/changed, for example, in set_pmd_migration_entry().

> +	orig_pmd = pmdp_invalidate(vma, addr, pmdp);
>  
>  	/*
>  	 * Syncing against concurrent GUP-fast:
> -	 * - clear PMD; barrier; read refcount
> +	 * - invalidate PMD; barrier; read refcount
>  	 * - inc refcount; barrier; read PMD
>  	 */
>  	smp_mb();
> @@ -3607,6 +3613,7 @@ static bool __discard_anon_folio_pmd_locked(struct vm_area_struct *vma,
>  		return false;
>  	}
>  
> +	pmdp_huge_get_and_clear(mm, addr, pmdp);
>  	folio_remove_rmap_pmd(folio, pmd_page(orig_pmd), vma);
>  	zap_deposited_table(mm, pmdp);
>  	add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);


Thanks!

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
