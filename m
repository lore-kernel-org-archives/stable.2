Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102446;
	b=s8p0yYHjj3eqlYQSJfaU0MJkJsqQFyQXet0hm+YK7CdkHSR41ri0PhYUNo5cvIdb/pAg
	 8+2CRusCXmZfl067Z88gPv4naQZga4xAZOvhuLFu1K1ny+j+IYKkdfiBK/aZ/GypOPK5c
	 COteEyaPp5KPyEGl/r5XnlgUv9+T47+rINjfUcVTLIe86jQHaxcCf67ft2g7JHnF0xKI9
	 CfQF7jQBy/VdWuaidRIH2gKs+fPRWHVDd6wW5OTi+jQ47mkw+7WHOIG8lv6Z676QjE5Q9
	 HodHhkpnci6Kh4bCnZinj+FbjbwLkst4U+DZwzplyurZol3XnNpUEAg74Z02FmUsTEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102446;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=44RpWvBCxaRdhkKmU4U4u5g9cCT+0OySigjHjteKBFA=;
	b=krVosu4zeC5YV/Jic5UEJoZcA2sR+atnCt3XJ9lfOszFz8d+RlKGKkgSt9wLEoOtCTGp
	 dR6d7C4hTv2bSQ3peI5L6h+S5bJaU1Acc969ZybqMRTQgcnO7f+fqT6g2tJOft8ASzNTI
	 CGgoTR/0z8Fwzm3N1QkwwsvbXMlX4JeFYVjqH9SCcEcF7eZB9oiHLM7ad4haA9XMStAUa
	 CM77D+ThBAEDA3eLUSIEbE597AbVm1vDKzROf3y+kyD0XEJvklNvnW8zex2RoeV0IHIGg
	 eWuedjRIIaeCRi11EQqSOs2/pole4AuEFpTmJt9fJUb2x4p0mIFUDXJu4IXXVIev2Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=SSDD+GYh;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2F5606A320;
	Tue, 27 Oct 2026 12:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C2F5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=SSDD+GYh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=44RpWvBCxaRdhkKmU4U4u5g9cCT+0OySigjHjteKBFA=; b=SSDD+GYhrUUY2cNOeiIkcZdZUt
	37a2mC7cKsayTVIpvEVZyt/bH4y7bBe5YlX/ll5v65tsWldXaBPas5/q2MWIeUPPdqQfgx+l3l6lT
	rKZiG/7aIhGUmLS1naxekYQfMojrzkaagxtP4aL6z9ORvndND6/lAUhKCwkbMMSslmWgOM5EnwqVW
	4B+ROKfJHYqc72/Vq2j9eGDLMiKVFomgIpVvE1gBnhDRiBHGDCY8nYeHHU/eDDx4Ja1sjeKcYPJSp
	tJ6GlCjIWR3ysiHXiSIUMRh7dWatQNsThXbAS0IKvBSUpnAiNT2Vj5sZQyGVcLuypI/E+n7EbzHkd
	40x2N5ZQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLfr0-0000000EtkH-1FWQ;
	Tue, 27 Oct 2026 12:00:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4DEB8300DB9; Tue, 27 Oct 2026 13:00:33 +0100 (CET)
Date: Tue, 27 Oct 2026 13:00:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Breno Leitao <leitao@debian.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, kernel-team@meta.com, stable@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] x86/nmi: Ignore negative NMI handler durations
Message-ID: <20261027120033.GM2668564@noisy.programming.kicks-ass.net>
References: <20261027-nmi_negative-v1-1-b436a005eb8a@debian.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-nmi_negative-v1-1-b436a005eb8a@debian.org>

On Tue, Oct 27, 2026 at 03:43:51AM -0700, Breno Leitao wrote:
> I am seeing NMI handlers in the Meta fleet reported as running for
> about 584 years. Over 30 days, 11 AMD and Intel machines logged 637
> such lines, for example:
> 
>   AMD EPYC 9D25 (family 0x1a, model 0x11, stepping 0x0):
>   [ 1650.616627] INFO: NMI handler (nmi_cpu_backtrace_handler.llvm.9643156322683129580) took too long to run: 18446744073709.551 msecs
> 
>   Intel Xeon Platinum 8321HC (family 0x6, model 0x55, stepping 0xb):
>   [360448.230129] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 18446744071018.936 msecs
> 
>   Intel Xeon D-2191A (family 0x6, model 0x55, stepping 0x4):
>   [81787.188959] INFO: NMI handler (ghes_notify_nmi) took too long to run: 18446744073709.545 msecs

All these are 'recent' machine and should have a stable TSC :-( I hate
computers.

> nmi_handle() times each handler with two sched_clock() reads. When the
> second read is lower than the first, the u64 subtraction wraps, and
> nmi_check_duration() treats the result as a duration. In the three
> examples, the clock went back by less than 1 us, by 2.7 s and by about
> 6 us.
> 
> The wrapped value is also stored in action->max_duration. Every later
> real duration is smaller, so the handler is never reported again until
> the next boot.
> 
> Whatever makes the clock read lower, a negative difference is not a
> duration, so return before it is stored or reported. A clock that steps
> forward is not covered, since that cannot be told from a real stall.
> 
> A backwards clock is still worth knowing about, so print the size of
> the step once per boot. This uses pr_warn_once() rather than WARN, as a
> stack trace says nothing about the clock and panic_on_warn machines
> should not go down for it.
> 
> Fixes: 2ab00456ea8a ("x86: Warn when NMI handlers take large amounts of time")
> Cc: stable@vger.kernel.org
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/x86/kernel/nmi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
> index aae7254774680..57a0dab1ec7a9 100644
> --- a/arch/x86/kernel/nmi.c
> +++ b/arch/x86/kernel/nmi.c
> @@ -130,6 +130,14 @@ static void nmi_check_duration(struct nmiaction *action, u64 duration, struct pt
>  {
>  	int remainder_ns, decimal_msecs;
>  
> +	/* sched_clock() went backwards? */
> +	if ((s64)duration < 0) {
> +		pr_warn_once("NMI handler (%ps): sched_clock() went backwards by %lld ns on CPU%d\n",
> +			     action->handler, -(s64)duration,
> +			     smp_processor_id());
> +		return;
> +	}

Fair enough I suppose. Thanks
