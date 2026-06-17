Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A4A3EFD14
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781697574; cv=none; b=Te+sz9fZm498ivCiJLMYdn8xcp6xOAEQhP4ASKJj/NIMeSFuAV+nxza9R8/NcknaXrMTzAbJDYTEmudKgyUe9hjSFQzo99/59cliM66Q9uSt524PlPddaheF4FT35g0iZ/z2vVIy8WizDJm8bnpaL7b18AuSv3MTW5juaRGkh8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781697574; c=relaxed/simple;
	bh=cvsxccTzFVOpMQezm4HlOWz2aB8KWwD6zxOBa9D3eA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rpb6u3lUSy2w5Ncewof5g/AdDGSdEQBUzZJrv8WhaR/91/XWdRugmyJWpyRzVIwn5X1I5emI7RjWVv5Yet3dK7E2RJd1mFNCg5HpxCf7f8k2lHuY0ilkLgGdo7eFFxfYbF0ZdjLszliJ6I6WiBox4PUh2+W4ibE3C7W76GMBuVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M6qD7bvt; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M6qD7bvt"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so7158485e9.1
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 04:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781697570; x=1782302370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wFy1siI5GPA02P4SigwJOvEY2/GCKPj1mDQV6Az/rvE=;
        b=M6qD7bvtZL4WoGDeCzK3htwiEAuyM4CktDeM5fxxmuqw8gryeGiBqYiMqXeDX0TObt
         ZhwgjWODAUq1Wf3Ii+fDS6wIbRIKznp+VbtnNcMlXDPeRTSb35z7nADRBqaaQQJpu7c5
         E+wQDUsA8ekgkOZFpVB+TO4QInOdJdP0boeMLaa7Jm+N+CRknJN8WskaFdqdSBs19MsJ
         eGKWMVRPZzLWCQU6WqgGC1mSSdRD/AcSd5UzNGZKVBVNC6xyNW6sQLx4BqpiZ+xh4bnR
         kH561LSvnpzCGzIWt+h44lsPyKA5JUitnlXOYfdn+0QaRB9CPyOj+PXMEt90lJWu8pBR
         H3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781697570; x=1782302370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFy1siI5GPA02P4SigwJOvEY2/GCKPj1mDQV6Az/rvE=;
        b=GaGUM5cBWn8PmJyN0WS7wZKRSsE+dprYMhdSe+f3t+UoIedq8T2WgSzLKMKM0RsMCG
         YROjv5oFGADnUFb276EegrajrHbWiU2BJL9O6oCVHguJAAgl4Lw9tgaSZ5D42ZmTMZIK
         brQhY5W8BgAgzUvbAHMpWLNaJvvZP68fhAlhPhAZxZrlPEOwZPc760he9gOutaIlrYVX
         0z5jHra4oADx22YjcpT9Nlt/4HzV9RQl7LJcyk9U0a7HSXrBogA4ZoUFOolwHA023g8X
         Yt5ekDh0xJaLRtD9FvsaMAcTiBIfZk1nstTujsUxheHk7HAnTf4ur/HrVuGxzKw8w6T0
         i7bQ==
X-Forwarded-Encrypted: i=1; AFNElJ9cBNogujR6wYiEp63VAtFxa+UISU4sjMbinLmYJXYJorYGlL1N/xGK6PRtmSTFEfHkZcCNr/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZTLl3agTGFPP9aX+i57G+KPn2C3PapiJBWaTk3bRCLXsj9EQN
	RA+jgXvJKz4//NgqE9wpoJ0fNENCCet6q+u0A1/2+uSSZOeZ+K8kpeUPWuYNZWOAGCo=
X-Gm-Gg: Acq92OFJ2+wqdxUDxj0FNWFxTLaqrBKQl2jzyH1Kni2TO84RECo5OoGy3SooFI1G5wk
	BJDf9MwhUQ2aOx0a5IsMsszE6RONZNsvdDJZ1STPnG1AzvxG4I2vi81kya5DWUCyXEB2+IeMz+o
	X9UQLT6osezh7jaHSh8bZXBHNN+xI5A6IIGava/WYyixGv4hjY1dphJQMXP7mWiiyXDdXURY+Uv
	wPop4kXZS5lWnG9UIJYgtbyg7RT4Yvetm5Q9zIFbwYxCsWoECotgtnOazL/pwzeSQi4RVXqX3Ik
	k/+QnAwlcPeIGPa1kkxochrE1GtHzTICBn/TyocTYak3EaIbjqLjMYgFye57GY1OKEVe83vOmR1
	VUWExgILSIkc1M1H4t1kaoUUHgL7ddqF+0OHiejRSTgIc0/QzxNcYxpnjC0wtOOSNaK0imEIil5
	rmHJ2/uYGiKtyjNIQ=
X-Received: by 2002:a05:600d:8450:10b0:490:4035:323 with SMTP id 5b1f17b1804b1-492340e75cdmr33496715e9.9.1781697570289;
        Wed, 17 Jun 2026 04:59:30 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f309sm48879291f8f.14.2026.06.17.04.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 04:59:29 -0700 (PDT)
Date: Wed, 17 Jun 2026 13:59:27 +0200
From: Petr Mladek <pmladek@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Vlad Poenaru <vlad.wing@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Breno Leitao <leitao@debian.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH net] netpoll: run NAPI poll in softirq context to avoid
 rq->lock self-deadlock
Message-ID: <ajKMH_LmiZhjNlOW@pathway.suse.cz>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
 <20260611191114.5bc43a59@kernel.org>
 <20260616103529.Yh9Dxsjp@linutronix.de>
 <20260616081128.04e2c8dd@kernel.org>
 <20260616153122.keHMKvVT@linutronix.de>
 <ajJy92ES-Q8ro97A@pathway.suse.cz>
 <20260617111504.GK49951@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617111504.GK49951@noisy.programming.kicks-ass.net>

On Wed 2026-06-17 13:15:04, Peter Zijlstra wrote:
> On Wed, Jun 17, 2026 at 12:12:07PM +0200, Petr Mladek wrote:
> > On Tue 2026-06-16 17:31:22, Sebastian Andrzej Siewior wrote:
> > > On 2026-06-16 08:11:28 [-0700], Jakub Kicinski wrote:
> > > > > 
> > > > > Adding sched and printk folks for opinions while eyeballing
> > > > > WARN_ON_DEFERRED().
> > > > 
> > > > Thanks a lot for looking into this! To be clear - the printk_deferred /
> > > > WARN_DEFERRED would be just for stable? Or there's still some
> > > > sensitivity even with nbcon?
> > > 
> > > We already have printk_deferred(). WARN_DEFERRED() would be new. I
> > > *think* this is not limited netpoll/ netconsole but all console drivers
> > > not using CON_NBCON if the printk (via WARN) occurs with the rq held.
> > > I don't remember all the details but printk_deferred() was introduced to
> > > circumvent this until printk is fixed.
> > 
> > Just to make it clear. The problem with the legacy consoles is that
> > they are called under console_lock() which is a semaphore. And it
> > calls wake_up_process() in console_unlock() when there is another
> > waiter on the lock.
> > 
> > > Once we get rid of those legacy drivers and NBCON is the default we can
> > > get rid of printk_deferred() :)
> > 
> > Yup.
> 
> Can't we push all the legacy consoles into a single legacy kthread? I
> mean, converting all consoles is of course awesome, but should we really
> wait for that?

I am afraid that converting the consoles one by one is the deal with
Linus. I could imagine to moving last few sinners into the kthread
when the majority is converted. But we are far from there :-/

Best Regards,
Petr
