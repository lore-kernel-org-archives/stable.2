Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B80563FD6
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962283; cv=none; b=uMjbXrdpIH/Yi5lyA+eKopHeap02TdyI9F5S2Cdsf7n7sdVrwzQbpjvWOSru1mL+sAx8iKMyvK1FUlCFq9r9yrp4Dyzufe0EMG6uGSSfDIEplyL5OKrzJZUOPc+elWwFv7CXGagbh03wUNbEbaoKiRWU6jBaeIJ5wLJEyqpP1eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962283; c=relaxed/simple;
	bh=MmOEf0Y78rR1tMkddC4OuotKqVBFJ6fwGa+NFgTsabw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JstCjsFBqclwjwMSCOunIPofwS9zCFVT3e/ytIpU+tla92hb7LssBZyShcjhpmOZ/eLdACXqlrb5kcEWHLDXB9wMwoRSCMrxihQXdgSZTwUa68uNKEnpxzmy+LcJeu7zxLksFAQhcrakAQdGNNvpJLGL6t7dxSjq+qVp/Gsxroo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PJnqHc63; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PJnqHc63"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4956869750eso52268655e9.2
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 06:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788962278; x=1789567078; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZDzlPxqZjAat9RI0uZbVqWCVCniwXqMbYrmH3owuOfY=;
        b=PJnqHc63ufGoBQoIVsG9iKDHI8iqnNwiLGXCninY8Mo2K2R8gpzgWp67p4IsXUIZYu
         wvKHBWuxn58yvOSvR6LyswYxseIELCrj8euu7mbp8N0Cg6nwIhDhyzKOlDK4vhDGx6DZ
         JdaZsuLseXczlks5SmWbI02MMRWqtX2XDoe2/wXxiMor8N1sNSzL09PE2IlZgM+kCPSm
         HT0JNw5PjHn8eBHuzFSNfaYlMsXk73tOVUqhIv/SwSZh+3fTEhx/Rt4YE2DNSkZilA1E
         Mlfxlk3Fs/dtVV/pU8zszzJxde3dwOiV7dawj+s3IG10D94KooCLSg64n3O4gku94Raq
         PfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788962278; x=1789567078;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZDzlPxqZjAat9RI0uZbVqWCVCniwXqMbYrmH3owuOfY=;
        b=lZoxt2arLASbsgWlG99QYu/2dKFk3uiPZoT8trQDI/uwR1KiaHvZYmfZqSpD7rCTKP
         j6kr67EN7G52pfJvwW60bHm2ScbFqPgk6u/E6H3WXaqyyvDpI361xPkCbXYGMaejQghL
         uMnIDz3dOpaRleNaBFkQ4hjL07hg63aeN3lr7TXc4lkKCAn0UJVPOs0fHYPGyLvR3cZ8
         KSZXkifVSOQEiGH1KgmSQjvhW+6AJPh2JD3kS/DF7GTpnK+S2e6S1gbP/o5RWVdjkn5F
         GlnmuWQPn9NtbaFZvn1B6c0fOVGYHFfGFNFmNKk0sURyRSUDpKuX2ZOO1bK0S0RR2BKb
         SDQw==
X-Forwarded-Encrypted: i=1; AKwUvBzEjvOvCL0bvSs4xnC3LQXtVJWxpp8hyAatDbbQsa2pBQ3riPgxDseh9pYuzKvLaD0dxEI0XA8=@vger.kernel.org
X-Gm-Message-State: AFuF++l7dAc2KTxLP7LwjaJ/C1kEc2B220ln1IG+Xme31OtOYcxopTHe
	g+UpbL+cbBvh0rFEStbXszjpnwzxYDvVpFgknLluvDFzIqS7ODaiPA0s6J5ZQzuaVc8=
X-Gm-Gg: AYBFou1/xkUMn0lzbqkEyh1G2YP978hW0nCOY61JR8gtrYmqsyV+gRGmPeN5lKWMr+I
	+6zwyK6lZEuq+VU3wV7nrRQdUKExiKWiBL7ym+yBS5yyb+HM/xFwTmEetiwyyRZK2dPfCyPNyb+
	0U3MIPfMEoA/Qqx3EgA8h8RXzwx5fHf2qP0wVRpBLP8M2sjBLZrN+M9vrb4UipTBvA4HFsMpfRZ
	gWdBv+kQLZDzlEGiHq5nb8yw9k2OrYU6dOxgg9dM+Oq0rm0vcSCRxqnTlEZj7PAeQjfwUw5CiCa
	/aMUDDatdG9G/oEA0ZEzeQK3zvBKG3VZt7FIfC6DpQIcqySXkWt4Cnnt5oo2k5TS4+krL7nHfe2
	Ezp9MTIewGolHS3aIzhwBFRtupWn7w/DTX5WHq0Ui2Abuku5vKdhj2Qe6c0EBmm+CRmdDEy/Db9
	dKp/wSIrOnuuEUyoJb1SPmcp7GShDca9rkShuEh6RpMssq9CAUAB/rVKUeB+1KnKcxze3U5sSMe
	AfnPmFCMyYTEZ7EMV3IkhyXSmi6w31comc=
X-Received: by 2002:a05:600c:5247:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-49cf81dadcamr328595095e9.2.1788962277576;
        Wed, 09 Sep 2026 06:57:57 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7736132sm466320805e9.12.2026.09.09.06.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 06:57:56 -0700 (PDT)
Message-ID: <3bd2f451-cbe4-4ef4-a552-81ea227fb15b@suse.com>
Date: Wed, 9 Sep 2026 15:57:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/4] module: introduce SH_ENTSIZE_STANDALONE for
 separately allocated sections
To: Hao Ge <hao.ge@linux.dev>
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
 <7dbba23e-5530-43c4-9c44-20108cd0cef5@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <7dbba23e-5530-43c4-9c44-20108cd0cef5@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/26 3:08 PM, Hao Ge wrote:
> On 9/9/26 20:47, Hao Ge wrote:
>> On 9/9/26 19:30, Petr Pavlu wrote:
>>> On 9/8/26 11:24 AM, Hao Ge wrote:
>>>> SHF_ALLOC means, per the ELF spec, that a section occupies memory
>>>> during process execution. Some module sections occupy memory
>>>> outside the regular module layout, for example the percpu section
>>>> with its per-CPU allocations. The loader currently excludes such
>>>> a section from the layout by clearing its SHF_ALLOC, which
>>>> overloads the flag with a loader-internal meaning.
>>>> apply_relocations() needs a special case for the section, and
>>>> find_sec(".data..percpu") returns different results before and
>>>> after layout_and_allocate().
>>>>
>>>> Introduce SH_ENTSIZE_STANDALONE to mark sections with a separate
>>>> allocation. The percpu section is its first user. layout_sections()
>>>> and move_module() skip marked sections, and apply_relocations() goes
>>>> back to testing only SHF_ALLOC. Based on a patch by Petr Pavlu [1].
>>>>
>>>> .data..percpu keeps SHF_ALLOC, so it would now show up under
>>>> /sys/module/*/sections/. The section has one instance per CPU and no
>>>> single address to report, and the entry never existed before, so
>>>> skip it in add_sect_attrs(). add_notes_attrs() indexes its attrs[]
>>>> array and skips it too. No functional change otherwise.
>>>>
>>>> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
>>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>>> Link: https://lore.kernel.org/all/499bb60c-c6e3-43a3-bd92-95a0567ece5e@suse.com/ [1]
>>>> Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>>>> ---
>>>> [...]
>>>> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
>>>> index 0fc11e45df9b..49190deae61e 100644
>>>> --- a/kernel/module/kallsyms.c
>>>> +++ b/kernel/module/kallsyms.c
>>>> @@ -76,7 +76,7 @@ static char elf_type(const Elf_Sym *sym, const struct load_info *info)
>>>>   }
>>>>     static bool is_core_symbol(const Elf_Sym *src, const Elf_Shdr *sechdrs,
>>>> -               unsigned int shnum, unsigned int pcpundx)
>>>> +               unsigned int shnum)
>>>>   {
>>>>       const Elf_Shdr *sec;
>>>>       enum mod_mem_type type;
>>>> @@ -86,11 +86,6 @@ static bool is_core_symbol(const Elf_Sym *src, const Elf_Shdr *sechdrs,
>>>>           !src->st_name)
>>>>           return false;
>>>>   -#ifdef CONFIG_KALLSYMS_ALL
>>>> -    if (src->st_shndx == pcpundx)
>>>> -        return true;
>>>> -#endif
>>>> -
>>>>       sec = sechdrs + src->st_shndx;
>>>>       type = sec->sh_entsize >> SH_ENTSIZE_TYPE_SHIFT;
>>>>       if (!(sec->sh_flags & SHF_ALLOC)
>>>> @@ -131,8 +126,7 @@ void layout_symtab(struct module *mod, struct load_info *info)
>>>>       /* Compute total space required for the core symbols' strtab. */
>>>>       for (ndst = i = 0; i < nsrc; i++) {
>>>>           if (i == 0 || is_livepatch_module(mod) ||
>>>> -            is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
>>>> -                   info->index.pcpu)) {
>>>> +            is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum)) {
>>>>               strtab_size += strlen(&info->strtab[src[i].st_name]) + 1;
>>>>               ndst++;
>>>>           }
>>>> @@ -199,8 +193,7 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
>>>>       for (ndst = i = 0; i < kallsyms->num_symtab; i++) {
>>>>           kallsyms->typetab[i] = elf_type(src + i, info);
>>>>           if (i == 0 || is_livepatch_module(mod) ||
>>>> -            is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
>>>> -                   info->index.pcpu)) {
>>>> +            is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum)) {
>>>>               ssize_t ret;
>>>>                 mod->core_kallsyms.typetab[ndst] =
>>> FTR These changes in kernel/module/kallsyms.c have a conflict with the
>>> series "Ignore local labels and mapping symbols during module load" [1],
>>> which is currently queued on modules-next, but it should be
>>> straightforward to resolve.
>>>
>>>> diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
>>>> index 01c65d608873..f64170344e69 100644
>>>> --- a/kernel/module/sysfs.c
>>>> +++ b/kernel/module/sysfs.c
>>>> @@ -62,6 +62,15 @@ static void free_sect_attrs(struct module_sect_attrs *sect_attrs)
>>>>       kfree(sect_attrs);
>>>>   }
>>>>   +/*
>>>> + * .data..percpu has a separate allocation per CPU and no single
>>>> + * address to report.
>>>> + */
>>>> +static bool sect_visible(const struct load_info *info, unsigned int i)
>>>> +{
>>>> +    return !sect_empty(&info->sechdrs[i]) && i != info->index.pcpu;
>>>> +}
>>>> +
>>>>   static int add_sect_attrs(struct module *mod, const struct load_info *info)
>>>>   {
>>>>       struct module_sect_attrs *sect_attrs;
>>>> @@ -72,7 +81,7 @@ static int add_sect_attrs(struct module *mod, const struct load_info *info)
>>>>         /* Count loaded sections and allocate structures */
>>>>       for (i = 0; i < info->hdr->e_shnum; i++)
>>>> -        if (!sect_empty(&info->sechdrs[i]))
>>>> +        if (sect_visible(info, i))
>>>>               nloaded++;
>>>>       sect_attrs = kzalloc_flex(*sect_attrs, attrs, nloaded);
>>>>       if (!sect_attrs)
>>>> @@ -92,7 +101,7 @@ static int add_sect_attrs(struct module *mod, const struct load_info *info)
>>>>       for (i = 0; i < info->hdr->e_shnum; i++) {
>>>>           Elf_Shdr *sec = &info->sechdrs[i];
>>>>   -        if (sect_empty(sec))
>>>> +        if (!sect_visible(info, i))
>>>>               continue;
>>>>           sysfs_bin_attr_init(sattr);
>>>>           sattr->attr.name =
>>>> @@ -181,7 +190,7 @@ static int add_notes_attrs(struct module *mod, const struct load_info *info)
>>>>         nattr = &notes_attrs->attrs[0];
>>>>       for (loaded = i = 0; i < info->hdr->e_shnum; ++i) {
>>>> -        if (sect_empty(&info->sechdrs[i]))
>>>> +        if (!sect_visible(info, i))
>>>>               continue;
>>>>           if (info->sechdrs[i].sh_type == SHT_NOTE) {
>>>>               sysfs_bin_attr_init(nattr);
>>> add_notes_attrs() has two sect_empty() calls. Both should be changed to
>>> sect_visible().
>>
>>
>> I kept this part unmodified to preserve the loop's original intent.
>>
>> This loop counts SHT_NOTE sections.
>>
>> SHT_NOTE refers to ELF note sections, which hold non-executable
>>
>> metadata such as build ID and ABI info.
>>
>> I wonder if we could keep the current implementation.
>>
>> As noted in the comment above, the top part counts SHT_NOTE sections
>>
>> and allocates structures, while the lower logic handles control of node attributes.
>>
>>
>> WDYT?
>>
>>
> 
> Sorry, I've reconsidered this. I think changing it to sect_visible would be better.
> 
> sect_visible stands for the count of externally visible note attributes, so the code
> 
> above and below can align with each other.
> 
> 
> Sorry for the noise.

No worries.

One problem with continuing to use sect_empty() in the first loop is
that it could overallocate the number of required entries if a module
contains an SHT_NOTE section named .data..percpu. That shouldn't happen,
but we can trivially avoid it by using sect_visible() there as well.

Using the same condition in both loops also makes the code generally
simpler to understand.

-- 
Cheers,
Petr
