Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA1631E824
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301784; cv=none; b=RxbzM4mSgyrwWNWPXrqxro7o+iiIH/zxVhdNM5zkBpsfQC1v7vYtfMbklvx8LWr4mUFxyRfg7kp/O+5gxTgTGtnF8pcrZ0d+ssz7UymJ6CZdBDs9aQkGuXCzI44TyMtj85ccQ9LUJvbcypmIjuW647wFZSv2nvjnM3GvaQfS2xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301784; c=relaxed/simple;
	bh=ldjiXEKTQB7Gnt4Gp/QNlr4hMf+izOX8e/wBRi+CE1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQqRPlljtz6SIR/KJHvlc1QxefI3NT79h/cJ7Fii+r1MvsgY5vh1h1tfnX9gSnQ8hx23Ffz63GI1g0mPC4VF6/4ttllB/FiI6dR0Xb1Tt+E7eZEqfSnM1HeJ6ENhC/vpjXKeBubKutucZjO8mp3n+jltZdOFxVoHU3gQp2fwj64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V8JHsU7G; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V8JHsU7G"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so4082139f8f.1
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 08:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784301781; x=1784906581; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xXzFJhhAu0paPqZvnx7kZReavfriCzThkXWJX/+JEuw=;
        b=V8JHsU7GenMwtIeikSU8WBBNxJz45Y7gQHGvUDLyyp+cQ1sO+7vBQPUYnTyB5f1/yg
         SNKILmkQyRVhcsymMxC9fBAqxWflK2fvfPkzjaoV9iDspLkbVHl0lp6h9sOQ4aPRYcGe
         juF8IHNRJyLI/5cOpYP7dA+c4irD75gcWY+fpG5AgzI2pzwgJ6lsQrFJ2uYB8kr7u3aU
         0OY+Em0pbFDIkjj5gcMBJibkRoazD9cZRHTIf/Ac0vEBDxOaFJVJywYsAkrVVDIZ50v1
         GuankfZFg7yRti3rnf2gR0BPBlKH963UO6V6d64MqNTFF2EUlp3UCkvl42+BYT30DCwy
         qqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784301781; x=1784906581;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xXzFJhhAu0paPqZvnx7kZReavfriCzThkXWJX/+JEuw=;
        b=hdh8ZN36U7w8yjMGAvBMQ8wlPBy1yrl+h5SJnnnD2fAlMxrO3ISeozzcZkZBNkWGrc
         4/CwqSkQTPqfy1Elpy1Klfafma38paboQ5yzxJggZJDJrPCqi+or0YAkXxznUIjYhNUr
         FyCstGJC9NHyoLwGTgEyERPWdyGMyNFt4HQW4d3XpZIgCFsATKgLviXVga8fDpJyQG+5
         plODj7ECZaTIaoM/+EL1qv/owN55Sm6DkjTiwTj6zECYB8gdEazBIzIpzoPqXl7x2zEH
         uWrfZcyCX8Ln3J98EaLn1UbRIL84h9SP7HtuXdbwMT9igWSqz36MvS45YDR8SP5FL/++
         3Oiw==
X-Forwarded-Encrypted: i=1; AHgh+Ro1ZfLN0TblUA4k1cz7LZhOj4tLLNCYzhRNFIHkbBItW/HEz9KQ+KRPGmZEHOYo/sv2VtULDLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1V77quJNXzEXIv3UdDFAPr/+/w+OyZHHIyhLLD2MbpqoaNd43
	DH7wR2zw+9VFbEWEWA68RU6jOCh8oZ8nu91BYgg1pIIpb0us/yQd29DA2N7z6ng5v60=
X-Gm-Gg: AfdE7ckZTRcCw7rg3inYwKcYeq7EQHn980YjFzTa1nUSCH2+vDNEUYzc/iQp2tUgBdn
	yfBSjjDNflso0RpjgcmDr5OUqzauPp1U4MsHV5XIm0tr1UA2UUXiGoJ5l73D8/QuVbW4kLTLPBM
	OV+kSwrQDQ8Qopw3Yxi/o6D+9bL4xOCkA1+tl9kTwaetssjXEcEue5R4IzXE55Y7PLpn6sIMyXw
	T17PXmmR5rMcsbo8sMpFS5nrlxa1hkW5aT0tQFjtP1jbYqLWH/O4ss6YXaZ84tNhyClQkjNusvs
	sSmXZytiMZxfNhv72QKz8sLXk5n59Fr30jNjJ4BDVWFmwsFUbZj2Sd/f1Iq8NBhwtyeTUOblc8L
	QExqd+VnTJP4dSrn0BTo7YXALgCET6XMTro2ARbGDfQ2DBmvDNP/TsFlwQxIFzHoEDNhZdlVjtg
	Y+p4Jgr/zc7HhLmxU=
X-Received: by 2002:a05:6000:40cd:b0:47f:5378:b6e1 with SMTP id ffacd0b85a97d-47f62318bacmr4030157f8f.30.1784301781221;
        Fri, 17 Jul 2026 08:23:01 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e52aa4sm4897943f8f.10.2026.07.17.08.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 08:23:01 -0700 (PDT)
Date: Fri, 17 Jul 2026 17:22:59 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bradley Morgan <include@grrlz.net>
Cc: akpm@linux-foundation.org, feng.tang@linux.alibaba.com,
	sashiko-bot@kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] panic: fix redirect CPU race in
 panic_try_force_cpu()
Message-ID: <alpI019MV7idCZ1O@pathway.suse.cz>
References: <20260714173103.11585-1-include@grrlz.net>
 <20260714173103.11585-2-include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714173103.11585-2-include@grrlz.net>

On Tue 2026-07-14 17:31:00, Bradley Morgan wrote:
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
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260705164123.18746-1-include@grrlz.net
> Closes: https://sashiko.dev/#/patchset/20260707172252.4842-1-include@grrlz.net
> Cc: stable@vger.kernel.org
> Signed-off-by: Bradley Morgan <include@grrlz.net>

> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -396,16 +396,20 @@ static bool panic_try_force_cpu(const char *fmt, va_list args)
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
> +		return !panic_on_this_cpu();

Nit: I would use

		return panic_on_other_cpu();

It is more straightforward. The negative logic just added an extra
step for understanding the code.

Otherwise, it looks good to me.

With the proposed change:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
