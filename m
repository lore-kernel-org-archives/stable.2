Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134E82D3A75
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 19:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787515024; cv=pass; b=HKddLZUzVc2mGmwLCVmKfT27jq7OgQrVmSkPb7xFAzVVg/m3X5D6ZOMQZw7wjo0QLPYUWSvwvwURKT6sQ1OySQS6sapoBbJtyvEy9W+0XUdBIqPm6BDF4Lk5UlwDmcwH5H7wBUbxyNbBtOfM/6OKDYYOeGST/MD5BxPZsiV7Fek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787515024; c=relaxed/simple;
	bh=e2YoJilRz/kvEUdFVBsJmCEXRlY5jUYdOLcC6Jc4EhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBYdd34HL4z9Tyfe1964hWWZkwri3/NDUSUptYxksSVXQk3RRewYxYFisqBckmK8k7YbMsezzY/mLEJK2k66PAhNIQOfM9z4pjBrcZUmQXGWD9FQFSRWlMpA2hhvBB6oYtItELV3F3Ybs61u6zREqn0nsXhZdxr2bUN9MsyN7zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=busaXdU1; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="busaXdU1"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-384caf7b168so243403a91.1
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 12:57:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787515022; cv=none;
        d=google.com; s=arc-20260327;
        b=O3k9yAkDzUzdLOyPdRB8KkSgWc0l+/yOcqczbK8BMedqoUxcJxgpUhpYEtN9AELCsN
         CxJNj+l+hiGQYZ7/n3Mke1JwgYhd+J7gadr42LTYdD3UgGlfKMyNY76ZbxGT/XD6bo36
         Mn+a41SzpGBTf8RLRAjrJWwXsu5gnqbn+RzFSXYc5GCENZeWytirX7dhgVzhY88hIhwo
         hY2PK+G1rloitjxBvBQ7/jP1I/xWN0rjqm531N2ibi0FuKZ40ZsTJzbBnCe6yWdh2mAe
         Z/hnm0M18XkkAiw7hA4U7iUWfWXf1bL0XKF8Q66YXDmh+WOOGIPpZ2hXl1aGnCFrtOrA
         6YUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ii9pPTvyH4snmu+QWWQwVRnHwnpxENjOJQSzf5Bngrs=;
        fh=15MYDy3sTa4j6+UN6hUM2gmnpHNbqUIulQWsUWx9Jes=;
        b=ff31ECXPqO0F5FBBuc28gPs+KELusE5+s53TzNXwtNbWG//sB6oAvhx4m1wWXEHUMl
         SvplS1E6gA0fgMgnFOmRuuc9eLq9spFJppHX29JOT3X5FaPUVdGLZ3r/CTCQX4ungVAx
         I4W1TRMHqfgIFWaTZuI4JBxhZphHuA8D4nTSMCaZPWInnEsK2C0KiC0ZLb38U7DrJ8gR
         Y6VPGuXs6hKtIB02rcanDadGgFnbrNLspq0wJiE3hZ3fzxMFBNL5YlAgMW+eQ+Bshzcz
         JzvKTsUbl6iQA6waaAcd6qhThdf2iJq6WGl0999Qrfxzeb1zz2Ubpfr7tOf2UHnxAJKL
         gYag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787515022; x=1788119822; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ii9pPTvyH4snmu+QWWQwVRnHwnpxENjOJQSzf5Bngrs=;
        b=busaXdU12amokEa1z7GPjwEqrrGJg3WCxP2rmsrTsQcvYwLDWvOWXXoLGldLwnXkbu
         tztqr2z06nhpXzhKgYWiGi/hqWJGtLcoRDssp9hnqzpkMht78DrGrPqd2k5IB7BSOVG7
         Xu8J8KlFGg5/Pj0x1Ti7Pd58vhxrqNavEhUhETD1wx2fqqHPOdKOiMvKjUSH3XLthcf6
         xSRIhAa/pr8MZ0LZGSkqiB/z3DGvp8slLEjkEXpxel5a1Qt0nLXDslXdWXF/IF/9rVdM
         stYrg8+4xsmdZwJaAIeHYj5VtHpnTb345bS7XJVKZX2ccN20lM/JVwNhxiSARtuzO47l
         HwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787515022; x=1788119822;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ii9pPTvyH4snmu+QWWQwVRnHwnpxENjOJQSzf5Bngrs=;
        b=IzvNnmhgXgRr6Iy84WqZyyCwbe2WAwrgNyFfidsKm7uAkNaDXid/SO2bZUl5RO3fjR
         95ymESWmQj4bn9RCwU8cnhP9HTwkLnMUNWpoOfe8lQZhF0cEKMMGXcsWdKAskaMa1Xb5
         Cxmdp+Cm+OyrfSOevNcHpcqeTralcwgIZRUYxp/6vKL35tJ4JtUbztWIgUMyHKXFiCk5
         PgvrjZ3dUYSpc7x5Nn4rpJT1KP0xzB1ibyqY0xQuHxYkiaQgfUUwjVccUqBo5zivjd9D
         c3aWrzBI91Y4oUjJSxC7MhvW/Zv/l0oOcLx4+lGFoaelqVr5wZh8ZB6qs6H5AwxuOEBp
         h6PQ==
X-Forwarded-Encrypted: i=1; AHgh+RqzGTsfnB664JHZLmnHu3SziFOWRDh58vyeyizr8hk5WbgtpFOqXHViRm3KY/ysZLbs8WNn0qI=@vger.kernel.org
X-Gm-Message-State: AFuF++nAWJl8lolRCkCiRjMFqdeCbdEMctIWPa/nomC4eTrK/AzJg24y
	+5/kunvXh8yW+mAOb0EHwiwoxR3LhD5Miw3Z6956LCFpmiDLhrtiyLRi24jriK0+OynYXNV/4wc
	sLCw/kLzrixwnM9ZYDjHqJ61Sin6SD5X3s39dYdU=
X-Gm-Gg: AR+sD11hNF8hF8UYVahwHPFjP5b82wTms7fpUOyY1QI1UD/Fs8dnjj5pxwvvq2dsgH4
	7Ro0XwtueDRb0ghCBWjdGD0TLnlzxEiGl3kuD/Eo28uPI1eRM5+Fv8EyDnZSQZh7QBVvOrvLykY
	ZHImDTEO7G2yMwr2mNMlFwy6r5ZcU/CZjVvh5FuK2cWB8vqEa0eRGSbrWFvpxAWyWQLnNk5kW5w
	wsDO9crMmvKE5iYrGhyOYTOXvNwn0JvlKpp4F6UqbrCvqY616JNhUECBDHKv1iDGCzTBKo22zYj
	wOnvVgDaAE3oe6N/bNSzztWnTSxJKBYlahi9jOFJVEXuPRwyfFjG4zBwDOW870GRR5iC1REyd7T
	xzdL95Jlk19vWuy2PtZ3iW1aZaFzG0Tv0KI2pThz6LZOmwN6Gwqg8yzoUILgaUo216NvUQqcu
X-Received: by 2002:a17:90b:4a08:b0:38f:57f0:1f51 with SMTP id
 98e67ed59e1d1-395c2f26693mr17048624a91.0.1787515022455; Sun, 23 Aug 2026
 12:57:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823193529.156066-1-ojeda@kernel.org>
In-Reply-To: <20260823193529.156066-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 23 Aug 2026 21:56:49 +0200
X-Gm-Features: AcwNN1V-x1COeybQxjem4PQWjBSL_WsHxSqMe08yuK5ZTBwEtWVtjAsz2JYB8h4
Message-ID: <CANiq72mj854XkMk_urvfcJtuiktMTHMU4kYiE=suF3YKM94_gg@mail.gmail.com>
Subject: Re: [PATCH] rust: kbuild: disambiguate `zerocopy_derive` for `rusttest`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Antoni Boucher <bouanto@zoho.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 9:35=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> +    --extern zerocopy_derive=3D$(objtree)/$(obj)/test/libzerocopy_derive=
.so

This should be:

    ... test/$(libzerocopy_derive_name)

as Sashiko mentions, for the macOS support, of course.

Cheers,
Miguel
