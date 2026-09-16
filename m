Received: from mta0.migadu.com (out-83.mta0.migadu.com [91.218.175.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7958E370D77
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 06:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789538433; cv=none; b=YOh067H0tfALgdGwFFu3NbyoJkBQ+gQkcKnC6fmtEpdE+WIQpozwOgSjAMPpuB2xmrUTZYtsuM5Qfc6/UH5aYmqRIEPXeFEyYwpAM3/+FPHSZsDGdtWxcJQcKKvi6I4uCHpY1dPL3fBECX3e/sEwHGUxbfV3YvkkPHM2yZbwuQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789538433; c=relaxed/simple;
	bh=lkKO+hhwFT4C9KkIH3ogidkHvWCUt7zPEkugIUZmm7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TMG3ZI+cA3zGSVeiPuI7txTcmDnbo2EKA/DGI9PARfa8tLS85CI+99S8KfRr0lYbAYKNWkd5niMbXTnmG4JjO7EHV6JtZjzD0Ah8wNcOWLNKSXaVO7FugPO6EhkmIS8FSt159DfAfdzoTCScaMmudMO654UrQ+sb9TjOqtFZt1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=njjEEzTE; arc=none smtp.client-ip=91.218.175.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="njjEEzTE"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lkKO+hhwFT4C9KkIH3ogidkHvWCUt7zPEkugIUZmm7w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789538428; v=1; x=1790143228;
 b=njjEEzTEcVy30RwhwiXNrWhjxRE1Rc3bAZJXeXx3LrWXegx/4oMKn3rf4Uev10jIoRlLd/m2
 38coU2jNIJ9yEThcWdxCuD+J0Ch5rI71N3+gk4R+uNmk+cRFEYZhBC3uK7uVj04fIecQG0WM+m1
 Cmy+muqUxuvD62g2JfuhjlvU=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 39cd2895c6e16674;
	Wed, 16 Sep 2026 06:00:12 +0000
X-Mizu-Trace-ID: 39cd2895c6e16674
X-Migadu-Flow: FLOW_OUT
Message-ID: <60642a7f-2949-428a-8290-40d69c989a77@linux.dev>
Date: Wed, 16 Sep 2026 14:01:06 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/6] alloc_tag: clean up the populate failure path
To: Suren Baghdasaryan <surenb@google.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, linux-modules@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20260915070001.113559-1-hao.ge@linux.dev>
 <20260915070001.113559-3-hao.ge@linux.dev>
 <CAJuCfpHJSwNhgotMVpmjVvdv=m52_7Kvzpztf0WcN0AaoSeGGw@mail.gmail.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpHJSwNhgotMVpmjVvdv=m52_7Kvzpztf0WcN0AaoSeGGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Suren

Thanks for you review.

On 2026/9/16 05:09, Suren Baghdasaryan wrote:
> On Mon, Sep 14, 2026 at 11:59 PM Hao Ge <hao.ge@linux.dev> wrote:
>>
>> The reservation is already stored in the maple tree when
>> vm_module_tags_populate() fails. A failed load never unloads the
>> module, so nothing releases the entry. Release it and roll
>> module_tags.size back. Without the rollback a concurrent load that
>> already passed needs_section_mem() can reuse the freed gap, skip
>> vm_module_tags_populate() and write to unmapped memory.
>>
>> vmap_pages_range() may have installed some PTEs before failing. A
>> retry to populate the same range would BUG on them, so undo them,
>> but only if vmap actually ran.
>>
>> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
>> Fixes: 0f9b685626da ("alloc_tag: populate memory for module tags as needed")
> 
> If a patch fixes two other patches, it likely needs to be split so
> that each part fixes one patch only. But read on please. I'm not sure
> if one of the fixes is correct.
>

Kept them in one patch because they only make sense together.

After a failed populate the reservation is released and the
size rolled back, so the next load takes the same gap and calls
vm_module_tags_populate() again, and that retry would trip over
the PTEs the failed vmap left behind.

Without the rollback a load that already passed needs_section_mem()
just reuses the gap, skips populate and writes to unmapped memory.
So splitting them leaves each half broken.                                   

>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>> ---
>>  mm/alloc_tag.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
>> index 2070e682fe10..95ddf5b743d0 100644
>> --- a/mm/alloc_tag.c
>> +++ b/mm/alloc_tag.c
>> @@ -804,6 +804,13 @@ static int vm_module_tags_populate(void)
>>                                      next_page, PAGE_SHIFT) < 0) {
>>                         release_pages_arg arg = { .pages = next_page };
>>
>> +                       /*
>> +                        * vmap_pages_range() only runs once all pages were
>> +                        * allocated, and it may have installed some mappings
>> +                        * before failing. Undo them.
> 
> If vmap_pages_range() failed to map the range, why should we need to
> undo it? If it indeed leaves some partial mapping when failing then I
> would argue that vmap_pages_range() should be undoing these partial
> mappings itself before returning the error.
>
Yeah it does - none of the paths under vmap_pages_range() undo themselves on error.
pcpu_map_pages does perform cleanup on its own as well. There may be other similar sites.
https://elixir.bootlin.com/linux/v7.3-rc3/source/mm/percpu-vm.c#L255
so I did the same here.

If we really want vmap_pages_range() to handle this cleanup internally, I believe that would
be a relatively large change, and we would need to consider many more cases. So I think we keep
the current behaviour for now.

Thanks
Best Regards
Hao

>> +                        */
>> +                       if (nr == more_pages)
>> +                               vunmap_range(phys_end, phys_end + (nr << PAGE_SHIFT));
>>                         /* Clean up and error out */
>>                         release_pages(arg, nr);
>>                         return -ENOMEM;
>> @@ -947,6 +954,7 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
>>                 return ret;
>>
>>         if (module_tags.size < offset + size) {
>> +               unsigned long prev_size = module_tags.size;
>>                 int grow_res;
>>
>>                 module_tags.size = offset + size;
>> @@ -961,6 +969,8 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
>>                         shutdown_mem_profiling(true);
>>                         pr_err("Failed to allocate memory for allocation tags in the module %s. Memory allocation profiling is disabled!\n",
>>                                mod->name);
>> +                       release_module_tags(mod, false);
>> +                       module_tags.size = prev_size;
> 
> Yes, this one is a valid fix. It fixes 0f9b685626da commit.
> 
>>                         return ERR_PTR(grow_res);
>>                 }
>>         }
>> --
>> 2.25.1
>>
