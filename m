Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505814;
	b=FRp7wNBTjqaNNQaajQPgEq3sYW1jJ8PkhxWzsbZzP8b+o6vtazsZULMOgxmYwCTHNz5+
	 BSGl6yARdDlSZ4DAx9dYpLiTBp231QO5zTs2mHx5GdJMMy3bt14Y/Au3Ttq7OS0ZwJ4QX
	 6x0HJxy8KdvKHeswd4yMU3AMhPfIRgB6/RhS1lU52YjL3IVzspGH1cLjEsEACN/Fs9nkg
	 hiQJJj4VUAahJ96aALjbHXSQgY02lUMMGWtvpneSYMvAdHJkT0sITHURAyEtTocJdkt2a
	 gke+svKxHNewvtjVJhMc2Ri0LJScJ2jReqc/YPY4ocZ41MdIjYBCWdaaFm+3PBIuVkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ebBi69aOwYuOv4v76Io54mnX1WxFsXlJh7CWwOPIC7M=;
	b=hHWLsGdH9DF4LgNFDkZxQrf/DsOOW6j5F2Fd5tPbMPPPSu8U9v4gyUIoOVPvVsxYsxza
	 wUHpTTfIKU5cC+CdZtYmzTno/kpiljRgrVpTOvRGdt0BG6vmZC6Lu0ZfGGzoOEy1VYzpG
	 9yYzvKIaaSZsZa53KOX4324sjxW8ViBvGp7oG2lh773uyf3hGbX3fmgaMi5HzsPTlRUqE
	 J79MD/YvCA0o8TlPdp/cG7DrCuBo2eDoaT9QM9PKuj7WqLlNzFIIhF2zoxpVsF87pxCoX
	 9pK61leyJgmyVq8S+3/Mz5vRP/rv4zhhMvLIMDCRwiy8wrN0DbIXrBLx7JhbPBeM1gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=cQUjrV0C;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2CA606A327
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A2CA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=cQUjrV0C
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so1205415e9.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 09:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794505812; x=1795110612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ebBi69aOwYuOv4v76Io54mnX1WxFsXlJh7CWwOPIC7M=;
        b=cQUjrV0CyahQPCNi5cU5YxS901CR+57CuvbolcO9byjlPxNsPnPJuVVQZ1ys9UHRm8
         mqZAzSk0r/lFrm6wpcmNXtqZmgHG6hnPbO7peeo3fOpKgtSIdB+voi16FchZ3n+h6Bbx
         IJqjNGaFfl7fZn3BrMYhsoj6W+RTvX45QR2gYZbvOHS0zJ+R7RhakhjFFaBh5E+ODoxw
         +Z64DiPbwjKA2mbtzlbTRs6GWaMA0sMlfqvZFi4aZM7HnQHvEcz54q1RFHdoHgHmme+T
         4p7vs4+77E78N8xxqNiVdlkFstEq3d0O3RbaUxXZEpQ8J+FpXo6xtp2LLGurOiYywzBW
         ME1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794505812; x=1795110612;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ebBi69aOwYuOv4v76Io54mnX1WxFsXlJh7CWwOPIC7M=;
        b=hkQCBC+FRa68/3BeJa7H8bkYCp6eV5G6H6SZyrAZDz7RKmizdRxSNx8DWZqsu8Y9G7
         GUeHzuvRJDou+kQ7aJBO3qtJfgyzlTfLSu+0+azj6JQ7w2Zbs6GWCY+AeuJdy4nn1zGL
         9QLL4DSIwHZz4BsP+IxhtKNK3mthSKB9y1zUX8uzSqRTb3CPEe5bvoHzHYTFqYtr8CuG
         OoZ3YJgvHOLy6/jjTny3jearyzlP6Mxi6Gvtej3jJbs1px6bcnOid0fwDrDPJjSaVsaK
         QSdpd2GpRz2pYxOvXobECTwfkMaRsC3hHsx6aPTI6kYkmgkr2cQHksYT8YvwT65tRlKf
         KUNg==
X-Forwarded-Encrypted: i=1; AL+hErGsDeyyyb2Zt5Kz82aDPxi6CiZj3q4oarFCdovDFHtavhcy3YTQw/Eufi1fw9UGrQGubKFJ5rE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8l/21uTOs6MidTS4KAQx8y3ThAdCY6A+JdonlrXrJ9hkWnsg+T
	f3eMAOllXE2KBm7uuY5m6tdKqS0nP0+4q4+UQQoo537gZejWMU0bPe7gE52TQhRUlbc=
X-Gm-Gg: AYBFou37y008MIl9A8rHlejkuWdsIhdnvyuBDKOpGmAV6Ug8thNyC7FB5WJE4FMW+Pd
	sfhuhsf6zpZ+xQuKic3xHJk68vw0Gphuobxnls1fSQPC+4Tsb5w4tkXlBzwHOErIjQjvybek0lm
	8HkgLIu2n3o/sSmvX6wN4mmnnwR9QP+On0M0lPUKIrq3iLgtjkkDzeCbVEN7GntK2cNyS/IXR08
	D7lY0pXcJ1SJc8nTbe2kfhoMDodlC5oYLHj2U4tp5Cua+Xq6bKeRMAiA926tWNvrOZNuep4HBpc
	THTQpWELyQiPMe6V1LE0RuGo6tvce4BvF5khZ2RY+22BUDQNYYINzAp642UDSNiPeufYUubjfmg
	qYJY88xm8Ik96+yVi91HV4FR/7GFKqoEi5FZB8mzAuvU/Z7CeukV1ZsaXzum5z0+DCkCaz+qhIX
	IQE6OyTVy4zAcBPX9fwNbofm2d3pI5OT5s05HLyIWrlqHHJyZeVInsaxc+4b5GFdCTx/xMt8TnY
	EQMmRDOaLI37OZH9aB6qkB4pGyK/wUbOqYL0+MjPXaYCAPZ+iDPyVvv/mg5T51JriXiXf6srISe
	B1MiNB60bXaVGy5v9hmlnuE9uKGIWfk=
X-Received: by 2002:a05:600c:5251:b0:4a7:4697:dae3 with SMTP id 5b1f17b1804b1-4ba0938d96dmr121010175e9.24.1794505812295;
        Thu, 12 Nov 2026 09:50:12 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5ff2be55sm498229f8f.28.2026.11.12.09.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:50:11 -0800 (PST)
Date: Thu, 12 Nov 2026 18:50:09 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>, Petr Pavlu <petr.pavlu@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] livepatch: Fix races between stack check and module
 load/unload
Message-ID: <avX8UWAA4DN44p6o@pathway.suse.cz>
References: <20261022134433.3595212-1-parri.andrea@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022134433.3595212-1-parri.andrea@gmail.com>

Hi,

I have finally found time and energy to scratch my head around this.
I am sorry that it took so long.

The solution is still a bit complicated. But maybe, we could simplify
it even more, see below.

On Thu 2026-10-22 15:44:31, Andrea Parri wrote:
> Unloading a patched module while a livepatch transition is in progress
> can crash the kernel in klp_find_ops(), called from the scheduler.
> 
> The scheduler checks the stack of a task that still has to switch
> without klp_mutex: __klp_sched_try_switch() -> klp_try_switch_task() ->
> klp_check_stack().  The check walks the global klp_ops list and each
> func_stack, and reads obj->patched.
> 
> Loading or unloading a patched module changes these lists in
> klp_patch_func() and klp_unpatch_func() under klp_mutex only, and
> unloading frees the ops, so the walk can follow a freed entry.

To make sure that I understand it correctly. I looked at [v1] and it
solved the problems:

  + racy access to func->old_func, func->new_func, obj->patched
    by using READ_ONCE() and WRITE_ONCE().

  + UAF access to ops->node by RCU.

There are few more details in v1 but they do not look that important
for what I want to say below.

[v1] https://lore.kernel.org/r/20261012140546.154730-1-parri.andrea@gmail.com

> Protect the lists and obj->patched with a raw spinlock, klp_ops_lock.
> Writers take it only around the list updates, as the ftrace calls in
> klp_patch_func() and klp_unpatch_func() can sleep, and free the ops
> after dropping it.  klp_check_stack() only trylocks it, and checks the
> task again later if that fails.
> 
> __klp_unpatch_object() now clears obj->patched before it unpatches the
> functions, so that the stack check skips an object whose functions are
> being removed.

So, v2 tries to solve the problems by:

  + taking klp_ops_lock around manipulating: ops->node, func->stack_node,
      ops->func_stack, obj->patched

  + manipulating obj->patched after obj->funcs are ready
    manipulating obj->patched before removing obj->funcs

  + taking klp_ops_lock around klp_for_each_object() in
     klp_check_stack()

You see how the two versions are different. In fact, they have
only the obj->patched manipulation in common.

IMHO, we need to better document the solution so that
we understand it later. Or maybe even make it easier,
see below.


> --- a/kernel/livepatch/patch.c
> +++ b/kernel/livepatch/patch.c
> @@ -22,11 +22,21 @@
>  
>  static LIST_HEAD(klp_ops);
>  
> +/*
> + * klp_check_stack() walks klp_ops and the func_stacks from the scheduler,
> + * without klp_mutex, while a patched module can be loaded or unloaded.
> + * Changes to these lists and to obj->patched are made under this lock too.
> + */
> +DEFINE_RAW_SPINLOCK(klp_ops_lock);
> +
>  struct klp_ops *klp_find_ops(void *old_func)
>  {
>  	struct klp_ops *ops;
>  	struct klp_func *func;
>  
> +	lockdep_assert(lockdep_is_held(&klp_mutex) ||
> +		       lockdep_is_held(&klp_ops_lock));
> +
>  	list_for_each_entry(ops, &klp_ops, node) {
>  		func = list_first_entry(&ops->func_stack, struct klp_func,
>  					stack_node);
> @@ -147,11 +157,15 @@ static void klp_unpatch_func(struct klp_func *func)
>  		WARN_ON(unregister_ftrace_function(&ops->fops));
>  		WARN_ON(ftrace_set_filter_ip(&ops->fops, ftrace_loc, 1, 0));
>  
> +		raw_spin_lock(&klp_ops_lock);
>  		list_del_rcu(&func->stack_node);
>  		list_del(&ops->node);
> +		raw_spin_unlock(&klp_ops_lock);
>  		kfree(ops);

This is called for the very last entry when the 'ops' is freed.
Is the lock really needed here?

IMHO, klp_check_stack() should never see this entry because
obj->patched is disabled before, see below.


>  	} else {
> +		raw_spin_lock(&klp_ops_lock);
>  		list_del_rcu(&func->stack_node);
> +		raw_spin_unlock(&klp_ops_lock);

This is called when ops->func_stack has more entries and we
just remove remove one.

What exactly the lock synchronizes here, please?

IMHO, it is related to:

static int klp_check_stack_func(struct klp_func *func, unsigned long *entries,
				unsigned int nr_entries)
{
[...]
		/*
		 * Check for the to-be-patched function
		 * (the previous func).
		 */
		ops = klp_find_ops(func->old_func);

		if (list_is_singular(&ops->func_stack)) {
			/* original function */
			func_addr = (unsigned long)func->old_func;
			func_size = func->old_size;
		} else {
			/* previously patched function */
			struct klp_func *prev;

			prev = list_next_entry(func, stack_node);
			func_addr = (unsigned long)prev->new_func;
			func_size = prev->new_size;
		}
	}

Now, when I look what v1 did here:

  1. It used RCU to access ops and it expected that it might be NULL.
     Also it replaced list_next_entry() with list_next_or_null_rcu().

     IMHO, this is only relevant for the last entry in ops
     which klp_check_stack() should never see as explained above.


  2. It used READ_ONCE(func->old_func).

     IMHO, the spin lock would be needed here only when
     it synchronizes the modification of func->old_func here.

     I think that we do not need the spin lock here because
     func->old_func is cleared in klp_free_object_loaded()
     which is called after obj->patched is cleared under
     the spin lock.

>  	}

Summary: IMHO, we do not need to take the spin lock here in
	klp_unpatch_func(). It should be enough to take
	it around manipulating obj->patched.

>  
>  	func->patched = false;
> @@ -191,11 +205,13 @@ static int klp_patch_func(struct klp_func *func)
>  				  FTRACE_OPS_FL_IPMODIFY |
>  				  FTRACE_OPS_FL_PERMANENT;
>  
> -		list_add(&ops->node, &klp_ops);
> -
>  		INIT_LIST_HEAD(&ops->func_stack);
>  		list_add_rcu(&func->stack_node, &ops->func_stack);
>  
> +		raw_spin_lock(&klp_ops_lock);
> +		list_add(&ops->node, &klp_ops);
> +		raw_spin_unlock(&klp_ops_lock);

First, this is not consistent with the "unpatch" code path
where we take the lock around both:

		list_del_rcu(&func->stack_node);
		list_del(&ops->node);

But again, this is the code path for the first entry in the freshly
allocated "ops". Nobody could see it until obj->patched is enabled
in klp_patch_object().

   => the lock should not be needed here.

> +
>  		ret = ftrace_set_filter_ip(&ops->fops, ftrace_loc, 0, 0);
>  		if (ret) {
>  			pr_err("failed to set ftrace filter for function '%s' (%d)\n",
> @@ -213,7 +229,9 @@ static int klp_patch_func(struct klp_func *func)
>  
>  
>  	} else {
> +		raw_spin_lock(&klp_ops_lock);
>  		list_add_rcu(&func->stack_node, &ops->func_stack);
> +		raw_spin_unlock(&klp_ops_lock);

This is the code patch for adding one more entry on the stack.
I am not sure why we would need the lock here.

It might be needed only for the race in func->old_addr. But I think
list_add_rcu() already includes the barrier.

>  	}
>  
>  	func->patched = true;
> @@ -221,8 +239,10 @@ static int klp_patch_func(struct klp_func *func)
>  	return 0;
>  
>  err:
> +	raw_spin_lock(&klp_ops_lock);
>  	list_del_rcu(&func->stack_node);
>  	list_del(&ops->node);
> +	raw_spin_unlock(&klp_ops_lock);

Like above.

>  	kfree(ops);
>  	return ret;
>  }
> @@ -231,6 +251,13 @@ static void __klp_unpatch_object(struct klp_object *obj, bool nops_only)
>  {
>  	struct klp_func *func;
>  
> +	/* Make klp_check_stack() skip the object before its funcs go away. */
> +	if (obj->dynamic || !nops_only) {
> +		raw_spin_lock(&klp_ops_lock);
> +		obj->patched = false;
> +		raw_spin_unlock(&klp_ops_lock);
> +	}

IMHO, this is the only location where we need to take the
spinlock in the klp_unpatch_object_loaded() code path.

> +
>  	klp_for_each_func(obj, func) {
>  		if (nops_only && !func->nop)
>  			continue;
> @@ -238,9 +265,6 @@ static void __klp_unpatch_object(struct klp_object *obj, bool nops_only)
>  		if (func->patched)
>  			klp_unpatch_func(func);
>  	}
> -
> -	if (obj->dynamic || !nops_only)
> -		obj->patched = false;
>  }
>  
>  
> @@ -264,7 +288,10 @@ int klp_patch_object(struct klp_object *obj)
>  			return ret;
>  		}
>  	}
> +

This would deserve similar comment like klp_unpatch_object(), e.g.:

	/*
	 * Allow klp_check_stack() to check the object only after funcs
	 * are initialized.
	 */

> +	raw_spin_lock(&klp_ops_lock);
>  	obj->patched = true;
> +	raw_spin_unlock(&klp_ops_lock);

Also this looks important to avoid races. But maybe not because
the main problem was when unloading the livepatched module.

>  	return 0;
>  }
> --- a/kernel/livepatch/transition.c
> +++ b/kernel/livepatch/transition.c
> @@ -266,14 +269,20 @@ static int klp_check_stack(struct task_struct *task, const char **oldname)
>  		return -EINVAL;
>  	nr_entries = ret;
>  
> -	klp_for_each_object(klp_transition_patch, obj) {
> -		if (!obj->patched)
> -			continue;
> -		klp_for_each_func(obj, func) {
> -			ret = klp_check_stack_func(func, entries, nr_entries);
> -			if (ret) {
> -				*oldname = func->old_name;
> -				return -EADDRINUSE;
> +	/*
> +	 * The lock is taken by module load/unload and by stack checks on other
> +	 * CPUs.  Do not spin on it from the scheduler, retry the task later.
> +	 */
> +	scoped_cond_guard(raw_spinlock_try, return -EAGAIN, &klp_ops_lock) {
> +		klp_for_each_object(klp_transition_patch, obj) {
> +			if (!obj->patched)
> +				continue;
> +			klp_for_each_func(obj, func) {
> +				ret = klp_check_stack_func(func, entries, nr_entries);
> +				if (ret) {
> +					*oldname = func->old_name;
> +					return -EADDRINUSE;
> +				}
>  			}
>  		}
>  	}

And of course, this is important.

> @@ -300,7 +309,7 @@ static int klp_check_and_switch_task(struct task_struct *task, void *arg)
>  /*
>   * Try to safely switch a task to the target patch state.  If it's currently
>   * running, or it's sleeping on a to-be-patched or to-be-unpatched function, or
> - * if the stack is unreliable, return false.
> + * if the stack is unreliable, or if klp_ops_lock is busy, return false.
>   */
>  static bool klp_try_switch_task(struct task_struct *task)
>  {
> @@ -344,6 +353,10 @@ static bool klp_try_switch_task(struct task_struct *task)
>  		pr_debug("%s: %s:%d is sleeping on function %s\n",
>  			 __func__, task->comm, task->pid, old_name);
>  		break;
> +	case -EAGAIN:	/* klp_check_and_switch_task() */
> +		pr_debug("%s: %s:%d could not be checked, klp_ops_lock is busy\n",
> +			 __func__, task->comm, task->pid);
> +		break;

And this.

>  
>  	default:
>  		pr_debug("%s: Unknown error code (%d) when trying to switch %s:%d\n",
> 
> base-commit: a804c5742bff224d4cb4d25dd383554d598be32b

I am sorry once again for the late reply. I hope that you still might
be able to handle the feedback and eventually test the simplified patch.

Best Regards,
Petr
