Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515DA2F8EA3
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 22:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788476120; cv=pass; b=SZMlhedwwWuYnfab3T4ON5CCh+LM/8QnO8g1n+D5MIH1+OB4ONtnIc9Avsc7tZyghnNiST+aRNvPD5UXha5tBov6veZAwX/GcktqtzRXRudp53cb916gF0qEdAYfT3E5MIECHNm8ynsO5LDAeBq3ECnyDUyAmEjFThjbGd4KlR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788476120; c=relaxed/simple;
	bh=Ereygt7HTSWSKl4D6olBnicFxYCLCCJHqv87atzDMEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WMVVkjrx/gGu9dWVJfH1DPJapUqthyDHioFV/XsmPwnTPuZ/BMS0xskAWB9KL4Mkrv5a9MHElbAohbkDCez4PTbdhLaD6LNahG0QSpVZ6fUbNqX8eG7UlK1r4S7OK6O9VOzVzHQTot1rIc9j6glZbXatvvIOsEnaX7cdIuolzmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuKczD1U; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuKczD1U"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-396555b8c7cso42990a91.3
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 15:55:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788476118; cv=none;
        d=google.com; s=arc-20260327;
        b=XO32CQ6mE7lp83yvmjOO1t65ku5b7YOzO5fWoD9ljEbS+4luZhGBbyr+S2k8x2Fzvl
         Y+dGtfSPPyBYkU3/lVKdjekD8soEkh+WHgT3tIbHOl/d5iu3WGJ46E3ZuQTm/ibXUSw7
         nRp17V+wNI5OGBH/fBzuzlOTuUtV9irjx+9ekaU3H0xskv1/S3FBFAJWGHGtjxmxNoil
         n+IltIHCMGyuBwKMksi85xZYx4GRzutijv3HXSdDYIN+2sSH52dgrfccmvu2K4e+tbeM
         G5wYwWM2dBAYowc/qJ9PwXBsRt0hw2Qst3Of6Efdy6rjDfXadtCFyjI9I3C8lM5JMaki
         Ezag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x5JVoFY9ZeQExqc2q9FWswR6O99QHIYdIyNGXwd0Ync=;
        fh=cZbWHU8S9QcNuo8X9aJ9hXIiemD4aHH1iq5DOvUrXVo=;
        b=r9NgEqMchcSqG9IspUGda+ATxcQ4qvnQ6PW1WAmDz6Ch/v3UkPV0+ZCgXBWdS+c7CT
         lKHGf/21IAAf8t/HA3OuA+oNeCKo13A1W+SJcPSWaBqPGYg2IaCj+vanHuqIQt/uQuJV
         Tm5o21RH8ifAmflwXQ+JYQRnOGvi8+QMxc+Us8cN5M9tQ/irdBjAV7s6SVxOWLDUMjhd
         i0XICC/de0j/Za3BObm21KVYB7oFaOs6oAbdpbcScRlVRY5husFUC7c1fRzPLzvD/dfi
         uKP/4iFZd1PHjOZll0MI5/lxRBPgSkmrzF3T+ty1zHYeywumGYwNKFHUYNUJCrLKohIU
         /l8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788476118; x=1789080918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x5JVoFY9ZeQExqc2q9FWswR6O99QHIYdIyNGXwd0Ync=;
        b=KuKczD1UYwP4AeJUUdhbkWWD2QJcnv6Q8Ec2TMLW0XCTiavXZBQ6RJI3LuNE8gy5qj
         Fc17NLD/bUv5lg6FN9lBlEDR31WdQiGTXgGIvkZuMgmk4lnrKcSU7tLkdqAVf6bXiD7h
         w/GXTvuBRJaAnBrR3dtacuP0XgtPr+5rHVDAL7pPs12nWkcnUFbHuRlooRcFVCK/li8Z
         dQAlWNNiORcsRVH7yWdqrfhkT3DWiF5633+hQ45Gabxrg1VcvDSTqc3HXpzRxmEWOBOV
         osJeqRW+z0YaOGk4WA7I5Rl6RUk3CD5AODZPrJsY3CCRbbig09xk6ecFsoypwTI66QgR
         0RQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788476118; x=1789080918;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x5JVoFY9ZeQExqc2q9FWswR6O99QHIYdIyNGXwd0Ync=;
        b=pnpWnC0eGz3KgFzUFEIxmhwS53RH3g1WsDOfseO+V7fAkbDlft1Wvq4MC1E0zAr40e
         F9ipRZDQ9HlmSrsorur33ckfB0gQ4s6PBa9mQCZnye4ohExpk8NylAM11w2O5OZdd8zt
         dq41kXDRpRoHR904U+/tr885fJ8FRvp9U6a/k70Y9DMjCCi1Ht6hRlR/vWGVFwYPJ8he
         TaT6h8S42A3VlepAn093hxyOd8c64gmYJPg91EO4QNxXUqvXZlE8KAt+QbRMadAhDCZ5
         q6wRp5S8DkTlreIpKMq+m9ywQE0vb6Y0kz8DE4mE/l6wXby+XCZr1sPLWrPIlUrxnBb2
         bQdQ==
X-Forwarded-Encrypted: i=1; AKwUvBwY0Hx9IOr3qLG0MrXJ29dxH58U2Y3DJmjTcXl/II5mqu717d4tG67DTcT/IAMKhwmAPwTmsw4=@vger.kernel.org
X-Gm-Message-State: AFuF++mniE1haSkpDmhvNgHD2Hd8u/VOUKfiDaXuqUoe+0+AiCLQue56
	hJiLETdIq5PWfYIUlPRx8q2fcRH7L/Se/PcOYfZvlhNw8HiK6JgH7+/DjcVRuf1FNa4EKsi9Ju4
	sGbBOXjhFxgONeGgJMM22v6rocn+o8tg=
X-Gm-Gg: AYBFou20On730aaOhi1e2mIoO1HrCBZiXRNLg1I04ZDfbXdeOzlDvixgRQH8XZWJRjL
	TTL+CQSGHktaYezW5kAPWPlB4p9ODI+gDUpEPnL3SXRu/ZYFqu8JXvDA5RDYXvS1ZMZoD7QNWjx
	BgWBougoH/P0rPEswMtxNmrx/x644m2OwEQ7UYEE59EmgXaZRwynV6Rb0ULCikaV0XeFv1c+2S4
	qCZQIHF+XpD5aJAfXl1HPZzofaI25TQS+l6RX5cZM9AkbYAKgI7IiZ+ty5y5qO5QsU/6Db7qrXi
	Oqi8LtbLQq16mpMhXL5B+6EOhJWZi3O3moH8bFcJqPtMkj1C8K8VAbtY+kAEWJ+Mo3ewfua03TX
	INjN2Nd3XPelPu49aHcPeeC32vhZ6AvfjVh4LJzsA8JQsPhv8I5HEbM2yBEXq
X-Received: by 2002:a17:90b:4b86:b0:38e:76f8:fcbb with SMTP id
 98e67ed59e1d1-39b26252efemr1538724a91.4.1788476118088; Thu, 03 Sep 2026
 15:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826145642.43807-1-ojeda@kernel.org>
In-Reply-To: <20260826145642.43807-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 4 Sep 2026 00:55:05 +0200
X-Gm-Features: AcwNN1VrwzX6ASP8KVz13RNpM47mRY3LWDyEJ1EhMzZ8gy8Jz0UYzA8WhpqQQjw
Message-ID: <CANiq72kFZ47SE8PmNe483T=+F_OYzFiP9=SEn_S4jCM=S-cSsg@mail.gmail.com>
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

Applied to `rust-fixes` -- thanks everyone!

Cheers,
Miguel
