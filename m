Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7AC3469E7
	for <stable@vger.kernel.org>; Sat, 30 May 2026 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780144268; cv=pass; b=MC4L0NlBQ4ePCakK468SJKgeElsrCSc8RDtlMvvyKiZRRIIJpfeq5rI7MbtdwO9Q4pcWzcZUZSUoIstYsnq3XycnKdiyzWgHLUolCVCeMofbO8RrkhHste+8rIB1Blu9PjYshHf6rF3RSAHLqfucnzgD+ft4LJuet+O9Gi0ywhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780144268; c=relaxed/simple;
	bh=5V0JB0seYuuGYGJZkHuPFUN1z102gqlQdDHPXmOEZaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mtln+HvcTd0Xm/pgGFvbppY5Y3mjlJkO4ftMPjUsllDemCAuReKMfG0nzAL9ajWxGS3MFOtNsdlDUeKSu4BesY+0Ra0+ejXitIpQDYu4xDZmxsQ738jdnVXZL6BRyr1pzP62036IGiFQaCAVluapOPGXg6Az52sIdFYyTqL3YxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DPC02kbb; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DPC02kbb"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45eeba68948so1871696f8f.1
        for <stable@vger.kernel.org>; Sat, 30 May 2026 05:31:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780144266; cv=none;
        d=google.com; s=arc-20240605;
        b=FSw6esHFGqGc1MpdfnNPr9d6XfuoVT6HWyNcCmKPWOFHM6e3qGqkg2+nZSjvI4d31L
         GowAY77PNmssZUyeJFTuD/lSRHgQomjbPYqIQyO4qv+Wwd8gIU9rO77jean9IxAMCef3
         BXMXwjg6eE3M4W9Ckz59Q3Wgw2icGeIy2hbAF/6yLeN4kXsuhxeTy1UIGgh/pGa0IDeg
         sv7Ky9nRsNdC6Tj7pw26HWZLfjNAMuJu7Z9wJaWvqgvdbw+VnSacuM85R7cTzzEkT6pJ
         YjMn3Q538StOpXF5yUZT+6cMLURYCs7sWRvGkBJfltFz2kxJXs0wv/wUDVUw86GjFleh
         q4RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tsmJTUGqQ4t1Byuf+9POVmmmU068+8j9SHedukFDssw=;
        fh=5c1wMKgflj+i4twoPSOv/lOeO/UJ58mHcNPWfVusPIo=;
        b=b5Vn8szDrIGNOCf/8HWX0O4BrsNL0KfUmhF86bfiCvvVhdJGFHL8vsoaIRuBxrAYQA
         eAIh4TA7wmdsj6yzTssnsSmGZWlBRj314tI0YLFnRuz5hEZDIzFAxJS6EHaSPtn5shDC
         no8FUwp0NWLdfHPLAXBhWYFqAkeC/L/QxiQovcJUEdF5D9E+svlmxIwTvK3sjrSiUu1+
         owGn/7lvDdajJ2Uu0yfqU9aSXWfKLTNLCgPYr36vTGsfsXIzfgN25ziS4fQ9WJR5oXxG
         Ca6hJpcchID8b2P/Nbz0AIC1e+QFFgbLE8wTh5zLJY5ZRiY135P6oQV0NsyRRrQp8ALd
         gvcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780144266; x=1780749066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsmJTUGqQ4t1Byuf+9POVmmmU068+8j9SHedukFDssw=;
        b=DPC02kbbdtl39Ax4OMAaqWdplckovJegTwKheCKwhoLGyoILKcCMGt2s9PTSzu/Zc7
         4CLZJr9138REQWWMtbEibRIPM04l9ZdmCQCrKUfbwKqKxBkWRofldXVgLrUZWrNxWsrl
         NBgTDdNV8m0TfvFgf5Li/4xTJv+JC3/aG4ajfuQDhlTLwczKAuzWgBaBDUs3Jc2d6i53
         bWvkBNrJxpx0bs50oVfklFVGEDMBIzEeMaZABJoMDm3z1jX456ooq8em/vgwB/VJrZXX
         bxILMDjn6kSvZBXJn5Z0xx7FGhGIXtkr9UqzkAqPkl6BKUeBzu+29IvhQSo1VwbdXeGG
         mwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780144266; x=1780749066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tsmJTUGqQ4t1Byuf+9POVmmmU068+8j9SHedukFDssw=;
        b=CDHkjBT8ObuA659sDEEHBjzLQE2CtTCdzV9gAnk2pP2OKZVunMIHkgVI4GsqpODnJF
         cfsNF5dGYAohsoJG/okS3rHTPsMtK2UF2kUHPOVS8HbZ8gtS6of0usAJMzEuKgsRz0tv
         FGMKKLivIS2wVwj4A/nm5oAb93KkWsz6HS9pJMhQKh19M8qybhurXVkSaQongnrvBSJY
         NP4Mgo/lLhjtabOf3X0VEGFwIFRreQYWbNG7W3najhbb0JI2SHjQqw8Aw2irXpO6s3hm
         qmeYs94eZNSUkWpf3v8DH/0sgjaXyA434c8dpFOQIxt8IR+PWzuRpbYobnAQMCL2gnt7
         MvfQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1Ht6LuJacv/Ki49tA+GjXlPKiXJW+UR1tcgNKftZnd1EBiFqTqxLvjYeIP0LNynBL/KPdewY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXOcUp0pZZMiSXgSZtu4v/P+tyTzYGY+wS+e+YEriyPNdnuEe1
	/eALDIQHsaONdMTtH85tuW+t1UDMh0fs/QLoJREd/kTNCM07+VmD3uJe7G0ZQjgAovF/ZrJFatv
	GKjo2DQKRkvpimKnCgirKpaeomNkMVKVdQaHoEahd
X-Gm-Gg: Acq92OGlE7y2/Nn4tvrbhvrUTvvx7x/NnNMSORWZHroRhAI7k/qgiSk43bInKuuo2bj
	amT9O1GMekm+6yfv58+EdJ3P91xpMzYPQveKpGdL43ZcrM4EIbcOMhQciai6I3qDq+o5l0hCnqD
	ULk9X8vAXNfpktbJBWDxeHSxqz6HsFBOCugIrS3alpTPRxWAhnZgAkk3785RnAtMHTKgrKo2GJ0
	90MzxBh2PdeJM+0y7/Ii4i8N6YrCdAyScNGKNqaTePnOMnSlhslA/ysLEg/LjEea373/bSPi4nf
	Kn6r1ECZWB3ISodmquPNuDrCPGFnSC4d7kGUX4FGiQTrZdN7
X-Received: by 2002:a5d:4387:0:b0:453:e3a1:6580 with SMTP id
 ffacd0b85a97d-45ef6b5af04mr4608951f8f.25.1780144265270; Sat, 30 May 2026
 05:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530114925.260754-1-ojeda@kernel.org>
In-Reply-To: <20260530114925.260754-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sat, 30 May 2026 14:30:53 +0200
X-Gm-Features: AVHnY4LccWAtRKrASCOhbKiSp_wJ9_ymIUBVUkcrjZtT13a4agAHvAMnhzm1asI
Message-ID: <CAH5fLgiXzxWD3t09PpiLhqNP_D5L3wX3dtqZC1kqOHupOVednA@mail.gmail.com>
Subject: Re: [PATCH] rust: x86: support Rust >= 1.98.0 target spec
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	Ralf Jung <post@ralfj.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 1:49=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Starting with Rust 1.98.0 (expected 2026-08-20), the target spec will not
> support `x86-softfloat` anymore [1]. Instead, `softfloat` should be used,
> which is an alias. Otherwise, one gets:
>
>     error: error loading target specification: rustc-abi: invalid rustc a=
bi: 'x86-softfloat'. allowed values: 'x86-sse2', 'softfloat' at line 3 colu=
mn 32
>       |
>       =3D help: run `rustc --print target-list` for a list of built-in ta=
rgets
>
> Thus conditionally use one or the other depending on the version.
>
> The alias has existed since Rust 1.95.0 (released 2026-04-16) [2], but
> use the newer version instead to avoid changing how the build works for
> existing compilers, at least until more testing takes place.
>
> Cc: Ralf Jung <post@ralfj.de>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).
> Link: https://github.com/rust-lang/rust/pull/157151 [1]
> Link: https://github.com/rust-lang/rust/pull/151154 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

With UML updated too:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
