Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB79135B136
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788617550; cv=pass; b=ZC2eGZnBRzMPSU/JfWKBYK+dmurr0qjq3j65G8nHtKyNCRY975jZ8kIZ+FJyxe7Pt30XBmnyshlq1iBh79DdnrslI3jHdT2cL2LEpKKlKb6cL2yEZfmF0la2/Nz7PoyJnxTaHDtyq7Is0GI7gO+WNZKtc/Q9D9hSBF6bBUF6Qk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788617550; c=relaxed/simple;
	bh=EFnYeSVdKVXMd6TO/Y43d+8KL3G7f3KpGkTiTDfCLDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HsOe3DUXGoXk8YKP1QIi1/61ln4MIdTAN/ngslyAXZFIRIXPxhk425g8t/nGQpvcH6VCpiomVsqGCuYfAOSfo/Kc1bF3ZtA55913IxQXfD48tJ0ovYNfoMrYfVzRLDxWU3xxnOOc9Mmku997TQT+yM7EhJAVs6kWLNnozSPdzJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5Vxm4Ik; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5Vxm4Ik"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39666e7c9edso82970a91.2
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 07:12:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788617548; cv=none;
        d=google.com; s=arc-20260327;
        b=PJPv5Ej/LjF6RBiejyudDkNnfjoNtLuR+UyzXXXPRbmkjC9ATdNxsLACgR/kK8oYw+
         dNYYT0ryoGDzRkBOm6hsEHsUHWVkWIAbWs9RMaxt9yKfPKAjUK7E98QvvAAm+gMOYxVB
         j7cp+MNqdKnvO7t4836kHjT/uGfHQGDLKYhCwgof3QDcOsgOuAMcsMm/RhxqoSeIdO0D
         APwcERWKVSCTcaGTidhV4MiBXExToUeiA8gHJ6Rx2UnZnQCVBxhJWPM9qfeds8jZ2JZk
         cv6NB4KomXr6t9JEBavsLCQR9PrLo56w2/yFTuXheHoLFktC2lNJglZ0oB1LCfs01vsA
         dW7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CgPxNoeOKOJ/enPgDZxD2BJ0wdJ0wbTm11Fisl0xW2E=;
        fh=cwZxL99HKGHzFZfaNGmAKF3yrW8oVQOqXPeXwaWwR4U=;
        b=FfPKSBicq7TjxPDG+a1I0Fxd4d/TkvOkSTGi0+yvKn4TK5vtfxDFSw7LD1IrDbBXfc
         keiJJgPfFnr8JyMXRDaMFN9gGRds8zPcfVYrPqFrtIxyDyxCrX7XhKPFhfaUrohv+tPS
         WzdNRiRygdjuUp7GRE6zfaRnwXv0C9cD18Spy+0v7heCXU00eHEGmLMXQmPcwDWbkyy5
         dU1eukM+VJcYoTJ/d3C5zzTUC3Knou8o0CcD/Bsv/L+fyGx9jOcB6vmlsJAFBsINbaN6
         vADtia5pJ0Elm0jxEIpTnRqiKNWkIH1w49J7+1DVPNJUCsi1YXy7batwb4yz/pn1qkYo
         O03A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788617548; x=1789222348; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CgPxNoeOKOJ/enPgDZxD2BJ0wdJ0wbTm11Fisl0xW2E=;
        b=l5Vxm4IkO9uXIUrqAJnvXIdiw7nos12djVac3GoFNTs6SGkgygGMA6ECPSBFhSDh8k
         dkODv3NwVZJQe4y18YVTGvZW+oQxUvx/Ds++imzKLo7Ki78GNPxGWXnR2DH56QMjtJb1
         O1HEXCaJOhGI19ooUYCU/jwbCWUreVO8SJRr114GijrJXXRmOmri1INwcUC1YQAmYy//
         Qdj0KgKhPpQVTnBUDU3f8B4ks5EPTH0j6/fqNmtSrZwznM2dM6/kdPTZdla6U8Fm4aL4
         kLgGf3rQXSXXIN15t7gOjJz/KbipH5pbQQ8BG30fZcUc+6CVj4qSw8aLcLGIoCdo4wb2
         ca9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788617548; x=1789222348;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CgPxNoeOKOJ/enPgDZxD2BJ0wdJ0wbTm11Fisl0xW2E=;
        b=e8LPUX1xWVp45DRs7biQUC7m/4M9Mi4rPh4FCVSa1EI9y78hivJRpcbZUrRlA+IrNy
         Id81ESFh7k0ZOS44xOfhq8uflojQRgw186fmPHoccHFMM7efJgIJx8YbF95qVO4spX5X
         qAwExyZ6yrT1itH8Y0G72gs/cGAjh/cvJdOehcRnz7B2KZhisx/EjW6S1Ld8kS1N4nCd
         C308xWkAycYBps9iwQJeposjbhX+tQoFIG+BFkj7xqRwVaC45PbNE4ritmwFxQhrp5K1
         Fo+O9miAr950YkFfd6ZUVk9a5EK4runsAZU4CMNY0QaKJjeZTxnwk7qJt7SyQ3pXOcmc
         GMAA==
X-Forwarded-Encrypted: i=1; AKwUvBx7JyPsb4VYTPoSnEFmXQak5Hr/fBTRFo/do6Vj338JAnlXlUi10Vw8vExWACuBAwXOqU4N4aY=@vger.kernel.org
X-Gm-Message-State: AFuF++n/WGu3bPOFECrPLXvIAKkTdIbQguVobdaZsEAZc+CQfNK8K4DV
	SAY/9U5vWK5McvJpxqCTt/4L212PAVjQi/oDxFQjAXSDnVYJ96Xchg0KlNhdVK/qyn8NPXzZzG6
	OMGRNuOex6tmneUIeqwgeT+cT/M65QyQ=
X-Gm-Gg: AYBFou2etBT4XNsK2PXvmvbbb+Ze6HJ4V2mj4A/oCxhLObNcVM6fOqStyfLuF2cRV2G
	TilWIjhM64BjA7wBs1I2X58Qlm1UJbj06HeEQYXJ19xLieveCWYhfQ9eSmRf3IdjGiyk1yS6AHQ
	m7wCqXipx3F9HtwDZ7PYHNJHuD/zrzf+XX3dCqB3CJRRQd6N0Sfs48U1dHD4w0XnXLMdjvxbd/Q
	IN6z4/QM+qRGLIK7PIP/xGOUDfmlyWapz9Aq25MZ+drWxQKhteA9/nqPz7dbTTx+6Y4MyS2MZsj
	88hNH988SfQWqyatcAkRQIwysrWycYjASrKLgqeRxrAjI/KI5eezYmgnNHzNTMruyWTkcfyQpvD
	w239F0EXsg0EjYCdpuj8n5gjdREGVfgQXK+qJsLgJpVCW18hWZi+83O/TNO+V
X-Received: by 2002:a17:90b:4b0d:b0:38e:c140:2a0b with SMTP id
 98e67ed59e1d1-39b3d78fb3bmr5583794a91.3.1788617548109; Sat, 05 Sep 2026
 07:12:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905-feature-rust-num-seal-integer-v1-1-83096115ad64@younes.io>
In-Reply-To: <20260905-feature-rust-num-seal-integer-v1-1-83096115ad64@younes.io>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 5 Sep 2026 16:12:13 +0200
X-Gm-Features: AcwNN1VugqNSp_8Ein0XE1Abe5QXhVthwvEHazcMbqXG-h6bVCGPCS19YnQwxxw
Message-ID: <CANiq72mMtbyBE9Lb0PUT-mj5pzOzauND8_j0Hc0mOGuMnHWB9Q@mail.gmail.com>
Subject: Re: [PATCH] rust: num: seal Integer
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

On Sat, Sep 5, 2026 at 4:17=E2=80=AFAM Younes Akhouayri via B4 Relay
<devnull+git.younes.io@kernel.org> wrote:
>
> Integer is currently safe and externally implementable, so an
> implementation can violate those assumptions and make safe Bounded
> operations reach undefined behavior.

Ideally, we would give a brief indication of how that can happen (like
saying "e.g. by writing ...") or sometimes even with an example if it
is short enough :)

> Fixes: 01e345e82ec3 ("rust: num: add Bounded integer wrapping type")
> Closes: https://lore.kernel.org/rust-for-linux/CANiq72mOfR33s4y+Ueivd5NrC=
5yre+Pcp57ZOBz0msw9A4AP1Q@mail.gmail.com/

Reported-by: usually precedes the Closes tag, e.g.

  Reported-by: Miguel Ojeda <ojeda@kernel.org>
  Closes: https://lore.kernel.org/rust-for-linux/CANiq72mOfR33s4y+Ueivd5NrC=
5yre+Pcp57ZOBz0msw9A4AP1Q@mail.gmail.com/

(But it is fine, i.e. no need to send a new version just for that)

Thanks for doing this! If Alexandre is happy with it, I will take it.

Cheers,
Miguel
