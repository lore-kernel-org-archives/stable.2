Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793953432;
	b=1eyEydXxc/X3q/Z+9DTH4hxIcaM2IbyBzRAf/7kS0i2BW12BoYSetLz8Y0ff1+Xf+hah
	 Z+Rn6UDGqBJQUkiBwxvFFyqzW/ILXVCgAOeaVauuOl8FPl9wh5UAjOrhjKiDQFgnFlquq
	 21GlJ3kD/9ZDZSP/vCAN8tYWY0qcNKbSq4lKr7zyt/K1nXSyeF1A9cGggYpSJVuJYv9UL
	 JlhEe8DvH/BSSrVjzyN3+ter4XlLbUWvzRVYHUZ35dtuYybW6nZQQNBlWJtav31cWa6cM
	 rpbs2QiDcJGsaB2bNAE+HEb8KSPlLteFppYL0hn7AakPSBieolaJl9SgXXktgPTPU1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=5M5PNZUHosrfCDAIz2IVeNADPw3KTbMiFCbuh4RG20A=;
	b=eKYsZ6xUxob/9e4g/MBHT1Qf1azoNK4/zrTObnCNqp2uZGCSAQV3wXkjncRMk2ZPCZ1x
	 nbEu0s0DAcWSYA5p6sjS0CUPvKfrQsIKyDKtFmkOV8O1dj0SeVaEeBX652KwXxkCx/Xhz
	 yggq+GzuP1dukJMNirOHan9/J/S04ltSYzTb0nYHEQMCPhOPPOkhrc6cdj4NXA4N/njFZ
	 W07GmX/5kBgojckXYk92vtb/h3nLNiFXhh/lPlP0pr1oUN6F+42L/AiEqE4eDxr6/196/
	 mP2XG/ajQxpauMHuyRngdij/vBEED49PzJjd13CJ+XLzWhI9VBM51XLOc77MJrQaCYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HiG56BEv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6F8606A328
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 08:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D6F8606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HiG56BEv
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36e2b1db9bfso47221eec.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 00:23:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793953431; cv=none;
        d=google.com; s=arc-20260327;
        b=KL3mdUXaviHkqXOL16W3eCgg5Xwp2GZLe9nN9DPQn4IAN0F3ZZIvfwasyaFUVf1e0b
         eB9MVbYgzinymJOY332pOvSCPntbifYPfFFgkPQohTMx83ETheLkHx8P6jpCX806In/5
         XvFqGk6loO5JWoIHOnCTjPzlNiFm4xWnbibIAg0yMAFtyo3+XSdcgrVYtEA1ymX+2y3v
         EP+/f6Tnv+kw4PSsjZv3uYlEJxROdc7u2YgxiyRILy7cIB8N0T6R1Q/7+/y7gdS89C+9
         s4MH1U1hTggRcJ1KJZOc4ry36/72yK80aLhDTIBRZqsPT7pNd+OxxSJxyaYXkOFk3DfJ
         i13A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5M5PNZUHosrfCDAIz2IVeNADPw3KTbMiFCbuh4RG20A=;
        fh=FjeIOHxbph29gj9msslRXZbtobOpzOiFLK0r6J2FWa4=;
        b=Gjq9y3NO+Ft50YTf+h92MJWdNIL0ctyQ1+5FP1W+szOP8EOtI+dco1vS3wIj3UsBWY
         SrJCA/sckZgUp7k9PKufN00lYgQaGe4jVFg5pxGZ+O4lwa9zIFKaVw74HBriMeHJuard
         +n8i7aFeWlx4mmaRLQXjGmzOfhCEqCHrI4IdNSqvWDS5dKOXO32Wme1QNzhF+HIr+3EK
         mudihDODq+e8Z338llm5ZET/V912xTori8p+RVceAPqNx01DRelKvjWPzVFLCzOpz5X5
         xYh1WhW6eG1N8y58VM7Lo9glX+ylAHQCEDtpdCyUc0kV2uShuK9vzHcERqIWBmLH4tNn
         wOYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793953431; x=1794558231; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5M5PNZUHosrfCDAIz2IVeNADPw3KTbMiFCbuh4RG20A=;
        b=HiG56BEvshF0wNZqTO7shg8U5Zon2BOVfV5vD8crvhHQm5JEZkjD7LTHWUnxi73IVw
         BYOeGF/g+rCrqBcl60JatSLWjMt9h66+c/T2e2nl8x1Hs4M1zcmT5Eif6nXJH0PWw7FR
         nJoRkj7ITNhuz31VlZJypE+v6iejH8cevdhmxhCkaFzEyinifbTHSjbeHc308zzhWz4c
         VOzSX3sMkIzvIekTXhUU+4ZU1EJOseeSeH3X7YsDwLWCHYuO45A4SzORYQ7vvernrJvG
         pU7yYZT4S5OI5fbPDxjRxoIZteGzbcLNIkIzyBkm/zSWahB+W47ItqMc4tgJM8AVLY/C
         XM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793953431; x=1794558231;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5M5PNZUHosrfCDAIz2IVeNADPw3KTbMiFCbuh4RG20A=;
        b=bnkiXQpCJ/+R59rFfmdWaffZFEKU5HEJ9/yq4R5UrUIWEl9cTtqcLsJMgkA2ClqRkJ
         gsqEMzLjIM3RUk4+a6MWbKye+QN1Ea+RsZGH6S0cVNj5Nm27/7+YEesmiohGcTZfNP8o
         Hqts1N758o3oYKCj4Taz91Ue3tt7ymocQvhQpqzFRFYefJz8plcpeYfNfcmvnf51SfEy
         aRs+S8tfx8Zo8skk0vxPfDwSsXxV38HWcgeTI1hGBFIVDFq89+t26GLx3hM2SVLe5Ssj
         XtZEgmaSywLnVfUUUIIsLgTAqxMBG6qUUJ2XAua0U0mtjFMiR9P+HJrE4866HDs/nSwy
         5JHQ==
X-Gm-Message-State: APuU4Z8NVybnZQldkB/KUYm+k5qCwhsYYHG+hGc5gCVWZqErSVxQhoYF
	YqRr6YnwZSHO6Xrk3hKsyaa7b1YYEI3Pw7dZ5+WHKGk8VO7jjTQhug8D3CHklQeAND1Zl5R5Xxs
	cCZ07YAw8qsfC3IyHJzahOA1KTbypfvWOysro
X-Gm-Gg: AYBFou1mV67ORfZUEhBEU5KlX2d/JHa4EcQ6nYLf4qT9aWA9DQtkC2g7L+tM1AyyB2M
	KLkCy++e9QBHgnmDpBRdztdhn0dkBi3zuGClmw1jfIK3QlSgM2L3cMrzrAD3Ngrv0D8tw08e++6
	15NgAhHCpYzFPsefXh/fH6gKj2OaknbMIUEF1mhkBUKpTyStnselhRHCwsfKTFphPpROm/fgg24
	yb1+5hjVsRF3mxUQErGdE2iNE3OhgSebtC9LcZT0tpb1BqWhHGtdQEyDUEusUvM3m6boCp5pMj3
	wEoevE9lOaMTaZl3qoztMP7hJu28aWUoZGwxmHM4rNu52IZt7///i6WHXzSvJVG0UEbYhrf0sNC
	IbMyIIWBKJCW6UMK8vOpwcZxbtRJrQmFqdqfaowfLfAGUFa2iIejrAGa0sbAlgh2LaS27zNapyh
	p8AExcmGoS4doXNjc6yKA7WhSGw8yPZl2GJwb6U8jgpuEo1JEOkA2UEC9iaRHdjgRzOEhA2Eeb7
	ECVXaAaqEUEtLrbSY+V1+IkgP2WGkWENtvT
X-Received: by 2002:a05:693c:8852:b0:36c:a1bc:6114 with SMTP id
 5a478bee46e88-36f6f3a068cmr3642296eec.0.1793953431201; Fri, 06 Nov 2026
 00:23:51 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <2026110447-anything-wildcard-f4e0@gregkh> <20261104201749.344995-1-sashal@kernel.org>
In-Reply-To: <20261104201749.344995-1-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 6 Nov 2026 09:23:38 +0100
X-Gm-Features: AclHuK_1H_swIOJhBR77KhBzYYhZyuiq7F3vCLUBXCi_ciuSKWwgDqd4Ci4DFHM
Message-ID: <CANiq72kXBEqUhzZpq1fOvejwHsEyD8PKzA0oqz_DmPt7Q2n7Cw@mail.gmail.com>
Subject: Re: [PATCH 6.18.y] rust: bug: pass TAINT_WARN to warn_slowpath_fmt()
 on UML
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 9:18=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> [ sashal: adapted warning handling to the single-argument warn_flags! mac=
ro and existing CStr API ]

> -                $crate::str::CStrExt::as_char_ptr($crate::c_str!(::core:=
:file!())),
> +                $crate::str::CStr::as_char_ptr($crate::c_str!(::core::fi=
le!())),

So this one looks OK to solve:

  https://lore.kernel.org/stable/20261106070543.89122-1-ojeda@kernel.org/

In the queue I see the commit with `CStrExt` I mentioned was already
dropped due to an earlier report of mine about `CStrExt` in older
kernels (and I guess you decided to send this one fixing both because
of that (?)), but I don't see it picked for -rc2 yet, right?

If this is picked in -rc2, then I think it should be fine -- I checked
it solves the build error indeed.

Thanks!

Cheers,
Miguel
