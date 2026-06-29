Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF673DD853
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 07:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782719314; cv=none; b=LruYojy97Y6I6rMD749PvvpcA1hFzzXd9w8ufb1H7TQvPOfI5E+EqQ8j0R2JQEsUikT47cU2bNA8U7LDWuzkyRrdUpxzbomtfX/k+OqeSoIU2RgrBg6ag7/37ANK4WJHESZtFXFllfEJqNWjYgGE2XKdgo4V4W1Ms8Hc080cIHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782719314; c=relaxed/simple;
	bh=I0LE9c3w+KcSiWBYmxliNvpIxE2KdyLvIg6huSHKM9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYPmBKs3XfwD2kiudrPekmBr5JJsomaHepA0qFF+KeWclWo55ei3m2jw0H1PxL5i//dHou7Z3PmQ2HYGX3j6gx/Har3FysBLP3fAo+DWli4rfBpM7dNi9cgcDrSI4aCKfi9nXp9f91i5qwFH/DQQQZ76e62xZD5JnUFze2BOg7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rql5VEcf; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rql5VEcf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782719304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xGFa9gooeOspYp4vl0A+wPqxGnfwbnKJ6LWOLsX6z/o=;
	b=Rql5VEcfNlXPZKFLS7y5qlk8EU6IZxaJbezHUrEyFyoHcx4/+RH5ALnqLEtQaRrosJUh6V
	BUq7TMwlCe6PqgxaxGQgzR9vWrUGXjjgzDOCu2JvphUiefbDAjbSVDH2YOibNL+UhyRAsZ
	46K/CszOdo5gTI0MkiYa172hVlOhyMI=
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org,
	dev.jain@arm.com
Cc: linmiaohe@huawei.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	akpm@linux-foundation.org,
	ljs@kernel.org,
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
	stable@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH 4/5] mm/page_vma_mapped: use huge_ptep_get() for hugetlb
Date: Mon, 29 Jun 2026 15:48:02 +0800
Message-Id: <20260629074802.42727-1-lance.yang@linux.dev>
In-Reply-To: <0fabee2a-edb7-41c8-91ec-8cf0646c9e83@kernel.org>
References: <0fabee2a-edb7-41c8-91ec-8cf0646c9e83@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Mon, Jun 29, 2026 at 09:25:48AM +0200, David Hildenbrand (Arm) wrote:
>On 6/29/26 08:48, Dev Jain wrote:
>> 
>> 
>> On 29/06/26 12:09 pm, David Hildenbrand (Arm) wrote:
>>> On 6/28/26 07:44, Lance Yang wrote:
>>>>
>>>> [...]
>>>>
>>>> Yes, that's what I had in mind :) thanks!
>>>>
>>>>
>>>> Maybe worth spelling out the rule as well: 
>>>>
>>>> For arch helpers that use addr, huge_ptep_get() assumes addr is the
>>>> address for the hugetlb entry ptep points to. arm64 already makes that
>>>> assumption.
>>>>
>>>> Callers where addr may not be hugepage-aligned should use
>>>> hugetlb_ptep_get() instead.
>>>
>>> Do we have any examples where code would do that? I would think that all code
>>> must properly align addr ahead of times.
>> 
>> Sashiko notes other places:
>> 
>> https://sashiko.dev/#/patchset/20260625112955.3254283-1-dev.jain%40arm.com
>
>Yeah, that looks shaky. We do seem to have a bunch of these cases, primarily
>from pagewalk code (where some users like pagemap need the actual address).

Indeed ...

>I think we have two options
>
>1) To prevent any (further) issues, make huge_ptep_get() always consume the
>hstate, and let the arch code deal with aligning it. Invasive.

Kinda lean toward option 1, even if it's more invasive. If we pass the
hstate down, each arch can figure out the right addr from there.

>2) Make the arch code handle aligning without the hstate.
>
>diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>index 30772a909aea3..303a1b74796c9 100644
>--- a/arch/arm64/mm/hugetlbpage.c
>+++ b/arch/arm64/mm/hugetlbpage.c
>@@ -126,6 +126,9 @@ pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>                return orig_pte;
> 
>        ncontig = find_num_contig(mm, addr, ptep, &pgsize);
>+       ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * ncontig);
>+       orig_pte = __ptep_get(ptep);
>+
>        for (i = 0; i < ncontig; i++, ptep++) {
>                pte_t pte = __ptep_get(ptep);
> 
>(nshift/order instead of ncontig might avoid a multiplication, but not sure if that matters in practice)
>
>IIUC, that's similar to what huge_ptep_get() does on ppc.
>
>
>static inline pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>{
>	if (ptep_is_8m_pmdp(mm, addr, ptep))
>		ptep = pte_offset_kernel((pmd_t *)ptep, ALIGN_DOWN(addr, SZ_8M));
>	return ptep_get(ptep);
>}
>
>I'd assume we could do the same on riscv. Besides that, I don't think any arch has cont
>entries.

AFAICT, for huge_ptep_get() the addr users are arm64 and powerpc, riscv
doesn't really care about addr there. Looks mostly arm64-specific ... 

>
>
>Interestingly, huge_pte_clear() / huge_ptep_get_and_clear() and friends would be all
>wrong when the wrong address is passed. But that code really is called from hugetlb.c
>where we should take better care of that. (e.g., partially zapping a hugetlb page is not
>possible)
>
>-- 
>Cheers,
>
>David
>
