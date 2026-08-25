Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6D833D6F0
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787651361; cv=none; b=OcgeMef104nlHQBzauANHI93MbaU9O8KRfvakfey/Wrdn0RisKz914NIHLVW9Xyl4ts7wutcMUgPZCAKigjL3oqiysPKGd6bRXrpjrhpzHwMYYcmSE8sbfLS5a0Jg6gXbUejbzNcvWH6HOn+x+q3p1HX5SZtML/qQ6rzi/QRrc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787651361; c=relaxed/simple;
	bh=SDOK5a982ZwEQnK+mq6ZJyeUw0V3az0fCs0VeBXrxUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngVLSZRCVw9vDw/y6jeCnnsw8MXLQ/LDIcTgEvb8KagaQBdGprhyW9CfKNpb1y0RVBr0mTjl/KeFvBoD9KkEYDJfL523C4NASFyeIrk5jRgr5oV/LkCJBHpFzxcvJpPuhyEexSIkCwDfap48lKo+9+8DRVphtjcSflqB/C9RRpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EHsQo9IG; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EHsQo9IG"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-69fab5a852cso7639292a12.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 02:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787651358; x=1788256158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jhNcaEAWGOV1mao/QyWB63lyecaeVBUJemIbl04upLg=;
        b=EHsQo9IGWT9obEWNEWTHRhCCnGixdbrhh0GFiMZKJOfK3h4rIoLxrNpzssR5zoBq/R
         mEbe4leE3KYiFo3hBMQvcZ5J1irI6RY4615zJJlauK+d4AKOI7muyN9A48IEhBuwahYB
         oC6yBkCTc72H5BqaicUZ+wEsYuje1dW/pFWk528BB8HMw/Nb8y9bmrAEKsPOdDfyZQaE
         h4642/3Y82t3mU4YU/LGN14PaKMnXNK5teX75bLRbBJ9hOmfnTODCEiAAMjQrBe+6KtE
         TsYsT13tG8Z46I3nTkRZjuyS4dJ19TRu4qeU852Te2hoMMnWmKNfMeBHoo2absKLBYb1
         LZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787651358; x=1788256158;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jhNcaEAWGOV1mao/QyWB63lyecaeVBUJemIbl04upLg=;
        b=e2vataCE7iMYvZMtUkfES9n2SXwUy6jyBUlFRY+LlKnIQz0LQ8zkVblvOwbwA4GJMm
         4GfmA539ibwq12AgaQ9BBodCX588ODfHJTWjMZNLIzxt4ADEF81MmvIPFoNIDY+Kq988
         rLAOrFu40qgiDSFmOvm6RuP5k/DF9LEGRQ2MFqT+/0Jbvm4DBW43bQvxgq8H6CXEkiTz
         w3jogczXPzaCtURxP4+Veg3uvay8GtEappUnP+P05b1d2WMiBZ+TMSDMseRp5DtOJ+qw
         XU3uiLY3SqaDtZIEMHeBX53PI/8sFFpU/eE44wT4rxObUkh6eVfF6P/Gv9Oww+wdcs+R
         htQA==
X-Forwarded-Encrypted: i=1; AHgh+Rqn3G99O4/rq2cC4aizsSCpjQUpmJHu0D0PlCLFAD3fLhjuzE8ikoj+NkXOZtcCW0VZZXJl8Gc=@vger.kernel.org
X-Gm-Message-State: AFuF++lXkZ99NaZlGM9tsyMPvEDRUosTWuMXCiJ533jL6ZMGz2f5Mx2x
	zQafFj3AfYn2E8LxzvXYTyapwh8zRzV+xb9XE3r3gwQ9Y0wJWVLHC8fmTEf9q/J7KSo=
X-Gm-Gg: AR+sD12mv+/MMlQGthAtpBccGeTOynAlqzpD1TXR/QB5z5GSV+FqDeDWW2Le4GrYkKZ
	LgnhqfpPgYuNk/IeU+pPathXZpCXY6XsFudSpeaISLYOp4iJdfYyN0/lOEufX67cEBx9oLeqebk
	1e4FYqybzDd2ha4lRptfOmrvI8nwW9Sk3shcTE1B540146cogZdnprsS+FrrQ/maGQqTvWcNwD6
	VoIperN8SBV2pO8Oh2+lemVJbV1EfVuh1wEWbmdWuV1OSD4jugJmOnfZIG0EkWOKLNpxNdjO301
	wP5z8GJcK9UsbKK8QvQFnNbpwIoucJ/p4urJHvunazZjgH756FLjsOC/wGRkmpn6fpgi1CsMpj8
	1p7yarTOgOGwUbEW81uta5RI+of+HtEkrkIp8CSQCWp12hSR4RTm6kE0/MvCL6R5I51hG4MZnWR
	+ICmd9LLWBmTyRBn9paeMpJwgdSmyuTE2/6NUncVLcBjSi/9gfmSZi3W9PR0SyLdd6JXoPJWSny
	A==
X-Received: by 2002:a17:907:9304:b0:c17:cf99:6154 with SMTP id a640c23a62f3a-c24e5b28879mr566987266b.16.1787651357608;
        Tue, 25 Aug 2026 02:49:17 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606a8fasm1864582966b.8.2026.08.25.02.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 02:49:17 -0700 (PDT)
Date: Tue, 25 Aug 2026 11:49:15 +0200
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
Subject: Re: [PATCH v6 6/6] panic: kill the "buffer unavailable" redirect
 fallback
Message-ID: <ao1lG5wumJJ6FO2T@pathway.suse.cz>
References: <20260818163806.17460-1-include@grrlz.net>
 <20260818163806.17460-7-include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818163806.17460-7-include@grrlz.net>

On Tue 2026-08-18 16:38:06, Bradley Morgan wrote:
> The redirect buffer is a disgusting terrible hack. panic_force_buf is
> kmalloc'ed in a late_initcall, the return value is not even checked,

It is not checked intentionally. kmalloc() prints a debug message
on its own when it is not able to allocate the memory.
And it returns NULL in this case. It is enough in this case.

Please, remove this sentence from the commit message.

> and until then the redirect delivers this as the panic message:

>   Redirected panic (buffer unavailable)
> 
> The whole point of the redirect is to hand the panic message to the
> target CPU, so the crash kernel boots knowing it panicked and not why.
> And that window is the entire boot, from the early_param to the
> late_initcall, which is exactly when you most want the message. A
> failed kmalloc just keeps it broken forever, silently.
> 
> Make it a static 1KB buffer and kill the initcall. The cost is 1KB of
> .bss in SMP crash dump builds, and it is only ever touched when
> panic_force_cpu= is set anyway.
> 
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -413,20 +403,12 @@ static bool panic_try_force_cpu(const char *fmt, va_list args)
>  		return old_cpu != this_cpu;
>  
>  	/*
> -	 * Use dynamically allocated buffer if available, otherwise
> -	 * fall back to static message for early boot panics or allocation failure.
> +	 * Do not consume args, the caller reuses them if we fail.
>  	 */
> -	if (panic_force_buf) {
> -		va_list ap;
> -
> -		/* Do not consume args, the caller reuses it if we fail */
> -		va_copy(ap, args);
> -		vsnprintf(panic_force_buf, PANIC_MSG_BUFSZ, fmt, ap);
> -		va_end(ap);
> -		msg = panic_force_buf;
> -	} else {
> -		msg = "Redirected panic (buffer unavailable)";
> -	}
> +	va_copy(ap, args);
> +	vsnprintf(panic_force_buf, PANIC_MSG_BUFSZ, fmt, ap);
> +	va_end(ap);
> +	msg = panic_force_buf;

Nit: The "msg" variable is no longer needed. It will always be set to
     panic_force_buf. The later code could use:

	panic_smp_redirect_cpu(panic_force_cpu, (void *)panic_force_buf)

Otherwise, the change looks good from my POV.

Best Regards,
Petr
