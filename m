Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA332D594F
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786787259; cv=pass; b=khHSdBEyJWTEhaxnhkOO9Eq2gAQpaSZbS5WiStNW81tIr5SpY6IpESdIAxI94NRUahZIyzxeqpY81vj+HaDleNdKxOZXv02W7+aCrWLWEkeQjHy1HVoqBKc7x7QgNT1cfO7MptYEQrVgXDiALVBx817ajS+LdkvuZ3fqveEA1UI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786787259; c=relaxed/simple;
	bh=A10tEUAy0J/eJt/6NCDSD2pQewscaevQo9UVF21SsrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i80TAFs9kmn2WiM3g9LonmreGnp+/pE2luEYEH01ZYO39Q5OTRbB9FpRBCo4hLceW0RdgrzbFslB9GL1P8AexlAMLQixMK3uKga4Qo42gtigh3zH2eqxfUvPHWwktwvIZ2rae7sqiqBJfpcoJQQdXBFdp+YoQJMPoFhNGuAEpyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTtyWapz; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTtyWapz"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d027b7c8easo3733355ad.3
        for <stable@vger.kernel.org>; Sat, 15 Aug 2026 02:47:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786787257; cv=none;
        d=google.com; s=arc-20260327;
        b=X0170siu7iUa4YXFhSG6EOz7jkD0B4xc501pEmLCVNTvVby6KltbRSQ0nemieHIgqR
         Q6jBMGdRf3Vl/bppn8wbPRMxYg0gYv/EcB6ASqM//n3ujN1n0CKHnoj60MCVvmB9P72F
         sg/XUeriV57AlZq0pUNif+JTN+bWnzJbEUEs7Laz0cY27tePvJ83G+gGHv7JMUTxIkbN
         xcBWuUCOawpvfxd5ls1WeBo2E5jiO1NbW64Oy7NdURTyR5fvgUG4y5WOjZa9Mg5uUNFk
         3tQNjw3htAet4AqZUap2QMy1DdBstibp3LDYquNbO3TvQ1SsJfFBDAkt/Hku7tcltNmP
         u//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cSzW5v6LopkgVYsyHDzCvEaqWdekzkzFKvdIf0+cXAE=;
        fh=7yWPyWL87qZXjYftgvXrMq3blw35DMO2qgIgxM1PJqg=;
        b=qntWmoHiy+WDgAUeLxf6wmLT5GGNe/bY2bvestWPONr6tDuMkaeoQyKq12NsWUpOS1
         JxdQcWuv6YU3Ct6hpwXiz2BXjBk7DrtEyTek9I1JzzwBYIAHdxM0yhbC++K6IRLWVLkR
         SaA/8WPf3b0NxgwEa9P0r3N8N5oVlvIVdbaXrk05KWieIHgHMyo9smGRmIjSnGPx32VY
         smyFjPHrl4sZmY1ss5H2oWuiqcJaiGkaeso/VSHEsVodqmlh4peUr7SkQQs0WL6GKwYA
         yqw01MhH0wiUyP59Pg6stFfxQJN+AeRRjZxFuwBq4FthbNsS8dNXFA7eCF6gJykbNobd
         e7WQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786787257; x=1787392057; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cSzW5v6LopkgVYsyHDzCvEaqWdekzkzFKvdIf0+cXAE=;
        b=GTtyWapz826r+DOw1Xkb8SZ7EUXxgLMju5P6MQNvubBW+gYQOYQtpzXbbDy6LYQzyE
         U9DiUYypGgG0Pv/afJVmzY44DNCoBQ1IhjljYAmWNOhd/9A1xxQ5wcwDXomrm9y0/bTm
         I+YZTNvlxPUdNfpWf+D0Fa2Pu+WMF1imEcvdaGgi3yzo9U1cneVf43KoSo2wVYsqjc87
         xRUnsGFShhLbIs2lGBF0pBnT1IyYqil+hrnBb67Wf86iEo0X5+rGKDiHhnNLy4S+pv3o
         YOHcdmKSO/vi1im7qI+FCTww2UDG66N5VLmymXimvlV4gLc0bqqgdy/JoIDankeBOaoD
         gF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786787257; x=1787392057;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cSzW5v6LopkgVYsyHDzCvEaqWdekzkzFKvdIf0+cXAE=;
        b=oTPaZ3akHvCNtv/JP73+S+ERq6cAItEVokjiwfAOZVga2mvPqAbbiauUchBLrbINc2
         ibgPx+Zr/3a7bjRPnd6FC0Xc9kNe9dmbc04eADPwfLs+ZjTClfX3LXvFX+Ipdneope9U
         xk68lfVZJhLgxxNXGDwqxx//xR8j5jGi0PS0/oC5oGAC02SGpCu50lW8LYwZzqJQUgs4
         tC2A9RaQ9/kt0jLbHGd4rMJi/hcqnuWvmmFU3sXmI78mhsGM+6wolDcrh5CiYZBr53RR
         nqYTEC29RkgkkJ34+Gn6pg+UZD2dmIDs0qaFLkBDBI3kYWen/b9o4e5P3thJHutGcZK1
         n8xw==
X-Forwarded-Encrypted: i=1; AHgh+RpoalttN6NYgXfrPOoILzvFD9SPQIuSoAsH/lSAPPTR2CtMwuZZIiQBRYdfmp8tevPyatzr5wY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNG7xstBYpc2i/aImIdNL1tvLzVt7AvgCdEPy5VPUWZURL3u2T
	8jA+iHaBNj+etjwPLQx4m6mHEUzlq8h61foI4bJCqgOroPABro0Mw5X9hS2PZPucrwOFf0zkFIM
	egKikPwWj/TZFNsfrhX8hC5LIbj8uAiY=
X-Gm-Gg: AR+sD12QbxoVh67mVMlnfD7DroVQsV8OMSRf6FEZar630on4KeYDM/B46XOlEoGQwUc
	tWB/4/MxEwC6URCbMAGFr46dFtyH7/ByZzRWOEgLQ/dv5bF4hwLj1c1OcKnZY5ZptFlqiOwEwU4
	LLWvJSYf+/6WRxPBSuz01OV1ZMVWPQDB2OHkqelHRm2dEzw3MQaq8pgfift06vLlHKa2KrZ0hAm
	69b4xWUY0j0jBi5GQZXqfiq1/zC4+TqpfdSq/lTxqZqDFr0xdGfffS13PJF/aZeL+/4ml/rA4qg
	QhRQqgF0oags6SHZR4SoPdz8/8B4ghMKxt1spZBeEL2TNLLZNUHjWUFKXUP+cuYwnM3MHCddPPJ
	LdShjteIv30RsZ5F3KL33bpzcSnsopZnfWzvE3npHCrky/NFU8k46aTCJ1WjkLa3toSFpcMXZ
X-Received: by 2002:a17:903:1b2b:b0:2ca:de3:15eb with SMTP id
 d9443c01a7336-2d3b0739429mr95810945ad.0.1786787257496; Sat, 15 Aug 2026
 02:47:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815-fix-rust-bounded-from-bool-submit-v1-1-882227bf40ba@younes.io>
In-Reply-To: <20260815-fix-rust-bounded-from-bool-submit-v1-1-882227bf40ba@younes.io>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 15 Aug 2026 11:47:25 +0200
X-Gm-Features: AcwNN1Vyzam60v46TuT2IRWTGvdbWAku89D1Z-Sv9_ewh6l1xj9Ps99KHfoQpLc
Message-ID: <CANiq72kAkDeyqPKHHMT3gRNyC35R+934jNNQOKKytMpmwPwLCg@mail.gmail.com>
Subject: Re: [PATCH] rust: num: reject bool conversion to signed one-bit Bounded
To: git@younes.io
Cc: Alexandre Courbot <acourbot@nvidia.com>, Yury Norov <yury.norov@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2026 at 10:07=E2=80=AFAM Younes Akhouayri via B4 Relay
<devnull+git.younes.io@kernel.org> wrote:
>
> +// `N >=3D 2` cannot be expressed as a trait bound without `generic_cons=
t_exprs`, so enumerate every
> +// width supported by the current `Integer` implementations.
> +impl_signed_bool_fits!(
> +    2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
> +    17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32
> +    33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48
> +    49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64
> +    65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80
> +    81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96
> +    97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112
> +    113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128
> +);

Hmm... Did you see compile time suffer with this?

Cheers,
Miguel
