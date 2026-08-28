Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BCC357CF7
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 18:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787942754; cv=pass; b=gJFC1vQIXCXRhx8rnWaCHYIhKYsDdYd4BMRxT2IqLDGDqKBaMryjdi4gQxGlLkdiKBxWUYa+g8XNX0cQ0qfZpYeLQwEWA0DijSA9C0VFXT9YedSS33asgg3qBIhwvwnPTHn9jLz8KuVv1jgqc5E2jKoftiU9wj9NPgjEzJg/hKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787942754; c=relaxed/simple;
	bh=ge4Ljtv1uU3tLDv0qn+CogzzM5fRFylDnv9OiKMMdUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuVbwuSLEOiN7lZIUW4mJsUFT2mr3V/ZaxWgdWlzrZkcfk7U1LBjg8mhl81pEQg1MQwe73ETFwnwu3bVl1KYMl2DZW7+JWit45QrsASaWukHP0bfpSXnef13bk1rRw473LqpVzPjQvabZVRsNw1asVRtrVQr+Tv8QVI5SSnOZOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=avB0OUCB; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="avB0OUCB"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-499add6348fso6055e9.1
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 11:45:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787942751; cv=none;
        d=google.com; s=arc-20260327;
        b=TOzv+lID/N6Gd9r6N2SSti+PeQJZChoJq7PCt37waFoDzNrTvC40ohIFzuD0pGtuiw
         a6wzgdVXz5jkwCGhn32QIXCHz+6mO10K50X2YqQgAxAKt2rINGJvu9hQdp9mLma1qwCA
         vbWLFMBlYExqFUCZZQA03AzFus/A1fSH88ZD9sUt5/xl3/g9tFj4fd/8MpKOkFxnGRx3
         GxCPBhQR7OQohhQRtVK3WVRgdBNzObrv0GjU9SoNkMkGJ/nEb1GwqjLYVypFexReA2cc
         uWRLzk6FHsidzeWxlleJkX3s3FFNvZLmXNghwx6e4uYhABZ3s5OmQ5REpmJR2D/N3ZGj
         wlew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ko7FEedg7fFwoXFuQeT19PTOVSQvIh4a9+NymvSzdZI=;
        fh=aKkwqZ/yPWvwIVrmEmSPGkIumNCaQpI38Whzvctrbtw=;
        b=ClYa1JGRPlGxH0PdIhG3Nm6FV998kei+//5GBwyEQLM2LYXFoXWvmgiq+zkUWusT1E
         sg6BGUw52WeangWsmH8yZ04RcciHTIiNAWXbPxYvizgv0lsZfW+gLmNVRWCLEG0EJLGY
         H41rVgFBZ3lV0gxPCrbg4x/4YKMENQW68/LuRsrQx+28dAApfzQ315RC2ED2rOHvbR+8
         H4S4MqpnsSladZ99Wxp/D0VbZ3TQ2XE34XeRNM3m19Gf+VQG/+FCX5oYe32qhfBq07WY
         sqC8PMY9X3f+vP5NYy1+ODveFIOcf7oX5vFo/fsu9yLUw+UEgEGDieFrUBCvThV/MD7f
         ZRlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787942751; x=1788547551; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ko7FEedg7fFwoXFuQeT19PTOVSQvIh4a9+NymvSzdZI=;
        b=avB0OUCBiyj8YZEMD1+lg1MWmwJdQwRhUSRs53LrLE6oZ3rZgcOv/J37V1YKQLiM6n
         Nf/4kqbaqL4T+2uPTrwNmUqSiFBKJywR+RTWA7Lc4BDcTF5wLlUh/2fG1OaMsjIffV0x
         1PRD4boPn0yWmYwrXWDv8JY6RUSONepEQZwIhot11QKDNKUYBHBFBPv5B3r7hUcRZAL7
         +W0VUAMLuMv6JQ8UEfxPMr5OsNFYsd3CBZFkwL0ct/ckdPxefUtq0G4F4ibztb8Vtibr
         3E+eJ5gKIVcIBHL/e7jwn14xTHBM+fXf1oNe+7hvLrBUppjrJPtkNtz9AulIiqdk5K0H
         szxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787942751; x=1788547551;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ko7FEedg7fFwoXFuQeT19PTOVSQvIh4a9+NymvSzdZI=;
        b=G/novzKMhSc+hmZO8CsS1MjWqZrKCPKKvMKPKBraVHawKV3+iROqaFxR4ocGKy2Lki
         0Iy2BkvhjnezPRTmx5UwU4N0eFTYzEAz+bHIirK6HTHudaUVGFYPPwJmJ3LWln+Fnbgb
         ax29GFGBbclhbeMTXjXOl0h9uBUaeRNjyi1E+8NG7V1p/CvME/qtYmmh7KqhKJCWS4No
         rNliVIFJwSVQ+GFNcqg1ZO50xf7keWbPrBQpwSpGBieMDwJlY4UBQxXXjCzKMnaSt5Z0
         AmMlPOJ+IjAq7OoLLoUhwEtsjA9+53w1EFz/8DDJF0j/ZC6tEGlYhqrIb5d9JRACMXsU
         ABNw==
X-Forwarded-Encrypted: i=1; AHgh+RoPRUUgdiakIdTxv6UVWaQzbCPP5DNhAIYGPH+DX7a+Nuyrgg18kGXwlh248eoezrnjP5BDn7c=@vger.kernel.org
X-Gm-Message-State: AFuF++nnH4hNHN6glCtWa19XKNGlP0FkTs3BlE71OzZ+YAm/70MM5BK6
	eodJhK7sTS98fNN6qZ5oVNJyvnSxes5E6NKGwKBclDV6FsjLrYiBS7zzGQtz5A1vpqlFuRicDZ/
	pOcvvITimafUh/aTIue9PpJGw5PjKI0ARNUyIegMN
X-Gm-Gg: AR+sD108yrpumV9nALXD2M0JdQBOSgLwpbsWP+Xsldo+U2X2fcVVQV6c/YVyIIvfvzd
	CEwokUJaGwy25oTkppX+pwqYv8FzPJvpV+DWO8fbCns8AeWqqXFWnBZ84doqbXDuu1uH8gfnk/v
	5X3nJMgmIwtV0W9ukSNxlvWLeZueOAJNeEARkt9xEsSc63sSGlOe4LW+wY36T0oIiW5rGaTRRDh
	MgwjAIjWiA8Yv/nfYIi3NjS59bTuGQJ8hppZqrtQmtRZjFhYCMou0xJHK1fu+bqT9qHAiga4zCU
	9ui3/RaXxxxtlKrDsoT43IYg5a3ydp45tt55kjUKJg==
X-Received: by 2002:a05:600c:6549:b0:49c:1295:45c1 with SMTP id
 5b1f17b1804b1-49ccbb8a4f4mr63075e9.3.1787942750098; Fri, 28 Aug 2026 11:45:50
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718111340.159896-1-linux@yoavmoshe.com> <20260827194508.446733-1-linux@yoavmoshe.com>
 <CAKwvOdkSZBbq=e916=efx8G-CTzZ5b31AhyUytO6eJjjkEdMow@mail.gmail.com>
In-Reply-To: <CAKwvOdkSZBbq=e916=efx8G-CTzZ5b31AhyUytO6eJjjkEdMow@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 28 Aug 2026 11:45:08 -0700
X-Gm-Features: AcwNN1Wx0I21Z8-gsT0HKzRa32m8c_GTOdvUPjQzxP_d9dv2tDYvd9upqY_kuJs
Message-ID: <CABCJKuc0cWWdkA7zrCcuze4AE-qTSETuUi-eRewPnn_ivHEADQ@mail.gmail.com>
Subject: Re: [PATCH v4] ARM: imx: Fix suspend/resume crash with Clang CFI
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: "Yo'av Moshe" <linux@yoavmoshe.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Russell King <linux@armlinux.org.uk>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 11:29=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Aug 27, 2026 at 12:46=E2=80=AFPM Yo'av Moshe <linux@yoavmoshe.com=
> wrote:
> >
> > Note: linux/uaccess.h is included before linux/cfi.h because
> > cfi_get_func_hash() uses get_kernel_nofault() and cfi.h does not
> > include uaccess.h itself.
>
> Ah, no, we (you) should fix that. include/linux/cfi.h should IWYU.

Nathan fixed this here:

https://lore.kernel.org/lkml/20260604-tracing-fix-cfi-h-build-error-v1-1-b2=
7015390901@kernel.org/

> > -ENTRY(imx6_suspend)
> > +#ifdef CONFIG_CFI
> > +       /*
> > +        * Pad the location counter so that the type hash emitted by
> > +        * SYM_TYPED_FUNC_START() below ends on an 8-byte boundary:
> > +        * fncpy() requires the function entry to be 8-byte aligned.
> > +        */
> > +       .align  3
> > +       .4byte  0
>
> I still don't like these assembler directives inline like this; this
> feels like we should have perhaps a new macro in
> include/linux/cfi_types.h. Thoughts, Sami?
>
> One that garuntees the 8B alignment of the symbol for w/e that
> function patching routine requires?

Sounds like arm should override SYM_TYPED_FUNC_START to add whatever
alignment is needed?

Sami
