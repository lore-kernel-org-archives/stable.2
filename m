Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19F63655FD
	for <stable@vger.kernel.org>; Sun, 31 May 2026 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780224110; cv=none; b=HvX0QT3uZ0MZOFJDrMVeX4xzvGCFu9ydPyqHstZ1yh2ZZMZG/JQppByaeyNHgCvjnKSwSR4mHGY9hVda6K2Qd+VYDuHqIduUg26QNrHm6jyAemoC/aeaO8N+8Qk6uhoOYWlk9wvz1cvlSU24uqU5mtYY0BlPRJT5LM7FB5vZKQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780224110; c=relaxed/simple;
	bh=Wcx9iLblDp4hblQ+ibXg4HnEYwY70izi+BxL3C+KWI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkgsIjaU6/OS64cQ9nRFn7OOqXyM7DldhgXl0dyPPpNkdAVLj4prV33y8/Euvk7Ory6JVQTU+nA+aNCv5x5eHIhiys42QzvZU6kBTNjwlpu9+5dUtFgRo2vyDKUVO2XKNxO3+NaQGJpIOCbd9zzW7TTVddXErynZNS80hr8ToQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=G0OU4NmU; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="G0OU4NmU"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gSttq74bTzY7c;
	Sun, 31 May 2026 12:41:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1780224099;
	bh=LTPyEEY0B3ySg8X1BcNaRZY61/WIhBEjhdVchJdIjTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G0OU4NmUv6zHih8zeIu6GZiCHjUBARFKuHd6Vl3Pu3ftAbFT0jBz3klv4iXwwcMBn
	 dZmrAf3nma6uE53BtgCClRj9QdsYJzmc2PAQoem5u/7O7c/ACpEvIHtO0F3NhMvOT0
	 v51d1OZZPk3obY4A4BvdABo7KgaGg/cFEdi1DZCs=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gSttq2Dzlz7gL;
	Sun, 31 May 2026 12:41:39 +0200 (CEST)
Date: Sun, 31 May 2026 12:41:35 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: hexlabsecurity@proton.me
Cc: Justin Suess <utilityemal77@gmail.com>, 
	"gnoack@google.com" <gnoack@google.com>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3 1/2] landlock: fix LANDLOCK_SCOPE_SIGNAL bypass via
 F_SETOWN to invoker's pgid
Message-ID: <20260531.irah0eiM3Chi@digikod.net>
References: <7rvmLIHR1Zh8RDF1IY1-SYRHzErgw9gPHq0k98RLYVsmHqAejjxcuJi8V3QaSbW-SnNvY5tfM2Xn_S1dEajKV_f7iyitoPwJgOSTZQ0nytc=@proton.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7rvmLIHR1Zh8RDF1IY1-SYRHzErgw9gPHq0k98RLYVsmHqAejjxcuJi8V3QaSbW-SnNvY5tfM2Xn_S1dEajKV_f7iyitoPwJgOSTZQ0nytc=@proton.me>
X-Infomaniak-Routing: alpha

On Fri, May 29, 2026 at 07:07:30PM +0000, hexlabsecurity@proton.me wrote:
> From b5fdc79ce1cb2881d59dfed01d3d9170306be9e8 Mon Sep 17 00:00:00 2001
> From: Bryam Vargas <hexlabsecurity@proton.me>
> Date: Fri, 29 May 2026 12:49:41 -0500
> Subject: [PATCH v3 1/2] landlock: fix LANDLOCK_SCOPE_SIGNAL bypass via
>  F_SETOWN to invoker's pgid

Please send proper threaded emails.  Sending two unrelated
emails/patches and with additional headers in the body makes it more
difficult to handle and ignored by reviewer bots.

> 
> A Landlock-restricted process can bypass LANDLOCK_SCOPE_SIGNAL on the
> SIGIO delivery path and deliver arbitrary signals (including SIGKILL via
> F_SETSIG) to non-Landlocked targets that share its pgid, by exploiting a
> producer-side cache-vs-live evaluation gap.

What does mean: "producer-side cache-vs-live evaluation gap"?

It looks like the "cache" here is the fowner data, which is not a cache.

Could you please make it clear in the commit message what is the threat
(e.g. real-life scenario of a signal control bypass)?

> 
> The SIGIO path in hook_file_send_sigiotask() consults a cached subject
> stored in landlock_file(file)->fown_subject at fcntl(F_SETOWN) time
> (via hook_file_set_fowner()), instead of evaluating the live Landlock
> domain of the invoking task at signal-send time. The capture is gated
> by control_current_fowner(), which returns false (skipping capture)
> when pid_task(fown->pid, fown->pid_type) is in current's thread group.

Commit messages should mostly explain the "why", and only the minimal
"what".

A simpler commit message would be useful.

> 
> This is correct for PIDTYPE_TGID / PIDTYPE_PID, where the target is a
> single task sharing current's cred. It is unsafe for PIDTYPE_PGID and

By "task" do you mean "process"?

> PIDTYPE_SID: when current is at the head of its pgid hlist -- the
> default placement after fork(), hlist_add_head_rcu() in kernel/fork.c --
> pid_task(pgid, PIDTYPE_PGID) resolves to current itself,
> same_thread_group(current, current) is true, the capture is skipped, and
> fown_subject.domain stays NULL. hook_file_send_sigiotask() then
> short-circuits at "if (!subject->domain) return 0;", letting the kernel
> fan the signal out to every member of the group, including tasks outside
> current's Landlock domain that SCOPE_SIGNAL is supposed to protect.
> 
> The direct kill() path (hook_task_kill) is unaffected: it evaluates
> current's live domain on every call. Only the cached SIGIO path is
> broken.
> 
> Tighten control_current_fowner() to apply the thread-group exemption
> only when the target identifies a single task whose Landlock cred is
> necessarily shared with current (PIDTYPE_TGID, PIDTYPE_PID). For
> PIDTYPE_PGID and PIDTYPE_SID, always capture the current Landlock
> subject so the consumer's scope check runs against every member of the
> group at delivery time.

PIDTYPE_SID doesn't seem possible.

> 
> Stable kernels before the fown_subject conversion store the domain in
> landlock_file(file)->fown_domain; control_current_fowner() is identical
> there, so the same exemption and the same fix apply.
> 
> Fixes: 18eb75f3af40 ("landlock: Always allow signals between threads of the same process")
> Cc: stable@vger.kernel.org
> Reported-by: Bryam Vargas <hexlabsecurity@proton.me>

You should remove Reported-by because it is implicit when you also add a
Signed-off-by with the same value.

> Tested-by: Justin Suess <utilityemal77@gmail.com>
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
>  security/landlock/fs.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index c1ecfe239032..edaa52572cbd 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1909,6 +1909,18 @@ static bool control_current_fowner(struct fown_struct *const fown)
>  	if (!p)
>  		return true;
>  
> +	/*
> +	 * For PIDTYPE_PGID and PIDTYPE_SID, signal delivery fans out to
> +	 * every member of the group at SIGIO time. Even when pid_task()
> +	 * resolves to current itself (e.g., current is the pgid hlist
> +	 * head post-fork), non-current members of the group are still
> +	 * valid targets that must be checked by hook_file_send_sigiotask().
> +	 * Always capture the current subject for those types so the
> +	 * consumer scope check runs against the live fown_subject.

This looks good but could be simplified.

> +	 */
> +	if (fown->pid_type == PIDTYPE_PGID || fown->pid_type == PIDTYPE_SID)

PIDTYPE_SID is not possible for fowner, and I'd prefer a defensive
programming approach:

  fown->pid_type != PIDTYPE_PID && fown->pid_type != PIDTYPE_TGID

> +		return true;
> +
>  	return !same_thread_group(p, current);
>  }
>  
> -- 
> 2.43.0
> 
> 
