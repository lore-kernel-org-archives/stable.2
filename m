Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273291D435F
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784219592; cv=pass; b=ZT4YHpsTgbxDdzFRYnJ6wnfUotTQi8pwvarxr3OD8r5uy8umhuN0qG5A4Dd//VB3ly1CjWXmSp5HWleGxWHAPAoM8/cMsa0RSWsvESbMl9sMnvML23bYrr+akt0lF4pkeLUvBzRJG7dSU4slHVLV8j+vwsaYVni69YPf2+iKRM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784219592; c=relaxed/simple;
	bh=tNGDQpr2wtelauRkyEV1WYWMk9U58mWKPY6Z5KYDsrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krGjr/qlyo/cFLXagwX7tgxoe0nx9nX4jpxXbkg0030MzcfZW63/6OVUsF5VOtsatBpFNBQP0i1FDLcmurcIPrRRGuaMFBYla8O7IbcWT9hgjF/lKq8icJ3Px5M0faZCtsPqT4hFMw/aphY7qY1dRZQnKAwEJkrytRWQfS1FBf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGJZKwc8; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGJZKwc8"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9d290216d0so330314a12.3
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 09:33:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784219586; cv=none;
        d=google.com; s=arc-20260327;
        b=JaUtAk2epeO4eZeDrpHFW1i4ZAYCy3kQH2nV/O1Q8Olcv/QHqwJHWWXBrjdUMCL95B
         43PywOMpi3t09lOZ6YGM8o2nLmzDQUIf/ZL/l0Ucu69YjGLIuidL/YWeOajhhY8vxHmp
         KEyp4gYFusf+BFZy73TY/0BmGtGbDoi5rPlfWONghV1feLlcW3hFMEDMH+f27Mg0B55C
         pv/Nd0kh2KIO47x8TOuyCA2ZO7E+8JQjj80hULHidX0gYnS9w/XCah7cFnIClDWfHCXw
         t5DAqW8SlvhhIc8W4aPmGZJQvd/by5rb2aaPpkYYL+pXZ4yR+duPN3vRNjMgyqEU0xOG
         CiGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t1C5iI6y//WyP3i7clmyabllqAGFWRzFp8nqIFUV6NQ=;
        fh=3RxY87jZiGP83UpRZyLeKmZqCXOsGyr8qHqjiWyNt18=;
        b=EKomIv3ss/O6Cxk0o515MS6VquOuwW4f5CT2cBpV3iRlpDo0DUD6faywRNr0HQ8vAk
         ER4WL6zMddCt3iCoOZigaKSkJVZalj8Fitfv9PXLMX4rD2tH4Wii1prxWSN7qYHsnz9i
         OwUjxK90pd7pSO4k9TRhc6oA5Br53Wj+OY7e7Ld/DVI4TvmlS0rlt6uUF+yVfNCyY5dM
         yAvwPcJC13+QpuivZWih3OaXigE0belMSyOJO/yOc27GX7QRuc2QGVKoOfk5xhKZfVvK
         ms4+ndZfPJwHJoYNnwUeAUbYlYuBOK+rDNld0AWWw+gg/H/J/PwSSVvCXXgJWOcynwqW
         6P1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784219586; x=1784824386; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t1C5iI6y//WyP3i7clmyabllqAGFWRzFp8nqIFUV6NQ=;
        b=dGJZKwc8+Qh/R4dvnGAFK+yhTc330EbPYfh9yBTsbNRAtzo3GO3fg1In0C89Rasjph
         JwMHAgpyhOhQkyrgkqgjagYttBl9vNiL1t0MUS2AuoQ9krKgKQR3a/dkeLHmHc3hbyKI
         7cRsH5YJiVuSpF/duZL6Adw22LK1aL9rGoWaZOfPGsPZ2f030Q5TlIuMvftYt1MBxCJT
         ycFviZQH6Zku/v0P3746enkUHj6PU6y+bMhIxHU2rgfE1E/wyrqCIEfQc5pT46F3UPkb
         xsUV3EKSqZw3p7LYXIO13gDtbYGPg9ZV9sDDTKzz7qL9/U++ydfoNCdtMXjbyHkCNds2
         5eWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784219586; x=1784824386;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t1C5iI6y//WyP3i7clmyabllqAGFWRzFp8nqIFUV6NQ=;
        b=hSV9bxerU22+e3/FGwHCNjNv1UOTZUxYHLjZj/K8WA1QJGycX6v/m55u2ny8sLcXfU
         QujllQ4+BoCWNtzDncQdCdyPDviVp481OfwzJsgIuwm946cyIKxVs4U64v9b1ZSDmPgz
         y4vswVzj6GXSLBLcPe3KcGaeVkw/uUiyREAPz2whXt+qzVUKLErBizRPqZQ4Md4eKIPY
         n+olVLADiq9Wtkd1ZYeKRpScoawGdLazGyOTzGjC0runIoAs38lFvp3oV5seQfw5zq/s
         2hfkE6f09gvLobD9aYyjnxzN5eQ7zZ0FGlEzBjUiSQ/kbVDJ6gMPfoOBfFz8+rzo9Sxo
         F0Aw==
X-Forwarded-Encrypted: i=1; AHgh+Rq2SB4pKDjp3Mf+3iL424wK9B/xcPMCz04AUzRsyBLplRzbit3kgXSVH31Mnp3aztGkezLe3XE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAKmiuiEHFCPTaOgKg3uN75c7ZWg4OjICABXRjsc6rNWZFvzCn
	RC4qcWLRbQsIpivd6x/APHiEanRh/lCu7rlg7tisiUvFcd7A+83v8arX9L84uHZE8NE+3hzSNkK
	gxpn1hvG/9Z3tFB6Wc78Krv4kKdqz/AM=
X-Gm-Gg: AfdE7cmXM/sSeqhqFMU0CS1sU0URRdlhJlGkg7C0nyH64ubu3oSWlr33dYxJyIkkhe9
	egOhAUzeWgGXI7yHMntD7FfODfCuEkg9BCYUHm4v0Y57Tg4dzEIwTyptuGxGBe8NzSh9MEoejFk
	Liup3cS1zZv7kdX3JpPJISeXhYvv+Gw1uf45TxTk//yC7ZRCwuvSPEADSaW/Mf/KeiZYHV/vyYX
	mNyapxmc+EddUvAIXJGGNhMmxgdGPTHPf4LILiti4eAPSBJPkbonlbw1F12rhpTJcMtD8kDmOZZ
	oBDV7HXgpIpz4GZ+Cx9sJjYqFwa6ZMKD9oHygGeE2ILpfv4Uh2xnDIu9a1smMbL7/PtsTROw7fG
	Glw==
X-Received: by 2002:a17:90b:4c02:b0:38e:bfe:81e6 with SMTP id
 98e67ed59e1d1-38e1a9d90f9mr7810297a91.1.1784219585950; Thu, 16 Jul 2026
 09:33:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716-device-trail-semicolon-v1-1-f48e9dcfae15@google.com>
In-Reply-To: <20260716-device-trail-semicolon-v1-1-f48e9dcfae15@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 16 Jul 2026 18:32:51 +0200
X-Gm-Features: AUfX_mxPokx3GaYpNkBp6-lei8Fb7lN_DjgdfGHoMR0h4GDo2j-4L4nqakTib6U
Message-ID: <CANiq72nhRy+LfZbEZt10artNGkpw7x8c9P3yMBrQiLEGv22ncQ@mail.gmail.com>
Subject: Re: [PATCH] rust: device: avoid trailing ; in printing macros
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, driver-core@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 12:22=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> These macros are used like expressions, so they should must not emit a
> semicolon. This is being turned into a hard error in a future release of
> Rust.
>
> error: trailing semicolon in macro used in expression position
>   --> drivers/gpu/nova-core/firmware/fsp.rs:79:34
>    |
> 79 |                 .inspect_err(|_| dev_err!(dev, "FMC firmware missing=
 '{}' section\n", name))
>    |                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^
>    |
>    =3D warning: this was previously accepted by the compiler but is being=
 phased out; it will become a hard error in a future release!
>    =3D note: for more information, see issue #79813 <https://github.com/r=
ust-lang/rust/issues/79813>
>    =3D note: this error originates in the macro `dev_err` (in Nightly bui=
lds, run with -Z macro-backtrace for more info)
>
> Cc: stable@vger.kernel.org
> Fixes: 5c7ca6fa603f ("rust: add `dev_*` print macros.")
> Link: https://github.com/rust-lang/rust/issues/79813
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-fixes` -- thanks everyone!

    [ I was doubly surprised since upstream made it a deny-by-default lint
      a year ago for Rust 1.91.0, and yet we didn't see it; plus I hadn't
      seen this in my CI even yesterday.

      It turns out this just landed into today's nightly (nightly-2026-07-1=
6,
      using upstream commit d0babd8b6):

        Link: https://github.com/rust-lang/rust/pull/159222

      which says:

        "The `semicolon_in_expressions_from_macros` lint previously
         suppressed warnings about non-local macros. This masks
         a lint that will subsequently become a hard error."

      So that explains it. And this is the PR that will make it a hard erro=
r
      at some point in the future:

        Link: https://github.com/rust-lang/rust/pull/159218

      Thus starting with Rust 1.99.0 (expected 2026-10-01), we will be
      seeing the deny-by-default lint above, so clean it up already.

        - Miguel ]

    [ Fixed typo. ]

    Cc: stable@vger.kernel.org # Needed in 6.18.y and later.

Cheers,
Miguel
