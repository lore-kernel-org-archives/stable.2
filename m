Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793881108;
	b=DkspMrx4W3KoWNU0fxm459UqhONsQJJ7ClkUqzOrZUsMrb1DiYbAuF83Fa3/ZmD+MO4C
	 HbOcidM4aKMZIr8UGUHSosluiOLjZ16adQtaSW8qtUqpF3bU/ItSc78kxdctxL+xPVmzP
	 tEaPHEJGCY8FPa4WTMzGD7jI2QMv0aWIZFY4NX7YSxPxLa7fLXRMkRg2zoBGXbj5Lvsmx
	 5suqofQ/21AQLQ7DcZNjpWSgLZBuKxM5xS9DBhS1IFXxfg3bZ95QfKCioasNdMaeKrxNX
	 QHTGZTL/dructoxiAbaI0Kl/3CYnpmEuH3frNLFprpZELcUO13htsdWQztSrX2UXsjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881108;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=eefMXQAgx8LZwf0Fx8BRlWFmLt9F1+J29m11Vy9njI0=;
	b=tFBB3dq3c6mup1A9LV4hx47mQxvXBw8Mopfd4WSmhr9tKTMOuRcQX0ViNjN4yq/NhBTY
	 sMGYbfUMtCBEyPi14qLT/HXJCcA3f10Rw+f4LOF1Favs8A4RBEox6M/PiBkaLHkrCA1lb
	 Jy5+n5l61R5t17rXu4fD/0fk6oiS5Oe99epgTb1l3T1dvsaGbFE/FKlyxjBD3gD3y3O7h
	 a22cpDpiRd0iY2TmvxVl8fzZPf/zd00RnWa4Tm9TlgO/wYDC+lWwc3g4kA4rZvr2GMhAB
	 5s/gF4TIz57ZU2MPXGLQS+bpoobtWfhAJQpChqjs8+wKJjIVS+Lpr0Tn1tEp5Rf46rQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=futuring-girl.com;
	spf=pass smtp.mailfrom=futuring-girl.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45146082BCD
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 12:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A45146082BCD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso277889766b.2
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 04:18:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793881096; cv=none;
        d=google.com; s=arc-20260327;
        b=ox7Ar+Nc2uEzd0YpOoAfwhHJUqvdbOu6KeyBQmGHc2CYpePpCKezoFhZGOiYwe+q/A
         CZK5UmmTKMEs4fAYx4Q6wcwe2QLii8yIW1FRFrfGqkk873c+Tu266xQhzmyDtfaO5YYa
         LwDDsoTRvLOO+qbDFkWRmxR8qMSvgfV7vvkyD8Zdi0ZVIOTjTPfVSms7EJafSZ6B5QOV
         D5+96QrmclGxtNk+ba4YaDFVuvTgBDtqbEVQsvcOIx9zQUDRDR7moK9PpUN0yk5a0qBp
         sTIDW1ZGS7hN1eBMTq2gr8PevJoLHU3OI9hn5OAZJMw1hRjF0Fc6t/ehJdoim4teeJwU
         KCFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eefMXQAgx8LZwf0Fx8BRlWFmLt9F1+J29m11Vy9njI0=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=hIWtp7grdWV+blbgGyjrvi6keLv4gJvPLUZ5oZVEfqAg3uDLfOiCbrMC2onsg+dwzr
         iaoAiTle06ROq2WaI261P9ctTuSSvRHGt6pGRtNYeYf0d5mZzh6wsN9TMYs+831wkEdm
         zUPK+y/YW6OLlq+MxE8IRX/q8hBb3wFwr7zsCVRfNQBo8/LyW+E+Uf3H3y0AKMmFZznq
         qHIyacB98Qa8OKjkcUaZQ3po2+RGKDoaL/WOUmy36ERmW/UG/eePEWoJbzPyze5wNHOd
         rMYCuh5lMobnpNo/y/v16nz3Mzbz/QSoVqYicsP0XPrSYl2ayvQBc2hvzsM+mR6V1P9R
         M+UA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1793881096; x=1794485896; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eefMXQAgx8LZwf0Fx8BRlWFmLt9F1+J29m11Vy9njI0=;
        b=I8vsUZP0H9GSmpiQduka/DtR8wsUcmq1RCpQijc6ZG39Xc8UMnTxn9qwdiMi/OkjGw
         LvStQ5IglRUyeX/2fOYxwPtWPD3y/AWIQRsqXlPUgDOGq8LTbckr77vyADGjwrpNe5nA
         lFebWqwJaf2jvPlvhZHOxf+k0zW09IoInLEEcp6YtAcyZGHRV63+iP25Y0GME0R67LZ+
         vlRX39VGczNVYr+M+fIDNjJNO/r33cIt5DYGj1DE9l57HsgC1UyB+PQAA3HYmcpHZRym
         7T5wRaTuva622derdAbl08OIct4f6MiUAPojxvuik4dn9/hNnuINABsjNKmv8ZTa2tv5
         eSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793881096; x=1794485896;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eefMXQAgx8LZwf0Fx8BRlWFmLt9F1+J29m11Vy9njI0=;
        b=SLJYUnUIltNp2EC6lJJVkZm0tmcxXXwIX4C+SN2lqoewybPKj0Wy0JxFbSkYeqlahk
         OTTJXTLO+0MACf2bMeMQH1msjESJSzDkvRjSp71eTuGgZN3dWqjFEDYMAPr5zGp7SbI/
         FgO24rh/JPph++HVV5U57sd2OdcxQPjYbsm05HlPqcDAlxredNUgIQ16UXi5ZI6LZldp
         Rf4GXmnaGWEysMmekMI5MHnzy8HB/F2ds3rbLusu3i/HlHVgeGRpXRh+elQKJ++ZkY8u
         Tg+VqsxWIAftUYx9xsCEt1a6WEvD+agQDxAS7uR85KO+aOtT0iIgnvqGglxpV2cm1o2c
         M2kQ==
X-Gm-Message-State: APuU4Z+p5JYFDWuiUkvICXXB/BqCbLNKGQCLomBFxPnvfHhRzBdmiPte
	sXcf4j/dOTZrFMfZkxRtnszTAAr2ZxXkCNMLxxR8NEatNucrrSrDFtX29OvuY98F88GCP5XkQlH
	1MesqXN4gQEQGAXTwJavOozRj6Ws8XfF98IH94EyYHg==
X-Gm-Gg: AYBFou0xOMtzV4rvh60Q/kkbjqz3VHdyqMBxItWVJSsY1828AYhxTICHcNfFn9WaW3L
	0aHyNntih0t7SFIndPCJ8sY4hyGFlHF/+hKGdb1NQINQPfIPc2gEv+EIkYNF9ENKyzTuT53c3Wd
	AjmBRwwaZtUKrPNSNAM0Kksx/2o1TSu/GlCFQF/K0Dk2mNv6HU+EGVVZB52/GexIhEJepSLwN8l
	xDGyJNHF63McUPAb8llHAENpbNoFN+UQBlQ4JG59xg/CnOTZ0LySzZpQFIMrPve0dqodtJwE+Wp
	+xJkDqoqZdOL5vsLxWD6NUOWxykGoj8fToByGmd76el+x2E/BbnquZseLZo52RFNQEW2fba5l+d
	TezD+f7ixLf0eyOoMfj8eqyEkA3M8/iaPpqW7
X-Received: by 2002:a17:907:6d29:b0:c33:dbe8:291c with SMTP id
 a640c23a62f3a-c4ca7a4dd2fmr1811633166b.20.1793881095505; Thu, 05 Nov 2026
 04:18:15 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104211038.406938024@linuxfoundation.org>
In-Reply-To: <20261104211038.406938024@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 5 Nov 2026 21:17:59 +0900
X-Gm-Features: AclHuK_xKzr1_jGZskftgS9tYbRvEAvyWrEkQDJw4-ZYm6nRuyK-hjQJVu5MVE8
Message-ID: <CAKL4bV6VGE1J3K45KsOfo40zsZEZav4rxSVGRR3Rs7Z2E94_UQ@mail.gmail.com>
Subject: Re: [PATCH 7.3 000/547] 7.3.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Thu, Nov 5, 2026 at 8:41=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.3.2 release.
> There are 547 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 06 Nov 2026 21:07:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.3.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.3.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Linux version 7.3.2-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.3.2-rc1rv-g75eaee7a6465
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.2.1 20260810, GNU ld (GNU
Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Thu Nov  5 20:31:07 JST 2026

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
