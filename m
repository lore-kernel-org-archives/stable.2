Received: from mta1.migadu.com (out-141.mta1.migadu.com [95.215.58.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D71239E6C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788959308; cv=none; b=qnd6Nt9jukeZq/964Olmvgy/nXLBt6+Ijco6wVOSQv7TAnBtx+8KIzYN8KcOLrRkQ95nlle+uBupBRcuOFqQddmr16t5O5NyHx9ME4MsJ5uPckHJmJNkKXa5zOPRtF56BkiuI1y4RR1D6cHxq3wglG+ch+1GkowZVZ7YdGIKuaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788959308; c=relaxed/simple;
	bh=VhlFjNAgQI2Jtqxdp11XUFniGZMKsYGwyqeIsjbkGdA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AfeazdvtNKWTKvDfx+IpjmeSTxugdW3cVhHGWqUuNiFQFbVojmqd9aQIR8HSZG+jiMieuNcOsGZYugY0xG6/DfX1sLw/euVOvebQzkN5+fXq8sGUluuv+xIA1ddelZvcvLaaDoPVcVw79mikf7iU7ojkj4Ol0q290gnuiKLEy/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SqpWv98C; arc=none smtp.client-ip=95.215.58.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SqpWv98C"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VhlFjNAgQI2Jtqxdp11XUFniGZMKsYGwyqeIsjbkGdA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788959301; v=1; x=1789564101;
 b=SqpWv98C61R76bJ0zUrMa/dUYoDYli14Cu7Sz2NGtXopPX3r0MU39mdYsfsxVAcN0nIXkHZB
 iDpYgU6xxC+1nMXUk9M4EJPCHIPpCUSVYrqxdZ4RPhIqRh0+meNClDCpRd33JuUrmJn0ZAzk0IJ
 KsweRhAgxCuHVDoM9FQKa/ME=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 25b253702b94a6c9;
	Wed, 09 Sep 2026 13:08:21 +0000
X-Mizu-Trace-ID: 25b253702b94a6c9
X-Migadu-Flow: FLOW_OUT
Message-ID: <7dbba23e-5530-43c4-9c44-20108cd0cef5@linux.dev>
Date: Wed, 9 Sep 2026 21:08:09 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/4] module: introduce SH_ENTSIZE_STANDALONE for
 separately allocated sections
From: Hao Ge <hao.ge@linux.dev>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20260908092412.115953-1-hao.ge@linux.dev>
 <20260908092412.115953-4-hao.ge@linux.dev>
 <76b5edbb-8231-41d0-9e7b-f965af13c324@suse.com>
 <ec3f14f0-cebe-460f-9df7-537f49d70afd@linux.dev>
Content-Language: en-US
In-Reply-To: <ec3f14f0-cebe-460f-9df7-537f49d70afd@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/9/26 20:47, Hao Ge wrote:
> Hi Petr
>
>
> On 9/9/26 19:30, Petr Pavlu wrote:
>> On 9/8/26 11:24 AM, Hao Ge wrote:
>>> SHF_ALLOC means, per the ELF spec, that a section occupies memory
>>> during process execution. Some module sections occupy memory
>>> outside the regular module layout, for example the percpu section
>>> with its per-CPU allocations. The loader currently excludes such
>>> a section from the layout by clearing its SHF_ALLOC, which
>>> overloads the flag with a loader-internal meaning.
>>> apply_relocations() needs a special case for the section, and
>>> find_sec(".data..percpu") returns different results before and
>>> after layout_and_allocate().
>>>
>>> Introduce SH_ENTSIZE_STANDALONE to mark sections with a separate
>>> allocation. The percpu section is its first user. layout_sections()
>>> and move_module() skip marked sections, and apply_relocations() goes
>>> back to testing only SHF_ALLOC. Based on a patch by Petr Pavlu [1].
>>>
>>> .data..percpu keeps SHF_ALLOC, so it would now show up under
>>> /sys/module/*/sections/. The section has one instance per CPU and no
>>> single address to report, and the entry never existed before, so
>>> skip it in add_sect_attrs(). add_notes_attrs() indexes its attrs[]
>>> array and skips it too. No functional change otherwise.
>>>
>>> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag 
>>> compression")
>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>> Link: 
>>> https://lore.kernel.org/all/499bb60c-c6e3-43a3-bd92-95a0567ece5e@suse.com/ 
>>> [1]
>>> Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>>> ---
>>> [...]
>>> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
>>> index 0fc11e45df9b..49190deae61e 100644
>>> --- a/kernel/module/kallsyms.c
>>> +++ b/kernel/module/kallsyms.c
>>> @@ -76,7 +76,7 @@ static char elf_type(const Elf_Sym *sym, const 
>>> struct load_info *info)
>>>   }
>>>     static bool is_core_symbol(const Elf_Sym *src, const Elf_Shdr 
>>> *sechdrs,
>>> -               unsigned int shnum, unsigned int pcpundx)
>>> +               unsigned int shnum)
>>>   {
>>>       const Elf_Shdr *sec;
>>>       enum mod_mem_type type;
>>> @@ -86,11 +86,6 @@ static bool is_core_symbol(const Elf_Sym *src, 
>>> const Elf_Shdr *sechdrs,
>>>           !src->st_name)
>>>           return false;
>>>   -#ifdef CONFIG_KALLSYMS_ALL
>>> -    if (src->st_shndx == pcpundx)
>>> -        return true;
>>> -#endif
>>> -
>>>       sec = sechdrs + src->st_shndx;
>>>       type = sec->sh_entsize >> SH_ENTSIZE_TYPE_SHIFT;
>>>       if (!(sec->sh_flags & SHF_ALLOC)
>>> @@ -131,8 +126,7 @@ void layout_symtab(struct module *mod, struct 
>>> load_info *info)
>>>       /* Compute total space required for the core symbols' strtab. */
>>>       for (ndst = i = 0; i < nsrc; i++) {
>>>           if (i == 0 || is_livepatch_module(mod) ||
>>> -            is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
>>> -                   info->index.pcpu)) {
>>> +            is_core_symbol(src + i, info->sechdrs, 
>>> info->hdr->e_shnum)) {
>>>               strtab_size += strlen(&info->strtab[src[i].st_name]) + 1;
>>>               ndst++;
>>>           }
>>> @@ -199,8 +193,7 @@ void add_kallsyms(struct module *mod, const 
>>> struct load_info *info)
>>>       for (ndst = i = 0; i < kallsyms->num_symtab; i++) {
>>>           kallsyms->typetab[i] = elf_type(src + i, info);
>>>           if (i == 0 || is_livepatch_module(mod) ||
>>> -            is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
>>> -                   info->index.pcpu)) {
>>> +            is_core_symbol(src + i, info->sechdrs, 
>>> info->hdr->e_shnum)) {
>>>               ssize_t ret;
>>>                 mod->core_kallsyms.typetab[ndst] =
>> FTR These changes in kernel/module/kallsyms.c have a conflict with the
>> series "Ignore local labels and mapping symbols during module load" [1],
>> which is currently queued on modules-next, but it should be
>> straightforward to resolve.
>>
>>> diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
>>> index 01c65d608873..f64170344e69 100644
>>> --- a/kernel/module/sysfs.c
>>> +++ b/kernel/module/sysfs.c
>>> @@ -62,6 +62,15 @@ static void free_sect_attrs(struct 
>>> module_sect_attrs *sect_attrs)
>>>       kfree(sect_attrs);
>>>   }
>>>   +/*
>>> + * .data..percpu has a separate allocation per CPU and no single
>>> + * address to report.
>>> + */
>>> +static bool sect_visible(const struct load_info *info, unsigned int i)
>>> +{
>>> +    return !sect_empty(&info->sechdrs[i]) && i != info->index.pcpu;
>>> +}
>>> +
>>>   static int add_sect_attrs(struct module *mod, const struct 
>>> load_info *info)
>>>   {
>>>       struct module_sect_attrs *sect_attrs;
>>> @@ -72,7 +81,7 @@ static int add_sect_attrs(struct module *mod, 
>>> const struct load_info *info)
>>>         /* Count loaded sections and allocate structures */
>>>       for (i = 0; i < info->hdr->e_shnum; i++)
>>> -        if (!sect_empty(&info->sechdrs[i]))
>>> +        if (sect_visible(info, i))
>>>               nloaded++;
>>>       sect_attrs = kzalloc_flex(*sect_attrs, attrs, nloaded);
>>>       if (!sect_attrs)
>>> @@ -92,7 +101,7 @@ static int add_sect_attrs(struct module *mod, 
>>> const struct load_info *info)
>>>       for (i = 0; i < info->hdr->e_shnum; i++) {
>>>           Elf_Shdr *sec = &info->sechdrs[i];
>>>   -        if (sect_empty(sec))
>>> +        if (!sect_visible(info, i))
>>>               continue;
>>>           sysfs_bin_attr_init(sattr);
>>>           sattr->attr.name =
>>> @@ -181,7 +190,7 @@ static int add_notes_attrs(struct module *mod, 
>>> const struct load_info *info)
>>>         nattr = &notes_attrs->attrs[0];
>>>       for (loaded = i = 0; i < info->hdr->e_shnum; ++i) {
>>> -        if (sect_empty(&info->sechdrs[i]))
>>> +        if (!sect_visible(info, i))
>>>               continue;
>>>           if (info->sechdrs[i].sh_type == SHT_NOTE) {
>>>               sysfs_bin_attr_init(nattr);
>> add_notes_attrs() has two sect_empty() calls. Both should be changed to
>> sect_visible().
>
>
> I kept this part unmodified to preserve the loop's original intent.
>
> This loop counts SHT_NOTE sections.
>
> SHT_NOTE refers to ELF note sections, which hold non-executable
>
> metadata such as build ID and ABI info.
>
> I wonder if we could keep the current implementation.
>
> As noted in the comment above, the top part counts SHT_NOTE sections
>
> and allocates structures, while the lower logic handles control of 
> node attributes.
>
>
> WDYT?
>
>

Sorry, I've reconsidered this. I think changing it to sect_visible would 
be better.

sect_visible stands for the count of externally visible note attributes, 
so the code

above and below can align with each other.


Sorry for the noise.


I'll rebase onto modules-next, apply this change and push a new revision.

I'll also add your Reviewed-by tag.


Thanks

Best Regards

Hao


> Thanks
>
> Best Regards
>
> Hao
>
>>
>> With this fixed, the patch looks ok to me. Feel free to add:
>>
>> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
>>
>> [1] 
>> https://lore.kernel.org/linux-modules/20260820125007.22943-1-yangtiezhu@loongson.cn/
>>
