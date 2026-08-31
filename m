Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B68649E5DC
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788198905; cv=pass; b=iXtJkoDq9nZb7WVNa6YrWTxnEpbv6CNq1qEjf4CyIBpKFwIqujvXpJyCjkZa27ah1RcdHHbYq2tG9HRMnnWJGXpZzmqd7+PrQLRNLQU2aFV5OJThy/45ugAtHIqEPj47MYCevnqQnsS/bC1pDnj6/fu9/VKJfkSn307Mn0ifIBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788198905; c=relaxed/simple;
	bh=1kCMgVeNQvSiwIL3h/DRjr4qSjOvxImZtZcvTmwnYcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rrrb5hkp5NkDlf+m0ULxDYUBpvrZoZ1FmDRvwMSABUvgJqSc0Iq0bkOXlX9GaRIH9xGzx5V2job+7n8ARklSUekJftrGjcetJgsx368JukYWFVMEbY4IcASc6xfcopm2poRBfzv8gIvUPxJvdJRPL0cL11W4B0u7i6n9dyrNoNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyxmnPxN; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyxmnPxN"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-384caf7b168so323571a91.1
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 10:55:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788198903; cv=none;
        d=google.com; s=arc-20260327;
        b=n3q+Skrxm8UYnqPkWBNQFnuON4beToZHWY3tpozLGSBi9zjy58xt7iMqtSt7hmKF9Q
         rjhfoFDRxaybxEER68gA76Nap5yFXImMhYzhP3BfdiNo96jIGbmBzbrJaJOZaE6YeYjG
         chjUmYbM845O73Oy6nGh9YEEc77ESBSoPr7uqB/50kahMe1bWkhPiQY0oqg4s7GFcmio
         AaCAKOjrwQe71Y9eU+ShCmg86rWnoB+iTt0OixhgnXvlFPThZ/A1T+SSXq3wnjbep1aJ
         2nk2cW8jy9omXKOTax8UGKlYwVYeUNPWrIuibg04So9G8X+OhV50X4+obYsRwyRVR3rD
         Br6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N/RETsztnDkAzUQrwJYe3M9VfKmr+8nyYXoQh9ATtTg=;
        fh=aVu5eIqcZO64XXSOkyFJNx8ITVmBXeyt/JhqpKQtJ/g=;
        b=ncQIwg7bywWWIHG64gVEe0oTInYRU8E3R5Dbp3bI+yAQM1ov5/WQzZc358yu11Jfdb
         qWfwf6gYC6kpCtBEc+AlM+zOMrOyctQeUPLmRBUCVM0/b72jsh0G8R+kExjjKxuKENMB
         AWOdjCWBiauhRwNGMSB4XeFIyEJ2LqstB2QJaBMPVclUgQKVuiFvJ4WTMskCjtYiBqqT
         Lb1ZrEWmtENQKYmWWbULqtafG81GOSFNJCcK0DYQq9FjSq7bYWcQRntWwdtCzECTesJH
         YIBipLoJigiMzACTCvDVqiFoUIdNrn2gOKjUwzA4nA/poy5u5+/rMVm6NGfHObAQitcP
         Kwcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788198903; x=1788803703; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N/RETsztnDkAzUQrwJYe3M9VfKmr+8nyYXoQh9ATtTg=;
        b=JyxmnPxN5h0vHaOvJhC5P6t8cXq+Wj0BtKDjm03KguwSvzW10EF6OmeMOflX7srlPA
         1S2OSYclK92wXtzQv+mVFjdhn1oSC77IY4Z7ThcPSoCZMVY24w3Jkx7oOW2do0CZqsRN
         INt3+vTKLAudaBycDwRJb4Gc1osw6zOyBrg2YRBdz74UlodTh2dN7pkO+d3V0caaGLE9
         o6h81epwGhDwWtk0KUKOWN7RZxPUHnI995fwxBqlwCqMyBDtXgrWFF15ea2gVdedGXqG
         C8xH8lzg3YsOXilevrGcyTYPGVkMk8kkh2y9I4HoMlFI2dIY+6Tn1T9Fr0MK8C9IsDvc
         Lsgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788198903; x=1788803703;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N/RETsztnDkAzUQrwJYe3M9VfKmr+8nyYXoQh9ATtTg=;
        b=Z73Aiy+CqgzIyehkXeKr2btxybO5T06EZOX2PDf8EJ4nKz5Ufu/r8mRgashwIE6UW9
         D/0m4jOHd/z/1vlQNKBdEHoS6nn9RP53Hx85keaRPwZY+GwefnWI5JOxIhfW6Ds5HEKg
         Tktq9JUH8jhXDBOQX+wrUKT/xqviS58mWcLhz+GMbOtnx6ZgWwIDA5td7skmW8p3dYHu
         xc/COcvICUhZQXUDAioOROpwt9PsdUOjlHpI+qHLA6HXl6tfO71SJyN2xXG9FnAf0oHi
         c+A7Wq7zS7/vcFaagQW3gSRl3lHm/qMxxW/R5hIxd+R9zmyPRlR0XeOtu2gYUiIXyiKj
         d70g==
X-Forwarded-Encrypted: i=1; AKwUvBxjdVtoU+bwNdfF+2mdPpzK2zlCqG9kdKZCfzQucX4yUbHwTLFvg5cwLnE7qQVwjou2di7dg28=@vger.kernel.org
X-Gm-Message-State: AFuF++knfCYcaUeNvyFEHSTpe63N6Q8UQEnIUZF+6tyfdQyyvcSYvgEF
	8UZCkLBcN3xKo0Mo53G8aGtcg/r5G+Dp4Egd6v7Oq1Yeza69SQ2i2EQL8HbVjnuNCgPK4TCLylL
	+imjyUOAAIhIUPpKnUbmLkQNqga3K0l0=
X-Gm-Gg: AYBFou11NDHv6aFtG25NKoXnKyP4RrPsffs/GBnZIeRB1DhfyTPD57aRqGMrQ6yTGg1
	RLaHG6z14J6QJ4v5eCU5bLH+pz6H8DDBet+vD7bhmA72zGezkODLB3GeMxIbPneJ2cBcjAkR0Wg
	nSi7rxJCCwi0Q4PdmSwoi2L4UHlMRmiXWSXEl5gt7ZQPbhf1TdBRCNvdwpy7IQhUnl/lwn68MJP
	dvR9ndbSmdjEGtsDa/LkTx2nnr74gHhCqt+4B7X//E9OCvCA1Sy8qhpJ9rRQDhG+mrcknFOSGfO
	lZimSa5P2kx+FF2Jc8sClmv6jKHhiO7GFz2fNfVlkYCkIN9lN7Ud6k3CzOJvtzDwmrq4N9u/nuN
	O3cOCuQA9zjPeD6LUPiSMMgCE0QDy0i73QDvJG30M1NHG8X+8Csd4Xv+NYEgM
X-Received: by 2002:a17:90b:4b87:b0:396:463e:2eeb with SMTP id
 98e67ed59e1d1-398ba6dc4f0mr13662063a91.0.1788198902732; Mon, 31 Aug 2026
 10:55:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826145642.43807-1-ojeda@kernel.org>
In-Reply-To: <20260826145642.43807-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 31 Aug 2026 19:54:48 +0200
X-Gm-Features: AcwNN1UHVFX8Gn5Pcu2VxHXdKlDsBxvZVLchmQDGmj0obMMvoJmQt1OhITRIZ9g
Message-ID: <CANiq72=TjVOxDj631gCFMKAeXYbjycmZe74ChXL=rw4H53pQzA@mail.gmail.com>
Subject: Re: [PATCH] drm/panic: clean new `clippy::needless_range_loop` lint
 for Rust 1.100.0
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Jocelyn Falempe <jfalempe@redhat.com>, Javier Martinez Canillas <javierm@redhat.com>, 
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 4:56=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Starting with Rust 1.100.0 (expected 2026-11-12), Clippy warns:
>
>     warning: the loop variable `i` is only used to index `self.decimals`
>        --> drivers/gpu/drm/drm_panic_qr.rs:410:18
>         |
>     410 |         for i in 0..len {
>         |                  ^^^^^^
>         |
>     note: for this index operation
>        --> drivers/gpu/drm/drm_panic_qr.rs:411:13
>         |
>     411 |             self.decimals[i] =3D (chunk % 10) as u8;
>         |             ^^^^^^^^^^^^^^^^
>         =3D help: for further information visit https://rust-lang.github.=
io/rust-clippy/main/index.html#needless_range_loop
>         =3D note: `-W clippy::needless-range-loop` implied by `-W clippy:=
:all`
>         =3D help: to override `-W clippy::all` add `#[allow(clippy::needl=
ess_range_loop)]`
>     help: consider using an iterator
>         |
>     410 -         for i in 0..len {
>     410 +         for <item> in self.decimals.iter_mut().take(len) {
>         |
>
> The lint did not trigger here before because it could not handle arrays
> behind a field access such as `self.decimals` -- Clippy was improved to
> catch those cases [1][2].
>
> Thus clean the warning by iterating over a slice rather than using
> `take()` so that an out-of-range `len` still triggers the same bounds
> check as the indexed loop.
>
> Cc: stable@vger.kernel.org # Needed in 6.18.y and later.
> Link: https://github.com/rust-lang/rust-clippy/issues/16631 [1]
> Link: https://github.com/rust-lang/rust-clippy/pull/16634 [2]
> Assisted-by: LLM
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> One may want to keep the loop in a shape similar to e.g. the one above,
> though.

Jocelyn: I will likely send another rust-fixes PR during this cycle,
so I can put this one there if you agree with it.

Thanks!

Cheers,
Miguel
