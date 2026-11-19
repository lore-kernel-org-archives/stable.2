Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.221.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795078431;
	b=3skjT9OKzkfbQRhgxfYnhfzGpaMxPpR16XA6ycVIc7UmSAIAdO60nL8u4NBYgHNKlO89
	 Nf7QcZX5QrZnLkqGtEcqwvFfvOQqWpmUoZSa1deVDrZ0yCDNhfD2g97/96tdCSPUbOt8O
	 0Tl3H8HkSPGOFF5ED5epqhKjI4nal1DqoKNeL0WyCJ10F82elRT28qEedI2qulRO9KtXB
	 AFqB2OqwS69NkAmVlRRicM3PFPedjaL5OQbQ8wU9dNTlNb49+N6NB5GuRCD17w5c82wzX
	 YQ8RrwoW/uZLu10RVlO8SAU0marzPRskIh+YeIvfE1CfpT2/vQD+2NAoTVzc4uh3wIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795078431;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5QqQji51y3qIauL0ncte9mW5b9mFOt1NrirI6UE5Ag0=;
	b=CHDHIVJWenJKufNwpA1nM2hw4D0vAHfXgWbaC55jJkfKJw8rYYzcoJqNDFeT+irLSfc/
	 EY1w7A99Ow/Kzf2hPzIHI4CRogicxfgKSGWpL1yeNmt0VUdUMXrxcqEcs0A+Oo5TuMiFz
	 tUX3N0cKCLy7RJBzNkv1a5HfoMhacBaF/3h2bfHQOi5wkjPzkzgSx2tteQmN7gIUw1jbk
	 rNudPfVkAEwimd2Sf79R9/RXtuUAJS5Ps9LQK44y17N+BVC4uChDIWINZvVhWVhHvFVsD
	 9LEGCqKFbAy0a6zMidnW8ZkR7DWuD9Yg/XgttLfHzCyu1ol9a4Ev4iCZLQJc8ym0nnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=afU9PVsL;
	arc=fail smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2E8606A320
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E2E8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=afU9PVsL
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so1310786f8f.2
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:53:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795078429; cv=none;
        d=google.com; s=arc-20260327;
        b=OqKExEKdZ2ZTuwaPVofXOSvoB1UUOosjmD266XlhTNAkeRO39ZVEJDug48zpZOCURg
         +uTk5w6xrKggYn9vp4WWwHohbD6Mm9ZJqOEVgm/hb5Qq4AtlkOcLXo4ziJx/0c8GByH9
         WQH+nqXcxuJOZW+Dhe2D6CVC+pyvj3p1XIiILD48hwTPMGBloBI0nWzENhuTiQmO5fkc
         VWjjrhxHgZJGwivZrQDKthDpjOLg3zSE3BjPjkVPbxxCG4oZspowzCbJP+kviSn2IoOo
         OB8NhwYI8ddzieoINDUN4TD7oYCRfsxa6L2I5kjHD2gFjXFZEjoZT2q4e3fM3sPCJgWX
         kcgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5QqQji51y3qIauL0ncte9mW5b9mFOt1NrirI6UE5Ag0=;
        fh=QyvsxIYV1T+OYpgqzAMNSsj1lV5lqP55f1Ntp0TPKII=;
        b=gvX0sgUTSh8q1rxUkJw/px/nbBy9HSDlyyMCQW6jxiutinCkDgL1/qt5edrnitOcY3
         GB/boYOV6l3Ckims1kmc77Malpbr5fjI0Dvukb7XmzvR+31GOtFlQkJkqajYs+ceqMJ7
         CRAThtOuNFTIVyzqbhi+AiIZutPOeDdCyWrqeSDvB2aMHBYzizdik7Px7w+o6YEhNqNA
         cCb4WopwnWuIYUkAe3bfKm3lFZCdbmx6eY4qSAhNYt2gNgVqWgUmoiEJkIVLbNR4CoNt
         XMXsBfnGdfvq7b0EfNIXKjEYKGiObyhZvGBsIXKwsIQUeQoAUt+GJ42liqTy7gtUGm7M
         b8LA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795078429; x=1795683229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5QqQji51y3qIauL0ncte9mW5b9mFOt1NrirI6UE5Ag0=;
        b=afU9PVsLC0NI3xdY8WJ6HfzNJAcK2Tjj2SMafl9/urdCxCRefIGe9zfIq6Yd5P4t2u
         7vEHK7HsNH20AcwGI5DRRuyPStcPF82LrsxyxFtNhg4lKSVJmqZ2vvLYIEKj/YmVXnMe
         f81bCYC8TH0ntLMUhePWVh41ui1Tz74tSpuhEA3ex4ZF5iwc2gtXHlxj3SrS5yHq21BB
         B9F0s9zM8bDOvfvnMm6yE30F+qb8mKFx3qqgcK2DFHWApFj+XPrh+dJQLXLA3mWMXGpK
         kwlBI/hOnf1Afrnz4iCe2v/vWY75AYZomjQUxv520epMl/2x3VqcH6GZrHd7/HcdwOQ2
         uA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795078429; x=1795683229;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5QqQji51y3qIauL0ncte9mW5b9mFOt1NrirI6UE5Ag0=;
        b=EtiV6rg2/rDm33ZKxqtQIejMl5ikwWoLX7F6bW33G3iwdyxL/9HBFbujgwSbDt37ZM
         2Qw7TkAoPVINRjG9tuxlAuGpPOptu4c7GQrpu6+qCrn9/nh1pyyCVuIr226Sx6nwhryp
         iY4mUMblUs0wG9qPYUsrjcRmh57InWB184/QixgFHmUOMq9wPP8Fyo7hx4YE5XBlfnNd
         uNm5FPC5grzNSfeo7MNhW5jP0RsjFsf0rSfEBZyeWdsStBLTwhYUivgjksCgHxDt8cW7
         +CGcUIhxzWQwRAyPo83EBckrlvt0uAOk/Qamx2/r/HP1PNRvZZSqpXcYqRJ5shI28/FY
         tEOw==
X-Forwarded-Encrypted: i=1; AL+hErGEmlG8N0K+Jp3tRR9UPXIaxcbS1M3HOu0hKZq/hBG6Ae7iL73Qz71JTjsDECU4gwVvuOU5+uI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/NoNC9Z9tXW5d5qGo+SQ33ahsdsZYK2EFu8Crjm4j/8vcOI+Zm
	XPmXglrxq7rjDhZLuQYQb8V8vcKqbMw8yNM6SH1p5k3ZiORFf2+6AAu+SkNFAOYv/9fPHVJ723e
	rO5032IWPRDRBxazFFSiuzjvqhLPYJ6ilXyXu3EjU
X-Gm-Gg: AZFdTZei2fCCjweLUeceLb4DlmsI0iJHRXuv4ceZtWiX6qpIUxpqZajPe8WF4B7LQDR
	5wsnMAc7su3W+mIiJt0KiPnyCbpWX3NrTw7ncJkLlVbfdAFjzdItV3Mw6yut0E6390GUOq9oSCc
	YyAvtdwOME9VWZJ+oika8eN74qMaEJZuunxMp05Ni4K0E6FhJPlsDF5UqYkON/TgK9aRJSWIuq/
	euyxrRq3SMBe50m4woVvMeVWOe3P8tRQ4zt/juIYUk7qAjXWTihuAd6bGDIbrz/6rC5wE+QY4AA
	/org0NEabeymau9xL+kmqeiiaThDcAUkuBnXQ/2rJcS1U+iCu4f9zWwjk4SShrOYp1fkQm7ZAue
	brtFnUCMUGAXK9rPgFI22WFtI95crK3bP307ffF37R61n3zQQF+13g/B8tLX2h6SzrsZhEFcmK9
	ceXpnPlfXzo0+B1ftCrVqWWFBcZtJH5y7zwthnZ4fbQTxT
X-Received: by 2002:a05:6000:4023:b0:4a5:af7a:b7ad with SMTP id
 ffacd0b85a97d-4a62e43a3fbmr12154110f8f.0.1795078429032; Thu, 19 Nov 2026
 00:53:49 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-formatter-lifetime-v2-0-e216d86ffb57@gmail.com> <20261117-formatter-lifetime-v2-1-e216d86ffb57@gmail.com>
In-Reply-To: <20261117-formatter-lifetime-v2-1-e216d86ffb57@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 19 Nov 2026 09:53:35 +0100
X-Gm-Features: Aa3M54qMGsiHV31TkfyWs7_IPL9ZgK6ffsi0k08k8zaNIGS3YlymgVZ3YAzTX-w
Message-ID: <CAH5fLgjLuB6ZdVTK=qUUG+NTBrJEY0cDjyNxZzAZX-NOThLVhQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: str: tie Formatter to its backing buffer
To: peder.bergan@gmail.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Georgios Androutsopoulos <georgeandrout13@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 6:57=E2=80=AFPM Peder Bergan via B4 Relay
<devnull+peder.bergan.gmail.com@kernel.org> wrote:
>
> From: Peder Bergan <peder.bergan@gmail.com>
>
> Formatter::new() returns a Formatter whose lifetime is independent of the
> borrow of its backing buffer. Safe code can therefore drop the buffer and
> then write through the formatter, causing a use-after-free.
>
> Tie the buffer borrow to the formatter's lifetime so that the borrow
> checker rejects such callers and prevents overlapping mutable access.
>
> Fixes: 87482d6d9104 ("rust: str: allow `str::Formatter` to format into `&=
mut [u8]`.")
> Cc: stable@vger.kernel.org
> Reported-by: Georgios Androutsopoulos <georgeandrout13@gmail.com>
> Closes: https://github.com/Rust-for-Linux/linux/issues/1261
> Signed-off-by: Peder Bergan <peder.bergan@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
