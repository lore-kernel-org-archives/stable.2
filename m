Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794930757;
	b=ooKVtVadSYV2jLmeu1awy/SZb9gil5qzcHNx/sbd+LXqVD96yxIyllQvxQyhwzS4llyQ
	 HUZNDKp89QYibq70+TUwdLaCGZawz4puVQkAdN1CaHRquBBg2ZtcXWRf6o2GOuIIQemBa
	 9isgL8905eVZk9K4B/QxNdKHcRQ7nnmfdvMCz5H4FDDpa41wsIkBo23JEXoWkkh5wUy+9
	 86ixhsbunLG72HVeQWXFBZ7oYP6Vowo0MhYw5aQTO9Xe5IbZ2Qcl10G5Aw452ejPnMhjl
	 Xr7GifcROdINSJ/+/zq6SlvwWYAfnE5MDaGc8PQUuQA8qLC7936Kmbkwe16ZZENmGBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794930757;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=rWQ3LCKx81yVb4ZPYmvkuNFKtOFNJfTl68Lxuk3875w=;
	b=t4yX0Q+k0GMHMhO2FxBcWEae6N7n+fUulJSagmpAOMB0cNDrGYTJf2mC+Pw9Qv5+1jK8
	 LB1mSW81BBENWWqNIqHVECuPCP4VuANDV2XVoTe0Opws5Zu9tGHWy+tfPcFqA7MCRQ0jM
	 9pGbFhEuXBnxgLXzrR67FZldRU9tWEVH7QeimgwmWiU3kuEVL4Nni2eTkC0nfdN71anOq
	 sOJQv62LtwUYZ5KDS/Q+b/2/uh6qg4OvUXoPQuRcI9SBYCxrIJ0fW3XcjSJcnc9CkoBsJ
	 VKHnVxn4HMoa0olI35bjmDL8ZAGKsG9hlwi1GQj5ExK2gLDQpaO8kAwUn1HRLCWCH+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=URGWjLaz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DF3606A32F;
	Tue, 17 Nov 2026 15:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=URGWjLaz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7A01F000C7;
	Tue, 17 Nov 2026 15:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794930757;
	bh=rWQ3LCKx81yVb4ZPYmvkuNFKtOFNJfTl68Lxuk3875w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=URGWjLazzCNyXLQoIZq8i+Ieeqm5wCpQGJa3a+x8rIKCdnXEJkzUl48TG7es5hN1t
	 aP23+qbwX5cDttOoJpIdRG2DNigYRritwoUMwYe5KGFybBNRKJT2cKLlO6S2VHwCX5
	 nTq11yf1pXMzhm3FpbRLshfnXfHG+9AUmH7xVqNnVZ3Sda/vcLAuqVhRPy1kCVnLNq
	 hWS+pU8vcqeNP/Jb3fhA2XXC1mHLAylbRZb8a+8164OusWf81YmV756sceh5ysQ1X1
	 yHPP7ilExlBiJ1uEbvfmlw5YbLkfvdHAmr3phQzeESesk8U2rDraLjNjIe++54oCc+
	 XRu+Xb4FIPsRw==
Message-ID: <07b9bd2b-19da-4e3c-9b01-552364a82269@kernel.org>
Date: Tue, 17 Nov 2026 16:52:31 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/4] powerpc/64: Leave lockdep hardirq context around
 replayed interrupts
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, stable@vger.kernel.org
References: <cover.1794924821.git.ritesh.list@gmail.com>
 <cfdac7c3508cf0eb1cbf063e7f6331dccb128796.1794924821.git.ritesh.list@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <cfdac7c3508cf0eb1cbf063e7f6331dccb128796.1794924821.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 17/11/2026 à 15:25, Ritesh Harjani (IBM) a écrit :
> With PROVE_LOCKING, boot warns once and lockdep turns itself off:
>    DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
>    WARNING: kernel/locking/lockdep.c:4448 at lockdep_hardirqs_on_prepare+0x22c/0x2d4, CPU#0: swapper/0/0
>    CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.4.0-rc2-00027-g074831f06e18-dirty #123 PREEMPT
>    NIP:  c0000000002b2f2c LR: c0000000002b2f28 CTR: c000000002426f90
>    REGS: c000000004f075c0 TRAP: 0700   Not tainted  (7.4.0-rc2-00027-g074831f06e18-dirty)
>    MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE>  CR: 48022221  XER: 20040000
>    NIP [c0000000002b2f2c] lockdep_hardirqs_on_prepare+0x22c/0x2d4
>    LR [c0000000002b2f28] lockdep_hardirqs_on_prepare+0x228/0x2d4
>    Call Trace:
>      lockdep_hardirqs_on_prepare+0x228/0x2d4 (unreliable)
>      trace_hardirqs_on+0x98/0x11c
>      irqentry_exit+0x64c/0x1064
>      timer_interrupt+0x274/0x6bc
>      __replay_soft_interrupts+0x158/0x380
>      arch_local_irq_restore+0x1cc/0x244
>      console_flush_one_record+0x438/0x654
>      console_unlock+0xb8/0x1e0
>      vprintk_emit+0x300/0x56c
>      vprintk+0x20/0x34
>      _printk+0x40/0x54
>      lockdep_init+0xdc/0x104
>      start_kernel+0xa24/0xc68
>      start_here_common+0x1c/0x20
> 
> Since commit bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature") a
> replayed handler always returns via irqentry_exit(), which traces hardirqs
> on while the replay is still inside irq_enter():
>    arch_local_irq_restore()
>      irq_enter()                        hardirq_context = 1
>      __replay_soft_interrupts()
>        timer_interrupt(&regs)
>          irq_enter_rcu()                hardirq_context = 2
>          irq_exit_rcu()                 hardirq_context = 1
>          irqentry_exit()
>            trace_hardirqs_on()          hardirq_context != 0 -> WARN
>        next_interrupt()
>          lockdep_hardirq_exit()         too late
> 
> Leave the hardirq context before each replayed handler instead of
> after it:
>    arch_local_irq_restore()
>      irq_enter()                        hardirq_context = 1
>      __replay_soft_interrupts()
>        lockdep_hardirq_exit()           hardirq_context = 0 // fix
>        timer_interrupt(&regs)
>          irq_enter_rcu()                hardirq_context = 1
>          irq_exit_rcu()                 hardirq_context = 0
>          irqentry_exit()
>            trace_hardirqs_on()          ok
>        next_interrupt()
>          trace_hardirqs_off()
>          lockdep_hardirq_enter()        hardirq_context = 1
>      irq_exit()                         hardirq_context = 0
> 
> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>   arch/powerpc/kernel/irq_64.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/irq_64.c b/arch/powerpc/kernel/irq_64.c
> index d5c48d1b0a31..b189e796eb34 100644
> --- a/arch/powerpc/kernel/irq_64.c
> +++ b/arch/powerpc/kernel/irq_64.c
> @@ -75,12 +75,6 @@ static inline void next_interrupt(struct pt_regs *regs)
>   		WARN_ON(irq_soft_mask_return() != IRQS_ALL_DISABLED);
>   	}
> 
> -	/*
> -	 * We are responding to the next interrupt, so interrupt-off
> -	 * latencies should be reset here.
> -	 */
> -	lockdep_hardirq_exit();
> -	trace_hardirqs_on();
>   	trace_hardirqs_off();
>   	lockdep_hardirq_enter();
>   }
> @@ -137,18 +131,21 @@ static __no_kcsan void __replay_soft_interrupts(void)
>   	if (IS_ENABLED(CONFIG_PPC_BOOK3S) &&
>   	    irq_happened_test_and_clear(PACA_IRQ_HMI)) {
>   		regs.trap = INTERRUPT_HMI;
> +		lockdep_hardirq_exit();

Can we include that in irq_happened_test_and_clear() instead of 
duplicating it 5 times ?

>   		handle_hmi_exception(&regs);
>   		next_interrupt(&regs);
>   	}
> 
>   	if (irq_happened_test_and_clear(PACA_IRQ_DEC)) {
>   		regs.trap = INTERRUPT_DECREMENTER;
> +		lockdep_hardirq_exit();
>   		timer_interrupt(&regs);
>   		next_interrupt(&regs);
>   	}
> 
>   	if (irq_happened_test_and_clear(PACA_IRQ_EE)) {
>   		regs.trap = INTERRUPT_EXTERNAL;
> +		lockdep_hardirq_exit();
>   		do_IRQ(&regs);
>   		next_interrupt(&regs);
>   	}
> @@ -156,6 +153,7 @@ static __no_kcsan void __replay_soft_interrupts(void)
>   	if (IS_ENABLED(CONFIG_PPC_DOORBELL) &&
>   	    irq_happened_test_and_clear(PACA_IRQ_DBELL)) {
>   		regs.trap = INTERRUPT_DOORBELL;
> +		lockdep_hardirq_exit();
>   		doorbell_exception(&regs);
>   		next_interrupt(&regs);
>   	}
> @@ -164,6 +162,7 @@ static __no_kcsan void __replay_soft_interrupts(void)
>   	if (IS_ENABLED(CONFIG_PPC_BOOK3S) &&
>   	    irq_happened_test_and_clear(PACA_IRQ_PMI)) {
>   		regs.trap = INTERRUPT_PERFMON;
> +		lockdep_hardirq_exit();
>   		performance_monitor_exception(&regs);
>   		next_interrupt(&regs);
>   	}
> --
> 2.39.5
> 

