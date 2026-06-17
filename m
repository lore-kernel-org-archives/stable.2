Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58003016FC
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 03:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781666111; cv=none; b=MAZr390liAx33f9w++/ItN7aDj9pQsJm7Z2JePHPS3GOg+NtazX0FjZWfg2v7AftUPE93xpEF0JnWBMhS6BB4bVt7biIR2tfN76lUZaxTBw40uV0A8Yaq67DRXCI/MiS/PwcAvlEsppDHwyIQpFEtaISxrBINOOyHIOC5T0V61g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781666111; c=relaxed/simple;
	bh=Qk/DM4744K7XBYGNbGM3g85QtFLrnbrVNMpF5F9IuE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMpbTxc5TMCR3xXwIIed4IldBASCWVyhWgd3dezf2JOvOOnlwloeejvlahYw6x1Na5l84+JT2+hNMLlryqNlMAZAAUFpqy8treMMPXJxE8BbeQrQC2wEzFRP/ainnrvzqxo6jLpMxVoeOUewGoF/gWwGMl46Y3O7CZDX5OO2Ark=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RyvrvsqH; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RyvrvsqH"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781666108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FYheglZoN7ZQINy1Nkai5yf7WMqEaDWpcm1200AttNM=;
	b=RyvrvsqHUQr2/2WVE1SSai7a83FHouvM1ASy/wdoWScK1x0Ub9zIsGQpopfn4pf36Mxb25
	DnpJnpNqv65Zb0KEYBbk16vQR2SLelhUs2cgnPVUw9x+PvqztbxbbfbOsDMaomrwInQBIw
	TbjerRr9NnM+ci/z211zqm2KqH7jzZY=
From: Lance Yang <lance.yang@linux.dev>
To: balbirs@nvidia.com
Cc: david@kernel.org,
	lance.yang@linux.dev,
	richard.weiyang@gmail.com,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	riel@surriel.com,
	liam@infradead.org,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	ziy@nvidia.com,
	sj@kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	stable@vger.kernel.org
Subject: Re: [Patch v2] mm/page_vma_mapped: revalidate and do proper check before return device-private pmd
Date: Wed, 17 Jun 2026 11:14:54 +0800
Message-Id: <20260617031454.29210-1-lance.yang@linux.dev>
In-Reply-To: <ajIBTyWCLDo9RAHR@parvat>
References: <ajIBTyWCLDo9RAHR@parvat>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Wed, Jun 17, 2026 at 12:11:14PM +1000, Balbir Singh wrote:
>On Tue, Jun 16, 2026 at 03:07:53PM +0200, David Hildenbrand (Arm) wrote:
>> On 6/16/26 14:30, Lance Yang wrote:
>> > 
>> > On Tue, Jun 16, 2026 at 06:34:36AM +0000, Wei Yang wrote:
>> > [...]
>> >> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>> >> index 2ccbabfb2cc1..21635fab209c 100644
>> >> --- a/mm/page_vma_mapped.c
>> >> +++ b/mm/page_vma_mapped.c
>> >> @@ -243,40 +243,28 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>> >> 		 */
>> >> 		pmde = pmdp_get_lockless(pvmw->pmd);
>> >>
>> >> -		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
>> >> -			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>> >> -			pmde = *pvmw->pmd;
>> >> -			if (!pmd_present(pmde)) {
>> >> -				softleaf_t entry;
>> >> -
>> >> -				if (!thp_migration_supported() ||
>> >> -				    !(pvmw->flags & PVMW_MIGRATION))
>> >> -					return not_found(pvmw);
>> >> -				entry = softleaf_from_pmd(pmde);
>> >> -
>> >> -				if (!softleaf_is_migration(entry) ||
>> >> -				    !check_pmd(softleaf_to_pfn(entry), pvmw))
>> >> -					return not_found(pvmw);
>> >> -				return true;
>> >> -			}
>> >> -			if (likely(pmd_trans_huge(pmde))) {
>> >> -				if (pvmw->flags & PVMW_MIGRATION)
>> >> -					return not_found(pvmw);
>> >> -				if (!check_pmd(pmd_pfn(pmde), pvmw))
>> >> -					return not_found(pvmw);
>> >> -				return true;
>> >> -			}
>> >> -			/* THP pmd was split under us: handle on pte level */
>> >> -			spin_unlock(pvmw->ptl);
>> >> -			pvmw->ptl = NULL;
>> >> -		} else if (!pmd_present(pmde)) {
>> >> -			const softleaf_t entry = softleaf_from_pmd(pmde);
>> >> -
>> >> -			if (softleaf_is_device_private(entry)) {
>> >> -				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>> >> -				return true;
>> >> -			}
>> >> +		if (pmd_present(pmde)) {
>> >> +			if (!pmd_leaf(pmde))
>> >> +				goto pte_table;
>> >> +			if (pvmw->flags & PVMW_MIGRATION)
>> >> +				return not_found(pvmw);
>> >> +			if (!check_pmd(pmd_pfn(pmde), pvmw))
>> >> +				return not_found(pvmw);
>> >> +		} else if (pmd_is_migration_entry(pmde)) {
>> >> +			softleaf_t entry = softleaf_from_pmd(pmde);
>> >> +
>> >> +			if (!(pvmw->flags & PVMW_MIGRATION))
>> >> +				return not_found(pvmw);
>> > 
>> > Looked at history a bit, and I wonder if this changed something old
>> > here ...
>> > 
>> > Since 616b8371539a ("mm: thp: enable thp migration in generic path"), PMD
>> > migration handling took PTL before doing PVMW_MIGRATION/PFN checks,
>> > including not_found() cases. So lockless PMD read was just a filter ...
>> > 
>> > With this fix, true case gets final pmd_same() check, but this
>> > not_found() case happens before taking PTL.
>> > 
>> > So a !PVMW_MIGRATION walker could race with someone, e.g.
>> > remove_migration_pmd(): we make the not_found() decision from old PMD
>> > value that still says "migration", while real *pvmw->pmd may already be
>> > present again. We return without ever taking PTL :)
>> > 
>> > Not sure about practical fallout, but should these PMD-level not_found()
>> > cases also take PTL and restart if PMD changed?
>> I was hoping that we could so something similar to the PTE case.
>> 
>> In map_pte(), we check whether the PMD changed, which is slightly different.
>> 
>> The actual check happens in check_pte() after grabbing the PTL.
>> 
>> For the case you describe, map_pte() would find !pte_none(ptent) ...
>> !pte_present(ptent) and !is_migration, and effectively grab the lock and proceed
>> to check_pte().
>> 
>> In check_pte() we re-check under lock indeed.
>>
>
>Thinking of the practical fallout, not finding the PMD for a non
>migration worker should be OK. Is there a case where it's not OK to
>report the old state.

I was thinking the lockless value should only be used as a first filter,
to see whether entry looks worth checking.

PTE side is roughly lockless filter + PTL/check_pte().

PMD true case now gets PTL/pmd_same(), but some PMD not_found() cases
still come straight from lockless "pmde".

That mismatch felt odd to me ...

Cheers, Lance
