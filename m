Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B6E3C3C17
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 08:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792225421; cv=none; b=i9TsiWnZrQT3pwQ2H+tzIMJ5dLzm41eFeg/5dAkzYNG/fuKrHkINYqEWXv3IpEbRkJF7rPhFX4G9wB+FVA6U2rwAZdHlcHH1+5/r0fSoOWBvydhFOPMjB09PgO9tb9jdIGVvy/vrToPNVWm8QjJfP2Qw6xKLhWUrstYM7zLg8VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792225421; c=relaxed/simple;
	bh=y2+e/LTKf+MKGERt11D3l4dQR8nUfwKaXWb2VD6+1LY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZKMBG1gtSuruecrr5R3J+1yOOvtTbf7AgiHxgz1/FFOjQf1n93MAZV+RSv7jVp2eI7h41OHDzDqYzn0spcaLDaCi74w15R5CA7eqoNjYmttUu5yywHO6cHY1XfUxNfxrBaUfaDDlqXso3hec0abPuYoZtuYisCF08VGjiDwGx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxHcIeaA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxHcIeaA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946871F000D2
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 08:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792225419;
	bh=vmhFk4RtQGZxg27YqVubstl52Uhel2A+MIgKqAe73/o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JxHcIeaAWk8DG6BjhvhiE3F4hA6aCn3iNFvbMWdF1UcJiJ2SOa7PSvKNdcDNdiEFw
	 NpxNEURB/faOnYwgiT//iOzBMVlzBpEWDncfcZwNR5dAvhBZaWUa7edvTCc9makof9
	 TQaJNRaKPziMoSzpwbm22G+7lXwihIrSlZG+u8EzWM80NdNNRDIiYgIn7wNJ07OkEH
	 DptlgqpEOB+6ey0sJmCWD3l9+jObbWevBIN+Quj05Afx+AaA5tZ074M41Sb6AVxg+s
	 GxSzI+j9gnAQIkCE1UpGl1WoWYRVE92HEepZdBxmTqhhiFHNcUe0jwdfcXogn0UgJ0
	 mrAReMbuZpuig==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b21cf1a580so630725a12.1
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 01:23:39 -0700 (PDT)
X-Gm-Message-State: AFq9FYJdiCc3dRiIalG7YUnBIEdm8Zvawmgqgkk0GOn2nafIJV5AQfm6
	3BKavMhIVu5y/QG+cIW5heEcHaW4mLJwjjIMbSPjQInjw4xrs05UcRERklAsZstVeKOLm9voWq7
	y7CIk/OcB41M2n2l0lGnzWv9E2OS79R0=
X-Received: by 2002:a05:6402:5192:b0:6af:5b14:78e7 with SMTP id
 4fb4d7f45d1cf-6b3a818b711mr1194022a12.34.1792225418181; Sat, 17 Oct 2026
 01:23:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016180418.4060503-1-sashal@kernel.org>
In-Reply-To: <20261016180418.4060503-1-sashal@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 17 Oct 2026 16:23:27 +0800
X-Gmail-Original-Message-ID: <CAAhV-H44JKoqH4borfXjR--mX5yp8gMJJpuxJqopFdOsEXbvQw@mail.gmail.com>
X-Gm-Features: AclHuK898mAKFrIMp_FpQ3_tqmR-HnEFN5rMIoWhGIyzU3DbhU9TN2A9R75EQcI
Message-ID: <CAAhV-H44JKoqH4borfXjR--mX5yp8gMJJpuxJqopFdOsEXbvQw@mail.gmail.com>
Subject: Re: Patch "LoongArch: BPF: Refactor jump offset calculation in tail
 call" has been added to the 6.6-stable tree
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

On Sat, Oct 17, 2026 at 2:04=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> This is a note to let you know that I've just added the patch titled
>
>     LoongArch: BPF: Refactor jump offset calculation in tail call
>
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      loongarch-bpf-refactor-jump-offset-calculation-in-ta.patch
> and it can be found in the queue-6.6 subdirectory.
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
> commit a0d511d60c584afdc0fb206d070abd1f2d5464af
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
> index f1ad46e233215..e3220af7d26a1 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -205,17 +205,13 @@ bool bpf_jit_supports_kfunc_call(void)
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
> @@ -225,12 +221,12 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, =
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
> @@ -239,6 +235,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, in=
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
> @@ -251,6 +248,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, in=
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
> @@ -264,8 +262,6 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, in=
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
