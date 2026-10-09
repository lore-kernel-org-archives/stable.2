Received: from mta0.migadu.com (out-24.mta0.migadu.com [91.218.175.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142B64D7950
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791555312; cv=none; b=C84CQRFwu20+rO9S29s3PwzqJsmMr707WWO7rjG81298aZoKA1shCEz0s35FGl8EMtyy/o7YlF7ndU0vxno42BtNdzfzbZkOEQrMmy+B8YC8RnPz8+bYDYe9LF0trkWyJ/zTvo/YbJBI/j0D3jJ8yPqvRJ6unMF8OFrLgA962FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791555312; c=relaxed/simple;
	bh=D7hfrm3qIlI4+AhECxlB2fjvQpfx6eid9hhS+USFrjU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rTsF3c1Vmn2nYsHh1EU+lebE0K33LpOuEwZTWEVA8f+kdGmrYBGIC7yJC7JKK1T5ArjCBycfE0yAjhbR6snsY+xV/OqYERfTDbnHG+Z0mFjgm2oE/nOupoMhBoIOI/UGAmXfc3rZhiHoSYhx/obHGeTvUDH4NIL5dgSF+A+t5/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j8NTeppk; arc=none smtp.client-ip=91.218.175.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j8NTeppk"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=D7hfrm3qIlI4+AhECxlB2fjvQpfx6eid9hhS+USFrjU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791555306; v=1; x=1792160106;
 b=j8NTeppkVXGfC8IhWAZ+0uNt2krpxfFy33/z/lBbjk4Iovqn5lLkJ69MNhmRam47hpDvVo4r
 ClMmjS19pVnfiXmbSCvpyMaDhp/psc5s8psLKxXq8Urx6grXRx/HF0dW+KrncM1RNDSzcrVJ6c2
 Keq9+GOQmKeQeNLLEldjIsEM=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d5fd037bf9b86533;
	Fri, 09 Oct 2026 14:15:05 +0000
X-Mizu-Trace-ID: d5fd037bf9b86533
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH 2/4] riscv/mm: fix hotplug page-table destructor handling
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <87jynrs8v8.fsf@all.your.base.are.belong.to.us>
Date: Fri, 9 Oct 2026 22:14:40 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 akpm@linux-foundation.org,
 linux-mm@kvack.org,
 stable@vger.kernel.org,
 david@kernel.org,
 osalvador@suse.de,
 dave.hansen@linux.intel.com,
 luto@kernel.org,
 peterz@infradead.org,
 tglx@kernel.org,
 mingo@redhat.com,
 bp@alien8.de,
 x86@kernel.org,
 hpa@zytor.com,
 catalin.marinas@arm.com,
 will@kernel.org,
 mark.rutland@arm.com,
 linux-arm-kernel@lists.infradead.org,
 pjw@kernel.org,
 palmer@dabbelt.com,
 aou@eecs.berkeley.edu,
 alex@ghiti.fr,
 linux-riscv@lists.infradead.org,
 agordeev@linux.ibm.com,
 kevin.brodsky@arm.com,
 bjorn@rivosinc.com,
 apopple@nvidia.com,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0E3A4E15-38DA-400D-95F2-01FFBB36304B@linux.dev>
References: <20261008073021.2512665-1-songmuchun@bytedance.com>
 <20261008073021.2512665-3-songmuchun@bytedance.com>
 <87jynrs8v8.fsf@all.your.base.are.belong.to.us>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 9, 2026, at 14:09, Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> =
wrote:
>=20
> Muchun Song <songmuchun@bytedance.com> writes:
>=20
>> RISC-V uses the same memory-hotplug teardown code for the linear map =
and
>> vmemmap, although their page-table pages are not always allocated in =
the
>> same way. Late linear-map allocations run page-table constructors, =
while
>> vmemmap and early allocations may provide constructor-free pages.
>>=20
>> The PTE path unconditionally runs the destructor, which is wrong for
>> constructor-free vmemmap tables. The PMD path avoids that problem by
>> using is_vmemmap as a proxy for constructor state, but that =
assumption
>> will no longer hold once runtime vmemmap allocations use the normal
>> pgalloc helpers.
>>=20
>> Page-table constructors record their state in PG_table. Centralize
>> page-table freeing and use PageTable() to decide whether the =
destructor
>> is required. Keep reserved and constructor-free pages on their =
existing
>> freeing paths.
>>=20
>> Fixes: c75a74f4ba19 ("riscv: mm: Add memory hotplugging support")
>> Cc: stable@vger.kernel.org
>> Assisted-by: LLM
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> arch/riscv/mm/init.c | 29 ++++++++++++++---------------
>> 1 file changed, 14 insertions(+), 15 deletions(-)
>>=20
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index 857f9a55039c..429a0b015ec1 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -1486,10 +1486,19 @@ struct execmem_info __init =
*execmem_arch_setup(void)
>> #endif /* CONFIG_EXECMEM */
>>=20
>> #ifdef CONFIG_MEMORY_HOTPLUG
>> +static void __meminit free_pagetable(struct page *page)
>> +{
>> + 	if (PageReserved(page))
>> + 		free_reserved_page(page);
>> + 	else if (PageTable(page))
>> + 		pagetable_dtor_free(page_ptdesc(page));
>> + 	else
>> + 		pagetable_free(page_ptdesc(page));
>> +}
>=20
> Is PageReserved() enought to determine if there's no dtor to run? On

Yes.

> rv64 your code is correct, but maybe for robustness?
>=20
>  | if (PageTable(page))
>  |         pagetable_dtor(page_ptdesc(page));
>  |=20
>  | if (PageReserved(page))
>  |         free_reserved_page(page);
>  | else
>  |         pagetable_free(page_ptdesc(page));

his looks good to me as well. I'll change it in the next version. =
Thanks!

Muchun

>=20
>=20
> Bj=C3=B6rn

