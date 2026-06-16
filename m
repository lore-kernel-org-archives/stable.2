Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9E0345757
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781615281; cv=none; b=B5auj6gt7PLx2+fuJQ5JlC5CJnWyWn5JAzn2n42BsQfd8X8qy7qOkosdxQzXOinNrEjFbIUeEvNodPtxmTVozqZ85jhjFyC3GE11nCy3+DFpbVDQCwXY3nOdVdQJv+f9bjYgoVMkJpeXKiMd84V2WcGYU1kdfyZIlVCAgJ9SELQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781615281; c=relaxed/simple;
	bh=HyLcNQbLsvNaHo5acFTUnjHxOApVJMkSPcGZ+qdf5l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sJk71gY9tOuuftVY2p0q49W9P8/VXJc+0GxaHV8F+poE2U3NLDPK9BS9eZxDlUpL+Y5HojPndGT1mB8uap3SB2/FChyL5AAzVFDG0qJyT7HdiMgvsgibwh+EY5GAUBDVRaZzKBZJ0lxhcq367tOhGmBgssRVLfi38RvCCYRVKD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3LCMVeS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3LCMVeS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760F01F000E9;
	Tue, 16 Jun 2026 13:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781615280;
	bh=44kGT5EsEATek0OwEmllUBkTdBMczZ5UTHP3Uzrhvfs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=U3LCMVeSvU194moAVojm2I397RFBkHK4PBp7fG54xBjccsk8nseP+p4yl5UDHqI/t
	 qPjC/aNYF4BWcGm0/CNok0D9CbkBxX7LOE6iwe31Yl2WvaMGTOdFRlNR84ZUSUDaAl
	 xCGLxlZmqFDqs6AdLcCpsOWq/m96hzIx4JaigC1MTvODdI9kuY2uXYsiCIXGXDlMbi
	 ciq4Mudskv5z2T1CJzENOZqSZ48oJyKAyMBv+7sGHXxCP/TQdHPhdBzJXAUiKfjhp6
	 6lKaZldqjoKZRFlpJ85tY76FDuCssJ/4otz5eHXh2zgeRb1l2gsDoCLPg2XC2DJGoj
	 HBpQWs3HtuNMQ==
Message-ID: <666dc40b-e37a-46eb-af55-7a81bc1643f1@kernel.org>
Date: Tue, 16 Jun 2026 15:07:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] mm/page_vma_mapped: revalidate and do proper check
 before return device-private pmd
To: Lance Yang <lance.yang@linux.dev>, richard.weiyang@gmail.com
Cc: akpm@linux-foundation.org, ljs@kernel.org, riel@surriel.com,
 liam@infradead.org, vbabka@kernel.org, harry@kernel.org, jannh@google.com,
 balbirs@nvidia.com, ziy@nvidia.com, sj@kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, stable@vger.kernel.org
References: <20260616063436.20455-1-richard.weiyang@gmail.com>
 <20260616123001.6501-1-lance.yang@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260616123001.6501-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/26 14:30, Lance Yang wrote:
> 
> On Tue, Jun 16, 2026 at 06:34:36AM +0000, Wei Yang wrote:
> [...]
>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>> index 2ccbabfb2cc1..21635fab209c 100644
>> --- a/mm/page_vma_mapped.c
>> +++ b/mm/page_vma_mapped.c
>> @@ -243,40 +243,28 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>> 		 */
>> 		pmde = pmdp_get_lockless(pvmw->pmd);
>>
>> -		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
>> -			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>> -			pmde = *pvmw->pmd;
>> -			if (!pmd_present(pmde)) {
>> -				softleaf_t entry;
>> -
>> -				if (!thp_migration_supported() ||
>> -				    !(pvmw->flags & PVMW_MIGRATION))
>> -					return not_found(pvmw);
>> -				entry = softleaf_from_pmd(pmde);
>> -
>> -				if (!softleaf_is_migration(entry) ||
>> -				    !check_pmd(softleaf_to_pfn(entry), pvmw))
>> -					return not_found(pvmw);
>> -				return true;
>> -			}
>> -			if (likely(pmd_trans_huge(pmde))) {
>> -				if (pvmw->flags & PVMW_MIGRATION)
>> -					return not_found(pvmw);
>> -				if (!check_pmd(pmd_pfn(pmde), pvmw))
>> -					return not_found(pvmw);
>> -				return true;
>> -			}
>> -			/* THP pmd was split under us: handle on pte level */
>> -			spin_unlock(pvmw->ptl);
>> -			pvmw->ptl = NULL;
>> -		} else if (!pmd_present(pmde)) {
>> -			const softleaf_t entry = softleaf_from_pmd(pmde);
>> -
>> -			if (softleaf_is_device_private(entry)) {
>> -				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>> -				return true;
>> -			}
>> +		if (pmd_present(pmde)) {
>> +			if (!pmd_leaf(pmde))
>> +				goto pte_table;
>> +			if (pvmw->flags & PVMW_MIGRATION)
>> +				return not_found(pvmw);
>> +			if (!check_pmd(pmd_pfn(pmde), pvmw))
>> +				return not_found(pvmw);
>> +		} else if (pmd_is_migration_entry(pmde)) {
>> +			softleaf_t entry = softleaf_from_pmd(pmde);
>> +
>> +			if (!(pvmw->flags & PVMW_MIGRATION))
>> +				return not_found(pvmw);
> 
> Looked at history a bit, and I wonder if this changed something old
> here ...
> 
> Since 616b8371539a ("mm: thp: enable thp migration in generic path"), PMD
> migration handling took PTL before doing PVMW_MIGRATION/PFN checks,
> including not_found() cases. So lockless PMD read was just a filter ...
> 
> With this fix, true case gets final pmd_same() check, but this
> not_found() case happens before taking PTL.
> 
> So a !PVMW_MIGRATION walker could race with someone, e.g.
> remove_migration_pmd(): we make the not_found() decision from old PMD
> value that still says "migration", while real *pvmw->pmd may already be
> present again. We return without ever taking PTL :)
> 
> Not sure about practical fallout, but should these PMD-level not_found()
> cases also take PTL and restart if PMD changed?
I was hoping that we could so something similar to the PTE case.

In map_pte(), we check whether the PMD changed, which is slightly different.

The actual check happens in check_pte() after grabbing the PTL.

For the case you describe, map_pte() would find !pte_none(ptent) ...
!pte_present(ptent) and !is_migration, and effectively grab the lock and proceed
to check_pte().

In check_pte() we re-check under lock indeed.

-- 
Cheers,

David
