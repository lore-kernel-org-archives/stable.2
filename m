Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795670344;
	b=F8bphUEZZTZoZ/hWqOX2Wp2e5wLFkjgvxce53ZXVvFaJESE9qzQQUXJrpWEoE2Zd+FDu
	 qtpSdGPkQNpVaUQj2HemZ6NV2C/peORUXOl0xbEfYqbi5sWOOVQFx0689B37h8JMrXe/f
	 8wA3oAXYhYq/KEraB5GdHbYhttwSEBSoJzfUTIFZjX7p1pS9Z9JGM3GdocCl5f/86VnpC
	 O6lo7rZLnAARlzXTdrkHNSa3RTenexkeppTYIoiTzHIjTzQLd/h25N9NahEY98ATCzmzy
	 ksz1buwufac/qOn3oSxj+0eORBUMm1PGmpWeHSBmAZiYFCJfNb5cQzqoiR88+HEVwFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795670344;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=SmGwW+D3JztXCRa1pJ0AYwGqb4CeC20tVUU8LlpmFso=;
	b=zJLwDb2hP6fs3Fr20LGqGqBE+MpyefFxXwYXpRsaUCPRJER0hZmCzj/q0SwKnX174xQt
	 quoifGwiQRiRxfzraYM6ET7uoX15mh9Ki1TkIQMs+kx/tUHNQA46EfbYGfQhRU+93KFky
	 ueNRG7Wtq2Cdpk1F138eR+iueDThAs6L8KyCHcw+rHdE1jIlvPvwH35MrI8JKgjyMnmLP
	 LSa1mQsv5hFJBmzFil795ZPxu1o7yEy3UjRU53UaaINUJxgS2qpyrv8s4zNeKaWZlJ5ij
	 5fo6Y5qDPUVmlJrkWFssWzBYfnn3U8E17z0n92PNVsO+V6nRUyU/qVzN6c2HzRgTgXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AvLXsUXg;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9676606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9676606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AvLXsUXg
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so4017151b3a.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795670343; x=1796275143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SmGwW+D3JztXCRa1pJ0AYwGqb4CeC20tVUU8LlpmFso=;
        b=AvLXsUXgPkiTFjjNz8ExKpCzuWQOTTx4zxsjwC/fv/6N/rR1UfIKtMPDIU4eas2Slz
         unCi+qGyHXdP1twnq3Uvcic1XmO1J2mjvSURYAELvTWEXJ/AuJs+lbhl4vQd6nnbAMFp
         7TY2ZzHzWEQfddk/tTrhBS2ulYwshGlqq0+UGW1Re7pC/XZRvKc/A5eqmW99R9OsArDW
         DkwFabTJSZWPIDnI+TqhMHv+2x0UHGx1korASFJ9VroK+MaLz1U/6DvprWodaDqhyFiV
         hvCGemXZzCsOHbXNpb4nW2aXQuVahtVMP4aVCjtVdOr911iDeC+HD/GBMZ5P67M2zFq4
         svCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795670343; x=1796275143;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SmGwW+D3JztXCRa1pJ0AYwGqb4CeC20tVUU8LlpmFso=;
        b=M1NERiqm8RX7HnPqfO6AFLW2Rmng+fTuWbchIli9jUL72u1JPCfeEdNHTeSZsuVzo7
         TWH8r7vCYoP4w1AOGfmf20+hSlaffdMqJrVpAUa9WmBm/OY2gSfUvPwD0ozKFoBinQIU
         IppkycJr6LjWgY5PH2GP/dyVSbEqCFivdYo+MrJqZ+huqJyHfWlLYgEGNf33U8tIQMey
         W86Tmdp06uk8CK48kjiQizZWCDln1Q8MzDZ54VxYXli41DMwcbIOp+T6C3V5X6JWksDf
         PUFn/DKxGDy+Mw+O1obgSWI5SRLTOQyoc/GdCJ7/eoyQWD6yyNN6Ao5INMD41sh++g4o
         ERaw==
X-Forwarded-Encrypted: i=1; AL+hErHRX2UTsPPa39R+Qx305sTMKFliGjpt37SxoEkAppQM5fJq39xg0i4YXVs2PHhUvnKQ0sLxz30=@vger.kernel.org
X-Gm-Message-State: APuU4Z8u4R7azqaP4KZwlD74eXhxor2dqmJjNusXIxW+bP59cAwjc9ct
	Zo+Zr6AS+vxSTEZjN0REIkWlrZp1uxHTEDGUu8b4YVheoymr563DzNyp
X-Gm-Gg: AZFdTZeB27rkXJwQ5/xY/8CExB3CiGaE845CGfl25bPs2vne90PxhDg+hZ8gNbC5tnf
	z+ntN6aEW2U/sBoAjz4TTnUNLBHQ9A+Uxhn3I0pzKxZegHmeNZDiOJAFFUZIZJtODxNMvzoOgRk
	3YoapYfQumqJpiTP/3V8g+H5n+BGWSOnrU5XrwGrqOEn5BssLWH1PZq6MGAkcxyHefOvr50Ld14
	5VbPtL3OPWz3yMnrJY3xRT6WgpmrorcmCyeonAk9GeOt23Hs4UtZCSfrUE714NklFa09h/toI0F
	/IvjuqHB4/G4IfRUqu49/uw4xgducr0qIKeKMS0ULFan+FssY7piAWoOs6ZYST/+ncW/NMtxj/N
	61EYo6asIcV11WfOmzBGRrLpyInpcumQTuozH+DUiBiJ1ObfxWJH+gfhofJkWepesShfAerul3t
	4chlE9S+NGfw39a8ykmJATmJB9HkeUXFM/GcLx0a9PijPLhcLZcDj1SzXNIl8Wgum1IgaaVafhy
	DN/ORCnIkuw5vWP9+RKsaB8goZONq5Qx8Dd6sdwjH/WsCeVMsqyMNKIPW7s+V2jHIstEFlcQvJ5
	9crg09XpZYArZ+mgOeYI+bfbwOV6ZoCyNfumXvLu92nK4LbmnMUZBLoinrPNgLLtZvq7JYzh1Du
	9/IG1wxDkWnXZ4BTPLt9ydA==
X-Received: by 2002:a05:6a00:3c92:b0:89e:db6c:f199 with SMTP id d2e1a72fcca58-8c87c57b613mr11322869b3a.14.1795670343036;
        Wed, 25 Nov 2026 21:19:03 -0800 (PST)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([122.161.50.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e45756sm10149403b3a.27.2026.11.25.21.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:19:02 -0800 (PST)
Date: Thu, 26 Nov 2026 10:48:56 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, chleroy@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCHv4 2/4] powerpc/watchdog: Disable preemption in
 arch_touch_nmi_watchdog()
Message-ID: <awfBNN6hpOHXS13M@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <cover.1795603946.git.ritesh.list@gmail.com>
 <fb07a250216a733b064f8eec672f9e682c3660d8.1795603946.git.ritesh.list@gmail.com>
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
In-Reply-To: <fb07a250216a733b064f8eec672f9e682c3660d8.1795603946.git.ritesh.list@gmail.com>

On Wed, Nov 25, 2026 at 04:56:04PM +0530, Ritesh Harjani (IBM) wrote:
> touch_nmi_watchdog() can be called from preemptible context, e.g.
> sysrq-w via /proc/sysrq-trigger. The powerpc implementation uses
> smp_processor_id(), so with DEBUG_PREEMPT we get:
> 
>   root@buildroot:/# echo w > /proc/sysrq-trigger
>   sysrq: Show Blocked State
>   BUG: using smp_processor_id() in preemptible [00000000] code: bash/238
>   caller is arch_touch_nmi_watchdog+0x3c/0xd4
>   CPU: 0 UID: 0 PID: 238 Comm: bash Not tainted 7.4.0-rc2-00029-g7664547149ae-dirty #126 PREEMPT
>   Call Trace:
>    dump_stack_lvl+0x138/0x150 (unreliable)
>    check_preemption_disabled+0x120/0x158
>    arch_touch_nmi_watchdog+0x3c/0xd4
>    show_state_filter+0xf0/0x338
>    sysrq_handle_showstate_blocked+0x24/0x38
>    __handle_sysrq+0x134/0x3a8
>    write_sysrq_trigger+0x178/0x22c
>    proc_reg_write+0xf4/0x150
>    vfs_write+0xfc/0x71c
>    ksys_write+0x8c/0x150
>    system_call_exception+0x310/0x590
>    system_call_vectored_common+0x15c/0x2ec
>   ---- interrupt: 3000 at 0x7ffd01755b98
> 
> Unlike the generic version, which only sets a flag, we update the CPU's
> timebase stamp and its SMP watchdog pending bit, so a migration in
> between touches the state of a CPU we are no longer on.
> 
> Disable preemption across the update to fix this.
> 
> Fixes: 2104180a5369 ("powerpc/64s: implement arch-specific hardlockup watchdog")
> Cc: stable@vger.kernel.org
> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  arch/powerpc/kernel/watchdog.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
> index 44f178e07531..1a8514b2d853 100644
> --- a/arch/powerpc/kernel/watchdog.c
> +++ b/arch/powerpc/kernel/watchdog.c
> @@ -459,9 +459,13 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>  void arch_touch_nmi_watchdog(void)
>  {
>  	unsigned long ticks = tb_ticks_per_usec * wd_timer_period_ms * 1000;
> -	int cpu = smp_processor_id();
> +	int cpu;
>  	u64 tb;
>  
> +	/* Callers may be preemptible. Stay on this CPU for the update. */
> +	guard(preempt_notrace)();
> +	cpu = raw_smp_processor_id();
> +
>  	if (!cpumask_test_cpu(cpu, &watchdog_cpumask))
>  		return;
>  
> -- 
> 2.39.5
> 

LGTM 

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
