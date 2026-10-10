Received: from mta0.migadu.com (out-168.mta0.migadu.com [91.218.175.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8427414A60F
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 03:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791603887; cv=none; b=WMPbnaMOb7YFApt24NmRT95BDU6NXo51pB1bP9INgLPvKKBYH7F2SQxIY04OjSZNRoGDY7VL90HDo9z/5G+wGuD2Cwgh5S/HWBRBzQAeSCF5wDeAMkm8/L+G/2iD1agyBY2WIz5R9mrSY4ENyEek6fq8dp44uPrIn/WBG3VPvQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791603887; c=relaxed/simple;
	bh=0fo0QMf0rjH7MV2/iuitzfDF1YtJ7sax/S4uxQhGa9o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ui8ytS8XFCw8Y0z8cPFPtAxH79K7WGNrtlvuWgwr1106QnGwAgI2RiJaWgy0VyPtul4zXBXyHJzrQSmnYS/YcnChG+gTjSEwWEoLcgENf6rGGp1U0wCrokTH+OsFr0JMn1tgaTdovBRuGDb3ZUnM11qDiRfnQCnzGnXXoc0o10w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZLC1yd49; arc=none smtp.client-ip=91.218.175.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZLC1yd49"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0fo0QMf0rjH7MV2/iuitzfDF1YtJ7sax/S4uxQhGa9o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791603883; v=1; x=1792208683;
 b=ZLC1yd49raPT2YE6fJK39fORSvmhoQ+qRo6TIfUNdICyeTRbOIPSyf7weuspuE38vRpSN4gb
 p6+0ej03LOD1jJNcm2KNzO7FGkozS57yvKefcmGG1STBSvbFYc8ZxVErWpNN3aCs/mFJRy4WJMv
 XBuUAQiDHwREqPS/v3U3almI=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 468dd143d2755872;
	Sat, 10 Oct 2026 03:44:43 +0000
X-Mizu-Trace-ID: 468dd143d2755872
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
In-Reply-To: <1a0f51d9-7931-45a3-ab36-e0642c199a37@kernel.org>
Date: Sat, 10 Oct 2026 11:44:26 +0800
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
Message-Id: <062E1067-B11D-4BF7-A2BA-C71B599A805C@linux.dev>
References: <20261008073021.2512665-1-songmuchun@bytedance.com>
 <20261008073021.2512665-2-songmuchun@bytedance.com>
 <ECC604FF-E74D-43B1-9105-A6683EEDE558@linux.dev>
 <1a0f51d9-7931-45a3-ab36-e0642c199a37@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 10, 2026, at 04:29, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 10/8/26 10:32, Muchun Song wrote:
>>=20
>>=20
>>> On Oct 8, 2026, at 09:30, Muchun Song <songmuchun@bytedance.com> =
wrote:
>>>=20
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
>>> +  	else if (PageTable(page))
>>> +  		pagetable_dtor_free(page_ptdesc(page));
>>=20
>> Sashiko mentioned that kernel page table pages and vmemmap pages are
>> freed to the buddy allocator before their parent entries are cleared
>> and before the TLB is flushed, creating a dangling pointer window.
>>=20
>> That's a a real but pre-existing issue, I will not fix that in this
>> series.
>=20
> Memory is getting removed, concurrent access to directmap+vmemmap is =
not
> expected unless BUG I think. That should make this less critical I =
think ...
> (except speculation? not sure if that applies)

Agree. So, I will ignore this.

Thanks,
Muchun

>=20
> --=20
> Cheers,
>=20
> David


