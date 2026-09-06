Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76C7241C8C
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 01:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788659597; cv=pass; b=THjM5886yGAIXLJng/r+HaPrdewT0+b2NLJnyWl1EucdQEC7IDcMDPK034N7NcOcEltiTzWDWFHqiLlDfhrSdmtVH244SfA4gPC6+ufBmMjTSM1peXTizl2371lrLA8O8e9siWFlef/en6gwJ+PxorclZIeXVM4hFGPLieXFbgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788659597; c=relaxed/simple;
	bh=0fe91VGjdHtQeef0UNlWbF5tOmLMtidS4mJC79LOGpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlozNz3gQ2m5PN8M2uCKYIWahbDAeBBUyXwuNYS2zrIvgfTejsXHpNwOODBsjlZFP1ijEXPwMUzov6NVGpHrVkkoz7kbkPmZQehHz4qek7VHdYx0mE4sJf2eAwAQu9ZsCAmD5GyHMOMnF9RKiz7FvKGlv/Drcvyet6gMdCYgWto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBX6pOw5; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBX6pOw5"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-399026951a2so248158a91.2
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 18:53:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788659595; cv=none;
        d=google.com; s=arc-20260327;
        b=qmVysyt9o1+xtKrZIHGXi6wHR9DGem0U83uIKPIHf4/bbJVR8W51RJE5/ixg1hRsqL
         rOgJJs3iNZZxU6uB09WE5SP2l4PituOwyv725HTSQzUhNprpNifyCfmJeqPpVFf6C3F3
         XF3JvOJNbMiGFKMEDqXsU7BmJa6Zc3WEN4YNSKLt1ojVmSnSZwY0GzffP3CMoEf3DnfU
         dMz/zeyezqIM9+I1y5tL8l7shJV9VInEO0d2SlLtPhuWxJVCqkMBTL11l/BoXjYzcQs+
         l5Ak/Lsto9B7pnF31uTaFOMoRmoUZDQ6T+DrGf6ouKQqr00lgDSEsDnPA5a5OXauuRcz
         kebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0fe91VGjdHtQeef0UNlWbF5tOmLMtidS4mJC79LOGpA=;
        fh=IJpWrLbtXyxpKuaBdW+ZFTuPqLNCQJVgYAkV6m8HUfs=;
        b=Akn7A1AKqBoX4xpuLMC3HjZWhZAL/egR8+OnkHToToOsMFQhOrwlnOuLyPOcj5FqP2
         zv0W/Cs5DsssCdAIxsI2COYfwpoEwPpoTmPkw70FVfDJkPzLaTSXTucCBpEjrGdYJwyn
         VuDg35/O6PBg/4IYMAwfsl9QprPzYFfM1Jh91mzvqXB0DLINXajY9BK7D7pF2sF4crRu
         SFXPUieaaTi7D+zRmYZgUji3XqVZgXmpG+Rvaz+IiXzlIJdUPj0hMZi/Edo1D1OKcTpg
         asRLbXejlPdiUHUDfwbZvSMUlaACAllsHwnPmvauCB0O2mCM4aQYRXcFgFJ2kGGFcuMq
         cVrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788659595; x=1789264395; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0fe91VGjdHtQeef0UNlWbF5tOmLMtidS4mJC79LOGpA=;
        b=XBX6pOw5nJcXyUo/ic4MJPrZMZgP/AkgdLY0GBolvVUXBQNFrhcaRBhOJjUAl88EGQ
         RjWCaiuQXazsq0c8Wc9QIenVnOgk8ub/8LgvJoE0hVCxdR/wx2J3P0fjjGmLg/E+TObR
         jcXPLesBuMbhu4l0+5kXAuUpu4w3mdT1nEfK3r9n+9cjJ8p8SCA2ScUJ/Acf8Ac5MR4d
         4RTT9iyaGRO1XijFVxQRhh2kThVzMsBfmWc64eEZpFnNDtv/6sNGg6xnt8kO7W9llLc3
         uIxto6wIFa2SuNB80oZHWsJcUSNuDmGh24+tg7YBfAK9yJ369sveccVDyunEpJtE5J/A
         aaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788659595; x=1789264395;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0fe91VGjdHtQeef0UNlWbF5tOmLMtidS4mJC79LOGpA=;
        b=rFDJSfF0vJiKO/jV0IBBRksUnTujDwLE+mdiTCyPdL3bPnLm5f239oKAvTrhYvy87t
         RsVdsvb7HwhBV9s1WbOjTghRjnkmXOeE7wadln9EKZBNwb7xex/BOsO44ApEUIi59QYU
         UZoZWC/SpHByAbrRaC2rdwYZuSb8wsJunzk3roaATweKYDKQ8OO3Rz1zu20WpKV7iANT
         6bK71G+86EeYNdvbdO/uP9sLOJgkKTCgJSd4LS8d23cpO881XDHdcQ77WVg2ttkjPaUc
         BoWvi+Cs+m4JaMyVh1qkAyhkAOWsxsW/RcfnoUCQj8GTMjSGyh7gBRimGChVzjoXD1Mf
         Utpg==
X-Forwarded-Encrypted: i=1; AKwUvBwJR0eeTFFBDLmuATo0p1Pydk3zUpSV+UkRobiVZ0KU6vhKlwVyW8lZasD7zBN8a45e/k/iyWU=@vger.kernel.org
X-Gm-Message-State: AFuF++nY0o9ZuHW7NeMCPD2yF3B5v89lDGJ8ziYAbZ/c4MpyipyYOAjI
	/tXSElh9G6bszYgyE6Xa2/pz5ykS/hW+D1Kiy+t5bWoX04r+6cysbyZ6qPZpmRLTwl06z91K0ur
	ACqUa+P2fp7S/fCC6h2NsXVMqjvYztLk=
X-Gm-Gg: AYBFou1K2lz8oieFEVx0aTsQ6QM2XxqhIbtTBrEgcy4SSYt7ZhUWxcqheBrlMmmEMhh
	nLMRZY6pxWgHsVql14k7QzgifqycLzsJ/OrDkRQvP8IsAQwGU79RzJ6x136MjNgeczh3FYiDGPW
	q3kg9M7NG0iiVlgvOmJ1s1ld8+dLkaE5//ZugjM3PsKIZz1O4b5caSG0OIXuv76F53Xj+mjIJXm
	qmAeTkaw+PwUbIoTRqEKMO8PG585suIeH85f5Mym8eDjG3PVG6jxIWqQDjQNT+tsu3XwxlCVKtU
	jTCE8nfWTS7cvwGHnguyVGeNp4Z3wCV/p2Nz1I8jmp6x1oH/7B4pHK0iXQEHw4JzYxJn3FztQ9A
	gCQDhsV/Quw0mwpD3PXryJQMhVpK8DfZfFLR+d+TvkRpEwtQ6kgLFFFCiXyaTGA==
X-Received: by 2002:a17:90b:574e:b0:38e:ab3f:2c99 with SMTP id
 98e67ed59e1d1-39b3d5dd778mr7610897a91.2.1788659595145; Sat, 05 Sep 2026
 18:53:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905-feature-rust-num-seal-integer-v2-1-f1311ffbe6e7@younes.io>
In-Reply-To: <20260905-feature-rust-num-seal-integer-v2-1-f1311ffbe6e7@younes.io>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 6 Sep 2026 03:53:02 +0200
X-Gm-Features: AcwNN1WEW51nBsJ3su_t8_hcLXLC7IQBuC52TmPA-qkeVxaLPbqIIJjxPe3cDsU
Message-ID: <CANiq72m8kycbfQ1teyne-OtB5d5TsUcX_WW0FCkWB3Ayyg-qWw@mail.gmail.com>
Subject: Re: [PATCH v2] rust: num: seal Integer
To: git@younes.io
Cc: Alexandre Courbot <acourbot@nvidia.com>, Yury Norov <yury.norov@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 5:17=E2=80=AFPM Younes Akhouayri via B4 Relay
<devnull+git.younes.io@kernel.org> wrote:
>
> From: Younes Akhouayri <git@younes.io>
>
> Bounded relies on Integer implementations to describe primitive integer
> semantics correctly. In particular, it uses Integer::BITS and Signedness
> to justify unchecked operations.
>
> Integer is currently safe and externally implementable, so an
> implementation can violate those assumptions and make safe Bounded
> operations reach undefined behavior.
>
> For example, an Integer implementation for a u8 wrapper can report
> BITS =3D 16. Safe code can then cast a Bounded<u16, 9> containing 256
> to that wrapper. Its TryFrom<u16> implementation returns Err, and
> Bounded::cast() calls unwrap_unchecked() on it, causing undefined
> behavior.
>
> Seal Integer so only the primitive implementations provided by the
> kernel crate can satisfy it.
>
> Fixes: 01e345e82ec3 ("rust: num: add Bounded integer wrapping type")
> Reported-by: Miguel Ojeda <ojeda@kernel.org>
> Closes: https://lore.kernel.org/rust-for-linux/CANiq72mOfR33s4y+Ueivd5NrC=
5yre+Pcp57ZOBz0msw9A4AP1Q@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Younes Akhouayri <git@younes.io>

Applied to `rust-fixes` -- thanks everyone!

It would be nice to explain somewhere in the code why the trait is
sealed, especially if we rely on it for safety, but that can be
improved later.

Cheers,
Miguel
