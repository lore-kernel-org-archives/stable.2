Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AAB37CD37;
	Wed, 29 Jul 2026 17:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785346329; cv=none; b=OQSQDwAJAFkBuQYF/0ilOSG6LYQRdIbnvY0y3OYEFXD4YxpB/tz+CO6k84jOebQtTr+alrsg3n/b51fj59m/wHlVcI10TUHTOF8LFKfNms3IX8EyW3DqAQcl9T2LhzZyxeYmkipF8FLZch4FvCcu2f95heemeqaptc46ewdmyXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785346329; c=relaxed/simple;
	bh=jzLKPOJfZi/ERyCqbefXUD/njeS+E0E8wHwLbTiO7wo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gcZvoL97xA02bLB6xLJGkar3IMHy6XmqB6nrfVm98v/NX7bgfWLOBGgRraYgGRboLEn4IgmjAVlaVmdOKV4e05fkwNmJeL0egxPFcWxu4FgtbMSTYJx+fghE2Asui3xgqVrpJG8b1jtDWgOpZj0D2ioOArSnLiQHW1hFcPqOb/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id B1FB8A0779;
	Wed, 29 Jul 2026 17:32:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 3F12220025;
	Wed, 29 Jul 2026 17:32:01 +0000 (UTC)
Date: Wed, 29 Jul 2026 13:32:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
 bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, song@kernel.org, jolsa@kernel.org, naveen@kernel.org,
 davem@davemloft.net, mhiramat@kernel.org, stable@vger.kernel.org,
 linux-open-source@crowdstrike.com, mbenes@suse.cz
Subject: Re: [RFC PATCH bpf-next 0/3] ftrace, kprobes, bpf: mark
 trampoline/kprobe ftrace_ops permanent
Message-ID: <20260729133232.1e6c79eb@gandalf.local.home>
In-Reply-To: <CAHk-=wjzHTuomhTegkD69veDVRxprX8NB=i7A+BEB2-v6v5n+g@mail.gmail.com>
References: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com>
	<20260729104114.04298a48@gandalf.local.home>
	<CAOu3gNgc0XHScgEf+yWF5Kr8sAm8Fsa4RBuwL0YE2EscSiBPrA@mail.gmail.com>
	<20260729113136.32af2a4d@gandalf.local.home>
	<CAHk-=wjzHTuomhTegkD69veDVRxprX8NB=i7A+BEB2-v6v5n+g@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 3F12220025
X-Stat-Signature: 5xdgoxrisbw3orwf73efo6xozpqu9cxj
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/xEXo6II7fWdCqKMnxVwogpUqOt5SbSV4=
X-HE-Tag: 1785346321-509819
X-HE-Meta: U2FsdGVkX19mhPo7qBAXnNQCBh4LMj2QLHcRYchT8qWobOEEwXW4ZN10LX7yP6HicrvpMS3PmTfz+8dBqQtTOTBzxWF2kA/hfjwIXdj1LbV8inBszGIpuwrMUczTITGSzYH5UP4NOPQy21Nqye7bojQLH7UGWTc4RRXB+sY3o/n7rW6ekE4lj46B7mEUc/nvDr3p5dt8dKycHwJox2qJK2v3uSjuKe8ReEwna2bThWB3mOMNs7u+Mw/dbWKhNiXLqsjjE6Qh+IrPF0d0cYI8SxtdXHGUOAZv5Vodv9gg8rLUEMdMR3qAzCWgvkEhbse18fd/QnnfcdL9g1V9Q/S/9DUCmSCPw4PCOXR7AqehOmfB39KMEAISYDsGDHdamvxK+c8MSaz5El6ZP2/KANDZp4rWAwTwTS8AbtmgZJLcuwoQarjjolUCFGW3LP4wi7F9

On Wed, 29 Jul 2026 08:47:33 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 29 Jul 2026 at 08:31, Steven Rostedt <rostedt@goodmis.org> wrote:
> >  
> > > > Honestly, I would love to get rid of it as today ftrace has proven to be
> > > > rather stable. But as it is a user space ABI, I'm not sure what will break
> > > > if we do. I wonder if we just make it a nop, and print a message to dmesg
> > > > saying:
> > > >
> > > >   "ftrace_enabled no longer does anything. Please report if you need it to."
> > > >
> > > > ?  
> > >
> > > Thanks Steven, if you and/or other community members would approve such
> > > approach I would happily do this instead for a few reasons -  
> >
> > It's actually if Linus is OK with this approach.  
> 
> The rule is always the same, and I don't understand why there's any
> discussion about it because it's been stated a million times: we can
> try to make any ABI changes at all, and what matters is whether it
> breaks somebodys setup.
> 
> If people rely on old behavior, it can't change. And if people don't,
> nobody cares. It really is that simple. That is literally the
> DEFINITION of "don't break user space".

That's basically what I said. I was just restating it and not asking if I
was correct. I added you more for the below information you added.

> 
> Whether something is user-*VISIBLE* in theory is entirely immaterial
> except in the sense of "be careful, this needs testing and may have to
> be reverted". So user-visibility isn't a "don't do it", it's a "do it
> carefully, and knowing that you may have to revert immediately if
> somebody complains".

Totally agree.

> 
> So changing user-visible things is potentially a lot of wasted effort,
> and needs loving care and follow-up.
> 
> So everybody should typically avoid changing user-visible things
> because it's potentially painful and developer-intensive, but not
> because it can't be done.
> 
> All that matters is whether real user workloads regress.
> 
> And please make sure that any changed behaviour is really obvious, so
> that people don't spend lots of time chasing down *why* something
> broke. A kernel printk is generally way too subtle - and no, the
> tracing "make the printk extra ugly with crazy ASCII barfics" model is
> not an improvement.
> 
> It might be better to actually return an error to user space so that
> users can see that setting ftrace_enabled to zero failed and it would
> show up in user logs. kernel developers may think that kernel logs are
> important, but users seldom even think about them. Of course, that can
> then cause even worse regressions, so there's a balance here.
> 
> End result: don't do user visible changes unless you really really
> care. And then you spend the extra effort.

Honestly, I don't know of any tooling that would use this kill-switch or
any reason to do so. For live kernel patching and for BPF, it doesn't even
work. Hasn't for some time. It's now a "kill some ftrace but not all".

Hence, again, the switch itself is rather useless.

It now is starting to cause a burden, as there's internal code depending on
ftrace functionality to always be working and can cause some nasty
undefined behavior if someone were to set that kill switch to zero. The
solution is to either play whack-a-mole and make sure all those use cases
have the PERMANENT flag set so the kill-switch does not affect them. Or we
simply disable the kill-switch.

But I like your idea about it returning -ENOSUP if someone tries to set it
to zero. Doing that and the printk should let people know why it didn't
work if they do care.

And yes, we need to be ready to revert it if someone does come back and say
their tooling broke because of it.

Andrey, care to make a patch to do that?

Have setting it to zero return -ENOSUP and print a message saying:

 "The ftrace_enabled file is deprecated and no longer disables ftrace"

-- Steve
