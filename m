Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795674093;
	b=aDP/NXrDkg3nHLdDnaztQ9C9nNQ5ZgcEh3SQoiz3QKy/zxYPdpH5viMund+vUUmiH7PG
	 gqhQvz8+o3pP/evgWhH8agm+57Hr8of983zdDx3XUeOstorGP3D3tRGNWS1W+qHTJ9LcD
	 PYMWkGE6LI8h7+miCUQ1ZN4NCBdVD9TRqwAFLYRZ6WcwEXDMwg5jd6zaR1x33JQnJ1db6
	 lkOHdppr/sKaNCdn9tvuLvVuFXCVn/BjYa4Mmu4q81oPiDYLjT3T3YwqAB9MyL1c+C2tC
	 0pH7k/gyHFg3WvubAXqNVcuMFad8eNYRTeafr0JPVkcKa2Dl2z0I0IzDXEQxZbCHq/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674093;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Q0z4xv3EWmhQDyAjFR8MKUlXt4SG+L1ZlVS7DWBq2yQ=;
	b=rftfjKDpHjZsr70Z/47xsFy+r/3G0z0U1YTB+WLqokyc3s+Ek/mNQPaxUts8YEOUgXhw
	 9tBwpcV64Qsqt2/v4auR8x+jMjw39iR9kP1fWgwPfZOxGQGedELQiShs/TaOD8ERmbzsd
	 hvG/LkbhNVbPUuWXNib0xWwieLjwrvhbkLMXQYf7C8ZNUIRta6+7WRXqptirk278ywaYC
	 H9R+OB+YHIdn7YeES4AzyXmu0mPc03nhYd3GecZAM56JS8XQYBH3d2TYX6s217FTsniif
	 s20OPFV8pHy67I9tMLBn8gu99vR/QvfhgG7sSkMA8G/qf2qgDSGzZbaxszEs//JoxDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0I997roE;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C6A606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 06:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5C6A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0I997roE
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2f0426a65e0so42004925ad.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795674092; x=1796278892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q0z4xv3EWmhQDyAjFR8MKUlXt4SG+L1ZlVS7DWBq2yQ=;
        b=0I997roEZ40SLiH9GUDo1iIQah3yMsSMCKjSJb/sLZbSAPBagBKajPDtX+ifjOL1+C
         uJgWQ/x/MwIvqqr3w3REM9IL9Ff3hvrPnFt+ouiFssL5DPUqfab4yujevaggueQPkPRi
         ygfX8Z/Ac/YvOkJCNL75C6D+HHfdkpqSxf/iKDgN1Cr6k51bhOW4uGNlBU8vikuInCuh
         U9ELx7THy1RgrueOGNq9bBLwpOcJNn9kl3RQD+MyK6HYGyigC+r3Pyf/JdW3h5JYzUN3
         ydfnFqpyuWDqUMAk7DxhFRLkv0sFDB7RYmngEjcVTGOYtWPFYkvP/Uc4h0LiN716daYL
         sthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795674092; x=1796278892;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q0z4xv3EWmhQDyAjFR8MKUlXt4SG+L1ZlVS7DWBq2yQ=;
        b=xnRmNZhbxFFK10ZOehZxpaPNUP0bVCMJMXl89aKuuteMxQvT3yjTp/8ccl3P9sZR1j
         wejSYbkZhwYKZMrvN9MDL62sSVWszz22g2Jpt8gu87dgijE3eAxILcQt6sBQph/9Xjj9
         qfYFKhRPyAgjLE9pLETWlF5nqunyAY/YJYZM+ScnKI5UHtyWeazOpegU4reWFquU5r+P
         D3JANiUo6Ep5EtR4hvlisM5i1/TllZSEH6N9cKeM24qNVcGlvXfSAlHrNsxMv2zbGJWI
         SX5BlhIf1CogLGlknVYH+6XgwlYkfX512apjJrdf1s85/a1keC4gsvzJOfT5O9pnR1R4
         DrIw==
X-Forwarded-Encrypted: i=1; AL+hErEeqCZ/SQ7czWezpvnNl28aV1vMCNS5eYsC5Ho5fdoiwsErxL+27swZBhl/FFoCAmYM7C2H/kY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wObpuO9sL263WjkSJLan/jhEjDb7PO5iN9Hq3WhaUZD4ZEc6z
	Cdh2Lv5fM8sFrfZnv6Xx7JBp4vsHitwVRl12l+ZfBdyNheZ6IpDEw3ds
X-Gm-Gg: AZFdTZeQ0ZXBIqZik2wYYGRICWP+qo5QQR4qNMOZiMpUcCtLarfMlv3mVEaDVcaeUfO
	lXiAMU6mNjEtXgO641I6J1o8ZHuUlgANvTsEvSt/KtU5dLywWQZqCER3ixLuTeINZEhy8KotLaU
	FUWh0kMV03RVPRtN9mfCZadHaxERl8h2rW88fhiYtJRUgMH2+n+hSPuv1xpNHWjv+SWNvBbI2e2
	v4+RZtjvUejWS7bg8Xb7k+kaJ0jO9GETZOxC+GSx/otxpSYLl/kucwiaHIcHwzYPLWgUcf2meHI
	lIPG//p/rDHpkTjGtF9wdAtnxxaP+38TV8//mN3v/LLDhy+ooQWBED94cxDAmeHiwkdKuj9wt5X
	4BUFSVRpwIhEbYaPH6t9DnUXUJ7mowtb0L0AMjbz5Ho5vrBfdhK1Hr+RPpge77ydoV6vuHKxuYI
	/Nv1Uo69+svHAcViGN7VYhKu5auPobwyAaTDa17B9hRcfzdIgSTdrNCP6jBidv3KZvQOprJOo7J
	UyZ/s0k6d7SXNT4HN2F1JB+2EAI642P6NQC52d96p1ZqWKlckK13cwqHstO2W3ZkTJ4OaSqp/o7
	H3vsi4E7MQkXKRIl371kbrCt/sVa9GSHgxfsKBzaGSZd56b7nM+zsAOKmj7zlw3XP0KwerC63gd
	/
X-Received: by 2002:a17:903:230a:b0:2ed:fd0:e736 with SMTP id d9443c01a7336-2f03f0c1ef9mr187752545ad.6.1795674091848;
        Wed, 25 Nov 2026 22:21:31 -0800 (PST)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([122.161.50.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f120769sm98712685ad.57.2026.11.25.22.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 22:21:31 -0800 (PST)
Date: Thu, 26 Nov 2026 11:51:25 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, chleroy@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, stable@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCHv4 1/4] powerpc/64: Leave lockdep hardirq context around
 replayed interrupts
Message-ID: <awfPsq2b__or0k74@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <cover.1795603946.git.ritesh.list@gmail.com>
 <6a02babe73f316616cf829af3ddbbfc61fb4066a.1795603946.git.ritesh.list@gmail.com>
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
In-Reply-To: <6a02babe73f316616cf829af3ddbbfc61fb4066a.1795603946.git.ritesh.list@gmail.com>

On Wed, Nov 25, 2026 at 04:56:03PM +0530, Ritesh Harjani (IBM) wrote:
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
> Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Closes: https://lore.kernel.org/linuxppc-dev/b44aefc5-e066-478b-8d34-50d2d0deab6b@linux.ibm.com/
> Closes: https://lore.kernel.org/linuxppc-dev/20260922150619.lwWqj1AO@linutronix.de/
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

Tested this with multiple rand config and fedora distro config. No
splats are seen now.


Tested-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
