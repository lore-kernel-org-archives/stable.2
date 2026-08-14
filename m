Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FF4339872;
	Fri, 14 Aug 2026 21:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786742422; cv=none; b=sojPmat4p4va/xKK36NEm7Ka4/YnYzfpz3YIDm5f6Pj70u0ub4F77dFoC4nDXudJb5rusB7gL9uJ1HlapAbCiW7TCh/DXSjivNaWeqsJ43avnWdENeYMRojZkyNZVrWdVAMMfoo0relgqp0so6DIzZstuN+7iEZlg+uaEOCKA0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786742422; c=relaxed/simple;
	bh=LfiC7i1te87um7ohclD/3S9oECb1gQQNvt4+lqFIumM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qa4b3OqIlDwlX5q4qk82ZhEI1eq65vMTUh1ngXkksZTDZ5io7TPstvfKjNC8GJW2hw6QCxPSxyWUWitNbHmkNaWSV+2Oz92aKDlxujPpvN8I+PFfa4IZmvIqvl7Z/Kzt/qpCIXdsfW/Luc9yaFuYTY7cPX974jOWypMygTCqTLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuJJZ4KP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuJJZ4KP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40F51F000E9;
	Fri, 14 Aug 2026 21:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786742421;
	bh=7s498hmyPH95uXRNYFX/lOgCIdJtR45crHIwDFMIeyo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=EuJJZ4KPfCIwikniyrMarU2e7tAtOpih209FaJKH4wzFgBimCJAl6Sv2LxOlObfhB
	 EkzZw3hkYvS8RFH4G2hitY53oggUYhdhoXN8HUdRVbCB3lfDul8ZX+li1ugzo07S4G
	 0V1bXSSrP8EukbwzGRLKoN4rdaKF9s2G64mZPjefBtwZIwO8L1mw9tlaahPI+1WLDe
	 Z4IQJkDbLBHdSf8WWp80WSwM/ySy0ErBRGY6X2HjHlegWcHEDgzJu3BUapNc7QzkOD
	 XoBTb/eBzl6g0RI0LKNqFPmgQD+fGiNG9qlwnE4vf7s3McZ98OyE83pz20Fn761LgT
	 hQiHEwPI2nJlw==
Content-Type: multipart/mixed; boundary="===============0578281140868157793=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <eba560e6a2352222c0ff0e4a8cc4d0525abe3ac1306d42958455ec2c2494801b@mail.kernel.org>
In-Reply-To: <20260814203248.3714536-2-vineet.gupta@linux.dev>
References: <20260814203248.3714536-2-vineet.gupta@linux.dev>
Subject: Re: [PATCH bpf v2 1/2] bpf, x86: Fix per-CPU address resolution into an extended register
From: bot+bpf-ci@kernel.org
To: vineet.gupta@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,x86@kernel.org,stable@vger.kernel.org,vineet.gupta@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 14 Aug 2026 21:20:20 +0000 (UTC)

--===============0578281140868157793==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, x86: Fix per-CPU address resolution into an extended register
>
> The destination of the per-CPU address MOV is encoded in ModRM.reg,
> which is extended by REX.R, but the REX prefix is built with
> add_1mod(), which sets REX.B. REX.B extends ModRM.rm and SIB.base, and
> this instruction addresses memory as disp32 with no base, so the bit
> has no effect at all and the high register bit is simply lost.
>
> Every is_ereg() destination therefore resolves to the wrong register,
> picking whichever one shares the low three bits:
>
>   R5 -> RAX    R7 -> RBP    R8 -> RSI    R9 -> RDI
>
> With BPF_REG_5, whose reg2hex is 0, the emitted
>
>   65 49 03 04 25 <off>	add %gs:<off>,%rax
>
> adds the per-CPU offset to RAX rather than R8. The destination keeps
> the unadjusted address and RAX is clobbered, so the program goes on to
> dereference a pointer that was never made per-CPU:
>
>   BUG: unable to handle page fault for address: 0000607e386a8894
>   RIP: bpf_prog_707837aafd2aa9ae_update_percpu_data+0x93/0xc9
>   Call Trace:
>    __bpf_prog_test_run_raw_tp+0x2dc/0x7d0
>    __flush_smp_call_function_queue+0x1e9/0xc80
>   Kernel panic - not syncing: Fatal exception in interrupt
>
> R5 is the mildest of the four, aliasing a scratch register and faulting
> at the store. R7 aliases RBP and would corrupt the frame pointer, R8
> and R9 alias the argument registers.
>
> Use add_2mod() so the register goes through REX.R, matching how
> add_2reg() places it in ModRM.reg and how emit_priv_frame_ptr()
> hardcodes 0x4c for the same instruction with R9. Encodings for the
> non-extended registers are unchanged.
>
> Problem showed up when trying to resurrect BPF_GCC CI (selftests built
> with BPF_GCC).
>
> This has gone unnoticed because clang reloads the address into R1
> before each per-CPU access, so the destination is never an extended
> register. GCC keeps several per-CPU addresses live at once, and
> test_progs-bpf_gcc panics the kernel in global_percpu_data/init, where
> the address of a .percpu variable ends up in R5.
>
> Fixes: 7bdbf7446305 ("bpf: add special internal-only MOV instruction to resolve per-CPU addrs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>

Should this include Eduard Zingerman's Reviewed-by tag? In the v2 review
thread, Eduard provided "Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>"
and specifically noted "Please don't drop acks."

https://lore.kernel.org/bpf/3338fd93155ac14b3b824ce232ae7be288072608.camel@gmail.com/

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index de7515ea1bea..276d076d2993 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1887,7 +1887,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>  				EMIT_mov(dst_reg, src_reg);
>  #ifdef CONFIG_SMP
>  				/* add <dst>, gs:[<off>] */
> -				EMIT2(0x65, add_1mod(0x48, dst_reg));
> +				EMIT2(0x65, add_2mod(0x48, 0, dst_reg));
>  				EMIT3(0x03, add_2reg(0x04, 0, dst_reg), 0x25);
>  				EMIT((u32)(unsigned long)&this_cpu_off, 4);
>  #endif

In the v1 review thread, Eduard requested an inline assembly test with
__xlated() matcher to verify the JIT generates correct code for per-CPU
address resolution. A test was apparently added in v2 as patch 2/2
(tools/testing/selftests/bpf/progs/verifier_percpu_addr.c), but that test is
not present in this commit.

Given that this bug affects all four extended registers (R5, R7, R8, R9)
and can cause kernel panics or frame pointer corruption, should the test be
included here to verify the fix works correctly?

https://lore.kernel.org/bpf/5acb321999d7cc7ebd945c519495a8762501e3cc.camel@gmail.com/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31839526403
--===============0578281140868157793==--
