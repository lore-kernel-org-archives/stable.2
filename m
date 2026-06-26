Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522672253B0
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 02:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782441111; cv=none; b=ltfUp3FKTG+n8U9fx7f/TFAFdpDyLYPcFUHlPRel4I3k02CLby0UJPLQ3kVJdeRn9MGGZh+LnTPpgSl5FkmWoBi+CkG9kfB055rYG0ukg6NGqeCIsmS+kqzqhT5a+MX1T6wcDQvJJKQ/j4redCJ3gK7yvICPP6BLvO928+q6G74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782441111; c=relaxed/simple;
	bh=B7pgTL/yD2cCIR7mQV4FOi7pP15bYtdb6RQtLUpsJ70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGZyUOpt7Ka5oGKqPftyMlWSAl3NbEiTZjY95lJ8MTagsdELN1Wl3CngPuIOQ8Mga2djC80JXNdNjn0TiYUgWc1fvPn3BQwLnPHNv3PubhOMgJkCRmCoRsXdqgNcQwURf2N/MH+nM9LnrNj4BdWk12UyrAIUkdiLw/dksnDGmKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wJmFW8Rq; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wJmFW8Rq"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782441106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d48K2vjsdWWrmdOhQW/44VDv65Oy54deGsCoIpejECI=;
	b=wJmFW8Rq8MtufcNDuLj9hiQBZr7FtMot8wz8j/UjOKKVXgJAFQA1+bNovARL0N/3j3ijtV
	issgHAKWSs/2O78CmFu/tLsAcyzZ5o2xW3OCNaoLPlvlAM1iFNuMI5pxxYRMzfn6RF7LJz
	XPdMrkzUPfgKlMJ+N+bq0LECZC2WUbU=
From: Lance Yang <lance.yang@linux.dev>
To: dev.jain@arm.com
Cc: muchun.song@linux.dev,
	osalvador@suse.de,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	david@kernel.org,
	liam@infradead.org,
	riel@surriel.com,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	lance.yang@linux.dev,
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
Date: Fri, 26 Jun 2026 10:31:27 +0800
Message-Id: <20260626023127.60788-1-lance.yang@linux.dev>
In-Reply-To: <20260625112955.3254283-5-dev.jain@arm.com>
References: <20260625112955.3254283-5-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Thu, Jun 25, 2026 at 11:29:53AM +0000, Dev Jain wrote:
>check_pte() is the final validation step in page_vma_mapped_walk().
>It reads pvmw->pte with ptep_get() to decide whether the entry maps
>the PFN range being walked. For hugetlb VMAs, that pointer refers
>to a hugetlb entry.
>
>On arches which provide their own huge_ptep_get() to dereference a huge
>pte pointer, accessing via ptep_get() would cause pte_pfn(),
>pte_present() etc to misbehave.
>
>It is not clear whether this has a trivially visible effect to userspace.
>
>Use huge_ptep_get() to dereference a huge pte pointer.
>
>Fixes: ace71a19cec5 ("mm: introduce page_vma_mapped_walk()")
>Cc: stable@vger.kernel.org
>Signed-off-by: Dev Jain <dev.jain@arm.com>
>---
> mm/page_vma_mapped.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
>
>diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>index 2ccbabfb2cc17..18e1d341f463c 100644
>--- a/mm/page_vma_mapped.c
>+++ b/mm/page_vma_mapped.c
>@@ -107,7 +107,13 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
> static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)

Just one ordering thing: should this patch come first?

Patches #01-#03 only reach the new huge_ptep_get() after
page_vma_mapped_walk() succeeds. But before this patch, hugetlb sill
goes through check_pte() (still using ptep_get()).

> {
> 	unsigned long pfn;
>-	pte_t ptent = ptep_get(pvmw->pte);
>+	pte_t ptent;
>+
>+	if (is_vm_hugetlb_page(pvmw->vma))
>+		ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
>+				      pvmw->pte);
>+	else
>+		ptent = ptep_get(pvmw->pte);
> 
> 	if (pvmw->flags & PVMW_MIGRATION) {
> 		const softleaf_t entry = softleaf_from_pte(ptent);
>-- 
>2.43.0
>
>
