Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7C1381EB7;
	Fri,  7 Aug 2026 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786094853; cv=none; b=ts0ekxfuxSqqiGifr2SpD0YS5x+5ao4ZOsB1LEHkbUFLZcssMZEitultqECOSxvYvXn+MTnMmgZ1piclDbeqdRFYB2rlT6SmxKQU9JHFGA775ZDtAXxiOeUDbPtB4tW209+ixP4g3MCL3eudXikFoiG9Ip62WhMIVIgs1xJDSJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786094853; c=relaxed/simple;
	bh=CKpHaaGkJysaEuldxwrZOynqEbe1wBeKPR5kES0pmdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVVC1NGuoiPSS3GqqI8GELx+Th00kusK51F3Ybns0mt4Ay8bXcdgcEIbfC6cH3HwjY7Y59uieeVsBkPW9nPvO8OroMUIcCbA0aDuN4xron4VHK+/bbabn19W+9FH/Tw/BOE4FrK23HdPWIfoAZ6REQSMBJZujDOFjCHNrPSLlfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9fzMAj9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9fzMAj9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B730B1F000E9;
	Fri,  7 Aug 2026 09:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786094851;
	bh=7bLwVOoBAN+V0pmI0BJbccWYshh97vq0Mu/2qyzbG+w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=A9fzMAj9ZqlgXqw49U/BCd3XPdYf8bRmHb0iQkAJmlBPsGKE2n0LNoj8ahftUza9e
	 4vHcv5Anvq0w8fv0J0C7XBSTHGgK0A5+4sOxLqIktAi7N8stQMHo3OrsWki+1Bhrgx
	 rEEoRehj2rh3kGj7oMjfCUYz9aJA9fuPue/m1jRjx3gI3Wlhogmp8aEXdPrm9gl3pe
	 6aGKZzqAjiEmZ05X9c+Rv8pbgvCvtOpEi9ddp6q3T+uodw11AQyrv2922d8JVFv5kY
	 VAerHya88TvofPgvQCntSWPK6QNdUxZJHQFtsMmxDakis+usg+7MfYgyanFtzEWanE
	 1FV/Ppgf0NU5Q==
Message-ID: <f5af86ba-e724-4b9f-acdb-2445e2ec4b1e@kernel.org>
Date: Fri, 7 Aug 2026 11:27:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fork: reset pointer tag of vmapped thread stack before
 vfree
To: sparkhuang <huangshaobo3@xiaomi.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
References: <20260806123020.90869-1-huangshaobo3@xiaomi.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260806123020.90869-1-huangshaobo3@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/6/26 14:30, sparkhuang wrote:
> When a thread stack is freed via RCU callback,
> thread_stack_free_rcu() calls vfree(vm_area->addr).  In RCU callback
> context (e.g. from rcu_nocb_cb_kthread with BH disabled, or from
> RCU_SOFTIRQ), in_interrupt() returns true, so vfree() routes to
> vfree_atomic().
> 
> vfree_atomic() uses the freed memory as llist storage by calling
> llist_add((struct llist_node *)addr, &p->list), which writes 8 bytes
> to the address being freed.  With KASAN SW_TAGS enabled,
> vm_area->addr carries a random tag assigned during allocation by
> kasan_unpoison_vmalloc().  If the shadow memory covering this region
> has been set to KASAN_TAG_KERNEL (0xFF) — e.g. by
> kasan_unpoison_task_stack() using task->stack, which was already
> reset to 0xFF by kasan_reset_tag() at allocation time — the shadow
> byte (0xFF) no longer matches the pointer tag on vm_area->addr,
> and the write in llist_add triggers a KASAN invalid-access report:
> 
>   ==================================================================
>   BUG: KASAN: invalid-access in vfree_atomic+0x90/0x150
>   Write of size 8 at addr c2ffffc0a8f70000 by task rcuop/7/75
>   Pointer tag: [c2], memory tag: [ff]
> 
>   CPU: 5 UID: 0 PID: 75 Comm: rcuop/7 Tainted: G S      W  OE
>   Hardware name: XiaoMi Xring_o1 UDP PHONE (DT)
>   Call trace:
>    show_stack+0x18/0x28
>    __dump_stack+0x28/0x3c
>    dump_stack_lvl+0xac/0xf0
>    print_address_description+0x7c/0x25c
>    print_report+0x70/0x8c
>    kasan_report+0xdc/0x13c
>    __hwasan_store8_noabort+0xe8/0xf8
>    vfree_atomic+0x90/0x150
>    vfree+0x220/0x298
>    thread_stack_free_rcu+0x3c/0x4c
>    rcu_do_batch+0x308/0xaf0
>    rcu_nocb_cb_kthread+0x33c/0x708
>    kthread+0x364/0x3cc
>    ret_from_fork+0x10/0x20
> 
>   The buggy address belongs to a 8-page vmalloc region starting at
>   0xc2ffffc0a8f70000 allocated at copy_process+0x1ac/0x12e4
> 
>   Memory state around the buggy address:
>    ffffffc0a8f6ff00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>   >ffffffc0a8f70000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>                       ^
>    ffffffc0a8f70100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>   ==================================================================

Were you able to reproduce this more than once?

Does this relate to CONFIG_KASAN_STACK? Can you share the kernel config?

-- 
Cheers,

David
