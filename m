Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710551;
	b=UMdUV77GqQHb3/qSxeQyIghZvKHm9nOle3WSGB6yY3jxgxD1Sl+2WkxJsNUJx7A1ibTH
	 uTKANCrhn4wBLFNeMYM+iFnDq7NsP6tyf8vG23XP5GxfOtuNcBtGYaAVL/4yU3ZWv71ru
	 R14fa9kP9aujFTsnVI/svuEW6ftv/3raqcEgdcKyiimrvJmuF6oGnUL9LG+s3yBC+Dxrj
	 mQ/nDXbVycKJcex85dgMg1tv03hacXdmgSve7Lrbhziid2QrXNfNFTMpfFD1VmK8olJMO
	 PlgCW+OAFLkjVUlTWscAPjawxAvyBgDUcgZJMbs7XfW6FJX1HWdwOvEjXRCs7Di2Iag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710551;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=WGmEidvvehaJScFEq1xdQHoioXcnhe32ej9jHAQch0c=;
	b=FYPk1tXDo4Ny6vQOB1YWN11pYTLnT9BfxidrZaVWQCG/zjOmturL0qYonsl5i+W9G8aZ
	 mzZRQixNI8XA6o3QbwKlxsVkG6jyoXEJEmYEToqwXI8Ep2tGofSl1CRVJrxW8xyqSloZ8
	 J4wv5H916RYCRElS7oaNWlaj+UElmQQf1PL33OG4wfhRx9NU+Y0+RhMGBhYfn/4QjFpkx
	 kP8dm+JfuflerJgUuuSHYC55dyfUqZ2wWqKy1bin4W/OlnB2z7NvAogEbJ5T6ZtTOUkH1
	 9ZLFV0k7HkIs1rfO7kg4WwodeucmsWm/PRlNKestl2g/R1mQlp9BAILFszAAtBIZX/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gSw4txl+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90097606A31C;
	Thu, 26 Nov 2026 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gSw4txl+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5161F000CF;
	Thu, 26 Nov 2026 16:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795710551;
	bh=WGmEidvvehaJScFEq1xdQHoioXcnhe32ej9jHAQch0c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gSw4txl+iuw4H5rZj8WPEf4SBYiu9DB3ztjOF5v+Vk42UKSVNFruGF/SeI8dzy1iO
	 ApOd4Wh/plF0BOKvI6wi7apjnYeItra1nCAy32L3hqiLslojZac0jaNGu3m/KMvQXg
	 3kHk7AvNTT9NQ2g8KPxM+jXJ/Vv63NC7myfnO4A03r15C5205bE8SSu1IYsUnT5JlL
	 K0mkPVjbvnqHlvGciqTjtmriHmLi8Gt31lx63Djwh1LCGFxrodm+nQUKS5D/yzoWHM
	 /sruyTWBwQUHbF0xYinYTYSntWJF4G+uzwHiNX5MQUC7c54/8bzi5C6LDUPn8YkXPF
	 TGRXS0MDxF16Q==
Message-ID: <9d506473-4844-4ed2-ac58-e72cd72b5c9e@kernel.org>
Date: Thu, 26 Nov 2026 17:29:00 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] mm/memory: don't allocate in finish_fault() with the
 folio locked
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Zach O'Keefe <zokeefe@google.com>, Lorenzo Stoakes <ljs@kernel.org>,
 Dev Jain <dev.jain@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Hugh Dickins <hughd@google.com>, Kiryl Shutsemau <kas@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Rik van Riel <riel@surriel.com>,
 Song Liu <songliubraving@fb.com>
Cc: "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Michal Hocko <mhocko@suse.com>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
References: <20261125100058.15200-1-azpijr@gmail.com>
 <20261125100058.15200-3-azpijr@gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261125100058.15200-3-azpijr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/26 10:59, Jose A. Perez de Azpillaga wrote:
> __do_fault() preallocates a page table only when the PMD is empty, so
> that finish_fault() does not have to allocate one with the folio locked.
> 
> Since retract_page_tables() no longer takes the mmap and VMA locks, the
> page table can be removed while the fault waits in ->fault().
> finish_fault() then finds an empty PMD without a preallocated table, and
> calls pte_alloc() with the folio locked. On ppc64 with the hash MMU,
> do_set_pmd() allocates the page table to deposit in the same case.
> 
> Allocating with __GFP_FS while holding a folio lock can deadlock in
> reclaim, for example the memcg reclaim deadlock on cgroup v1 described
> in commit 63f3655f9501 ("mm, memcg: fix reclaim deadlock with
> writeback").
> 
> Return VM_FAULT_NOPAGE instead, as we already do when
> pte_offset_map_lock() fails. The retried fault preallocates the page
> table before locking the folio.
> 
> Fixes: 1d65b771bc08 ("mm/khugepaged: retract_page_tables() without mmap or vma lock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> ---
>  mm/memory.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 11cc4039b853..b7e53d7cf6e5 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5986,16 +5986,21 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>  	}
>  
>  	if (pmd_none(*vmf->pmd)) {
> +		/*
> +		 * The page table was removed after __do_fault() found it, so
> +		 * nothing was preallocated. Allocating with the folio locked
> +		 * can deadlock in reclaim, so retry the fault instead.
> +		 */
> +		if (!vmf->prealloc_pte)
> +			return VM_FAULT_NOPAGE;

Hm, but do_set_pmd() really only needs one for ppc64. Assuming we allocate it as
NOFS in there for that corner cases ...

> +
>  		if (!needs_fallback && folio_test_pmd_mappable(folio)) {
>  			ret = do_set_pmd(vmf, folio, page, /* may_alloc= */ true);
>  			if (ret != VM_FAULT_FALLBACK)
>  				return ret;
>  		}
>  
> -		if (vmf->prealloc_pte)
> -			pmd_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte);
> -		else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd)))
> -			return VM_FAULT_OOM;
Could we instead fallback here, after we tried to install the PMD ?

-- 
Cheers,

David
