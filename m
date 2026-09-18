Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65491501291;
	Fri, 18 Sep 2026 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744515; cv=none; b=TZ69P3KCfjEboCmg5ZJtYOxmUPaX7NdSztGjPY6e8FxH6uHTOjHlbASChBSI2QyUwhabkvaSi/GcuHrfEb6c7iS/lmsu3ZiNkjxuV2TcuIjb6hl5eMuODIxfMgxZD8T/2oqlhemnglJJG53cHhK1+VpGXt303tM4GTvSt3PyDR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744515; c=relaxed/simple;
	bh=CvgWex6KlusCUqyWTNIjyIfUF64Sdse64MrVF6yTZLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVW+rak2yRSlfhMwd+ROavmnFje2ZDYo0g8vRn0Fq814V5ho6NN9KldMLjUWSFTewsWNa7SnPVeT4MnIKzNcglZeIJ581DJ05DYt+sENU9llMnqmsPCujIY1TMsNvgYMrfvNWt85aEIXu700W5pc0jQuF1lIGZNmqH0ihWmjsh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALXpnp1G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALXpnp1G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F781F000FF;
	Fri, 18 Sep 2026 15:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744513;
	bh=D/F6D1NMbwjNTV7KUzsWnd2D24VgFEgesLpZdXDwK78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ALXpnp1GHZGwryIUe3HRJsdfB2RX/g4ef7xnnB6/pGLV1iAWyFzmsR5PIapv6H17q
	 jj0UwoN+pu/t44md9aeZl9dKsdth73UiY7msfLcpTSW98gTyKG3GMRHLZU8Sk0H1fd
	 Ut7nYF8fKH6Cc8L/Aom3goTKn31Lrvh+s3V+zMcnRoduUNeg9ZdIi+rwT5qGY44bxU
	 hP+VoPIKc6IB2IdsVHYpP0p7rXLMOWuseQReBCxLLue5iPVlWCaolHYqUVD29J0Gjh
	 3CfxbMl8eBIeQ8Cm/1x91vcAlbhIMxuX3scvMP9eig4RKFD4hzU+9AxMZyF3lEvmhv
	 z9yKshBOgxgJQ==
Date: Fri, 18 Sep 2026 17:15:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, 
	io-uring@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/7] fork: refuse new threads while a coredump or an
 exec is in progress
Message-ID: <20260918-indiz-halbkreis-puzzeln-424924a9f781@brauner>
References: <20260917-work-coredump-fixes-v2-0-f3787fcda051@kernel.org>
 <20260917-work-coredump-fixes-v2-1-f3787fcda051@kernel.org>
 <aq0VLTyxNatFmLOK@redhat.com>
 <20260918-irrsinn-pickt-vermummen-d7167c397398@brauner>
 <20260918-disput-maden-parkdeck-2bc22dd90398@brauner>
 <aq0_lvHDViIpX_Mu@redhat.com>
 <20260918-elstern-potenzieren-marotten-71ebd0744753@brauner>
 <20260918-oliven-lebst-wohltat-c633868711f1@brauner>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260918-oliven-lebst-wohltat-c633868711f1@brauner>

On Fri, Sep 18, 2026 at 05:00:50PM +0200, Christian Brauner wrote:
> On Fri, Sep 18, 2026 at 04:29:41PM +0200, Christian Brauner wrote:
> > On Fri, Sep 18, 2026 at 03:41:42PM +0200, Oleg Nesterov wrote:
> > > On 09/18, Christian Brauner wrote:
> > > >
> > > > I think this works but they also need to check ->in_execve as the
> > > > exec'ing thread is obviously never signaled:
> > > >
> > > > @@ -2709,6 +2707,10 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
> > > >                 .user_worker    = 1,
> > > >         };
> > > >
> > > > +       /* A creator past its fatal signal or in execve gets no thread. */
> > > > +       if ((current->flags & PF_SIGNALED) || current->in_execve)
> > > > +               return ERR_PTR(-EINTR);
> > > 
> > > Ah, I forgot to mention...
> > > 
> > > Can we shift io_uring_task_cancel() up, after setting bprm->point_of_no_return
> > > but before de_thread() ?
> > > 
> > > I know nothing about io_uring, not sure this would be enough...
> > 
> > From my reading of this code it works.
> > The cancel runs task work and any create_worker_cb() queued before the
> > exec can still create an io-wq worker. If that happens before
> > de_thread(), that worker just becomes a sibling that de_thread() kills
> > and waits for. After the cancel nothing new can be queued.
> 
> Right, one more thing to think about with this...
> 
> zap_process() skips every thread that has PF_POSTCOREDUMP set.
> do_exit() sets PF_POSTCOREDUMP in synchronize_group_exit() and calls
> io_uring_files_cancel() right after that.
> 
> That runs task work, create_worker_cb() runs and creates a new io-wq
> worker. If a thread started a coredump rgith before that worker gets
> created from a thread with PF_POSTCOREDUMP set which zap_processes()
> doesn't see. So two ways of fixing this:
> 
> (1) mask off PF_POSTCOREDUMP in copy_process() -> probably the wrong
>     place
> (2) key on PF_SIGNALED | PF_POSTCOREDUMP
> 
> I think (2) is probably correct:
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index a28fd3976cc0..94a652d933c8 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2707,8 +2707,8 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
>                 .user_worker    = 1,
>         };
> 
> -       /* A creator past its fatal signal gets no thread. */
> -       if (current->flags & PF_SIGNALED)
> +       /* A creator past its fatal signal or its coredump point gets no thread. */
> +       if (current->flags & (PF_SIGNALED | PF_POSTCOREDUMP))
>                 return ERR_PTR(-EINTR);
> 
>         return copy_process(NULL, 0, node, &args);
> 
> Better ideas?

I guess we could move io_uring_files_cancel() before
synchronize_group_exit() but that feels sketchy.
