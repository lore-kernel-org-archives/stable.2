Received: from mta0.migadu.com (out-70.mta0.migadu.com [91.218.175.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F16630DEA5
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811800; cv=none; b=MofWGZfiNcbtVm5zxGvSS8IBZ+gYMlAfaPvctDGQoz3auOdkBsJh4QmG/UqlBl6db5YMlFIemUPV8TKhv3I20iHhR0GKts1C+Eroj/2/2bbE71VZP4rdsWpdTlXfAxzRreSH+v8Sy+1vyEC2ZhOOxeUZYPZRiNbBhyx97WSmXnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811800; c=relaxed/simple;
	bh=GGn8drrlO6i+jPM1cQp3kvDlxLXSPfm+i8X2a7OAoPo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gIR1KEyGx61CfSQDoQXerd2HTMIT/fDY+meGRjZ2XNaKaawH9+73v+d3YLr/qrAem44heVeGnZ/xjA2Kl0DrLeBbSB5JFMN9KuehX3uFRUqc1hHvK7xd5zHVKrZtboLjN9Lh6RZ7+V4MEorq5Z5IwdXwphLy3hiQgG7zpxnA0bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HKcQEqzM; arc=none smtp.client-ip=91.218.175.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HKcQEqzM"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GGn8drrlO6i+jPM1cQp3kvDlxLXSPfm+i8X2a7OAoPo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791811795; v=1; x=1792416595;
 b=HKcQEqzMc0b9qa3T1l/MT1XX0glz8eLZEWBDc5AJJkcuEAlLFd65BvG/PK8qVzy9Mf/fZPNW
 8dO6QDotEkdH3rj8UjNe2IE6iaeogMiaoXnpuJZZMWnJAHGZ7ImhKIfqy5LwDxPo2JXY+v+V0D/
 FTFz2JY0x35Bi0yTNwGvHeEk=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id d7c9edd7e757cc90;
	Mon, 12 Oct 2026 13:29:55 +0000
X-Mizu-Trace-ID: d7c9edd7e757cc90
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
In-Reply-To: <919fcaa9-5ebe-4940-b4fc-59ea0c655ec3@kernel.org>
Date: Mon, 12 Oct 2026 21:29:35 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
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
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Alistair Popple <apopple@nvidia.com>,
 linux-mm@kvack.org,
 linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <77D942CF-B657-4735-9B95-1C6B38DD0F46@linux.dev>
References: <20261010112457.49485-1-songmuchun@bytedance.com>
 <20261010112457.49485-2-songmuchun@bytedance.com>
 <919fcaa9-5ebe-4940-b4fc-59ea0c655ec3@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 12, 2026, at 21:27, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 10/10/26 13:24, Muchun Song wrote:
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
>> - if (ptdesc_test_kernel(pt)) {
>> - ptdesc_clear_kernel(pt);
>> - pagetable_free_kernel(pt);
>> - } else {
>> - __pagetable_free(pt);
>> - }
>> -}
>> -
>> #if defined(CONFIG_SPLIT_PTE_PTLOCKS)
>> #if ALLOC_SPLIT_PTLOCKS
>> void __init ptlock_cache_init(void);
>> @@ -4078,6 +4061,26 @@ static inline void pagetable_dtor(struct =
ptdesc *ptdesc)
>> lruvec_stat_sub_folio(folio, NR_PAGETABLE);
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
>> + if (PageTable(ptdesc_page(pt)))
>> + pagetable_dtor(pt);
>=20
>=20
> We do have
>=20
> static inline void pagetable_dtor_free(struct ptdesc *ptdesc)
> {
> 	pagetable_dtor(ptdesc);
> 	pagetable_free(ptdesc);
> }
>=20
> ... can we now get rid of pagetable_dtor_free() and simply use =
pagetable_free() ?
> (separate cleanup)

You're right, that's exactly my plan.

>=20
>> +
>> + 	if (ptdesc_test_kernel(pt)) {
>> + 		ptdesc_clear_kernel(pt);
>> + 		pagetable_free_kernel(pt);
>> + 	} else {
>> + 		__pagetable_free(pt);
>> + 	}
>=20
>=20
> This goes into the right direction. I'm still confused, but the less =
freeing
> functions we have the better.
>=20
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks David.

>=20
> --=20
> Cheers,
>=20
> David

