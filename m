Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8566338E8C7;
	Thu,  6 Aug 2026 07:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786001576; cv=none; b=u8eCuxrfBgbTQ1ICWxg/wkA8Y70DgX4+nJn55P47f6E6dpfNN6ECVJv2aqQqZs4DbGsXmiFwAEXfIZKEWPwKM4l4LgqaS2iQ1Lfubpg9NmBZHjpCvWp+rXsUPB54iIIEOiknClUlz9gKxPszU+VVV5aQf1/FvyIQH0ugAWtE8dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786001576; c=relaxed/simple;
	bh=G555qcSTABNjTGl5WJmuY4hJyTDyo/R9g//LjIH7osY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkweSULJFygPqVBn9uPN4aXDF0ranq2pQpOy6FM7quUQjXIoLhvcShOVYGIJSD7wXBSZI9cWaJASccjXmLtn29YBUN5amt9AqUobSgeBe4+87yGLURTRIyA7XwmBqVW22Dv90MglluPm/yx2GH+ksdKueT0LPJCQnpmD/9EmcII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oVLfE200; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oVLfE200"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iky40uyxfSucD4SrN1FwgoAHOq3IOpXgMvFnUdxhBGw=; b=oVLfE20026jMBQejgucwqsOTBN
	q82ZZgTwbpFAV+n0f0MUEcR6iLB3aBWOVDTsdbyUnskafAMMfySTWjmBrqlPdYBwy3NwiUINkGFix
	8wK214bo/nQVetj9lZVpO+sljlgh0ujDgTzCuTKeRLpWNpP/sC6mEUyFzRDidwo5cMtxyBDG+X4Vo
	w/j+UuiG6vydtpnXLafGtg2RNLMLF9ujE0/55P0no8szRcySMYe7noBETNEkPaHuK1Q9N+iaU4XRL
	e/gUqSNqM3ihSZ1SonoJsDCKOUzOB+FV1y8nd2xTiNL29LqOFQSqpdAkLS65iYUI26k/wI2Hygn68
	MxKJww5A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrsaq-00000008gO0-43ll;
	Thu, 06 Aug 2026 07:32:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6CC69301519; Thu, 06 Aug 2026 09:32:44 +0200 (CEST)
Date: Thu, 6 Aug 2026 09:32:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jann Horn <jannh@google.com>
Cc: John Johansen <john.johansen@canonical.com>,
	John Johansen <john@apparmor.net>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	apparmor@lists.ubuntu.com, Paul Moore <paul@paul-moore.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Morris <jmorris@namei.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	kernel list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] apparmor: fix cred UAF caused by
 begin_current_label_crit_section()
Message-ID: <20260806073244.GM49951@noisy.programming.kicks-ass.net>
References: <20260714-fix-apparmor-cred-uaf-v1-1-be40e8c83b90@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714-fix-apparmor-cred-uaf-v1-1-be40e8c83b90@google.com>

On Tue, Jul 14, 2026 at 05:38:07PM +0200, Jann Horn wrote:

> diff --git a/include/linux/task_work.h b/include/linux/task_work.h
> index 0646804860ff..ce19fc14060c 100644
> --- a/include/linux/task_work.h
> +++ b/include/linux/task_work.h
> @@ -33,6 +33,7 @@ struct callback_head *task_work_cancel_match(struct task_struct *task,
>  	bool (*match)(struct callback_head *, void *data), void *data);
>  struct callback_head *task_work_cancel_func(struct task_struct *, task_work_func_t);
>  bool task_work_cancel(struct task_struct *task, struct callback_head *cb);
> +bool task_work_has_func(struct task_struct *task, task_work_func_t func);
>  void task_work_run(void);
>  
>  static inline void exit_task_work(struct task_struct *task)
> diff --git a/kernel/task_work.c b/kernel/task_work.c
> index 0f7519f8e7c9..f83d1528e0bc 100644
> --- a/kernel/task_work.c
> +++ b/kernel/task_work.c
> @@ -189,6 +189,20 @@ bool task_work_cancel(struct task_struct *task, struct callback_head *cb)
>  	return ret == cb;
>  }
>  
> +bool task_work_has_func(struct task_struct *task, task_work_func_t func)
> +{
> +	struct callback_head *work;
> +
> +	if (!task_work_pending(task))
> +		return false;
> +	guard(raw_spinlock_irqsave)(&task->pi_lock);
> +	for (work = READ_ONCE(task->task_works); work; work = READ_ONCE(work->next)) {
> +		if (work->func == func)
> +			return true;
> +	}
> +	return false;
> +}
> +
>  /**
>   * task_work_run - execute the works added by task_work_add()
>   *

This thing is quite terrible. And AFAICT the only purpose is to
determine if said task already has said function enqueued. Why not add a
single bit to struct task_struct for this? I'm sure we have a spare bit
somewhere.

> +/* replace the current task's stale label on syscall return */
> +void aa_schedule_stale_label_replacement(void)
> +{
> +	struct callback_head *tw;
> +
> +	if (task_work_has_func(current, aa_replace_stale_label_tw_func))
> +		return;
> +	tw = kmalloc_obj(struct callback_head);
> +	if (!tw)
> +		return;
> +	init_task_work(tw, aa_replace_stale_label_tw_func);
> +	if (task_work_add(current, tw, TWA_RESUME))
> +		kfree(tw);
> +}

