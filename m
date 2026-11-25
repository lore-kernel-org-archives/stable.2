Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795583977;
	b=qxScD09gqMRdCsCICxdYGNXHvI/HKpsCPwntFXCvVMcKbQ+xvB9bOVauqdsKi2re+UVG
	 4N6X9Kc52RU+PBTIebUo4ohMAYl9cTPlCiaqMjERo7n30I2YLClZBfxZfNEBwJHcIwV2O
	 tf0UOb6vE391t6M4Wsfa8IMNUivFKlIWizkcaPYr71HOVwZFbf8ssMWLlhjJY5n2ePpGD
	 gbWszJsW/c3AmksBEfV5k1G8N9F1MtlSEz+bz4jupuhTmOz6XuxBQnAlCptecfP9hRLsN
	 AJdS2V1mu80oCyH4D5kR3SuqQBm8JXhW9kvB+Vf68B7c/Mp/pJW0F7Mj8OwfkF0+m0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795583977;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=++Apgl37kjRYqQpIi3d+LCDkwVVawhVRcSfP5lZmBu4=;
	b=JGE7hlrC4KPbd38IZt5ejra2N47qjIn14sElwdoUZShD9effUpTDanUO2C5/o415rf6I
	 x2RH9iAvQDuRkDKqnwhGyo1ayNu0TqPEqRwbuZ8OqoaYAXQxF0kekt7Rm/kWh8xyRpsV9
	 0lkFmWX5/hZHn/AKLyCP2HU3LQYOdhdYpsB7Lqv+nyOTHxoaseo2wfohhWdRBHd48D0/c
	 Vtc/a/cqVVdrqi/JeWbVInfuvlWfljO7s/rDDU+ota8RrRfD4oRv5GMRK6hQeb79nGMq1
	 XEeWkMy3T/3fR1yrnw3tYH++nRXoVvWWPTymHRzqix9ss+5PZUMzIHCdMpOvr0lZLsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B4zvXCto;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26F9606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 05:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D26F9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B4zvXCto
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b439e37813so2588083a91.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 21:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795583976; x=1796188776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=++Apgl37kjRYqQpIi3d+LCDkwVVawhVRcSfP5lZmBu4=;
        b=B4zvXCtoBOViByCN556STozY1uYwuOqmuuAFuNCP83vFOWrHSwAI/cTs/2smjchkAi
         eodtznUsfheJOLv0U7VrmM+v7TNK0kxYdSl7GDVft7X7Pau3ncZsYHCaIKE9JO1QLqAX
         Iqaun/nO8h1Kl1Az/j57TOas3TbTMkHTYYvcJNQQkmyBcuDfPeoEQerK3Kl7152gJBbv
         jUriCaxlDTZhM2MYgVrvXj+Un2PbGaRh8FcLCwjXNI5dYByM3DvZl2Hr/CB4jvNPtIGO
         DcCO5RlS3yT+Tx6VkvtnKRIkn9wGb+ucfA4NnDBNxWG4J911Fh4f7T9WnGmW5jfrYCza
         3Y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795583976; x=1796188776;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=++Apgl37kjRYqQpIi3d+LCDkwVVawhVRcSfP5lZmBu4=;
        b=MXtRiZ4DcKIDfFLmaNG+D189fDlvA+M5+zKMguB4dVKpU6NwyPXY/SzZbnG37OCDos
         oXgtLd4GH2Rm+Avn1jBWbGpLAwhYBUpH/ep0olb+Yy28iUNuBrgE4+BZQ6nQ0sxLP+9G
         lluQ+sv57JikNL/GcaB86jJENj7gxFNCZPQeCTEKGhUfYNwWTHSjSW9OIqoLdDkIYa7w
         KTLBeitbJbIsno22Uy/KuTiREQ0gVuHwEs5DH+4LVbJRhPNCxuT7Un0JqzFY/ubv9gwP
         Bx3P7D/onpt0xRC0HupxFBuQip4N+fIAuh4vinh5zuejOpLvAObssjy2aACcOVlztdIS
         0AoQ==
X-Forwarded-Encrypted: i=1; AL+hErG3/yBN7K8iyeaZqc8IixVyFf0miu0d53dzhpgHsl9ISzoANfX+gc2gbYhmsE5ww+sXmnAEA4k=@vger.kernel.org
X-Gm-Message-State: APuU4Z/mb16RjdupMSWEeAHit8IDL3HG0uybRIDnryrBa8ke/Ocz9ZEF
	PeqvnFl5X8Ocnqlj92spIFNX4XZGTSnydXfuRS7f3Nx/MGYFfS4+Bzu9PKrfaA==
X-Gm-Gg: AZFdTZdGCZPXqgS6kDria24AwZhCRMX+YYmALV3kaACslplI6Bpunb4g64yyLK3YrR5
	g+mxTYPmRF6kQkbkT2q/q9kl7B5OWhOzY4J+nNed89omPjBffrn3je+dZc6scX/a3pbnku7c9hk
	3UVa3pUBnBpzdPHhkjzqva8/my5mO0oduCslixV0oADfwlkGOJ2wFCJJ581oAsbHsdJ61mdW4g3
	Qw9fvySISllt/ZRsmCTbJJ0s6blIr+/pWtwl2jM+WsUPMH4C8Dagt9qABqcwT5hse+v7uZjkBaR
	42zDIWtoShjjDtTzrPrxADnUKacQ0HXjtGzU0KPo9PC8z6fWMzwH1XaEI2PktJroTLwFKL2eq2F
	utbVszY7l5UV03cRslmzIViY5fAFUr0+KPaU39p3IFGjs0VthGlulBc0Eelb4C4sd0n6LoQ3VLK
	UGEu407ezlRa6L2ffj6eMksGiSrU6sN6l93ly3kSjKdM7tgq1c4LWeSZHxZ+Bpk+iR/RHz1LXog
	Oblsr7rOEHBf62k0oc/a1UWdUDnXQsJlvqx0xGvYT+UXND53kPDmEb++cc7asUU3/7QM0NX1/zh
	YjCneACe9wloDh6lHDMA1ZMbOA4wnwbXmGVbIGfgod5kFntGRDMGEpD0JfkZ0WRiBcVO5ox32la
	l
X-Received: by 2002:a17:90b:288e:b0:3ac:7556:8eda with SMTP id 98e67ed59e1d1-3b41c9cf219mr14157411a91.26.1795583976121;
        Tue, 24 Nov 2026 21:19:36 -0800 (PST)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([122.161.51.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4afeaaa84sm10183348a91.10.2026.11.24.21.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 21:19:35 -0800 (PST)
Date: Wed, 25 Nov 2026 10:49:29 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, chleroy@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCHv3 1/4] powerpc/64: Leave lockdep hardirq context around
 replayed interrupts
Message-ID: <awZuo3adxt0d77KH@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <cover.1795441238.git.ritesh.list@gmail.com>
 <57a5455331a768ffe7d66409ea228d31e9ec1edd.1795441238.git.ritesh.list@gmail.com>
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
In-Reply-To: <57a5455331a768ffe7d66409ea228d31e9ec1edd.1795441238.git.ritesh.list@gmail.com>

On Mon, Nov 23, 2026 at 07:21:50PM +0530, Ritesh Harjani (IBM) wrote:
> With PROVE_LOCKING, boot warns once and lockdep turns itself off:
>   DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
>   WARNING: kernel/locking/lockdep.c:4448 at lockdep_hardirqs_on_prepare+0x22c/0x2d4, CPU#0: swapper/0/0
>   CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.4.0-rc2-00027-g074831f06e18-dirty #123 PREEMPT
>   NIP:  c0000000002b2f2c LR: c0000000002b2f28 CTR: c000000002426f90
>   REGS: c000000004f075c0 TRAP: 0700   Not tainted  (7.4.0-rc2-00027-g074831f06e18-dirty)
>   MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE>  CR: 48022221  XER: 20040000
>   NIP [c0000000002b2f2c] lockdep_hardirqs_on_prepare+0x22c/0x2d4
>   LR [c0000000002b2f28] lockdep_hardirqs_on_prepare+0x228/0x2d4
>   Call Trace:
>     lockdep_hardirqs_on_prepare+0x228/0x2d4 (unreliable)
>     trace_hardirqs_on+0x98/0x11c
>     irqentry_exit+0x64c/0x1064
>     timer_interrupt+0x274/0x6bc
>     __replay_soft_interrupts+0x158/0x380
>     arch_local_irq_restore+0x1cc/0x244
>     console_flush_one_record+0x438/0x654
>     console_unlock+0xb8/0x1e0
>     vprintk_emit+0x300/0x56c
>     vprintk+0x20/0x34
>     _printk+0x40/0x54
>     lockdep_init+0xdc/0x104
> 
> The warning is triggered because trace_hardirqs_on() gets called while
> lockdep's hardirq_context still says we are handling an interrupt. To
> fix that, we need to ensure lockdep's hardirq_context and
> hardirqs_enabled state stays consistent with powerpc's soft-masked
> interrupt replay code and the generic entry/exit code.
> 
> With the current change, this is how the new state machine looks like:
>                                        hardirq_context  hardirqs_enabled
>   arch_local_irq_restore()
>     trace_hardirqs_off()                     0             1 -> 0
>     irq_enter()                           0 -> 1           0          (softirqs held off)
>     __replay_soft_interrupts()
>       lockdep_hardirq_exit()              1 -> 0           0          patch: the loop is not a handler
Yeah this makes sense to have it here.
>       timer_interrupt(&regs)
>         irq_enter_rcu()                   0 -> 1           0          handler starts
>         irq_exit_rcu()                    1 -> 0           0          handler done
>         irqentry_exit()
>           trace_hardirqs_on()                0             0 -> 1     legal: context is 0
>       next_interrupt()
>         trace_hardirqs_off()                 0             1 -> 0     still replaying: back to off
>       ...                                 same for each pending interrupt
>       lockdep_hardirq_enter()             0 -> 1           0          patch: restore for the caller
>     irq_exit()                            1 -> 0           0          softirqs may run now
>     trace_hardirqs_on()                      0             0 -> 1     IRQs really enabled
> 
> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  arch/powerpc/kernel/irq_64.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/irq_64.c b/arch/powerpc/kernel/irq_64.c
> index d5c48d1b0a31..e2f1e5b7a3a7 100644
> --- a/arch/powerpc/kernel/irq_64.c
> +++ b/arch/powerpc/kernel/irq_64.c
> @@ -76,13 +76,11 @@ static inline void next_interrupt(struct pt_regs *regs)
>  	}
> 
>  	/*
> -	 * We are responding to the next interrupt, so interrupt-off
> -	 * latencies should be reset here.
> +	 * We are responding to the next interrupt. The irqentry_exit() of the
> +	 * replayed handler has traced hardirqs on, which also reset the
> +	 * interrupt-off latencies. Trace them off again.
>  	 */
> -	lockdep_hardirq_exit();
> -	trace_hardirqs_on();
>  	trace_hardirqs_off();
> -	lockdep_hardirq_enter();
>  }
> 
>  static inline bool irq_happened_test_and_clear(u8 irq)
> @@ -116,6 +114,15 @@ static __no_kcsan void __replay_soft_interrupts(void)
>  	 */
>  	local_paca->irq_happened |= PACA_IRQ_REPLAYING;
> 
> +	/*
> +	 * The irq_enter() of our callers is there to hold off softirqs. Each
> +	 * replayed handler enters and leaves the hardirq context itself and
> +	 * returns through irqentry_exit(), which again traces hardirqs on.
> +	 * Since lockdep only allows that outside of hardirq context, so leave
> +	 * it for the duration of the replay.
> +	 */
> +	lockdep_hardirq_exit();
> +
>  	ppc_save_regs(&regs);
>  	regs.softe = IRQS_ENABLED;
>  	regs.msr |= MSR_EE;
> @@ -168,6 +175,8 @@ static __no_kcsan void __replay_soft_interrupts(void)
>  		next_interrupt(&regs);
>  	}
> 
> +	lockdep_hardirq_enter();
> +
>  	local_paca->irq_happened &= ~PACA_IRQ_REPLAYING;
>  }
> 
> --
> 2.39.5
> 
LGTM

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
