Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD8B78F2B;
	Fri, 26 Jun 2026 04:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782447463; cv=none; b=synGBhE6R7CPXhgGb6QdYURxdOUMiGO4/F/EaHDaGVsgqDAUUhva3oUPL+TLbUhofmfrdGWymhQVwgJtO3yehC4utfuWvofWNAxowhE4OkWKkol/72r8QWz5v1XIUiCKXmqnNVUOKsGTpA7KosUE16eb6tAftLfRNr+cCg4LodM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782447463; c=relaxed/simple;
	bh=QAzu5UjlSbz6C9zs1JEWdI4j4aEcleaku/Mfot+onhg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XTwrMSNQV+EP0O8U/kDnB5Dj0HU8lQEkEEopUTPELaU+/O3R0HyEQin4Z/bFp3KCFueitBDWLiHVr1e0l7INGXZaY7bGtk+2dGrFtJ5XXLG5BrWzmGPcuvoJMn+hsnXnXSlx/gAv5V0Atavun0jKIEU5IgqvoulWfv9snLwYCyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tU4auLan; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tU4auLan"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782447417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XOkT4HE4MTvk1wZ4w40cb5pP0zMW5GgLzCncJ/GrFKA=;
	b=tU4auLanIoznu++bAndccmy95kBQZM3vq3F5BJdIdB3bzdmwcKIzlcD38N7fNciBZ/LSMH
	FmoUliuhEWquBQUxpNJpE5YaDbsYyNkQL31Ss1/hRuoD6Ntulu0n0evwIVXfNH2VKUj639
	Q9BDEF4Ep3G7a4GsovfzVtNZszPAUak=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH 1/5] mm/rmap: use huge_ptep_get() in try_to_unmap_one()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <4619650f-28b5-4fb4-91be-50daa0b4d84b@arm.com>
Date: Fri, 26 Jun 2026 12:16:16 +0800
Cc: riel@surriel.com,
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
 stable@vger.kernel.org,
 osalvador@suse.de,
 akpm@linux-foundation.org,
 ljs@kernel.org,
 david@kernel.org,
 liam@infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EF014590-F5F0-4B9A-9C6A-C4EAC8187237@linux.dev>
References: <20260625112955.3254283-1-dev.jain@arm.com>
 <20260625112955.3254283-2-dev.jain@arm.com>
 <f8516534-3b18-4988-b384-251225755285@linux.dev>
 <4619650f-28b5-4fb4-91be-50daa0b4d84b@arm.com>
To: Dev Jain <dev.jain@arm.com>
X-Migadu-Flow: FLOW_OUT



> On Jun 26, 2026, at 12:03, Dev Jain <dev.jain@arm.com> wrote:
>=20
>=20
>=20
> On 26/06/26 8:47 am, Muchun Song wrote:
>>=20
>>=20
>> On 2026/6/25 19:29, Dev Jain wrote:
>>> try_to_unmap_one() handles hugetlb folios when memory failure needs
>>> to replace a poisoned hugetlb mapping with a hwpoison entry. In that
>>> case page_vma_mapped_walk() returns the pte pointer to the hugetlb =
folio
>>> in pvmw.pte, but the code reads it with ptep_get().
>>>=20
>>> On arches which provide their own huge_ptep_get() to dereference a =
huge
>>> pte pointer, accessing via ptep_get() would cause pte_pfn(), =
pte_present()
>>> etc to misbehave.
>>>=20
>>> It is not clear whether this has a trivially visible effect to =
userspace.
>>>=20
>>> Just use huge_ptep_get() for dereferencing a huge pte pointer.
>>>=20
>>> Fixes: c7ab0d2fdc84 ("mm: convert try_to_unmap_one() to use =
page_vma_mapped_walk()")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>> ---
>>>   include/linux/hugetlb.h |  3 +++
>>>   mm/rmap.c               | 16 ++++++++++------
>>>   2 files changed, 13 insertions(+), 6 deletions(-)
>>>=20
>>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>>> index 2abaf99321e90..fdb7bdf7645c5 100644
>>> --- a/include/linux/hugetlb.h
>>> +++ b/include/linux/hugetlb.h
>>> @@ -1261,6 +1261,9 @@ static inline void hugetlb_count_sub(long l, =
struct mm_struct *mm)
>>>   {
>>>   }
>>>   +pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr,
>>> +            pte_t *ptep);
>>=20
>> Thanks so much for the fix! I'm curious, though: why do we
>> need to add a separate declaration for this function here?
>=20
> For !CONFIG_HUGETLB_PAGE, compiler complains that there is no =
huge_ptep_get.
> So this is to make compiler happy.

Got it. We can refer to 5d4af6195c87c6b162b7963e0ad00a214b80d764 to fix
this warning.

Muchun,
Thanks.

>=20
>>=20
>> Thanks,
>> Muchun
>>=20
>>> +
>>>   static inline pte_t huge_ptep_clear_flush(struct vm_area_struct =
*vma,
>>>                         unsigned long addr, pte_t *ptep)
>>>   {
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 1c77d5dc06e9f..aa8a254efaecc 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -2095,11 +2095,16 @@ static bool try_to_unmap_one(struct folio =
*folio, struct vm_area_struct *vma,
>>>           /* Unexpected PMD-mapped THP? */
>>>           VM_BUG_ON_FOLIO(!pvmw.pte, folio);
>>>   -        /*
>>> -         * Handle PFN swap PTEs, such as device-exclusive ones, =
that
>>> -         * actually map pages.
>>> -         */
>>> -        pteval =3D ptep_get(pvmw.pte);
>>> +        address =3D pvmw.address;
>>> +        if (folio_test_hugetlb(folio)) {
>>> +            pteval =3D huge_ptep_get(mm, address, pvmw.pte);
>>> +        } else {
>>> +            /*
>>> +             * Handle PFN swap PTEs, such as device-exclusive ones,
>>> +             * that actually map pages.
>>> +             */
>>> +            pteval =3D ptep_get(pvmw.pte);
>>> +        }
>>>           if (likely(pte_present(pteval))) {
>>>               pfn =3D pte_pfn(pteval);
>>>           } else {
>>> @@ -2110,7 +2115,6 @@ static bool try_to_unmap_one(struct folio =
*folio, struct vm_area_struct *vma,
>>>           }
>>>             subpage =3D folio_page(folio, pfn - folio_pfn(folio));
>>> -        address =3D pvmw.address;
>>>           anon_exclusive =3D folio_test_anon(folio) &&
>>>                    PageAnonExclusive(subpage);


