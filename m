Received: from mta0.migadu.com (out-153.mta0.migadu.com [91.218.175.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8981D14A60F
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 03:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791603828; cv=none; b=lcSkPmHx1pYWaZyLYzyxJHx4Q4NF7gbQZ5M07BPhsZTM57yz1pqGMuRg0nYKWOkYL67kgTtsd2m9Jb6ybx/RyFY9TgNLVr5ppF2ft3kyTFsJiRekwlLUppDLdwbe8FyCev6CxMvsdvVEti/DK6tveY6EUkFgBDeo/Fl3mKFnhhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791603828; c=relaxed/simple;
	bh=e2Gg2A0pOiUOVFvGVHWV6wr7kkqR+muGcjituStXuzA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jyFL+0tUajIhxbo2tUtVyFb9XV8CuTfQU3nkB863dq5lJ39mwFD2Ar1i0/TDnkSoMeYJ+2MBLmRS6C8DJKHX4uVB27sKU0WXJ22S6Sena91oFsLGhZpGXtk0hid0kT16UtBzWAu+gJAYn7QCjqvR9cDjIhkXqoGgzWRqu0TAVUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=knhHF/JD; arc=none smtp.client-ip=91.218.175.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="knhHF/JD"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=e2Gg2A0pOiUOVFvGVHWV6wr7kkqR+muGcjituStXuzA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791603823; v=1; x=1792208623;
 b=knhHF/JDy9lkKxtZQnxgn3u7UyjAyvUOTckxSbLlK7a1iULv3C7sntUsb9k9jijBoEqjPsVM
 glo48k56/pu9rwM90gWWg3q6OH00dLjyEQldwtk9MV10cDWKYN/Fz1G82iksnDzUo8iWdJ3p3Nw
 lAciycb8CyOb7GiowS9UrO94=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 14bbb4f2a2970250;
	Sat, 10 Oct 2026 03:43:43 +0000
X-Mizu-Trace-ID: 14bbb4f2a2970250
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH 4/4] arm64/mm: fix destructor for unconstructed hotplug
 page tables
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <d47bdf83-1db4-4601-a516-7e23488ea9cf@kernel.org>
Date: Sat, 10 Oct 2026 11:43:23 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 akpm@linux-foundation.org,
 linux-mm@kvack.org,
 stable@vger.kernel.org,
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
Message-Id: <DDFF90A3-86D7-42D6-844A-5D29A44BAB4D@linux.dev>
References: <20261008073021.2512665-1-songmuchun@bytedance.com>
 <20261008073021.2512665-5-songmuchun@bytedance.com>
 <d47bdf83-1db4-4601-a516-7e23488ea9cf@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 10, 2026, at 04:43, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 10/8/26 09:30, Muchun Song wrote:
>> Commit c594b83457cc ("arm64: mm: call pagetable dtor when freeing
>> hot-removed page tables") made free_hotplug_pgtable_page()
>> unconditionally run the page-table destructor. This matches page =
tables
>> allocated by the arm64 mapping code, which runs the corresponding
>> constructors.
>>=20
>> However, arm64 also uses the generic sparse-vmemmap population code.
>> Runtime intermediate page tables allocated by that code do not run a
>> page-table constructor.
>=20
> Why do we have that inconsistency? It seems to cause pain :)

Ha, yeah, it's a bit painful :)

I think it's because the arch folks didn't realize that vmemmap =
population
does not run a page-table constructor.

But the inconsistency is temporary =E2=80=94 I deliberately kept it so =
the bug fixes
are easier to backport. After those fixes land, I'll follow up with the
unified series, which will make vmemmap population run a page-table
constructor.

>=20
>> Freeing one during memory hot-remove therefore
>> runs a destructor without a matching constructor and corrupts
>> NR_PAGETABLE accounting.
>>=20
>> Use PageTable() to run the destructor only for page-table pages whose
>> constructor initialized them. This keeps the arm64-created page-table
>> lifecycle balanced while safely freeing constructor-free vmemmap =
tables.
>>=20
>> Fixes: c594b83457cc ("arm64: mm: call pagetable dtor when freeing =
hot-removed page tables")
>> Cc: stable@vger.kernel.org
>> Assisted-by: LLM
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> arch/arm64/mm/mmu.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 7343ac9294f8..688b33095651 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1495,7 +1495,8 @@ static void free_hotplug_page_range(struct page =
*page, size_t size,
>>=20
>> static void free_hotplug_pgtable_page(struct page *page)
>> {
>> - 	pagetable_dtor(page_ptdesc(page));
>> + 	if (PageTable(page))
>> + 		pagetable_dtor(page_ptdesc(page));
>> 	free_hotplug_page_range(page, PAGE_SIZE, NULL);
>=20
> That results in a __free_pages() for  ones allocated by sparse-vmemmap
> population code. Are we sure that's the right thing to do?

Good point. free_hotplug_pgtable_page() is used to free intermediate
page-table pages, so pagetable_free() is the more appropriate interface
here.

>=20
> This is all so inconsistent and confusing :(

Yeah, so I'm working on removing these inconsistencies.

Thanks,
Muchun

>=20
> --=20
> Cheers,
>=20
> David


