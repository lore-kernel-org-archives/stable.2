Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCF7371D13
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 10:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001945; cv=pass; b=NtKxcCiEwfsDnmB6a0YHTFeDsxTV21hhKCKT5vFYY2tAlYTSifaPm3593FrkEqx8HWN2CoUuQH+6VlneUlpAJEjmi62DrRB/mY82NsIsTl/+3iOD3HrGlCxhftFylmzHZ9DPERVzDMsD8xf23/dmkYlRq8Cb0uFPkrXchSP2HZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001945; c=relaxed/simple;
	bh=AwPGYYli5QTCCe0SPtucRYCLSpbMWCY+OvxWF+x1R2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJvapy1Z54acH5KSXII704l7qmQrUs9vN63irwp3oir8JxiyuyRXfW2o/eLOtxwwzefu189w1ntL8GRmvnKit17jaWaEPc8jPbWiFfWw5kj/GQOQqUDyf4uGQWzqvhllP4ZzEWfVYF+Kd7cbt/iLW+V4M7zsPzfUeHsTmJk93hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bg0lIrtI; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bg0lIrtI"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490a76757e5so34867855e9.2
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 03:45:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781001943; cv=none;
        d=google.com; s=arc-20240605;
        b=iw/QbICCiiE0kfivZ4dEwLhlzwmkKEo7RB8/O1HFP0rY5uZYR6/ZZQ1SeTz0BGfupy
         0OwGg/ddmCJdOgJ55RL0KSp6jgwvTgDEYT405qavg2/KkEWF6r+8U/++LWAW3meX/Tml
         mZOPMC1GBkBKC78zO+UQshbaGBV7CDigU3xgfH1P8lfZRSXZbMQRRyxlNafd1vohPgi/
         OrrlY53I0zua2jpcdjmJU1u5ryjgln6grbbPyX1IZhlZXr5F3JQHiGVCsN4IkoSR8CEx
         FEXAkydlSx7Cgw3qtUs32lmkG+1IiWGInMhlFBBgR9mAzFpU5W2VqAh5+kzAkMR+ds7G
         1b8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pEro8W74MnxeK0SsaFEfRSb0IJxOqJEfCobL5j4Y024=;
        fh=Sz6D1qLmNDh8sES+ZSLojyOdinWGyh31lO/Qc0N1RJs=;
        b=MY61c8N5LC/MVXEl1YgbARFvASVjdo6pcJP3zvi5SJKDQtkggKCEm9TmiDP5FZ07bk
         cLLtozjgoVyliA3ZUHSzfv01LCYWLoSIdX5bDzsyV6C2uuz4DWtOqXq7ScUb2zve09kc
         uFvgfz8uUgH1aw++q0bGGkrRKU99kHtLXOaF+rYam+KuYpPnk5Q/rMEdNn+mp4pMY/Mp
         IugVMznvr2meSlVxReb+YTninkaMOdAG3uA7KAs6jOTpbaRMediCwHxEXJ70EmW5f7i9
         DBoLUXoGv1lGZeAM/FxH9+/QxFwIrA+T9Qxhxx+pK24mdODYhZ5T+ph8MKyEpwY/Dx3w
         s7dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781001943; x=1781606743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEro8W74MnxeK0SsaFEfRSb0IJxOqJEfCobL5j4Y024=;
        b=Bg0lIrtIOa6oPJ/Ik6drAwiVEEY/sjLZtOX3hqHy2O//tRNtABz/5LmhLAjrD1Tmt6
         inW+lGSS4roBC+sZIEoLbXHIM1jSATRSgF1PPifLgh/82lnMA7j9iy3lomH8kk1wzS5A
         Fodpkcr87V+QTtX0BJUPVFU3HwID6VOdn2WOB23NiLmv4/g/fuxynZaf93yX8ap679+q
         yyNxHYZeUT+b2bjQB+Aq5GXwP2B5Ru7Z5Ks1YjsD7XxURoyMUqfIjyEY3XEyOg1673G/
         gzFWvua3oZ71YSm8jZPEBcdWHjAeQBgIlHntoH9NgOb4E8cK8LUgud0dI4+E5DEvfVI9
         HhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781001943; x=1781606743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pEro8W74MnxeK0SsaFEfRSb0IJxOqJEfCobL5j4Y024=;
        b=q6+1lClTlROoaIkXxsH0tknaAmemzW0v/XwUlM9HdvfaVQrBqbWSC009nSBMqfDDaE
         /wlx32Bg0+fAQo+atQyTPQrhmUyRc8wsQvG+l+FLttE/ID2yVv2W8logxGd3migrzrJN
         egTTOfi8FydJpfdGgeNGJfrg8NivHaU7Ox4EK1NXnkcNZAt9IfTFBG8JgO1GCqxJ9Xx0
         WChoz4VBz5K+sRk3TORW29JkQhGUD1gkCyYo2PVp285geME35VE2jAJKuMkpIegYKBdk
         InVsNRKyfUPA1gXhkwx3pAd+HXLwOTBv8TLfXB6L7dKkVv1L3MYXOPmEXDXkDOJm+bNk
         lX/Q==
X-Forwarded-Encrypted: i=1; AFNElJ9ZFUQp6XGGrG7gaQKOkWzjZTJVLSe3KXo65D/DphTVKee0fd87VZT43BgEhaLa6dZx9QTcC7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMN8gZf8R9bO8QLKiwp6ehOuaLsAb54pQdrk76gmrbzhPeINUv
	T0GxyUrBa03Z1vnLgGM04VTW/LnVe9fZEUKrOhaz+M+hzaHdaNvYYFw9i7vxxnAgpCt8z03C628
	4qZPVSTUG51+4qjIagHlIbf40npVLpNkn9Hze3vQt4JZ7hxRFqRMtkRYG
X-Gm-Gg: Acq92OFByulO6fTyH+aSJ5iPi+7jf6XkZhQ9bVFNUuEQYYKCmeF53GUIuzwZ5w6i0jq
	XJfTSbfWsMXQXGZ5hhCpGHHkQ9IXPcn+oYuE2yTMtiMIwvfESWadN5x1KQr20gNm6IPS/j9c7+W
	Jui4HQQ0yktiypYBuXL+lzabV4Mns9Rh0kjoUkKwX6Yvp3faEw4Uh2xkLRUg2I3V4dm/XXOFvhK
	txiM4WaGAD4MM+TdZ96U0q4kbnS9NSXzRIc8G1orb9yEICc6fZBq5Njt3R3RQwwOEcJfKxQyGf6
	MZF2RB1tI1+duW4T8dxc7OL8ADkae63dAoEmzslH5lrydvK4evSnaJCxyzfpcNsDaKE31YCDWDb
	RKJK2
X-Received: by 2002:a05:600c:5488:b0:490:9d1b:f07f with SMTP id
 5b1f17b1804b1-490c25b1277mr375416095e9.12.1781001942651; Tue, 09 Jun 2026
 03:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609104152.261145-1-ojeda@kernel.org> <20260609104152.261145-2-ojeda@kernel.org>
In-Reply-To: <20260609104152.261145-2-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 9 Jun 2026 12:45:30 +0200
X-Gm-Features: AVVi8Cer4scMdIBrXUgDXbzDusIpIfMzZs4qRkvpYxnZtM7R9UU-ZA3VgPardd4
Message-ID: <CAH5fLgg2QKczybLJYA7D9CAVURRKAzEWWHMLS5gweX0aCcR9AA@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: str: clean unused import for Rust >= 1.98
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 12:42=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Starting with Rust 1.98.0 (expected 2026-08-20), the compiler has changed
> how the resolution algorithm works [1][2] in upstream commit c4d84db5f184
> ("Resolver: Batched import resolution."), and it now spots:
>
>     error: unused import: `flags::*`
>      --> rust/kernel/str.rs:7:9
>       |
>     7 |         flags::*,
>       |         ^^^^^^^^
>       |
>       =3D note: `-D unused-imports` implied by `-D warnings`
>       =3D help: to override `-D warnings` add `#[allow(unused_imports)]`
>
> It happens to not be needed because the `prelude::*` already provides
> the flags.
>
> Thus clean it up.
>
> Cc: stable@vger.kernel.org # Needed in 6.18.y and later (prelude added to=
 `str`).
> Link: https://github.com/rust-lang/rust/pull/145108 [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

I ran into this one too.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
