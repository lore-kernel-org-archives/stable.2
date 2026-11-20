Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795203900;
	b=Nly9c/mrbAbBTrgvCIBIqxsBUNLmvodRAlHbJtd+CxfGW1OUSvlT0qPvqmD3JH9rry0H
	 rfheqO5dEVe3l2fjo4fX2Y2NtPXO9ED61ctygKiYsXnft1qbGQ6Yr1x7QkGZ6Mtm/n0yB
	 P1E6OXJkq+wgGtHXaGI+iuf3PBLx1f3uwq20hAweysa9Pko27KIjXxm0C9ZwKlmMGk91G
	 nnFHtH2On/L7bIm1woffotYvFazaxvoCt+dmmZKR3T/YeUX0uhORqfkLrwQZpYGTHhEvL
	 w/gRw9I763SRhMUfeFwkFMS5s2S+Y1J4tCtseBabZP3ZVeDeX7AzI/oGogi6gERTIAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795203900;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=x7+tW7HypPO42hLMOeRGLaulRUEYCU/KAN2PcvD0X5w=;
	b=ERVQ7HngrrOCwfihAQP+HN119DEqybygi/QO2WG0gyol0oNTSCnKJgwH9oZjObiuqbOC
	 EMHmCms0SJjXpFr9jV0o6hOdSY0iXd5mOdyUcdl9wNp4SF2wTOoH6JyDZH5nwBszjW1T6
	 oskR/MZn0ezNRst+0nqU9HVmYRMqJiqhkyTFhKY8ODHxIVG9hj09w6vC3t6+4mBQYj7yM
	 agVUtrl3pW1nNDkP41SpeeX7hWun8VS0PZE1TD7lNOzLHr7E5Hzyts0/UT4Lp6FfvCnqE
	 VoRNWSt00QDbPa8Z9KxmLw4ctAUfXLEXrQ6erPlfyshSVLZauUlnbr+ODb8UGTUciSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gz2eTSaG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E06606A33B
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 19:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90E06606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gz2eTSaG
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5c09e2ed679so93770e87.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 11:44:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795203897; cv=none;
        d=google.com; s=arc-20260327;
        b=drfKrtiQ2A0rVbMSdFvPFbjNSIMj8gIOuO/yX0ENemDbcvQdBROjLUYAPM5N0aEoRk
         NzfGQOhuggYhCOVWibhIovq05448rZ0TRRLO52cBengiPaKRT3iQBb1fZQZrRjnEa7sb
         s7ZjosbiajRmUULd2ayV3hZhrfQMKi6DYxQtkb99XEmCYPd9KVpM/4vFoc3km3ZTebPo
         FHZBzfADZcS1gEr8VukKnSdA2vF5CcG7FcqAh1mTZCJlioaJ3AbWU5CBjaJSIBsoM9JL
         4k6Syp5gjlxNvQ0Kkw0Jx2xmQK+gkIFdaX3LCTCp44GCifahS93z7TYiKh4uXhGU7IDV
         T8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x7+tW7HypPO42hLMOeRGLaulRUEYCU/KAN2PcvD0X5w=;
        fh=LoCU7cxaMUoEfS3oNpBOZv42yKvZ8AWiNyyLII5V5Y8=;
        b=ohv1KfaEQJdaNpareq02agYilyEnCxwp0AlEvNEgGEk6HuZgX+lfJssevxYFBwKJTo
         RwGu7wwp2L/70cSzUEnJ4NlkDBMSh0b0Qk4dx2a5lvCGx4PEG6W7gek8zfsBhmPs12Za
         1RGjI0X7o/QrrfEjTqw68zpqw7xetgDJd/rqUg//+/n4qG/nC+zVXTzOO5W3k0IRTfAX
         qFmhXbvzXz/mRwk2W5d0A6COooXfW0WTTMp0K17dyipDZhNUW120gi++vPbm+aRqQf+W
         BcE2v4uw2X1bHBZtULjj1vixWT50tTwmRtE1SHPlp1gonAr7DSlFym6Tm+FwMzrZ+p/t
         w+yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795203897; x=1795808697; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x7+tW7HypPO42hLMOeRGLaulRUEYCU/KAN2PcvD0X5w=;
        b=Gz2eTSaGNril2BjpKUQtkMs26AMWQizJ5rPS+Q2Y4NhGnyxDR5NGvbHEcjHE99rAx0
         4f3wExIK1ULhLSBl7jIK+O7WAXJ5xQa2drkXltY+AtSG99KzYSYXi3Bu2fXZ+3oDK532
         FNtb3HOcnYZD45Z8oVRzZjBZJXbhplXeJkPWjcP2Pr4+QeYPbybJoAasfa72HA5Bd8lY
         OQPS3+NfQvJ6ZgmGITfkKnhUNJUs+2GWXlQazbhaH/L4bjmxh5rBuhQKyLQe0ytGBJrr
         QHojT1hnlodc4ZeoVypnVjDL9uMxh96YFDn/Hz31SWbD2TG1JK5btrp/85M9MRSz7qNb
         NVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795203897; x=1795808697;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x7+tW7HypPO42hLMOeRGLaulRUEYCU/KAN2PcvD0X5w=;
        b=zUXMFABwTQbowvODl2NVXNpWlQA4bqaq0UTkkCVjbCPN2W4sKysK7HzEvvfO6tL5hi
         cMLZRfKSd/eXOCD44FHPFeAob6D5puJvf2gUSajN1bSJU7X4CA47d3T0eztQ/7akgTSS
         EPfdPO/dofYSV4xTmw2UJbmOIgDhpu66UAKte9rxMjcZMLjbpmmCletHT7yykUargcoO
         iNuuu8rDvXZXarFu3nhVPBFEOHyJz2i2COvw+BjWfi71i7DU/6EiRoAFNO/kZjDh/2l8
         b4+pNSQ5X2aZwyEm9ErIp3FqV1O+LBavjIa6nlhwqfy5jcXoueerOMbj0OXAFn6XNBiK
         j62w==
X-Forwarded-Encrypted: i=1; AL+hErGKob+BNAysuDrCHYtI9tvPhin1ycC3zR6lWg3INBFa+KSZDowlDoI+9evFIsfvSPYqBsxkaUk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9oC8JxOM5eorGezFAsVHi0Us7M+Na9/+EtT0UV32HjxF+aPgka
	lGblZrPMhCINhNcDPMj5ZXkCblwg13RKPi7ekTrknGhyFyyR3RmH/1451O81RcdzkLN/cfwhlY3
	+GCl6kMR0l0WJydmkVe5kE1v5hK2bDcc=
X-Gm-Gg: AZFdTZeFZJDJqntIuuKBIf2FlXkMMjPYdppaz5PdledTdfW1tSblrbQ2q3cj4OkYxCG
	P+MWnkZZ7kvVemJ3wi3fUNSwOkfgmlPj6UhGd7Rt8ojPgrysZtQ6o1vNwJaVxi/5XjAWc3nKg6N
	QpjV62eK3Ot8Jzwmcjl7O1urHlYkU8hUngOal21xQZ8WDiDnjv1D+zm3Z6bOejk6dXH5k7EO71l
	WLf8v2tY365p9+xY1b2t0P9N576PnFQIfQeOfTRv8Zwq0F8otRZkqjY8OPrttoDMg+Ox+mvLDmi
	gNnFhRqLp/+mxma/5FroJDZvXb+2Mg1+dI2GZf8KjjsG4I2VzIfPoTTmH6nMp39AFfchobuTuzS
	HT2nl1fp06yV/FeuTCCvYib6CLrkHqQ5uD2t5FF9bay8bZy/3JWf4/tOtRIehJ4JC6BQtUTfGrG
	nG8G7SiKSaJFKBWRiB2M740bGglMgzXhTOdnYj4w9b+TEzUtfLIsyljliuqkRK8e+Pae4GCbIQD
	H56+JyKZcb5d0vGK1qvABmsBCvCfhMcxamK/5GfMphdluPqCWjoTR7JuNU0j+7EIviquS8I4aKp
	CxzZSoqhCW+os58mHQ==
X-Received: by 2002:a05:6512:1394:b0:5c0:da9:407b with SMTP id
 2adb3069b0e04-5c1bc8722ffmr1651344e87.5.1795203896543; Fri, 20 Nov 2026
 11:44:56 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120-fix-schedstats-bindgen-layout-v2-1-1c42e4a996ae@gmail.com>
In-Reply-To: <20261120-fix-schedstats-bindgen-layout-v2-1-1c42e4a996ae@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 20 Nov 2026 20:44:45 +0100
X-Gm-Features: Aa3M54qL7PawZ3rq6zWWS_GSU8uuvKfOSc8NrmthN25EzkgMW8lZpFzXsfgYK0c
Message-ID: <CANiq72k3e5ko2vA26Dy2GmVW+8Ja2xmzPydX8wut+XeLT0uYDA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: bindgen: Preserve sched_statistics alignment
To: peder.bergan@gmail.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Carlos Llamas <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Jules Mercier <jules@les-mercier.fr>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 6:19=E2=80=AFPM Peder Bergan via B4 Relay
<devnull+peder.bergan.gmail.com@kernel.org> wrote:
>
> +# misplaced. Making sched_statistics opaque preserves its C alignment.

To clarify, in the comment I suggested, I didn't mention
`sched_statistics` because it could be that we need to add more cases
into the list, i.e. I was trying to make the comment generic.

(Of course, hopefully the bug in `bindgen` will be gone soon)

Cheers,
Miguel
