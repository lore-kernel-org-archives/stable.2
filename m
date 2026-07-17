Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4331340417
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303057; cv=none; b=qErnQx8eDqsNPIWgzyRPg/5N84YXCh/NEjLblWS6i3hL11U4QnxFu+KDALPnS1DiP/cBy8Rd9sJFsR6cyaYKPNVRf98r+CSUAEQJ6dn5j0TyoPaxQC0vBONhCNElmqsb0EKmgQ92CPe8xKVZzwESi5U+RMLqhI6vCzJVV6eBgbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303057; c=relaxed/simple;
	bh=n/wfwnqtnGvminIyol/cfz2Ze5UYwp6eKz58oVT3iVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pggQGn/EqdayGK0EZZg7gnEqZPREU02EWGDL8+9Fokqtki5k2phbu+cV+q4xZBGEBxr+PXsEwLGOmNmh6HCx4VLPk7MaHIyOC3s+7Wm7JsLM44D1kGTfjEAFO3ySJL1Idx6NrRRkvqLwj0aELLJPWLRu0XPnu32JuYEIrcXr3o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O9VhARKH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O9VhARKH"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493e4ccccc2so50686335e9.2
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 08:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784303053; x=1784907853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EWBhw7StCLNDSwr5xQ05sldMvvBYfrFruLgAYegBxmI=;
        b=O9VhARKHCe+dlnw/TNg6YYngx8iCj7zyMjEhlUCIrGiJy3qkRO+3DWbOSNo+BgLfsj
         etgf5qpZ34LMPrhAGLX1yU86vJzVCEtYjTMGuAZWcHNToyRE7uYrbUK6mgOqEdSsGy7B
         VTFp+zYKhD9ZxVpmWaEtjcFsACE5cnfgXWjgrk2gcfgPZ6nwJUye1uRJPl6ZKbbyyJv6
         hlMjdqa5aTun3WmMbz61DpjnLH5mlmrtLoX2Yb9g7dykyXsKyy7eQOttF10gfi/GsTy/
         +kWIGYDVB2IMm0J+r3vzojlKgOHaPDxcCkolKPgH/YQ/S853OALNIudPymqWKxCr3JZh
         2SVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784303053; x=1784907853;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EWBhw7StCLNDSwr5xQ05sldMvvBYfrFruLgAYegBxmI=;
        b=Ir64ELcffeAcaVwKaaxXCHAdbB31oNiNmJqBve4sOXLdUCrEqxjsSvAxPnGDBxO80x
         x5HAnuOu2WU8HKV0YqI9OP17MiONsjulVyeMOUNURmysafJRpQgAteQ+hUtiwevgTxY5
         1v286KMC9CQbvN6IhVxIAHMBKi/43CE0721VQIG78tJMi3V1jK/K++rlwMaa8Jq4lW16
         nDJQap48uVh7NKFEt/tQrjyJn2w7reVtEews6/fLPa+k3W2wOo8hqko7jN4j7TfFzQUz
         H/gjdudHOBgERp/XjsQma5ZMriN9uI82do1yj8NRtsJKjpCCLcpKZZIilh4MEgk1vmMU
         FMdw==
X-Forwarded-Encrypted: i=1; AHgh+Rp/pGmvHOjmMOe2e0SrioBfgZcI77/ZH6iNgssn6RBNJiaHjAwgap5+RPgn41SpMjztlk6N75w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb4CVhGfK1JIJa/Xzjkgub90LfhW9Tw7fXwlYJyzSjiKkqfIJf
	bYhyyFp71cG/B5ZUcjXwtlaxKCE72GnND5OM+RA3FMSylKt+iXs5Uni9M5w9bhlhbDU=
X-Gm-Gg: AfdE7cnjIrRqzYgCNMld0wb0eAzBb/Drvz+HsaJgfbgAayf5yw6IXrMRNfzPYxwlPUv
	/pcTZOBv2rDdo/zTrRPHOF/GeNZ7mkwVHFg9L3y6igOrcnyLWkU/xg/YHBKM56ESfc7hs3zDerO
	6L2ES3XtJtvPJzvwQiJs4T8viDT9OMOy8UoF/2qrkUqlGN8eDTbg4Iojg94WUaVB1vvZq7mFNBd
	mDpKGvArjMuuqzopEu2kJqpUZd1ow/Si9EtDWs36DaNEqTttafvyHoUdrSqrJMX4VtrpI5hgH+j
	nbZFVAiVHIlQKj06l3LFrO1U7X7RlXl59tMzn+4IlqSAocTbbF0p9FHO1Jk+MhuVZQUnWhLbe0X
	+WHl/JlS5IzTuoYk8Sa5DxBE8sm73Ro75sobio1ezjEepp/KZiLFVBDpabbm1QfZbScuNqKCcIq
	NSeT7Og70JOyo6OJs=
X-Received: by 2002:a05:600c:8b37:b0:493:e4ce:acd0 with SMTP id 5b1f17b1804b1-4954a3d0967mr36098615e9.1.1784303052813;
        Fri, 17 Jul 2026 08:44:12 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954d384146sm20641245e9.14.2026.07.17.08.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 08:44:12 -0700 (PDT)
Date: Fri, 17 Jul 2026 17:44:10 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bradley Morgan <include@grrlz.net>
Cc: akpm@linux-foundation.org, feng.tang@linux.alibaba.com,
	sashiko-bot@kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] panic: allow force_cpu redirect from an NMI
Message-ID: <alpNysl-ykOcqO5t@pathway.suse.cz>
References: <20260714173103.11585-1-include@grrlz.net>
 <20260714173103.11585-4-include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714173103.11585-4-include@grrlz.net>

On Tue 2026-07-14 17:31:02, Bradley Morgan wrote:
> nmi_panic() calls panic_try_start() before panic(), so it claims
> panic_cpu first. When the panic then reaches panic_try_force_cpu(),
> the panic_in_progress() check sees panic_cpu set and returns false,
> so the redirect to the requested CPU never happens. The crash kernel
> runs on the CPU that took the NMI instead.
> 
> The buggy call order, on a CPU X that is not the target (target is C):
> 
>   nmi_panic()
>     panic_try_start()              wins, panic_cpu = X
>     panic("%s", msg)
>       vpanic()
>         panic_try_force_cpu()
>           panic_in_progress()      true, panic_cpu is X
>           return false             redirect bypassed
>         panic_try_start()          already won
>         __crash_kexec()            on X, not C
> 
> The fix is to try the redirect before claiming panic_cpu. nmi_panic()
> now calls panic_try_force_cpu_fmt() first, and only calls
> panic_try_start() when no redirect happens. The requested CPU then
> claims panic_cpu itself when it runs panic(), so panic_cpu does not need
> to be handed off.
> 
> nmi_panic() holds an already formatted string, not a va_list. Add a

This is confusing. nmi_panic() does not _hold_ any string. Also
it is not _already_ formatted.

The problem is that the same args might be used twice in
panic_try_force_cpu() and vpanic(). So that panic_try_force_cpu()
must copy them.

I suggest to fix this in a separate patch, see below.

> variadic wrapper, panic_try_force_cpu_fmt(), so it can reach the
> existing formatting guarded by the cmpxchg in panic_try_force_cpu() without
> a signature change. The wrapper builds the va_list and the real
> function still copies and formats under the redirect cmpxchg, so no
> shared buffer is written before ownership.
> 
> The redirect sends the IPI via smp_call_function_single_async().
> This is safe from NMI context: the doc on the _async variant
> states it can be called with interrupts disabled, and kgdb_roundup_cpus()
> already calls it from NMI/debug context (kernel/debug/debug_core.c).

I do not think that it is fully safe. For example, see smp_send_stop()
vs crash_smp_send_stop().

I would rather say that it is a best effort. And it is worth the risk
because the redirection should be used only when panic() would fail
otherwise.

> The nmi_panic() body is reshaped to a goto self_stop, since panic()
> is noreturn and the stop path is shared.
> 
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -450,12 +450,32 @@ static bool panic_try_force_cpu(const char *fmt, va_list args)
>  	/* IPI/NMI sent, this CPU should stop */
>  	return true;
>  }
> +
> +/* For callers without a va_list, such as nmi_panic(). */
> +static __printf(1, 2)
> +bool panic_try_force_cpu_fmt(const char *fmt, ...)
> +{
> +	va_list args;
> +	bool ret;
> +
> +	va_start(args, fmt);
> +	ret = panic_try_force_cpu(fmt, args);
> +	va_end(args);
> +
> +	return ret;
> +}
>  #else
>  __printf(1, 0)
>  static inline bool panic_try_force_cpu(const char *fmt, va_list args)
>  {
>  	return false;
>  }
> +
> +static __printf(1, 2)
> +bool panic_try_force_cpu_fmt(const char *fmt, ...)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_SMP && CONFIG_CRASH_DUMP */
>  
>  bool panic_try_start(void)
> @@ -519,11 +539,20 @@ EXPORT_SYMBOL(panic_on_other_cpu);
>   */
>  void nmi_panic(struct pt_regs *regs, const char *msg)
>  {
> +	/* Try to redirect to the requested CPU when one is set. */
> +	if (panic_try_force_cpu_fmt("%s", msg))
> +		goto self_stop;

This correctly copies the argumetns when panic_try_force_cpu()
is called in nmi_panic() code path. But there is the same
problem when panic_try_force_cpu() is called in vpanic().

IMHO, panic_try_force_cpu_fmt() makes things too complicated.
The patch where the arguments were copied directly in
panic_try_force_cpu() looked better, see
https://lore.kernel.org/all/20260705164123.18746-1-include@grrlz.net/

We will need v5. Please, remove panic_try_force_cpu() in this patch.
And add the va_copy() into panic_try_force_cpu() in a separate patch
like it was proposed before. So, v5 would have 4 patches...

But please wait few days. People might have different option
about using smp_call_function_single_async() for the redirection
in NMI. Also I might have missed something....

> +
> +	/* Try to acquire the right to proceed with the noreturn panic(). */
>  	if (panic_try_start())
>  		panic("%s", msg);
>  
> -	if (panic_on_other_cpu())
> -		nmi_panic_self_stop(regs);
> +	/*
> +	 * panic_try_start() only fails when a panic is already in progress
> +	 * on another CPU, in which case this CPU must stop.
> +	 */
> +self_stop:
> +	nmi_panic_self_stop(regs);
>  }
>  EXPORT_SYMBOL(nmi_panic);

Best Regards,
Petr
