Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A5A23EA94
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 23:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787701013; cv=pass; b=e0PDsFRPKPSOrdUQGIgt1ah6dfgEa1GKWlENf/K7UaG6ZCQr/DzVlb1hB19Qis3dVJOO9q54Z44zsbqPCyYQ9Nn+AtOW3SyXFT8ly/Y9fLbrcCclj6cgZ/WOw6gjAeRNNKnJP4B9c7/L+1S9ANVwKkdpamECMwBKTXhQKQhCH7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787701013; c=relaxed/simple;
	bh=h1DbMee42kDTE/h0M3ZhHKpBRN+EYlu3Xiaw/VOWNzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhX21P/wJfuaHsLfElF7GE6Bithqv6IwH8mxRx8VXkrmAkeF1jBELwJ+QvtbHQiR0dfRaFi6ZnGfhV568TVdimhxgmEAoVsHuJUcwa7UovouLsa4+oEP0Qfes8NimetcitAkK/2lzVIpFlbwNIEes1OmqwZr+cyjAtOdHAvY7yY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cq5aUTeC; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cq5aUTeC"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d03fcd26a6so358455ad.2
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 16:36:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787701011; cv=none;
        d=google.com; s=arc-20260327;
        b=kQPpx1k3LULcrq34nIGzbzCAT804JkDcI0rGwvDhFTRNHZjUVnIGxGEcuar4w2v2EY
         rnc+73L9v70rq8OtQo9CoCOJaWHETha8GA0eMgF8uNeZarAARZIcQ0CdtbnQyK3sCwvm
         QXOJMRuEqvWFCmbz+AxPiiQe9D5x28IaWroSqYIabotFqxi+2uDyvbXqL5tINle69Rb2
         WWADjgJwGQzhx4m2+6XB7AU9ftxL0xXzQCIF3UobnwHC+PkxFuekbcLA3QvUyGojf77I
         5ZGbBOg+QCGP/TsqsjPrERPJG2Bc6zg05E1P3eGUFmIh4FFJkQv9KqPtIrVVdIMdJjOJ
         amyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2fMZcIr7PJYUKtYt6N73x4GUy9xmDK+BvFmvurRf9/Q=;
        fh=YQgENS8p/X3DcT4oqZ/9X8LA0vR7XI1zX3Qz+aoOEBI=;
        b=gOxww+YuYlERcs7NNvu8qXdaJp1fepUebE1cMg0dd/MOpsbC99lM9R/hGVe2lP9KuH
         Zn3xP00HA29MpdtrAzKgz1BVCorGXiq/pramHRYLjNHhpUt6A4HZUOgYRdt3686rkIjY
         igXuMuqTeTPz4+oqf3+k7hKtT0Gdjcg7al5lHfezMLRLUJYhCX83Cn7QUOIZIbTJMstR
         gI8QEEUZzDbufYjcGYWuMqswn3LCn3l+TOwyCOFAYBSyGGZVql5gFAMeMpYFMAnDardY
         nXhUTCPehZOaSUBu788ARfXS0TGFKBaKZikcVuJZO8Zw4eLzoHcBb3SrkEzvVwXTFHFE
         qSIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787701011; x=1788305811; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2fMZcIr7PJYUKtYt6N73x4GUy9xmDK+BvFmvurRf9/Q=;
        b=cq5aUTeCIAE4mPtjyZVij1Hq4AplR5/esWhQPkNAERpwIuaaWIPVGtfFgZstEhFweB
         pVprFD7Z26WLT36SDmmhso44Pw5y3eJJ4CGWxpt/0kMkyQFS1459igOdKymQnRGZLfVq
         gE9Q6RCmNodQEOMsKejWCjBl+3ZuR+kihYHbMZjB1tbPNGi68C/P0mVCVHY/VkwBKY41
         EgSrSi3jUvk+ZK9zbs1/tYQDh5qE/8OPY4YzjYKQfMS7EaQixYtsf8k3oPCTrsq/5zkK
         1EY5tldB36zoQowFXpBqhhiX138FcQoJcT66X28v0gm67EMWKqTl5EAtfCBoF/QTFf64
         LTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787701011; x=1788305811;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2fMZcIr7PJYUKtYt6N73x4GUy9xmDK+BvFmvurRf9/Q=;
        b=mrFEzktUarWGyvcjCaI6d6y1+t/IZs+6wrocUHTiql2tKqP3O0H35z/ujNgCNQ6qdy
         EOW95FoLf4XfPm1OxiHrqocb4qleon4LD7Sz8toah5+LEySsdxR0z2anBuiqWzYVnPwr
         Ch/OXMLUc+TE7sdYkILD6FAXGFDAhEgclorYhiQ1+2mTPatozsSWqPKxRnrnoegpmeMQ
         yjcxv3kLfdt13EMeCpAfz8uszxQYCcsIcS8ExQ/FzPoZh74q2S3qJ2svThfm8VDKakeP
         iTIRqNHPs7uWYcympGT/D5+/eMsLPl/JhAqEQNeUguvkQKUttQxTKMHOhOGXhAeEy41t
         rMMw==
X-Forwarded-Encrypted: i=1; AHgh+RqMPf8rwwLy62qI76QpiTq4JuMStk41DuBJgEnOiIe2nDS1pGfbUr34pHWk+aJVv+1DDbeVKrc=@vger.kernel.org
X-Gm-Message-State: AFuF++niASFQqHzzkVr2wZZYgCNIApNG7ZHOzUhPq3iTIQu3LVZqy0Jy
	x3Lz0XLFIrMvJ/nA7bvMxvJZIV/cbNsNB/VOUI+h2diye3FHsB6zPrKi2tgDzRzPyopm97/euqr
	9ke677nOAK6pgLKbr/P4rvxBfLOS9vzM=
X-Gm-Gg: AR+sD12FGQres1OC5ForJLY4n13BAp3vjhq4OZqW6ZHmzb8WocS3erZYL6eeysA6JmK
	ZfltIXcZcB8+qsHIeSdTq9OQ/QLWB3ny3q6C2AslOy30hlRaUecvtX2U/YHlTod+kJalzo8h6ri
	kn1yGiJEYgfZKr+YwrfVLGBsXRfQG9OQEUeRAd6IbnJSE3rTW8nlPww4xyp9OqWMG3HB1aul6vj
	Kpqo1j0IkI9fvR6kWQ0IRMvtbSFnbbLOBJW6T4NT4d42cLYXKVzjM/ideZZdrcVdHgsR1xVFve4
	i/5EFC0nNMfB1uLvPGD+1In9/AHHPri0B0N7gqpUhtfqowvKAZGHgcCnsxyUmmHDYAhSIHZGs4R
	sSPaqjP1Uc8D+UI7YeJDCbIQ6iycr4kkIAdSC5p3Eop9LjNHY3IaIkc9ogdXpqQZ6Yrgseqc=
X-Received: by 2002:a17:902:f789:b0:2c9:ed4a:c3a4 with SMTP id
 d9443c01a7336-2d7077710ffmr16923965ad.0.1787701011201; Tue, 25 Aug 2026
 16:36:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823193529.156066-1-ojeda@kernel.org>
In-Reply-To: <20260823193529.156066-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 26 Aug 2026 01:36:37 +0200
X-Gm-Features: AcwNN1XJUdcU-uaWrJb_MWdWJsZH9EysTDIt0KdNtGRwRojvJo_C-_WfkW_E10w
Message-ID: <CANiq72=AXhvxG3TD5QgnLMmL1hcPyahn55wO28MOsWTAo6F_Ww@mail.gmail.com>
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
> The `rustc-dev` components for Rust 1.82.0 through 1.87.0 include a
> precompiled `zerocopy_derive` procedural macro in the sysroot. This
> range includes Rust 1.85.0, our minimum supported version.
>
> This makes `rusttest` fail because the compiler finds both the sysroot
> copy and the copy built in `rust/test`:
>
>     error[E0464]: multiple candidates for `dylib` dependency `zerocopy_de=
rive` found
>       --> rust/kernel/prelude.rs:70:9
>        |
>     70 | pub use zerocopy_derive::{
>        |         ^^^^^^^^^^^^^^^
>        |
>        =3D note: candidate #1: .../lib/rustlib/x86_64-unknown-linux-gnu/l=
ib/libzerocopy_derive-54d2b38896fa6bc5.so
>        =3D note: candidate #2: .../rust/test/libzerocopy_derive.so
>
> Commit fe39a233ea52 ("rust: kbuild: disambiguate `zerocopy` for
> `rusttest`") fixed the equivalent ambiguity for `zerocopy`.
>
> Thus point to the dependency explicitly in this case too.
>
> Cc: Antoni Boucher <bouanto@zoho.com>
> Cc: stable@vger.kernel.org
> Fixes: 506054980429 ("rust: zerocopy-derive: enable support in kbuild")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes`.

Cheers,
Miguel
