Received: from mta1.migadu.com (out-72.mta1.migadu.com [95.215.58.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C46212542
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 02:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791945453; cv=none; b=TvHrtoKQi2dua5luHqg7ImxE6LAZfluKHK8PSL1q7BrZnpFtvwDNsSnNMEET9jvFLl2EVVUiuJ7VgcSh6KgblDvzffBWcvNeroqPR0dx6LTEWanWt0oSuC90JghWB+uLi08fhkKmjDvY6kh/8uX2dXEtzcIjDLIWao8Af5CUadQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791945453; c=relaxed/simple;
	bh=7UUTt82RGwkEsPz4m1IMAXE3gzzct3/wWyS9tYPd83k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=X4MpSy+2vDQDRIJsZ17bshhx52SrZlLXOnsoxGNcFU2RJvUvbWt9jCqOwuwzKe2vskaGsVAIc6yqI+xWEy6ud6jFc9b0sog86u5rUWTqc9JZ1LReeUnitLjrEcDEvFHEsKjQibiT6gE5WhHXasGQGqg9DRXZuPV9tVVwoffyTgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=La3OfXhN; arc=none smtp.client-ip=95.215.58.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="La3OfXhN"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7UUTt82RGwkEsPz4m1IMAXE3gzzct3/wWyS9tYPd83k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791945449; v=1; x=1792550249;
 b=La3OfXhNVJgiTFfFk9tY+W6mgr0e+Wrslw7TVGCZm2oEArf037YkG/VaXD73QhxkIW+S4BFV
 ry6UXbtpmVLiaS93qlaY5ZSA+ykqVboleHgKUV82+emy1AR7Qc9Q5x/81sBMDn8K6OyGtfnWTED
 uTDeO7hHWs7VDkyRRPysYJTc=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 48e5c038101e18a7;
	Wed, 14 Oct 2026 02:37:27 +0000
X-Mizu-Trace-ID: 48e5c038101e18a7
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH v2 1/4] mm: fix missing page-table destructor in
 pagetable_free()
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <2552e0bd-0e50-4dd5-a3d9-00e9204eb2c2@arm.com>
Date: Wed, 14 Oct 2026 10:37:04 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
 Dave Hansen <dave.hansen@intel.com>,
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Alistair Popple <apopple@nvidia.com>,
 linux-mm@kvack.org,
 linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6DB87EB4-93BB-4861-AC17-159DCD1E442B@linux.dev>
References: <20261010112457.49485-1-songmuchun@bytedance.com>
 <20261010112457.49485-2-songmuchun@bytedance.com>
 <2552e0bd-0e50-4dd5-a3d9-00e9204eb2c2@arm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 13, 2026, at 23:46, Kevin Brodsky <kevin.brodsky@arm.com> =
wrote:
>=20
> On 10/10/2026 13:24, Muchun Song wrote:
>> Since commit 49f599666420 ("mm: call ctor/dtor for kernel PTEs"),
>> pte_alloc_one_kernel() runs the page-table constructor for kernel PTE
>> tables.
>>=20
>> HVO (HugeTLB Vmemmap Optimization) uses pte_alloc_one_kernel() when
>> splitting a PMD. Restoring the vmemmap backing pages does not =
collapse
>> the PTE table, so a later memory hot-remove eventually frees it =
through
>> pagetable_free() on x86-64. That releases the page without running =
the
>> matching destructor and leaves NR_PAGETABLE elevated.
>>=20
>> Make pagetable_free() detect constructor-backed pages and run the
>> destructor before releasing their memory to fix the problem.
>>=20
>> Fixes: 49f599666420 ("mm: call ctor/dtor for kernel PTEs")
>> Cc: stable@vger.kernel.org
>> Assisted-by: LLM
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> v2:
>> - Move destructor handling from x86 into pagetable_free() (suggested =
by
>>  David Hildenbrand)
>> - Trim and update the commit message (requested by Dave Hansen)
>> ---
>> include/linux/mm.h | 37 ++++++++++++++++++++-----------------
>> 1 file changed, 20 insertions(+), 17 deletions(-)
>>=20
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 5cca90fc1df6..771a7d60b0a5 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -3969,23 +3969,6 @@ static inline void =
pagetable_free_kernel(struct ptdesc *pt)
>> __pagetable_free(pt);
>> }
>> #endif
>> -/**
>> - * pagetable_free - Free pagetables
>> - * @pt: The page table descriptor
>> - *
>> - * pagetable_free frees the memory of all page tables described by a =
page
>> - * table descriptor and the memory for the descriptor itself.
>> - */
>> -static inline void pagetable_free(struct ptdesc *pt)
>> -{
>> - 	if (ptdesc_test_kernel(pt)) {
>> - 		ptdesc_clear_kernel(pt);
>> - 		pagetable_free_kernel(pt);
>> - 	} else {
>> - 		__pagetable_free(pt);
>> - 	}
>> -}
>> -
>> #if defined(CONFIG_SPLIT_PTE_PTLOCKS)
>> #if ALLOC_SPLIT_PTLOCKS
>> void __init ptlock_cache_init(void);
>> @@ -4078,6 +4061,26 @@ static inline void pagetable_dtor(struct =
ptdesc *ptdesc)
>> 	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
>> }
>>=20
>> +/**
>> + * pagetable_free - Free pagetables
>> + * @pt: The page table descriptor
>> + *
>> + * pagetable_free frees the memory of all page tables described by a =
page
>> + * table descriptor and the memory for the descriptor itself.
>> + */
>> +static inline void pagetable_free(struct ptdesc *pt)
>> +{
>> + 	if (PageTable(ptdesc_page(pt)))
>> + 		pagetable_dtor(pt);
>=20
> Took me a while to understand why this is fine. Currently we have:
>=20
>     ptdesc =3D pagetable_alloc();
>     pagetable_*_ctor(mm, ptdesc);
>     [...]
>     pagetable_dtor(ptdesc);
>     pagetable_free(ptdesc);
>=20
> All good, nice and balanced.
>=20
> Now we're saying that pagetable_free() should call the dtor. But of
> course, in most cases, the dtor has already been called. Yes, this is
> fine because in that case PageTable(page) returns false. Still, the
> casual reader is likely to be confused (like I was).
>=20
> The commit message should really explain this. I'm not a big fan of =
the

Maybe I should mention that pagetable_free() is supposed to free page
table page from now on.

> asymmetry we're creating between explicit alloc+ctor and free =
implicitly
> calling dtor, but I suppose it's safer this way. (And looking at the
> rest of the series, it does bring some nice cleanups.)

Make sense. That's my plan.

>=20
> I understand this is a bugfix series so its scope is limited, but if
> time allows please post a follow-up series removing all those explicit
> dtor calls that are no longer required.
>=20
> Now don't get me wrong, I am absolutely in favour of moving as much
> handling as possible out of the ctor/dtor and into
> pagetable_{alloc,free}; a series I posted earlier [1] was a step in =
that

Excellent work.

> direction. It unfortunately had many issues, including the unmatched
> alloc/free calls [2]. The work you're doing in this series, and your
> plan to use pagetable_alloc() for vmemmap, are exactly what I was
> planning to do next, so thank you for taking care of that :)
> With the commit message improved:
>=20
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

Thanks.

>=20
> - Kevin
>=20
> [1]
> =
https://lore.kernel.org/linux-mm/20260714-remove_pgtable_cdtor-v1-0-44be8a=
7685d7@arm.com/
> [2]
> =
https://lore.kernel.org/linux-mm/6d167aaa-e9b0-4687-970c-1c67d0df6344@arm.=
com/
>=20
>> +
>> + if (ptdesc_test_kernel(pt)) {
>> + 	ptdesc_clear_kernel(pt);
>> + 	pagetable_free_kernel(pt);
>> + } else {
>> + 	__pagetable_free(pt);
>> + }
>> +}
>> +
>> static inline void pagetable_dtor_free(struct ptdesc *ptdesc)
>> {
>> 	pagetable_dtor(ptdesc);


