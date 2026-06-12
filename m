Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4A4399017
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 06:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781245965; cv=pass; b=GOLQvJ5q/yL9UlUAqtw14WnE5ASq1El8R7WSfHpqnxx0+g087vuT+J0NpWTpDMoi0L1KezbnrATy+WA32BLKrZocgWsKFCwqsmnZoSAS3nxWWhOeIayehfo74EMD93eyaqp5HxaYP9bXCsDT+ShXiOZxC1RrqDbCHF0cuSVgkVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781245965; c=relaxed/simple;
	bh=E70qoRUfGKWHoRfDr/vGHx+xj9G4daC6qsXk61KaDnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exK+MKDyn6iMVGvp3QcVHJPm1lj374k199ZiW+taB+WMWjwcxT39kXZ8qxD7y2l1N14tpmWOiniwgEBmjGr1xqXFssOpGIfj3OT56e23BARHzGhPaDYGZvbWxfNSw6WPtUwotehy0GBUnstvqj4lXlObuHzmtlCNSVC7Fbi35xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8aetRYR; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8aetRYR"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso6907835e9.2
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 23:32:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781245962; cv=none;
        d=google.com; s=arc-20240605;
        b=kPcIuxM1UOD661IzsEY+7y/Zc6LyVGYY/RS7Z1bQcDUBhpF30TTjrbilmH0J5ifm5r
         JAQra8xgvGqJeQrHe9ppgPhc7Nr9p6AEULV3XJW/3zqL9JeKPDm891yhjxGIVxEBkAZJ
         ki+2DKFXvpn4bs1XCunxkvClRc4IMvPPqZ2mXUk7cVk69D6PRlhjsCJt7wOUijGgMMpS
         Pcvax2EvpChJLdJh6TLo8vx+ln2Aq8jPLjRT71/2XfEEWE8DXq1AizfNaFbw8tRgrxs/
         AWDGlnoI0mdy6Lq8eT+FDr/vSgYD0H7+x89uryrsBr4lsqTiUjXn1+AUolbNolneJDHg
         T2Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1CO6Doo//w2RGkJIhLZDU9oQk9kpI1zOxu1zlLLy3gI=;
        fh=Q2D+w7IUnBE4swLVzK4kzARQWzbDA4Ha76yc9HOZ8R4=;
        b=OHv9uog85fZnMNRIwlIoYhJZJpYNDMWRNawDuHbRLnMm56l5wxgzihuqd5pAymiiKd
         j4JqWl4LOGGCLq1bNU8S8opaEZhqdRbqn6kNuge6FtJpDvpbapui67aasAGK+cI/FlXm
         PRgf4jD/zu8BAYkjnThf9ysf97URnGtIJTOhdtWVJ2HC7j2YvP0AYGwda46BI/Cnybe2
         CfTyelu3/Gv3KeseHSMvJM2aTn+omxKxZv73raiiwjSOC5mj88ADXykHxlQjRGlYYFad
         JbB1RxXY7SHzeNG0UnvcHnBitVsUwiwUvnO9VGCOcsBb8BeGmr3Pke243XDzdvzw3vvg
         AM7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781245962; x=1781850762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CO6Doo//w2RGkJIhLZDU9oQk9kpI1zOxu1zlLLy3gI=;
        b=e8aetRYRQwZmtknKmu4v4+nYP6KiEPcT3u7uPP2jMrifEHDi3ShhupYI/IxSHv3shr
         1dJkXYHifLJPIe21NAXm1R+kVzAxqgCJt0wtRJBMbTmvOpt0RL9xEvmIr7zIVgfQT9HR
         aLU9mFOllcrO2VBIYWEjVfKzuWOqhvPdDN88rgXJRtr3NHe5iGKxtYsKTcxv1c2+YO7H
         aLdwPJuT9S7OtJJbNPfGODmU4R9CwTWtHs8tlbpVVBIsiA1UWsm1ek0OHuVzOJ8fjpqc
         +8ieKRcj0mjWWVUtk3CVH98yJ7jyFOOjRuopbtOR5qqD82x+EC0O0JU23Z+oMc6TjcYb
         pR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781245962; x=1781850762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1CO6Doo//w2RGkJIhLZDU9oQk9kpI1zOxu1zlLLy3gI=;
        b=qoojCjeNl1YLYALXEtUKO3KPNgjkDA764KpGwQWWOo/LIM3TwyUKw4sI8jEP41ir8M
         8svPE0tzPWz7NQPSEMGC3gL8EEQzcGzQvWD5ObcyHHRjV/gsWWalxxyo9tqvQ1Jqf+1w
         3MVnJGJMZm0VhrjimePXi0Wueo225ba2raL9+SqKWSiVYj1kHEy2bb7IjG+GMAdOhKkU
         rbCEfL58IuCnLDRZayf2YernvSwzeimDTkI8ZaJZpqdHUniO3qABVxQl/WJr/S3Z9KEI
         p1SLnQHz9Jy6SMsITUDVMsA2J4ptxUDipojMjtkOgH6rkAY/xvQIRTsWm2JGYF6twsUB
         5czA==
X-Forwarded-Encrypted: i=1; AFNElJ9PD04klz0Of2HmBcIfPKIXjQlggjee93hxoqdB0k4WeC3PM1+QFMB/I4uNGFNP6WNRp5Ng6s0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMF4ww91hXXfwdC637rmQj7o46BMHRIqgxy7Qy5BHEk8RkY7z+
	j+CEv99FC2OP7I+B/5YkSIG+TcHV6llxpXId33FDjw1Xwu5HLai7RzeQ+64xv0OPem39vDbpTBR
	B2h4aMrJvt2CuYfLkCxW6/1gpO4WbpGHTivG7MxpYrewG
X-Gm-Gg: Acq92OF/gELILt25W6UUIW98s5gCzppLcD2T019VBwpLrpkZYo6UODFPtUm0bNrw+w3
	u1dwngrMACbVHEUQ322MuIiPZ3phHVjSAbsaYFZskaXYv3zu5If2KXaqjQ5tR4OHZIB/wnOx0TJ
	Pji4CSUmeYAK4NyDmetEglrvLXYefdToRig2mqc6mK3X2fq+a/29tU32YM1dXV3l8rXWefnKNft
	CLr5kUfcPIRxpDtV5PkL8yNvAeYGvbtEWtLfsPLzPZ5gQCJt4HjVmU0MsILoCXMh/4WenV/89yI
	Ndq0
X-Received: by 2002:a05:600c:3b90:b0:490:b629:286c with SMTP id
 5b1f17b1804b1-490ec4c4d5dmr13864405e9.12.1781245961963; Thu, 11 Jun 2026
 23:32:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611160749.391279-1-jt26wzz@gmail.com> <6e70a018efc87ba1334617b2e6c75ca003e7b1345affe15f1b605634a4ebd183@mail.kernel.org>
In-Reply-To: <6e70a018efc87ba1334617b2e6c75ca003e7b1345affe15f1b605634a4ebd183@mail.kernel.org>
From: Zhenzhong Wu <jt26wzz@gmail.com>
Date: Fri, 12 Jun 2026 14:32:30 +0800
X-Gm-Features: AVVi8CezUJQ5dJo2tCsl4YwT6OFMv_yZWKbGu9cEm2eLDv1JPD0X-poujETqbbQ
Message-ID: <CALgi0XntTQpXBPG-znFGohvSMHDmMf93kqz9K6k2dN2rPE_ABA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add helper retval linked scalar
 pruning selftest
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, menglong8.dong@gmail.com, eddyz87@gmail.com, 
	shung-hsi.yu@suse.com, stable@vger.kernel.org, mykolal@fb.com, 
	tamird@kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for taking a look.

I used `r0 +=3D 1` only to shift the helper success value from 0 to
1, so this test is not masked by the verifier's not-equal-zero
refinement. In this reproducer, `r0 +=3D 1` does not enter the internal
BPF_ADD_CONST linked-scalar path.

The helper returns an integer with `R0 id=3D0`, `r0 +=3D 1` keeps
`R0 id=3D0`, and the `r0`/`r7` scalar-id relation is established later
by the `r7 =3D r0` move on the failure path.

The success path skips that move and keeps `r7` independent. The test
is intended to cover pruning between those two different state shapes,
not ADD_CONST delta propagation.

Separately, I don't think the Fixes tag suggested by the bot is
appropriate. I do not have evidence that b0388bafa494 introduced this
issue. I can reproduce the issue on v5.10.258, v5.15.209, v6.1.91 and
v6.6.142. The upstream change that fixes this state shape is the later
linked-scalar precision tracking change:

  4bf79f9be434
  ("bpf: Track equal scalars history on per-instruction level")

More background is in the v2 thread:

  https://lore.kernel.org/r/20260607170959.823755-1-jt26wzz@gmail.com/

BR,
Zhenzhong

On Fri, Jun 12, 2026 at 12:58=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > selftests/bpf: add helper retval linked scalar pruning selftest
> >
> >     Add a verifier runtime test for a branch pattern where a helper ret=
urn
> >     value and a related scalar stay live across the same control-flow
> >     sequence. Rust/Aya-generated eBPF can naturally produce this shape =
when
> >     a match on a helper status keeps data derived before the helper cal=
l
> >     live across the same branches. Such code commonly uses the helper r=
eturn
> >     value in r0, where 0 means success, producing an r0 =3D=3D 0 / r0 !=
=3D 0
> >     branch shape.
> >
> >     The test preserves that branch shape but shifts the success value t=
o 1
> >     before branching. Using r0 =3D=3D 1 / r0 !=3D 1 avoids depending on=
 the
> >     verifier's not-equal-zero refinement, so the test exercises linked
> >     scalar precision and pruning behavior directly instead of being mas=
ked
> >     by zero-specific range refinement.
> >
> >     On affected kernels the verifier can explore an impossible path whe=
re
> >     r0 and r7 are linked by scalar ID, keep the wrong branch, and make =
the
> >     test return 1. With linked scalar precision tracked per instruction=
,
> >     state pruning keeps the real success path, and the test returns 0.
> >
> >     Suggested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> >     Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
>
> This adds a regression test for a verifier state-pruning issue with
> scalars linked by scalar ID, but there is no Fixes: tag.
>
> The test structure (success path keeps r7 independent with id=3D0, failur=
e
> path links r7 to r0) matches the "registers with id=3D0 in cached state v=
s
> linked in current state" pruning scenario that was addressed by changing
> check_scalar_ids() and regsafe() to treat rold->id =3D=3D 0 as independen=
t.
>
> Should this carry:
>
>   Fixes: b0388bafa494 ("bpf: Relax scalar id equivalence for state prunin=
g")
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/273612=
18656
