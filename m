Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39AB42047D
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786806039; cv=pass; b=A+lTHbhofH7SOOYVZXaJXYbIBsEI8Cfgbwlm8Ncpi8ZzQvZY30AoxlAwjdj5REUtpbO+NUM7ofomiU72WFCRXyR32xKOS3IWrGxKz7wM6N3ZYUSt3unuM1ILvd8xC+suSWv4wa6qYITISRLrg6bAniHrMBszUlvGBpUomqjfXrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786806039; c=relaxed/simple;
	bh=F80T8bGizUmF10YfgJvolA/hvtxH0CvhCxqiWGyLA8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GIoQwmirgnNuxyB8d6SlWvAdba1Hctl8hCSpjIfGW6/aeZqL/ZwsOyJMjUUcoDY9GjYhDETFjzOvhlPSRPOx47Hj0cIiT7KHsagoKxtfnlSTUBzMKgh3BT3cvjmsGWaXLA/GD3AgB1UJRC98Y+5OmTGiWgspIkkmBxgW3ru2zks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHj90k1i; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHj90k1i"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38fe113c792so166843a91.3
        for <stable@vger.kernel.org>; Sat, 15 Aug 2026 08:00:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786806037; cv=none;
        d=google.com; s=arc-20260327;
        b=MPhCJbutO4uBob9QpZN8QIDB750BnjbARDy6jeoNmqew72/HhCxqTUeJQbpR1HbHzG
         2bytHwl/BrQtEQd7nIiGeOmLmHnoZFEgwSRbBV+JkzF6nHH6IfJgJjvVyVlFXisc+rP9
         Y4odgWvapGU/JBRlqqjnsdbVf2VoaAPwEr+XOVQn1D3nwGi+P5MZ2xTYACU+5eFWVm/D
         gluLYW2uXBgAmAFJhdOEG25tmFAtQaK4Oi/MX1U6Ebb6ndGkAyPp5In/4dzuWvN3mAvy
         YdOJyBXtT4OPteBOoghuZL+p3AE1sUl/MYxfPTEjBuxvx7Xu7FDA04+NYMLxka3H6k3m
         MuKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F80T8bGizUmF10YfgJvolA/hvtxH0CvhCxqiWGyLA8g=;
        fh=a6zPGTRfEnaQI0/PoITHnXnkGl7WKKG7xRgHape1p7o=;
        b=KyhCm7DQEPON9Y/rJHDYhlAONbTFNsyIqYL2PjOBH9W7HT3cUDjTih0gKjfZh9icb5
         YtcA6aR1sHp/RXMIPZQqxXbcqQ5E5A6tb2ivFhFxW7JW9i2ElyDsyuFXevhWEzwuDi80
         uLoV2yoyt1XFCQpaTw+Cr3WgLcY0fZHNaqsoqefLTb5qDw/jmtUnxUv0RuyufiMNMmgd
         DiHx9BKrop6NfJqQpgVorn3P5Z+BarsFI1jlwATXBdjIz8pPmynB6mPlMVApFlwwID+2
         vecfeVZnpfZocBbgCBcZBxHLou8tHnfaVbQYxIQ1QSTMn2ePu5uyndcGyWJPEaCpH0Hi
         vSoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786806037; x=1787410837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F80T8bGizUmF10YfgJvolA/hvtxH0CvhCxqiWGyLA8g=;
        b=cHj90k1i3bCDtBM3N4F/mYj/KMSaqAOfO7Jnkh/0gOe8ND1QNz/tvWscEqnbn/c5ei
         Auj4krh1VmuUWPY3tGSw3wudjzfxV/L3ZQODBy0IGFlZmPms9C8vWKORVksMFzCTNA25
         fBMZpHDwdbs5otcqWMDgTPGy3ccE1AtOuZXY/tRZXNm+cqxMmYi4NJHKDrNgUNxZ0wI9
         eoyvt4xDYe8vubTFYq0Pxg0wKXtuujLnrwqUEs6/HrYOSACcrUlJfi+qkMGkw8VzCsQx
         Smak8HqrHmyRrUWJ9eVG3OR5QmTbj2rjfD59Ox4Ob+qMRBJWl092TWdvE82m8DOjPR4U
         jAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786806037; x=1787410837;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F80T8bGizUmF10YfgJvolA/hvtxH0CvhCxqiWGyLA8g=;
        b=ivgzKEl0BcT3+yLLX79pUQJ/IeZmBnwoLT5Z8SrZ0wI/GsoqN5UtTBPEQ+JD16smXL
         FsuPsKpBw0FxIfdarjpopQuGwoCcXBCChenWQirPZ9SJ5rrapMkJj8hkJZG71BA/H7y0
         qozbWvHuiyjWJ2yC9UlPGA66d4SATBuAjWLSXxEviZjCm605O7mTrEzQTksH6HX6H2K0
         43M2lY6c/deyAKEEF8kzK/EhtWP5QaEjjXoQ+oQoHxjIqH5HUwfEoJ35VsKJYoToATRr
         bifWgmTTLYjQ1SbWruTcGfsWPYP61VxNmOxk28C/4cbSko6x+WWwlVS6KDZ6PkVC81GU
         5kGQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr0yp7Fvpqi6Svsb4MjVBNgi2TLTJUELP5xGqm0YkPXSbmb4cu4NKN6siii44zSaW6zAfhsvKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNOS4L+SI4Qz11i4SuDLprRXqXiijyVhvJYHpiXQAo4Z/7RrqJ
	8dprGbx+kClga9nQo7FkrnWxdN+q3CPTTGY6P/tRHCE221yOh+AgF3+igX+LvN+Wu6ZuPpFsoRU
	LMkpx/utQQ+tI+OPqiJ9WebW3W71tmUc=
X-Gm-Gg: AR+sD10il7/T1w0Wu3ZT4aKujqujfRapigiz3MjNcNHrMzxgFOQq3Z5tSCNblC/UbKo
	VBLRVKFUNOS+d7CWfUGWlEPa3JHq3wxJxUO7wP0OxqZaW7iSlYixR8q1blCUJcG3jLlsACcsydd
	pCwbf5hcX6Yjel46YOir+iMV2lCufiWDBBZpaLk2XEKu+YSC6Q5LZB0TPnLP/6GnhTfmYLx/MF4
	xVKwgB+UP1S1it7bzhC7tRL3fe7IrvnFguZ3QF4nC5DvEYnhUnFNu4xYwLzI2ADpag6rpPw3o1b
	Ctj4Ua0TL/CyPeit/f+hbTCj+p3AzCWMVgGpof7Uk+P0J5wGLlo0A0eaOzJXHNGlJRqpUGwYPKm
	obBYoLeMhLZ52BMe8O3NvjIOYqfAjGp0cUhBHCkpJgofYo/AfW80of5rguzUq
X-Received: by 2002:a17:90b:448c:b0:38e:55ec:e436 with SMTP id
 98e67ed59e1d1-3933b4f801dmr10089002a91.0.1786806036827; Sat, 15 Aug 2026
 08:00:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815-fix-rust-bounded-from-bool-submit-v1-1-882227bf40ba@younes.io>
 <CANiq72kAkDeyqPKHHMT3gRNyC35R+934jNNQOKKytMpmwPwLCg@mail.gmail.com> <P-4v-PO--F-9@younes.io>
In-Reply-To: <P-4v-PO--F-9@younes.io>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 15 Aug 2026 17:00:23 +0200
X-Gm-Features: AcwNN1Wn7uixZildjRdjg8WS6aPMk0JG3Kwzib7LF04dEFlUG-lVVTMWQqy26Fk
Message-ID: <CANiq72mDbUzggU3uEK=DDQCxLr7Gzr3sFTCUUewt0XS_pJ-tdQ@mail.gmail.com>
Subject: Re: [PATCH] rust: num: reject bool conversion to signed one-bit Bounded
To: Younes Akhouayri <git@younes.io>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Yury Norov <yury.norov@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Rust For Linux <rust-for-linux@vger.kernel.org>, Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2026 at 4:56=E2=80=AFPM Younes Akhouayri <git@younes.io> wr=
ote:
>
> I tested this in a Linux Docker container with Rust 1.85.0 and two CPUs,
> alternating 50 builds of `rust/kernel.o` for the parent and v1.
>
> The difference was 1.16 ms (0.066%), similar to the identical-source
> control at 0.96 ms. So I could not measure a clear slowdown from the
> patch.

Great, thanks for testing that!

Cheers,
Miguel
