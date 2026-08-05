Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B883E49DB;
	Wed,  5 Aug 2026 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785915455; cv=none; b=DDa/rqZGyjmYu2mBSw0+0V+WAEcEjCmOQ/k5Ds5bKewlUKkJDzkrObeJehCLG4s4uMNgiqJymBiMYmLNgqy6DojUung6ff67dRyyYlMWub9PiDe5eYjn0eksAjQ0UBali25kP6b7ddIF7ekTxi7cu8O6Dhw82/lIg84A76Sfvns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785915455; c=relaxed/simple;
	bh=Zmxr78xdBA130PUcbv3deCSZZhkCEXY80LMQCZV+1nY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pd1LYnQ6zy2YelXaJpSlM2bwjJzys1Mk7enGRDzvUpMgk0zAgoDsuDYqEcMPupxwmn16QGnaTS6D7P9p9+grP02BzOloymKBWeOTz5Q0YywiJQZvGguRtE5tYhehP7t+z9KTHC2Bb6KQfCc8Ks2GU3YTVn7N8cmeBcBbMYzJZb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/SYKN/S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/SYKN/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFC51F000E9;
	Wed,  5 Aug 2026 07:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785915454;
	bh=QCYYzFAXd/HHDMG7wDvaDepVmzvK1kP9KPdvFyneu38=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=B/SYKN/SgQpBsMcAEjIrmvurqUHxCtPn0WFU5yCxYq+lyFi/P4ProO4bE1A8AMCXB
	 gw/WkRXxGtDep1gG2KBamKdCnzLtsfiJIy7LH9YwxRHDwuuFf+Dr6V0OqOKOCLQAQg
	 BkFZFsBc1VbQjj8enzuLJLv4ccKmyMmw52rzqlU6bb12JhFKPHr1hhTFfViMolJ3Qh
	 gEvj0Y4f6KnciC+AZ1QLysWA3etxEt6wze9jfKU1zYP7/dH7UpREnIz17UzVVkqhHD
	 TnNwvkhCjDC1G2yKYgFE00RrjouDviw/irjwcTGVUjxpeNVptdr1+9bEvFymggffTD
	 Lokky6UdfhPTg==
Content-Type: multipart/mixed; boundary="===============6287462164471471335=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c5ba5b501929ae0da789f24d30b07fc3345822dcdab291694bb4a205f5ba96d4@mail.kernel.org>
In-Reply-To: <8b7bde664004feb383741b8807a561dba601285c.1785906979.git.skb99@linux.ibm.com>
References: <8b7bde664004feb383741b8807a561dba601285c.1785906979.git.skb99@linux.ibm.com>
Subject: Re: [PATCH v10 3/8] selftest/bpf: Fixing powerpc JIT disassembly failure
From: bot+bpf-ci@kernel.org
To: skb99@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,venkat88@linux.ibm.com,yeswanth@linux.ibm.com,skb99@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  5 Aug 2026 07:37:33 +0000 (UTC)

--===============6287462164471471335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftest/bpf: Fixing powerpc JIT disassembly failure
>
> Ensure that the trampoline stubs JITed at the tail of the
> epilogue do not expose the dummy trampoline address stored
> in the last 8 bytes(64-bit) and last 4 bytes(32-bit)
> to the disassembly flow. Prevent the disassembler from
> ingesting this memory address, as it may occasionally decode
> into a seemingly valid but incorrect instruction. Fix this
> issue by truncating the last 8/4 bytes from JITed buffers
> before supplying them for disassembly.
>
> Fixes: b991fc520700 ("selftests/bpf: utility function to get program disassembly after jit")

The Fixes: tag names b991fc520700 ("selftests/bpf: utility function to get
program disassembly after jit", 2024-08-21), which is the commit that
introduced get_jited_program_text() itself. That helper was not wrong when
written: at that time no powerpc JIT emitted a raw data word inside a
program, and the helper is documented (jit_disasm_helpers.c:13) as serving
small assembly test programs.

The undisassemblable trailing bytes come from d243b62b7bd3 ("powerpc64/bpf:
Add support for bpf trampolines", 2024-10-31) - the same commit both
sibling patches in this series cite - and only become observable once
powerpc jited selftests are enabled, which happens later in this series in
d3841599dc7ca ("selftest/bpf: Enable verifier selftest for powerpc64").

More importantly, the fix as written is only correct on top of its
immediate parent. Truncating the last trunc_len bytes assumes
dummy_tramp_addr is the final thing in the JITed image. That layout is
established by the immediate parent c6ba4edfe6e46 ("powerpc/bpf: Move out
dummy_tramp_addr after Long branch stub"), which moved the data word from
the top of the long branch stub to its bottom:

arch/powerpc/net/bpf_jit_comp.c:bpf_jit_build_fentry_stubs() {
    ...
    long_branch_stub_idx = ctx->idx;
    EMIT(PPC_RAW_MFLR(_R11));
    ...
    EMIT(PPC_RAW_BCTR());

    if (image)
            *((unsigned long *)&image[ctx->idx]) = (unsigned long)dummy_tramp;

    ctx->idx += SZL / 4;
}

On any tree that has b991fc520700 but not c6ba4edfe6e46, dummy_tramp_addr
sits before the seven long-branch instructions, so trimming the tail
removes two real instructions (bctr and mtlr r11 on 64-bit) while leaving
the data word in the middle of the disassembled range - the disassembly
failure this patch targets is not fixed, and expected __jited() output is
silently altered.

A backport driven by the stated Fixes: tag alone would therefore land a
change that does not work. Should the tag point at the commit that
introduced the byte pattern (d243b62b7bd3), or should the dependency on
c6ba4edfe6e46 be stated explicitly in the changelog?

> diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
> index 3558fe10e28cf..c4aa1d69d3bbf 100644
> --- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
> +++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c

[ ... ]

> @@ -225,9 +227,30 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
>  	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd #2"))
>  		goto out;
>
> +	/*
> +	 * last 8 bytes contains dummy_trampoline address in JIT
> +	 * output on 64-bit and last 4 bytes on 32-bit powerpc,
> +	 * which can't disassemble to a valid instruction.
> +	 */

This isn't a bug, but the comment says the trailing bytes "can't
disassemble to a valid instruction", while the changelog for the same
change says the opposite - "it may occasionally decode into a seemingly
valid but incorrect instruction" - which is the case that actually
motivates unconditional truncation rather than tolerating a disasm
failure.

The comment also names the field "dummy_trampoline", whereas the arch code
calls the symbol "dummy_tramp" and the field "dummy_tramp_addr"
(arch/powerpc/net/bpf_jit_comp.c:118), so grepping from the comment does
not lead to the code.

Separately, the second added comment, "Disabled JIT have zero func_lens,
hence underflow", is a sentence fragment that leaves the reader to infer
that the ternary exists to avoid a __u32 wrap when func_lens[i] is 0.

Could this comment use the "dummy_tramp_addr" name from the arch code and
describe the failure the same way the changelog does, so the two do not
read as contradictory?

> +	triple = LLVMGetDefaultTargetTriple();
> +	if (triple) {
> +		if (strstr(triple, "powerpc64") || strstr(triple, "ppc64"))
> +			trunc_len = 8;
> +		else if (strstr(triple, "powerpc") || strstr(triple, "ppc"))
> +			trunc_len = 4;
> +		LLVMDisposeMessage(triple);
> +	}
> +
>  	for (pc = 0, i = 0; i < jited_funcs; ++i) {
> +
>  		fprintf(text_out, "func #%d:\n", i);

[ ... ]

> +
>  		fprintf(text_out, "\n");
>  		pc += func_lens[i];
>  	}

This isn't a bug, but two blank lines are added inside the loop body that
are unrelated to the fix: one immediately after the "for (...) {" opening
brace, and one between the disasm_one_func() call and the following
fprintf(). Neither separates logical blocks - the loop body is six lines -
and no other loop in this file opens with a blank line (compare the two
"while (pc < len)" loops in disasm_one_func(), which start directly with
their first statement).

Are the two new blank lines inside this loop intentional, or could the
hunk stay limited to the truncation change?

> selftest/bpf: Fixing powerpc JIT disassembly failure

This isn't a bug, but the subject uses the prefix "selftest/bpf:"
(singular) where the tree's overwhelmingly dominant prefix for this
directory is "selftests/bpf:" - 1272 commits versus 10 in recent history.
The subject also uses the gerund "Fixing" rather than the imperative mood
the submitting-patches guidance asks for ("Fix ..." / "Skip ...").

Would "selftests/bpf: Skip trailing trampoline address bytes when
disassembling" fit the usual prefix and imperative style for this
directory better?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30981212698
--===============6287462164471471335==--
