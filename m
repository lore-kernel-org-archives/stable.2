Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889D54C9007
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 20:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780606085; cv=none; b=WD9TytvPw3kuJiWueTX/nsu08OWNIJDeBe3wE0tEOnjEF0JFJiQaXUCjWYnTR2nT6IqWjHvB2imiNbg8uafmyUZh+dizdwa20aNJpn40+6FfrYK4C3CmJ3DpHQ36Y+a6J8hbRZxDeDNaExChjQMF0ImcpxAgKL0Nahum+s/rHpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780606085; c=relaxed/simple;
	bh=6hGQLbsaDeyUM+nnzCDhG50UBs91b9ghew0II57BQ6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyLhOUK5+OGZH3N1fz+AOKYo1yLTrNqsdoV4cTQa7UYG7TddbO5e3jDVWDBToXxd22ft2a5YFEFxAqxIrEIMTPzJ67FjqOmWAsCqRUdgXwgI4p8/qM/nTLoTwJNzQaBcoGm6I8apHSXbDnz4e763wtpIxlR4PxYDCIqcmyEB/Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lD+TVf/f; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lD+TVf/f"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45fd464d51fso701195f8f.3
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 13:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780606082; x=1781210882; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tvYftNrs5kAZ/e9l/bRPV9TOjx9gdfGqGwbPpzRf47A=;
        b=lD+TVf/f7E450z2GFtI5D4IckqnbYIobPaHeoGbGjPKdgM3+kEaU8UHWgCYsF/VtT8
         fcwC4MmexblK5+7R5VQuiTWgeqZM7QqxI5LjALmSjgQOf/J+d0joblfOnbe/s8E4v+v3
         ztA03kVOIS5XcrEQFuOlrHOePjkHj34QEmsgBZcbjjr/Zrh62jZIxFcv29fVl1wqB8IQ
         j7QeTFnAdxL2qxMuvk3et8f2O+bgU6kjK+Soya41O+ckxPnkZaHx2RBwpS1w+oGkkXLN
         owpNpjxNzMB8O/Rbd4I7B4Fi7IQIXBOhV48abavILVcySHzB3nBHnhhxQRpQc21mbzDk
         anzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780606082; x=1781210882;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tvYftNrs5kAZ/e9l/bRPV9TOjx9gdfGqGwbPpzRf47A=;
        b=pbSK5oJZesuF/igOJaRrZRIiEyHhfh1ds5lPfBPY75pfr185kLunf6v2bDN5cxv7Z6
         IirFEJVcqcFsopaMVJH0h2PNun4EBjAwMfiegrrqEqGiCzVDZthgar2kDaihob/ZPsTi
         z1V5Qvin/RNWwu7l7DZw74A2w3g8Wi7Xt6eng2xwIqick2uTDxgqNYshHeriF9LcLyCN
         nc47yU93MYIXjldE4teUeQoR7QLcUF4MYkd/jF4c1uIoluFSSW50sbOPFgwIi4HPt4JR
         uwqyM/AXlDu/1qBNXZbqAFfkZsJgiFvUUTvoL8laW4wDmcGLh41w1nD5esoR3pSF0j2h
         Jn0Q==
X-Forwarded-Encrypted: i=1; AFNElJ+BZzHjPgHxXONGLi+qcW3h/gtKfocMakIJStXHM4U55FDP6bFlumoZXbWDMqWWO8/OwHVoIGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtnG+0M6wxXFRClDXeIDjIyw4wXDy2Cf09l2ntsk+sZZu/RNd/
	1e/R7yUAjH6nqKD+gnOz2gL1qXPdjNVQZIJg/v9RFH/q8ywbpwl9Ogk7
X-Gm-Gg: Acq92OHL6x9guSBKnG6l3hvUorB7fM+DSL1N1FboIoaCJc+kr+inzuz95pBx/k3gj+s
	YItkykAmg+sNfl22sDkahVdbDjl4934tFZ2bGXpbJyJqGUMOPGlF86kXowcvm2NwkTCgnyN0ghc
	e2P8tfL5kG91E969hmNTW6iKfdRsXXdX/pZIJ+jY8kCRwUdmubm1IiyonZKT+lNmbKFvmzI3E6M
	foPSmoyyi/EAo7g3LFETy+2mLjBfqN1G6XLUKxiGv0gVca76DTEIJaHzXatPQffxJeEhbGWHY0W
	DF7v1HDnJGH5CJGzz7Cd3a4LSi5PzVeAaWLwGtrsjqUCCnQO4mA6wm6Ri1tc4SQEb7wpfugO+VG
	q32lpPPuW4TZmtISo+bYZBgog9DuakWAItcmWj23EV8Fb1R+GW7FAticDFSADt19TCefjOIdB8/
	AiXHq/Ppu7C5jiQF9+GQoDhfiFqdVY94K2qY+e9BqzbnX6jzgAcgBZ+Okh3qo=
X-Received: by 2002:a05:6000:18a5:b0:460:1967:abed with SMTP id ffacd0b85a97d-4603063c55dmr1042701f8f.39.1780606081674;
        Thu, 04 Jun 2026 13:48:01 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344558sm19171848f8f.18.2026.06.04.13.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 13:48:01 -0700 (PDT)
Date: Thu, 4 Jun 2026 22:47:56 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] landlock: fix LANDLOCK_SCOPE_SIGNAL bypass on the
 SIGIO path
Message-ID: <20260604.e8a19bf4e0ed@gnoack.org>
References: <7rvmLIHR1Zh8RDF1IY1-SYRHzErgw9gPHq0k98RLYVsmHqAejjxcuJi8V3QaSbW-SnNvY5tfM2Xn_S1dEajKV_f7iyitoPwJgOSTZQ0nytc=@proton.me>
 <20260531.irah0eiM3Chi@digikod.net>
 <20260602172741.18760-1-hexlabsecurity@proton.me>
 <20260602172741.18760-2-hexlabsecurity@proton.me>
 <20260604.f1cb6ce9cd6b@gnoack.org>
 <20260604102707.133997-1-hexlabsecurity@proton.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260604102707.133997-1-hexlabsecurity@proton.me>

Hello Bryam,

Just a brief mail to confirm the approach; this makes sense to me.

On Thu, Jun 04, 2026 at 10:27:13AM +0000, Bryam Vargas wrote:
> > I believe the result after this patch is:
> >  - No threads receive the SIGIO at all.
> >
> > This is because we have been setting T2.2's Landlock domain as the
> > "sending domain" for the hook_file_sigiotask(), and that hook does on
> > its own not do the "same_thread_group()" check [...]
> 
> Confirmed -- I traced the delivery path and your analysis holds.
> 
> For a PGID owner the signal is anchored per process on its thread-group
> leader: a task is attached to pid->tasks[PIDTYPE_PGID] only in the
> thread_group_leader() branch of copy_process(), so send_sigio()'s
> do_each_pid_task(pid, PIDTYPE_PGID, p) walk visits exactly T2.1 for P2,
> never the non-leader T2.2.  hook_file_send_sigiotask() then runs
> domain_is_scoped(recorded T2.2 domain, T2.1's live domain, SIGNAL) and,
> having no same_thread_group() exemption of its own (unlike
> hook_task_kill()), denies it -- even though T2.1 and T2.2 share P2's
> signal_struct and 18eb75f3af40 mandates that same-process delivery always
> be allowed.  T2.1 is P2's only entry on the PGID list, so P2 receives
> nothing.  You are right.
> 
> One thing worth putting on the record: this over-block is not introduced
> by the patch.  In unpatched control_current_fowner() the PGID case already
> resolves through pid_task(fown->pid, PIDTYPE_PGID), which returns an
> arbitrary hlist head -- one representative leader.  Whenever that head is
> outside the caller's thread group, the domain is already recorded today and
> the same delivery-time denial of the registrant's own leader already fires.
> The patch only makes domain recording for PGID unconditional, i.e. it turns
> that order-dependent behaviour into a deterministic one while closing the
> order-dependent bypass.  So the corner you describe is a pre-existing gap in
> the delivery hook, not a regression in v4.
> 
> That points at the real root cause: same_thread_group is a *per-recipient*
> property, but control_current_fowner() approximates it once, at F_SETOWN
> time, against a single pid_task() representative.  hook_task_kill() gets
> this right because it evaluates same_thread_group(p, current) live, per
> actual recipient.  hook_file_send_sigiotask() is the SIGIO analogue but
> delegates the whole thread-group decision to that one registration-time
> check, which a PGID delivery set simply cannot be captured by.
> 
> So the fully-correct fix is to move the same-process exemption to delivery
> time, keyed to the *registrant* rather than to current (at SIGIO time
> current is the fd writer, not the task that armed F_SETOWN).  Concretely:
> when hook_file_set_fowner() records the domain, also pin
> get_pid(task_tgid(current)) in struct landlock_file_security; in
> hook_file_send_sigiotask(), before domain_is_scoped(), return 0 when
> task_tgid(tsk) == that recorded pid.  PGID owners still record the domain
> (so P1 stays blocked -- the bypass fix), but the registrant's own process,
> including T2.1, is always allowed -- restoring 18eb75f3af40 exactly.  The
> new pid is taken/put in lockstep with fown_subject.domain under the same
> file->f_owner->lock and freed in hook_file_free_security(); the equality
> test follows neither pid, so there is no extra RCU surface.  Sketch:
> 
>     /* struct landlock_file_security */
>     struct pid *fown_tg;   /* registrant's thread group; NULL if no domain */
> 
>     /* hook_file_set_fowner(), where fown_subject is recorded */
>     fown_tg = get_pid(task_tgid(current));
>     ...
>     put_pid(landlock_file(file)->fown_tg);     /* release previous */
>     landlock_file(file)->fown_tg = fown_tg;
> 
>     /* hook_file_free_security() */
>     put_pid(landlock_file(file)->fown_tg);
> 
>     /* hook_file_send_sigiotask(), after the !subject->domain quick return */
>     if (task_tgid(tsk) == landlock_file(fown->file)->fown_tg)
>             return 0;   /* same process as the registrant: always allowed */
n> 
> I do not see a correct fix that avoids recording the registrant's identity:
> the registrant task is deliberately discarded after set_fowner (only its
> domain is kept), and exempting on a shared *domain* instead would be
> insecure -- sibling threads can hold different domains, and a different
> process could share one.

Yes, your approach checks out for me; I also think that storing this
additional information is the best approach; we need to know during
hook_file_send_sigiotask() what the TGID of the registering task was,
in order to tell apart signals within the same process from signals
going outwards of that process.


> > To be clear, the patch is still obviously an improvement [...] it just
> > seems to block it slightly too broadly in this corner scenario?
> > [...] Mickaël, maybe you have some thoughts on the tradeoff?
> 
> Agreed on both counts.  Mickaël -- two ways to land this:
> 
>   (a) keep v4 as is.  It closes the bypass; the residual same-process
>       over-block is pre-existing, deterministic only under the stacked
>       conditions Günther listed (already-multithreaded enforce, no TSYNC,
>       SIGIO to a PGID that includes self, registered from a non-leader
>       thread in a per-thread signal-scoped domain), and arguably tolerable.
> 
>   (b) v5 = v4 + the delivery-time exemption above.  Strictly more correct:
>       it also closes the pre-existing delivery-hook gap and restores
>       18eb75f3af40's same-process invariant, at the cost of one struct pid*
>       in landlock_file_security.
> 
> I lean (b) -- it fixes the actual root cause rather than the one reachable
> instance -- and I am happy to spin it (with an added selftest covering the
> PGID-includes-self / non-leader-registrant case, A/B verified) or to hold at
> v4 if you would rather keep the change minimal.  Your call on whether the
> corner warrants the extra state.

+1, I also think that the approach is quite clean.  Some checks would
happen at a later time, but it seems unavoidable in the generic case.
Checking TGID during hook_file_send_sigiotask() sounds reasonably
cheap.  (I suspect that trying to do that check early during
hook_file_set_fowner() would not save us much.)


> > P.S: [...] new patchset versions are posted at the top (no Reply-To
> >      header in the cover letter) [...]
> 
> Will do -- v5 (whichever option) goes out as a fresh top-level thread, no
> In-Reply-To/Reply-To pointing back at this review.

Awesome, thank you very much for looking into patching this! :)

–Günther
