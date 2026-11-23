Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795460084;
	b=jL9iR0eQGO+amFQy5NuG9MakXZ5k55skkJCzwqwyRdZWUjJdFHU2kMGO/pJprbnMSW1n
	 4nDIFiqtae2Bv87Xel3qatezDNWG7BFjJUYvTIrYlylWorl1gauvXtcrM2GujBnQq1+Od
	 YlazPPd98MkY+0jj+u4riaeSL3Ikkq9dpRzY2Gtc+N1qVJEAS+1JxMBe/f6xFcxs7rgys
	 fIhAwcmsrebSDNRsoS5TEhT61rsLz5jCHYeFQowvHx3Zh+HRLeatpMsaveMyIxlmbSnt4
	 e6hC5wuIKUHIjY3uWt8Z87nV3QdyAdkzN8Th0yt2ZPhPmEZ5xQHsbKOkgRzdldTkYuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460084;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=4hKfDKhS/y0v7LwYfVdwmNntrIbkTnTWq8HGysu213g=;
	b=gikTOJ68wjxh3i82HL4yfSRXyD9FXR8EDLY/T67ZQ4bh0rFNDnFFGc/BVXtjQhomJSut
	 v9TfscTEpJ7onOPCY6Sfu8Qp2puLavxcN+Wmqyh2TqsoskQEYaOWoXQYwPS6sV4NTGCwg
	 DGnjdU+5guZfYpHs3YF9nJH0wyyo3Lb3GdMnwaV3aMM7gppXJja/PZmcuMGDss9rMT0Af
	 nok2Q/k3gQM3SdNgXQh7gr1KbGybQGsrYCo7+W6i7O4OnAaF1p0syy+JBGWQkB55AO1Kw
	 7W7H8qkWu3ae97+IbcewcRK9x99l82QmT2Hrz0JXc2mLB73VQTQe0vc9f67lEJhpGvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DpOMEAqL;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20C2606A31A;
	Mon, 23 Nov 2026 18:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D20C2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DpOMEAqL
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 196F7143D;
	Mon, 23 Nov 2026 10:54:40 -0800 (PST)
Received: from [10.57.91.245] (unknown [10.57.91.245])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF2003F763;
	Mon, 23 Nov 2026 10:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795460082; bh=KBj2RreVlKeNnFDTM1L6+3NBD7uGNn8uIi6vqvj5hOc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DpOMEAqLprlXADevvML5TdqeEd1ZjIXSfm3e8eAMLiVg31HW93XTJMwDlVRLK6yBQ
	 szl/Px0I/yh7C98FfCLq38MVoUWyuPfLWLOCjmXeZ5+LPiwcedW4xjd3t0oHgc3jWs
	 v923uc/ClVoNwttizcJzuNR/My8eAzGiuKw17Z7g=
Message-ID: <74b99755-bc3d-4cad-9678-c2de740fe20a@arm.com>
Date: Mon, 23 Nov 2026 18:54:39 +0000
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
From: Ryan Roberts <ryan.roberts@arm.com>
Content-Language: en-GB
In-Reply-To: <f543aea2-3a21-44ce-bb44-c84bd66b0a76@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/11/2026 13:08, Kevin Brodsky wrote:
> On 23/11/2026 11:36, Ryan Roberts wrote:
>>>
>>>>> @@ -127,7 +127,9 @@ void __set_fixmap(enum fixed_addresses idx,
>>>>>          ptep = fixmap_pte(addr);
>>>>>
>>>>>          if (pgprot_val(flags)) {
>>>>> -                __set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
>>>>> +                /* The slot must be usable on return, even in lazy MMU mode. */
>>>>> +                __set_pte_nosync(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
>>>>> +                emit_pte_barriers();
>>>> I wonder if it would be clearer to wrap __set_ptes():
>>>>
>>>> lazy_mmu_mode_pause()
>>>> __set_ptes()
>>>> lazy_mmu_mode_resume()
>>> That would work. However, there's the stable backport. 6.18 has the
>>> bug, but lazy_mmu_mode_pause() was added in 7.0, so 6.18.y would need
>>> its own patch. This patch applies to 6.18 unchanged.
>>>
>>> I'm happy with either, or with a followup patch in the same series.
>> I'd personally prefer to use pause/resume since it's makes it very clear what's
>> going on and avoids the layer violation. Perhaps your approach as the back
>> portable one, then pause/resume as follow up (along with ptep_try_set() tidy
>> up)? Others might think differently though...
> 
> Using pause/resume does work, but it is a bigger hammer than necessary.
> If other features make use of lazy MMU mode, then we may end up paying
> extra cost by leaving/re-entering the mode.
> 
> For instance, with page table hardening [1], using the pause/resume
> approach means 4 extra ISBs:
> - 1 when pause() leaves lazy MMU mode: restoring default kpkeys context
> - 2 in __set_pte(): switching to page table update kpkeys context, and
> then back to default
> - 1 when resume() enters lazy MMU mode: entering page table update
> kpkeys context
> 
> An explicit __set_pte_nosync() + emit_pte_barriers() achieves exactly
> what we're after (immediately visible PTE update) and doesn't disrupt
> lazy MMU mode - we don't unnecessarily set TIF_LAZY_MMU_PENDING. 

It's so ugly to spill this stuff everywhere though.

How about a nested lazy mmu section?

lazy_mmu_mode_enable()
__set_ptes()
lazy_mmu_mode_disable()

If it's nested the enable() is essentially nop, and the disable is a flush,
which emits the barriers. If it's the first enable, we still set
TIF_LAZY_MMU_PENDING though...

> 
> An alternative approach that addresses your point about layer violation
> is to call arch_flush_lazy_mmu_mode() and leave the __set_pte() call
> unchanged. This is slightly slower as we still end up setting/clearing
> the TIF flag in that case. Not sure this is worth it - ultimately we
> have to be mindful of what lazy MMU mode is doing to ensure this code is
> correct. I'm happy with the current approach.
> 
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> 
> - Kevin
> 
> [1] https://lore.kernel.org/r/20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com

