Received: from mta1.migadu.com (out-198.mta1.migadu.com [95.215.58.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F2547ECEE
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202242; cv=none; b=YUnGLzDE3Lh1nJ1FOkiZyBMRwF7AdN9OFNp43Ub5dSmua818gw21DUAvgXZrCqsqe26jeaUi1X316+QA9J45O4il6xWtzzycWZFyhGxu1xBq6O++ZfAvuci1uCieBKNOxh08iL4l3DL71SYvLLqEnL5oIAAzXihMNtth3JQ4FV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202242; c=relaxed/simple;
	bh=f+hFXIzzuMe3tcXs0GPJ00JVOEjMIu0ORPYVIQIfNH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kSObI2x4xlUA+bbNwdv5ZBTShqhiXO7PusQNcTQYQCDMY1Ao2FBPKIyaXZXv4uTy2c2DweMsuZM3OU6Ufxg+z2MTWUw2oMrZaFAM26k+/1Erqx+uCLB1qNLDeOYMkDsR9MuRjEz5CXwmVVgCEFQRTHOO0vRZnEuAH8JGBh5SLXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qc4uRKrd; arc=none smtp.client-ip=95.215.58.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qc4uRKrd"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=f+hFXIzzuMe3tcXs0GPJ00JVOEjMIu0ORPYVIQIfNH4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791202237; v=1; x=1791807037;
 b=qc4uRKrdD6qeP5GjqsjJ4Cz/Rrj6iackxl9sFUoPmCvOaYE8EX8Hbl6TnvA+elrpiXZPs0Du
 GJRdmcMJ+6fTBQ47KSYs4kVRaEXBale69wybiJ6i3YGqbb45Hmy9hpcsA559USq/HiU1/NaGSUH
 19T5pTfp6wE6ki5goZxoBEDg=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b52a094f8f923b80;
	Mon, 05 Oct 2026 12:10:37 +0000
X-Mizu-Trace-ID: b52a094f8f923b80
X-Migadu-Flow: FLOW_OUT
Message-ID: <c07ede42-408a-4959-9ca5-bb94ff851b0f@linux.dev>
Date: Mon, 5 Oct 2026 20:10:24 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] x86/mm: fix incomplete page-table invalidation with
 TCE
Content-Language: en-US
To: Pedro Falcato <pfalcato@suse.de>
Cc: dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, riel@surriel.com, linux-kernel@vger.kernel.org,
 qi.zheng@linux.dev, nadav.amit@gmail.com, thomas.lendacky@amd.com,
 kernel-team@meta.com, linux-mm@kvack.org, akpm@linux-foundation.org,
 brendan.jackman@linux.dev, jannh@google.com, mhklinux@outlook.com,
 andrew.cooper3@citrix.com, Manali.Shukla@amd.com, mingo@kernel.org,
 stable@vger.kernel.org, toshi.kani@hpe.com, david@kernel.org,
 mikhail.v.gavrilov@gmail.com
References: <20261005052302.43042-1-lance.yang@linux.dev>
 <asM7b8ECO34-jiwi@pedro-suse.tail5790ac.ts.net>
 <60d5db86-8002-4d87-b8d3-c161d674122b@linux.dev>
 <asN4wjUbDAIcrfA-@pedro-suse.tail5790ac.ts.net>
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <asN4wjUbDAIcrfA-@pedro-suse.tail5790ac.ts.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/10/5 18:24, Pedro Falcato wrote:
> On Mon, Oct 05, 2026 at 03:29:22PM +0800, Lance Yang wrote:
>>
>>
>> On 2026/10/5 14:09, Pedro Falcato wrote:
>>> On Mon, Oct 05, 2026 at 01:23:02PM +0800, Lance Yang wrote:
>>>> pud_free_pmd_page() uses a single-address invalidation to flush the
>>>> paging-structure caches before freeing the page tables. With AMD TCE
>>>> enabled, this only invalidates upper-level entries associated with the
>>>> target address. Cached PMD entries for other addresses in the PUD range can
>>>> still reference the PTE pages being freed.
>>>>
>>>> The AMD manual quoted in the commit enabling TCE says these instructions
>>>> remove
>>>>
>>>>     "only those upper-level entries that lead to the target PTE in the page
>>>>     table hierarchy, leaving unrelated upper-level entries intact."
>>>>
>>>> Even with all PTEs cleared, speculative page walks can cache present PMD
>>>> entries after the earlier TLB purge.
>>>>
>>>> Use a full TLB flush before freeing the page tables on CPUs with TCE. Keep
>>>> the single-address invalidation otherwise.
>>>>
>>>> Fixes: 440a65b7d25f ("x86/mm: Enable AMD translation cache extensions")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>>
>>> I'm not sure this is correct. The PUD is clear. We invalidate the TLB, which
>>> invalidates the translation caches for that walk. invlpg will notice the PUD
>>> isn't present. I don't see a case where it can ever not clear the rest
>>> of the translation caches for all leaves. And, in fact, by that point the CPU
>>> can (does?) probably formally treat the PUD as the leaf.
>>
>> IIUC, clearing the PUD in memory doesn't invalidate cached PMD entries by
>> itself. With TCE enabled, flushing one address only invalidates the entries
>> associated with that address ...
>>
>> (That's how I read the manual, but AMD folks, please correct me if I'm
>> missing something.)
>>
>> So couldn't other cached PMDs under the same PUD survive?
> 
> I don't read it as that. I read it as "flushing one address only invalidates
> the entries on that path". So, if you flush one address, you'll flush the
> whole translation cache for that range. And page table zapping agrees; if you
> follow the code from zap_pte_range() -> pte_free_tlb(), it will do a single flush
> for each PTE table (if the whole table is empty/non-present).

Let's wait for AMD folks to clarify whether a single-address flush is
sufficient :)
