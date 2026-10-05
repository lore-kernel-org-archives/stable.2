Received: from mta0.migadu.com (out-130.mta0.migadu.com [91.218.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2C3259C82
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 07:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791185044; cv=none; b=B7j7YG+AsOUU2vHiv2qWszOWufkxsi+U+ASGnfMu/OhU0g3vlbqGm5jHCfx8ehnW9V6B55/We0r7WmsFqQ77qq4sowvPNMu5dSlasNkzMSpQF6fhCdlitG4xjPiKkLi8oIFtLoPQ7O4000hn+LipIPNoJtCAR3s3+6cOuJxARyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791185044; c=relaxed/simple;
	bh=Gmsh/yjeWQhuRRzt7tOzKvgXe8nse8xEadBQY+u8XjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkkT+gy6nieMN/2C7GvUKcBLPpnRH4Pn42zN6MN8d5Brunq/v2YhyKjun98VnzZJu0baoKxoM6mOGpAdtaGYXiPgV8TNgUFkgUNWCvQttM0F732EDxfiTVu67TZrCdiiusnrG53/FhHr3f92Zm4iO5gWKBPTqJaHrrd8efOJWZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wchswUTx; arc=none smtp.client-ip=91.218.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wchswUTx"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Gmsh/yjeWQhuRRzt7tOzKvgXe8nse8xEadBQY+u8XjM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791185037; v=1; x=1791789837;
 b=wchswUTx3q4XFhZr3lr+cgPzLyyaYnbldXpuAa9VsE3xssRtOj4zVsJIpyLPxu3HEhVRX2ME
 M3HYnlJv8VM/2eyRq3DwN4cP+SlhP/xQuacqs9sKiTsnAyr7bF6c6H+kpfYvFo7D/R9u7eNhQ0k
 wR66Obpf1Ms+0IuHeSUFnnL4=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 943f59b3aa53cf7d;
	Mon, 05 Oct 2026 07:23:57 +0000
X-Mizu-Trace-ID: 943f59b3aa53cf7d
X-Migadu-Flow: FLOW_OUT
Message-ID: <c6421cab-1a21-4d39-87ff-05dc7be6bc02@linux.dev>
Date: Mon, 5 Oct 2026 15:23:45 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] x86/mm: fix incomplete page-table invalidation with
 TCE
To: Nadav Amit <nadav.amit@gmail.com>
Cc: dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, riel@surriel.com, linux-kernel@vger.kernel.org,
 qi.zheng@linux.dev, thomas.lendacky@amd.com, kernel-team@meta.com,
 linux-mm@kvack.org, akpm@linux-foundation.org, brendan.jackman@linux.dev,
 jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
 Manali.Shukla@amd.com, mingo@kernel.org, stable@vger.kernel.org,
 toshi.kani@hpe.com, david@kernel.org, mikhail.v.gavrilov@gmail.com,
 pfalcato@suse.de
References: <20261005052302.43042-1-lance.yang@linux.dev>
 <D8AEF6EF-D92A-4838-95A7-EB93BE319BE1@gmail.com>
Content-Language: en-US
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <D8AEF6EF-D92A-4838-95A7-EB93BE319BE1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/10/5 14:38, Nadav Amit wrote:
> 
> 
>>
>>
>> On 5 Oct 2026, at 8:23, Lance Yang <lance.yang@linux.dev> wrote:
>>
>> pud_free_pmd_page() uses a single-address invalidation to flush the
>> paging-structure caches before freeing the page tables. With AMD TCE
>> enabled, this only invalidates upper-level entries associated with the
>> target address. Cached PMD entries for other addresses in the PUD range can
>> still reference the PTE pages being freed.
>>
>> The AMD manual quoted in the commit enabling TCE says these instructions
>> remove
>>
>>   "only those upper-level entries that lead to the target PTE in the page
>>   table hierarchy, leaving unrelated upper-level entries intact."
>>
>> Even with all PTEs cleared, speculative page walks can cache present PMD
>> entries after the earlier TLB purge.
>>
>> Use a full TLB flush before freeing the page tables on CPUs with TCE. Keep
>> the single-address invalidation otherwise.
>>
>> Fixes: 440a65b7d25f ("x86/mm: Enable AMD translation cache extensions")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>> arch/x86/mm/pgtable.c | 11 ++++++++++-
>> 1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
>> index 4a105f283cfb..6b7fa44f1bf6 100644
>> --- a/arch/x86/mm/pgtable.c
>> +++ b/arch/x86/mm/pgtable.c
>> @@ -727,7 +727,16 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
>> 	 * via normal page walks. Make them unreachable
>> 	 * in cached mid-level walks too:
>> 	 */
>> -	flush_tlb_kernel_range(addr, addr + PAGE_SIZE-1);
>> +	if (boot_cpu_has(X86_FEATURE_TCE)) {
>> +		/*
>> +		 * With TCE enabled, a single-address flush does not invalidate
>> +		 * cached PMD entries for the rest of the PUD range.
>> +		 */
>> +		flush_tlb_all();
>> +	} else {
>> +		/* INVLPG to clear all paging-structure caches */
>> +		flush_tlb_kernel_range(addr, addr + PAGE_SIZE-1);
>> +	}
>>
> 
> 
> It might be cleaner to replace flush_tlb_all() with:
> 
> 	flush_tlb_kernel_range(addr, addr + PUD_SIZE - 1);

Looks much cleaner, Thanks!

> While the flush-ceiling would usually end up doing a full flush, the
> code would be easier to follow (the very least). Maybe adding stride
> to kernel TLB range flushing would make sense in the future.

Ack.
