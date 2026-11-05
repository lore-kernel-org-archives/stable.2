Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889277;
	b=HDSN5c8Z693aCjOsYS2K79inwhZb6/1VtFZ5XcUc8J/ujhc6nAVnk9mfkR4guGDPDv/S
	 WtHv6bwIbrz1IoqDZ6J6SJdwSUihb7wb2ckbO1u+Fmwgab/oUzjvawh5ypepNwzUJRVCN
	 hJAyAX1yf5wwefbD1nkZZA8tS+ll80NjZdEPFdIN+RcCBS2LZ4qaDhZVLrKZOtPvCymEo
	 85f4RjYAJQ3dkCplw2grYC89dHcCPSZRFqoJ8lc9ZkDU/pO+yckUChG6pB/ihY2oeKyPV
	 g6v1DKXbgrbWUyScI1Y5MognTVWwVBLDZe7GtCCzFQcwTu6kSfenwdCEb+knFV7X5uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889277;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=c/yt9uFPnjvQM+fiEYYJRoCxuqKFimMZvvZyEcVri54=;
	b=fUdg7eNJQlPoL37C/4MI5Y5zr2FQ2FILc291hY6mCa+zpKglzads1gEYHRl4byBY1QN1
	 Kspsvu8xnqHGV+tip+EZe6AELNF/vyCxag4P8mVlmOGpLweRYcIsT5RRDFKRcw2WnG1bU
	 Y+vq5WgvDY0KCALIxegqSB9anWy3Rmd7WqM48H7DBGFoBUH2RIigWYXWcctbOQwd7lsLX
	 tKBdC6I4LViaadyRWPFLAOGysp5TtNbUkAToQVinkHIZYG5w319zYYuTWxLBpoVgI5c03
	 ShmQSwDbSrolwiMg0bnINT83JR8FcMiUST9exedcAqqBLqMh2F4EC6HZWaz116wIxtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=y8kPvgpB;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ubYMg+wD;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7BB606A338;
	Thu,  5 Nov 2026 14:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C7BB606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=y8kPvgpB;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ubYMg+wD
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793889273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c/yt9uFPnjvQM+fiEYYJRoCxuqKFimMZvvZyEcVri54=;
	b=y8kPvgpBm6pcjhdgIt6MKI76n7YcCOMGFSUhP56keDoTBkv1upezh7+RoupfxlbIzWo9MY
	Unw2CSO8NPpzqepNUn0jsjs9WcYUBaapCiLMxl2kobyF4M4282CnrnaGAHQF1r7h101McP
	yDAQ6N/qmHvCX7eBTW2RiMzX42wyfp9q+53te74H1Xgl4QYfI2cRt2G6rzCAGbIBmrG3/z
	dHujzGKFRQP4pZqPhy6gcCRcXQAtU0IOtxVxrtN2Wm9wxgxBDxSsPwOvtYc/9ZCLmPRaML
	bOMJc2Y5DPMNiFz/2GHR8CQ8XGoPRluEQEVAZdVOUEH3ZcedwchkzPfxkFLTkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793889273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c/yt9uFPnjvQM+fiEYYJRoCxuqKFimMZvvZyEcVri54=;
	b=ubYMg+wDtIygfUyemhGW8eaVqxZ9fn6Uuvfta99Fo2lhXCI58yM9flSvWKtHzOodlNSpBE
	fSGJHxVrI1fE/5BQ==
To: Breno Leitao <leitao@debian.org>, Petr Mladek <pmladek@suse.com>, Kiryl
 Shutsemau <kas@kernel.org>
Cc: linux-kernel@vger.kernel.org, printk@lists.linux.dev,
 gustavold@gmail.com, samuelcrossley@gmail.com, ryan.roberts@arm.com,
 brads@mainlining.org, x86@kernel.org, Breno Leitao <leitao@debian.org>,
 kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] printk: nbcon: Flush unsafe consoles from printk()
 in panic
In-Reply-To: <20261102-panic_unsafe_flush-v1-1-12d1e22fd6d8@debian.org>
References: <20261102-panic_unsafe_flush-v1-0-12d1e22fd6d8@debian.org>
 <20261102-panic_unsafe_flush-v1-1-12d1e22fd6d8@debian.org>
Date: Thu, 05 Nov 2026 15:40:33 +0106
Message-ID: <87v76bz6rq.fsf@jogness.linutronix.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On 2026-11-02, Breno Leitao <leitao@debian.org> wrote:
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1688,7 +1692,15 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq)
>   */
>  void nbcon_atomic_flush_pending(void)
>  {
> -	__nbcon_atomic_flush_pending(prb_next_reserve_seq(prb));
> +	u64 stop_seq = prb_next_reserve_seq(prb);
> +
> +	__nbcon_atomic_flush_pending(stop_seq, false);
> +
> +	if (panic_on_this_cpu() && oops_in_progress) {
> +		panic_nbcon_allow_unsafe_takeover = true;
> +		__nbcon_atomic_flush_pending(stop_seq, true);
> +		panic_nbcon_allow_unsafe_takeover = false;
> +	}
>  }
>  
>  /**

This part of the patch gave me some ideas. First, I like the idea of
putting the policy handling code inside
nbcon_atomic_flush_pending(). This keeps the code outside of
kernel/printk fairly simple:

1. In emergency sections, printk() is calling
nbcon_atomic_flush_pending(), which always skips
CON_NBCON_ATOMIC_UNSAFE.

2. During panic, printk() is calling nbcon_atomic_flush_pending(), which
via policy could include CON_NBCON_ATOMIC_UNSAFE (in a 2nd internal
loop, after all safe atomic consoles are attempted).

3. After kthreads are shutdown, printk() is calling
nbcon_atomic_flush_pending(), which via policy could include
CON_NBCON_ATOMIC_UNSAFE (in a 2nd internal loop, after all safe atomic
consoles are attempted).

For the above situations, no new flushing calls are needed. But there is
another scenario for CON_NBCON_ATOMIC_UNSAFE (and unsafe printing in
general):

4. If the kernel ends in a way other than the final panic() loop, (for
example kexec, sysrq-r, panic+reboot), the above scenarios do not allow
unsafe printing. For the related code points we could call
nbcon_atomic_flush_unsafe() and it could handle the policy of unsafe
flushing depending on the context, which would allow
CON_NBCON_ATOMIC_UNSAFE to flush here as well.

The unsafe policy flags could be something like:

PANIC_PRINTK
- panic: all printk() calls during panic
- checked in nbcon_atomic_flush_pending() of #2
- if ((policy & PANIC_PRINTK) && panic_in_progress())

NORMAL_FLUSH
- non-panic: atomic flush calls: shutdown, reboot, kexec
- checked in nbcon_atomic_flush_pending() of #3
- checked in nbcon_atomic_flush_unsafe() of #4
- if ((policy & NORMAL_FLUSH) && !panic_in_progress())

PANIC_FLUSH
- panic: unsafe atomic flush calls: reboot, kexec
- checked in nbcon_atomic_flush_unsafe() of #4
- if ((policy & PANIC_FLUSH) && panic_in_progress())

Netconsole originally wanted by default:

    .policy = NORMAL_FLUSH | PANIC_FLUSH,

But this last series shows that netconsole actually wants:

    .policy = NORMAL_FLUSH | PANIC_FLUSH | PANIC_PRINTK,

These are slightly different policies. But as long as printk supports
all 3 policy flags, we do not care which policies are chosen.

I am happy to code up a full implementation if you think this has merit
or you want to see the patch to decide.

John
