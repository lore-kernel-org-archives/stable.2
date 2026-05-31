Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891DF283FE6
	for <stable@vger.kernel.org>; Sun, 31 May 2026 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780234362; cv=pass; b=I3AB65v8Lvx+elvwx9EPcFYuHAXDm6DivMlez+xUGfCF9hMxzgpuz4y3La5M1BuSl+KuJ+0ey7T6nz1ScbIfB9N72r97A82QN7ElT6/LtixZ+UUIY+Qj7epkeusbtBee2Wb32fCCSUDPhq8VtCmBkVw0D0Um6MS5RJXPhQzVv9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780234362; c=relaxed/simple;
	bh=qAMyTFiFtTC0eh3lc4F6V3JJiXo41Df+HeqxHIXgYe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BYC/34wcBoFoCLELzJ41GG78ndNIdkK1M3WREl/7W/FU4yQB2PHmO7yk2GfaKqrI1CHcmrrtoqtfFwf4cQMf2Me9dZqU2Zp+jK042A2tX5Dl1tUBg8UG89ZUHC/MO+GfZZvcEdkEPzhHapbDGsGVuyNcZPMGRlyS2bpd07aOS6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7aUXPwf; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7aUXPwf"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-305056ac6cbso98703eec.1
        for <stable@vger.kernel.org>; Sun, 31 May 2026 06:32:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780234361; cv=none;
        d=google.com; s=arc-20240605;
        b=bdGGLI3T+PnOACQA8C9sCRm+2Y9tU7KfwZ/9C/x4lh/itvKXP3Ay/lP7mlmIDdAsHO
         hqJTwmaVTJh87JelaeKddVXhV1Xh+xsvzv7BNX+8IhtZ+plGL0Q7ns0k/GdkoHS1Do5B
         kXbzU+fwJaB26myjGX1+7/R9TZesw2HPG9hI3Y41zo3XHDS83WmJqoNVhP5WHOC44+W6
         YUwFYm67WFsBkbXOZ7BBo5r4OoAyfVjIyoY2Yu5CANc3OQHq9dI7prdhPTGHyKHyvt0T
         jff5g9QzGgdKLs/lxFA81XO7unCB+OmGvp6opiM56RcgrC/jUmX3kTq8/963Rar9sJUt
         BgqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fWh0gdQbkNaUBMeVhYlkCZO1iRuS2+mRH1lNXIa5o8Y=;
        fh=+u+BoGXNlsWaOZU0Klw3KLwJw/5IXdg9AZo1gFXdr08=;
        b=E2W0xM8Cx03rxqW3rAcDsw/6GMX+QwbhVrUfZyCIAIAAobWBq4I8yGctrcqXYuyLrr
         8+7ThQdHyLwG8kz8b0ZV/d35LqvMRHAyJ2dZ4AEXQB6o3kgHy8CQgFwWdDsFCHWFVd9Q
         sPBFYPEWAZmA2wo7R8LgevF6GvtXvmL/7zZfdlYH+y7tzfHxWW3nIlXdfRTgBUlNbDgu
         HAUjw6tgy3oyvoXV2G6WrR4zSKRg4y7N8oS9lRQn1xNsmzPmsD8xTLtFlfckB2p+cjiG
         xR36gQ5SxtxptYHhrmo6TgJ1go7kYVZe3G9zq269BcQNivs3Wn0hTofkHn/d0fpF+qOQ
         +DYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780234361; x=1780839161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWh0gdQbkNaUBMeVhYlkCZO1iRuS2+mRH1lNXIa5o8Y=;
        b=k7aUXPwfVCa+A1xV3xg7R1gPGpSGX0amSwRUkU0yHjlJVFntutJT3oYHxdVAHsduYv
         DbW2TcAOpzvLKD6xQk4WTMZNY2aRxYb7HgWW2dRvPmlKO6FV8+4/onBc2FccypuIq2PP
         bIRLcb50YgQmUXP8GJ/K/i1jVeDYx6NjYnJd3dpg+IVWFF6eZAdt7vb2dx6OmaWW2oO4
         7aX7GpqaOvtuvpiCuZavI1WACiWxI+XHP5JAdHoI01CjyReD8OcDl2Ei5EA3J7sYZIZM
         vzqqO9jPrh5nKvmryLV2saNrIH7as1zWrScNjqWwyAHn0Jl6si+KZgnPJkAAdQ37l2NB
         o9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780234361; x=1780839161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fWh0gdQbkNaUBMeVhYlkCZO1iRuS2+mRH1lNXIa5o8Y=;
        b=iXWukuBhHru3XmH1F/BzoUfOO6tsq7HadstRI8Z7sD5SytirHmc17MVDK0j4Ri79UE
         8XrEUHfR0GoJSOVt0oNedryMCKOFwnGwrDsJNKqKEn1TXm5ydR6PLZO4uhgRffnsL9Gq
         mBvDNux5MeWPHpY+D9KH+sSpFNKhrHMd7AWb7eJ8kbQf8d8vPeI4M+a/AurJmAk1RMyB
         XC3Vg0kDB9BiAhwgwtJq9asKI3oEMSIzVO12yL8WWhvRn5pq9WxiYoHNwRdRygbea3Qi
         znYMVcB+YyaHHR4ptYPL2Uy2SRCotS6mQTuS6qHmRjkXw4+ouIURLwZ/O4Uffb14Y2cl
         dCvA==
X-Forwarded-Encrypted: i=1; AFNElJ/5GbE+C0uj3c07dUu7szdttxHMuqBNcYO3DoWDLqomqX6D0PPxft8tlm2Ug48Z1B+zCpsOnoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzITnaXxaj31zVqdiD8S9jWrYIbjlfEgVbew4oK/t81AC/sbNN8
	p9pZuZEcIywMPaK+kLAoqlwK5VbqierXsYHawTgHFcQaJm9nr9M+NlXeNWYAw2S3MeOHMCLJCVt
	PGZUe2hd/nS6RLzjnZGD9SZ7zIJfSraM=
X-Gm-Gg: Acq92OHSdTkHNx2UEXuuAiMKJd9bS7CZqpSBQECGoRt8CzFCBDy56ZVRwZFaRM6wXq1
	Nx8Km5kppp2G7vsIZuwWvgDIIZjyDEE4KSKYqP32DnpWTpuQYE+AzuHRk8NgLElGB34fi78SHBI
	XMpGGDuPH/S7d9QA3bpi6DBIg/zJ5IBbVI/CS2cWRwVxJ6kZOtQRxi38TsmduxCtuMINj7mJJwC
	4dVtUhQkC4VDk8Hl+QuLYUGQR3Wfq1LndzgM8zMInKuECbq7vWdpnPUUciMw1aRLjq01aNvURVI
	MCZCNiZ6OtfIVBINv0j774h1G3Nu1OvCN/nluFV7ra+lGLnJiTvBzhn/+5RbGdprZ82lY+4bxwn
	WdUhlmqJkOdrHaQ4KlxKUWWRd+tF2b6ZAxw==
X-Received: by 2002:a05:7301:6785:b0:2d3:4252:b13d with SMTP id
 5a478bee46e88-304fa6815a1mr1660153eec.5.1780234360638; Sun, 31 May 2026
 06:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530114925.260754-1-ojeda@kernel.org>
In-Reply-To: <20260530114925.260754-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 31 May 2026 15:32:26 +0200
X-Gm-Features: AVHnY4LkFossGWgF2BUdrWeoDzVI1qLwed4mxEucX-F3jYH0q0QFqR2HJgvbDJ8
Message-ID: <CANiq72nJP0+FED8MRX9_Jz0WX9ZeTekqE8xE2066VGsQPns-QA@mail.gmail.com>
Subject: Re: [PATCH] rust: x86: support Rust >= 1.98.0 target spec
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
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

Applied to `rust-fixes` early so that we start getting testing
tomorrow -- thanks everyone!

Tags still welcome for a day or so.

(I considered `rust-next`, but to simplify testing for ~2 weeks for
those that want to use nightly, I decided to put it in `rust-fixes`
instead.)

Cheers,
Miguel
