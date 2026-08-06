Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E12940DB5C
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 08:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786005394; cv=none; b=pBUNX2tiQ+s6K7uyaqbAyPm/fzrg4ho8gLWMES2F/VESBrzvS1BdOM3t32SweyEqy3f1vL/rEYdtmTGpIcyIpOvpC1zPRC6kxYS08WhBF7jLtCDBmBobLrbcnn2VdIkTVd3XAbe1ovL5dkE6trgUjuMSTbkYSnt/jQQC2H7Icbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786005394; c=relaxed/simple;
	bh=D+Nh7Nv/98LpDmCKn0wdcFPwsrvWJlwNYT769oVgdco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DsZPzqGX9h60oT0gYNDu5yskHVY2p04nkwQMs2EcHm/u/2YGMvkJE6cEQAxeDq5hQra+C/FXq8d64WiZkXHSmoNaRg/bkNe4RRrNw9z7cgyD1ofAMttXSUwRp4QqPe0D0GXzzT2+ye/5l2Bs98o/CQFB7XPaErl8kvtakqZMikY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VW9Y4Eh3; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VW9Y4Eh3"
Message-ID: <e96d8a13-8f9a-49f4-ae4c-a14c6de5ae66@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786005378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqP6xIom5z/JgiZxChLOxSoV7HfcbtYKbXpcpVaVwyc=;
	b=VW9Y4Eh30Usq0AUvRj8F7W5tWArsdtGcXuE4NlQ/gwarc4Ss1n/U9lWUWMW/mV6adBM/mA
	xZId21sQz4oBvADexAu6EenYmDG1syopmi+C737znb0+epHUVAaAbW9ffH9HqnUn8sReju
	WOFWQ9kNfPunFLYqXgIh7C2Ea60N6OM=
Date: Thu, 6 Aug 2026 16:35:49 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] alloc_tag: fix undetected compressed tag overflow when
 profiling is disabled
To: Suren Baghdasaryan <surenb@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Abhishek Bapat <abhishekbapat@google.com>, stable@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
References: <20260805090633.141001-1-hao.ge@linux.dev>
 <20260805095505.1c2cbc150441cb20a74ba9bb@linux-foundation.org>
 <CAJuCfpG_XX-Hwy=TCrJ+g6yiMxGXLB=LvnPN_WLP3WQktNZMbA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpG_XX-Hwy=TCrJ+g6yiMxGXLB=LvnPN_WLP3WQktNZMbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Suren


On 2026/8/6 01:47, Suren Baghdasaryan wrote:
> On Wed, Aug 5, 2026 at 9:55 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Wed,  5 Aug 2026 17:06:33 +0800 Hao Ge <hao.ge@linux.dev> wrote:
>>
>>> In reserve_module_tags(), the tag overflow check is gated on
>>> mem_alloc_profiling_enabled():
>>>
>>>      if (mem_alloc_profiling_enabled() && !tags_addressable())
>>>
>>> If profiling is toggled off at runtime and a module is loaded whose
>>> tags exceed the compressed-mode limit, shutdown_mem_profiling() is
>>> skipped. vm_module_tags_populate() still maps memory for the tags and
>>> the module loads successfully, but the total tag count now exceeds what
>>> NR_UNUSED_PAGEFLAG_BITS can address.
>>>
>>> Once profiling is re-enabled, ref_to_idx() computes each tag's index
>>> as its position in the alloc_tag array. update_page_tag_ref() masks
>>> it to alloc_tag_ref_mask before storing in page->flags. Indices
>>> beyond the mask are truncated and idx_to_ref() resolves them to wrong
>>> tags.
>>>
>>> This silently corrupts /proc/allocinfo: allocated pages get attributed
>>> to the wrong call sites, so the statistics it reports are wrong.
>>>
>>> mem_alloc_profiling_enabled() and mem_profiling_compressed are
>>> independent. Once compressed mode is established at boot, it stays
>>> active regardless of runtime toggles of mem_profiling.
>>>
>>> Remove the mem_alloc_profiling_enabled() guard. Also return an error
>>> after shutdown_mem_profiling() to skip vm_module_tags_populate(), as
>>> the mapped pages would never be reused - shutdown_mem_profiling() sets
>>> mem_profiling_support to false, so no future module load enters the
>>> codetag path.
>>
>> Thanks.
>>
>> AI review points at a cpuple of possible things, one pre-existing:
>>          https://sashiko.dev/#/patchset/20260805090633.141001-1-hao.ge@linux.dev
> 
> Yes, pre-existing issue can be handled separately, it's not directly
> related to this change.
> 
>>
>> "Does this unintentionally result in a denial of service for module
>> loading, preventing critical drivers from loading when they otherwise
>> could have just disabled profiling and gracefully continued?" sounds
>> pretty obscure and I doubt if we care?
> 
> Hmm, I think Hao considered that in his previous version

Yes, I did look into this.

but now I'm
> thinking we might be able to handle this more gracefully and not fail
> the module loading. When profiling is disabled
> codetag_needs_module_section() returns false here:
> https://elixir.bootlin.com/linux/v7.1.5/source/kernel/module/main.c#L2822,
> so if we had to disable profiling, we could return NULL instead of
> ENOMEM and change the condition here:
> https://elixir.bootlin.com/linux/v7.1.5/source/kernel/module/main.c#L2825
> to act as if codetag_needs_module_section() was false from the
> beginning. IOW code at
> https://elixir.bootlin.com/linux/v7.1.5/source/kernel/module/main.c#L2822
> becomes:
> 
> if (codetag_needs_module_section(mod, sname, shdr->sh_size) &&
>      (dest = codetag_alloc_module_section(mod, sname, shdr->sh_size,
>        arch_mod_section_prepend(mod, i), shdr->sh_addralign)) != NULL) {
> ...

The primary blocker is __layout_sections.

https://elixir.bootlin.com/linux/v7.1.5/source/kernel/module/main.c#L1730

This is because __layout_sections controls whether we reserve space for 
the codetag section inside EXECMEM_MODULE_DATA, the same way we handle 
regular sections.

When codetag_needs_module_section() returns true during layout, 
module_get_offset_and_type() is skipped, so sh_entsize only gets the 
type bits with offset = 0 - no space is reserved.

If we bail out with NULL when compressed tags overflow and add a dest != 
NULL check here, we'll end up hitting the later else block.

if (codetag_needs_module_section(mod, sname, shdr->sh_size) &&
     (dest = codetag_alloc_module_section(mod, sname, shdr->sh_size, 
arch_mod_section_prepend(mod, i), shdr->sh_addralign)) != NULL) {
	......
} else {
	enum mod_mem_type type = shdr->sh_entsize  >> SH_ENTSIZE_TYPE_SHIFT;
	unsigned long offset = shdr->sh_entsize  & SH_ENTSIZE_OFFSET_MASK;
	dest = mod->mem[type].base + offset;
}

That'll cause the following memcpy to clobber the leading data.

If we really need to fix this, we can use dest's return value, with a 
check like:
if (codetag_needs_module_section(mod, sname, shdr->sh_size)) {
	dest = codetag_alloc_module_section(mod, sname, shdr->sh_size,
		arch_mod_section_prepend(mod, i), shdr->sh_addralign);
	if ( dest == sentinel_val )
		continue;

But that would also mean extra work on our end - for instance, we’d need 
to stop the per-cpu allocations inside codetag_load_module.

https://elixir.bootlin.com/linux/v7.1.5/source/kernel/module/main.c#L3571

Could there be a simpler solution for this?

Thanks
Best Regards

Hao

> 
> I think this would result in a better handling of this situation: if
> we can't fit the tags anymore, we issue a warning, disable profiling
> but continue loading the module. Hao, WDYT?






