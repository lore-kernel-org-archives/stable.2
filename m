Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7673769E6
	for <stable@vger.kernel.org>; Sat, 13 Jun 2026 10:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781347534; cv=none; b=BPj2xrdyzuDEZ2a6WY8JfQujaP4V52ue623xenhutUeoqQONJ9rWTGRHgAkK+s5E2GeWLXSjkk3DpvFqCkXLU2GsY8TkOjILD+BR7OpvRLIWhgeW6RqCdGkAA0/IH35VEpV8Jy854nSsMV7Sgo8EIvyed8dtFkpzEu//vE5zCNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781347534; c=relaxed/simple;
	bh=emc8m6OlD7VMdxRW7IDvqajEHlfMACphdp9G63UhcRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMp6pFhMeF5J9TlAALKjGTHC2DAoEekbrusHsDQF6SEDEONQ3f7iWSivTm2gNdDOOrkzBtCkeFvq8IfFIEDP5VryttVsnWJHFYsYnhXGQFGmyu7L0dYnhYYf9MBq/aWTK90CZaFdPmrgIZbSRPN8q80oyVPw+7VWuUTE3PJXjTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XG1hBZab; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XG1hBZab"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781347532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t0Rdn7ZGItclRk/+njrMNwKPmYdf4WznHl68jVY8zfQ=;
	b=XG1hBZabBIkpL36bh+g4EvuvOFm4yjvsfFicNrPrWms7ju6SDWd/FnmjpLmYty5ldgnVtw
	ZLvoND3Ms26x1E5gvlwN2d4dST8btCG7dJJ0yCwmYz2daI0k5lfN3T/hrXXMx4kp1ndAxt
	u9Ggt9OqOTgRIul6fbeaqDNbtOxl6jo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-1KrHt5iEPg-CfOpTqeYkSw-1; Sat,
 13 Jun 2026 06:45:26 -0400
X-MC-Unique: 1KrHt5iEPg-CfOpTqeYkSw-1
X-Mimecast-MFC-AGG-ID: 1KrHt5iEPg-CfOpTqeYkSw_1781347525
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 33E3719540C3;
	Sat, 13 Jun 2026 10:45:25 +0000 (UTC)
Received: from fedora (unknown [10.22.88.101])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D834D180049F;
	Sat, 13 Jun 2026 10:45:21 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 13 Jun 2026 12:45:24 +0200 (CEST)
Date: Sat, 13 Jun 2026 12:45:20 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>, lance.yang@linux.dev,
	Davidlohr Bueso <dave@stgolabs.net>, Qian Cai <cai@lca.pw>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/kmemleak: avoid soft lockup when scanning task
 stacks
Message-ID: <ai00wD4ICs1nk4zf@redhat.com>
References: <20260612-kmemleak-stack-resched-v2-1-53240de79e88@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612-kmemleak-stack-resched-v2-1-53240de79e88@debian.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

To avoid the confusion, I see nothing wrong in this patch, but see
the question at the end.

On 06/12, Breno Leitao wrote:
>
> +/*
> + * Briefly drop the RCU read lock to reschedule during the task stack scan.
> + * Both cursors are pinned across the gap; return false if either one was
> + * unhashed meanwhile, so the caller stops this round instead of walking a
> + * stale list.
> + */
> +static bool kmemleak_stack_scan_break(struct task_struct *g,
> +				      struct task_struct *p)
> +{
> +	bool can_cont;
> +
> +	get_task_struct(g);
> +	get_task_struct(p);
> +
> +	rcu_read_unlock();
> +	cond_resched();
> +	rcu_read_lock();
> +
> +	can_cont = pid_alive(g) && pid_alive(p);
> +
> +	put_task_struct(p);
> +	put_task_struct(g);
> +
> +	return can_cont;
> +}

Perhaps we can rename and export rcu_lock_break() to avoid the duplication...

And, this is slightly off-topic, please ignore, but this reminds me about
[PATCH 1/2] introduce for_each_process_thread_break() and for_each_process_thread_continue()
https://lore.kernel.org/all/20180912163335.GA18748@redhat.com/

> @@ -1890,11 +1917,21 @@ static void kmemleak_scan(void)
>  		rcu_read_lock();
>  		for_each_process_thread(g, p) {
>  			void *stack = try_get_task_stack(p);
> +
>  			if (stack) {
>  				scan_block(stack, stack + THREAD_SIZE, NULL);
>  				put_task_stack(p);
>  			}
> +			/*
> +			 * This is an expensive loop, we must to call the
> +			 * scheduler to avoid lockups
> +			 */
> +			if (need_resched() && !kmemleak_stack_scan_break(g, p)) {
> +				aborted = true;
> +				goto unlock;

Can this need_resched() check actually help if CONFIG_PREEMPTION &&
CONFIG_PREEMPT_RCU ?

In this case (lets ignore PREEMPT_DYNAMIC to simplify) rcu_read_lock()
doesn't disable preemption and cond_resched() is nop, need_resched() is
(almost) never true. Right?

I guess even in this case it makes sense to not abuse rcu_read_lock()
"too much", but perhaps we need something more clever than need_resched() ?

Note that check_hung_uninterruptible_tasks() uses time_after()...

Oleg.

