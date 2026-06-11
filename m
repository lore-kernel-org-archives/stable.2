Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C15723C8C7;
	Thu, 11 Jun 2026 12:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781180312; cv=none; b=PcE/VhuzjRrTfL6lOnNlUd5IqhNHARtWFPrsPRoji9Le+JJYtDauHhUUp3pl0XSl/ddlXGQ+nVOwsU9fCOl7ytGxk4kjcZhkuniuVLsgeK4/OMscm/CMu+7vaLKyAdmLWh9/5XJag2ottTKieRzALKVQLj+lEfcOY9PvpuU1uWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781180312; c=relaxed/simple;
	bh=uZd6o68zFqyX+82j3hPwFSN3yDQRe2yJ7Ue8vc5dM6c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Nv7tKxLKGNkPeaxhpvsWs9Iq+uBYEXPI/hlVmvgBait3w9ZGQm5ndhHqDbN2mmdDewqKjKxa1TnpLBnwSkguma3sX9ab1fzyNVRC10K9g+UQJ7nCrwhr6iJil3y+ZTgm9D9iylTOrFAZhFinqqSej6yymK8W6xWXciGbYSna3j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gh1HRszp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gh1HRszp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589251F00893;
	Thu, 11 Jun 2026 12:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781180310;
	bh=141gI6qHfCWItY/nQuT4+axMxf2+yNx7YkH48PkWfHI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Gh1HRszpNwjIkArB4/fvKDY80JjRE/yZmV8Zw9IsvjQtEfpK6XpxVa+BcSmPFU41y
	 D3YSpNYau8JPs/tKG3wmntbGokNlIhdV7eSXBGyDNgh6Rt3lZT2bgujywhHXM0E3Tc
	 iNjH3IKGjlD4s17PV41igtl02nqUWGkvgEVW8GKNwcIsu/bQ3l4WoAoS5lasEK6ICW
	 8BERJaO1tlfbPRSfRftEMfWIK1ft4FZKu2fex4WtertIEF76dvwKAgEC6K26poXLrV
	 s6L/vUHVutMLnniK8VdVEU6+KcYfEkccJbld8V0wiKRq4hj+TOCqEP1sO9cSgT4naU
	 Qnk7TEz2cGTwg==
Content-Type: multipart/mixed; boundary="===============2293734144057904883=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b3a9887383e78d4ab37879573df3b240c880d206529a6d23e3299e7f56a9df74@mail.kernel.org>
In-Reply-To: <20260611153826.31187-3-adubey@linux.ibm.com>
References: <20260611153826.31187-3-adubey@linux.ibm.com>
Subject: Re: [PATCH v7 2/7] powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 11 Jun 2026 12:18:30 +0000 (UTC)

--===============2293734144057904883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -217,7 +217,8 @@ static inline void bpf_clear_seen_register(struct codegen_context *ctx, int i)
>  void bpf_jit_build_epilogue(u32 *image, u32 *fimage, struct codegen_context *ctx);
>  void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx);
>  void bpf_jit_realloc_regs(struct codegen_context *ctx);
> -int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr);
> +int bpf_jit_emit_exit_insn(u32 *image, u32 *fimage, struct codegen_context *ctx, int tmp_reg,
> +										long exit_addr);
                                                        ^^^^

Does this prototype change break the build for 32-bit configurations?

The function definition in bpf_jit_comp.c and the caller in
bpf_jit_comp64.c were both updated to the new 5-argument signature, but
the caller in arch/powerpc/net/bpf_jit_comp32.c was not updated:

arch/powerpc/net/bpf_jit_comp32.c:bpf_jit_build_body() {
    ...
    case BPF_JMP | BPF_EXIT:
        if (i != flen - 1) {
            ret = bpf_jit_emit_exit_insn(image, ctx, _R0, exit_addr);
            if (ret)
                return ret;
    ...
}

This still passes only 4 arguments to a function now requiring 5, which
will result in a compilation failure with 'too few arguments to function'
when CONFIG_PPC32 is enabled.

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c

[ ... ]

> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -1726,7 +1726,8 @@
>  			 * we'll just fall through to the epilogue.
>  			 */
>  			if (i != flen - 1) {
> -				ret = bpf_jit_emit_exit_insn(image, ctx, tmp1_reg, exit_addr);
> +				ret = bpf_jit_emit_exit_insn(image, fimage, ctx,
> +								tmp1_reg, exit_addr);
>  				if (ret)
>  					return ret;
>  			}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27344891421
--===============2293734144057904883==--
