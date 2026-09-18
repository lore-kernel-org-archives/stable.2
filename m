Received: from mta0.migadu.com (out-208.mta0.migadu.com [91.218.175.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853BD395AFE
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 01:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789695505; cv=none; b=ltaNNpErqmkYn82gHsF8+W9WSL/0+73HyYM4eYOKvcPQU63V/l6F6ArXFRYMn2THomJ+JBIkGpGuxXIPtLNwmmbdEJvwKpKsJYZTvnACoOUAVnxjdmxUaX2T5OciM7955oDEg0lv2m8QGqLObLw9c5wod4rRqc0yk5Kl5XD03dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789695505; c=relaxed/simple;
	bh=nhaB4QCyvY2vj/8aUqYIKXSALA608i9qAGxN94zUC5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmFf8b1tViZTubXXCl3e1ozIDzqL2GmL7dl2omC2IV/D6CYPnDLTfe1q7RxWDPXwnOA+b8t1bJosMQim/Agrc3KdMCnXESRyL9ZK7pgprmzolis/lJGp+0RCfOOPJl9I1Gvw9FDJ8xoNUXGcHjyeCwjdd4i2PTw72euasKd+lkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HAvJJQz0; arc=none smtp.client-ip=91.218.175.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HAvJJQz0"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nhaB4QCyvY2vj/8aUqYIKXSALA608i9qAGxN94zUC5o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789695500; v=1; x=1790300300;
 b=HAvJJQz0TIzLUIFAdl3YNUx8wR5LfXsxyzZEgqmASqxWFXXgizDSQfifrtIrPdNXMJ1PYVQt
 jTrjTQqLJZDPgoVDGZzAtVGKUI0luDbEqDIVBhf0SZKlkDzkWoKMPXvaWY0kp/CZdpffFB4BuSQ
 licyAOnlz1qtWlDCslxcgpyk=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9f10f04cf85e3f6a;
	Fri, 18 Sep 2026 01:38:20 +0000
X-Mizu-Trace-ID: 9f10f04cf85e3f6a
X-Migadu-Flow: FLOW_OUT
Message-ID: <d7327cdd-43df-46f8-92d4-c25dda7ae684@linux.dev>
Date: Fri, 18 Sep 2026 09:39:12 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 6/6] alloc_tag: Defer /proc/allocinfo removal to a
 workqueue
To: Suren Baghdasaryan <surenb@google.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, linux-modules@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20260915070001.113559-1-hao.ge@linux.dev>
 <20260915070001.113559-7-hao.ge@linux.dev>
 <CAJuCfpGMQqjHsAvW=XUA1Q3AyaVJKM2bKYVja_fgn0wa1tk7DA@mail.gmail.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpGMQqjHsAvW=XUA1Q3AyaVJKM2bKYVja_fgn0wa1tk7DA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Suren


On 2026/9/18 09:09, Suren Baghdasaryan wrote:
> On Mon, Sep 14, 2026 at 11:59 PM Hao Ge <hao.ge@linux.dev> wrote:
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
>> The file creation is moved to the end of alloc_tag_init() as well.
>> If alloc_tag_init() fails with alloc_tag_cttype still NULL or an
>> error pointer, a concurrent reader of the leftover file would
>> dereference it in allocinfo_start() and panic.
>>
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>> ---
>>  mm/alloc_tag.c | 26 +++++++++++++++++---------
>>  1 file changed, 17 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
>> index 1ca0409b492b..cfa0fc84b68f 100644
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
>> @@ -591,6 +592,13 @@ void pgalloc_tag_swap(struct folio *new, struct folio *old)
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
>> @@ -600,7 +608,7 @@ static void shutdown_mem_profiling(bool remove_file)
>>                 return;
>>
>>         if (remove_file)
>> -               remove_proc_entry(ALLOCINFO_FILE_NAME, NULL);
>> +               schedule_work(&remove_allocinfo_work);
>>         mem_profiling_support = false;
>>  }
>>
>> @@ -1358,16 +1366,10 @@ static int __init alloc_tag_init(void)
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
>> @@ -1375,10 +1377,16 @@ static int __init alloc_tag_init(void)
>>         if (IS_ERR(alloc_tag_cttype)) {
>>                 pr_err("Allocation tags registration failed, errno = %pe\n", alloc_tag_cttype);
>>                 free_mod_tags_mem();
>> -               shutdown_mem_profiling(true);
>> +               shutdown_mem_profiling(false);
>>                 return PTR_ERR(alloc_tag_cttype);
>>         }
>>
>> +       if (!proc_create(ALLOCINFO_FILE_NAME, 0400, NULL, &allocinfo_proc_ops)) {
>> +               pr_err("Failed to create %s file\n", ALLOCINFO_FILE_NAME);
>> +               shutdown_mem_profiling(false);
> 
> You need free_mod_tags_mem() here.
>

Right. Another problem is exposed here: moving proc_create() to the end
implies successful return from codetag_register_type(),
so alloc_tag is already added into codetag_types.
That looks a bit odd to me. Because all places inside codetag that access this
linked list will access this incompletely‑initialized codetag_type.
There is currently no matching unregister interface to tear it down.
So I drafted one previously:
void codetag_unregister_type(struct codetag_type *cttype)                                                                                                                                                                                                                      
{                                                                                                                                                                                                                                                                              
	struct codetag_module *cmod;                                                                                                                                                                                                                                                 
	unsigned long id, tmp;                                                                                                                                                                                                                                                       
                                                                                                                                                                                                                                                                             
	mutex_lock(&codetag_lock);                                                                                                                                                                                                                                                   
	list_del(&cttype->link);                                                                                                                                                                                                                                                     
	mutex_unlock(&codetag_lock);                                                                                                                                                                                                                                                 
                                                                                                                                                                                                                                                                              
	codetag_lock_module_list(cttype);                                                                                                                                                                                                                                               
	idr_for_each_entry_ul(&cttype->mod_idr, cmod, tmp, id)                                                                                                                                                                                                                       
		kfree(cmod);                                                                                                                                                                                                                                                               
	idr_destroy(&cttype->mod_idr);                                                                                                                                                                                                                                               
	codetag_unlock_module_list(cttype);                                                                                                                                                                                                                                                 
                                                                                                                                                                                                                                                                             
	kfree(cttype);                                                                                                                                                                                                                                                               
}

But looking back, do we really need to do this? I'm not so sure.
I previously thought the issue reported by Sashiko was a false positive,
and I laid out my thoughts back then:
https://lore.kernel.org/all/afa606df-3d5b-47c2-9972-f3e0c2e13c12@linux.dev/
and I thought the change would be straightforward, and defensive programming
felt acceptable to me, but it turns out to be a little more complex than I expected.

Suren, could you help me analyze this? Thank you very much for your valuable feedback

Thanks
Best Regards
Hao

>> +               return -ENOMEM;
>> +       }
>> +
>>         return 0;
>>  }
>>  module_init(alloc_tag_init);
>> --
>> 2.25.1
>>
