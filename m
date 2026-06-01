Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C541F360ED8
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 22:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780351738; cv=none; b=cnpPfv/Liq4By8knMwt8IeQrjxOb3tN6HnOG38nohJBwAh1YOW0bVTouYfgJ1odRBIPQg0n49CcS7cDx94zaF3jwfA//NSh0/t32xkP9+9kg++sNOX2VdDorcDngL5bg24sBMV6vWB96UFSiELGOfS8M9oy1/e7E3Yol/54WpRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780351738; c=relaxed/simple;
	bh=zZ1OG+0BsRnJQ+8GlFp/Ufe3W6tMC4asQu6TyQBTSsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ps80gdAf9gcYIBeRGNxWo5F+j6rzmqbSwnKhNTpn/05VOnqZvS8jnKh0pvG61XqKBPDuqKxladD7durLGRrUuCA9fOnBMa5LaG6ssrTkW8EBxUL20BlpWGC1kVGAkDaMbSJB+wuHpHrqrsPpZYx6rKgXl5s3rWxIPTb0OYnmvCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TR92kAN5; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TR92kAN5"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45eec22fab7so2418431f8f.3
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 15:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780351735; x=1780956535; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rAhp16dJFI2PsFp27rrivudvE8RRL21MgbXmfxm8dus=;
        b=TR92kAN5S8AyJ+2+8rGr/hSDA2jcW0WollYVAWrfQlB4BtDhNslfiRPnAsdtw0USZt
         xPPWuwV8FV76B+3vEkoCn0edrrVH/z/eFqj6HMkNoDc+45Poy2tjZRoE38deznOGYKol
         Q9NmcD/U3EN42E1Y7xjoVhTrPHMnQBH75vim5tLUOVJFhuCG3YCqKsQ+zo/SewMM4Pwx
         RHz/mx0xG4H1Lw/7l0I8zhK3qLhVJtr7ptWRg+lDUGVBTFRQUivPP8ai4liPC7Cvh7uv
         o1I6sx15otP7siICTAs8YFHN8ehbz/2RAxa3j4rkhXYAPoR+JW/KcBiyq9knY8FPpbLB
         juiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780351735; x=1780956535;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rAhp16dJFI2PsFp27rrivudvE8RRL21MgbXmfxm8dus=;
        b=Yslvw4mMh3WjdRFD6yGOUq9DieDxyh+Py5EEk4YmHYxA+40r2qpuccXuUgSgfEW8sB
         wsYvBtDLCeDGbgH5Mq3uHkKYOxckNuEwkT5tfmpft15rjrAk3u5mFiIgSmFAmwzgFNap
         /Ze3XxJqq8+O+kFeGbXVEaTMmmDcURethahLWDy1aPakGfQoGBXSIerWkZGV9mlbuEPZ
         Uu+ZUTqVte+lY6MZM7wj1JX9wG2/GPiX1TpWO0V/kR5NANhrHOcXGSDhuksjhIvZivMM
         t/mBBbsf1L3Y9Nzdbawn76BXhoH+n0yVecMw3TkSAJzwgmDOgznodWyLD+PKkSJEdGh0
         i13w==
X-Forwarded-Encrypted: i=1; AFNElJ+S7koK9EtohW2w1PhR24xsu4XI/Xc0A0IrYKl7HIjKwC0E/dvcSGrxT33J8MOoByWikHky+x4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5nOS7rbwbH18LxLVRijivf7xHZt5F6NoOZtkqRrh+EtUHGQQ5
	rGlgNQ8nzHu1X18Iuw5jxNnp79tGujkBIl0X57edI92nMsqzeHJDBHiO
X-Gm-Gg: Acq92OHx0BI/eIdjZWlSOM0RY5+X5YVgNW2IONhWMEit5e9ygSGL3CBpTUX4Dlc0eYR
	wODslN7I0+zW5+G5GPz7p19fspeQ0VoHgT1pDgNQ7MhdeFmARBU8ynEyE7xE84LTKa3Drnkflus
	T+trP+7IY+6v/3UEQza16ZzZpVK4myeAo2sdnq9bsWiXDBF/OStnKy+rJrE7MylC51VtIxATohx
	FE6pZsN7NxmX3KHUAvKzwlTsGC+QPogfIu99YYzncJf6eeBx/85S1We/zbLKnRjrgHGC3dwqa8b
	kh7cM9qvQ5HnrIVe3yEkJhAjdhNPowfa37CarLcvRaAart/dN+5aaNg0yn/P4p3QxcmLlIzbqnC
	/hYAeKSJ8ng2pAPV+MAjcQU8YinNq6T8aPKQSevhWHQfGVrsNvLhrVqjBLRvpTc9rQ1BbJ9lLSj
	v/ah9VmiWE4t8LGhtaBjTcEC/JyMx/mkVPqyUbVgWS8lPHhquW13FsJ8CYRLXR+H2sfsXWrQ==
X-Received: by 2002:a05:6000:41f9:b0:460:ff2:63e5 with SMTP id ffacd0b85a97d-4600ff2650emr12534219f8f.18.1780351734962;
        Mon, 01 Jun 2026 15:08:54 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354c682sm26914936f8f.23.2026.06.01.15.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 15:08:54 -0700 (PDT)
Date: Tue, 2 Jun 2026 00:08:47 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: hexlabsecurity@proton.me
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Justin Suess <utilityemal77@gmail.com>,
	"gnoack@google.com" <gnoack@google.com>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] landlock: fix LANDLOCK_SCOPE_SIGNAL bypass via
 F_SETOWN to invoker's pgid
Message-ID: <20260601.aebdd5a9ecc6@gnoack.org>
References: <7rvmLIHR1Zh8RDF1IY1-SYRHzErgw9gPHq0k98RLYVsmHqAejjxcuJi8V3QaSbW-SnNvY5tfM2Xn_S1dEajKV_f7iyitoPwJgOSTZQ0nytc=@proton.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7rvmLIHR1Zh8RDF1IY1-SYRHzErgw9gPHq0k98RLYVsmHqAejjxcuJi8V3QaSbW-SnNvY5tfM2Xn_S1dEajKV_f7iyitoPwJgOSTZQ0nytc=@proton.me>

On Fri, May 29, 2026 at 07:07:30PM +0000, hexlabsecurity@proton.me wrote:
> From b5fdc79ce1cb2881d59dfed01d3d9170306be9e8 Mon Sep 17 00:00:00 2001
> From: Bryam Vargas <hexlabsecurity@proton.me>
> Date: Fri, 29 May 2026 12:49:41 -0500
> Subject: [PATCH v3 1/2] landlock: fix LANDLOCK_SCOPE_SIGNAL bypass via
>  F_SETOWN to invoker's pgid
> 
> A Landlock-restricted process can bypass LANDLOCK_SCOPE_SIGNAL on the
> SIGIO delivery path and deliver arbitrary signals (including SIGKILL via
> F_SETSIG) to non-Landlocked targets that share its pgid, by exploiting a
> producer-side cache-vs-live evaluation gap.
> 
> The SIGIO path in hook_file_send_sigiotask() consults a cached subject
> stored in landlock_file(file)->fown_subject at fcntl(F_SETOWN) time
> (via hook_file_set_fowner()), instead of evaluating the live Landlock
> domain of the invoking task at signal-send time. The capture is gated
> by control_current_fowner(), which returns false (skipping capture)
> when pid_task(fown->pid, fown->pid_type) is in current's thread group.
> 
> This is correct for PIDTYPE_TGID / PIDTYPE_PID, where the target is a
> single task sharing current's cred. It is unsafe for PIDTYPE_PGID and
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
> 
> Stable kernels before the fown_subject conversion store the domain in
> landlock_file(file)->fown_domain; control_current_fowner() is identical
> there, so the same exemption and the same fix apply.
> 
> Fixes: 18eb75f3af40 ("landlock: Always allow signals between threads of the same process")
> Cc: stable@vger.kernel.org
> Reported-by: Bryam Vargas <hexlabsecurity@proton.me>
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
> +	 */
> +	if (fown->pid_type == PIDTYPE_PGID || fown->pid_type == PIDTYPE_SID)
> +		return true;
> +
>  	return !same_thread_group(p, current);
>  }

The reason why the same_thread_group() check exists is so that Go
programs that had to use libpsx instead of TSYNC had a way to signal
their own OS threads at the C level (a feature used by linked C
libraries and specifically by libpsx itself, so it prevented nested
Landlock domains).

(a) On Linux 7.0, the Go-Landlock library automatically uses TSYNC so
    this is not a problem any more.

(b) On earlier Linux versions

    * libpsx signaling is also going to continue working,
      because it uses normal signals instead of SIGIO

    * other libraries are also likely to continue working, unless they
      use the somewhat obscure SIGIO with PIDTYPE_PGID or PIDTYPE_SID.

    There is little incentive to use SIGIO in a pure Go program, as
    the runtime already implements file descriptor polling logic (with
    epoll, which is anyway a better choice)

So, this looks fine from the Go perspective; I doubt that this has
practical implications for Go.

Thank you for spotting this and providing a fix! 🙏

–Günther
