Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794234172;
	b=nhlo5IiGkjm6M51DtH5yDfNLW8SgQtyBbUVLJkxtWGU8ofHyoxjPNQcZgfECtsn+wg89
	 1zvA7L6xi0Kaq8LC9dh2sc17NkCEN70R6X/S9hxrnqa5ST2X2JNAJj2u1z0tpwpzcPRXa
	 ahYpr97wroFd4Zp6NSwdykTpnkqipIjO7riZF87pdwZhOoazeQRNpEO0JJxpD2vRg3E4J
	 0nfNbuR0WUlJiSUVjNUGAD/fg890jx3RPfFa51YNy9KaQNSZ39RHPq5hEgVPWGMkO+0Oj
	 vIaFBC+PGcn8ZbdctHWldrfMBdkPMyfPrsfPCn6E91xCOSfKT1K8yvjjaITcoSm53lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794234172;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=7isCUsuGWC/Pk0kPq18bunZ15LbusZD3620YiOmbCWs=;
	b=zfFNJlBl51NyMgsTh7zCfUmhOWwCFdoxeg/pq8+bQPwhLNBHPe5E4lWnL9/sjX/jvuZk
	 RMJDatRt05xskEGPMeLdmmH5SEAuax/7LwMaBTT2nF2aSG+NcyrJuNT/GRacZY6MSFWM0
	 6YLbTDbpLkq+Dt0v4e0Fc90QtwI3I8klevNpX38q5DbHNHvai1i4k61R/lvPvgL6BX4QD
	 ARX/8SlPycgIXesjln842N59TNO4j/67XuHoEIMyQRhjfumFTtSaR6Or+L6wNWCPV7dsP
	 sU5f/ZJ93iXIuw/4y5/aOUGV25LWQz2LDolKi+0psfIKQ8rpk2uyp5jEyxYUZkmny7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JKkUdmMG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66FE606A323;
	Mon,  9 Nov 2026 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JKkUdmMG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A840B1F0089F;
	Mon,  9 Nov 2026 14:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794234171;
	bh=7isCUsuGWC/Pk0kPq18bunZ15LbusZD3620YiOmbCWs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JKkUdmMG3WEmwG9PZDtBPn8mPQCAfcvbK9QCxG9DKs7GZAjaO5hftP7/XX0ZpjpN2
	 dC8zSyBeIAYic0NYI3EnSQOx/TBuHEiPKh1aWXjnrfofmUxuvsYRD6JIhEi9K1rmVK
	 3EVea9LwkQGb4qOQApraD63OJ60bw1OMn/vSwz/k2hj+FJmOO1jktxLEwK7uIFRhmd
	 SSRKF+Qec6l/Wl88ahehwFcbN+xbRLQSR2/F0f75ArHLipgdSQhlOLpKAJBGAm4bya
	 f8BjU4jWjQtFdy80oic/KcFkoQLjcMdBj2FQmVSVMsKMIPinX/8gWiPYEr9r23nkTi
	 fNmfqgFQInt6g==
Message-ID: <3a2d4135-f531-4797-8dd2-a2732a846e45@kernel.org>
Date: Mon, 9 Nov 2026 15:22:45 +0100
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
Subject: Re: [PATCH v3 1/6] mm: khugepaged: ignore MADV_HUGEPAGE for shadow
 stacks
To: Yeoreum Yun <yeoreum.yun@arm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Rik van Riel <riel@surriel.com>, Yuan-Hao Hsu <aa9736195201@gmail.com>,
 stable@vger.kernel.org
References: <20261109-refactor_gup_fast-v3-0-2aaef02df0e1@arm.com>
 <20261109-refactor_gup_fast-v3-1-2aaef02df0e1@arm.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261109-refactor_gup_fast-v3-1-2aaef02df0e1@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/9/26 13:32, Yeoreum Yun wrote:
> commit 3efb9800557b ("mm: do not map the shadow stack as THP") makes
> shadow stack mappings default to VM_NOHUGEPAGE. However, userspace can
> still clear this flag and set VM_HUGEPAGE through madvise().
> 
> Allowing large folios in x86 shadow stacks exposes a limitation in
> folio_pte_batch_flags(). For example:
> 
>   1. create a shadow stack mapping.
>   2. apply MADV_HUGEPAGE and populate the mapping with a PTE-mapped
>      large folio.
>   3. apply MADV_DONTFORK to the first base page of that folio.
>   4. call fork().
> 
> In the parent, the first page remains writable and anonymous-exclusive,
> while the remaining pages shared with the child become write-protected
> and lose PageAnonExclusive(). These pages can still belong to the same
> large folio.
> 
> On x86, writable shadow-stack PTEs have _PAGE_RW clear and _PAGE_DIRTY
> set. Write-protected PTEs have both bits clear, with the dirty state
> preserved in _PAGE_SAVED_DIRTY.
> 
> When FPB_RESPECT_WRITE is set without FPB_RESPECT_DIRTY,
> folio_pte_batch_flags() normalizes PTEs using pte_mkclean(), which clears
> both dirty bits. This loses the distinction between writable
> shadow-stack PTEs and write-protected PTEs, allowing them to be grouped
> into the same batch. GUP-fast can encounter such a batch when walking
> across the VMA boundary created by MADV_DONTFORK.
> 
> Since there is no practical use-case shadow stack with large folio,
> ignore MADV_HUGEPAGE for shadow stack mappings, preserving their
> VM_NOHUGEPAGE setting and preventing large-folio allocation.
> 
> Fixes: 3efb9800557b ("mm: do not map the shadow stack as THP")
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> Cc: <stable@vger.kernel.org>
> ---
>  mm/khugepaged.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 40fad28c52f6f..51ec043fa26c3 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -367,6 +367,9 @@ int hugepage_madvise(struct vm_area_struct *vma,
>  {
>  	switch (advice) {
>  	case MADV_HUGEPAGE:
> +		/* PTE batching doesn't work reliably. */
> +		if (vma_test_single_mask(vma, VMA_SHADOW_STACK))
> +			break;
>  		*vm_flags &= ~VM_NOHUGEPAGE;
>  		*vm_flags |= VM_HUGEPAGE;
>  		break;
> 

Ack, I prefer this solution for now until we know how to make pte_mkclean() on
x86 shadow stack PTEs not result in an implicit pte_wrprotect().

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
