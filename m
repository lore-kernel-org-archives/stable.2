Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5345842EED8;
	Thu,  6 Aug 2026 14:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025634; cv=none; b=aXuIttG0+2i6zIA2oHC7s/Akqk9Gvki0pz1HicH70/Mp6Lvy/5kEYaRfmz08U9752wO4DSEM+J7jsqUAUMXnFsOfHLUUbjXSZp0CtrXigUcyfEnbjq8rwxW4JyNO47LnF5mOSxPHDHVQAgKZfqxB5CJtmM6ppPL95lhkgAOqPqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025634; c=relaxed/simple;
	bh=c8v7z+X0uJx+XMONDJIzu1et6BM0Vkgsk0kAbeAluPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToHyo403mmCabvT9syS8woY1SXrU4LKExT/PCh3JHbyUxV4MHxN5+aW688py57bHP8luieaIzTsi2BMhJxQmOm+56t6M83yfkVDK0LbJL9n8kAPymEPvJIZB//nFggSWi/2cVXwNzYytY+Ts19a7fFObSBqIxAbv0qtaS5xPQXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8v1pNGM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8v1pNGM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113591F000E9;
	Thu,  6 Aug 2026 14:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786025631;
	bh=GUMeeKsz24PpxZAbkO6Pk82CWiUyq2afca9g6wm5yyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H8v1pNGMRAtUFKh788pnMEkbQIpZ20rnktk9mYX9rjM1PoYcM8bc5YpWooSpPLAO1
	 00XbKpd1zEgr9tfMupjyO3SGhW8CQCbVNTn/PrWt7zArAv9lcqeauwSb4X5nWYAKRw
	 YxNuyjUxPI2GMkC1L04UmG0fAt59ErhzyQ8npl4BiU+/1ghYOxsfRf2NnGG+a9G64O
	 0/+N5OaIl4KeJo3qVnWIR745mF4z63xWJsaGSC5THmvIkoq0SyGBJ063mRzQ2LgkjN
	 7A7taiMkfLtg0K/ewHb0CXuarnzS++zadX4+8/xCg3t1B3A6uB2k8M41GRj7Wfsan0
	 P2WdzjY7JM+Ag==
Date: Thu, 6 Aug 2026 15:13:31 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: sparkhuang <huangshaobo3@xiaomi.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Kees Cook <kees@kernel.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH] fork: reset pointer tag of vmapped thread stack before
 vfree
Message-ID: <anSVlVpUXrA8ra_z@lucifer>
References: <20260806123020.90869-1-huangshaobo3@xiaomi.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260806123020.90869-1-huangshaobo3@xiaomi.com>

Hi,

This looks AI-generated but I see no Assisted-by tag, please follow kernel
procedure on this please.

https://docs.kernel.org/process/coding-assistants.html

None of your 4 patches pre-dating the slopularity look anything like this.

Also please use a real name.

On Thu, Aug 06, 2026 at 08:30:20PM +0800, sparkhuang wrote:
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
>
> The tag on tsk->stack was already reset to KASAN_TAG_KERNEL (0xFF) by
> commit c08e6a1206e6 ("kasan, fork: reset pointer tags of vmapped
> stacks"), but vm_area->addr still carries the original random tag.
> This is the same class of bug that was fixed for shadow call stacks
> in scs_free() by commit 528a4ab45300 ("scs: Release kasan vmalloc
> poison in scs_free process").
>
> Fix it by resetting the pointer tag before calling vfree(), so that
> vfree_atomic()'s llist_add write uses KASAN_TAG_KERNEL (0xFF), which
> makes KASAN bypass tag checks for that write in all modes (SW_TAGS,
> HW_TAGS, and Generic).
>
> kasan_unpoison_vmalloc() is not needed alongside kasan_reset_tag():
> in HW_TAGS, __kasan_unpoison_vmalloc() is a no-op without
> KASAN_VMALLOC_VM_ALLOC (only KASAN_VMALLOC_PROT_NORMAL is passed);
> in SW_TAGS and Generic, the 0xFF-tagged pointer already bypasses
> shadow checks, so the shadow state is irrelevant.

Output from a repro that you don't share, brilliant.

>
> Fixes: 0f110a9b956c ("kernel/fork: use vfree_atomic() to free thread stack")

A 2016 Fixes for some KASAN state bug? Really?

> Cc: stable@vger.kernel.org

And of course Cc: stable...

> Signed-off-by: sparkhuang <huangshaobo3@xiaomi.com>
> ---
>  kernel/fork.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index f0e2e131a..2fd6fd25c 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -280,7 +280,19 @@ static void thread_stack_free_rcu(struct rcu_head *rh)
>  	if (try_release_thread_stack_to_cache(vm_stack->stack_vm_area))
>  		return;
>
> -	vfree(vm_area->addr);
> +	/*
> +	 * Reset the pointer tag before vfree(): in RCU callback context
> +	 * vfree() routes to vfree_atomic(), which writes to the freed
> +	 * memory as llist storage.  Resetting the tag to KASAN_TAG_KERNEL
> +	 * (0xFF) makes KASAN bypass tag checks for that write in all modes
> +	 * (HW_TAGS, SW_TAGS, Generic), avoiding a false tag-mismatch report.
> +	 *
> +	 * kasan_unpoison_vmalloc() is not needed here: in HW_TAGS it is a
> +	 * no-op without KASAN_VMALLOC_VM_ALLOC, and in SW_TAGS/Generic the
> +	 * 0xFF pointer already bypasses shadow checks.  This mirrors the
> +	 * intent of the fix in scs_free() (commit 528a4ab45300).
> +	 */

Nobody in their right mind does a comment like this for a kasan_reset_tag().

> +	vfree(kasan_reset_tag(vm_area->addr));
>  }
>
>  static void thread_stack_delayed_free(struct task_struct *tsk)
> --
> 2.34.1
>

--
Cheers, Lorenzo
