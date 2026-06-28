Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FA83101A7
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 05:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782625455; cv=none; b=Twto/Lx63he11SdMPnTYJ7IxsOw07cqmss50cVEGCLN+z0g2WbOHfZfas9uz4DCRa7oPR+N3O9luk+MosA3VwkUa7kV0rtlj6qhFrzVQrU9QaOyGv/Pj5vCYQ4fTvNszG9otusibzz8015SR7qfE2FBZ0zxeQoC5FFEJIjVCjyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782625455; c=relaxed/simple;
	bh=dNZCXESJIirjwyAMEv7eRRxz/LQxEHp62a7BqiVbM60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e4+dKpo3f45DY9dmVI+2ODO8gfDOkxUXMMhNCDOvsR+MNzT7qJkcVbA1YOnIXx+zclbsm3L8HmJ10s5tY+crv09naZfA+XALcCHdoANw6TdAYlFDS810K8R9YP0KSOiY6opDexZzZKfq7CMKht/yjttczeAcgYwW52XNVADfcTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UbSaXfGF; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UbSaXfGF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782625451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hh2gd/qWylLtYWmFXLrDcR+MvqoGGuVJgOfm4/cNwnU=;
	b=UbSaXfGFeBZY8DWvD4BZijtH1P+LU+jU7J+yZCcXnK6fzLcMgDZfFgvUOZ6QoZ+3q31NgQ
	RuPz+1jUO6Q6d6PczVunELVw6rDH7vqb9rxNAFzlsoaC8oCQBa633o30AfId7jm4PvZ3jj
	dW1Of102EdtUGtUOHDuvE8cA1aDtamw=
From: Lance Yang <lance.yang@linux.dev>
To: dev.jain@arm.com
Cc: lance.yang@linux.dev,
	linmiaohe@huawei.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	david@kernel.org,
	liam@infradead.org,
	riel@surriel.com,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	kas@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	rcampbell@nvidia.com,
	apopple@nvidia.com,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	mel@csn.ul.ie,
	nao.horiguchi@gmail.com,
	ak@linux.intel.com,
	j-nomura@ce.jp.nec.com,
	pfalcato@suse.de,
	dave.hansen@intel.com,
	tglx@kernel.org,
	jpoimboe@kernel.org,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/5] mm/page_vma_mapped: use huge_ptep_get() for hugetlb
Date: Sun, 28 Jun 2026 13:44:02 +0800
Message-Id: <20260628054402.76978-1-lance.yang@linux.dev>
In-Reply-To: <82395f5a-31d4-406b-b7ec-10d1a9d067d4@arm.com>
References: <82395f5a-31d4-406b-b7ec-10d1a9d067d4@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Sat, Jun 27, 2026 at 12:43:31PM +0530, Dev Jain wrote:
>
>
>On 26/06/26 10:16 pm, Lance Yang wrote:
[...]
>> 
>> Just thinking out loud: given that huge_ptep_get() already assumes that
>> addr matches the huge pte, at least on arm64, would it make sense to
>> have a small hugetlb wrapper around it that takes hstate and aligns
>> the address before calling the arch helper?
>> 
>> Might make the rule clearer, and a bit harder to get wrong again :)
>
>Are you suggesting something like:

Yes, that's what I had in mind :) thanks!

>diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>index fdb7bdf7645c..xxxxxxxxxxxx 100644
>--- a/include/linux/hugetlb.h
>+++ b/include/linux/hugetlb.h
>@@ -825,6 +825,15 @@ static inline struct folio *filemap_lock_hugetlb_folio(struct hstate *h,
>
> #include <asm/hugetlb.h>

Maybe worth spelling out the rule as well: 

For arch helpers that use addr, huge_ptep_get() assumes addr is the
address for the hugetlb entry ptep points to. arm64 already makes that
assumption.

Callers where addr may not be hugepage-aligned should use
hugetlb_ptep_get() instead.

>+static inline pte_t hugetlb_ptep_get(struct vm_area_struct *vma,
>+				     unsigned long addr, pte_t *ptep)
>+{
>+	struct hstate *h = hstate_vma(vma);
>+
>+	return huge_ptep_get(vma->vm_mm, addr & huge_page_mask(h), ptep);
>+}
>+
> #ifndef is_hugepage_only_range
> static inline int is_hugepage_only_range(struct mm_struct *mm,
> 					unsigned long addr, unsigned long len)
>diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>index 18e1d341f463..xxxxxxxxxxxx 100644
>--- a/mm/page_vma_mapped.c
>+++ b/mm/page_vma_mapped.c
>@@ -110,8 +110,7 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
> 	pte_t ptent;
>
> 	if (is_vm_hugetlb_page(pvmw->vma))
>-		ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
>-				      pvmw->pte);
>+		ptent = hugetlb_ptep_get(pvmw->vma, pvmw->address, pvmw->pte);
> 	else
> 		ptent = ptep_get(pvmw->pte);

[...]

Cheers, Lance
