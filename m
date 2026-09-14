Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACCC37E304;
	Mon, 14 Sep 2026 09:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789379075; cv=none; b=OSX71Grc8u54bLuaq8TgOM20y4V0vsGvU6OZ150ubuOGX39JYabY/0ByLpAkcAKamFxrOmzgSM9ERil0WBkGkNDqviwdwRgXT4r3OWt3A1QDY/cyvL3BaH2a8bijyTeB86Els9dJfH/8iHhDBoTk7m/uGKxxO8ix7rDydyMU0Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789379075; c=relaxed/simple;
	bh=Si4xeoOg6Vd9qWl7+h3jXXtYt9IocrMl6ILVb0P4kRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJOduVEMvx8RQ0OqfSf+uKPMQgQ5oMNoUUPnrykm4tbbdcW0jf0O9BbScNG2vjPxagu2NGA3xfawtZbfqpu4RkzlfSnOdz9uBDjTZ/rZygagDaW0qcXHwieVcrMxQDtZL8q4iZ4iWlTfCPv+nXto04z9cBCBJdXtsDZgfpcVjPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWt7mu4E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWt7mu4E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177691F000FF;
	Mon, 14 Sep 2026 09:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789379074;
	bh=RqhRsSPgAhnByvBCyGHJb2bv4q3f94ZzhrbaeD0aH4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KWt7mu4ELgJGrcVZ0DL9s5IU+inozxhjLkG/29VpB9RV7Eo8oIiU70bBDZPvPzneS
	 LiqWlP2EdIpLG2EUdBQtTTOFwV1nba+iVAEALW6zYxPLztIlB7nwlNuTeoVYhL9FUl
	 hFHXZ199IV6x6mUAumxMRUlCu8ojrfM4kFiBfFpJZlE/Mwt2S25JOPSJx2e1TfZVgN
	 WkBkFLiCFqDUutsuMD2zaG7JOW/CT7l41NeiKp2xG0x7cIywTEsePSq0Ow3wyeTrLd
	 EA7TSY4wyjToX5H+p57WAQLh3Y4UCDQcnwge3VevFbQjxtR4tfd+edoCXs9QTZlKta
	 SZkcnHI0SWyxg==
Date: Mon, 14 Sep 2026 10:44:26 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Shaobo Huang <huangshaobo3@xiaomi.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, akpm@linux-foundation.org, david@kernel.org, kees@kernel.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, kprateek.nayak@amd.com, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, ryabinin.a.a@gmail.com, 
	glider@google.com, andreyknvl@gmail.com, dvyukov@google.com, 
	vincenzo.frascino@arm.com, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH v2] fork: reset pointer tag of vmapped thread stack
 before vfree
Message-ID: <aqfBDEkiRmlb0WWZ@gremlin>
References: <20260806123020.90869-1-huangshaobo3@xiaomi.com>
 <20260914093300.100495-1-huangshaobo3@xiaomi.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914093300.100495-1-huangshaobo3@xiaomi.com>

+cc Ulad for vmalloc stuff.

Please don't send a v2 in-reply-to a v1 or any other email.

Send the patch entirely separately.

I really need to write a bot to say this :)...

On Mon, Sep 14, 2026 at 05:33:00PM +0800, Shaobo Huang wrote:
> thread_stack_free_rcu() frees the vmalloc'd thread stack via
> vfree(vm_area->addr).  In RCU callback context, vfree() routes to
> vfree_atomic(), which calls llist_add((struct llist_node *)addr, ...)
> and writes 8 bytes to the base of the region being freed.
>
> With KASAN_SW_TAGS, vm_area->addr carries a random tag.  If
> kasan_unpoison_task_stack_below() has rewritten the shadow covering
> [base, sp] to KASAN_TAG_KERNEL (0xff) -- which it does on every CPU
> resume for the current task's stack -- the llist_add store checks
> shadow[base] (0xff) against the pointer tag (random) and reports an
> invalid-access, although writing to the base of a stack queued for
> deferred free is legitimate.
>
> Reset the pointer tag to KASAN_TAG_KERNEL before vfree() so that
> kasan_check_range() short-circuits the check, the same way the task
> accesses its own stack at runtime via sp.  The vmalloc lookup is safe:
> __find_vmap_area() resets the tag before comparing against va_start.
>
> Fixes: 9f7d416c3612 ("kprobes: Unpoison stack in jprobe_return() for KASAN")
> Cc: stable@vger.kernel.org
> Assisted-by: zhipuai:glm-5.2

Thanks for adding this!

New convention is to say:

	Assisted-by: LLM

Rather than to list the agent.

See https://docs.kernel.org/process/coding-assistants.html

> Signed-off-by: Shaobo Huang <huangshaobo3@xiaomi.com>

Looks reasonable to me so, with nits addressed:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

But I would like Ulad's input on this from vmalloc side.

> ---
> Changes since v1:

Thanks for adding this!

Nit, but nicer to say 'v2:' here I think.

> - Drop the 12-line comment; keep just the one-line fix.
> - Fix the Fixes: tag to point to the commit that introduced
>   kasan_unpoison_task_stack_below (9f7d416c3612), which added
>   both the function definition and the _cpu_resume call site, not
>   the 2016 vfree_atomic commit.
> - Add Assisted-by tag per Documentation/process/coding-assistants.rst.
> - Use real name (Shaobo Huang) instead of "sparkhuang".
> - Trim the commit message; remove the full KASAN dump.

Please give credit to reviewers for each change, e.g. 'as per XXX' :)

> v1:
>   https://lore.kernel.org/all/20260806123020.90869-1-huangshaobo3@xiaomi.com/
> ---
>  kernel/fork.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 45300f59cf2c..9a66b10749de 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -238,7 +238,7 @@ static void thread_stack_free_rcu(struct rcu_head *rh)
>  	if (try_release_thread_stack_to_cache(vm_stack->stack_vm_area))
>  		return;
>
> -	vfree(vm_area->addr);
> +	vfree(kasan_reset_tag(vm_area->addr));
>  }
>
>  static void thread_stack_delayed_free(struct task_struct *tsk)
> --
> 2.34.1
>

--
Cheers, Lorenzo
