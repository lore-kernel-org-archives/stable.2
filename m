Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C193B42F1;
	Mon, 31 Aug 2026 08:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163959; cv=none; b=YxhEGVeu8VDLoBurWuGfgnM6d4zqcoiVqIINBySzXu3eaxyggDuEzgeYs6l+2z6LiAykOS5HzWNIv5ZrVS6Jc0zo48AcFA/hZPW1bGE9rAcgpslzzo2eqm0A+R0o6EttDQNf3Xd/UBDb+Oum4KYbMNcAGZu961SO95M31iMbjUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163959; c=relaxed/simple;
	bh=bJtaF4SL+dPYWNtKeipmDvS2j2B4bNfP4VeegpaL6AY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iC/jiyLenJAVcVxeuAybsqJMtXyj9FpyJ01SQb2XoEBSSJ53FOBkH8NweaNiuTbXfMwTy7CT4SHkoOGG4+/JVkRiSnsBFqDd4xhse3epyho6lrwdbcErxpvMXkTr1v6YsAY5X9KVtlyWlZiz19ahjkbhFIlSY9QV7naHmJoEfXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXRqMvPf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXRqMvPf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F811F000E9;
	Mon, 31 Aug 2026 08:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788163957;
	bh=mxaD1aN/r9kM1YvzylFDxbR38xtnHNx6b1PVq1CwqVY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hXRqMvPfKn/5jeO/eRGALKDRNhrU5a0N97hgnfp9JQ5Bpl1OwoVQleV9kss42aTyO
	 wLsPgWVpdfodSM12rsTjWvPmWJIVdu6be0cTregMNbYq7Ds/a6Xo9D67BQr5CabBNY
	 CBCM2k220f6hwM2vL927Cf1SS62bWImRaVJuRi1WisLlcs3elfHQDXupE//ccWRa1W
	 mFLEw3jbWO+wJ+gPlnkMNEDaQrc+0cfv78K06FaX03EMPPgcReIOiXhjDi+t2FLDCi
	 8+XkYSlV0xZAzHHfa6Q1IO3MYirE4CZ3ZV2Oog/5ogodSZlMzu3kNzpySaIVpqM8kv
	 fn7Rv7y5a/udg==
Content-Type: multipart/mixed; boundary="===============5025744068711041007=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dc68ecf3e7f2f451cedb579967d136e2c8619ad13c3c5d004f931c65ca0610bf@mail.kernel.org>
In-Reply-To: <b11a7ad9ecf1dd7f6524067f061b4f7dabeff1d9.1788154635.git.skb99@linux.ibm.com>
References: <b11a7ad9ecf1dd7f6524067f061b4f7dabeff1d9.1788154635.git.skb99@linux.ibm.com>
Subject: Re: [PATCH v13 8/8] selftests/bpf: Add tailcall verifier selftest for powerpc64
From: bot+bpf-ci@kernel.org
To: skb99@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,venkat88@linux.ibm.com,yeswanth@linux.ibm.com,skb99@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 08:12:36 +0000 (UTC)

--===============5025744068711041007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
> index 48fa34d2959f4..9880ce4f1931a 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
> @@ -91,6 +91,84 @@ __jited("	popq	%rax")
>  __jited("	jmp	{{.*}}")		/* jump to tail call tgt   */
>  __jited("L0:	leave")
>  __jited("	{{(retq|jmp	0x)}}")		/* return or jump to rethunk */
> +__arch_powerpc64
> +/* program entry for main(), regular function prologue */
> +__jited("	nop")

Will this test work on CONFIG_PPC64_ELF_ABI_V1 builds? On big-endian ppc64
kernels, arch/powerpc/net/bpf_jit_comp.c prepends a 24-byte function
descriptor to the JIT image:

#ifdef CONFIG_PPC64_ELF_ABI_V1
        /* Function descriptor nastiness: Address + TOC */
        ((u64 *)image)[0] = (u64)fcode_base;
        ((u64 *)image)[1] = local_paca->kernel_toc;
#endif
        fp->bpf_func = (void *)fimage;
        fp->jited_len = cgctx.idx * 4 + FUNCTION_DESCR_SIZE;

and bpf_prog_get_info_by_fd() copies jited_len bytes starting at
prog->bpf_func. The disassembler then receives those 24 descriptor bytes as
if they were instructions. The low half of a typical kernel_toc address
such as 0xc000000001b70000 decodes from primary opcode 0, which is illegal,
causing disasm_insn() to call PRINT_FAIL("Can't disasm instruction...") and
fail the test.

The companion commit 9e3a62e5e00a6 truncates the trailing 8 bytes for this
reason, but nothing strips the leading descriptor. Should the test be
restricted to ELFv2, or should jit_disasm_helpers.c skip
FUNCTION_DESCR_SIZE at the head of each function on ppc64 ELFv1?

> +__jited("...")                          /* ld 2, 16(13) absent with CONFIG_PPC_KERNEL_PCREL */

Is this comment accurate? The TOC load is guarded by both conditions:

#ifndef CONFIG_PPC_KERNEL_PCREL
        if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2))
                EMIT(PPC_RAW_LD(_R2, _R13, offsetof(struct paca_struct, kernel_toc)));
#endif

so it is also absent on CONFIG_PPC64_ELF_ABI_V1 builds.

Also, is the displacement always 16? The offsetof(struct paca_struct,
kernel_toc) is 16 only when CONFIG_PPC_PSERIES=y, because the leading
'struct lppaca *lppaca_ptr' member is inside '#ifdef CONFIG_PPC_PSERIES'.
Without PSERIES the offset is 8, giving 'ld 2, 8(13)'.

> +__jited("	li 9, 0")
> +__jited("	std 9, -8(1)")
> +__jited("	mflr 0")
> +__jited("	std 0, 16(1)")
> +__jited("	stdu 1, {{.*}}(1)")
> +/*
> + * load address and call sub() via count register
> + *
> + * Address materialization differs between PCREL and non-PCREL kernels.
> + * Skip the address generation sequence and verify only that the call
> + * target is loaded into CTR before branching.
> + */
> +__jited("...")
> +__jited("...")
> +__jited("...")
> +__jited("...")
> +__jited("...")
> +__jited("...")

Does the framework need six consecutive '...' entries? In
tools/testing/selftests/bpf/test_loader.c, the push_disasm_msg()
function handles '...' by setting on_next_line = false and returning
immediately without pushing a pattern:

if (strcmp(regex_str, "...") == 0) {
        *on_next_line = false;
        return 0;
}

So '...' pushes no pattern at all; it only clears the on_next_line flag
for the following real pattern, which then matches anywhere later in the
log. Consecutive '...' entries are idempotent. These six lines behave
identically to a single '...', and five of them are dead. The comment
describes skipping 6 instructions, but the framework doesn't implement
per-line skips this way.

> +__jited("	mtctr {{.*}}")

[ ... ]

> +__jited("...")
> +__jited("func #1")
> +/* subprogram entry for sub() */
> +__jited("	nop")
> +__jited("...")                          /* ld 2, 16(13) absent with CONFIG_PPC_KERNEL_PCREL */

This comment is repeated verbatim from the main() prologue and has the same
issues: the TOC load is also absent on ELFv1, and the displacement varies
with CONFIG_PPC_PSERIES.

> +/* tail call prologue for subprogram */
> +__jited("	ld 10, 0(1)")
> +__jited("	ld 9, -8(10)")
> +__jited("	cmpldi	9, 33")
> +__jited("	bt	{{.*}}, {{.*}}")
> +__jited("	addi 9, 10, -8")
> +__jited("	std 9, -8(1)")
> +__jited("	lis {{.*}}, {{.*}}")
> +__jited("	sldi {{.*}}, {{.*}}, 32")
> +__jited("	oris {{.*}}, {{.*}}, {{.*}}")
> +__jited("	ori {{.*}}, {{.*}}, {{.*}}")

Will this lis/sldi/oris/ori sequence always appear in exactly this form?
PPC_LI64() in arch/powerpc/net/bpf_jit.h emits between 2 and 5
instructions, conditionally, based on the runtime value:

EMIT(PPC_RAW_LIS(d, (uintptr_t)(i) >> 48));
if ((uintptr_t)(i) & 0x0000ffff00000000ULL)
        EMIT(PPC_RAW_ORI(d, d, ((uintptr_t)(i) >> 32) & 0xffff));
EMIT(PPC_RAW_SLDI(d, d, 32));
if ((uintptr_t)(i) & 0x00000000ffff0000ULL)
        EMIT(PPC_RAW_ORIS(d, d, ((uintptr_t)(i) >> 16) & 0xffff));
if ((uintptr_t)(i) & 0x000000000000ffffULL)
        EMIT(PPC_RAW_ORI(d, d, (uintptr_t)(i) & 0xffff));

Each of these four patterns follows a non-'...' pattern, so test_loader.c
sets on_next_line=true and requires strict line adjacency. The verifier
rewrites BPF_LD_IMM64 to the kernel address of the kvzalloc()'d 'struct
bpf_array', which is a linear-map address 0xc000000000000000 + physaddr.
When that object lands above the 4 GiB boundary (routine with >4 GiB RAM),
PPC_LI64() emits an extra 'ori' between 'lis' and 'sldi', and the 'sldi'
pattern then matches one line late, causing validate_msgs() to report
WRONG LINE.

Symmetrically, a 64 KiB-aligned map address drops the trailing 'ori', and a
map whose bits 16..31 are zero drops the 'oris', both producing
EXPECTED/no-match failures. The test already recognizes this problem for
the call-target address (the comment about PCREL vs non-PCREL address
materialization plus '...' wildcards). Should the map-address
materialization use a single '__jited("...")' instead?

> +__jited("	li {{.*}}, 0")
> +__jited("	lwz 9, {{.*}}({{.*}})")

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33368376983
--===============5025744068711041007==--
