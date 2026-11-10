Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794320503;
	b=vTsddKEF6WoSOzPvoHU/FwanhFq5QKSu5rtMPkSU0PNTfAt6vvG2BcKuGOYaaoP1vMvZ
	 Us9t/XR2nkte1k0x8QtAUnGh+e5iClyA1gMhpeJf5hNr/s1B2HTlIPAPm1iBLaha4Ag+V
	 /KSfaxpeK4ms9nq0hmnGK0/814UQt5PsQxbh5AVaY7DOR8/ufQDohIMgHhxfWiKnQ840+
	 oDreAyu+/DUenkZPrF0Satgj1hh0V0w9uN6BQMb1B/tZN/6PoDceT+cv/YnXjKBfpsW01
	 J+z7zpIy4/LHSzEd5uRQrlhg8tDQmLVbDBI58KY+FxYCMA0a5QOEPrMFPvkRg0suWbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320503;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Ejm8pe9G15DYxQ7Hb5OdNIp8qY5r8fdDKVN+ZYBfwxM=;
	b=TFaMV9kYPrGl/wrhqpK9NEtlzkDK4fb+WFm+K4QvYLmesLpSM0MvKrXzjfy/WOQcosGA
	 1KnZJrggaFeZmvM7oHhAU2WmRQnRRju1cKLfH12+/bZoZczFkUfcloOpkcVHPaQ1Vulyd
	 EmtvbnEQspUPi1PTAX+Q8m7Qf+0YPbrpMomlIeU6bQQZkA0ixRHyWUyIHxZx6aAGm9m4D
	 Q49Gen4kUN1nAyMBVuSGWidyk0h1P+AvVn+sv4d9M6kQlNtciUIxohlL2UjlmSaPqUG7s
	 y9dvAHC3FoEx8ECTQy6x3hQ+Kfr4pWUOuZ0M2w4e//dLMAJtSGXfko1NBdejZgAhyJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uArSYa94;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.41
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5B360A3835
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD5B360A3835
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uArSYa94
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5c15956ce07so458207e87.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:21:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794320501; cv=none;
        d=google.com; s=arc-20260327;
        b=Rrrqiw9ZH4A6KKkxQoavd2SWqBhgZj8Tz/R5+tlsYW2klRftbkgjyvYGJMIjbIf5fV
         69dRWCPnIYrIO+6vl/8gjt5L6a/HQlVnmmTQVSiy9O1aeS01duJJRZMKNXcRhrZ2wk9B
         akQuM8wMRxD9PW+xXZUfVD26tLQe02UwhhhY6uxPsZxEDKHY8cUqQiSJVCZoRWo2Jaf7
         J4bsOCZCDkEVrKnMLmEQS6pDmx6iEmN0AOs2pjh2laGdn1LEf3Fdl33RXHXZavHHHPfV
         yjcCHgzNUKLFUsqcuOfBRKGmUhL01irINuf6i8OQjD527/aukK5M6snC18uwLN8KMgZB
         +vZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ejm8pe9G15DYxQ7Hb5OdNIp8qY5r8fdDKVN+ZYBfwxM=;
        fh=Rb55KI0X1KqkLwHA1rhvfUOMdeyX86m/0Fbdz2jqSV4=;
        b=R05SPRviTUoIhvR6CaJoiI9o+pg8rnPqH2vKzk3BcYLRIiCmaVvVr91MfLWwMY8SXz
         TorDiDYv4yR8uik3xlUbuMeGhVVPdn5R5AAgq+NhHf7s4ApApRl0yt5UYu9CTYL2WFrC
         rVW7tCUHkXe4HbFEk1UND0dK+BpIAUrFrRUQZqqlGgSIvE3ax9kusUcK2cTSzvkd8lHz
         DruD6IEzXmCamAvuyxIIDYJArlXLV/a+b6us1+UvsyKAlT3vArA1UPeKFJtz+zfBmgwc
         yqH8H7r7zfPv0pnQY6EzbHfXUTWNzzaMvDnX4uIay7LJgnpN4aqt7YyztmaDSaSygj8K
         QHxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794320501; x=1794925301; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ejm8pe9G15DYxQ7Hb5OdNIp8qY5r8fdDKVN+ZYBfwxM=;
        b=uArSYa94ATnFMRAypTPoIZopEiWjn7Q5TSFwOXUFzIXVd3gI2H/IZPRINtu6zbzQEm
         pzUccU7eoX0n2I3adAPcdkf5jZ9Hsi4QFTmUHFbgJYiTTbjBmID6AkvnWbg4NOJjd5T8
         Dqm42cOmZI4RPyjuQkR2/mN0ZfR/aSE8uHmmI//8W2Zvq7cgII+cNDJoVB+7s50E58rd
         0RCD6uBKE015IERTcPJqUkP3latdSh5W/Gx+gcFc9sSQfx0sKWWmNmpKUOcxWqiD+OOH
         Y5ObIIgUTlDOcqBZnY6TxngSwu6z90aQzL9512gnSsayMyEa8pzZG+Wie37BxTf4h4Yj
         lkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794320501; x=1794925301;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ejm8pe9G15DYxQ7Hb5OdNIp8qY5r8fdDKVN+ZYBfwxM=;
        b=CSSKMMpv65Bywa60T8dXFS1Crm5sNSSRU5mYfNOM9Q5kn3H3SqgNG09w5b8gccGMU/
         3SU9V3clEUCk5wqjVvIwTnkU6oylBBmB4+fD/6u83ZRPoM+Jh14bULMzOuV3bfSwAswe
         CgWIv//1JbqJmsXT9puW3MzofAAod13PHmxuJhhHNDJHysLc8+MedB41mH41IJVAhNbh
         zY9J61iu7B0wNnv3PXjwuuG3Eq5+pmc18MX1vh5/vMEBfrvTwHEpcdNam22HBAWt/4ZL
         cBpDRbzjpF+ns6h64jklgLHxFOz9mNBdOWM9viwvcnaDpABpIOG1oDAG1TlVHfVMBboH
         NpLA==
X-Forwarded-Encrypted: i=1; AL+hErHV/UoqKYcf/ZDdZVdKYvkutVW1TTwyPDfIoqtXbkiiNBnsPwz5qFLfNRKEzXQYck2cXB32/9A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+H7fR2tZ3p6NQZVvEdPiYA9/YEkacuR4NjEh1RUl0aQeDEvjdh
	7TwjUnDoI459EpBhDera8kmtSKZa20lJRodheaQInG06+G1oWOG2zLajX5U/7FLRAp/CEp7M9VD
	wxAZnbW0cdmEfR9torX2r+FIRs/fCJp0=
X-Gm-Gg: AYBFou39LwDzfS5HFtb1wik4/+kPOYtm7VVriyFi9SY2qL3KiJeT2ux1ZXqG7DeIZm9
	/pALf2e2cUdCIcvi2neO2mIDghDjjt9XNxURoxUBNOYyxTktKUn40QBJSLzDsTE6x69tgbCJ5Sd
	2TjoBQm6ZCapIcc2NJWoEir3hhx3EpE7NdXdVagex/0tbhd1+DNAuM8EUuQep1btuzlQyqDVfc3
	+k1GMVBo7bmx5I3RDnLGTTjkRtLFUl9VQvJcN9/jPXMkHbToYFsYkhRo+z8NaWwgc3Q/XHl/SeE
	ANn07EkgXnj+/K0tWsnOZsCSXIUv6UTtGuqCPhgVFmKUbPrFxE9S+aRR2aUzxQ/brdNrIfxTXqH
	9C5tfEvokx1MHUKjnDlMvktT/vTD2eMT3m8wkExChgH+aNCOcCPQ32I8jXmErfj6dkD1ZKJOYFa
	zjuVDeyr6KyUS0xrtWGfN217mZwg==
X-Received: by 2002:a05:6512:15a8:b0:5c1:4bb3:afbc with SMTP id
 2adb3069b0e04-5c156de82b9mr828897e87.26.1794320500715; Tue, 10 Nov 2026
 06:21:40 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018022400.599028-1-festevam@gmail.com> <20261104105829.GI792264@google.com>
In-Reply-To: <20261104105829.GI792264@google.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 10 Nov 2026 11:21:25 -0300
X-Gm-Features: AclHuK-TGMXiiM572Q7C7MqR_s9Ybhyu13xf-9p15OjOQAwSBPcq2XTBncA1S4E
Message-ID: <CAOMZO5AjeeNdeysBuoUoejg0yECiNWjX6o=Q+_iPUfF4=uiVOQ@mail.gmail.com>
Subject: Re: [PATCH] mfd: mxs-lradc: Pass mapped IRQs to child devices
To: Lee Jones <lee@kernel.org>
Cc: dmitry.torokhov@gmail.com, jic23@kernel.org, linux-input@vger.kernel.org, 
	mfd@lists.linux.dev, linux-iio@vger.kernel.org, stable@vger.kernel.org, 
	Marc Zyngier <maz@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Wed, Nov 4, 2026 at 7:58=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:

> If this all seems like too much, let me know and I'll spin-up an RFC for
> you to test.

Thanks for your help. I sent a v2 with your suggestions.
