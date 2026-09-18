Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD174F30DC;
	Fri, 18 Sep 2026 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743661; cv=none; b=twcsZMn78Kj0Gt/29ohbfB98bgp66neCewsyYzBhe69rORbloRK64AobSflzcUaZR31zN0RUmiSrEIWA51QkOTVNqVUYH0Ce5Vyr+4F3hpbs/AziF+rv5SwGJ26375iQP184PQy0+ADbjGFbaMSof+vcKj7unuxR630/q5D/NNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743661; c=relaxed/simple;
	bh=kwAce/U4/lhY0aCQXvEsOHRNbCkH1p1okIQpMdOtSXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0iEkYxVWBdG+mPjNsu517UV35Ern9wTq+jwlRWi3662o80DwIkmWE3K/Gj2ZCax3JUN+gPLxDyZJEghqNUCLsSB61wgV9wDwjqlJjW8QyOxhObAbosk4vhUgBkMk+ZgYUKfOSGtDxzCfStL4nUQhaw24xUgiahVt+DsXs6y4VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3tj+2SR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3tj+2SR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E77A1F000FF;
	Fri, 18 Sep 2026 15:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789743660;
	bh=m0lbIXYPWHNxCUA+ixIepaYl5/92+XFxrovY+YXT0Oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h3tj+2SRLdyyyh8u6EmUdZLxGnTCejPhtW7liS54uyDqfHII8uZGPJSjRKYeJknSC
	 VcNwzzno0SonxatCkgMXDqtQ1GFAQEcHr6e5okErY/GhfEbhJZA+JVa0nf671uAmth
	 3KmGDUSKIDQN6TFK6rx5Z7uBikGnd4JWH9oYOVdHNIEJLfjqCG/mByc8vHg/Cgv9mV
	 d7D80DVQzaNDziO+TBHvSre0qgy1ldT2XNELzipdrmjj0qAAhSzKVTJqT0T2agG4N7
	 v745yVxJlJVC7B/4Uj7vPZ3BntThlPrIkclP8BybCFg5P1sm4G0wOPjtHgsx5nuePv
	 TIwGlDUdXinbA==
Date: Fri, 18 Sep 2026 17:00:50 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, 
	io-uring@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/7] fork: refuse new threads while a coredump or an
 exec is in progress
Message-ID: <20260918-oliven-lebst-wohltat-c633868711f1@brauner>
References: <20260917-work-coredump-fixes-v2-0-f3787fcda051@kernel.org>
 <20260917-work-coredump-fixes-v2-1-f3787fcda051@kernel.org>
 <aq0VLTyxNatFmLOK@redhat.com>
 <20260918-irrsinn-pickt-vermummen-d7167c397398@brauner>
 <20260918-disput-maden-parkdeck-2bc22dd90398@brauner>
 <aq0_lvHDViIpX_Mu@redhat.com>
 <20260918-elstern-potenzieren-marotten-71ebd0744753@brauner>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260918-elstern-potenzieren-marotten-71ebd0744753@brauner>

On Fri, Sep 18, 2026 at 04:29:41PM +0200, Christian Brauner wrote:
> On Fri, Sep 18, 2026 at 03:41:42PM +0200, Oleg Nesterov wrote:
> > On 09/18, Christian Brauner wrote:
> > >
> > > I think this works but they also need to check ->in_execve as the
> > > exec'ing thread is obviously never signaled:
> > >
> > > @@ -2709,6 +2707,10 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
> > >                 .user_worker    = 1,
> > >         };
> > >
> > > +       /* A creator past its fatal signal or in execve gets no thread. */
> > > +       if ((current->flags & PF_SIGNALED) || current->in_execve)
> > > +               return ERR_PTR(-EINTR);
> > 
> > Ah, I forgot to mention...
> > 
> > Can we shift io_uring_task_cancel() up, after setting bprm->point_of_no_return
> > but before de_thread() ?
> > 
> > I know nothing about io_uring, not sure this would be enough...
> 
> From my reading of this code it works.
> The cancel runs task work and any create_worker_cb() queued before the
> exec can still create an io-wq worker. If that happens before
> de_thread(), that worker just becomes a sibling that de_thread() kills
> and waits for. After the cancel nothing new can be queued.

Right, one more thing to think about with this...

zap_process() skips every thread that has PF_POSTCOREDUMP set.
do_exit() sets PF_POSTCOREDUMP in synchronize_group_exit() and calls
io_uring_files_cancel() right after that.

That runs task work, create_worker_cb() runs and creates a new io-wq
worker. If a thread started a coredump rgith before that worker gets
created from a thread with PF_POSTCOREDUMP set which zap_processes()
doesn't see. So two ways of fixing this:

(1) mask off PF_POSTCOREDUMP in copy_process() -> probably the wrong
    place
(2) key on PF_SIGNALED | PF_POSTCOREDUMP

I think (2) is probably correct:

diff --git a/kernel/fork.c b/kernel/fork.c
index a28fd3976cc0..94a652d933c8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2707,8 +2707,8 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
                .user_worker    = 1,
        };

-       /* A creator past its fatal signal gets no thread. */
-       if (current->flags & PF_SIGNALED)
+       /* A creator past its fatal signal or its coredump point gets no thread. */
+       if (current->flags & (PF_SIGNALED | PF_POSTCOREDUMP))
                return ERR_PTR(-EINTR);

        return copy_process(NULL, 0, node, &args);

Better ideas?
