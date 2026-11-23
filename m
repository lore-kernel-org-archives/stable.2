Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795430213;
	b=XHqV5VHXACkOfM1mTBM/jbphqR/uhgJlzjz3FRHzrnpqRMZg4/U19SDbnxyc1Uuhh+6Z
	 Gx3BQcDOQFiISNpYjB1L3EKlJ8N0otyjxVy6iEA/zZjzf8V/rNnYzKZ786pxgDn4wNJzP
	 e61fHiLqN7jeFYVmP6frDvTO50tyiO3ie5J4AtfXmxD6dL53Fw9kBw/E9AtUHq1hKr3kT
	 oSWzFY322wjRf3Byk2WT4jUn9Fs0+DfIWrWfM5T/cBeOyRsZeIiTowOIA/kVX5Nmz9884
	 2k7V6+nVgRVpEViiPuTq4xuPQXkVTfaJlduk8B44ASDNutY/J62o3CVkCryy/WsPWpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795430213;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=uDIyL8csS0OafYWL+DTmNWGdhbsOuiWOQJkObodqJlE=;
	b=0g4d5LFxy+mTJx5+onRRiplcvYN8wu1csUrnGn4+doGdqs1TlfaZXemzE8whJXOvlesk
	 QT/gPoAwTXPOGkTKo/ng1UnN/aMhMZ+09q7tDarPo90zHXXF0e+5XoZBbznBxcatpBpqr
	 H1sKd63s3lOOtlPiwdTIMZCJKbAHewvfoKO6IUyoJqqEiyoywPUrpdAZdmOdFazO8Q+kf
	 jNPqH97HyOO2w0W/w/KAncfamC0StB4hu8y85bbBb/NYk8sthnCCom5SfNGxAg8+4fEIH
	 MClnB/956wo82fcktita7koZS2Uxgf+S71cF2KAiZ9y+wNfg8ZOBon5l8HTQMXnXfUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=pkO3cxgd;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37113606A31E;
	Mon, 23 Nov 2026 10:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37113606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=pkO3cxgd
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62F0A143D;
	Mon, 23 Nov 2026 02:36:49 -0800 (PST)
Received: from [10.57.91.245] (unknown [10.57.91.245])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25D723F632;
	Mon, 23 Nov 2026 02:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795430212; bh=zxMgJ0Zod2wpdsyWepEtw4oVnjAoyPgBY3VWNAhnP7M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pkO3cxgdC1Ma9566c7PDIZgUyDTw/GTPNKPYUHG2BR63OXTEzzEQs+CraFnUg2myV
	 5AIDh+wbSitzPRL3+3WA0saItk2Mgsq01o/7l++5BdhZ2n1FKd8uE58qHfkf3GUHTD
	 ozS0U8gq/7uNSrzNX6QhEEhYJr4uc0eTMD/zGtko=
Message-ID: <5b0a26ee-30b0-4a79-9cca-9848dc9d65c5@arm.com>
Date: Mon, 23 Nov 2026 10:36:48 +0000
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
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Yang Shi <yang@os.amperecomputing.com>, Kevin Brodsky
 <kevin.brodsky@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261120121638.194154-1-fuad.tabba@linux.dev>
 <20261120121638.194154-4-fuad.tabba@linux.dev>
 <6782b5ee-3dfe-4076-a79c-fbeb2c2ac7da@arm.com>
 <CA+EHjTziXrRdR+guikKbj93Az96T+AMx_=0sVeyWG5C4fwaaTg@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
Content-Language: en-GB
In-Reply-To: <CA+EHjTziXrRdR+guikKbj93Az96T+AMx_=0sVeyWG5C4fwaaTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/11/2026 07:35, Fuad Tabba wrote:
> Hi Ryan,
> 
> On Sat, 21 Nov 2026 11:01:49 +0000, Ryan Roberts <ryan.roberts@arm.com> wrote:
> [...]
>>> kernel then warns about a spurious translation fault. When kgdb stops a
>>> CPU in lazy MMU mode, its breakpoint writes through FIX_TEXT_POKE0 can
>>> fault the same way, and fail.
>>>
>>> Emit the barriers directly in __set_fixmap().
>>>
>>> Fixes: 5fdd05efa1cd3 ("arm64/mm: Batch barriers when updating kernel mappings")
>>
>> My memory might be betraying me, but I think this change went in before BBML3
>> (BBML2_NOABORT)? In which case, the bug is only exposed by the latter series?
> 
> It did, and the set_swapper_pgd() path is only exposed by the later
> series. The tag is for the kgdb path, which doesn't depend on BBML3.
> When kgdb is entered from a breakpoint in process context,
> in_interrupt() is false, so in lazy MMU mode the barriers for its
> FIX_TEXT_POKE0 mapping are still deferred.

ACK

> 
> [...]
>>> diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
> [...]
>>> @@ -127,7 +127,9 @@ void __set_fixmap(enum fixed_addresses idx,
>>>          ptep = fixmap_pte(addr);
>>>
>>>          if (pgprot_val(flags)) {
>>> -                __set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
>>> +                /* The slot must be usable on return, even in lazy MMU mode. */
>>> +                __set_pte_nosync(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
>>> +                emit_pte_barriers();
>>
>> I wonder if it would be clearer to wrap __set_ptes():
>>
>> lazy_mmu_mode_pause()
>> __set_ptes()
>> lazy_mmu_mode_resume()
> 
> That would work. However, there's the stable backport. 6.18 has the
> bug, but lazy_mmu_mode_pause() was added in 7.0, so 6.18.y would need
> its own patch. This patch applies to 6.18 unchanged.
> 
> I'm happy with either, or with a followup patch in the same series.

I'd personally prefer to use pause/resume since it's makes it very clear what's
going on and avoids the layer violation. Perhaps your approach as the back
portable one, then pause/resume as follow up (along with ptep_try_set() tidy
up)? Others might think differently though...

Regardless:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> 
> Cheers,
> /fuad

