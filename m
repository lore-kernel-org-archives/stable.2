Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795177929;
	b=rPs9OykxtC+7OTde/Qvx+MaCadyWitsBhKhGz2isXxXOvHocKDtUnHVY/9J2OHVFX+sl
	 EiW+V3R9CQYoKLI2g+fYcbjmVZxlnJEsoZ7Pu6G5YkheaiXu0BPDUAgtLOdVHO0dMb5DT
	 zwyYwGmMbv7m/KK6/4b/ZfHhF9tRWFkl9m7nnv1BA0FKjYxSnOcqP8hnpusD4QBtmQNrg
	 NDy0w+RCd6/U8TZr6L4jaa6IBYVbMOmDtUCmYiRemhCrKvTjTNj/kwOmt+wJjhGHfJZT+
	 wctBiqd+9KyPfDZ+qz0p5Ott3WRkTdiMJ2xJu7aO9HdCJcsKp2yVRcq2NHZodJgoZdw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IhiE/LJFQy9yi5YvfPy9sO4qIb7WIlTpzeu36y0dLyM=;
	b=qsuxnKmWvJQQfinAtqYPzxWByIAq3x5fBho7azHyZeA06MoT1t9Rvriz8KWuV02qYHKo
	 u2ulXQqrXfcZCCA3pDRXizTUJxRm+Hg3GlfYGjyy5WFs1dABGLO+uq+yKZI5FtqPbPUWb
	 FNY98dV0OPhsYqX9uDbCyClm5v/Hdha140ekDNLwocL3evpQtUkJGP5e15DBnS+paj1Fx
	 8w2W5JYUwFeEeAB+X0jb8303GFpSvOW937SVes1ZpQTFIPRjYrQIk2hBUvr3AgFUqhjCv
	 KaI+luvU1EiTdfOerYP332TrvZdHYEwWOOgew7hi5gdQXwkqg9jSqFlHZStBIT2yWvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QDmwuMBh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.170
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15E3606A333
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 12:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E15E3606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QDmwuMBh
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3adb75e65ecso639521fa.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 04:32:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795177927; cv=none;
        d=google.com; s=arc-20260327;
        b=TFdKQktJZpyRLcmzJYXG2qkaA7nu2NDPhnnU8YGlb42RuZtq7DET41ldnJhVr/AiRV
         k0WqiKH4y0iNXaNIlyxXzAKc5sZyg0hvHWsqcU9KKT0mRErSn7JwvdVT29bOuhHtvHeT
         V0L4Q/etcWgRqyD24HEg/+f2IyiLAl4J352+NDWMJL1XZJ5G9RBDMaUJuK4xv9ZhJ6dc
         xm9xjopYRku7JxRHczESRUV79Ht6+nUp9uj/YBWRC18I9yc9Xa3iHCfBxm3Xp9UPFnMv
         G/hbU5rS/L23fL6bgYTM7igGCO6mAjgQ/TmObURbliybFT1ejB3I9TA7ZFh5XMnEBNIe
         a7Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IhiE/LJFQy9yi5YvfPy9sO4qIb7WIlTpzeu36y0dLyM=;
        fh=LBuwtnCnTPEZhOiG970htoNTWIrvD4gVeLAsu9SQHbg=;
        b=g+wn/XZRQ0J7UDbapTGT2QOB13rUPOPbwxEAuIpVw5jK+kwPxVgokRJg5rXmcLoknK
         ONRVZEooRv2fevDS5XVkWAcZCfVa1FCARS53jyLqqm1S0tm0JnpR9kIucYSzRPgAb0XA
         eJFZr0VLkX5+MWfm+mZzUwdFuo2NUU7qq8pwd0Gd5bhkd2hIrs4IcLNENyXo6SQuWQUG
         TlW84kuqk3hMa66Zl8B0ir40vcQD5/bNGeWXCZak5R4AoyN6HEqJ7Pt5hYqbrBoBY1iP
         wzW/+tj2Y4Zrz1dns1aPpNCLoHbcvPVpE5lmPx57OKeMy6gcDagtNlqhOee55wtCrle5
         2eqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795177927; x=1795782727; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IhiE/LJFQy9yi5YvfPy9sO4qIb7WIlTpzeu36y0dLyM=;
        b=QDmwuMBhSpTqnt8KZvPmDtpegZio09coWGXg5ZEFJ0HQ2BZKSYNl29jzbBxRtoour8
         WjzeD/x0LXOjsGErS/402inLq2+slzulYjk4LJKocMxKvgNz3EhH6NthHh686TY1kHsk
         kYq6H9szHwIVKBE8HaoHmF7dJWayeZ51W8MKNEG+mid6f3petDzIAw1aqnkMTjwCqo2Z
         4P76Z7zUmv5qzbhsa6t8Vc7TyqVVHS/C6G+t7V6nR8PjeWFf4ByO1/OH2KnXSCWfYMzk
         gY8tX+IhAv/GYC7ZTJNJoIp63FCAVaptkfuPj7bHSniq4kogSZymU3auX9w+Hk9Y2ROZ
         oUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795177927; x=1795782727;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IhiE/LJFQy9yi5YvfPy9sO4qIb7WIlTpzeu36y0dLyM=;
        b=VsdYxSvhBkOsVhYRdFQuS6bPHfbr59aTrK9IQs8m2rOZ6tKE3gqPghA93/ZoiOC/vV
         31EWp6RHcJbZ1MLSg06XbrEwzYmB2PQQa6gzRG3mQb12HMukGRVkqoGvz5KvQKocYmos
         e1mRST+0bxOQWNuEalW4UKx7r3dianqquJn7u2X9Pnl/6TAEUg+nYEdjIiEfeU8K5Tds
         VzqZR1wdLy3SEsoVjj6kZxf95jxqNwAjVGnmrroVVHgUtO4kR6zpk7XJ++yY1C0hO4tA
         n4VcGv8j+CPmeS6kJm/ItC/h/M35t841CHDSAiJnQBJyId0iYEvPjqPIun5LVU4mcKE1
         w35A==
X-Forwarded-Encrypted: i=1; AL+hErGKmCSkGfU4rePtYLJ7z2nBMPga4hfscqq4IUQ5h0pl9/NDJacBiO0UdByboTzXq+iOL4UtEps=@vger.kernel.org
X-Gm-Message-State: APuU4Z+nAP5vZihDcXSnxH58CY1vY+F0GqJr6y4Q/kSYcskmsqbipl9B
	7Bs7zxUjc4+nkbM9w/Gmd45kSIYa6Xuwd9JD0dRGYO16dbzCl6JV+eKtVy9adcMGa1F9elBk0By
	M1qTO/px6eUroMK66paUroyuterqYiLPqynqa
X-Gm-Gg: AZFdTZcckwFII7YcjAXBy6n8kPdUQKtEjqjdAukMuFTs/YOIUNh1d5v+M5ApPqD6t4V
	eYjOVzaEoPrztWZnd6N4B3K/9hz2VPSH/ExOQq7nn9CrLzjp8QgElHzwNiGEoyHu1fX+wuwD3Z5
	totT0mqS8/u0BBo5sjFfPO15/Pla4CLFVz6oYKKpY8MHWVAfrzroJWv723FVhIHf1Y15+qbc/V0
	RFL7NTKefflyf66tCWtV3nFLpGdzvRTnrcbJdc3jpuCcqTgMy9k5ve6Dq0uj4GH0ryBF4hD2JjV
	ZlOn8d2QfLpR+0aOqh+ZoDGs405fBJO7PzyURMetR4roQd1x/NRug3ZHEhXKklAs9xyO6vlOe/J
	n2JWHkn/DKSTRrTJHe21CCTMjK4avFKe18Clh0webC28qXQeNYW/3H6yA2C763WwBKZFftg+xx0
	3s/ahufwlcroi2JbpPArWL7m5xdbjT1CaCL4RN8qttQMVF6g3sGYcg6cXlZd5YBTwja4Cmfd24i
	z//rOyUVcU4jEFuX7b8n6Q6dueta+M6TRu7LosYUzVLBVyLw8SpQiQSgc+/nD0Sy/U9jtc5NGtL
	UXF5BZ+FXIAFlIbE3A==
X-Received: by 2002:a05:6512:6313:b0:5c1:ac32:9904 with SMTP id
 2adb3069b0e04-5c1bc80e619mr987431e87.3.1795177926726; Fri, 20 Nov 2026
 04:32:06 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119-fix-schedstats-bindgen-layout-v1-1-0599dd230ffd@gmail.com>
In-Reply-To: <20261119-fix-schedstats-bindgen-layout-v1-1-0599dd230ffd@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 20 Nov 2026 13:31:55 +0100
X-Gm-Features: Aa3M54rcMiGp8tEKzqSGwq9pN9j_ip44fxmLfK1-urL5STB7swv0NRy8cxr5owE
Message-ID: <CANiq72kcDMqswODJ0OqcqecDG+8mVn7Q43v48=ED5d6tsFOWQQ@mail.gmail.com>
Subject: Re: [PATCH] rust: bindgen: Preserve sched_statistics alignment
To: peder.bergan@gmail.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 8:33=E2=80=AFPM Peder Bergan via B4 Relay
<devnull+peder.bergan.gmail.com@kernel.org> wrote:
>
> With CONFIG_SCHEDSTATS disabled, struct sched_statistics is empty but
> still cache-line aligned. Bindgen emits the empty definition without
> that alignment.

Link: https://github.com/rust-lang/rust-bindgen/issues/3549

Most importantly, this is about a bug that happens to be exposed in
bindgen 0.73.2 only, as far as I can see -- could you please confirm?

> In the reported arm64 build, Rust
> Binder reads the wrong pointer via CurrentTask::mm() and rejects mmap()
> with -EINVAL.

Cc'ing the Binder folks.

> Fixes: 313c4281bc9d ("rust: add basic `Task`")

Given this is a `bindgen` bug, this tag should instead be:

Cc: stable@vger.kernel.org # 6.12.x (Rust is pinned in older LTSs)

> Jules Mercier reported the layout mismatch on arm64.

Reported-by: Jules Mercier

(I asked Jules about an email in the issue)

> +# Bindgen drops the alignment of empty structs. Keep the cache-line alig=
nment
> +# of sched_statistics when CONFIG_SCHEDSTATS is disabled.
> +--opaque-type sched_statistics

This seems OK as a temporary workaround, but I would probably write
something like:

    # Bindgen drops the alignment of empty structs and bindgen 0.73.2
does not add
    # explicit padding before over-aligned fields either, thus the
fields that follow
    # get misplaced: https://github.com/rust-lang/rust-bindgen/issues/3549
    # By making these structs opaque, we recover their alignment.

(In addition, it would still be nice to have a debug Kconfig symbol to
enable the layout tests as discussed in the issue, but that is an
independent patch, of course -- I am thinking of gating it under a new
`BINDGEN_VERSION`, plus particular architectures where we can confirm
it is clean, and maybe `!COMPILE_TEST` in the beginning too...).

Thanks!

Cheers,
Miguel
