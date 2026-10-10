Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777A825F98A;
	Sat, 10 Oct 2026 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791638618; cv=none; b=eUKRKitDCVElX0HQV8JSo6KlYq8KjABaQzVvn3tBDdESruKKGTz6TgqMbWQ44y2KYmtF5uJ4rhgAMXNsvlbFEQWMif+dBECOr418grrOPBOUw9vvm5q+JJIDNeewBAjGtkw/cqyrt0ZOeVD5G4BlvKUs/YhRiUiKDy1NDzXfink=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791638618; c=relaxed/simple;
	bh=cM2J1p04d6KxHya+wO6I2ybiKXgq8Mcr9fRWnfsWy4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJCKD0CGIxoqexg0l0M0//ug4sNATIoZ8VfVKNY/+TulJEBdgRljpA9/qIsIL8P+MPWUbLZQm50nBHGkNnUsPMHQgYU6zqsE7ycpRu97S1oonjh2KYvrz9GUJvu/8hfvH6oKw493RfN/QdlUKpyrO2Nub8avNgJGAbS0mOsIrN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0fW5fFj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0fW5fFj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6622A1F000FF;
	Sat, 10 Oct 2026 13:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791638617;
	bh=jSn1IK04TkZcZee9zhz9sEIPssSjp24H+zQ/sP34SBE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=P0fW5fFjAF5qEShD2FDUvhRLrpwuYauXz7mH0/BSGcs1DeAv1GtmOVVG/2URH7Nil
	 Wp7IYW+Wv03cB9LfWZcRjNFYz0kCgtVvJncN3ac2E9G0ZIkIOdvjPHjh3vg52WlgNo
	 5Wlw/ejL90a14q4Vviu2IAatKuQrY5GO0AR9xa2hVWWg5/UwMnYgO3AgB+jB+lW+Vc
	 CzV6C9D/37DcbFx8Guens1jLZhndt+gROqpJ0cPyfu1x5sKaz92g9XWah1cqwpx6Wx
	 F5ZvDMs8i/Le+rGQB1xi9V8X65teOuzLFUWnMdc/8rWz+9kJ58E5S9pgQZHGzWWwFC
	 EZyVOU+A0eHzg==
Message-ID: <5d20f9b8-9085-49df-87df-05f29f1496a1@kernel.org>
Date: Sat, 10 Oct 2026 14:27:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] riscv/mm: fix hotplug page-table destructor handling
To: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, stable@vger.kernel.org, osalvador@suse.de,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, catalin.marinas@arm.com, will@kernel.org,
 mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 linux-riscv@lists.infradead.org, agordeev@linux.ibm.com,
 kevin.brodsky@arm.com, bjorn@rivosinc.com, apopple@nvidia.com,
 linux-kernel@vger.kernel.org
References: <20261008073021.2512665-1-songmuchun@bytedance.com>
 <20261008073021.2512665-3-songmuchun@bytedance.com>
 <664510b2-3510-499f-aab5-ceddfcc82581@kernel.org>
 <F7FC1A28-A34E-4FE3-A6E8-92D842FFA0A8@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <F7FC1A28-A34E-4FE3-A6E8-92D842FFA0A8@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/26 04:58, Muchun Song wrote:
> 
> 
>> On Oct 10, 2026, at 04:37, David Hildenbrand (Arm) <david@kernel.org> wrote:
>>
>> On 10/8/26 09:30, Muchun Song wrote:
>>> RISC-V uses the same memory-hotplug teardown code for the linear map and
>>> vmemmap, although their page-table pages are not always allocated in the
>>> same way. Late linear-map allocations run page-table constructors, while
>>> vmemmap and early allocations may provide constructor-free pages.
>>>
>>> The PTE path unconditionally runs the destructor, which is wrong for
>>> constructor-free vmemmap tables. The PMD path avoids that problem by
>>> using is_vmemmap as a proxy for constructor state, but that assumption
>>> will no longer hold once runtime vmemmap allocations use the normal
>>> pgalloc helpers.
>>>
>>> Page-table constructors record their state in PG_table. Centralize
>>> page-table freeing and use PageTable() to decide whether the destructor
>>> is required. Keep reserved and constructor-free pages on their existing
>>> freeing paths.
>>>
>>> Fixes: c75a74f4ba19 ("riscv: mm: Add memory hotplugging support")
>>> Cc: stable@vger.kernel.org
>>> Assisted-by: LLM
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>> ---
>>> arch/riscv/mm/init.c | 29 ++++++++++++++---------------
>>> 1 file changed, 14 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>>> index 857f9a55039c..429a0b015ec1 100644
>>> --- a/arch/riscv/mm/init.c
>>> +++ b/arch/riscv/mm/init.c
>>> @@ -1486,10 +1486,19 @@ struct execmem_info __init *execmem_arch_setup(void)
>>> #endif /* CONFIG_EXECMEM */
>>>
>>> #ifdef CONFIG_MEMORY_HOTPLUG
>>> +static void __meminit free_pagetable(struct page *page)
>>> +{
>>> + 	if (PageReserved(page))
>>> + 		free_reserved_page(page);
>>> + 	else if (PageTable(page))
>>> + 		pagetable_dtor_free(page_ptdesc(page));
>>> + 	else
>>> + 		pagetable_free(page_ptdesc(page));
>>
>> Similar thought, can't we detect that in pagetable_free() somehow and avoid
>> requiring callers to handle that?
> 
> I think we can, then pagetable_dtor_free() can be removed because pagetable_free
> can handle the case of pagetable_dtor_free.

That sounds much cleaner :)

-- 
Cheers,

David
