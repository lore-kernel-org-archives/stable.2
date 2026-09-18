Received: from mta0.migadu.com (out-8.mta0.migadu.com [91.218.175.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ED43546D7
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 02:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789699844; cv=none; b=OT11HSveYryayK5wkbYFAEEM3aYQY6u/yJSp7PS23AuOyp1ArXAR8+spZAR9RBPm9N/01OKKBQ6Pl0x0G+jqY5DTThtUONxcRR+O8tH7kv3nJU2TevIpC0rmjKSM2wMUsAbBGmOAvSySEpPc9cCcJAaPS7JRUw8KkjjZ/d+F/Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789699844; c=relaxed/simple;
	bh=N6CEd0l0gJW6eAjQ3ySm2d8Yd/dkGeFlWotcwVS5SyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DKpvGX4b86ZvTFevz0ggs6H/r2TvPJusj4XUZFWbuIqi30cOOqeXpxu8iJJj5dtn5bMDK6rEF14hvHY5mCmwyeOIubbXbblYO/ke0HqDNMKpS5fFJnK+47QI5Oi2HGvpjabN7Fm9UKyIHJkJJhm7X54SuVbG/sljFu4yWFMHdj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q8L+LzCh; arc=none smtp.client-ip=91.218.175.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q8L+LzCh"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=N6CEd0l0gJW6eAjQ3ySm2d8Yd/dkGeFlWotcwVS5SyY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789699832; v=1; x=1790304632;
 b=q8L+LzChO5BJ4zN/c+/2DaJ/1RGJ8LSa8XmeBKkXK9Y3/ees52CMnAbfwvYH6EP/oxh/quPU
 vLr0ldVTl6kib3XrtDxoqBVQTeJ7NV8dfPT1xrWAA/54XuhOOQsNqcswzNpU8g61oSv/rqkvYbv
 Ul2ToTd5G9rOUsAnk23E8rTI=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9d9f438652b75181;
	Fri, 18 Sep 2026 02:50:12 +0000
X-Mizu-Trace-ID: 9d9f438652b75181
X-Migadu-Flow: FLOW_OUT
Message-ID: <887bab46-1959-4e1b-acba-082f91294055@linux.dev>
Date: Fri, 18 Sep 2026 10:51:10 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/6] module: introduce SH_ENTSIZE_STANDALONE for
 separately allocated sections
To: Suren Baghdasaryan <surenb@google.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, linux-modules@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20260915070001.113559-1-hao.ge@linux.dev>
 <20260915070001.113559-4-hao.ge@linux.dev>
 <CAJuCfpHz6V0zT5+QkYdQsBzG9kWCFhP+gris2XRrvSu4hHD6Hw@mail.gmail.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpHz6V0zT5+QkYdQsBzG9kWCFhP+gris2XRrvSu4hHD6Hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Suren

On 2026/9/18 01:25, Suren Baghdasaryan wrote:
> On Mon, Sep 14, 2026 at 11:59 PM Hao Ge <hao.ge@linux.dev> wrote:
>>
>> SHF_ALLOC means, per the ELF spec, that a section occupies memory
>> during process execution. Some module sections occupy memory
>> outside the regular module layout, for example the percpu section
>> with its per-CPU allocations. The loader currently excludes such
>> a section from the layout by clearing its SHF_ALLOC, which
>> overloads the flag with a loader-internal meaning.
>> apply_relocations() needs a special case for the section, and
>> find_sec(".data..percpu") returns different results before and
>> after layout_and_allocate().
>>
>> Introduce SH_ENTSIZE_STANDALONE to mark sections with a separate
>> allocation. The percpu section is its first user. layout_sections()
>> and move_module() skip marked sections, and apply_relocations() goes
>> back to testing only SHF_ALLOC. Based on a patch by Petr Pavlu [1].
>>
>> .data..percpu keeps SHF_ALLOC, so it would now show up under
>> /sys/module/*/sections/. The section has one instance per CPU and no
>> single address to report, and the entry never existed before, so
>> skip it in add_sect_attrs(). add_notes_attrs() indexes its attrs[]
>> array and skips it too. No functional change otherwise.
> 
> And IIUC no userspace-visible changes too, right?
>

Right, I'll fold this into the commit message for the next version:
"No functional or userspace-visible changes otherwise."

>>
>> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Link: https://lore.kernel.org/all/499bb60c-c6e3-43a3-bd92-95a0567ece5e@suse.com/ [1]
>> Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
>> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>

Thanks.

Best Regards
Hao

>> ---
>>  include/linux/module.h   |  2 ++
>>  kernel/module/internal.h |  8 ++++++++
>>  kernel/module/kallsyms.c | 13 +++----------
>>  kernel/module/main.c     | 32 +++++++++++++++++---------------
>>  kernel/module/sysfs.c    | 17 +++++++++++++----
>>  5 files changed, 43 insertions(+), 29 deletions(-)
>>
>> diff --git a/include/linux/module.h b/include/linux/module.h
>> index 96cc98568eea..0c6f32ddcbf2 100644
>> --- a/include/linux/module.h
>> +++ b/include/linux/module.h
>> @@ -325,6 +325,8 @@ enum mod_mem_type {
>>         MOD_INIT_RODATA,
>>
>>         MOD_MEM_NUM_TYPES,
>> +
>> +       MOD_STANDALONE = -2,
>>         MOD_INVALID = -1,
>>  };
>>
>> diff --git a/kernel/module/internal.h b/kernel/module/internal.h
>> index 061161cc79d9..4c738074a27b 100644
>> --- a/kernel/module/internal.h
>> +++ b/kernel/module/internal.h
>> @@ -29,6 +29,14 @@
>>  #define SH_ENTSIZE_TYPE_MASK   ((1UL << SH_ENTSIZE_TYPE_BITS) - 1)
>>  #define SH_ENTSIZE_OFFSET_MASK ((1UL << (BITS_PER_LONG - SH_ENTSIZE_TYPE_BITS)) - 1)
>>
>> +/*
>> + * Marker for sections with a separate allocation, which are not placed
>> + * into mod->mem[].
>> + */
>> +#define SH_ENTSIZE_STANDALONE                                  \
>> +       (((unsigned long)MOD_STANDALONE & SH_ENTSIZE_TYPE_MASK) \
>> +        << SH_ENTSIZE_TYPE_SHIFT)
>> +
>>  /* Maximum number of characters written by module_flags() */
>>  #define MODULE_FLAGS_BUF_SIZE (TAINT_FLAGS_COUNT + 4)
>>
>> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
>> index f23126d804b2..0dca6d40160e 100644
>> --- a/kernel/module/kallsyms.c
>> +++ b/kernel/module/kallsyms.c
>> @@ -76,7 +76,7 @@ static char elf_type(const Elf_Sym *sym, const struct load_info *info)
>>  }
>>
>>  static bool is_core_symbol(const Elf_Sym *src, const Elf_Shdr *sechdrs,
>> -                          unsigned int shnum, unsigned int pcpundx)
>> +                          unsigned int shnum)
>>  {
>>         const Elf_Shdr *sec;
>>         enum mod_mem_type type;
>> @@ -86,11 +86,6 @@ static bool is_core_symbol(const Elf_Sym *src, const Elf_Shdr *sechdrs,
>>             !src->st_name)
>>                 return false;
>>
>> -#ifdef CONFIG_KALLSYMS_ALL
>> -       if (src->st_shndx == pcpundx)
>> -               return true;
>> -#endif
>> -
>>         sec = sechdrs + src->st_shndx;
>>         type = sec->sh_entsize >> SH_ENTSIZE_TYPE_SHIFT;
>>         if (!(sec->sh_flags & SHF_ALLOC)
>> @@ -131,8 +126,7 @@ void layout_symtab(struct module *mod, struct load_info *info)
>>         /* Compute total space required for the core symbols' strtab. */
>>         for (ndst = i = 0; i < nsrc; i++) {
>>                 if (i == 0 || is_livepatch_module(mod) ||
>> -                   is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
>> -                                  info->index.pcpu)) {
>> +                   is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum)) {
>>                         strtab_size += strlen(&info->strtab[src[i].st_name]) + 1;
>>                         ndst++;
>>                 }
>> @@ -199,8 +193,7 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
>>         for (ndst = i = 0; i < kallsyms->num_symtab; i++) {
>>                 kallsyms->typetab[i] = elf_type(src + i, info);
>>                 if (i == 0 || is_livepatch_module(mod) ||
>> -                   is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
>> -                                  info->index.pcpu)) {
>> +                   is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum)) {
>>                         ssize_t ret;
>>
>>                         mod->core_kallsyms.typetab[ndst] =
>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>> index c1b34dc1e89a..ae2678ac7840 100644
>> --- a/kernel/module/main.c
>> +++ b/kernel/module/main.c
>> @@ -1619,12 +1619,13 @@ static int apply_relocations(struct module *mod, const struct load_info *info)
>>
>>                 /*
>>                  * Don't bother with non-allocated sections.
>> -                * An exception is the percpu section, which has separate allocations
>> -                * for individual CPUs. We relocate the percpu section in the initial
>> -                * ELF template and subsequently copy it to the per-CPU destinations.
>> +                *
>> +                * Note that .data..percpu has separate allocations for
>> +                * individual CPUs. We relocate the section in the
>> +                * initial ELF template and subsequently copy it to the
>> +                * per-CPU destinations.
>>                  */
>> -               if (!(info->sechdrs[infosec].sh_flags & SHF_ALLOC) &&
>> -                   (!infosec || infosec != info->index.pcpu))
>> +               if (!(info->sechdrs[infosec].sh_flags & SHF_ALLOC))
>>                         continue;
>>
>>                 if (info->sechdrs[i].sh_flags & SHF_RELA_LIVEPATCH)
>> @@ -1715,7 +1716,7 @@ static void __layout_sections(struct module *mod, struct load_info *info, bool i
>>
>>                         if ((s->sh_flags & masks[m][0]) != masks[m][0]
>>                             || (s->sh_flags & masks[m][1])
>> -                           || s->sh_entsize != ~0UL
>> +                           || s->sh_entsize != ~0UL /* offset or standalone */
>>                             || is_init != module_init_layout_section(sname))
>>                                 continue;
>>
>> @@ -1745,16 +1746,10 @@ static void __layout_sections(struct module *mod, struct load_info *info, bool i
>>  /*
>>   * Lay out the SHF_ALLOC sections in a way not dissimilar to how ld
>>   * might -- code, read-only data, read-write data, small data.  Tally
>> - * sizes, and place the offsets into sh_entsize fields: high bit means it
>> - * belongs in init.
>> + * sizes, and place the offsets into sh_entsize fields.
>>   */
>>  static void layout_sections(struct module *mod, struct load_info *info)
>>  {
>> -       unsigned int i;
>> -
>> -       for (i = 0; i < info->hdr->e_shnum; i++)
>> -               info->sechdrs[i].sh_entsize = ~0UL;
>> -
>>         pr_debug("Core section allocation order for %s:\n", mod->name);
>>         __layout_sections(mod, info, false);
>>
>> @@ -2822,7 +2817,8 @@ static int move_module(struct module *mod, struct load_info *info)
>>                 Elf_Shdr *shdr = &info->sechdrs[i];
>>                 const char *sname;
>>
>> -               if (!(shdr->sh_flags & SHF_ALLOC))
>> +               if (!(shdr->sh_flags & SHF_ALLOC)
>> +                   || shdr->sh_entsize == SH_ENTSIZE_STANDALONE)
>>                         continue;
>>
>>                 sname = info->secstrings + shdr->sh_name;
>> @@ -2954,6 +2950,7 @@ core_param(module_blacklist, module_blacklist, charp, 0400);
>>  static struct module *layout_and_allocate(struct load_info *info, int flags)
>>  {
>>         struct module *mod;
>> +       unsigned int i;
>>         int err;
>>
>>         /* Allow arches to frob section contents and sizes.  */
>> @@ -2967,8 +2964,13 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
>>         if (err < 0)
>>                 return ERR_PTR(err);
>>
>> +       /* Repurpose sh_entsize to track where each section is allocated. */
>> +       for (i = 0; i < info->hdr->e_shnum; i++)
>> +               info->sechdrs[i].sh_entsize = ~0UL;
>> +
>>         /* We will do a special allocation for per-cpu sections later. */
>> -       info->sechdrs[info->index.pcpu].sh_flags &= ~(unsigned long)SHF_ALLOC;
>> +       if (info->index.pcpu)
>> +               info->sechdrs[info->index.pcpu].sh_entsize = SH_ENTSIZE_STANDALONE;
>>
>>         /*
>>          * Mark relevant sections as SHF_RO_AFTER_INIT so layout_sections() can
>> diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
>> index 01c65d608873..15c6baeb39c4 100644
>> --- a/kernel/module/sysfs.c
>> +++ b/kernel/module/sysfs.c
>> @@ -62,6 +62,15 @@ static void free_sect_attrs(struct module_sect_attrs *sect_attrs)
>>         kfree(sect_attrs);
>>  }
>>
>> +/*
>> + * .data..percpu has a separate allocation per CPU and no single
>> + * address to report.
>> + */
>> +static bool sect_visible(const struct load_info *info, unsigned int i)
>> +{
>> +       return !sect_empty(&info->sechdrs[i]) && i != info->index.pcpu;
>> +}
>> +
>>  static int add_sect_attrs(struct module *mod, const struct load_info *info)
>>  {
>>         struct module_sect_attrs *sect_attrs;
>> @@ -72,7 +81,7 @@ static int add_sect_attrs(struct module *mod, const struct load_info *info)
>>
>>         /* Count loaded sections and allocate structures */
>>         for (i = 0; i < info->hdr->e_shnum; i++)
>> -               if (!sect_empty(&info->sechdrs[i]))
>> +               if (sect_visible(info, i))
>>                         nloaded++;
>>         sect_attrs = kzalloc_flex(*sect_attrs, attrs, nloaded);
>>         if (!sect_attrs)
>> @@ -92,7 +101,7 @@ static int add_sect_attrs(struct module *mod, const struct load_info *info)
>>         for (i = 0; i < info->hdr->e_shnum; i++) {
>>                 Elf_Shdr *sec = &info->sechdrs[i];
>>
>> -               if (sect_empty(sec))
>> +               if (!sect_visible(info, i))
>>                         continue;
>>                 sysfs_bin_attr_init(sattr);
>>                 sattr->attr.name =
>> @@ -159,7 +168,7 @@ static int add_notes_attrs(struct module *mod, const struct load_info *info)
>>         /* Count notes sections and allocate structures.  */
>>         notes = 0;
>>         for (i = 0; i < info->hdr->e_shnum; i++)
>> -               if (!sect_empty(&info->sechdrs[i]) &&
>> +               if (sect_visible(info, i) &&
>>                     info->sechdrs[i].sh_type == SHT_NOTE)
>>                         ++notes;
>>
>> @@ -181,7 +190,7 @@ static int add_notes_attrs(struct module *mod, const struct load_info *info)
>>
>>         nattr = &notes_attrs->attrs[0];
>>         for (loaded = i = 0; i < info->hdr->e_shnum; ++i) {
>> -               if (sect_empty(&info->sechdrs[i]))
>> +               if (!sect_visible(info, i))
>>                         continue;
>>                 if (info->sechdrs[i].sh_type == SHT_NOTE) {
>>                         sysfs_bin_attr_init(nattr);
>> --
>> 2.25.1
>>
