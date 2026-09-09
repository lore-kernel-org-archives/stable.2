Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B25154529C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953459; cv=none; b=O8u9haE6dsXa7kPtjMEjqDyW05NLXcHNCW0U0HuKTUUPIApTzHq0c2t2txziR/KobmlY0t0DDXm7jakFuLHOk005TtQZZxT1aYzN2y+/C7lnRO7tUlLw+B5tL0qovkunLmKRpCrya35NDHcXiy3dcHPwdQxX/7XvbFR/BoMl4ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953459; c=relaxed/simple;
	bh=ftNwKSd1iBc8pytpsmrczSurftwKx6ejlicpmNp3+5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Amaoy47jMmmZoBECpPbD3CM3CH5bYCd+EyyoNl/yYTOD78JTDERLoe2O7Zp3AYcxIiYTLtD4XG7RMKvDYcbGURiSClwsY2gYyxz8gLa0uNvFGsOkBGblgZCmTNkkNP/R8H7isYxdnJbRKtBQ6nnK5FgLh3pFeAPMJOxuL7S8Ras=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QKxtn33V; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QKxtn33V"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48442ea8f59so4754069f8f.1
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 04:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788953455; x=1789558255; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S3GAQaN4MUpmSo4Q7ZsJl4/HQ5mDsQes7kEJFp9ImSA=;
        b=QKxtn33VM1i/NHylYZYs/G1rrpiI6sxeTybGL0TmNMycPKtDtwmMxnNbM6nKp0TH+E
         akc6WMyNdu4wEnEWQauXMb1Vp01+zd6MAwmz/a8dD7Jyz+SBHnKvDtCt2XZ7lsTs4BAw
         IA7up0zhit/0zGWCNMyzBqiLx45VooYoMvNvCDcXj8bzQ1YFifSQ0RyPUZ92gTe5GyGF
         N61EZ64bhDAweZjMTaiuyKl2RMt0JyEO6h7IzM16J1rzma1DvIeakeZtmSkQP0HzgOpl
         ngzVEI9Y3zS+aq7832dJaRbX/VUlqTgzqW7hssG9SO5fW7COMBlwnBL6iGFL2DGuZoKn
         Xhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788953455; x=1789558255;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S3GAQaN4MUpmSo4Q7ZsJl4/HQ5mDsQes7kEJFp9ImSA=;
        b=JGj8uhP7V9XpWdDuWwN2+7/xBxjRLul7CdO+xfUitWXXckKd6L5QPRzyGbLRgE1aN0
         pnx4TUKGQhZTXBx7eoJnizsc31pQvf84WIjVfzWQpoS/1kwa+twaSJw8rJvARvKThqVE
         Sk7xlOrUZvrh293Mv/VOnMJO05ozlb+nsziJM9a7JInitVkqcz8IT1y2XZNqq7kDnuhI
         GhtxOUVW+9VimhCGsMfl0y0MgwRnW9lSlSZ5jwMsMkvgrFItv/12Ba2LEiEKY8vUdJ1e
         AoC7nb+jyP4sqvsKl8VDx2Megc/TAIqcy04c0eo+Sy2ryqQc5oEoVJNJzBimmR+Tse0i
         nzvQ==
X-Forwarded-Encrypted: i=1; AKwUvByHbaamqJ2xz31zRhYd5MpY6ZYyl6g9QYoD4QAVlO56EL4AF/ilXg4LhSLxSd1mo/ANI4s2RXM=@vger.kernel.org
X-Gm-Message-State: AFuF++mUwpxyMI73LMEf7LC7W4ATjcYzaZIsJv6DcQFi0cTLBS/TGEHU
	wJjwaVHOvDt2e4pRg7aRxntKDLfoMCF23dsdivEzVD+9PjOR5Vqho+fFEW2H6gDet8k=
X-Gm-Gg: AYBFou1+Cfa3UVNKzQt6K3Felnpjm/mAeZTXbo+E44QOpNQwqx2WYr6XccknNDBfmui
	ZIrWNIiMOaXsPBvUyIc4UVPzdqUmvHhUGRvMOjlVnz4pstDZ6x4yv876Vdo41n/nR5SpH3AJ3W9
	+9ZH3jLIJ2UqnZaF5j8d5Ph2MSO/yM7jM3C149vKVo0P56HL9nnQ6aw7afEU5+OMwoE5fn6mcab
	E7EKdStJc9MOAuPheG42oi3Shwj2KfAfZ9KGh5oAV99e02ryEr89qozY/A1ebaXSIAZb86Z1s9i
	9kUWSPD7GzbHn8CEkB41ciQw54UIr7udIIsWVo8Zi6vTy4Jamy0iNIFpo9afNMRS6dMZX/gpOjf
	eMJ4zuv0tySuqkr23Zl1DSxU7rFVXqCmzse5PTr7W0tbU1GmXDydvOJELR53fTVHVLBNqEV+eGU
	YTX/aeZ0h2tSs8ZC70l5dayScxIdgs92f0g6QMQaXpMC3QRxfB+SVzehuHOkiD8K0kAhQYBxakd
	JhN292I3tzOZF9/gjzaW47z+l65i2hDVmQ=
X-Received: by 2002:a05:6000:25c8:b0:485:caa9:87f5 with SMTP id ffacd0b85a97d-485caa98937mr892423f8f.14.1788953455145;
        Wed, 09 Sep 2026 04:30:55 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883927a3sm33609875f8f.11.2026.09.09.04.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 04:30:54 -0700 (PDT)
Message-ID: <76b5edbb-8231-41d0-9e7b-f965af13c324@suse.com>
Date: Wed, 9 Sep 2026 13:30:53 +0200
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
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260908092412.115953-4-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/26 11:24 AM, Hao Ge wrote:
> SHF_ALLOC means, per the ELF spec, that a section occupies memory
> during process execution. Some module sections occupy memory
> outside the regular module layout, for example the percpu section
> with its per-CPU allocations. The loader currently excludes such
> a section from the layout by clearing its SHF_ALLOC, which
> overloads the flag with a loader-internal meaning.
> apply_relocations() needs a special case for the section, and
> find_sec(".data..percpu") returns different results before and
> after layout_and_allocate().
> 
> Introduce SH_ENTSIZE_STANDALONE to mark sections with a separate
> allocation. The percpu section is its first user. layout_sections()
> and move_module() skip marked sections, and apply_relocations() goes
> back to testing only SHF_ALLOC. Based on a patch by Petr Pavlu [1].
> 
> .data..percpu keeps SHF_ALLOC, so it would now show up under
> /sys/module/*/sections/. The section has one instance per CPU and no
> single address to report, and the entry never existed before, so
> skip it in add_sect_attrs(). add_notes_attrs() indexes its attrs[]
> array and skips it too. No functional change otherwise.
> 
> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/all/499bb60c-c6e3-43a3-bd92-95a0567ece5e@suse.com/ [1]
> Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
> [...]
> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> index 0fc11e45df9b..49190deae61e 100644
> --- a/kernel/module/kallsyms.c
> +++ b/kernel/module/kallsyms.c
> @@ -76,7 +76,7 @@ static char elf_type(const Elf_Sym *sym, const struct load_info *info)
>  }
>  
>  static bool is_core_symbol(const Elf_Sym *src, const Elf_Shdr *sechdrs,
> -			   unsigned int shnum, unsigned int pcpundx)
> +			   unsigned int shnum)
>  {
>  	const Elf_Shdr *sec;
>  	enum mod_mem_type type;
> @@ -86,11 +86,6 @@ static bool is_core_symbol(const Elf_Sym *src, const Elf_Shdr *sechdrs,
>  	    !src->st_name)
>  		return false;
>  
> -#ifdef CONFIG_KALLSYMS_ALL
> -	if (src->st_shndx == pcpundx)
> -		return true;
> -#endif
> -
>  	sec = sechdrs + src->st_shndx;
>  	type = sec->sh_entsize >> SH_ENTSIZE_TYPE_SHIFT;
>  	if (!(sec->sh_flags & SHF_ALLOC)
> @@ -131,8 +126,7 @@ void layout_symtab(struct module *mod, struct load_info *info)
>  	/* Compute total space required for the core symbols' strtab. */
>  	for (ndst = i = 0; i < nsrc; i++) {
>  		if (i == 0 || is_livepatch_module(mod) ||
> -		    is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
> -				   info->index.pcpu)) {
> +		    is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum)) {
>  			strtab_size += strlen(&info->strtab[src[i].st_name]) + 1;
>  			ndst++;
>  		}
> @@ -199,8 +193,7 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
>  	for (ndst = i = 0; i < kallsyms->num_symtab; i++) {
>  		kallsyms->typetab[i] = elf_type(src + i, info);
>  		if (i == 0 || is_livepatch_module(mod) ||
> -		    is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
> -				   info->index.pcpu)) {
> +		    is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum)) {
>  			ssize_t ret;
>  
>  			mod->core_kallsyms.typetab[ndst] =

FTR These changes in kernel/module/kallsyms.c have a conflict with the
series "Ignore local labels and mapping symbols during module load" [1],
which is currently queued on modules-next, but it should be
straightforward to resolve.

> diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
> index 01c65d608873..f64170344e69 100644
> --- a/kernel/module/sysfs.c
> +++ b/kernel/module/sysfs.c
> @@ -62,6 +62,15 @@ static void free_sect_attrs(struct module_sect_attrs *sect_attrs)
>  	kfree(sect_attrs);
>  }
>  
> +/*
> + * .data..percpu has a separate allocation per CPU and no single
> + * address to report.
> + */
> +static bool sect_visible(const struct load_info *info, unsigned int i)
> +{
> +	return !sect_empty(&info->sechdrs[i]) && i != info->index.pcpu;
> +}
> +
>  static int add_sect_attrs(struct module *mod, const struct load_info *info)
>  {
>  	struct module_sect_attrs *sect_attrs;
> @@ -72,7 +81,7 @@ static int add_sect_attrs(struct module *mod, const struct load_info *info)
>  
>  	/* Count loaded sections and allocate structures */
>  	for (i = 0; i < info->hdr->e_shnum; i++)
> -		if (!sect_empty(&info->sechdrs[i]))
> +		if (sect_visible(info, i))
>  			nloaded++;
>  	sect_attrs = kzalloc_flex(*sect_attrs, attrs, nloaded);
>  	if (!sect_attrs)
> @@ -92,7 +101,7 @@ static int add_sect_attrs(struct module *mod, const struct load_info *info)
>  	for (i = 0; i < info->hdr->e_shnum; i++) {
>  		Elf_Shdr *sec = &info->sechdrs[i];
>  
> -		if (sect_empty(sec))
> +		if (!sect_visible(info, i))
>  			continue;
>  		sysfs_bin_attr_init(sattr);
>  		sattr->attr.name =
> @@ -181,7 +190,7 @@ static int add_notes_attrs(struct module *mod, const struct load_info *info)
>  
>  	nattr = &notes_attrs->attrs[0];
>  	for (loaded = i = 0; i < info->hdr->e_shnum; ++i) {
> -		if (sect_empty(&info->sechdrs[i]))
> +		if (!sect_visible(info, i))
>  			continue;
>  		if (info->sechdrs[i].sh_type == SHT_NOTE) {
>  			sysfs_bin_attr_init(nattr);

add_notes_attrs() has two sect_empty() calls. Both should be changed to
sect_visible().

With this fixed, the patch looks ok to me. Feel free to add:

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

[1] https://lore.kernel.org/linux-modules/20260820125007.22943-1-yangtiezhu@loongson.cn/

-- 
Thanks,
Petr
