Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795508536;
	b=ygVEhBpMmQ4LKY7p5u4Q0pCpd18yrzmvrAi7R5fEAkfHUyeTl7FFWVe+ZQQPuwA98Vf1
	 1agsP/bAUOrsc9jBzMe8Vn63ALlGAQKxZ5c8OML1H2mmpSOl9XFyB+4cfUnZFlDIEdJHq
	 eZPk5gwJ5nzM8WncT7/s8NrX+VT1QTVyH0USpFn0Gp5zaabiMqkrZVq1lVIzxrsAfHPTH
	 5Y4OSiuVRmo8cNG3NT45R5YqGlo+XQ5VKT8BGfu+eJ1SYttVdirQUyzGtElX7H6wade38
	 45cb+ix7ItMlhYMLpYsSrg0L8zyDAuosbQtD521ECxXayUcDjV23Ye5muRelbC9acwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795508536;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=UTreTMQa8LvjdoM8COmSUHdlMhJFJeNrLGcsJogPxCo=;
	b=P6WHY/p0uFGWNVU3++qORd3KzpP8oK8Zw5SEFyOZ9nrx85N3njNi+SgXPn1owMfT+Vcx
	 tqqp71MHbs8tRm6QYRGdNCNjeMZXjpZiZi3mkqWTYc8rsTaJfhv8r3SZVuum/LFl21vSI
	 A4Am15JkojwuQxoTCMEFWmCZfsvRtim6wZH36Az/JIjV0ky+cgBhP7luPtX50sgOle0SY
	 4EkQLsRFRIenA7S94uDYgI9sqCgly9r3Z7qC1pNjhQUOvuTy6eToYnkTIkQa8u5dep9+j
	 6PHfuJAwywlmDL6IvN4zW1pQZBl4d2WhI6B428wfN42SZIHMmCu73d+xC8Kxk4IRBEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DvXjesYv;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCC7606A31E;
	Tue, 24 Nov 2026 08:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DCC7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DvXjesYv
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9430D339;
	Tue, 24 Nov 2026 00:22:12 -0800 (PST)
Received: from [10.57.32.89] (unknown [10.57.32.89])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61A3D3F632;
	Tue, 24 Nov 2026 00:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795508535; bh=UN0TYHD1/Q+IpKv1fvkTUAHvCf4+97rRTpT+UJ/8pek=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DvXjesYvFiRzxrR8ub/OAEeqpByEnUvZsjIYvz7GrSaVJDYZQ8fIyW1SB908YskGi
	 cokaybsZGddAylVKSgVoOADOobCypqvp0tq2WYZBxA7TASZHhGdMxPZDZEIZbW2UYA
	 hTgi+lVGT5O/++htwhm0NbSaLGe5Y9PrfGn3c32Y=
Message-ID: <f9a42849-fe8f-4a96-81a1-ab58193b222d@arm.com>
Date: Tue, 24 Nov 2026 09:22:11 +0100
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
To: Ryan Roberts <ryan.roberts@arm.com>, Fuad Tabba <fuad.tabba@linux.dev>
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
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <74b99755-bc3d-4cad-9678-c2de740fe20a@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/11/2026 19:54, Ryan Roberts wrote:
> On 23/11/2026 13:08, Kevin Brodsky wrote:
>> On 23/11/2026 11:36, Ryan Roberts wrote:
>>>>>> @@ -127,7 +127,9 @@ void __set_fixmap(enum fixed_addresses idx,
>>>>>>          ptep = fixmap_pte(addr);
>>>>>>
>>>>>>          if (pgprot_val(flags)) {
>>>>>> -                __set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
>>>>>> +                /* The slot must be usable on return, even in lazy MMU mode. */
>>>>>> +                __set_pte_nosync(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
>>>>>> +                emit_pte_barriers();
>>>>> I wonder if it would be clearer to wrap __set_ptes():
>>>>>
>>>>> lazy_mmu_mode_pause()
>>>>> __set_ptes()
>>>>> lazy_mmu_mode_resume()
>>>> That would work. However, there's the stable backport. 6.18 has the
>>>> bug, but lazy_mmu_mode_pause() was added in 7.0, so 6.18.y would need
>>>> its own patch. This patch applies to 6.18 unchanged.
>>>>
>>>> I'm happy with either, or with a followup patch in the same series.
>>> I'd personally prefer to use pause/resume since it's makes it very clear what's
>>> going on and avoids the layer violation. Perhaps your approach as the back
>>> portable one, then pause/resume as follow up (along with ptep_try_set() tidy
>>> up)? Others might think differently though...
>> Using pause/resume does work, but it is a bigger hammer than necessary.
>> If other features make use of lazy MMU mode, then we may end up paying
>> extra cost by leaving/re-entering the mode.
>>
>> For instance, with page table hardening [1], using the pause/resume
>> approach means 4 extra ISBs:
>> - 1 when pause() leaves lazy MMU mode: restoring default kpkeys context
>> - 2 in __set_pte(): switching to page table update kpkeys context, and
>> then back to default
>> - 1 when resume() enters lazy MMU mode: entering page table update
>> kpkeys context
>>
>> An explicit __set_pte_nosync() + emit_pte_barriers() achieves exactly
>> what we're after (immediately visible PTE update) and doesn't disrupt
>> lazy MMU mode - we don't unnecessarily set TIF_LAZY_MMU_PENDING. 
> It's so ugly to spill this stuff everywhere though.
>
> How about a nested lazy mmu section?
>
> lazy_mmu_mode_enable()
> __set_ptes()
> lazy_mmu_mode_disable()
>
> If it's nested the enable() is essentially nop, and the disable is a flush,
> which emits the barriers. If it's the first enable, we still set
> TIF_LAZY_MMU_PENDING though...

Yes that's essentially the same as the explicit call to
arch_flush_lazy_mmu_mode() I mentioned below. IMHO that looks pretty
obfuscated though - the casual reader will wonder why we're creating a
lazy MMU section for setting just one PTE. If we go down this route, I'd
argue the explicit call to arch_flush_lazy_mmu_mode() is clearer (and
our implementation is safe to call even outside of a lazy MMU section).

- Kevin

>> An alternative approach that addresses your point about layer violation
>> is to call arch_flush_lazy_mmu_mode() and leave the __set_pte() call
>> unchanged. This is slightly slower as we still end up setting/clearing
>> the TIF flag in that case. Not sure this is worth it - ultimately we
>> have to be mindful of what lazy MMU mode is doing to ensure this code is
>> correct. I'm happy with the current approach.
>>
>> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
>>
>> - Kevin
>>
>> [1] https://lore.kernel.org/r/20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com
