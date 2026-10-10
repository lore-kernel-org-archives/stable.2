Received: from mta1.migadu.com (out-211.mta1.migadu.com [95.215.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051923BCD37
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 02:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791601136; cv=none; b=pT5Utak6MjqPeDbtrDWiTeZ6RSh2tIYHwVkDRulh0UbCglKFccoWsDYXq9zxoVgrSBvqKtPMnTQQdC4Xa5FmeTQzi/P6vNAJkE++SVvTAzXHFwJDB3GR7R8XOEvcNYragl5Vx9UbnvByy9o5cET0jgvN6OkxFiN9D/LkSI0Q1yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791601136; c=relaxed/simple;
	bh=fuKQv+8RzNOVU5ZBFPLwPT4hB6cWDIUsCSCLi5x0JgQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bXnJGsD0kuN5ehRFHZOGb1Y+ZLIxxTqEnHPSsEshWqNbBSA1wxTIp71rgmWpk8IG9I/auNPQSc0FkDda/EOMtvPwx9TQ+yFQ65A6JkDP+AiLQxUZV0+QStZgHM4GWTz5G9W/bQ7ymJNc6gyTJ0vQGX7eglhHvxcalA8VrMNSiwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PAj8h8hF; arc=none smtp.client-ip=95.215.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PAj8h8hF"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fuKQv+8RzNOVU5ZBFPLwPT4hB6cWDIUsCSCLi5x0JgQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791601131; v=1; x=1792205931;
 b=PAj8h8hFf53pYA8bcbFfyagGuVs4DqfbJuXHEUnfv59QUS5S5psIkTHUuenHnzKs8/hsCMFW
 Y9qXKdb7ZS40BBEWtKNeHuAFhCPDS3wRLvIjGCOj+uzX/blKplHI+EZupUQhTBSUV88U9ZaJ57e
 hSGchvbD2wPg5sMocvPwtlqM=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 04bc35dd178ace7f;
	Sat, 10 Oct 2026 02:58:51 +0000
X-Mizu-Trace-ID: 04bc35dd178ace7f
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH 2/4] riscv/mm: fix hotplug page-table destructor handling
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <664510b2-3510-499f-aab5-ceddfcc82581@kernel.org>
Date: Sat, 10 Oct 2026 10:58:32 +0800
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
Message-Id: <F7FC1A28-A34E-4FE3-A6E8-92D842FFA0A8@linux.dev>
References: <20261008073021.2512665-1-songmuchun@bytedance.com>
 <20261008073021.2512665-3-songmuchun@bytedance.com>
 <664510b2-3510-499f-aab5-ceddfcc82581@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 10, 2026, at 04:37, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 10/8/26 09:30, Muchun Song wrote:
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
>=20
> Similar thought, can't we detect that in pagetable_free() somehow and =
avoid
> requiring callers to handle that?

I think we can, then pagetable_dtor_free() can be removed because =
pagetable_free
can handle the case of pagetable_dtor_free.

Thanks,
Muchun

>=20
> --=20
> Cheers,
>=20
> David


