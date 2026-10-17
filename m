Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B991F3F4128
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792225407; cv=none; b=Kq19TijI6gT8MWp5GHuq9gMvdfOspMeCHxzuUqW76BfxIn6MQ+PBqL3p9emXqH6+MIkcPPmM9qKGqk7GZVWUIsM8pV7WxXH4aPcWhiOqf5oQZPAHKXWETBzp4g/akQugCpTxCv5Ni79d35IPG4UAt7eZf9jo3mGWCEBsw599K0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792225407; c=relaxed/simple;
	bh=B/8PT4AjH4rqvTrp0fFTFPo8EpA/5PLE0aHfyAYek6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dwyYcchZNjKfuvxgVEyBUlq+oxVu7qcUKapQ2Y/ECNAhxfVWd1Zi5tHfUE4ng/98FohZ1E3rBgYZAvI7G7y2Dhn2ms/b+n6j83e9MxtNcPqALkFx/BtS2+8MU8n3FN+vfNRptYUL7uv5fIKczS8dqoktnWTx7adDg5J0HF3aQ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABo4VBp8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABo4VBp8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A61F1F000CE
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 08:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792225405;
	bh=CzWYlYAS4AGuXYGusSpuGOU8ZQW7NemBmNK6vpZWRD8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ABo4VBp8LdHmkhYF0soBjkxk5JGJNFflZus5ddgKJIGeibVURxWGA1Ik93sG28Qpf
	 L/g8m9/AFX/70H7TG6aKnrd86APHwphob9Cwtp1PcKbTuraBj0UOLKAbsGHMyDsNqX
	 0eQQvO+OpSPSkHio1ZRVJ5GuX6eoGrRZAZ4VR48XQ03Oz9P0kwW5hV4IuFboK818aa
	 nmc+Y3kkkhs+8XRYhbhnium8Mg5gPuMxjhJ8lZbqwbIF3yogQNY4i1eayk4aneSfO7
	 MADiFa+Kvayq0DNttvDSQmUOgv9zc7otjd42h9weMPEuBkBLPSmTrKORd2SBTpKT6S
	 dLlA1POuq0baA==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b203527bceso699873a12.0
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 01:23:25 -0700 (PDT)
X-Gm-Message-State: AFq9FYKGb8IewMoRFDLsVKNwaHX0ED6dZg16LsbfOKDtgeRPj4fbC9YZ
	vP7IRBNvOKcvFYUMxI5q3abkKxDc01CMb6+m84vEGGGYwtu6sd2Vt7ZOg8cLyclvXILd2o290rX
	J9zhZVPW6IKFOJMCmhWvVpYo2LfZDe/Q=
X-Received: by 2002:a05:6402:2110:b0:6a9:aabb:5364 with SMTP id
 4fb4d7f45d1cf-6b3a8175ddamr1231513a12.11.1792225403927; Sat, 17 Oct 2026
 01:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016170833.3977982-1-sashal@kernel.org>
In-Reply-To: <20261016170833.3977982-1-sashal@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 17 Oct 2026 16:23:12 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4K-i-zdWB7mkXVujXEhc2G350a1pKXx+q=9Uxx5tHbxg@mail.gmail.com>
X-Gm-Features: AclHuK8n0GCr5b_1Bh7P8v3FENlgYQx8VrecjirPT_wbTraUwPSwmzyN_l0pnuE
Message-ID: <CAAhV-H4K-i-zdWB7mkXVujXEhc2G350a1pKXx+q=9Uxx5tHbxg@mail.gmail.com>
Subject: Re: Patch "LoongArch: BPF: Refactor jump offset calculation in tail
 call" has been added to the 6.12-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, yangtiezhu@loongson.cn, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, WANG Xuerui <kernel@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Sasha,

On Sat, Oct 17, 2026 at 1:08=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> This is a note to let you know that I've just added the patch titled
>
>     LoongArch: BPF: Refactor jump offset calculation in tail call
>
> to the 6.12-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      loongarch-bpf-refactor-jump-offset-calculation-in-ta.patch
> and it can be found in the queue-6.12 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
I think this patch is not necessary for 6.6/6.12 because the commit it
fixes is not in 6.6/6.12.

Tiezhu, what's your opinion?


Huacai

>
>
> commit 0dab95914c7ff9101f5b41b2d549be998370c84a
> Author: Tiezhu Yang <yangtiezhu@loongson.cn>
> Date:   Mon Aug 17 22:07:23 2026 +0800
>
>     LoongArch: BPF: Refactor jump offset calculation in tail call
>
>     [ Upstream commit 37d545d12f21c4d50612ecaebd7ae1e5bf91b2d8 ]
>
>     The old macro-based jmp_offset calculation derives the jump distance
>     from a stale prior-pass code stride, which can lead to wrong branch
>     offsets and soft lockups under extra JIT passes.
>
>     Fix this by calculating the offset directly on the absolute target:
>     "ctx->offset[insn + 1] - ctx->idx".
>
>     To avoid a false 16-bit range check abort during size estimation, add
>     a "ctx->image =3D=3D NULL" guard to inject a safe dummy offset.
>
>     Cc: stable@vger.kernel.org
>     Fixes: cd39d9e6b7e4 ("LoongArch: BPF: Fix jump offset calculation in =
tailcall")
>     Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>     Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index f1aaa4367fc88..4797b0bcc4fd7 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -210,17 +210,13 @@ bool bpf_jit_supports_far_kfunc_call(void)
>
>  static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
>  {
> -       int off, tc_ninsn =3D 0;
> +       int off, jmp_offset;
>         u8 tcc =3D tail_call_reg(ctx);
>         u8 a1 =3D LOONGARCH_GPR_A1;
>         u8 a2 =3D LOONGARCH_GPR_A2;
>         u8 t1 =3D LOONGARCH_GPR_T1;
>         u8 t2 =3D LOONGARCH_GPR_T2;
>         u8 t3 =3D LOONGARCH_GPR_T3;
> -       const int idx0 =3D ctx->idx;
> -
> -#define cur_offset (ctx->idx - idx0)
> -#define jmp_offset (tc_ninsn - (cur_offset))
>
>         /*
>          * a0: &ctx
> @@ -230,12 +226,12 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, =
int insn)
>          * if (index >=3D array->map.max_entries)
>          *       goto out;
>          */
> -       tc_ninsn =3D insn ? ctx->offset[insn+1] - ctx->offset[insn] : ctx=
->offset[0];
>         emit_zext_32(ctx, a2, true);
>
>         off =3D offsetof(struct bpf_array, map.max_entries);
>         emit_insn(ctx, ldwu, t1, a1, off);
>         /* bgeu $a2, $t1, jmp_offset */
> +       jmp_offset =3D ctx->image ? (ctx->offset[insn + 1] - ctx->idx) : =
0;
>         if (emit_tailcall_jmp(ctx, BPF_JGE, a2, t1, jmp_offset) < 0)
>                 goto toofar;
>
> @@ -244,6 +240,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, in=
t insn)
>          *       goto out;
>          */
>         emit_insn(ctx, addid, REG_TCC, tcc, -1);
> +       jmp_offset =3D ctx->image ? (ctx->offset[insn + 1] - ctx->idx) : =
0;
>         if (emit_tailcall_jmp(ctx, BPF_JSLT, REG_TCC, LOONGARCH_GPR_ZERO,=
 jmp_offset) < 0)
>                 goto toofar;
>
> @@ -256,6 +253,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, in=
t insn)
>         off =3D offsetof(struct bpf_array, ptrs);
>         emit_insn(ctx, ldd, t2, t2, off);
>         /* beq $t2, $zero, jmp_offset */
> +       jmp_offset =3D ctx->image ? (ctx->offset[insn + 1] - ctx->idx) : =
0;
>         if (emit_tailcall_jmp(ctx, BPF_JEQ, t2, LOONGARCH_GPR_ZERO, jmp_o=
ffset) < 0)
>                 goto toofar;
>
> @@ -269,8 +267,6 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, in=
t insn)
>  toofar:
>         pr_info_once("tail_call: jump too far\n");
>         return -1;
> -#undef cur_offset
> -#undef jmp_offset
>  }
>
>  static void emit_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx=
)
