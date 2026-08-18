Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B5A382287
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063756; cv=pass; b=n5cxFxqGcq4JzyfXkoPuKPL9bMGoJASu03Qu+OY8VvL/VgWpKveImBG9b79p1KLDuHO46y/x5qr2XsFS9UDDNMs/OEC53pfd7VLr+e405E4d/yemI04Pd2lNi5bV+SlZiuMbxFPJ4b60/7bHKHiU9c1RFsZpzv6Odaqzc6QxDws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063756; c=relaxed/simple;
	bh=eK/OAvD5T3nAKg67fnkrfSipcDgxi3KnfRYcdUcekeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPnACdMmWnGcNVFV778dBKagPyRUHc5JOzflC5bJQ9RRC5XrnrbI2+PeXPdmzRYOQ/eskHagqmx11eor7Y5hhkYrd9nSWF39HFOCqHbEQAFV1svnoYaA+M7/xzV60Uomd3U4oAKR4zexl8FfnQGdkDFLxp7jv+++YsAMPS/5Q9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlqfDp57; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlqfDp57"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47de0093c42so4121734f8f.3
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 07:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787063753; cv=none;
        d=google.com; s=arc-20260327;
        b=GIbUw2eZj9WWJEcTuqkq79xH2yuIIiy4QqaTrIyEcWHZwBUCGABzoxCIxPxZW1S93E
         g1XsrIbbfW3D17FZPHul0PkLsgX5UgfDfJ1KQPzw35SGg/BsYdMw8WDYtkfLJ3yVKxIU
         slmpAkrIPM6Pl3cG/WtCfBQ+YoUDxEXvc9xEf+JSx6DATkG+XXQySpXAKmakWBhBHgNW
         7wGZNogEKA3Pozs/AF3lf7wDbVmpMzIe2g9pO6u0ESZeDC3gkhteDSgJq4hghKn2+oBh
         uE/eZrQjYHyssQVu6Y71CwHExxy6xK2opRnVa7Wbe8GH4iuStULJBIM2LTush56258mr
         xmIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MVCvZ3mYxT1SbXEXSshkIkro7sM7s+vt95nIOeUmgDs=;
        fh=Gfo/cwVoubLrO0Q5wTBqlqlNqQC8bXOhWVBvvSRfUps=;
        b=kXPLfTx2uexeAarRporNpdmMnld53SyZ5af75mwE+bd4OQU57X4dgEN84DZrbA8CKS
         1wVk8vsJAZQpQQnTVunF3qZYx4X3y7c1u/gLsUbeA+Wn4SPL8k5xa1nLPxAeOhQqmtVF
         ZNXeBN4y95Nn+3bY+LNd6slWuZ/fPPg0yHWtMf0o8eMfhx1XBkq/sbpA5m4cq9A77+Hd
         ZTfIN9cgujjd/J1E2sA2ztxl/1t4EcsFqgqNizr+dDyGFQ3uheGupwO1B5eS1zsCBVUx
         ajq4PQk25irCqxqvvsbHF4MeAmNWFjOAP8TPThjNasbmoAlj/tAhmA3ppIvTzwjpJLa4
         allg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787063753; x=1787668553; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MVCvZ3mYxT1SbXEXSshkIkro7sM7s+vt95nIOeUmgDs=;
        b=DlqfDp57i/lLeOaBqF9kekje2l/CW/2I3oNPwNIjDtKLctzc5RlpZkKpQs7BSSr/AE
         BcIDqRmiveEeUcq9iMDhkrllYmw4AEePUazKMJA5vG8eBgMPhMvzKd/io9XjkCexZFJM
         IvG7+Bjw5edbntqftIjRmveoMay0sMuhJbadM4cAvdqZC1tU5mee64GUwT3tt1Vj5Vdd
         6tsGI3Dn2f73dnwC5R1qdUQz0UDjGrxMoYaqH/HYDjKxlKW7xm9ToO4enu8MfZlfAsi1
         aXMaWksIPCPARWgzJP2vxy1F9Ur+QeJv4l1UHX1MWdwzQIPhxq5M5qxphWnDjfQLmbFL
         y+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787063753; x=1787668553;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MVCvZ3mYxT1SbXEXSshkIkro7sM7s+vt95nIOeUmgDs=;
        b=NlnXT76nJwXlPL5gHDpftQuza/JUDRwKZGeqlzRWnCjmub8ZVcIkhhYIuyHQy1db2C
         zmx74CWEE9/lVm5Qu3Srxh8G0IKSIeq4CzXXC3QZAZwkmzSXPea1+QlK3jW0v0YNH5Vb
         Mkcx1ZXSAiJLQ+CC5ypT+AKsWpbeO2YMuyLPL8bvhuZqXoREeoNcTR/+zzg5JV4PEijE
         p2jVNMtcfNpogHUVRjjo6LaTd2odT7rKPVcpPyeKTNaT29JeBcpVfhFNa92t6fawOn9C
         52QylU+V+/OjSAlzpX6V8BjHEmCuqf5InZaeI8m7dgSN+kktSGtlZd58I9090hIn5pLH
         iG4Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr8B8sgFXGFBqUOLTYnN7sOIpfMyWo0kJArq2GBg5Qb4BsMsiA8D1YaK87lYdRTvKNmdMVfjng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpDdm6RbzWSIPUNw6RwoGgIHV6EMVjSli4yaqhyTm9W9OnQ3YR
	rfGwQaD56YJbOcZ04UDqHbvUwyu6UBvsLbcelqZxlUa/cep0y6WHIZBjRkTadQmR0XpZ2IkHpgd
	Yo5+AinhDnEl6pmbvbSMYRAbKmuPOe/s=
X-Gm-Gg: AR+sD11n6LYlICaU4bzDN6iElb8aM+ULj2meKv0Fn40AHevq1tfuuSl43O9TAxJUGKk
	VUY4nebG7ixRPR8DE2pEHW1gW6cYJBgj+nTGSGJQnB8SQuR3uTNuGlEXhqLie5NxIawzycxqsYz
	SRTTrzh8r+VFWLXeU2kNiNZFFTqDjofXUAZddCH4F2xh5cmTXruD09ggLZl1L/kJ7pMNd8oCU+W
	1Sf5Zgf2/zIjkGRjgrNhxzGbORlCxxurYUFTzf33jfyNFz/NOXBHdG4azjZiG+ypcTGFMW90Z6d
	Lym1MQc2gXI4UvTK4mQ8OFcbBbBWe+ZZ5/gRGsgi46PH1/himjZK8SBVZvi2PnObSAMLKazlMmn
	erQQ8dL9JxUKZ+ww3rVgxYzD7b0Us/3Ii8kg18kQfBXI5kU/5Guo3Df7f76tZ6VE=
X-Received: by 2002:a05:6000:3109:b0:47f:e748:3ae3 with SMTP id
 ffacd0b85a97d-4816070bf1fmr51894142f8f.3.1787063752390; Tue, 18 Aug 2026
 07:35:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706175138.12587-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <aoQvrL8cnnK7uxqw@ninjato>
In-Reply-To: <aoQvrL8cnnK7uxqw@ninjato>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 18 Aug 2026 15:35:25 +0100
X-Gm-Features: AcwNN1XrTnnWQE0HKkObvyxUFu7X0N_3i8zbJm_vjvyoQd8C8mij4hA0jhrhrcM
Message-ID: <CA+V-a8sG47PCuKTR-K=sci2SOEWjYRDOWRWeamYysvNO0XAuNQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] rtc: rzn1: fix weekday underflow when alarm
 crosses month boundary
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
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

Thank you for the review.

On Tue, Aug 18, 2026 at 11:10=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> On Mon, Jul 06, 2026 at 06:51:29PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > In rzn1_rtc_set_alarm(), the driver attempts to calculate the weekday
> > for an alarm by computing the day delta between the alarm time and the
> > current time:
> >
> >     days_ahead =3D tm->tm_mday - tm_now.tm_mday;
> >     wday =3D (tm_now.tm_wday + days_ahead) % 7;
> >
> > However, if an alarm is scheduled for the beginning of the next month
> > while the current time is at the end of the month (e.g., current day is
> > 31, alarm day is 1), `tm->tm_mday - tm_now.tm_mday` results in a negati=
ve
> > value (-30). Since `days_ahead` is an unsigned int, this underflows to =
a
> > large positive number, leading to an incorrect `wday` being written to
> > the RZN1_RTC_ALW register. As a result, the alarm fails to fire.
> >
> > Fix this by utilizing the already computed `alarm` time64_t timestamp.
> > Convert it back into an rtc_time struct via rtc_time64_to_tm(), which
> > automatically handles month boundaries and correctly populates the
> > `tm_wday` field.
> >
> > Fixes: b5ad1bf00d2c4 ("rtc: rzn1: Add alarm support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> These messages look a bit LLM-generated. Is this true? What about the
> code?
>
Yes the commit message was fine tuned by an LLM, but not the code.

> > -     days_ahead =3D tm->tm_mday - tm_now.tm_mday;
> > -     wday =3D (tm_now.tm_wday + days_ahead) % 7;
> > +     rtc_time64_to_tm(alarm, &alarm_tm);
>
> This conversion is superfluous, we already have 'tm'? So, I think we can
> skip the whole conversion block here and use?
>
>         writel(BIT(tm->tm_wday), rtc->base + RZN1_RTC_ALW);
>
> Only lightly tested, please double check.
>
Yes it does the trick. I tested with the below script:

#!/bin/sh
set -x
DEV=3D/dev/rtc0

for d in "2026-08-31 23:58:00" "2026-04-30 23:58:00" "2028-02-28
23:58:00" "2027-02-27 23:58:00"; do
    echo "=3D=3D=3D Testing boundary at: $d =3D=3D=3D"
    hwclock --set --date=3D"$d" -f $DEV
    hwclock -f $DEV --hctosys

    # -m mem/standby would actually suspend the board, which is disruptive
    # in an automated test loop. Instead, block on the alarm IRQ directly
    # via select(2) on the rtc fd -- this is what confirms the alarm
    # actually asserts, not just that it was armed.
    timeout 150 rtcwake -m on -d $DEV -s 130
    echo "exit: $?"
done

Without the fix I get timeouts as expected.

Cheers,
Prabhakar
