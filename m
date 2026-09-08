Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4504449AA30
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 21:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788903334; cv=pass; b=K5DZNnCTEdyesjq8wEw3VtAwTwKcJRvSOaev0nxFDo766u/cOtiSVmZ3Mlf4Axk6aTBpZ4VBVfTYpu+ncYz/BVBr1+9kAOkJMj3HdPs9P0OYC2vd79M31XizQg4pAhMk9EbZ3HmN9d7X6SISjSU5JHs+zRVryOVi/M+AT+cTU+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788903334; c=relaxed/simple;
	bh=Ih9aNAHPmb3atmae8ogQ3aGNGlgXNmwTkwSV+CuwpQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KYRwkS6DhK1NCWWQRe36Ic6DKOhpqe+QTEV02Co2TQrBCYQBuCG8I7zhgE6HnovUywrnX+ZBHneEt85ohEN+gmKWsC/JhnB2PkQLIJ966esH0ysaCNY65VDLbxyt+Hv/5XuQurwKY/AzI86AU2H3JvVqsj27OZrEbI9SZzufzgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNIOo14D; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNIOo14D"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b1a806664so660147a91.3
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 14:35:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788903332; cv=none;
        d=google.com; s=arc-20260327;
        b=hXSwrHMsoFCdVN6Lpvd9/KUwnf/g5Q6khMeJV0rHvZm62ChBPPyGpORWbEOf9hyjqf
         zGgjbOCzuZi5eQ+9n48SpLOuBGxdtnWA07Bv8BAWy03zHSv0CyBD94YHxkOeCcGLBV/I
         hEeF91OM/UZSFWwJCGI4Yrt/TH1Olg0lRnYcVxx/DmGW6aVxGrNXOqVlJ2/B+sp1iM9T
         lX8n1lGER8EZAiBkLa3/z46/IxIkciCvys/TodsFgpPGuXzpTdJVS3GK8JBHvLDZlM/L
         1a4uoyRouzV4bY5oUS3Yy5HWluTRp0fZpBdnRWCORdkWEPsjNZcgpUhe8Cq74NJuVUm2
         r8rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y7pAMbndvfBt65mnzcKTzmmfGUDejmm01Bt7ape8n2o=;
        fh=MoAE01eMZmcjh2bHcpQugS93wmRbJOGoux0ZrsVcLcQ=;
        b=AtoDABjoKy0/D+ya9lHtPq3EM0Wki1fakAgeabDEv+VR0D1apUJgKLp4PurZzPqJUH
         ggGZevJ1+iiY1Hj7Gk/Mzkq7BZ9Rrcd56+KhCvVtHyylIdJpjvSmAcKkDfDQZikGMpxc
         ZypF2QVyOWUvfD1WqzYC0mx+Iawdbl3yf6UNm/ZSyuliBI3OgKO5YU8AhCPPCP42RQgr
         aB32vvlvadAeuiQKxP02aHtn7rNVmHyBc1cZHYWBXuCFmTQNOSYHL+m772h0k4n63Kiq
         NelvmGBtMFubjrPMKdAnSBFk/Qz/oRAgZMEWei1ydgvjX6m8wKIwXzlLah2ApjOyA3lf
         gyUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788903332; x=1789508132; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y7pAMbndvfBt65mnzcKTzmmfGUDejmm01Bt7ape8n2o=;
        b=PNIOo14D6ouU51DNkiTt5srlB7XYE/62PPRqqou5MG/6n+e6EtZkCIHfExIlKwFrel
         7RORbFMZaVA6IT1kDpimhA2GeufN2VQM67l3HKCuAqsZ6ZoaZStPClnyjgl1XNUmnE8e
         JclOW08sO22tZx1gBn25K9D+BIsPSLI0HCDwt/Dw31drB+04OE9dqNGb1NXEMVKmYvkx
         Nd4THEAOE5lSBHpnw1TYNtx3Ny9DQE8oA8BWmuifldRNeYYz7t5LXYioMqlwiQAWfeAK
         MUjdi36mbH7/dqrES7lxFwtIAhb2NfQXMMZRuvOAczLXnfr2LTL8dVQNustofgoxjfVh
         YvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788903332; x=1789508132;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y7pAMbndvfBt65mnzcKTzmmfGUDejmm01Bt7ape8n2o=;
        b=mNhfzztuuO1OYiB1qyJaJsIr6N8HsmooUEMGXh0Yw3GBaL7JLPT4EhtiBBAZZjBcFM
         IQvDblO3P406R4YG/rc0ljOT2B9wxXvCVRfddb3uOScukmjGvLmJas/7Y7GBb8XuS6bn
         qQeuitcoxJJpv/TQa7CN45JPGhnX6sx0bly+8Q3RmVreRP1Xe7jn8U7IzIUpPdRAToxF
         03lFqxU6w51I7vejfWaK0PMYYvJKY1odBwPOH83LcOrQ9bS+K74NIp2SefO4WYzSNWPG
         mfB/CKzOE3YbPGiHktkyQofeSrOLfECDuVxz3XHdLC4yNUn04YHHD/bIcxhG1J4xCkvj
         IRAw==
X-Forwarded-Encrypted: i=1; AKwUvBzXmHTvYlw1yKmTr3j4Ocw27Cjeu3INysvm2g7YHrqny5R8M6Ont4u0oHgAVV629AcsiVgQKLY=@vger.kernel.org
X-Gm-Message-State: AFuF++n3+Pk6LaBTbXbq0pXl+wa20jM75ydrGRco0fsWu1OEtZ2Rtioe
	65Y+9FY6fEDK0a5JCJTliNlYshXkGymJi9R9yErix+FpHgJmwU7cN2U9WYoG/r4SQ5SUVdUpreR
	zbsPJNZZIJ3jbl2owGEFSpKa62oo9NWA=
X-Gm-Gg: AYBFou2WT3ZZFjYg8Mh8cRJ9w3MQRtapgEjBW36aTC9qJG2T9xFQ7a+ERdgEiATMEEP
	D/xD7SATH9Rqd+Awe7mhAqWqCAuW9BH34/E3ihX/OnQ46bHkF3s/TxO11D/+J5gifN5v5px17an
	vsePDntJzJd/C8F2YJCj8kHnnoS4Cp1n7xaaTlGLgbu4E+5TGGU2L+TomVPOVk/uHtaSaMs1Y7w
	ZTb8qAM3Ohe6WZhiSz2W3I7URmXjv/wh56AWvK0BeWNI+9kK2OQ3CS1svgORfj49T6PPwNVm8ky
	UDHc/0sfSKBY7rsttVbX33WYbwYegzHUqJ0Ytj7gTya/gQ/OpA4rHfIqm4V/e9WX4iCI/xcGAAz
	EIhIPe47lsDYsSzhfYy50h253ZXCKGAj/rbWwg+K9uenoekdyjx4msQtK11io8Uu+FuwoZO3RRU
	Sz1yEItljMH53NW0NTgVVEbqg81ea6UejGlqSLibew0wQhyPtmXCs=
X-Received: by 2002:a17:90b:3ccf:b0:39b:34ef:3b24 with SMTP id
 98e67ed59e1d1-39b3d5aaa70mr22748600a91.1.1788903331609; Tue, 08 Sep 2026
 14:35:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908170539.345207-1-ojeda@kernel.org>
In-Reply-To: <20260908170539.345207-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 8 Sep 2026 23:35:18 +0200
X-Gm-Features: AcwNN1UgNfvavHHRk8c1vcqAAwrO6dRloNQXkFX7IxIu_0dbYHQkxC2fQ8lYnuk
Message-ID: <CANiq72=fEYa1PygH-XJHONQKqf53dZFuGc-Z7wd4M7yeREq8Vw@mail.gmail.com>
Subject: Re: [PATCH] rust: allow `unknown_lints` in generated bindings for
 Rust < 1.88
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	stable@vger.kernel.org, =?UTF-8?Q?Emilio_Cobos_=C3=81lvarez?= <emilio@crisal.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 7:06=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> Starting with bindgen 0.73.2 [1], `#[allow(unnecessary_transmutes)]`
> are used, even when `--rust-target 1.85` is passed.
>
> However, the lint was introduced in Rust 1.88.0. Thus building with
> older Rust versions warns like:
>
>     error: unknown lint: `unnecessary_transmutes`
>          --> rust/uapi/uapi_generated.rs:26294:13
>           |
>     26294 |     #[allow(unnecessary_transmutes)]
>           |             ^^^^^^^^^^^^^^^^^^^^^^
>           |
>           =3D note: `-D unknown-lints` implied by `-D warnings`
>           =3D help: to override `-D warnings` add `#[allow(unknown_lints)=
]`
>
> Thus allow `unknown_lints` in the generated bindings -- only when buildin=
g
> with older Rust versions.
>
> I have asked upstream if this is intentional [1], i.e. if we are supposed
> to always allow unknown lints in case `bindgen` uses such attributes,
> or whether it is an oversight.
>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).
> Cc: Emilio Cobos =C3=81lvarez <emilio@crisal.io>
> Link: https://github.com/rust-lang/rust-bindgen/pull/3455 [1]
> Assisted-by: LLM
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied early to `rust-fixes`, but tags still welcome for a day or so -- th=
anks!

    [ Emilio said it wasn't intentional -- we will work around it for now
      on the kernel side. - Miguel ]

    [ Removed the `cfg` for `allow(unnecessary_transmutes)` as suggested by
      Gary. - Miguel ]

Cheers,
Miguel
