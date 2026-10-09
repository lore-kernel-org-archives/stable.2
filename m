Received: from mta0.migadu.com (out-68.mta0.migadu.com [91.218.175.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69AA4CA777
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 11:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544572; cv=none; b=PT4BhgRFROQ/PNeDxGrNiB/mSwX/qZKrCqnSUkFt0viJHMeeBsttZhXrcF2OaqFWPaKpPL3u3qyRN19pKhUgPhgFhfDySIAZSeOaaAFW+Iwgh5Us3WvW1HHafEokRdjKYViepD+9BPcGDmMuh7FpN1vjGLdSsStMNUoito/7/eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544572; c=relaxed/simple;
	bh=4KiuDAG3gm65cIQ2mqPJSAHpZO66H8hjIEiCXFAoNYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MOm+47MpXFIYgSJATwUvRnyPvXtzrqVWszOZwp4wDojrSnlPj8y6Cc4bgd/wiqbZ8zTS0ozp2QIPzVK+NmSVMNaUrdalVfdMD4bqpkzMPMSUTUQlfu7NfZQ/HkCw8GTbv3ECys+6CX/6+K2igh5tPsQR+yp4czgOuHcp0oh1dZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AvBWyQWP; arc=none smtp.client-ip=91.218.175.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AvBWyQWP"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4KiuDAG3gm65cIQ2mqPJSAHpZO66H8hjIEiCXFAoNYM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791544560; v=1; x=1792149360;
 b=AvBWyQWP3rcBetVOVIU7NVk4oy7VlA7D2gOQ9G2FqXEJIAuc6JbovwF6sEWyCCcTD4SMEWP4
 CV8x9Owgu04HIuwn/uyXTzZllBRfPxm2XSW0iuy51DV+F/obP1wWO5KqfS4V/q/rErOZtcIzkxU
 oBk1aMzCkFs9V3dcGRxwraHk=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 50b57414bfeda855;
	Fri, 09 Oct 2026 11:15:47 +0000
X-Mizu-Trace-ID: 50b57414bfeda855
X-Migadu-Flow: FLOW_OUT
Message-ID: <fc32fbb9-9db2-40f1-88fc-c087927a1eb8@linux.dev>
Date: Fri, 9 Oct 2026 19:16:53 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 7/7] alloc_tag: fix the /proc/allocinfo lifecycle
To: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Andrew Morton
 <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>,
 Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vlastimil Babka <vbabka@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <brendan.jackman@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, Sashiko <sashiko-bot@kernel.org>,
 stable@vger.kernel.org
References: <20260929082014.160587-1-hao.ge@linux.dev>
 <20260929082014.160587-8-hao.ge@linux.dev>
 <CAJuCfpEwrdOKQmt9_=J4Qawtg48AUuwwbc2Lp-1oWiNbKO_UVw@mail.gmail.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpEwrdOKQmt9_=J4Qawtg48AUuwwbc2Lp-1oWiNbKO_UVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Suren


On 2026/10/5 02:23, Suren Baghdasaryan wrote:
> On Tue, Sep 29, 2026 at 10:20 AM Hao Ge <hao.ge@linux.dev> wrote:
>>
>> shutdown_mem_profiling() calls remove_proc_entry() from
>> reserve_module_tags(), which runs under mod_lock held for write.
>> remove_proc_entry() waits for readers, and a reader takes mod_lock for
>> read in allocinfo_start():
>>
>>   CPU0 (insmod)                      CPU1 (read /proc/allocinfo)
>>   ----------------                   ----------------------------
>>   reserve_module_tags()
>>     down_write(&mod_lock)  [held]
>>                                      use_pde()            [in_use++]
>>                                      allocinfo_start()
>>                                        down_read(&mod_lock)  <- blocks
>>     shutdown_mem_profiling()
>>       remove_proc_entry()
>>         wait for in_use == 0         <- blocks
>>
>> Move remove_proc_entry() to a workqueue.
>>
>> The deferred removal also affects alloc_tag_init(). The file is
>> created before the type, so on a failure it is still there with
>> alloc_tag_cttype NULL or an error pointer, and a reader panics in
>> allocinfo_start(). Create the file at the end of alloc_tag_init()
>> instead, a failed init leaves nothing behind.
>>
>> If proc_create() fails, the codetag type and the module tags memory
>> leak. Call codetag_unregister_type() and free the memory.
>>
>> alloc_tag_cttype can now be freed at runtime. alloc_tag_top_users()
>> reads it from __show_mem() without locks, read the pointer under
>> rcu_read_lock() and take mod_lock before dropping the RCU lock, the
>> type stays alive until then. The only caller never sleeps, drop the
>> can_sleep argument.
>>
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>> ---
>>  include/linux/alloc_tag.h |  2 +-
>>  include/linux/codetag.h   |  2 ++
>>  lib/codetag.c             | 26 ++++++++++++++++++++
>>  mm/alloc_tag.c            | 52 +++++++++++++++++++++++++++------------
>>  mm/show_mem.c             |  2 +-
>>  5 files changed, 66 insertions(+), 18 deletions(-)
>>
>> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
>> index 7f2d80a59792..852dc10c00ee 100644
>> --- a/include/linux/alloc_tag.h
>> +++ b/include/linux/alloc_tag.h
>> @@ -81,7 +81,7 @@ struct codetag_bytes {
>>         s64 bytes;
>>  };
>>
>> -size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sleep);
>> +size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count);
>>
>>  static inline struct alloc_tag *ct_to_alloc_tag(struct codetag *ct)
>>  {
>> diff --git a/include/linux/codetag.h b/include/linux/codetag.h
>> index a25a085c2df1..0c4e0337b474 100644
>> --- a/include/linux/codetag.h
>> +++ b/include/linux/codetag.h
>> @@ -87,6 +87,8 @@ void codetag_to_text(struct seq_buf *out, struct codetag *ct);
>>  struct codetag_type *
>>  codetag_register_type(const struct codetag_type_desc *desc);
>>
>> +void codetag_unregister_type(struct codetag_type *cttype);
>> +
>>  #if defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES)
>>
>>  bool codetag_needs_module_section(struct module *mod, const char *name,
>> diff --git a/lib/codetag.c b/lib/codetag.c
>> index a0b600720afc..46d0904b08b3 100644
>> --- a/lib/codetag.c
>> +++ b/lib/codetag.c
>> @@ -429,3 +429,29 @@ codetag_register_type(const struct codetag_type_desc *desc)
>>
>>         return cttype;
>>  }
>> +
>> +/**
>> + * codetag_unregister_type - unregister a codetag type
>> + * @cttype: the codetag type to unregister
>> + *
>> + * Undo codetag_register_type() and free @cttype. The caller must make
>> + * sure no lockless reader still uses @cttype, e.g. clear the pointer
>> + * to it and wait for an RCU grace period first.
>> + */
>> +void __init codetag_unregister_type(struct codetag_type *cttype)
>> +{
>> +       struct codetag_module *cmod;
>> +       unsigned long id, tmp;
>> +
>> +       mutex_lock(&codetag_lock);
>> +       list_del(&cttype->link);
>> +       mutex_unlock(&codetag_lock);
>> +
>> +       down_write(&cttype->mod_lock);
>> +       idr_for_each_entry_ul(&cttype->mod_idr, cmod, tmp, id)
>> +               kfree(cmod);
>> +       idr_destroy(&cttype->mod_idr);
>> +       up_write(&cttype->mod_lock);
>> +
>> +       kfree(cttype);
>> +}
>> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
>> index ba8a651769e3..b9af5fe5bba2 100644
>> --- a/mm/alloc_tag.c
>> +++ b/mm/alloc_tag.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/seq_file.h>
>>  #include <linux/string_choices.h>
>>  #include <linux/vmalloc.h>
>> +#include <linux/workqueue.h>
>>  #include <linux/kmemleak.h>
>>  #include <uapi/linux/alloc_tag.h>
>>
>> @@ -484,22 +485,28 @@ static const struct proc_ops allocinfo_proc_ops = {
>>  #endif
>>  };
>>
>> -size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sleep)
>> +size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count)
>>  {
>>         struct codetag_iterator iter;
>> +       struct codetag_type *cttype;
>>         struct codetag *ct;
>>         struct codetag_bytes n;
>>         unsigned int i, nr = 0;
>> +       bool locked;
>>
>> -       if (IS_ERR_OR_NULL(alloc_tag_cttype))
>> +       rcu_read_lock();
>> +       cttype = READ_ONCE(alloc_tag_cttype);
> 
> Code looks correct to me but if you are changing alloc_tag_cttype to
> be accessed under RCU, then you should declare it as __rcu and use
> rcu_assign_pointer()/rcu_access_pointer()/rcu_dereference()/rcu_dereference_protected().

Yes. I missed that. Will fix in the next version.

Thanks
Best Regards
Hao

> 
>> +       if (IS_ERR_OR_NULL(cttype)) {
>> +               rcu_read_unlock();
>>                 return 0;
>> +       }
>>
>> -       if (can_sleep)
>> -               codetag_lock_module_list(alloc_tag_cttype);
>> -       else if (!codetag_trylock_module_list(alloc_tag_cttype))
>> +       locked = codetag_trylock_module_list(cttype);
>> +       rcu_read_unlock();
>> +       if (!locked)
>>                 return 0;
>>
>> -       iter = codetag_get_ct_iter(alloc_tag_cttype);
>> +       iter = codetag_get_ct_iter(cttype);
>>         while ((ct = codetag_next_ct(&iter))) {
>>                 struct alloc_tag_counters counter = alloc_tag_read(ct_to_alloc_tag(ct));
>>
>> @@ -520,7 +527,7 @@ size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sl
>>                 }
>>         }
>>
>> -       codetag_unlock_module_list(alloc_tag_cttype);
>> +       codetag_unlock_module_list(cttype);
>>
>>         return nr;
>>  }
>> @@ -591,6 +598,13 @@ void pgalloc_tag_swap(struct folio *new, struct folio *old)
>>         put_page_tag_ref(handle_new);
>>  }
>>
>> +static void remove_allocinfo_file(struct work_struct *work)
>> +{
>> +       remove_proc_entry(ALLOCINFO_FILE_NAME, NULL);
>> +}
>> +
>> +static DECLARE_WORK(remove_allocinfo_work, remove_allocinfo_file);
>> +
>>  static void shutdown_mem_profiling(bool remove_file)
>>  {
>>         if (mem_alloc_profiling_enabled())
>> @@ -600,7 +614,7 @@ static void shutdown_mem_profiling(bool remove_file)
>>                 return;
>>
>>         if (remove_file)
>> -               remove_proc_entry(ALLOCINFO_FILE_NAME, NULL);
>> +               schedule_work(&remove_allocinfo_work);
>>         mem_profiling_support = false;
>>  }
>>
>> @@ -1351,16 +1365,10 @@ static int __init alloc_tag_init(void)
>>                 return 0;
>>         }
>>
>> -       if (!proc_create(ALLOCINFO_FILE_NAME, 0400, NULL, &allocinfo_proc_ops)) {
>> -               pr_err("Failed to create %s file\n", ALLOCINFO_FILE_NAME);
>> -               shutdown_mem_profiling(false);
>> -               return -ENOMEM;
>> -       }
>> -
>>         res = alloc_mod_tags_mem();
>>         if (res) {
>>                 pr_err("Failed to reserve address space for module tags, errno = %d\n", res);
>> -               shutdown_mem_profiling(true);
>> +               shutdown_mem_profiling(false);
>>                 return res;
>>         }
>>
>> @@ -1368,10 +1376,22 @@ static int __init alloc_tag_init(void)
>>         if (IS_ERR(alloc_tag_cttype)) {
>>                 pr_err("Allocation tags registration failed, errno = %pe\n", alloc_tag_cttype);
>>                 free_mod_tags_mem();
>> -               shutdown_mem_profiling(true);
>> +               shutdown_mem_profiling(false);
>>                 return PTR_ERR(alloc_tag_cttype);
>>         }
>>
>> +       if (!proc_create(ALLOCINFO_FILE_NAME, 0400, NULL, &allocinfo_proc_ops)) {
>> +               struct codetag_type *cttype = alloc_tag_cttype;
>> +
>> +               pr_err("Failed to create %s file\n", ALLOCINFO_FILE_NAME);
>> +               shutdown_mem_profiling(false);
>> +               WRITE_ONCE(alloc_tag_cttype, NULL);
>> +               synchronize_rcu();
>> +               codetag_unregister_type(cttype);
>> +               free_mod_tags_mem();
>> +               return -ENOMEM;
>> +       }
>> +
>>         return 0;
>>  }
>>  module_init(alloc_tag_init);
>> diff --git a/mm/show_mem.c b/mm/show_mem.c
>> index b938cbcd774a..a2e710404a48 100644
>> --- a/mm/show_mem.c
>> +++ b/mm/show_mem.c
>> @@ -439,7 +439,7 @@ void __show_mem(unsigned int filter, const nodemask_t *nodemask,
>>                 struct codetag_bytes tags[10];
>>                 size_t i, nr;
>>
>> -               nr = alloc_tag_top_users(tags, ARRAY_SIZE(tags), false);
>> +               nr = alloc_tag_top_users(tags, ARRAY_SIZE(tags));
>>                 if (nr) {
>>                         pr_notice("Memory allocations (profiling is currently turned %s):\n",
>>                                 mem_alloc_profiling_enabled() ? "on" : "off");
>> --
>> 2.25.1
>>
