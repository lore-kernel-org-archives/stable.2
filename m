Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4803B8BCC;
	Mon, 31 Aug 2026 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163956; cv=none; b=G7MWmBTO9H6l6l36xm6WhuCWf+xHHwXspzulvSR+ekwZbk1HuQhp+F1lUGXjuScUhf5oh6DVRpr5hv3kiWnq18IxH6uouLFIuakFiliMdrP2yShhoKT1dm1E9LomTj1W5Hz66/1DFtjFWY7jzRsWGBx65IXSXjqyJBYhEpMTAl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163956; c=relaxed/simple;
	bh=MAT6TUxhMMywJZPHNT9A7YnH/2tW68PMrUwqdl3HSpY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SOVPGq1Dk0rMUu9Z1bjPfXGzAutkIYCIwxqohwzcobAAmbf0ONhvOiJC/Nnqp3rRfP3rFaR/dzkWJcjnWSWbKPeTfzMn/TL00+FIiAeYwJyZT5LNP0aOXTsxygTwWGHShCyC9xdBok/4+6mKxuGG59pJqU3vpYjEyxfRtVt/Q+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3fCH6LZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3fCH6LZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AD81F00A3D;
	Mon, 31 Aug 2026 08:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788163955;
	bh=8YMWtQhoNec0eQMN+uaUDx0asxbEyHNoV6RuG2L3NJc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=e3fCH6LZVXE5Cq9vGwt8R8sacD/D/tPe9blv+x2rbdeMhLwDecp+yoW0W1tRQC1TH
	 /jPtpqBsNZTflkR6dTXU1kmzHw8cjPHrtXxFZHTzQzahQm8FbvyBXvnX/2b6CpH1ST
	 iFP+OfzLZWvlck83pndCtC1eRc0U3Frj4d9J0FWiWOmzjPRgwnFKW7YxHsg8wVfy0v
	 sPsVTrKv7Qg6Ac5w/jO4KaIzzvFemRwf/IDsmC+DAw35BmsEQANazxf+/ipXTbwY6G
	 q18TYKexxlN7rXDHRNb+TDzXv8zQYw6yQcEuA9qeATNsCsmA2ssYUO6wvBpPuP9hyM
	 WyMIlukvVNEaA==
Content-Type: multipart/mixed; boundary="===============0534822206783585426=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <71916017b03ad6e22c093094acae6a356a57f8fd0c3afda3833a20a2db10ec77@mail.kernel.org>
In-Reply-To: <0700c866205c8fa2f861e4b8d64fdf7469cba021.1788154635.git.skb99@linux.ibm.com>
References: <0700c866205c8fa2f861e4b8d64fdf7469cba021.1788154635.git.skb99@linux.ibm.com>
Subject: Re: [PATCH v13 4/8] powerpc/bpf: fix alignment of long branch trampoline address
From: bot+bpf-ci@kernel.org
To: skb99@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,venkat88@linux.ibm.com,yeswanth@linux.ibm.com,skb99@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 08:12:34 +0000 (UTC)

--===============0534822206783585426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 11981d2270a9d..8ca36a933c7ae 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c

[ ... ]

> @@ -49,11 +49,35 @@ asm (
>  "	.popsection				;"
>  );
>
> -void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
> +void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx)
>  {
>  	int ool_stub_idx, long_branch_stub_idx;
> +	int ool_stub_sz;
>
>  	/*
> +	 * Align the mis-aligned dummy_tramp_addr field in the fimage.
> +	 * The alignment NOP must appear before OOL stub, to make
> +	 * ool_stub_idx & long_branch_stub_idx constant from end.
> +	 *
> +	 * The fimage can be non 8-byte aligned, so final alignment depends
> +	 * on start of fimage and the stub's instruction count offset. The
> +	 * OOL stub size is 4 instructions (with CONFIG_PPC_FTRACE_OUT_OF_LINE)
> +	 * or 3 instructions (without) before dummy_tramp_addr.
> +	 *
> +	 * Emit a NOP here if address is not SZL aligned.
> +	 *
> +	 * In pass=0 when image==NULL, conservatively account for space
> +	 * required to accommodate alignment NOP. In case final pass skips
> +	 * emitting alignment NOP, the image buffer have 4 spare bytes and
> +	 * jited_len signifies correct program size.
> +	 */
> +
> +	ool_stub_sz = IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 16 : 12;
> +	if (!image || !IS_ALIGNED((unsigned long)fimage + ctx->idx*4 + ool_stub_sz, SZL))
> +		EMIT(PPC_RAW_NOP());

Can the conditional alignment NOP here mask program length convergence?

The preceding commit (5175364d6174 "powerpc/bpf: fix buffer overflow in
JIT for large BPF programs") added a convergence check:

    if (pass >= CODEGEN_MIN_PASSES && proglen == prev_proglen)
        break;

to bpf_int_jit_compile(). But the alignment decision above forces the
stub block to end at a fixed residue mod 8: the field address (fimage +
ctx->idx*4 + ool_stub_sz) is aligned to SZL, and exactly SZL/4 + 7
instructions follow it. So fimage + proglen is congruent to a constant
mod 8 every pass, meaning proglen can only change in multiples of 8.

When the body shrinks by an odd multiple of 4 bytes between passes, the
NOP can absorb it and keep proglen unchanged. The body can shrink when
an exit goes from out-of-range (emitting a full epilogue) to in-range
(emitting a single branch):

arch/powerpc/net/bpf_jit_comp.c:bpf_jit_emit_exit_insn() {
    if (exit_addr && is_offset_in_branch_range(...)) {
        PPC_JMP(exit_addr);                    // 1 instruction
    } else {
        ...
        bpf_jit_build_epilogue(image, fimage, ctx);  // N instructions
    }
}

The shrink is (N-1)*4 bytes. When N-1 is odd, this is 4 mod 8. The NOP
appearance or disappearance compensates, making proglen identical across
passes even though addrs[] shifted.

Because forward branches use addrs[] from the previous pass (addrs[j]
for target j > current i is computed in the prior pass), those branches
would land (N-1)*4 bytes past the intended target.

The comment at arch/powerpc/net/bpf_jit.h:132-138 documents that the
PowerPC JIT avoids pass-to-pass size changes by padding the short branch
case with a NOP, specifically to prevent this scenario. Does reintroducing
an address-dependent, pass-varying size risk incorrect branches?

(Note: commit 0cd8bd7da278 later in this series reworks the stub layout
and is described as a layout improvement rather than a fix for this commit,
which may provide additional context.)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33368376983
--===============0534822206783585426==--
