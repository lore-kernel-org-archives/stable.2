Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9633139AD3B;
	Mon, 12 Oct 2026 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816581; cv=none; b=GQ98oRFsfihuOxbjzE0DS2TVI/80zq04zyvyi7n0aaNYXoBTOOnIyIRD/Zlaj3RkknfT1cmex7bi/t1ASI80uh1/n0rpN6DFCut9XosSaik8Cee98voUZ4etKUl56lF233HjZWcJrV9U/IEh9mculq82u/kK+7ANHEATBHbr1nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816581; c=relaxed/simple;
	bh=gNUN1PeLrzguojVepCK36wD7He1jYT3XIVgIRd6U6p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOGuP/nB5eJqjfClkmxYAVJ8B3p73umD5Dq8Ei8keD4mTWVncGflW9DipIO3nR448MP9O8dYyAH56U33q0bdxWl/3CYdNuiaAPom01cYyUlP2Eqbtis6cJSCRes1yAqGV7nhMklRBA0FhVebFHEbjb90OaiQnTac3GUmonCRvzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pAag5HOP; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pAag5HOP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r+N6R62BknSMaVGFnJv8A3+Jyc2QMb/vkx4SHVadquY=; b=pAag5HOPVbCcIdY9v0e3oak/BI
	EZAAhLuer9FAjMK6gp6ice/l+9xBlZKVEo6icX2WMpgob4RLLn0lXFzhSrrh98Izq7FyA5jkdtH1h
	XgSdV+jT5kDZ+nn5a+8eqmtRAli5djnNYu18dt0ISeYYNC8Zl0DGCL4WzjfMwctqGX1SfGoPQSQ4/
	QFZWuzmdcO3o+6+Nf8zOWgnknbNgBxi+VqnF8Nd4sB6wquGwU+3XWh51y5nwwtnXsgJrHdXxNQVBg
	q9rcO5Ecs0W0RE4l+N6/dmuuRdJRzyUlOYKv0J7yAAJ72rvUbMrlonYcxjHsb8tg+gQanpBiflY/i
	c+ulJmng==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGHLK-0000000EWlC-0YQu;
	Mon, 12 Oct 2026 14:49:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2E73E30045A; Mon, 12 Oct 2026 16:49:33 +0200 (CEST)
Date: Mon, 12 Oct 2026 16:49:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>,
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] livepatch: Fix races between stack check and module
 load/unload
Message-ID: <20261012144933.GW2009045@noisy.programming.kicks-ass.net>
References: <20261012140546.154730-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012140546.154730-1-parri.andrea@gmail.com>

On Mon, Oct 12, 2026 at 04:05:45PM +0200, Andrea Parri wrote:
> diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
> index 3f54a017bbf69..d01ec7a6256ab 100644
> --- a/kernel/livepatch/patch.c
> +++ b/kernel/livepatch/patch.c
> @@ -22,15 +22,19 @@
>  
>  static LIST_HEAD(klp_ops);
>  
> +/*
> + * Caller must hold klp_mutex or rcu_read_lock(): klp_check_stack_func() walks
> + * klp_ops from the scheduler without klp_mutex.
> + */
>  struct klp_ops *klp_find_ops(void *old_func)
>  {
>  	struct klp_ops *ops;
>  	struct klp_func *func;
>  
> -	list_for_each_entry(ops, &klp_ops, node) {
> -		func = list_first_entry(&ops->func_stack, struct klp_func,
> -					stack_node);
> -		if (func->old_func == old_func)
> +	list_for_each_entry_rcu(ops, &klp_ops, node, lockdep_is_held(&klp_mutex)) {
> +		func = list_first_or_null_rcu(&ops->func_stack, struct klp_func,
> +					      stack_node);
> +		if (func && READ_ONCE(func->old_func) == old_func)
>  			return ops;
>  	}
>  

> diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> index 2351a19ac2a9e..e9aa16baf1743 100644
> --- a/kernel/livepatch/transition.c
> +++ b/kernel/livepatch/transition.c
> @@ -8,6 +8,7 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/cpu.h>
> +#include <linux/rculist.h>
>  #include <linux/stacktrace.h>
>  #include <linux/static_call.h>
>  #include "core.h"
> @@ -201,12 +202,16 @@ void klp_update_patch_state(struct task_struct *task)
>  /*
>   * Determine whether the given stack trace includes any references to a
>   * to-be-patched or to-be-unpatched function.
> + *
> + * Must be called under rcu_read_lock(), see klp_check_stack().
>   */
>  static int klp_check_stack_func(struct klp_func *func, unsigned long *entries,
>  				unsigned int nr_entries)
>  {
>  	unsigned long func_addr, func_size, address;
> +	struct klp_func *prev;
>  	struct klp_ops *ops;
> +	void *old_func;
>  	int i;
>  
>  	if (klp_target_state == KLP_TRANSITION_UNPATCHED) {

As per always, I much prefer things like lockdep_assert_held() and
__must_hold() over comments.


