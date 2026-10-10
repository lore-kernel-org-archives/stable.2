Received: from mta1.migadu.com (out-139.mta1.migadu.com [95.215.58.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F837314B6E
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 03:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791604241; cv=none; b=ho6qA6Mz4CJJBrlE6ELJGvyQJF8e1/NJzZHlvuBnosyXRNLYHcmCffJLsEv8wdny8WIRb5ZP3eFENZb9AOcQfwl5yUz/NRa9plWCY8xWLAHgCJ7HgBwxuw2u+JeTgUpAoc2GTL2YSCBW+uohNK8L50ifp0/z0BSmuseHjltmEGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791604241; c=relaxed/simple;
	bh=ejj+1mQ7GORhSID6jODIShDthWwWtiPSHyMLfZ3/AqU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WTK/ZTRn7GZK05JgNlwqaGZfEX2nXrbaQpw95jnaX6aYLvuNGtX+3WqhKTpwPw8e0d9PKCOb0xg5UrGv0LEHiPSiUTUqH1Edpt4gjeg054GKbbokAdelEcezjrpj8MF8s+k3NIqToU2SrqbTC9M1TFfffe0DsL7fXrAzJrV0iOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oXXbzJ4J; arc=none smtp.client-ip=95.215.58.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oXXbzJ4J"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ejj+1mQ7GORhSID6jODIShDthWwWtiPSHyMLfZ3/AqU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791604238; v=1; x=1792209038;
 b=oXXbzJ4JEVIIlXmLSFRm9OK+stur3MstaTSM8R7gazaCRKIGrKwCfpn8L2p7Dj5L16p8FS71
 p+ORylMMHzgTMoR/YNm9X2+lSyxkj632ly8gHzZ2g0ei1Jyxvu/lJPvz/2amZ+UA2nLFH41br1x
 pIxXRgA80hDqODcHgG5tXZrI=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9484aa877343ee44;
	Sat, 10 Oct 2026 03:50:15 +0000
X-Mizu-Trace-ID: 9484aa877343ee44
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH 1/4] x86/mm: fix missing pgtable destructor for vmemmap
 tables
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <39ae6c48-7fcc-41d5-bfaf-fe626071861e@kernel.org>
Date: Sat, 10 Oct 2026 11:49:57 +0800
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
Message-Id: <98481914-D123-4F58-97FA-C2F34469D34C@linux.dev>
References: <20261008073021.2512665-1-songmuchun@bytedance.com>
 <20261008073021.2512665-2-songmuchun@bytedance.com>
 <b8769c67-1683-4d84-94c9-916c305dafc0@kernel.org>
 <39ae6c48-7fcc-41d5-bfaf-fe626071861e@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 10, 2026, at 04:36, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 10/9/26 22:33, David Hildenbrand (Arm) wrote:
>> On 10/8/26 09:30, Muchun Song wrote:
>>> Since commit 49f599666420 ("mm: call ctor/dtor for kernel PTEs"),
>>> pte_alloc_one_kernel() runs the page-table constructor for kernel =
PTE
>>> tables.
>>>=20
>>> HugeTLB vmemmap optimization uses pte_alloc_one_kernel() when =
splitting
>>> a PMD. Restoring the vmemmap backing pages does not collapse the PTE
>>> table, so a later memory hot-remove eventually frees that table =
through
>>> free_pagetable(). That path currently calls pagetable_free() =
directly
>>> without decrementing NR_PAGETABLE.
>>>=20
>>> Use PageTable() to identify constructor-backed tables and run the
>>> matching destructor before freeing them. Keep reserved and
>>> constructor-free tables on their existing paths. This also prepares
>>> vmemmap teardown for generic runtime allocations through the normal
>>> pgalloc helpers.
>>>=20
>>> Fixes: 49f599666420 ("mm: call ctor/dtor for kernel PTEs")
>>> Cc: stable@vger.kernel.org
>>> Assisted-by: LLM
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>> ---
>>> arch/x86/mm/init_64.c | 2 ++
>>> 1 file changed, 2 insertions(+)
>>>=20
>>> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
>>> index 70e682180291..a3ea627157ab 100644
>>> --- a/arch/x86/mm/init_64.c
>>> +++ b/arch/x86/mm/init_64.c
>>> @@ -1003,6 +1003,8 @@ static void __meminit free_pagetable(struct =
page *page)
>>> {
>>> 	if (PageReserved(page))
>>> 		free_reserved_page(page);
>>> + 	else if (PageTable(page))
>>> + 		pagetable_dtor_free(page_ptdesc(page));
>>> 	else
>>> 		pagetable_free(page_ptdesc(page));
>>> }
>>=20
>> pagetable_free() will do ptdesc_test_kernel(pt) -> =
pagetable_free_kernel(pt) ->
>> pagetable_dtor_free().
>=20
> Ah, behavior depends on CONFIG_ASYNC_KERNEL_PGTABLE_FREE$ ...
>=20
> Why not do the right thing in pagetable_free() instead?

Good point. More easy to this issue on different architecture. I'll fix
pagetable_free next version.

Thanks,
Muchun

>=20
> --=20
> Cheers,
>=20
> David


