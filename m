Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F293D4132
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646432; cv=none; b=NF0GoGJl6NJio0ld/bvBqdy24hv9kUPDj0NUwiMi6NCa3oiG6VruAc6zjPN1/CvVbHwr9y38VsaN9dSWcZaGtQEdhbybGQo1NxXDlyRWLEA792VrDD52fIokVWVEAop5YWEhmaNilH2yXLbhiw8mpO+AtKpzr6DekuMWLL4GSrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646432; c=relaxed/simple;
	bh=dyVQW9gRLSLRud2A56oCasKJYXjEIo8Bbt+OQMWXYzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPxl7jSql5n3E2HnuA6ELZdFkyAYbKBwiKqB4CGn0UFpo47cr7GGKMyM9HBZ9nrE60bZLELeWRqvaV9U/+N38Tj1vqJjdszD61eNZQK7ZExjKFtTi3PZeuFg2W6V4+voVu14jkiUO9DqfsiB//3fnfuFFLRKbTPCdacbcZ05oxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EvPB3AGd; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EvPB3AGd"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a15d54ac95so7691744a12.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 01:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787646429; x=1788251229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WlBe2tCB1TNQh/yTFepa09hxWsDbL5hbhAFU88+P9Z8=;
        b=EvPB3AGd8zU0bVWoGqAKtmeoAyZUCO/AVVdiJcDCiIwtqJMqanoTn1B0GiBzZl8fJc
         mMYPPDWPi5fGGaeqCHgxDJT02ChpNpFxc3r5wl1t1oMigXNK4Uu9ohDFiKetCoDNaWwv
         YUIae+SSzeUwMtnVsWJWi5CPq5QZ4o41tNhYb7BhSV4l0UNvN/Vp4IRWeNxzllI2MD1R
         6R1dDkLQp01HbjFL6Q3hzmFXM4iXzf4MSFZM+hoRVFnpWvo1+34KWwOKSw34dCIzomcE
         6uHtgQFoux8ZcnS30t1+WKd8EXnLQp+5H/N3h9wAqWU8gmsNcxXiA2h6xPtLOHLVCucK
         opqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787646429; x=1788251229;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WlBe2tCB1TNQh/yTFepa09hxWsDbL5hbhAFU88+P9Z8=;
        b=i6IkuwYUJ8yiTQw57OmsiuCfoysdHDTQW+OdOZF7dHKQ9J3NoqFaX7c0EYXBbYGgL3
         FIPEcGLAj77UgvBiuYy4Ct5v1PGUu+IMBx+3J+T+EYsI8bTCIfENb+KG4Vy+xCtQ3PGM
         kvbNNbELiRPulMuafTxGvYO1hIbO8xcW9m1Z5PFKTfoWgdybqmGdVsWnT7x0iWEg+ov6
         rOomQoQN/g7xA1jYyOWlo8Rwuqg4eARnWCsQFsCRVDOAOYP2goAFlaxSthUNRKM9N7rU
         6S22SKyHtlW6lgxUVbZ6o6zvbJCf7kAWISkXEEoRsy2BtV3Po4dqqxvV33Tra8uRY9RU
         ao2Q==
X-Forwarded-Encrypted: i=1; AHgh+RrjMv/rPKfLj0gJFAA8E4nORwSkPkGcS63XKqGHcJ3OQ1nnTld7SYaFUJ8oO0tOsyW4bGY3gj8=@vger.kernel.org
X-Gm-Message-State: AFuF++khmMJ8O0TCNWbyfYsHOGFf7lQcp7UitURpim5UaA1lditGI7b9
	5ILSIAY4wTAWrmyezvEQCjfWDd1Ht4+mGZ9tizms42etXpMuly/L5xzjjLPnGIykEAM=
X-Gm-Gg: AR+sD12xsRffwXwGboZ9kT4cYHKzNoDhGSSKuJc4vgcvGG/Q4aco1Bv0SS047WaMCd9
	ORFp4gKWFR4JvpR7yoRiJyj/cBHeDNefohWQ/Ycd4CoR+vvv55Ixj/+sxKcs3HgctK68g+46pWf
	Q+IxKle5jzbSVcx8x+C2ajZBYri9+kP8ogGfFMQ2MhlCOv6wIOCvAIo/w1YshaHks0WqeVSyaTT
	dMKI6432A+TLhzGJ8l7jivfIHqPy7MeheTrb3bDUQ7+j8XedrWv2ahj03XfKmyBKTlHF9bQMY3B
	hWLm+e+PFkTPmu4xR48xrlj65jhjnIQGUqWxVVD22Plc+io/AGC9h3xwhuihtiEeewPW/da8hpf
	tVQw8x2oZZ/b4g7LuLO9xuoX08TTt0uB+vuL4BWhE4OdFoXoEVcv5Zrey8E+JCg40iz6XDitydO
	v0ebK6FT0I7DAbMC6ekemC0isXru+XsDLjH0bP535JQeuW4vGtsezc69yYYWFoHw==
X-Received: by 2002:a05:6402:21d4:b0:69a:928:9405 with SMTP id 4fb4d7f45d1cf-6a582af8853mr24585036a12.1.1787646429584;
        Tue, 25 Aug 2026 01:27:09 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e00108asm18987959a12.2.2026.08.25.01.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 01:27:09 -0700 (PDT)
Date: Tue, 25 Aug 2026 10:27:06 +0200
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
Subject: Re: [PATCH v6 1/6] panic: fix redirect CPU race in
 panic_try_force_cpu()
Message-ID: <ao1R2u5QQKnnIzcZ@pathway.suse.cz>
References: <20260818163806.17460-1-include@grrlz.net>
 <20260818163806.17460-2-include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818163806.17460-2-include@grrlz.net>

On Tue 2026-08-18 16:38:01, Bradley Morgan wrote:
> The cmpxchg() in panic_try_force_cpu() makes sure that only one CPU
> tries to redirect panic() to the requested CPU. It is similar to the
> cmpxchg() in panic_try_start() which makes sure that only one CPU does
> the panic(). In both situations, only the winner of cmpxchg() should
> proceed further. Other CPUs should go offline.
> 
> There is a bug because the cmpxchg loser returns false and falls through
> into vpanic(). Two non-target CPUs A and B panic, the requested CPU is C:
> 
>              cpu A                          cpu B
>           ----------                     ----------
>     panic()                              panic()
>     vpanic()                             vpanic()
>     panic_try_force_cpu()                panic_try_force_cpu()
>         cmpxchg wins                        cmpxchg fails
>         redirect = A                        old_cpu = A
>         IPI -> C                            return false      <- BUG
>         return true                     panic_try_start() wins
>     panic_smp_self_stop()                __crash_kexec() on B
>     (A stops)                            (target C bypassed)
> 
> The loser must stop, not fall through. It cannot just return true,
> though. A CPU that already won the redirect cmpxchg can reenter
> panic_try_force_cpu() on the same CPU, for example a nested NMI during
> the message formatting, before the IPI is sent:
> 
>              cpu A (1st)                  cpu A (nested)
>           ----------                     ----------
>     panic()
>     vpanic()
>     panic_try_force_cpu()
>         cmpxchg wins (redirect = A)
>         vsnprintf(msg) ...
>             <-- NMI, nested panic -->
>                                      panic()
>                                      vpanic()
>                                      panic_try_force_cpu()
>                                          cmpxchg fails
>                                          old_cpu == A (this CPU)
>                                          return true   <- would halt
>                                      panic_smp_self_stop()
>                                      (IPI never sent, panic abandoned)
> 
> Check old_cpu against this_cpu so a second call from the same CPU
> returns false and falls through to panic_try_start() instead.
> 
> Also fix the panic_in_progress() check. We must not redirect when
> panic_cpu is already assigned. Return true to stop when the panic is on
> another CPU, false to proceed when it is this one.
> 
> Update the panic_try_force_cpu() doc comment for the new return value
> semantics.
> 
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -396,16 +397,20 @@ static bool panic_try_force_cpu(const char *fmt, va_list args)
>  		return false;
>  	}
>  
> -	/* Another panic already in progress */
> +	/*
> +	 * Don't redirect when a panic is already in progress. Stop this
> +	 * CPU when it's another one, proceed when it's this one.
> +	 */
>  	if (panic_in_progress())
> -		return false;
> +		return panic_on_other_cpu();
>  
>  	/*
> -	 * Only one CPU can do the redirect. Use atomic cmpxchg to ensure
> -	 * we don't race with another CPU also trying to redirect.
> +	 * Only one CPU can do the redirection. Others should go offline.
> +	 * Continue with panic() when we already tried the redirection
> +	 * from this CPU before, for example via nmi_panic().
>  	 */
>  	if (!atomic_try_cmpxchg(&panic_redirect_cpu, &old_cpu, this_cpu))
> -		return false;
> +		return old_cpu != this_cpu;
>  
>  	/*
>  	 * Use dynamically allocated buffer if available, otherwise

Just for completeness. Sashiko AI points out that the vsnprintf() in
panic_try_force_cpu() uses the "args" and they might later be used
again when the redirection fails, see
https://sashiko.dev/#/patchset/20260818163806.17460-1-include%40grrlz.net

This problem is fixed in by the 3rd patch in this patchset, see
https://lore.kernel.org/all/20260818163806.17460-4-include@grrlz.net/

So, we are on the safe side.

Best Regards,
Petr
