Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6755F4570C4
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 22:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141170; cv=pass; b=Q+JUSJjm0ODmxWXWpLF4fOi9T48V5n7nPhfOXm3yYjVZPxCc1YeowTvdLLucERB93ai1UTFVv/TyknornZbpiOuxEVMHK4vdl4qWpPGAE4Vni7FX/YfPZZPkMDxkj+P71CwR0Maz4mlNL2DGK6ImCsJedqulEwEfZgRWTXQD1EI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141170; c=relaxed/simple;
	bh=e8Y1Xf7NJBWvn3GcoXqfY0ReAr4Anku3u7aZBDyqicM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scP3BsYjcLB0RINlT9kEGiH5NaU9/jLd3r3UiwJNmLH84YaCleFQPIYiRdbNWhXPFiJkFNlos+4MyEjJWA8Sp2FwYf8/Eczge4evOBb6G6ZVAhcLqQlxveQcAD9eZ9AfJFxmkyUpW54XNslqZIdZyPIVUz3xSTCF/OmHIUXmAC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaX76M3u; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaX76M3u"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d027b7c8easo236335ad.3
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 15:19:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786141169; cv=none;
        d=google.com; s=arc-20260327;
        b=jIOgR8nLobwbkT7VgdZ9aOyfF0rPbt8ibQTtxmYQ6QUh6jhKtw/U3n6bD/AoaQ/m85
         BuMTG8aY6aixLvtozx4xJ/m/oXx0mgoXfpPMY4gmxGPU2YmS4xs6i2opT28lEM/4q5Ko
         mw/HQSoI5B/frOmHl1zYSDoGfUmcCNCrqT1TYWVDgCe3Gwnn3TCgGmGvIUWM6M6Qbe7R
         QMOp//A4B7VdhHbWLEKZ2LRPR+LqyfnefxEJK8N87YoDDpSA4nLRj62ML1N/Rh/mR2Xa
         KLXZczFxT172a5VbKhuE/ea8EYBjPw39baDzrp+6oxS+QVnM6v6S59l5wlz2D8AkTGMF
         yCuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9kg8y3o57QGeppntQHDvu4FgsLPM5YrqCaAU724RNaQ=;
        fh=eoKttCc5ioHsYpmSX0uIUpJ5GqGEE8V1hh4xn7tVo3M=;
        b=gxJV4ONFUQ3ydLTerEFBKX+aXelhSYU7uLLD9hUUV6uCCxfYDHibi1ncENSRcDy3k+
         BBTu2Gti3/veZK8LC8le09xxTUO3/KfY0l9E/jzF/UlXVkS+ObWGsyDues1t6qRe8e8e
         FWYOz/Ck7hx8k7aq5moTB8J3PubkflId+htjMEH8GMTeJHPmark/gwEnonwD+AYCwuwx
         fDHolwqA4tzNs2i3rYsZSk1TmOoc4rEVh21NDdTFAJfTht+I2Agmb+Lkpz6JKETcEfZL
         jyuRaVZHTT/YDpaWMxN0ex27A1+xGn/EThWa82h3XNJxc4MBF/mod8ypT1dx0da2wLlJ
         5sSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786141169; x=1786745969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9kg8y3o57QGeppntQHDvu4FgsLPM5YrqCaAU724RNaQ=;
        b=VaX76M3uV0U7ynjUY6VIWK6Lh5U/jYu4k0l1104e16U7N9vWpql5u/QJlvVyeEVzZ8
         Qse1Do9DmmSDDwEYxynDNyDPP5xEDhL5cVB1EZEn/a545pEDpn1XyHEbn4kLAit5Eiat
         s6voTa/o+nlI/UOyY8i20d/fubia49euLOm7IS1G8YD6mVmvP2QhDWPLQuF8CS72uXiP
         7YNBe7D2vukbEyoSA4Ud65TaF26xGvJWYSOePGhNrirRNvKZ78Tqw2Nzu5EpCnUypjVW
         Oc1hWyi3XdyT/DOjmIlNghGZzDApP2Q/4n2EiVMEmxgPZDkVhImPmFu9tUtedoHP/qdS
         kB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786141169; x=1786745969;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9kg8y3o57QGeppntQHDvu4FgsLPM5YrqCaAU724RNaQ=;
        b=OGFYZ/s5zCS611bEao5we7YNi9TykWVPVaLi3LoGbxVPYt/O4lXl8zEfpU3FcnIgtn
         nq+N7LGJcp4d30xLtbIBIM/vRW0eZuPoHw3VYOJ92UUiMSHfthCoIdPpXhon0Ikg5MqU
         OqtvxmzQyF+6t5agV4q96l+UbXdicNT8JSvf2H9+7tkG5DUhRdRfBatbQM2IPEpQ/REt
         /Te5GnsAr2ciUaiRhPUbEC9ujov+pQka43L58P/m1/pmewvc9DSJElFJynqmN7vwyfIY
         edcABOFJ/wMIQJRz9tyvD6kongrImNjRGe3Tj/zkXJyjGGMv3vxWgbcwW1S0S80ydxOG
         Pz5w==
X-Forwarded-Encrypted: i=1; AHgh+RrPi8kwBhOVQAbJSCujYWbS/ZAiK3ns4XtG9l/dnOjJMmUOn71Zdb9+O798G+OymjiCJOCDDSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKOvIyZ044ORb+wGpKed8zETAbIlXCjUAZxgibb1t7fC4pvkGt
	Jf0lkgmBWnYiRBiD8jjgJ8TAltrIG58OMAK6TSEzw29kA1N2KUcV8TYatGcOFRBvEykLJQo3lzi
	NZtHSLxWbwjS1zc/M0+8lxQ8QMxGm/q0=
X-Gm-Gg: AR+sD10EyBzIqiehk64OJofmiN01eS7y81X10tb6KwWmq/+NYvTtAhx8PIqOxROQWwo
	s/pPhz0EkedrWCq3BKnoOZ7xfMyhmBiZF4hIJJZcjAHcmVx+ljjdleMGZ+c+7X4Eft5Nh6zpI2Z
	rx7BtcZOnX5gj5RDWNFsTDKGkh/8xATH449DrMLVeXpzeVcWkmxAuZKh6uZUWUeiUA1F6KUHBev
	vTHT7FxXHQm82m2dycoax8m5ajHG4FwKflxpJfNxJ50H1GXOxOWHStPkhcg1K7/TJ3SrI5MsB7d
	wskzbyAVM5aUpas0Nai7zNd9BA6j9dyE995eZKZOqMDX1a9MFqLHaCZHZX6fxiZUU+yCY0BK5am
	Ou87xrshbauOvI15/sPNy2ggvkxevfWus/2w0imUDuG66tBqmQOOvT8X4sjFv
X-Received: by 2002:a17:903:2f8f:b0:2ca:d803:5c8f with SMTP id
 d9443c01a7336-2d0ca73a210mr199280125ad.1.1786141168638; Fri, 07 Aug 2026
 15:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807221429.155946-1-ojeda@kernel.org>
In-Reply-To: <20260807221429.155946-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 8 Aug 2026 00:19:13 +0200
X-Gm-Features: AUfX_mwU-H5_dufTVjV8Trje33MyfE-Oane2tYYmAglrqJ8h4ShpzMvOIUP5krs
Message-ID: <CANiq72kz2Ec119ZW2uiu0-RPHr=Zy5-WRA5tSOYk5it6PqpH2g@mail.gmail.com>
Subject: Re: [PATCH] rust: bug: fix `dead_code` warning in `warn_on!`
To: Miguel Ojeda <ojeda@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Linus Walleij <linusw@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	rust-for-linux@vger.kernel.org, Drew Fustini <fustini@kernel.org>, 
	moderated for non-subscribers <linux-arm-kernel@lists.infradead.org>, soc@lists.linux.dev, 
	WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 12:14=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> On arm and loongarch64, or under `CONFIG_BUG=3Dn`, the upcoming SRCU
> abstractions from commit
>
>   59cf3a5bda61 ("rust: sync: add SRCU abstraction")
>
> use `warn_on!`, which in turn warns:
>
>     error: constant `WARN_ON_FLAGS` is never used
>        --> rust/kernel/bug.rs:126:19
>         |
>     126 |               const WARN_ON_FLAGS: u32 =3D $crate::bug::bugflag=
_taint($crate::bindings::TAINT_WARN);
>         |                     ^^^^^^^^^^^^^
>         |
>        ::: rust/kernel/sync/srcu.rs:106:12
>         |
>     106 |           if crate::warn_on!(
>         |  ____________-
>     107 | |             // SAFETY: By the type invariants, `self` contain=
s a valid and pinned `struct srcu_struct`
>     108 | |             // and `srcu_readers_active()` only checks the ac=
tive reader count.
>     109 | |             unsafe { bindings::srcu_readers_active(ptr) }
>     110 | |         ) {
>         | |_________- in this macro invocation
>         |
>         =3D note: `-D dead-code` implied by `-D warnings`
>         =3D help: to override `-D warnings` add `#[allow(dead_code)]`
>         =3D note: this error originates in the macro `crate::warn_on` (in=
 Nightly builds, run with -Z macro-backtrace for more info)
>
> The reason is that `warn_flags!` discards both arguments in those cases,
> and so the `const` becomes unused. And since it is a macro, it went
> unnoticed so far.
>
> Thus fix it by simplifying by removing the `const`.
>
> Cc: stable@vger.kernel.org
> Fixes: dff64b072708 ("rust: Add warn_on macro")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Sorry, I forgot the Cc to Tomonori:

Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>

Cheers,
Miguel
