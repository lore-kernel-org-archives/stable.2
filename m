Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6023548C41F;
	Wed, 16 Sep 2026 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789558233; cv=none; b=LlzExmxqI2eo8OzoQiaanM5vTpwt9D5UUsO3zWnSzfsCviU2bMsmzzJa89DU1qHpbEUUPS0pcqSlColqkME3q2rmcX6zYezPf7nnfKrSXzJZmEiHe7dEbw/b7M3/PkFNdbJjhF1dg+KQrZ/ngtoRLHuCsyT2lHh8YzfxGdf1nBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789558233; c=relaxed/simple;
	bh=JcGe199HRyS/GbHXcbyhMUnOpw1nwLiEld7/bLunpIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RML7yzk6fbZqXtluM6q9U0XNXOURCZZIRHGOVyE/R6piu2BLeJiCt+WXNk0SoRf5aXjFhXEVXHQxWfcgYkRsGD1qQV2TfyvNzQi3wsDj1bOY0VVETxonL0v5Xx4HhhTnZZcIHoGDmsgcMgCzNmMFrHWbiVsldK/frJM9uhH4zNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6mXo8aG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6mXo8aG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11CD1F00893;
	Wed, 16 Sep 2026 11:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789558226;
	bh=cNxxziEzSRjeeKkjHPI2ybzZcO+hLZVdC7CPel2aGig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D6mXo8aGO1S4K38ZGd8hkcIL0zJZyK5x1+eSM6TRcftvJ9ZosYGt4bxLvysVZ+c/Y
	 xDcSDPMp52bYcCHZbgSChB8nsQXIgP/tAv10w+e4enDJXg7Uhd6pl3beUXWDcN6RdQ
	 6VF7pTigbgLNIIxkSvcuWk5HBji2ptCf94tszX/X9Ha5vfIU5DpjUo7TzugCOisXTb
	 AuyPrBRFbuaFK29qI7SDRhEjy3Ku7qyicG1MDeY96T6+L6Tts7MoKh14J/IoMUKB9B
	 HCQc6d71jHWqbETl0C7+9hNnVoF9hUItBo8u3gooJ0NJZhejtfpJE89vQU4GBshhLq
	 T/Un53225h9YQ==
Date: Wed, 16 Sep 2026 13:30:21 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, 
	io-uring@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/6] fork: refuse new threads while a coredump is in
 progress
Message-ID: <20260916-geortet-ermessen-delegation-07b36ac1f4eb@brauner>
References: <20260915-work-coredump-fixes-v1-0-f354ca41780c@kernel.org>
 <20260915-work-coredump-fixes-v1-2-f354ca41780c@kernel.org>
 <aqleExxTBcHsonQe@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aqleExxTBcHsonQe@redhat.com>

On Tue, Sep 15, 2026 at 05:02:43PM +0200, Oleg Nesterov wrote:
> On 09/15, Christian Brauner wrote:
> >
> > Say a SQPOLL thread is a member of a thread-group that coredumps.
> > The coredump code uses zap_process() and sends SIGKILL. The SQPOLL
> > thread uses io_sqd_handle_event() and calls get_signal(). It removes
> > SIGKILL from the pending set and returns. The SQPOLL thread breaks out
> > of the loop and drains its own task work.
> >
> > Any pending io_req_task_submit() with REQ_F_FORCE_ASYNC creates a new
> > worker when no other worker is free. So it ends up calling
> > create_io_thread() from a thread whose fatal signal is gone. That means
> > copy_process() allows the creation.
> 
> Hmm, thats bad ;)
> 
> But then ...
> 
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -2491,8 +2491,8 @@ __latent_entropy struct task_struct *copy_process(
> >  		goto bad_fork_core_free;
> >  	}
> >
> > -	/* Let kill terminate clone/fork in the middle */
> > -	if (fatal_signal_pending(current)) {
> > +	/* Let kill or a coredump in progress terminate clone/fork */
> > +	if (fatal_signal_pending(current) || current->signal->core_state) {
> >  		retval = -EINTR;
> >  		goto bad_fork_core_free;
> 
> this change is not enough? Don't we have a similar race with exec?

Yeah, we do...

> de_thread() kills all other threads and counts them too. Shouldn't it
> also check signal->group_exec_task ?

not just that. We need in_execve checked too because
io_uring_task_cancel() runs the exec'ing thread's task work after
de_thread() when group_exec_task is unset.
