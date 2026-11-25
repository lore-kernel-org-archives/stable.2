Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795585843;
	b=x+k6vrjVoFLaLZqhzDbTRaaP6QrcGvnXeEk58h2eBPa9k/0zGCYmh784Ql5OmVatZpyJ
	 on2h3jrxt//MIkwQDtaa6frvXPxMw8Jst4DMyA6s+TgatV9/VrNL1z2qJ47krIWFGulqo
	 srIAaWI4pOHmM0YgtbQxmyZqPYlM44wcZcqdCaLaZLfyRMMrcXzPHtSOY9WQhlQIyLqHZ
	 3o+VliXxfpNuDWXBwRQhyr3bUS0fuzFxFT66NLIhNjOCLdR/6zbIm6NuZmOpW8iC7nfpf
	 aERQ66WuKIBEOb0X1LHUBCzl6EalBL2YeYKjgFYsPcmDWoD0GAdiI1LkI2KKz8C6vXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795585843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ROEbaJZgsjUR2jXRu+Oh+vuifiOcyZNOtowCB7+3Vv4=;
	b=bFOJEDk+HXebJyngc0S2Q+KGiF4Znx8RbnLIy5QZVi7A+mIQgtCFy6xl3c8S8yGyMQk+
	 7Ic7S7KosHY99zfajZG0YJYl4mwhbgAwS3/9VpnT8uafMHA4uJEpoU4HUTtm/zHBVFMwZ
	 9o8fhJhq6Vnvi6VRUpsWbYoGgidKwdj1HorOm59Lywi+vMIyMLHlm24yxkFxKwK4FWVmj
	 acNNnSU8q4WX5dKnbfIGPAVTDuT8jNFnJSNIwSkocYysCXIGI5XPbjO03xOBbiuRWDDps
	 O8011XjAZT2bAbuxNEoUFMLFrZ3fFBwyJUasWePiO0auhPBhJeNbXLDg5udbm5CePSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BL5Oh30v;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFD4606A32C
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 05:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAFD4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BL5Oh30v
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2f04bea9a93so46809415ad.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 21:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795585842; x=1796190642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ROEbaJZgsjUR2jXRu+Oh+vuifiOcyZNOtowCB7+3Vv4=;
        b=BL5Oh30vzrSpx1HPKYmDihMSZy+x4PFVNXhOREMhl+eJ1mqZV1jzQzz06ZKPcAz1iZ
         tjxVNiIBZmDRIfqgaQS9ult+/qJuDPLO3lC/WydpzqRBV+4NCW8gxc9huoMhEbjG/eh8
         5SL+E3kJWwmRrVIa1xHL823kT8xjvmcpgW9/y74EWss+pu1wQDZ4f9LADyu567apDLaY
         jK/M87Vz3NjoHIBpVdpB0ihY8Uex7QzZj3kR+yEvuBXyD2e1wUTYbslNdLt1yIEUmJEb
         +6H4QWUOBadcNp/LCMPP/fTuPuPJpqr+nvfYeuO65Q5FOo0K9PcvgisyM/P1MGJ3D1Yy
         Bxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795585842; x=1796190642;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ROEbaJZgsjUR2jXRu+Oh+vuifiOcyZNOtowCB7+3Vv4=;
        b=KvT4rsoqHoEIQ8LJUOeAz9K5NXOYq8dJdiIa+1ItUJyItJcQ+kxjcz6OJMR5ykoLOp
         TxUQnA7rlR/a/VHY+QhajFsH2d06Nh9KcTgup1Bz6EVsd57gdZtRxVLBQIemVl1GxOqo
         8ePhVJc7f7gwvg2RL1us+UvKAQG+vYwBudJR/vJ1p40UYJbw9r1axZXmsJ3BeYFUHoSr
         HAKBwVeHtUaTww8duJiq0vL/DgGeLDz0Q1bGBQs56IGuK8FXBSUD2wuFabAlguxoJWeA
         YOVmxamq7utOke2QGp85/5aNS2QByNvxqPhXEePM968dfXb+kehDFuZ02WmvtDrqtRGM
         1H1Q==
X-Forwarded-Encrypted: i=1; AL+hErHYFOIwuimxHAV6UcwFOcF7nKErrSSNX+l9CzTVjdwXaa/HvF+AE2xBV9F7LQ3Hyt0M9bX/M7g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/uL65U4rdr3lKnQGoVNS3+5xBxyPvsVm/yXBmPQlhi/azlJGEF
	VRTUgHkwTBC/7mDRVDEeV4FaBmkCyLbb5CsTiCxTVsbQJqwdKv3RD7vg
X-Gm-Gg: AZFdTZdlidl6dq9JyQlqVK2W0IT6uk5XjXAUstYI/ivSm1Hn48FfyQkH+gN26ozE6gK
	688DaDzB2l5yVL4vKsYNHvV4Rrarzh8Rcdv6AG1wz3MyuNyfcb3rp3p9l+yVg9yUPS6pZuUc6Br
	U5SO+aSsil7i5ND3HV2g8ybcIL0kJOyASCpSJ+M5dHvoYllxww5+Rl/xTKGG2FUSgXlmx/7x1HO
	Jd69ZmiFDtvGgeQzjrNdvy5aXh5INxrXUi1xrG8i60kZ211AB/Dj62exov2GqHYY+FOwASQH5Da
	iBJY+qnQXqCCyGLIsoKMo5kABIDIeuuC1L+oSjZ0chrHDw15jbAeKDWpbBlsywK5EYbbE4y3F1N
	DqORxUDRiARh2cL2/duGBSS/JGlfcSZ4x/3YCn2SAUKzpBhpMD+gAC9xsp+VSDZEzRukVuDGs7c
	WKriifYbQTlXxwGpnx67/59o//oighYGe1LQ1SjfAp3MjRNjyNL8eyNHfkKrN4nEwE+UeYz5SDn
	fHcTmdG5UlSvtWgIKGIJraIjHDR2MneYL1j62rS7ItKKz64NYk34ucqSUfDyGew6qiS0U5Nn/Wu
	SLb6wHlZ7lMu8j4HhHDqKAhTb0qAOgKRw+bH4WwtQJItuBzKcN/D0eaKHVN9mxTFnSbjRlTJCk5
	c
X-Received: by 2002:a17:902:db11:b0:2ef:eb06:387 with SMTP id d9443c01a7336-2f03f246dc5mr175431075ad.47.1795585842120;
        Tue, 24 Nov 2026 21:50:42 -0800 (PST)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([122.161.51.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f118c88sm79569105ad.56.2026.11.24.21.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 21:50:41 -0800 (PST)
Date: Wed, 25 Nov 2026 11:20:29 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, chleroy@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCHv3 2/4] powerpc/watchdog: Disable preemption in
 arch_touch_nmi_watchdog()
Message-ID: <awZ2qXSxXPO3XUUb@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <cover.1795441238.git.ritesh.list@gmail.com>
 <8a70fa42449a63a73b8340d3296974cc519b5826.1795441238.git.ritesh.list@gmail.com>
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
In-Reply-To: <8a70fa42449a63a73b8340d3296974cc519b5826.1795441238.git.ritesh.list@gmail.com>

On Mon, Nov 23, 2026 at 07:21:51PM +0530, Ritesh Harjani (IBM) wrote:
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
> Disable preemption across the update. While at it, let's also mark the
> function as notrace (since we might be within a tracer when this
> function gets called).
Do we need to also mark wd_smp_clear_cpu_pending as notrace?

Regards,
Mukesh
> Fixes: 2104180a5369 ("powerpc/64s: implement arch-specific hardlockup watchdog")
> Cc: stable@vger.kernel.org
> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  arch/powerpc/kernel/watchdog.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
> index 44f178e07531..32d4e716cb0a 100644
> --- a/arch/powerpc/kernel/watchdog.c
> +++ b/arch/powerpc/kernel/watchdog.c
> @@ -456,12 +456,16 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>  	return HRTIMER_RESTART;
>  }
>  
> -void arch_touch_nmi_watchdog(void)
> +notrace void arch_touch_nmi_watchdog(void)
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
