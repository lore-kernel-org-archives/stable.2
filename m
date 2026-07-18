Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202603126BF
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 18:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784399237; cv=pass; b=ael3zUSQwav1I9XR7Ypj7kJcME6fBwpTSrgST/7Xw3yD5qpWIUx4+zBjoBi4CK/UQW9ltPxM0ULOSUdxWwG3Z/sKFY14Mup1zx9n4VDbUSr5a94U26F8iRqL5s8MVxlqTobCRESbI6AY4YDabhhFMMqWY+LTT55f6iFrgsB6TRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784399237; c=relaxed/simple;
	bh=AP41tUx195ng9TgT6uzGyVV7lbuXENWF5xVRR8LXTEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oy5KLLz20IM7qGaSD9Z9PAQ5xcgB14BPtYfgLw3XkJBTrqIO1unSW+He9AE03tl7rr3vibZC3xpHnlJAgaFgAIK8CMGqIRmgynw+98v//PAwQPU2wYs4X1zZOJPYEu618orqC6ayMWGS4fVAvA/N/dHa19XLoUflpyo4O12svbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amMECZXx; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amMECZXx"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3856d4015e0so1394631a91.2
        for <stable@vger.kernel.org>; Sat, 18 Jul 2026 11:27:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784399235; cv=none;
        d=google.com; s=arc-20260327;
        b=kg7qJYeikNITul/HFXIyIdLFZA8kDLRq8paF7Oq2eJ2KiU6Forj/6hcPPcOd9hRDXt
         iRnvcuhei4KZmtffS0GliGtvnmiWJ+33/BHWi1NSwMs6lLVPMck3MyzINkePEHSNX8E2
         PbiHSkC0/Z+6R6ir6Mf3ggnqeBEORmSpVVVq6t6N1HVAgsrKtVnunv5iXPW1veTMfTec
         xZvtqS1YciA4dQW64nlLAJNHt9UTA+hlgmGi5+qNBtRJdvXxJn4E9p+ppYcZMcaXpH/i
         TS1zDe5kqKKfV9652fGd8DCMt3unMW3NNOjhLqjQGaXWLY0xPLGGeVj4ZRFVdbvouSxO
         NJ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VF1UqndvD15BxTbg7z5vo4szg71VyV/aIRdaOO6x9SQ=;
        fh=FjdQb4N10gYp4xXu7JW/z0cu4dyB1aTrG/8OB+RK71A=;
        b=Qi4CU2kv9GGz8BgSGxwcuzXXA2xQmL+DJN44v/xLiU5/UXEF+JFgpr3O0EIcvZJyGE
         qEeL3OQ51adC2t8rLkyntbPw6YE9dSjqH8ETwhkIMaETNx0yon4ywhX8Zqnc7sRNBCuZ
         SZT7bI27VcTtfNHrbT1ou/KTnS/XBaF90M3GhcBY4zUVeWFZwQPjGRyEC9LR5VwyZXUD
         SZElUuYFp7VjfoT1Ga2itCVXWi1ZxO+MOamYaVfSjaBRJBZjVA9fuF2fRU4XjA+ddGzt
         J9LjuiqewNXT7E2Zh0aqvPrBksZoWXyn5fdM1JDz1hKs1XfAnAU1TbwbE4gIWu5IiOeX
         6iLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784399235; x=1785004035; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VF1UqndvD15BxTbg7z5vo4szg71VyV/aIRdaOO6x9SQ=;
        b=amMECZXxDcVI/tDclwfWEv91FERjCewoh7Xun9jiWjXpgvbeX1dsNB8a2RjP7RieJM
         ZQlHu2E1Ff95i2SPMjZPmsbICL2QdSTVeiEJexhYZjQ32QGUYbKi1k7fGDHGmECQtaW0
         9P56H3gCFeuxsNnpindCx45z6d770aIe4NQwOPVPUR5D1OeKXKOuy6CcD8NVUfn4t4Zb
         kg2fMhYVoCQjS7lwLfFEvDjeKWX5isCyxbdxsQprVQzk2c+1UcRs6xvoQke+9QkBM8kE
         JZlmtPYuZsXM0W+v7fvwdXoVKnrAmnCyEnSeGHdaIscl3SawQ8FwNh7347MWklrFJsb/
         pppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784399235; x=1785004035;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VF1UqndvD15BxTbg7z5vo4szg71VyV/aIRdaOO6x9SQ=;
        b=KnW/sjZRVISMyO93KJLyfUGeAIG587DS7QpuYZ2mi8izAh/OBWs3wjZKIDrHFos+2B
         ao1KMikGikvKKsO6xg6tYBmiC/upp6dSAnFuFHqPLIKvWTC17J3aH8LLDe0wjlZBB176
         oIbk+REYQp84cgRKMlnYBEWp1tiZG4AFiaVbEq27zNG/rtu7Mn2oWw9mQuleanY6EFqW
         Mgb5wQPE0g8MCep+LGboAH9rzDQlT+EYGhmU7h685eYOAoc2Sf2oC6HA5AlLYppYOv2f
         sflBe/sH3Wq1gwu26GqkzL9FoibCZBilVg7oZVv+zeevm4O9mY4lE6ZBxehcbwaoyGvS
         7+fQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp7GZkaiibczACtxoYWtc1yf29CFrF5+hSsBzFa401uBDEXfNQ3C0o3BK3I+3OGUSECijyJhB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+jpxW24PH/px60Y/DCZRR/QU7KRwCk3eFYu3D9BIK8ACviQb9
	Fcjeq8OWBfqnQVlAyWIrEH2J188EvxpjjA6rMt0nn+GEzycsYqMhxtCOTYutHpasfc5wx3T2rsV
	wIHfao31Cr2kuwijfM6ZmUWWGo1KTipY=
X-Gm-Gg: AfdE7cnrKrp7I9BZWPrF5TCLAfaj8Jr7D5NuUBWy3TOaICoOCZUXTAmTr9Lnz7vwgQO
	3q+AUNkm8iKH+W2rkMc61nm4bQhIjb8mTqmPm6tNG00pvbJL+0QW3mz25eCugQNTfdmoy9GFtsH
	xD0kM3rApaVlJlZnI09C59Zf0vgKZ0wgnMv9P4vCIt7ltV90O7bWIjscNf8zsM6zFLJriIunO9/
	NO5Vch5C4XAyin6AZ8o51hBaBbae2Wan0ij04c/W818mZoM2rc69zdASD1fyuh8uYqUBJ0cesH7
	2Nt4CDJm8irbXXwx/YEjMJ/gl9YH/98epbXgZ63/wXid9LX0qQadMTsvh/BE+TAt49jkwpVCDAp
	kGA==
X-Received: by 2002:a17:90b:48cc:b0:381:2788:a437 with SMTP id
 98e67ed59e1d1-38e4b45428bmr5637614a91.1.1784399235381; Sat, 18 Jul 2026
 11:27:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718182323.107565-1-ojeda@kernel.org>
In-Reply-To: <20260718182323.107565-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 18 Jul 2026 20:27:02 +0200
X-Gm-Features: AUfX_mwJPjIV2cZCTnoVSTWE_fZLtIswk-O58QgDaLvdnhGdzF4gPg_mWdzIaoU
Message-ID: <CANiq72nLTuv2s71bNBVV85bTbWriiCdhG_O+-=t+1Ubv-sHFJw@mail.gmail.com>
Subject: Re: [PATCH 6.12.y] rust: block: `allow(deprecated)` for
 `fetch_update` for Rust >= 1.99.0
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Boqun Feng <boqun@kernel.org>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2026 at 8:23=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Starting with Rust 1.99.0 (expected 2026-10-01), the
> `Atomic*::fetch_update` method is deprecated, with the compiler suggestin=
g
> the `try_update` alias instead:
>
>     error: use of deprecated method `core::sync::atomic::Atomic::<u64>::f=
etch_update`: renamed to `try_update` for consistency
>        --> rust/kernel/block/mq/request.rs:206:22
>         |
>     206 |     let old =3D target.fetch_update(Ordering::Relaxed, Ordering=
::Relaxed, |x| Some(op(x)));
>         |                      ^^^^^^^^^^^^
>         |
>         =3D note: `-D deprecated` implied by `-D warnings`
>         =3D help: to override `-D warnings` add `#[allow(deprecated)]`
>     help: replace the use of the deprecated method
>         |
>     206 -     let old =3D target.fetch_update(Ordering::Relaxed, Ordering=
::Relaxed, |x| Some(op(x)));
>     206 +     let old =3D target.try_update(Ordering::Relaxed, Ordering::=
Relaxed, |x| Some(op(x)));
>         |
>
> The deprecation was added in Rust 1.95.0 [1], but only triggers starting
> with Rust 1.99.0.
>
> However, we cannot use the alias since our minimum in 6.12.y is Rust
> 1.78.0 -- `try_update` was added in Rust 1.86.0 [2].
>
> Thus just allow the lint.
>
> Cc: Andreas Hindborg <a.hindborg@kernel.org>
> Cc: Boqun Feng <boqun@kernel.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Link: https://github.com/rust-lang/rust/pull/148590 [1]
> Link: https://github.com/rust-lang/rust/pull/133829 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> Warning: this is a 6.12.y-only patch -- I assume you prefer something
> local like this instead of backporting the commit that made this go away
> later with the move to `Refcount`.

Cc'ing stable here in the reply.

Cheers,
Miguel
