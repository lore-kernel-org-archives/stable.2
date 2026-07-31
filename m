Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A68037E5DF
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 20:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785531493; cv=pass; b=KWCig356Njx8rfBYd6l9XFBVDI+sTe9uuE0gmbKHYRSJMoBFUfUycy/6tphuFLQhAO2t5gaJ4qfkR31v2XRcZ/xozj/OrlTU0mN7MH18wfGmT5xaqikcLiObsDYDbeSz1P1/xTj9Pv65URtvUovF9wDunMfDbOJxFNvcrVl7is0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785531493; c=relaxed/simple;
	bh=QpxQyRFlAMg3zdNKOHqLP2D+nnCqtp3/FyUT/or79Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4Q63snSQgZelZbfPY8S+Msv8un7xIK6FVyA2cwJnpUiqsO4vN1oQNT6EbR2fLB0OhTDs4ICf0ZsVU4kQuFs3PU2gH6L5HHQiJBsGnOtgRuO1k4NN2N98NeLNkAtB/Z8m3BQTNOOcQpLKytBp7f2jfbOc9tv54UFRAK3O/kLU+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pEpkc2kS; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEpkc2kS"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38ecc48b3deso175759a91.0
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 13:58:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785531490; cv=none;
        d=google.com; s=arc-20260327;
        b=RuP2/y5gg3skaW93vhUK7l4qLa614B0wYNbIGp2Zy3wz/JCD0NwVO4+ueTxGtrBLBb
         gTfrXB1uB242E+knY5mCQHby8WMcLLW8R4Bayd5zWimBpvuTBP+lA03GYngBEjiap4Qd
         ZJfndId//isA4phfFO8Ef2B6FByokCHZX3MQINyFdxwzuYlOwHkjzqjsS2jZ1utgG/BB
         76R3VjGgJjLfz9/Swmy5jqwgfNg4Nm10WONL/S5am7H9XUOupkNZqMkAl3og0B0tpBtr
         ghmgutvx1AI2Do9yLHRghbXk8u4hkZDbRZDoh+5PS6Ha4JfwjIk5gqHB51ji3UM7RA9d
         2VRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t+Teresz2uzFXJRBmUNilJ0KmYvmwmTuIpPexTxP6II=;
        fh=GZ68PoTgHfRQyHb4QFd+ilwECu2O6j7uNOp/4HWZF1A=;
        b=mlYawr7j/nzzH/48eqD8JEwKSR+MioCxEumPajwV0L+OqLxvFfPcorQXPo79oL7rtH
         C4pp2FpTkWmgOy8UGPmnH7YlZRT5LBamoHLwZYQDt3ioMH9l31LfSclmfmPqI0UatUr8
         pXZKU6CXC9/lURRA/RxQkesD6V1P5Hfad/Ef3lgJKD1Yvz84EPC0wfxfQkHFA9dt0Svu
         qKqEOEDBiMS/G1wDfzGwnFqGJhm5+AT+g344TWTqdxDyEVsAiJ012WTNlWw08MPTdvnA
         aHllUz1dtFXwWXjYjm4YODZo4/I1QvUC0Z0nnMDruX2O4XF1o57pCS96sasrfIUHbFgX
         Xx7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785531490; x=1786136290; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t+Teresz2uzFXJRBmUNilJ0KmYvmwmTuIpPexTxP6II=;
        b=pEpkc2kSKf38ETdsRTjzDUD2lwDILslIJA9FBg/GUrxJgj+RKJs9JrcpHbBKiBTTaD
         lc2DCGmitAssbzbH+YpGEV/ZtVFogg+VQpSwdQz+I/WTBWxjAOKt4VjU+btfuOlFzwNo
         6NeF4Apka8zzVS2C/WMrFL0WJeyGeDceNR74bdJz+ADzItFeTFRqhFccR9R3+HcSUvTX
         6FBgtmg0xT/EkVnOonMLhiPbU0EesIDGc0W2YgaR+ZPsFHoi2ILwy8xZFZQV/jy7A3om
         IpXrLr/9Kr1Of8qtw1Rq3WNNVERGjwt2KZCBOqbKYIPvVjvmyAayH+gpRKOTX3ELEudU
         r8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785531490; x=1786136290;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t+Teresz2uzFXJRBmUNilJ0KmYvmwmTuIpPexTxP6II=;
        b=isgQaO3mp1aj75J/PlLGIne3XJKkPuzTQA7u2/NLovTHW7fxZDkzw5/aSZCQfnpmEx
         gQDc2hc/VQ1I2COILstsIxdBrREA/uR5lU0F24gRPOOkqwuctq57UFeX4KcFT/ipL0Bk
         o6VD1BUWuZNx39PjoPCeSefOnLnuB9xVw4PZc29Nx/gDQ1r76VCLKxdjFb3mRI26m54d
         KeAuS+gxKNVKKn8Q9MFkbMZFGNSf+AOgkcuLgXWlp9o0O0YsmA7dJdIY+dxzRHMyO43g
         U8zG/iex29+TpVXIRTlEYmBDOttqfM53I7iNAIP7S1XUdxSmO4Pf0oapEPYV8GEKPZ3l
         sKxQ==
X-Forwarded-Encrypted: i=1; AHgh+RoHF6jNDBbtDLQOqZf6XRQNsdreU3bSw+z6o2hWV2yzuX5X/PWmGWjcP/IeycTycDGr6eGEdck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC04o9pDjnafdjofTvDgzC3HOpFj3cNcELWW5Oy7pIJUmQlMf3
	Mf2jOfE6NWV862ZcMyQNeQFSF1JXV1CX6xE4D9NyteQnCOIddJT+SyI1CEImc2RL/n8P9YK833t
	Iq8BUVCQjSRQhcYJrTDhW+ca7hWQRGng=
X-Gm-Gg: AR+sD138Q25q7Kq8zteZq4/lJeRIW/dWSvHNtP6mcLdnOvidKV2UyI6Awi2kQMRv7c2
	9tQX4JDWsJZ5cnVSW+uUGhOljYK40Q4HKd/1PvMddefUOGLfhTxQI6Hy1F20r6w0d3An6QAWmXF
	0b4MHaw50PgphF8mbkwlEQXeUUx1uzzUzxzoAX8W9KHfU+Mk3VB+dgAw1BLTb7hbHESJxMlk+U+
	gxdyRMctTrjMbaspW0Q69bXYQbyYzi4tdQ1OYHwCZ0J5xCjQpvHt5BTfFKGUfPo8Rb8Pcbjevw0
	tpBZqaxKWdVpjENuiXa2tYxdsjISGZOiGrTbgCKZIX49Ply5ayA03EeBzW/uxdV0wzKKW8L4dU0
	IJuU16aJv4uOsBMvXJhTMOwQehuw9D/0gUyLPzHAbBOsTt8DaS9CzeLQwaan4
X-Received: by 2002:a17:903:38c7:b0:2c9:8287:fd0d with SMTP id
 d9443c01a7336-2d052438c91mr17898875ad.3.1785531489794; Fri, 31 Jul 2026
 13:58:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708211435.402426-1-chang.seok.bae@intel.com>
 <CANiq72=-HjYOoJPd=B+0OYrHuyCO+NpcjRvmmhT_ecVZj8q97Q@mail.gmail.com>
 <b705ef27-e87e-432a-ad1a-f425fe66887f@intel.com> <CANiq72kn8F-pnd-YxBiPN9nr02jagRk4NL-3vyX1tERCQjqNHA@mail.gmail.com>
 <fbbe2b57-19de-4480-b0c6-f44a6007a38f@intel.com>
In-Reply-To: <fbbe2b57-19de-4480-b0c6-f44a6007a38f@intel.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 31 Jul 2026 22:57:56 +0200
X-Gm-Features: AUfX_mzIM4fLMtOWaIr9Pfdp7VGovFZERS0Jgk5EJXX3PQxspAj1Mv0yqU8Ra64
Message-ID: <CANiq72n0K3ULP=7iZhB1hnu6NHEHea66drAN3DKJEG-usTn6QA@mail.gmail.com>
Subject: Re: [PATCH] x86/build/64: Prevent native builds from generating APX instructions
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	Omar Avelar <omar.avelar@intel.com>, stable@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 10:46=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel=
.com> wrote:
>
> Given that one option would be relax the rustc version while tightening
> the backend like:
>
>   Option 1: RUSTC_VERSION >=3D 108800 && RUSTC_LLVM_MAJOR_VERSION >=3D 23
>
> Or, simply like the previous:
>
>   Option2: RUSTC_VERSION >=3D 109301
>
> Since the rustc front does no longer emits the `apxf` attribute starting
> from 1.93. Also, 1.93 requires at least LLVM 21 which already supports AP=
X.

Does it mean it could be the "OR" of those two?

i.e. it sounds like we could avoid having to pick one or the other.

Thanks for double-checking that and doing the analysis, I appreciate
it! Figuring out the precise version gates for this sort of thing is
always informative on its own.

Cheers,
Miguel
