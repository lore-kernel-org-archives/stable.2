Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6454D2EE4
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 11:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780657895; cv=none; b=ef0gaX8KuT4Ge9bIp6A0oT/9hrDt8Hta+UXiVeWpEMCLmY1X1QbSLhZ+n9tK+w5ayu/cUsMUD1w7elLb0gNBxufzYXqUobyMUjvda27lInYhlH9QXn3vSKRYh8MfS98pyBIKYryZss94pOL43qKxZ5STpU2j/xps98lZtWwp51Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780657895; c=relaxed/simple;
	bh=NzXUcDwqkS4QUba0RK4Z+8RdDly35ObmbNBSFZcPT5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgrAp3+IdqbEyTh0Z2XKfyqrl7xHk6eA3YldM4gKJrDkubSyeaRlQ/iEXH8Hk7lPS4fw3lT7QqeL7Bso2zaaX5Oc4sB6MCnEoPQ4ZJMJMfS+RQzfH2fRUv5kipBLsPAibwM+WJ37JK4HRSrskbfTCosVTRspO+pHmhqJpqVjHd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYWYRe9y; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYWYRe9y"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490b2b037d2so15803465e9.3
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 04:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780657886; x=1781262686; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NP8UmE1JJTaZ1ok4zYbN2k3div/k4FL0sO/lWo9YA80=;
        b=YYWYRe9yDyhz7sSrTZtyFgLxQHHw/3ldxZbu4Wu2HpgZSPqkwYym7Tb7jHTJXCmUKg
         ln0tr2Mp86n/aOfD78bPNFOJtAOCnY0cWXxss1CjovyRBoIXGIA1MXhqPe4hwBTi09q1
         43nkvHpLZvO0Hw3onDPUE6e1mg1VwJ9Mf6OvrUIaV34ivasEP1KEAJDW9Z0qiYQc0UrM
         ykKg6owwO/XdRUNpM9aQEazFSyvOt5JgnZYrAQEoGFJ6/w1wSyguIsFy9CcF781B/YX1
         Ad8ESsI/4xQclaQn1dTliAODMJ7+mWxlG6T4QKaNBwnhaCYY+iGFPTaRNpq7yzB6l1ZE
         twHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780657886; x=1781262686;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NP8UmE1JJTaZ1ok4zYbN2k3div/k4FL0sO/lWo9YA80=;
        b=F3O9PC1HSXp5NSz+6ikOA8vHQ+DEXFWH1AfUPbTwXPYJjjfbMzYNMtoTGQA5hBSKMW
         JN5h+jcx4gkllGpU/d6PZwQTg+Dy40Y4xTvrUIucq55SLl4ZcWCxKL84kzXjFQpItUdC
         oTBLKzpCZQMi5jfBLksz9Dwqy8EQTkvgS9R37tQG18LJ5Mp4zFBQPID0SvHsXJfOflA1
         n5qsQMwsuqrcNywybyqaBtviJijvVSCXTIUqz/RT+ut+/qUxc4PMBjwDfENOc/MEWof/
         qC7Cr440yaq/KV1EPvqZXDgnUW7A5UigWgYj+FRj0xCqzNWy+z8hAk6P/oDtv+pwmLWY
         mwuQ==
X-Forwarded-Encrypted: i=1; AFNElJ/DfOk0f43eCRzcjS1KsdhHVRkMkG9WeeZeGJ2PMfEHzo00kpaq2b6fSf9eI5nghFBK5NKZTIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx39+JAWkKOz3ifBcBuxbgAaasBc3GpCDIo/b0F4X4QDoKXdhK1
	zLy64kYJlvzlRQcRjkbC8iQUenS6xKpJm45nXumzbs5vRtPunnMbA9S4
X-Gm-Gg: Acq92OH8fVCbkhYeDCWwyfQjhAzCWcdMtbbGtaR20MBLTJrE3YAVm1MbufwGfxQAoE0
	YiIdwmkRbJCYHikt/09ItEA39OV6Qi72BP5yb/+OKVFWmAG5egaF1zTYcy1OSmE+/v0zFPHE5KO
	AxtdbQzFk2Ud7nILdQm7NRZSZh15N877/bMpprAfxwinh+pp8AUI+ZAB6grEZ5cr8gaRaT3RGEP
	4pCUOSIAt+rJ+JfII5FyQ27FrsAGaWmcGbS9OuLmJy7RnvIUTYji6i29ImuZoQHlbCMegh2Dpik
	Wlkl7n1PxRzshfOu/RElJhV8eX0vWbK2YRbUO4rEZvJhoeTPfDUp1DBrfg3oFXSYtShvpur4uBN
	SRFwbipaYjP7Q9g94nVrlBfIacee9C0zWQeMGmIqmT2rJv7NKtuipxCggAPHi9y5Y6BC6BqzQFi
	RPhLXurE7arq8B3IhP5s69CBy2yxVKdLwzv1hy9NMDKgZ4Qa54MhWAtdV2Vpo=
X-Received: by 2002:a05:600c:530d:b0:490:b92f:ef5b with SMTP id 5b1f17b1804b1-490c25d4cfcmr51953845e9.13.1780657886089;
        Fri, 05 Jun 2026 04:11:26 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344762sm26586232f8f.23.2026.06.05.04.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 04:11:25 -0700 (PDT)
Date: Fri, 5 Jun 2026 13:11:10 +0200
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
Subject: Re: [PATCH v5 1/2] landlock: fix LANDLOCK_SCOPE_SIGNAL bypass on the
 SIGIO path
Message-ID: <20260605.ed2bc08adf71@gnoack.org>
References: <cover.1780614610.git.hexlabsecurity@proton.me>
 <56bffc24f3d0d08b45a686a48e99766b0a0821fa.1780614610.git.hexlabsecurity@proton.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56bffc24f3d0d08b45a686a48e99766b0a0821fa.1780614610.git.hexlabsecurity@proton.me>

On Thu, Jun 04, 2026 at 11:16:56PM +0000, Bryam Vargas wrote:
> LANDLOCK_SCOPE_SIGNAL must prevent a sandboxed process from signaling
> processes outside its Landlock domain.  It can be bypassed through the
> asynchronous SIGIO delivery path.
> 
> A sandboxed process that owns any file or socket can arm it with
> fcntl(F_SETOWN, fd, -pgid), fcntl(F_SETSIG, fd, SIGKILL) and O_ASYNC, so
> that an I/O event makes the kernel deliver the chosen signal to the whole
> process group.  As the head of its own process group -- the default right
> after fork() -- that group also holds the non-sandboxed process that
> launched it, e.g. a supervisor or a security monitor.  The sandbox can
> thus kill or repeatedly signal exactly the processes SCOPE_SIGNAL is meant
> to protect from it.
> 
> The scope is enforced in hook_file_send_sigiotask() against the Landlock
> domain recorded at F_SETOWN time, not the live domain of the sender.
> control_current_fowner() decides whether to record that domain and skips
> recording it when the fowner target is in the caller's thread group --
> safe only when the target is a single process sharing the caller's
> credentials (PIDTYPE_PID, PIDTYPE_TGID).  For a process group
> (PIDTYPE_PGID) the target resolves to the caller itself when it is the
> group head, recording is skipped, and hook_file_send_sigiotask() then lets
> the signal fan out to the whole group unchecked.
> 
> Record the domain for every non single-process target so the scope is
> enforced against each group member at delivery time.
> 
> That recording is necessary but not sufficient on its own: the kernel
> signals a process group through its members' thread-group leaders, and the
> leader of the registrant's own process can carry a different Landlock
> domain than the sibling thread that armed the owner.  domain_is_scoped()
> would then deny that leader, even though commit 18eb75f3af40 ("landlock:
> Always allow signals between threads of the same process") requires
> same-process delivery to be allowed.  hook_task_kill() avoids this by
> evaluating same_thread_group() live, per recipient; the SIGIO path instead
> delegates the whole decision to a single registration-time check, which a
> process-group fan-out cannot honor.
> 
> So also record the registrant's thread group next to its domain and exempt
> it at delivery: hook_file_send_sigiotask() allows the signal whenever the
> recipient belongs to the registrant's own process, restoring the
> same-process guarantee while keeping out-of-domain group members blocked.
> The direct kill() path (hook_task_kill) already evaluates the live domain
> and is unaffected.
> 
> Fixes: 18eb75f3af40 ("landlock: Always allow signals between threads of the same process")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
>  security/landlock/fs.c   | 15 +++++++++++++++
>  security/landlock/fs.h   | 10 ++++++++++
>  security/landlock/task.c | 11 +++++++++++
>  3 files changed, 36 insertions(+)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index c1ecfe239032..ff2c12e38bfc 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1909,6 +1909,15 @@ static bool control_current_fowner(struct fown_struct *const fown)
>  	if (!p)
>  		return true;
>  
> +	/*
> +	 * A process-group fowner fans the signal out to every member at
> +	 * delivery time, so record the domain for any non single-process
> +	 * target -- even when it resolves to current as the group head -- and
> +	 * let hook_file_send_sigiotask() check the live scope per recipient.
> +	 */
> +	if (fown->pid_type != PIDTYPE_PID && fown->pid_type != PIDTYPE_TGID)
> +		return true;
> +
>  	return !same_thread_group(p, current);
>  }
>  
> @@ -1916,6 +1925,7 @@ static void hook_file_set_fowner(struct file *file)
>  {
>  	struct landlock_ruleset *prev_dom;
>  	struct landlock_cred_security fown_subject = {};
> +	struct pid *prev_tg, *fown_tg = NULL;
>  	size_t fown_layer = 0;
>  
>  	if (control_current_fowner(file_f_owner(file))) {
> @@ -1928,21 +1938,26 @@ static void hook_file_set_fowner(struct file *file)
>  		if (new_subject) {
>  			landlock_get_ruleset(new_subject->domain);
>  			fown_subject = *new_subject;
> +			fown_tg = get_pid(task_tgid(current));
>  		}
>  	}
>  
>  	prev_dom = landlock_file(file)->fown_subject.domain;
> +	prev_tg = landlock_file(file)->fown_tg;
>  	landlock_file(file)->fown_subject = fown_subject;
> +	landlock_file(file)->fown_tg = fown_tg;
>  #ifdef CONFIG_AUDIT
>  	landlock_file(file)->fown_layer = fown_layer;
>  #endif /* CONFIG_AUDIT*/
>  
>  	/* May be called in an RCU read-side critical section. */
>  	landlock_put_ruleset_deferred(prev_dom);
> +	put_pid(prev_tg);
>  }
>  
>  static void hook_file_free_security(struct file *file)
>  {
> +	put_pid(landlock_file(file)->fown_tg);
>  	landlock_put_ruleset_deferred(landlock_file(file)->fown_subject.domain);
>  }
>  
> diff --git a/security/landlock/fs.h b/security/landlock/fs.h
> index bf9948941f2f..911b83669e20 100644
> --- a/security/landlock/fs.h
> +++ b/security/landlock/fs.h
> @@ -78,6 +78,16 @@ struct landlock_file_security {
>  	 * euid.
>  	 */
>  	struct landlock_cred_security fown_subject;
> +	/**
> +	 * @fown_tg: Thread group of the task that set the file owner, pinned
> +	 * while @fown_subject holds a domain.  It lets
> +	 * hook_file_send_sigiotask() always allow a SIGIO delivered to the
> +	 * owner's own process -- e.g. the thread-group leader reached through a
> +	 * process-group owner -- matching the same-process exemption of
> +	 * hook_task_kill().  NULL when no domain is recorded.  Protected by
> +	 * file->f_owner->lock, like @fown_subject.
> +	 */
> +	struct pid *fown_tg;
>  };
>  
>  #ifdef CONFIG_AUDIT
> diff --git a/security/landlock/task.c b/security/landlock/task.c
> index 6d46042132ce..7ddf211f75c3 100644
> --- a/security/landlock/task.c
> +++ b/security/landlock/task.c
> @@ -411,6 +411,17 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
>  	if (!subject->domain)
>  		return 0;
>  
> +	/*
> +	 * Always allow delivery to the file owner's own process, including a
> +	 * thread-group leader reached through a process-group owner.  This
> +	 * mirrors hook_task_kill()'s same-process exemption and preserves the
> +	 * guarantee of commit 18eb75f3af40 ("landlock: Always allow signals
> +	 * between threads of the same process"), which the registration-time
> +	 * check cannot honor for a process-group target.
> +	 */
> +	if (task_tgid(tsk) == landlock_file(fown->file)->fown_tg)
> +		return 0;
> +
>  	scoped_guard(rcu)
>  	{
>  		is_scoped = domain_is_scoped(subject->domain,
> -- 
> 2.43.0
> 
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

Thank you, this looks good!
–Günther
