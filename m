Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C87C3E832C
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782469434; cv=none; b=BwvMGaFsuzgB5bKRCguFKFAb53cePjwD1PIGZZddy3KTYclqEVT7WCBwELTAe6FYiIbFZFH9usRphwiBTjnDov3BUiB5mTyvIJJhz3zk9ULeawc3CCQVJhkRavKH9zBLot5roJFBjj1SbMMiqcMnLe+4CkM/uR2gMB0C8+uzhz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782469434; c=relaxed/simple;
	bh=ffNECExMWsXfqi2yo0S2r8IrBwZRf40yiT2nYi2+6Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSgNvG4q86W48gJ4cpsR8EuObN99kuilQdn7FjA8NP15YQpxzbBHF+5KBeRmrADyT0tdRvPdtXG9bymbv1vFSRe/2uqKbldROEZy4SGaKLZsIOQxZauBAY9p1VCpA4K2yYZekOvM8qtlw9QjTZ1G9R6r4EjM1YHSfWh0GigsNWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cN6A/R4H; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cN6A/R4H"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-46f27bd4c45so408879f8f.2
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 03:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782469430; x=1783074230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eLFZTGPtRiE8UPhqU4UMjkuV0PbJHe/HCNgoSE+benw=;
        b=cN6A/R4HtvgBXKGB5A+UHEStNNf7UvH2iFaPP0zH836AXQeyuNgNDcK5vvsCutS4E6
         vnPQWTm8RvxNsDzHGOsUQ/3C+94OaUUWOYyL17Y/21HGIKORPcfvKeJhmLUK3xa/blLi
         an3VDrhgnBJm1Q8axUDuEBPceTPf/FUJI3ndg8JEmBQXTaYlS5FJGCAwhBkZrzUY4Zp6
         1y6KWNw/KedmlKBxoz1KDP/DZ+7HIhGga7pr52Y7b5jQ2I0pj6+95awT8AIp7w9EQDEx
         T7AGUAzFJefET/quPWKA0S48rdv9+3s0WwUj2MDY7wpRdYB5rHYMXWVorXUrlGx9m4ja
         R/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782469430; x=1783074230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLFZTGPtRiE8UPhqU4UMjkuV0PbJHe/HCNgoSE+benw=;
        b=I1/c33PUL1DOW5tKPwMoBfrpBZxvh0SJ38Y4QqlnkRjCgwFAhPMYxgCUKwElTbdBYF
         1RJ7g2t9hhyo7Hqec7rf57gPh6fK6+3J3n2RfDRGYHiPBWMYwuA+tZRwVWYV7xgry4kV
         utzbrJ+44zo2pRaCmLwCZBdij+gFQ1NqzGuIMJXqjr/Ii1PHvJIrHT02Um8MoUv5FCqk
         lqgk4eYdNcy1c+NHvVzIdjpQ08BfQqynlIeILZV05JN/B89+XvuW6qRk6KOLNI7dkLd7
         w3olOpGk7qAwcHlu+2bZtXdoUVts7su8R8BV7vADeNyDLWiHoaibR4j83lZdHTK/O8Uz
         Dzxg==
X-Forwarded-Encrypted: i=1; AHgh+RpX6cUPnzdhAGNEftxIyCGmshsPAshHnHRXkPtYAjPNusvWPdyg5qUoMDYdDuTtVIcfNLAgq34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5s89w9yiw8E8cOOEfyrN/IjR3BXVjFPl0ROb61tsYbFLybC/8
	WRMzWQZWPZKwaSIq+t2Ihhf6dBGfvS6iu1ZY2Q1tzkWKSoYccssq5Y85eYKhXTv5FMo=
X-Gm-Gg: AfdE7cmcel/je5EEtrY4+mB+xcnfJxfKVC4rhKaU1TIsR/NWQlEfiLHwkkvrCIy7Yah
	YuWzG/SqY2lDlwihhOamR5zVMRgHW1E4uGXp3RBQpsnuAVr+0N30Z9dDG2o7C5pbuLN/bFZDGK+
	yzWpO29STZKaV2aVEc4dV8Fvruv2tFq6/kaiBylOUFqnOvBA1uuatDbGvuBs/AURkfiQJWf7vzv
	BnlBFWPPWcaLkPpY9WXk5R27cBivkvCJmc0e6LEY7k4yStCGypoUDHGohdZfXq3COFRf8EUUoMq
	kXy/cPnPUiHIqFNHF0smuXhxQaSBbuRQt2x7vzGQAynRQW7GzEb3BxYKKm7QTJkYK8R7zxXHsNs
	22iD0o7QnWvQTcFlGK3c2r1bh76yhofoMOz8k3awq9M0UJmD7LfxVXMEY0zuc8HJhCXn6N4X7Po
	mFCdBU7sePG1YAdgE=
X-Received: by 2002:a05:6000:4204:b0:460:30bd:4dca with SMTP id ffacd0b85a97d-46dc12e056fmr9792387f8f.30.1782469430521;
        Fri, 26 Jun 2026 03:23:50 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46dcbac0c9dsm13650525f8f.19.2026.06.26.03.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 03:23:50 -0700 (PDT)
Date: Fri, 26 Jun 2026 12:23:48 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 4/4] panic: use sys_info_with_filter() to avoid
 duplicate backtraces
Message-ID: <aj5TNB8cRtMNTtIT@pathway.suse.cz>
References: <20260625152558.7450-1-include@grrlz.net>
 <20260625152558.7450-5-include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625152558.7450-5-include@grrlz.net>

On Thu 2026-06-25 15:25:58, Bradley Morgan wrote:
> panic_other_cpus_shutdown() handles SYS_INFO_ALL_BT before stopping the
> other CPUs. Do not ask sys_info() to handle that bit again later in the
> panic path.
> 
> Use sys_info_with_filter() so panic_print=all_bt does not request more
> output after the CPUs are stopped.
> 
> Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys info on system lockup")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bradley Morgan <include@grrlz.net>
> ---
>  kernel/panic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 213725b612aa..eb842823df61 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -680,7 +680,7 @@ void vpanic(const char *fmt, va_list args)
>  	 */
>  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
>  
> -	sys_info(panic_print);
> +	sys_info_with_filter(panic_print, SYS_INFO_ALL_BT);

Hmm, this prevents printing backtraces from all CPUs completely.
But what if they were not printed?

They might be printed by:

static void panic_other_cpus_shutdown(bool crash_kexec)
{
	if (panic_print & SYS_INFO_ALL_BT)
		panic_trigger_all_cpu_backtrace();

[...]
}

But it checks only "panic_print" variable. It won't do anything
when (panic_print == 0).

In this case, we might still want to print the backraces when
SYS_INFO_ALL_BT is set in kernel_si_info.

>  	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);

Of course, we might fix panic_other_cpus_shutdown() to check also
kernel_si_info.

But it all becomes very hairy. We have several levels:

   + watchdog-all_bt-specific option, e.g. sysctl_hardlockup_all_cpu_backtrace

   + watchdog-specific si_info preferences, e.g. hardlockup_si_mask

   + panic-specific si_info: panic_print

   + universal fallback for any layer: kernel_si_info

Now, we try to check all these variables back and forth to
trigger all backtraces or to avoid triggering them.
And it clearly does not work well and the code is more and more
hairy.

I think about another approach. The word "waterfall" comes to my mind.
Instead of checking all the settings back and forth, let's process
each setting one by one and just remember what has been done and
skip this in the next level.

All the si_info actions seems to dump a global system state.
So, it would make sense to remember the state in a global variable
even when it might be modified by more CPUs in parallel.

I am going to think more about it.

Please, do not send v4 until the discussion settles!

Best Regards,
Petr
