Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990A942902E;
	Fri, 18 Sep 2026 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789735986; cv=none; b=BroN8a/m2S43ht9Fvif2WGGpPSy6kwu08/V+rZcFOQfqlo2RDy02M2DawdrV9SR/HS25foAG6jUo9Wa9x5WZktndD3Z0bBkNIbKwCgqR/Kcq0lbBtqxYwvTN++WXzO1y7wgUsp0WUaBKRMS6FbYKDw1I9tdKcRORjwM2Uq9zPps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789735986; c=relaxed/simple;
	bh=KV+XKXUDMWeEkkP9fRRiZbuS1iLuosQl/iuS/8a5tjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOPWHIfdjfk4Y1CybqlcwA/QETkPeZbkAT7yLAkU6wPx8t+ECDRXfrBy9itSh8lXDpe08ROgwuTc1ptZj5aTXd2NBjrWm8mC8kIOyo4PMH4tra1TV7HHnEba9OFV+/ttphWRpD4M/HIHa4S6CKW4M1HgxUga+IIe0xC+DHZGUag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+48af3L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+48af3L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16921F00898;
	Fri, 18 Sep 2026 12:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789735977;
	bh=URFVDzgpelJJ+jDhgim6DiODp4bS41sZLqrpRa8KViA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I+48af3LUNbvFF0M3+2V6k077VkMdkXCMw8Tzm8fgogJIAAmrrhl/pZKR5ouKn8pZ
	 +muGLNETLWA6HqkauxvPPoviHN/g9Nhnh91tTxenAf/9E9KA7Flsub2ItEXFDyJVN9
	 Ld+fSiYZsNwBJV/MKfr12j2E1+UebbO2km/rQMj89KBNbPiYqHN9fwhqX0ngN26TqI
	 KEzInAmEOdeTFvZxzU/BUrOHJuWIIq0OGV6lr4kerUBwuFA3KWRpKJbiCiDIA4u+VB
	 eXBeBBtMMNmk6/OQb08Fk9NfbcMfU/OpvLCoppOXjPSMjxfpTY5WFW2grMdqaS6RKF
	 sON1aXuXpBh1g==
Date: Fri, 18 Sep 2026 14:52:52 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, 
	io-uring@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/7] fork: refuse new threads while a coredump or an
 exec is in progress
Message-ID: <20260918-disput-maden-parkdeck-2bc22dd90398@brauner>
References: <20260917-work-coredump-fixes-v2-0-f3787fcda051@kernel.org>
 <20260917-work-coredump-fixes-v2-1-f3787fcda051@kernel.org>
 <aq0VLTyxNatFmLOK@redhat.com>
 <20260918-irrsinn-pickt-vermummen-d7167c397398@brauner>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260918-irrsinn-pickt-vermummen-d7167c397398@brauner>

On Fri, Sep 18, 2026 at 02:24:07PM +0200, Christian Brauner wrote:
> On Fri, Sep 18, 2026 at 12:40:45PM +0200, Oleg Nesterov wrote:
> > On 09/17, Christian Brauner wrote:
> > >
> > > Say a SQPOLL thread is a member of a thread-group that coredumps.
> > > The coredump code uses zap_process() and sends SIGKILL. The SQPOLL
> > > thread uses io_sqd_handle_event() and calls get_signal(). It removes
> > > SIGKILL from the pending set and returns. The SQPOLL thread breaks out
> > > of the loop and drains its own task work.
> > >
> > > Any pending io_req_task_submit() with REQ_F_FORCE_ASYNC creates a new
> > > worker when no other worker is free. So it ends up calling
> > > create_io_thread() from a thread whose fatal signal is gone.
> > 
> > Oh.. Can we fix this in the io_uring/ code somehow? The very fact that
> > copy_process() can be called after get_signal() returns SIGKILL looks
> > very wrong to me. See below.
> 
> Yeah, I agree but the io_uring solution I came up with all where a bit
> involved...
> 
> > 
> > > --- a/kernel/fork.c
> > > +++ b/kernel/fork.c
> > > @@ -2491,8 +2491,10 @@ __latent_entropy struct task_struct *copy_process(
> > >  		goto bad_fork_core_free;
> > >  	}
> > >
> > > -	/* Let kill terminate clone/fork in the middle */
> > > -	if (fatal_signal_pending(current)) {
> > > +	/* Let kill or a group exit, exec or coredump abort clone/fork */
> > > +	if (fatal_signal_pending(current) ||
> > > +	    (current->signal->flags & SIGNAL_GROUP_EXIT) ||
> > > +	    current->signal->group_exec_task || current->in_execve) {
> > 
> > Well, the comment doesn't explain why should we care about exec or coredump,
> > if we forget about the problem above fatal_signal_pending() must be true.
> > 
> > At least, can we move these additional checks into create_io_thread() ?
> > To not uglify copy_process()...
> > 
> > Hmm... get_signal() sets PF_SIGNALED before it checks PF_USER_WORKER, so
> > perhaps something like below can work?
> > 
> > And perhaps io_should_retry_thread() should check PF_SIGNALED too?
> 
> Hm, I like this idea...
> Let's see.

I think this works but they also need to check ->in_execve as the
exec'ing thread is obviously never signaled:

@@ -2709,6 +2707,10 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
                .user_worker    = 1,
        };

+       /* A creator past its fatal signal or in execve gets no thread. */
+       if ((current->flags & PF_SIGNALED) || current->in_execve)
+               return ERR_PTR(-EINTR);
+
        return copy_process(NULL, 0, node, &args);
 }
