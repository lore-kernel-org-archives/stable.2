Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795520731;
	b=MYsw5r7bImQX7Tw0BVvnXRqqpVfkKnS+zUSbshnbF6k+iDFLESdeFJYwluQbLPeoQRGS
	 Awch3n5x27uPYglOl+k302CORQxB2meJgiG66GYwOMDiDK32aR2BFPLRM7eaaezcCsuUh
	 czSZVpl5eNBGA44HmouE4qCut0MfZe8jGxg92cJiqEDptDSwJ4pP9R18tCYb1YJEd5g+O
	 vOz6zo39pXj0MMB0dPYPGAxQJDbwWP7Na7JnnN5D2gzbvjbdlwOHh/dpMz2UyNxGzgeo4
	 zKbO4X9OBNFKEGd7SY8hFs2csqSGIWEcJp/m9OQpvPnXzTD5oBpqqaoxyLNoXiZai+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795520731;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=FaOzZeSEcsiEu7Danddjhvc2fvrZGUSlNkNLOC9h7EU=;
	b=zYx4TRGD1gQiUkTlofQtwWzqPahOoqi1h8OVcWdyN3mvVfvduQAGpp444tkQSr9an1v5
	 clqi0xDVQI2pRb/9JpdSH3lfVLMwGS+EldOg/79YXTZsiJ0bioky/ODvuvGEdzKTHmTyE
	 oWvitog98yQOC1hmEW3R+2XsnPh+e5ABPlJy8P+xzmDLcHZ3Z10rmJ+lFIAgoYVklLupn
	 j9NVm6wpDMMIEFAwNMgclSjdkxkvDoJT6d9vX7QSvrGgCtb9/5f3H29r3glk4XuGw8EHv
	 /+Ll9qITShG/3qbNsU7cx8UVKn4MM+auXHmLEmwBqFL2IcAsyeVyVjNb64KyqDBHgVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="oHS1j/OD";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAD4606A327;
	Tue, 24 Nov 2026 11:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEAD4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=oHS1j/OD
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36740339;
	Tue, 24 Nov 2026 03:45:27 -0800 (PST)
Received: from [10.0.136.47] (LRYFGMQP07.cambridge.arm.com [10.0.136.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C7EC3F86F;
	Tue, 24 Nov 2026 03:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795520730; bh=okJBaBQeKqLQjanlOT9Hdjoxc/5u+umivG32ad9P2p0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oHS1j/ODs9XrlcrwFcErJAuiUASAVqGdlM5jJ0TrHu5LO/ecVQpI92au9My9i5YB4
	 IsEgPf5Eg2D9VfrdTht5Jho7YM+cHWoKdHuykVuNBYuauGW6ByyOMfILaILRHgrzmk
	 HHo8zI77+KVFXie7ld9oLUNxjfzFuhYGbQQR91gM=
Message-ID: <3d88c31d-04cc-49e4-b30a-3ece06908da6@arm.com>
Date: Tue, 24 Nov 2026 11:45:27 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: mm: Don't defer the barriers when installing a
 fixmap entry
To: Kevin Brodsky <kevin.brodsky@arm.com>, Fuad Tabba <fuad.tabba@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Yang Shi <yang@os.amperecomputing.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261120121638.194154-1-fuad.tabba@linux.dev>
 <20261120121638.194154-4-fuad.tabba@linux.dev>
 <6782b5ee-3dfe-4076-a79c-fbeb2c2ac7da@arm.com>
 <CA+EHjTziXrRdR+guikKbj93Az96T+AMx_=0sVeyWG5C4fwaaTg@mail.gmail.com>
 <5b0a26ee-30b0-4a79-9cca-9848dc9d65c5@arm.com>
 <f543aea2-3a21-44ce-bb44-c84bd66b0a76@arm.com>
 <74b99755-bc3d-4cad-9678-c2de740fe20a@arm.com>
 <f9a42849-fe8f-4a96-81a1-ab58193b222d@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
Content-Language: en-GB
In-Reply-To: <f9a42849-fe8f-4a96-81a1-ab58193b222d@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/11/2026 08:22, Kevin Brodsky wrote:
> On 23/11/2026 19:54, Ryan Roberts wrote:
>> On 23/11/2026 13:08, Kevin Brodsky wrote:
>>> On 23/11/2026 11:36, Ryan Roberts wrote:
>>>>>>> @@ -127,7 +127,9 @@ void __set_fixmap(enum fixed_addresses idx,
>>>>>>>          ptep = fixmap_pte(addr);
>>>>>>>
>>>>>>>          if (pgprot_val(flags)) {
>>>>>>> -                __set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
>>>>>>> +                /* The slot must be usable on return, even in lazy MMU mode. */
>>>>>>> +                __set_pte_nosync(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
>>>>>>> +                emit_pte_barriers();
>>>>>> I wonder if it would be clearer to wrap __set_ptes():
>>>>>>
>>>>>> lazy_mmu_mode_pause()
>>>>>> __set_ptes()
>>>>>> lazy_mmu_mode_resume()
>>>>> That would work. However, there's the stable backport. 6.18 has the
>>>>> bug, but lazy_mmu_mode_pause() was added in 7.0, so 6.18.y would need
>>>>> its own patch. This patch applies to 6.18 unchanged.
>>>>>
>>>>> I'm happy with either, or with a followup patch in the same series.
>>>> I'd personally prefer to use pause/resume since it's makes it very clear what's
>>>> going on and avoids the layer violation. Perhaps your approach as the back
>>>> portable one, then pause/resume as follow up (along with ptep_try_set() tidy
>>>> up)? Others might think differently though...
>>> Using pause/resume does work, but it is a bigger hammer than necessary.
>>> If other features make use of lazy MMU mode, then we may end up paying
>>> extra cost by leaving/re-entering the mode.
>>>
>>> For instance, with page table hardening [1], using the pause/resume
>>> approach means 4 extra ISBs:
>>> - 1 when pause() leaves lazy MMU mode: restoring default kpkeys context
>>> - 2 in __set_pte(): switching to page table update kpkeys context, and
>>> then back to default
>>> - 1 when resume() enters lazy MMU mode: entering page table update
>>> kpkeys context
>>>
>>> An explicit __set_pte_nosync() + emit_pte_barriers() achieves exactly
>>> what we're after (immediately visible PTE update) and doesn't disrupt
>>> lazy MMU mode - we don't unnecessarily set TIF_LAZY_MMU_PENDING. 
>> It's so ugly to spill this stuff everywhere though.
>>
>> How about a nested lazy mmu section?
>>
>> lazy_mmu_mode_enable()
>> __set_ptes()
>> lazy_mmu_mode_disable()
>>
>> If it's nested the enable() is essentially nop, and the disable is a flush,
>> which emits the barriers. If it's the first enable, we still set
>> TIF_LAZY_MMU_PENDING though...
> 
> Yes that's essentially the same as the explicit call to
> arch_flush_lazy_mmu_mode() I mentioned below. IMHO that looks pretty
> obfuscated though - the casual reader will wonder why we're creating a
> lazy MMU section for setting just one PTE. If we go down this route, I'd
> argue the explicit call to arch_flush_lazy_mmu_mode() is clearer (and
> our implementation is safe to call even outside of a lazy MMU section).

OK let's just leave it as Faud has done it then. I don't have a strong opinion.

> 
> - Kevin
> 
>>> An alternative approach that addresses your point about layer violation
>>> is to call arch_flush_lazy_mmu_mode() and leave the __set_pte() call
>>> unchanged. This is slightly slower as we still end up setting/clearing
>>> the TIF flag in that case. Not sure this is worth it - ultimately we
>>> have to be mindful of what lazy MMU mode is doing to ensure this code is
>>> correct. I'm happy with the current approach.
>>>
>>> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
>>>
>>> - Kevin
>>>
>>> [1] https://lore.kernel.org/r/20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com

