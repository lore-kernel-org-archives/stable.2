Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.79
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979260;
	b=DHx7EtlnVuoB3Vv/IwaVODLQESadpdNd27Mp6V9H4Yi0XQcZDkq1WnF5B0cmWmbcYnti
	 pzzzA/fqFlbfz7ahoglxDijfh3QuAQQG61Dfxkei+FP9JlFWu0MQMNkj+8dq66IV6Zm92
	 zNMxy32bB5p9B75efMb6KWHMv/qAYapYwxNc59xTvSH/9NVqX8qH+M23qqayZ0KEl3aO/
	 WQN08R7gKWNottvEVh6NeYfzqRm1FY4lseJgScxX7wjLugreirzdqeiqtBh20/XpNMx+U
	 J0MhKF4c7/TzR2L23iFRfBdSUEUGSQi7VqhelVV38hEOh1AUut1tAU0PI+YwZNb938Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979260;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3UAbQu4Zz7jM5fvfnVPIQRW8LGHO6T/qo7Hc+AehbY4=;
	b=GFDjMB3bRK4d0GJHNcIRH4tJHiDf0D8S2Qj7xcuWiTVLwoEuI2Yi3FM+GdmobWH8mRgj
	 HP8PTOtT+PnZFMno6RAH9RGv6/X1mAHdwFWp0LosLmedjCdZuzq06n/GDBRyLHVpBjs3z
	 wuv9bSNfflhJVl99KDsQV23POIEb08Bt9Y0PaLaIB3PMi/srsakHc3wovob6uRxLPjVbO
	 6DffyBFZ6DMnObAge7EB13i2nqS9IcfhoZ8Ti05xRk5D6zfBaIVr/dwkHr6mqD71NpfNA
	 3nnFQn1RTmJKZ9tNfQUSTXRonPPGsPMjehw3eUwjV1hnF3JGng6wKANVGdFlMPeFTIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VhokyNrA;
	arc=none smtp.remote-ip=95.215.58.79
Received: from mta1.migadu.com (out-79.mta1.migadu.com [95.215.58.79])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0781606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 15:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0781606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VhokyNrA
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4IpYDm1JeTeVQryoSNRzjLLGuozzk6CpKr9+AhGJ6uY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793979257; v=1; x=1794584057;
 b=VhokyNrA9rO/IiddTY7Qj6x7ba7aZUn1FKhs7ajCtrOgaJAPnmZzejHHyYw4UfLOAiH5bxP+
 4EWVftLheEtm70YmUWkm1Px7Rdi/ZpK1E+FLUi4G28bspY0FLOVM838t2GYXE+DcjLjAXlIXX6y
 nSKJFHy9h74g1jcO9X8vu3GA=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 1c7542236927aa1f;
	Fri, 06 Nov 2026 15:34:17 +0000
X-Mizu-Trace-ID: 1c7542236927aa1f
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Usama Arif <usama.arif@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: free unused page table allocated by do_set_pmd()
Date: Fri,  6 Nov 2026 07:34:13 -0800
Message-ID: <20261106153414.2938216-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106-khugepaged_set_pmd-v2-1-d2457b5e377a@kernel.org>
References: 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 06 Nov 2026 13:36:12 +0100 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> do_set_pmd() can allocate vmf->prealloc_pte on architectures that need a
> deposited page table, such as PowerPC with the hash MMU. If the PMD is
> no longer empty when it takes the PMD lock, it returns VM_FAULT_FALLBACK
> without consuming that table.
> 
> Since collapse_pte_mapped_thp() uses mmap_read_lock(), a concurrent
> userfaultfd operation can install a PTE table before taking the folio
> lock. If that races with set_huge_pmd(), the unused preallocated table
> is lost when its local vm_fault goes out of scope.
> 
> Track whether do_set_pmd() allocated the table and free it after dropping
> the PMD lock if it was not consumed. Preserve any preallocated table
> supplied by the caller for PTE fallback. Successful PMD installation
> consumes the table and clears the pointer.
> 
> Returning without a preallocated table matches the existing behavior on
> architectures that do not need a deposited table. All callers
> already handle that case.
> 
> Fixes: 1043173eb5eb ("mm/khugepaged: collapse_pte_mapped_thp() with mmap_read_lock()")
> Cc: stable@vger.kernel.org
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/memory.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Usama Arif <usama.arif@linux.dev>

Reminded me of lazy pagetable deposit series :)

> 
> diff --git a/mm/memory.c b/mm/memory.c
> index becf53a2a0944..421064aef3cf0 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5687,6 +5687,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
>  	struct vm_area_struct *vma = vmf->vma;
>  	bool write = vmf->flags & FAULT_FLAG_WRITE;
>  	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
> +	bool pgtable_allocated = false;
>  	pmd_t entry;
>  	vm_fault_t ret = VM_FAULT_FALLBACK;
>  
> @@ -5725,6 +5726,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
>  		vmf->prealloc_pte = pte_alloc_one(vma->vm_mm);
>  		if (!vmf->prealloc_pte)
>  			return VM_FAULT_OOM;
> +		pgtable_allocated = true;
>  	}
>  
>  	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
> @@ -5755,6 +5757,10 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
>  	count_vm_event(THP_FILE_MAPPED);
>  out:
>  	spin_unlock(vmf->ptl);
> +	if (pgtable_allocated && vmf->prealloc_pte) {
> +		pte_free(vma->vm_mm, vmf->prealloc_pte);
> +		vmf->prealloc_pte = NULL;
> +	}
>  	return ret;
>  }
>  #else
> 
> -- 
> 2.43.0
> 
> 
