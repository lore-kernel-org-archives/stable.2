Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFA93AFAF9
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 10:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784111462; cv=pass; b=cyTCBcu+3v4PaJms66X2ma8mZweT0Xk9eWc+ZDPWHQbMQaKey+ChUcmBXBh19n5HsOtK2wsXfo3e+MMShvm1OmYxM3bYXPve31cFfaple54pXGWj6tU8GYiyssXDh90AOkVh1HHWEwS21HRAc4gjINq7Oz7mNyd6zaJ7yNNtDY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784111462; c=relaxed/simple;
	bh=zCVEWbgPtNQZ1Mf0SSgc/9MVLe94ygEvCMPHUAjF2Nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zg9rSTN2ajKi+iVXkIQRfeuMc+khBg4Fj4rZE5IeFhwT0AhR0ZV8RybF+w7hvu+lU0zvVR6vcEPmKjVn2LwPio4Y/OoK4YWJunY0K+Z3ilTXUQRMk94Y4X7Nxi4IDT4tGS6ycUm4yP0o/lzhtCSgNLubMicw0ghF1+5epTQA2Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClVGaUhF; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClVGaUhF"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cac39b729dso13625315ad.3
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 03:31:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784111461; cv=none;
        d=google.com; s=arc-20260327;
        b=Orn1JjtFSv7P55DUwQ56ATaJNv6P29iy1YceT/7mRqjXcESnawkyvBba3i1g/jlhKU
         ltwPzQRwnbHvoAvwMfdYhtvaiBArqGR1WTxwO5SAfxNYQ3CS4EDPZDVkH/fFJO/FHj3h
         +bw5r5bKluOkcJ4CGj1Jp/S3ZFkurZYCktc42L2gmpjzEsOWjXnZ1jnMlMyrQHd9ldmo
         WCfaLywtMs7oia0VfhPKbipk5Ays7C1EnYu9unR7A+DR16DuwDRsbTE8u4kLfe3QD1HF
         gc/HayW6UrgmjpMDnXi0opkGNBuzSDBwmVs9pcrC3B/WOOgWNge/zsc5yMFw1VerM0SL
         aYxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7I5s1r4zbwdDnFUPkYxXrynK0Xpz2B6Wc1hGmhEooeE=;
        fh=arR+w8SttxL79ofHkC1Im39cWQRbJ+lVfoZniOyJ68g=;
        b=OgiU8+SwAtO0ik/9jGaVB5OeuiEaRTWd7j0MQp8w65iRnnsfnQGGOmBA3vlCSdqWud
         qoqU/uZOmA9yc4oi+suL3volCB8a4TZuooFBr60oh9GgGjjwsGYujZtOgGLshpG/FvbQ
         W3bWC7d1iC3yZhjFIoz5LeBHoSUnPHdIcHbbR5dMx87JZqCdr0uO8dbqJkHwIqsKLylp
         pOAd503P+Iir4iSw+4wKPWCxwJSgmXsCNBDolvT5kUBadcjTptqpuZ4Hoc6Y1N79oCmT
         ZBbfS0GB03YzhYbBLzuieWPeMWF8MNE/u8cr3rw4HM9aflCBBYLBQ+odVrDIAfTlEUAV
         qYdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784111461; x=1784716261; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7I5s1r4zbwdDnFUPkYxXrynK0Xpz2B6Wc1hGmhEooeE=;
        b=ClVGaUhF6WpO8z2Yn90X89Qio7kq7FZtqBOpZGVUPZU7HvFM3y/WgL9KmcZsOHowyp
         k59F9LwYQcihBqKg+SIN2zqg1sMQRMEPug5WP8FCbbsPIiF1cHCpynJ+7fQ1+KBuaCWR
         Y0lx5qUE/7R7OTJrtobidRwDWwx91+WCQpX+0rMmnc76tXRkpLtnNw6j7+NjloudhhNk
         fFfg5tSo7txJGj8hoGEcyiLGgkI1CiSxSyvRnqqw4azVUZ9husZSCD4YTrQInDM0Hoo3
         3zszl/SfOSOemoL1qt/ygtvwmoNE1PrM5VRrW5xVoTg8LY/ZrTEQHJjUojiiDe8aLsaS
         Ax9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784111461; x=1784716261;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7I5s1r4zbwdDnFUPkYxXrynK0Xpz2B6Wc1hGmhEooeE=;
        b=Lqr+RDehuGPl4zIUWzJnAoDeQ9RRUBsa+gPXwFLnbGZWgK2NOtwOwxJzUD2n8Mi+Ux
         v92MQA8bye+UtempaCTYntcuhAZupl7PIeZ1KfuelIEJLv96qsR9gykhVa74J3iEnIKU
         3oR711iC+S+3ZBwwCnUPQyDkd69mc7NnObBfrR5S+nuhx94vLhC51Om4n/SF55KKwGji
         LqUM7BfM2bdIYxxhwpjtfnMc66EaXRuiTD6X1HF6JJrai6DlCj3e7RxV52/IjUpV1AzM
         lzgiY4qh9ZHcROJHD9JFTSphVASVH+o/RBzkhCfscuIV4ogc4HwRyttSgDN9DMtF3iyR
         P/ng==
X-Forwarded-Encrypted: i=1; AHgh+Rqt26WbiK7QqA7zOD5+UZPg+7QzKcGOTSVXHqm40HS6EZ15NkTFQxMV3+Igpu7bKpHllPmJSps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ84MfWgw0LyGgnr9PM3C+LVbD0fgZisUFzfyB94TxIIAbRiaV
	AxFkkQ+gFNWcfZVPxavE2rco1tkc48d0PE5NpaOlN81Yk0tl9VjIXmojXihKMpQAHBZcteEBP/7
	E0PH/A3DSOsF0jUbo7jr7fBeqbJs7g+c=
X-Gm-Gg: AfdE7clECIzF2L67uF6CQyTAZ2kzV9uV09x94MH++Ld1WQSRtbSEfht33zw7jHNi7F9
	AlvC9b5c8x5Bl2YL5HRQRndaDhK8+0VC6OaTE2koh1c9dWCkJG5or87v5Af+23HRZnw8h1gopVB
	ICIpL5wff5iQW7v0JecDOZyYR3Ypd1KPxV0nAHqtwSMgb65wtFMr7woOfHK3J1UdC6ng+P92vej
	ji4mHuURAk5+w8gTu8fKm9bsal0fBbYbA9HktVaiEW1yD24DYrh4lX9l79yljgx62qMTTlL9XAE
	Dj08WyT586zIoYhfAR4MLvKq5hREtPnKygTasP/O8w83eFqOrTojgINTITTo1DBv9Jb3CknqEqb
	Dn8g1kmPHJCDH
X-Received: by 2002:a17:90b:4d08:b0:38d:fe7d:2a83 with SMTP id
 98e67ed59e1d1-38dfe7d2abfmr8330874a91.3.1784111460832; Wed, 15 Jul 2026
 03:31:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708211435.402426-1-chang.seok.bae@intel.com>
 <CANiq72=-HjYOoJPd=B+0OYrHuyCO+NpcjRvmmhT_ecVZj8q97Q@mail.gmail.com> <b705ef27-e87e-432a-ad1a-f425fe66887f@intel.com>
In-Reply-To: <b705ef27-e87e-432a-ad1a-f425fe66887f@intel.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 15 Jul 2026 12:30:48 +0200
X-Gm-Features: AUfX_mxOa88utfElFRyZIrS2LgzsWoibXzzaSNpmHupISKv8tKlcaf7D0e6UA7w
Message-ID: <CANiq72kn8F-pnd-YxBiPN9nr02jagRk4NL-3vyX1tERCQjqNHA@mail.gmail.com>
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

On Wed, Jul 15, 2026 at 12:15=E2=80=AFAM Chang S. Bae <chang.seok.bae@intel=
.com> wrote:
>
>     JSON avoids the warning but Rust versions prior to 1.93 instead
>     produce another noise:
>
>     '-apxf' is not a recognized feature for this target ...

I think that warning may be coming from LLVM, not Rust, so it may
depend not on the Rust version, but on the LLVM backend being used
(Rust compilers support several major LLVM versions).

So I would recommend double-checking that -- and if so, perhaps you
may need to restrict the LLVM backend version. In case you need them,
we have nowadays e.g.

    CONFIG_RUSTC_LLVM_VERSION
    CONFIG_RUSTC_LLVM_MAJOR_VERSION

Also, from that
https://github.com/intel/apx/blob/study_rust-apxf/study_rust-apxf.md,
I notice you checked object files, which is a good check, but what I
meant is to check the LLVM module attributes in the LLVM IR emitted
from the Rust compiler.

For instance, if I do:

  https://godbolt.org/z/sMaajjYao

I see:

    +egpr,+push2pop2,+ppx,+ndd,+ccmp,+cf,+nf,+zu

being added to the LLVM module attributes when I pass a `+apxf`.

Also, I saw in your file:

  "The generated `rust/core.o` object was selected as the insepction target
    because it appears to represent the core Rust support built into
the kernel."

To clarify, that object file is "just" the standard library. Which is
definitely a good target to inspect, but since you scripted this
anyway, I would suggest checking others. In fact, you could even
inspect all and filter them out by the language DWARF tag. Or perhaps
you can just do it for every single object, since the C ones are
expected to behave the same, no?

I hope that helps!

> Indeed. This is very helpful!

You're welcome!

Cheers,
Miguel
