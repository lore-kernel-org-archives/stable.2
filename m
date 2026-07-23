Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001C4432E7A
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 09:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784799876; cv=none; b=jV3Xln/ca2Yc7HQkj7buScET/d2H4UamNIUxldhT3LnXF5BCwvEDJ6hZbIL1ePi2nndsVOFyRScObTyERsrXzAQRHlYkMvEmaBfD4+3LdTHwlEoKZNAPgknWrZH4FLUA2CDV4v6UWMJ7v01mRCVl+BVsVv3rBDiOO38BQ31X7V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784799876; c=relaxed/simple;
	bh=tz7OO3wCjOe1LJryPg0gYDnlsWt7deLgozE8i5WrNBI=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D9H73nCMWkIyy63+MPSzstyNaAUACAM/fyF+KMSycwcA/EvfCdZMFHcl+ph6r5CczhE1AtO9EcgNscIOehMaRTlF7sZZ0zx5/RlIvZFdmZrzQiDdlQpCuk6P46x3brN/yEL+vRu/6foL3qDZvKJc6n8aUsCRQPdEmrMN3R/0aEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMeQGbPF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMeQGbPF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F49E1F00A3A
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 09:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784799874;
	bh=upJm9Q93FoQ32YOmgLd56LAW++MWJuCBKbNFi1vKSIY=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=NMeQGbPFE8babLxzxEONQnEXaHVLfNf9v/rHkc53TaRiMtEbX17AwvCdeQUNvTTQX
	 YgH91nahid0wW3ZotKh/vAZVJiuOesnKfi3Rs3M+/UkCL08GI/PN6ud7hpJ7rYgmxc
	 knOz3lQOWTVMQA/gFhppU5BB0p+PvjdKDvZkcfc8lPo2pvFxcgn9RtzfJoahzc5urE
	 TruLLHuezk/F1SG0e3jL/WkdvkgLQ60JWbagHTtj65luOjZwfhCwnfaBEHsenoPUvI
	 JjagEp5VgW+xTEUC67p6GjwpA3hGuuQvlIukVQZJSM+RsKb2AVKK8W0EhHbg3/+CAF
	 XBdpon5FV5PZg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b2aa3be376so297114e87.0
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 02:44:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqt0cp6jx9gN8knJYh/eMc7daqT4LECgz6wdhhopwHqpqtTgibZVegYZJgkFemBaKnHMPwG8ZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6qXhV4PF6xrP7UgKDCXyf6l4WSGKFZjWk2DxwID8YwV6yOnOq
	Ik9cz9gP5i0o1No/MIIIleD2/+hskhficFQByk+aTlEPjm3NGe6D2vTOMoGGWxB9WP1wsOEEx5I
	pW363gBXXHrttcxZZgACRGnhD7OejU2rcMCJiODTD5w==
X-Received: by 2002:a05:6512:340a:b0:5b0:23c3:4f55 with SMTP id
 2adb3069b0e04-5b2b2f72e6dmr483668e87.53.1784799869499; Thu, 23 Jul 2026
 02:44:29 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 23 Jul 2026 02:44:27 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 23 Jul 2026 02:44:27 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260722162040.GC2794619@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712-qce-broken-v2-1-b2dfff47f7f5@gmail.com>
 <alnlaCXmoLRAlr96@gondor.apana.org.au> <20260721082501.6128-1-bartosz.golaszewski@oss.qualcomm.com>
 <c826b73d-6307-4237-a065-b7a8487350ce@gmail.com> <CAMRc=Me55rUmjjR+ZzdWd2ss9JJMZzJch0zKd4GqONBjCzFMYQ@mail.gmail.com>
 <20260722162040.GC2794619@google.com>
Date: Thu, 23 Jul 2026 02:44:27 -0700
X-Gmail-Original-Message-ID: <CAMRc=McTUmyCNvW6qECR4rnVQNLAWLnOr8+fdcZEyDfKESifHw@mail.gmail.com>
X-Gm-Features: AUfX_mxedXof9O40mfMVKV-BEEyZQWgJJjJYjRe7y_syomCjENHofNVGIye_ej4
Message-ID: <CAMRc=McTUmyCNvW6qECR4rnVQNLAWLnOr8+fdcZEyDfKESifHw@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/crypto: Mark QCE as BROKEN
To: Eric Biggers <ebiggers@kernel.org>
Cc: Demi Marie Obenour <demiobenour@gmail.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, stable@vger.kernel.org, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Jul 2026 18:20:40 +0200, Eric Biggers <ebiggers@kernel.org> said:
> On Wed, Jul 22, 2026 at 01:33:51AM -0700, Bartosz Golaszewski wrote:
>> > Also, what can the current driver do that cannot be done better using
>> > software crypto?  I understand that you have future plans to add more
>> > features to the driver, but those are not relevant to this discussion.
>> >
>>
>> We can offload crypto operations to the QCE saving CPU cycles but more
>> importantly, the QCE provides HW based isolation which some vendors care
>> about.
>
> Do you have any concrete proof of anyone using this with a specific
> Linux kernel feature and actually getting a benefit from it?
>

I'm not required to produce a proof of Qualcomm's clients using it. That's
never been a requirement to keep a driver in mainline. I'm saying that Qualcomm
wants to keep it and I've stepped up to fix and maintain it, which is what I'm
doing.

But yes, I know about companies that do use this driver as is for whatever
reasons. I'm not sure I can mention them so I won't.

> Just for some additional context, I've been on the Android team for many
> years and have worked with lots of companies shipping Android devices
> with Qualcomm SoCs.  I also upstreamed the support for the
> Qualcomm Inline Crypto Engine (ICE)
> (https://lore.kernel.org/all/20200710072013.177481-6-ebiggers@kernel.org/
> https://lore.kernel.org/linux-mmc/20210126001456.382989-9-ebiggers@kernel.org/),
> which is what people actually use and isn't the same as QCE.
>

Yes, I know about your work. Thank you for doing all of that.

Best Regards,
Bartosz
