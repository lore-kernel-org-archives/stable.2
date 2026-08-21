Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B01D3AAF5A
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 20:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787345053; cv=pass; b=hJrYwhcngM80ZXA9woKfiMwTQwDD5x2GEAwRtJl2iRlzSX+/VXVF2rzHbfj4URxj0OpwwUMqzpxEJ3x2N8LAyUIrh9xBMYT9FyRTAKvXNOKDU0rie7tPI/5FpuGxwZ+ovWYBnfaqBaHq0Fq9GcnrRs3D1rXHu4vDpAtiwEe4Fck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787345053; c=relaxed/simple;
	bh=pfqUIoW7PHPIYNNgFH4u6pCoFZSchCOkft0xZM8GW1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHn7XUNUEVAEXGnuv9DntFcyZ50B7vc4uXo0uVbsiXfj1I6LT+HBgVHbOTeuxWHdRD/B3nPptNLWiXHRe4boTZVYf40G9c6747TssoKRucIt50kXiaiBcix/ypymCaZctzAIklzBU7FRYZIjkBXWsHEJbnr5Nimifkw8JPsB388=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4RUZzef; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4RUZzef"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-476a130c138so1453812f8f.0
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 13:44:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787345049; cv=none;
        d=google.com; s=arc-20260327;
        b=NGx/Q4noSJt5lOF/aKYnKwgkufKgz7K7/+1PgQWcGZ5WJw4oZ3eYIxTYDhFKqLNibr
         KrCi6m13VoP4GInNhETtkMHcznvU/V49PLosjGJcZBoRGhc7mtr2Gl94gnXxu0Y3AEpl
         xWA+vZu3NIGGSxVMcIh0YmGOifEAhyxJ7KriKvH63YdDutG4OKw5brgEcS/mOxZQX584
         cfLhwzSgyvvM3K1hYpO8tIY7e7YYZ1d88TuGY+/R1A2Rx4XrYEEFL60kjFUg2IxSFHB/
         sb9PILDVl+MtYQHGxSKswQswNpqB3zqFvsWoh1sQ4c+PwD/u2/vP01lF89o83f+Jf2/a
         QXDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+341h6DEBK5z4wanMXZy9KI3GcewBIrOEEjNnpvxUQE=;
        fh=vWfxlY5xRQ1/0ebBtm/WkZePAgU1SgKMKQRfLEXimq0=;
        b=TPdUp1xoIIsEGoYrZk8asn5kwxcZkqWhvfTkvyPME8T6Nt5K3pdriCgpGlAVm/RtAB
         LatEE7RcziK8ml3jdIQjWUn0Dspnl7f1Ir4Jr94+Z0eszn7/j9AV8WlMXGyx6audEvdY
         dVKbX2cjd5b4qWdtT+7UWFj7fI+2tBKZtmapDM/Tf6alT3HQnp+E/tf1+UmNbhK7diNI
         wYJqaHU2ms/kvREqoNSSivVqkdEEeSPU2NVJoNoUBUYlSQsRb99mLDbYKumHmPkyyaBT
         sixf4BT+1EGiJtocsyDKNANRra4uPVDu1sVD1Goeh9JZbEJMDoYQf+mNeH1Foyn7QF92
         df2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787345049; x=1787949849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+341h6DEBK5z4wanMXZy9KI3GcewBIrOEEjNnpvxUQE=;
        b=J4RUZzefrcYjBbdgV5g4UJmBLQK/FJeHaTUbMM5mP4bshfUBERauh8Qm179Csr7PM8
         P+CfowNPWCI2fbsUAzzwjDoJfhMDd8kfAoSsQ/EC4IhKlT+OkZe8i+QfvKv1HX4fdZn/
         OIuU8/BJ1QOgVvMgJu6Wp/k7xyrnQLhdmWQrpgdyoS0wU+A6yRCN00HQBmDhp1K/aplG
         SJo7lh+gUJP7d5DRA5cGJOlIfuhNp1xsgSKbO53UIn9Aeh1l4GZd5fINfxnHzYBlmkj3
         pkOGWiRMIdKjSnIwTqKs/bUdAgsmE5Z3ANpQiAaXbVJvtM7c0w66NVkDYs18rkk9W/v7
         GIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787345049; x=1787949849;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+341h6DEBK5z4wanMXZy9KI3GcewBIrOEEjNnpvxUQE=;
        b=Y+9PAnxwHLoKFzSpqALSCjVds1lurUhjdPdHCAVJ8msRlJMtDIfNRkrv6pf1uY/eU6
         IW4sU05TIeYCVHA7Jy1dKpJ0lbcXFylzvUlct9kyZATJ1ezrUGCw7fDh+3imqC6qEYhO
         dGKOPqacsjza0zwUC+Q1cCnEQz+U6FSxpE4QvJHq3JALF8t4aYYrz5OJpasQ0j24XAP5
         YzypjdPEZPcWvvneF8lAsr38dHCukf8bvoJF0K3hiCQcE7lL/y7fLj5jmQYCuBzRy5FG
         Qy9Z9KeHEuMtRIDrzljLsf5lH47bB85W1Iu5RyRTGSqfbNMhpsIz7ojEXq+4icEc0yJl
         H32A==
X-Forwarded-Encrypted: i=1; AHgh+RpIdyU0v6ou/zrzza8GUrRjsk7yqKHwa/5lbBhIWpEpEMiaRsUUif+vgfp6fJbq5xZORuJX0xI=@vger.kernel.org
X-Gm-Message-State: AFuF++kmh345smxjViBHI+9298dLu1PGK/VrhTn1g6UT6H7j3ohXMIFa
	3BNqkNDhUU5VXvUaAakdYpoSLNWGeIPXnAhP0Jgy0VIQqYkIyYJ7ZAWOe9KskPxQknOMNsGPbv4
	4pHIQ0F5xqQXThZWNtRU5KMucciAYC4MMfeU2
X-Gm-Gg: AR+sD13N1zedAFQbcXKkZOwylNtIpR8QrelaFI0Z7Y7Oe4iUwlYAC8xtRoqkz3oIc01
	2ii67ObNJp+pPWNmQSjYY8yeoDVbzcE6O65MeFf2X3GZRpLQTGrqvaD3PRDIS7R2KMQOVvH/knf
	7iaTgdSfWNHl2/iXotiiGbp8ht4XkQJToSkdk05W91Zm41lRdL/t3DmzlX7iaAb5hv0Z/nxIFWI
	g3WtBqT22zj2Tn3bGM0aAMPSvQdAD+fRSHg6XBeYW5ivX4u12qmggfbVFvyDDCC3mkFpqXYNhqg
	uvqurw2JPCpYQs+1JqAF45Fx58Qk9KohecPDYcJEUM+PjjOQL2gxGZWxKujB8CqnxYaq3da8Ojd
	BvNy6UPNBzDQ9Scg4VzQAUKRQ2gu77pIffdysgQcIz8jV7w==
X-Received: by 2002:a05:6000:4b16:b0:47f:f1ab:9075 with SMTP id
 ffacd0b85a97d-482c0bb16f4mr14946126f8f.20.1787345049436; Fri, 21 Aug 2026
 13:44:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <aohqChLVqwiTpICo@ninjato>
In-Reply-To: <aohqChLVqwiTpICo@ninjato>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 21 Aug 2026 21:43:42 +0100
X-Gm-Features: AcwNN1UV5kbjb7HhnjD6pQaN2t78NxQ2bOmzAO_X4_DwzDdyb74TPzJRrq4RttY
Message-ID: <CA+V-a8tAUirxWKyCx9yvYgp0EkysxgkgK20-RArzFFKOXuHSvg@mail.gmail.com>
Subject: Re: [PATCH v5 04/17] rtc: rzn1: Handle unset alarm weekday in rzn1_rtc_read_alarm
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

THank you for the review.

On Fri, Aug 21, 2026 at 4:08=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> On Fri, Aug 21, 2026 at 02:55:55PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > RZN1_RTC_ALW is a weekday bitmask where bit N represents weekday N.
> > When no alarm has been configured, the register has its power-on-reset
> > value of zero.
> >
> > rzn1_rtc_read_alarm() uses fls() to convert the weekday bitmask into a
> > weekday number. When RZN1_RTC_ALW is zero, fls(0) returns zero and
> > fls(wday) - 1 evaluates to -1. This invalid weekday is then used to
> > calculate the alarm date and can either leave tm_wday set to -1 or
> > produce a fabricated alarm date.
> >
> > Treat a zero RZN1_RTC_ALW value as an unset alarm weekday and return
> > without calculating the alarm date. Move reading RZN1_RTC_CTL1 before
> > this check so that alrm->enabled is updated for both configured and
> > unconfigured alarms.
> >
> > On a cold-booted board with no alarm configured, the following was
> > observed before the fix:
> >
> >     root@rzn2h-evk:~# cat /proc/driver/rtc
> >     rtc_time        : 00:00:19
> >     rtc_date        : 2000-01-01
> >     alrm_time       : 00:00:00
> >     alrm_date       : 2000-01-07
> >     alarm_IRQ       : no
> >     alrm_pending    : no
> >     update IRQ enabled      : no
> >     periodic IRQ enabled    : no
> >     periodic IRQ frequency  : 1
> >     max user IRQ frequency  : 64
> >     24hr            : yes
> >
> > After the fix:
> >
> >     root@rzn2h-evk:~# cat /proc/driver/rtc
> >     rtc_time        : 00:00:25
> >     rtc_date        : 2000-01-01
> >     alrm_time       : 00:00:00
> >     alrm_date       : 2000-01-01
> >     alarm_IRQ       : no
> >     alrm_pending    : no
> >     update IRQ enabled      : no
> >     periodic IRQ enabled    : no
> >     periodic IRQ frequency  : 1
> >     max user IRQ frequency  : 64
> >     24hr            : yes
>
> The output of the tests could be dropped IMO, but I'll leave this for
> the RTC maintainers.
>
I'll drop it.

Cheers,
Prabhakar

> > Fixes: b5ad1bf00d2c4 ("rtc: rzn1: Add alarm support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Other than that:
>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
