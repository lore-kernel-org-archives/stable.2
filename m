Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E435246781;
	Sat, 22 Aug 2026 23:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787442385; cv=none; b=jqE0YTLXsTuFf4v9ObMn0ngc4cCpFva+RaSxI34MSos91Vah33OCXsPQJWR/IJZiUKZ9U065ZDDE2LCJrAnkD8RxvXsa+AOTYNTbJDI5468xUjzotpRPl1tmCe5t6sXxik6awsaJLXnog+Pcscp+EX5aN4BGvlhsdW+OzUJXLFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787442385; c=relaxed/simple;
	bh=UAPzIN7w023OtzD8hFszURq+goZ5BiuC6fV3FakAarY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=P++mDDy6d9ZehuxEGcJPfivR3gyvGgbapI8pI9NwzDZQyvxY05AuWmFrajfNgCv15WfzSiT11uVR74JINpdz10ZyrBV+i5zmN8lI4VYt/sIIx/3d5Wdn6bOvLUKn2UOEiSfrFct0s9lJf+d+zVwIV6L7CFLQ0yhTrsQrVgpg0lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcdPn/9m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcdPn/9m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF891F000E9;
	Sat, 22 Aug 2026 23:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787442383;
	bh=dmdY0rRVY96lqwDqBiPyoFiRonX3ZZ/mephexaiP38Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NcdPn/9mAPucJCBHN/9YxRhyr/89/pUwiGfgj05i2yKrR04/j2wtvmfUNuEbQbbm2
	 1f0GqJZwafXVTyMKXthAnB0Rbwck0ADrQxx0zVixAjbLxa9HaAaAq4OVWYl7SMYjpj
	 j2dxiQ+qWwr6hGaco348ynRRcy0jcEpPwLT4YENt+HRM9IrucVC6ZN4CYxooqNQwja
	 /PqC5oy0NWEI6RuobswCWB2q8/y5B8OWW8H6qyei2LkV/TgTxv9RSxZ3B6qh0UJfYK
	 ABQwPRjPOqnMUFW/IfahLMpNxz3P8RYr5KTX4r1qcmGKbpfpvck1R6tkoz7WmniDJ7
	 okTHCAgplS7lA==
Content-Type: multipart/mixed; boundary="===============2076503959956051201=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <541d85c3ca72e8955c562df851c52a6a0d364d95d1efb9fa6a584ed4d826fb01@mail.kernel.org>
In-Reply-To: <20260822225444.2774461-2-simon@swine.de>
References: <20260822225444.2774461-2-simon@swine.de>
Subject: Re: [PATCH bpf v3 1/2] bpf: disable private stack for sleepable programs
From: bot+bpf-ci@kernel.org
To: simon@swine.de,bpf@vger.kernel.org
Cc: simon@swine.de,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,tj@kernel.org,yonghong.song@linux.dev,stable@vger.kernel.org,andrii.nakryiko@gmail.com,olsajiri@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 22 Aug 2026 23:46:23 +0000 (UTC)

--===============2076503959956051201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5e37ca75e5c4..038753ef07a9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5237,6 +5237,15 @@ static enum priv_stack_mode bpf_enable_priv_stack(struct bpf_prog *prog)
>  	if (!bpf_jit_supports_private_stack())
>  		return NO_PRIV_STACK;
>
> +	/*
> +	 * Sleepable programs can be preempted, allowing another task to run
> +	 * the same program on the same CPU. Since private stack is per-CPU
> +	 * and per-program, the second invocation would corrupt the first's
> +	 * stack. Disable private stack for sleepable programs.
> +	 */

Is this comment accurate for all the program types below?

For BPF_PROG_TYPE_TRACING / LSM / STRUCT_OPS, private stack is only
granted when bpf_prog_check_recur(prog) holds, and that same predicate
makes bpf_trampoline_enter() install __bpf_prog_enter_sleepable_recur(),
which bumps the per-CPU prog->active counter under migrate_disable() and
skips the nested invocation.

Similarly, the sleepable raw-tracepoint runner __bpf_trace_run() calls
bpf_prog_get_recursion_context().

The statement "the second invocation would corrupt the first's stack"
would be true for sleepable uprobe programs run via uprobe_prog_run(),
which takes no recursion context. Could the comment explain why the check
is placed before the switch rather than in the case arm that actually
needs it?

> +	if (prog->sleepable)
> +		return NO_PRIV_STACK;
> +

Does placing this check before the prog-type switch have unintended
consequences?

The check strips the private stack from BPF_PROG_TYPE_TRACING / LSM /
STRUCT_OPS even though those paths are already protected. For these types,
bpf_trampoline_enter() consults bpf_prog_check_recur(prog):

kernel/bpf/trampoline.c:bpf_trampoline_enter() {
    if (bpf_prog_check_recur(prog))
            return sleepable ? __bpf_prog_enter_sleepable_recur :
                    __bpf_prog_enter_recur;

and __bpf_prog_enter_sleepable_recur() does migrate_disable() and then
bpf_prog_get_recursion_context(prog), which uses a per-CPU prog->active
counter. A second task entering the same program on the same CPU sees
active != 1 and is skipped, so it can never reach the private stack.

The real hole appears to be below the new check: BPF_PROG_TYPE_KPROBE /
TRACEPOINT / PERF_EVENT / RAW_TRACEPOINT return PRIV_STACK_ADAPTIVE
unconditionally. For sleepable uprobes (the only sleepable case allowed by
can_be_sleepable()), the uprobe runner takes no recursion context:

kernel/trace/bpf_trace.c:uprobe_prog_run() {
    if (sleepable)
            rcu_read_lock_trace();
    ...
    migrate_disable();
    err = bpf_prog_run(link->link.prog, regs);

so a sleepable uprobe can genuinely be re-entered on the same CPU.

Moving the check into the case arm (BPF_PROG_TYPE_KPROBE through
BPF_PROG_TYPE_RAW_TRACEPOINT) would close the uprobe hole without taking
the private stack away from the trampoline types that already handle
re-entry.

There's also a user-visible side effect: priv_stack_mode decides how
check_max_stack_depth_subprog() budgets stack. PRIV_STACK_ADAPTIVE checks
each subprog on its own against MAX_BPF_STACK; NO_PRIV_STACK accumulates
depth += subprog_depth across bpf2bpf frames and checks the combined total
against MAX_BPF_STACK (512).

Any existing sleepable program whose bpf2bpf subtree exceeds 512 bytes
total - SEC("fentry.s/..."), SEC("fexit.s/..."), SEC("fmod_ret.s/..."),
SEC("uprobe.s/...") - now fails to load with -EACCES and "combined stack
size of %d calls is %d. Too large", where it verified fine before. The
selftest at tools/testing/selftests/bpf/progs/verifier_private_stack.c:86
("Private stack, subtree > MAX_BPF_STACK", 512-byte main + 32-byte
subprog, __success) has exactly this shape; it only survives because it
uses the non-sleepable SEC("kprobe"). With Cc: stable@vger.kernel.org,
this would break working programs on a stable update.

>  	/* bpf_prog_check_recur() checks all prog types that use bpf trampoline
>  	 * while kprobe/tp/perf_event/raw_tp don't use trampoline hence checked
>  	 * explicitly.

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32604492082
--===============2076503959956051201==--
