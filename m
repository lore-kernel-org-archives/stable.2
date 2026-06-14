Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916D521CFEF
	for <stable@vger.kernel.org>; Sun, 14 Jun 2026 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781422548; cv=pass; b=ozMEEYMJd7y9rfNlYavlqmRDT79IEvKNcoiK2gvZx52dNYQpUSS7wH7Hez7t8TWOtS/7cLVsy0/ecjXQLtrmfep+tQZBokKa1uxakyy5zvZelqQY32IYvQCFX1JFsfxT0keKtE1VZsDlmeTlCyFW2VKUgr3cnTFHhdyb6k8DAJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781422548; c=relaxed/simple;
	bh=jt9vfiaXpX9Ce0DF2iU5CYaSj0yXd2dYdT7MYev5Vs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmHogpi+ZBbXi3dzoGVXy1rRp76Y6pQ1YYRCaxBNx/5+ZNIMgcy/WPjGCw+yTje0AXSL4rC3/lk6oi8JHaiOppUWu8stVmEdUVxzve3WPmksZWq40Z4VBkejWK9O9ZOg7rKQ0BM2knjSOKem9PIWAQWdlycPXo7M+Kz0LkVbseE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZNTexmB; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZNTexmB"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490b7866869so23443515e9.2
        for <stable@vger.kernel.org>; Sun, 14 Jun 2026 00:35:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781422546; cv=none;
        d=google.com; s=arc-20240605;
        b=JT+zQcaM8MXp490fsfiyw8jhXdNfu7PD+25NGBkBGd2Wxs1dQjhSFZeokbe7VXduyd
         DMM5sM2IoBh4P2Nbw0QQDSFREZNnUcBNZ8q7T2ont+mixytMjwETO1oRIViQ7DmsS3gE
         Mnq1xi96oKIjQXkd3MGCjXBCOeSHtUqHzLbdVK8GqQvhPSkzryqli3I0xOhmEi9nn9lz
         GBsB43SY9XMZKkAsGs3dUBBXl7R9KZdcVIikBYcbzQEMax205aD3usvToj/HChsX4Pmf
         DDkeBJ3FYHq5BgBk+HxbhA/85ayl3RXrQC7u28bkvDDYn8bGDLx8B6cKCwn01UOD1j0D
         7+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G+kn/95nppQ4V0BrtS5dxP/rcmqLU2CIc2jCMr5ukIo=;
        fh=/6/L9ZjdT0jwDrfQiO7vBoYQLHDXkBOc6MkMDCSYUpg=;
        b=Dqsu7FzBMyPYPvtmezTaQeWfkjAVzav3KGQA0Jt48TAhEmYHCOEYqih1z+qXJyWJ7t
         ijxmH4Yj/2/BtHelWgceFln9JXjpm/uyzU4zWrGXFvWEficF2AUJ2TtXibXBt2gQn73j
         ysHHQCPkkVhcCq+Vw7mvjypWPKeIQX1GX9FnQW7LATGes1kwelH6yxDLcLqlE2B6RlQd
         gtp1Zyj2vVV2MiBUQt474C3Sz8xUxL2w64sPwiwz45De2VF843mLTZ8RedNvVifWA/MR
         Wm4A04B81yan9LShpF1YI3knynIGgHEw94zr8hrRZ5GAD9KNs499SA98JD1hkQAp5v5p
         U09g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781422546; x=1782027346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+kn/95nppQ4V0BrtS5dxP/rcmqLU2CIc2jCMr5ukIo=;
        b=CZNTexmB+rYB6icWofn1xIyuUHlKAaWKCnsviw/rZ7rZUDBUxySstVxuwPx4TObStd
         U5iXyRBrfZRDQS9DXZfwiWVhxq5+oj++T2ECvMS15sbl3O6UXWC25bmyk76bEU5/kvT+
         DhEdbR2jQG+0rnSGluM5Mjg4qujgNlw35OdIgQsn+5FOhIgEQkrtbZSLPW1cO6fay6By
         rkvQjqOgANLzOGmxSvr10VZZlMxbkoSw4hTdas7B900WhfIAmMKpfBCztEr4XsAkopAA
         aJAoxtFP/kJPUcPdqjMaQJAjMUWDN1+g2SqR68PMwqTNrqcemRDA8Twc0dRgAVchcpTW
         5mGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781422546; x=1782027346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G+kn/95nppQ4V0BrtS5dxP/rcmqLU2CIc2jCMr5ukIo=;
        b=W4g6cM5/zEAi88K2GrG748vHGbJqJDaopOlp+hjhzTLPhUnv2jqWB3H6E3mYhAtT6c
         DhYcwq0xNkWyzG2PAPnVPWq0xz+ov3Q1+KsqAF0XRJtykNo564c5x6L/857OcJHsjFdz
         /tplW+c+aPQRxHL0GY9pYxupAr1oBKZtVIYIfhlOmcP/yvmqOeMSz0zUEINPBU/ur2nb
         qJL9BUdaz4xcELHt9UZuqT2Sm2qKiZsCg060kBl1/XK/l+uxMb1JZpoaBrdfFfvnxHTa
         FQo7uRLSR2GNyqE/MM54nCHNVbuCTXeprocHlvW/tcR5TKKQoI+aiaM1XvdZfe7jDRFN
         gzCA==
X-Forwarded-Encrypted: i=1; AFNElJ8x4Oup2T0i6oSmd9s9lbsc8g4dEezo3vwnpQIUgqWYY6jfbLMYyMbhVUxdG5xoZCBCIbIaIu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuMdKhTJmz817fFqjKZQhH7MQNfYDoVTwvaCBg6ykfLhE/f0q9
	bL02oLG56PozxFFCc8pdTXUk3sqB6pxKsYrzwpJJLFYpyYvJC39+qgvwqjpQGeZdANPHrYlXkq1
	zmCBUjpuQILpyOhYa5V+BpbjaTFvVdxU=
X-Gm-Gg: Acq92OGzZ+8Dnl+qS5si3pmayLpyGRNfUkd+dQYYWB/0pltp4fNstZ7bvq97vPCk+Nq
	bK3Gy6ERPzsiCDhGfGKc0oymFjMwJPqefvWvdJHEAquRi0qaqxRpVu6Dvfe4FKoUuJabbiI8sXc
	rxDI37BZwIcEn/y6GzIRBk4SepBXxkwbIhsAVWvweyzuxXK6EBYSZLciKpbfoj8qVArQtmhRLGK
	pB3sDLd4ckgSXAr27L8Czvy9cACAFwT/AjyFYqmHA6DKerNiVJJcczkr1M+eVj9zOXNnyN7Mi7y
	LW075jM/
X-Received: by 2002:a05:600c:820c:b0:489:5022:39a4 with SMTP id
 5b1f17b1804b1-490ec4d652amr112488235e9.9.1781422545558; Sun, 14 Jun 2026
 00:35:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611160749.391279-1-jt26wzz@gmail.com> <DJ6DMGTPWXJN.1YKSBHULQ1PB9@gmail.com>
 <aivZ9jYGw6QRxLQQ@u94a> <DJ78FEGKX5S8.1H2M4C8415L98@gmail.com>
In-Reply-To: <DJ78FEGKX5S8.1H2M4C8415L98@gmail.com>
From: Zhenzhong Wu <jt26wzz@gmail.com>
Date: Sun, 14 Jun 2026 15:35:33 +0800
X-Gm-Features: AVVi8CeMd-vQB5-GRBpTKGXkjEefh5p3w8xHUU3WFVRuMmsTgKn_YIcq_b-BA8s
Message-ID: <CALgi0XmXX_hBkxZRv8TgxJuoH8QHSBMyM4D3Z90FZGHzs0-s7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add helper retval linked scalar
 pruning selftest
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, menglong8.dong@gmail.com, 
	eddyz87@gmail.com, stable@vger.kernel.org, mykolal@fb.com, tamird@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Let me add one more data point beyond Shung-Hsi's explanation.

I first tried running the current bpf-next verifier_scalar_ids tests on
a 6.6.y kernel as a rough filter. I then realized that the result was
not a clean comparison, because many of those tests validate verifier
log strings through __msg(), and verifier logs are not stable across
kernel versions. So I did not use the pass/fail result as evidence; I
only used it to pick the closest existing tests for source-level review.

The closest candidates I looked at were:

  precision_two_ids
  linked_regs_broken_link_2
  linked_regs_too_many_regs
  two_nil_old_ids_one_cur_id
  linked_regs_and_subreg_def

Some of them are pruning-related and some cover linked-register
precision, but I still do not see one that covers the same
helper-status/r7 conditional-link pruning scenario as this selftest.

So my current understanding is that the selftest adds distinct coverage.
If this still does not address the concern, I am fine with dropping this
selftest patch.

On Sat, Jun 13, 2026 at 1:04=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri Jun 12, 2026 at 3:18 AM PDT, Shung-Hsi Yu wrote:
> > On Thu, Jun 11, 2026 at 09:55:55AM -0700, Alexei Starovoitov wrote:
> >> On Thu Jun 11, 2026 at 9:07 AM PDT, Zhenzhong Wu wrote:
> >> > Add a verifier runtime test for a branch pattern where a helper retu=
rn
> >> > value and a related scalar stay live across the same control-flow
> >> > sequence. Rust/Aya-generated eBPF can naturally produce this shape w=
hen
> >> > a match on a helper status keeps data derived before the helper call
> >> > live across the same branches. Such code commonly uses the helper re=
turn
> >> > value in r0, where 0 means success, producing an r0 =3D=3D 0 / r0 !=
=3D 0
> >> > branch shape.
> > [...]
> >> > +SEC("tc")
> >> > +__description("helper retval linked scalar pruning")
> >> > +__success __retval(0)
> >> > +__naked void helper_retval_linked_scalar_pruning(void)
> >> > +{
> >> > +  asm volatile (
> >> > +  "r7 =3D *(u32 *)(r1 + %[__sk_buff_data_end]);"
> >> > +  "r5 =3D *(u32 *)(r1 + %[__sk_buff_data]);"
> >> > +  "r7 -=3D r5;"
> >> > +  "r2 =3D 0;"
> >> > +  "r3 =3D r10;"
> >> > +  "r3 +=3D -8;"
> >> > +  "r4 =3D 1;"
> >> > +  "call %[bpf_skb_load_bytes];"
> >> > +  "r0 +=3D 1;"
> >> > +  "r6 =3D 1;"
> >> > +  /* success path keeps r7 independent; failure path links r7 to r0=
. */
> >> > +  "if r0 =3D=3D 1 goto l0_%=3D;"
> >>
> >> this exercises linked registers with BPF_ADD_CONST logic.
> >> We already have such tests. Why do we need this one?
> >> How is it different?
> >
> > BPF_ADD_CONST wasn't what was meant to be tested.
> >
> > The main logic is r7.id =3D=3D r0.id only happens on "if r0 =3D=3D 1 go=
to l0_%=3D"
> > fall through, and does not have such link otherwise. I only check tests
> > added in commit c0087d59e504 ("selftests/bpf: tests for per-insn
> > sync_linked_regs() precision tracking"), but it doesn't seem like such
> > conditional linking was tested.
> >
> > The other rational is that this seem like a common pattern that is
> > genereated from Rust-based BPF program.
> >
> >> > +  /* success path keeps r7 independent; failure path links r7 to r0=
. */
> >> > +  "if r0 =3D=3D 1 goto l0_%=3D;"
> >> > +  "r7 =3D r0;"
> >          ^^^^^^^ conditional scalar linking
>
> Fine, it's a regular register linking without BPF_ADD_CONST.
> Still the question remains. I believe:
> "We already have such tests. Why do we need this one? How is it different=
?"
>
