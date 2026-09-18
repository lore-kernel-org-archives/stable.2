Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55C34C2253;
	Fri, 18 Sep 2026 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789734253; cv=none; b=sXzoDyTatfZE7g0dWvRxQMoYwj7JVXqPTEZSAkxCWHdfxN2e72nYUjif597VdKW8h1d+TGiKLGkFAZIBAI6HYohRzTxnZxTTjp3kfAmucyu7F9VbHhNZB826XxEciyJzrgqM//3Ex0OijRJkPxyTngG98Q3K+TETJCimycwhMmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789734253; c=relaxed/simple;
	bh=/3mBRjErhvrUAidKGNnQM9MPjiGzRc3EgGWMhwBiMNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhNNmDLYb6ptwCvuRwOpjDHdQ+HftpCJODlaRqYLHJU1S57+2rTqfUOheD84DMLCEfQy/ml4CMLZn93A8V1kcsBn2/dRsFsms6j7AzKaaTJom2/I68Xp4JTMGjwACmvcFoEb3D8txzTqJZe6pdLjE6mqvuIBwFt4DsQLRoqI3Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzoCNVPQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzoCNVPQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EF61F000FF;
	Fri, 18 Sep 2026 12:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789734252;
	bh=Q6oMeyEK/1JyGwnyMfukKkQ88mHLG2Cz9KdlVILMP34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UzoCNVPQCiXKBTYtowh0ZR/LLXxwdtOWPoKneKGSAqYgMe/WyRWSHetaw5EiwvjGR
	 WeJjNKZGrrIKcTSvmpF9VUP7qcYlgwmR+JOMpRHTLxGy4gvjeGqsqYoW1dqqJtpRsQ
	 pLRV8irhFy6iyo7XbFIlM0X78irC7zNhMx7hrAcrZuH2mE9R3FGJsGhauhMMXRE0nv
	 u7NAYalvWl01s1XENCPDT0fZQGWMwcxcPTXDtkYUbnhW0wFCBhfqv7L4OZygWUlzpY
	 3iXAodlCgCOPfV6hy0tzot8Vh/NWc8PNRMLoj5iJ4JCbVagqL7TOphRI1Soo7q/i9h
	 l+YtUxsU2NFHA==
Date: Fri, 18 Sep 2026 14:24:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, 
	io-uring@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/7] fork: refuse new threads while a coredump or an
 exec is in progress
Message-ID: <20260918-irrsinn-pickt-vermummen-d7167c397398@brauner>
References: <20260917-work-coredump-fixes-v2-0-f3787fcda051@kernel.org>
 <20260917-work-coredump-fixes-v2-1-f3787fcda051@kernel.org>
 <aq0VLTyxNatFmLOK@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aq0VLTyxNatFmLOK@redhat.com>

On Fri, Sep 18, 2026 at 12:40:45PM +0200, Oleg Nesterov wrote:
> On 09/17, Christian Brauner wrote:
> >
> > Say a SQPOLL thread is a member of a thread-group that coredumps.
> > The coredump code uses zap_process() and sends SIGKILL. The SQPOLL
> > thread uses io_sqd_handle_event() and calls get_signal(). It removes
> > SIGKILL from the pending set and returns. The SQPOLL thread breaks out
> > of the loop and drains its own task work.
> >
> > Any pending io_req_task_submit() with REQ_F_FORCE_ASYNC creates a new
> > worker when no other worker is free. So it ends up calling
> > create_io_thread() from a thread whose fatal signal is gone.
> 
> Oh.. Can we fix this in the io_uring/ code somehow? The very fact that
> copy_process() can be called after get_signal() returns SIGKILL looks
> very wrong to me. See below.

Yeah, I agree but the io_uring solution I came up with all where a bit
involved...

> 
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -2491,8 +2491,10 @@ __latent_entropy struct task_struct *copy_process(
> >  		goto bad_fork_core_free;
> >  	}
> >
> > -	/* Let kill terminate clone/fork in the middle */
> > -	if (fatal_signal_pending(current)) {
> > +	/* Let kill or a group exit, exec or coredump abort clone/fork */
> > +	if (fatal_signal_pending(current) ||
> > +	    (current->signal->flags & SIGNAL_GROUP_EXIT) ||
> > +	    current->signal->group_exec_task || current->in_execve) {
> 
> Well, the comment doesn't explain why should we care about exec or coredump,
> if we forget about the problem above fatal_signal_pending() must be true.
> 
> At least, can we move these additional checks into create_io_thread() ?
> To not uglify copy_process()...
> 
> Hmm... get_signal() sets PF_SIGNALED before it checks PF_USER_WORKER, so
> perhaps something like below can work?
> 
> And perhaps io_should_retry_thread() should check PF_SIGNALED too?

Hm, I like this idea...
Let's see.

> 
> Oleg.
> 
> --- x/kernel/fork.c
> +++ x/kernel/fork.c
> @@ -2700,6 +2700,9 @@ struct task_struct *create_io_thread(int
>  		.user_worker	= 1,
>  	};
>  
> +	if (current->flags && PF_SIGNALED)
> +		return -EINTR;
> +
>  	return copy_process(NULL, 0, node, &args);
>  }
>  
> 

-- 
