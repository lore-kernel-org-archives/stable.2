Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7003EAC80
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787650141; cv=none; b=kGrHC0mKLfwubPX+76jLaH/qHfElwMCXm+d71s6YPoxisjd5oxzuC6mLuH5DL3b4z2+jL8ZR4xJW04drQSGuAYG5Jpqxtb3a8vwVUzcM4VfgpoNM8i0UsbhAAYfLQCx3Af8n7jS8KDAEhvNzvZ/ONXi4zSq1eLuTLKCsnK/B/gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787650141; c=relaxed/simple;
	bh=it/Wm0hwwDMU5ZnynexBLplwy6F+rvfkLfXizNRji/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4kK6kxea7RWW9hBSI9oaNS63s07St1b5d5MnJtoaBXxJXYK9ZaM1kUKOz1dpb5UFQMtmiU3vl9+SYDknm9PiacavMIneHyApmonERsW/kd5Y1w9HEP/bPf66NPBXc2iDmE0O2OYx9n5Ym2BMHG7tvwfcv6WghPbtPdS4zIF40U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KXecCzB9; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KXecCzB9"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a378f90555so7091976a12.3
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 02:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787650138; x=1788254938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=syExKixb5ojbug7gf/PFSmcFjNNr9pCGcOpMliPCGJ0=;
        b=KXecCzB9GWbUwivOtVwi4yAPfGmIWLVHryQUaFOepMWsHii8s1wzz9Vk33+C5w89Mv
         Elt1+SCDfHUtGMRiQqQmjMtoZfa46TIaXVRWKUuTB+LB9OXccy7LRr60/nyTryrWHRzT
         B02CyiOVQMQ6IGb5dA9I/J3ax6et4EF4kcvxDx2k966mHYM5wG61a7S+8WWQHodDIxlv
         WdNYzzz+XgqFh1hqQUb82dVbYUQOuXXFCfI3LkgbO0mzoIcBASG+y0uc5dJkUwTC8TNz
         HyvAJsOMLqkWBwFnmNK0OiopNB25J2/M2aytPfQ1oo/mWMGIumzV6D+w8pf4yUhF5uQ2
         E7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787650138; x=1788254938;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=syExKixb5ojbug7gf/PFSmcFjNNr9pCGcOpMliPCGJ0=;
        b=bLyi1BJ0xqGuf1ls62NTsMrix5l8EoS2ZGAG5Zx8K8/v4tgmgZ7pxrxqe8vhGALQDl
         cSVEfKnApHv1RWvEsAVKf93a0PonPT/hqkpQ4HQQd9qmSXDbNrcmut/98DNuLE4bgUt7
         Uua+cTRFfpkGCdc9G6QbDMangE9pMAHwUfLcvUcvmpK3yNABOrAQN3Asv77uq5jFeusB
         sUEeG9W14b+uVVPS8aTkiVY6RN5QnnPGwKpVujX1uVXkq2rrei3xaPjOieRAk82CRnTm
         w8p4Ce7vabIBruZPrQ2Y2rekzlgeQ6/psixww5EI+A9bDjATGv6+uWEoOSsuxiFdW5Az
         /0gg==
X-Forwarded-Encrypted: i=1; AHgh+RpPR7rSByqjEzCxAwdwBoCRa18yo/J+hdREwraOchJfGQP3UHUssP1pd7qvSrW4MwvdN9yAgkY=@vger.kernel.org
X-Gm-Message-State: AFuF++nai5mMHDVt9G6R2/I/yzU0CH2RN5rnnJXNGmE7nKtcc+1FAt0m
	xFsw5SMwsWDPDQEfQRqZeJPhJeYM2K+IdZ1qhgq4Fax+mKphnhsVTc9YvTkUVW/fSf8=
X-Gm-Gg: AR+sD12ue1aquDl6Mz8kR9dmrnj8XJHuTpVXf+6TNRa0sKDQ7i1aZZHiLyPgpSQ2mj4
	HpyfEdqas5+Y0XIzc40Ghc3o4RQFn6jVDiEOmPTk5G+nUp9BowF+JoeRw+z134j7IWssQgxuraH
	LGoiYfUfIJ9cRTKtd9R3L/klKWQ2yA7vr2BsuxviTL6BNti8VE9Y0sDNOnnZnmYqN0F3BYqBdkb
	S+O6gkd7N28D6E425d6vTeQyaMFXcX7Q9KsMLx0UGH7a1IK38auGx0QVgwDQz3QlZWEDAKmV56H
	5XqMXPyVbDzYsURUnOd1OSKIuNyt1hJ59+MPaoW31M2Mpce3Ty97ypki+OEdyfY26nXbzbfGgup
	wtxrMZozAtNXPJjzGp0DiU2dfFJ9pDxRNS/gaN8OJaAcbF8RmxfXfEbeDzAq/BUrPPg/UJRTcHK
	wDTy8Lc3dS3B59TTTgoWZyDHjEi+dL3Oid1icQU9p/+dPyRxOGN2JB2OSbVZ9khaqMvTHOt4AY
X-Received: by 2002:a17:907:3e2a:b0:c21:7feb:4574 with SMTP id a640c23a62f3a-c246a2cece6mr3358491066b.1.1787650137856;
        Tue, 25 Aug 2026 02:28:57 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24dfd91dd4sm399826766b.16.2026.08.25.02.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 02:28:57 -0700 (PDT)
Date: Tue, 25 Aug 2026 11:28:55 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Rio <rioo.tsukatsukii@gmail.com>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v6 5/6] panic: allow force_cpu redirect from an NMI
Message-ID: <ao1gV_fFfH1wdg1E@pathway.suse.cz>
References: <20260818163806.17460-1-include@grrlz.net>
 <20260818163806.17460-6-include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818163806.17460-6-include@grrlz.net>

On Tue 2026-08-18 16:38:05, Bradley Morgan wrote:
> nmi_panic() claims panic_cpu via panic_try_start() before calling
> panic(). When the panic later reaches panic_try_force_cpu(), the
> panic_in_progress() check sees panic_cpu set and refuses to redirect.
> The crash kernel runs on the CPU that took the NMI instead of the CPU
> requested with panic_force_cpu=:
> 
>   nmi_panic()
>     panic_try_start()              wins, panic_cpu = X
>     panic("%s", msg)
>       vpanic()
>         panic_try_force_cpu()
>           panic_in_progress()      true, panic_cpu is X
>           return false             redirect bypassed
>         panic_try_start()          already won
>         __crash_kexec()            on X, not the requested CPU
> 
> Try the redirect before claiming panic_cpu instead, as suggested by
> Petr Mladek. nmi_panic() now calls panic_try_force_cpu() first and
> claims panic_cpu only when no redirect happened. The requested CPU
> claims panic_cpu itself when it runs panic(), so panic_cpu does not
> need to be handed off. panic_try_force_cpu() copies the arguments
> before formatting (patch 3), so nmi_panic() can pass them to vpanic()
> again when no redirect happens.
> 
> The redirect IPI is sent with smp_call_function_single_async(), which
> is not guaranteed to work from NMI context. Treat it as best effort.
> It is worth the risk because the redirection is only used when the
> crash kernel would not work on the panicking CPU anyway.
> 
> Keep returning when the panic is already running on this CPU. A
> nested NMI, for example with unknown_nmi_panic while this CPU is
> inside panic(), must return and let the interrupted panic() continue
> instead of parking the CPU in nmi_panic_self_stop().
> 
> Mark the redirecting CPU offline before stopping it, like vpanic()
> does, so that panic_other_cpus_shutdown() on the target CPU does not
> wait for it.
> 
> Fixes: 2e171ab29f91 ("panic: add panic_force_cpu= parameter to redirect panic to a specific CPU")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260708164312.19044-1-include@grrlz.net
> Cc: stable@vger.kernel.org
> Signed-off-by: Bradley Morgan <include@grrlz.net>

The patch looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

See some comments below.

> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -513,10 +513,11 @@ bool panic_on_other_cpu(void)
>  EXPORT_SYMBOL(panic_on_other_cpu);
>  
>  /*
> - * A variant of panic() called from NMI context. We return if we've already
> - * panicked on this CPU. If another CPU already panicked, loop in
> - * nmi_panic_self_stop() which can provide architecture dependent code such
> - * as saving register state for crash dump.
> + * A variant of panic() called from NMI context. The panic is first
> + * redirected to the CPU requested via panic_force_cpu=, when configured.
> + * We return if we've already panicked on this CPU. If another CPU already
> + * panicked, loop in nmi_panic_self_stop() which can provide architecture
> + * dependent code such as saving register state for crash dump.
>   */
>  __printf(2, 3)
>  void nmi_panic(struct pt_regs *regs, const char *fmt, ...)
> @@ -525,6 +526,16 @@ void nmi_panic(struct pt_regs *regs, const char *fmt, ...)
>  
>  	va_start(args, fmt);
>  
> +	/* Try to redirect to the requested CPU before claiming panic_cpu. */
> +	if (panic_try_force_cpu(fmt, args)) {
> +		/*
> +		 * Mark ourselves offline so panic_other_cpus_shutdown() won't
> +		 * wait for us on architectures that check num_online_cpus().
> +		 */
> +		set_cpu_online(raw_smp_processor_id(), false);

It is a bit strange that we set this CPU offline in this code path
but not when the below panic_try_start() fails.
nmi_panic_self_stop(regs) is called in both situations.

I guess that we should mark the CPU offline in the other case
as well. But it is an indepent change. We could fix this later.

Feel free to keep this patch as is.

> +		nmi_panic_self_stop(regs);
> +	}
> +
>  	if (panic_try_start())
>  		vpanic(fmt, args);

Sashiko AI complains here:

| Does this sequence result in printing the 'target CPU is offline' warning
| twice?
| 
| If panic_force_cpu is set to an offline CPU, the newly added call to
| panic_try_force_cpu() evaluates this logic:
| 
| 	/* Target CPU is offline, can't redirect */
| 	if (!cpu_online(panic_force_cpu)) {
| 		pr_warn("panic: target CPU %d is offline, continuing on CPU %d\n",
| 			panic_force_cpu, this_cpu);
| 		return false;
| 	}
| 
| Because the redirect fails, nmi_panic() continues and calls vpanic(). Since
| vpanic() unconditionally calls panic_try_force_cpu() as well, the same
| offline check will execute and the warning might be printed a second time
| before the panic_in_progress() check can abort the redundant redirect attempt.

It is right. We might fix this by checking that panic_try_force_cpu()
has been called twice, for example, by checking the
panic_redirect_cpu value at the beginning.

But I would personally ignore this problem. It is a corner case.
The fix would make the code more hairy. IMHO, it is not worth it.

Best Regards,
Petr
