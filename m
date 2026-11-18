Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795041052;
	b=Fae0L+/bjw2ybENt1d6QiBsF4tpJ++sT2+Cz0WnzGENn+jAK4E40uExHIqXUYkm/lJXy
	 VnrQUiEg0lWFZ+zk47d3Vh1Hvq8Y/Xllfh++ZO9bicLsnz78NKGmg15k/7FWxEX4s30QE
	 EKpfR6pgVtByzdcJLV6k0PTzGtNT4xF9N6GXZ9yPYVQetjbgxXgiuhHiN1kcf2Q4X0vrM
	 /9d1jDolOz7QylAw9gk0XbU4pONY/1CIZoVINd8n4OGrg48AaqnnbvtUfCiTMDvfpWMGx
	 kYGuTfgNv4LtzbEgpxS2KgHcng2MoPUGgRecfIOOn6AICGKCphXE33s2wsWO7jIG5Kg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041052;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=yqnC38uWfwKQrsdALtzn7RtsAAUyiJIP1ETaKtJsGh4=;
	b=zsxTJ6HWYfNN0f/DITUPZHN21U90EMFV4fXhI0sxyanBTjXs9I84vlBpotI3sMdLiX2j
	 7XU5EbykinBRFJUujdlBipSWvqK+P93IHZqLil3IhzXeR6ywPJh2EJQlkvNCOepvE5Vpt
	 1mRXRiS7ti/fuQiQejhOq6gcbt6jMVoWZtVT6/vRwvQnf9rc9BbEaeSGXbKjztRi/HnS7
	 5/8RdprYM6aKpyoH9WIipwpjBj0uzyi9MDjqHMrLByUbWg2HMvTz+qJxIkWTp9Bz83JAx
	 j9BIUOhNfCsY7f2ty3Xhj7q1WxOUW6mRJPmTlRUQnk8sy+NyWEDULEqRRGc+GTyKrAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=futuring-girl.com;
	spf=pass smtp.mailfrom=futuring-girl.com;
	dkim=pass header.d=futuring-girl.com header.i=@futuring-girl.com header.a=rsa-sha256 header.s=google header.b="j720/APk";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751C4606A320
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 22:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 751C4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.a=rsa-sha256 header.s=google header.b=j720/APk
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c506a231b88so230337666b.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 14:30:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795041050; cv=none;
        d=google.com; s=arc-20260327;
        b=hZw14rilf1vAwU5NaN79sEIF8pKjlIQR5X1w3NwcFrv0iHOwhbzL2itYw/ay767PFY
         MLht3mC8VS8fraRGc/eqQr0hje1bsjgEOA5Gd6SIXre/GvLx8oU+VtQMIaGWsgOnvXkJ
         ucMhGufmiwj5IgINlCUzOpqLWautf8Pnd2wr3N3/9CnoCm6lEBiNahBCyuZ4u1206Dux
         7OzxdRbyD7sUFWtElzndS4CPJ8ehS4IJBSVmGtsjae3johwrSvruwK3Zk9XurPgVKiJ2
         GEIBldfUgrlDDkdwsFPZKsJERe8fp/6kGEh12lFgqz5VWYwpIm1NF9GfBv4aUjRO3Au3
         SfdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yqnC38uWfwKQrsdALtzn7RtsAAUyiJIP1ETaKtJsGh4=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=Maxc29+LD4c+WCiAcf9fX596j0e4Qg5ce8Wry1+Orbkq3C3Rb9abi1fAoRbSvg8Wk8
         5kAL7phYYylQEaXSvgdL22I948zAy09lI9JVexxrUqNAnzO7zYDbm2Syk9KDQLVqZ22I
         PL+6NiHWnSHgzrIxrazkFI9I3XDsCAJV0rnoKu1PwzeBkR/pm4hLvmJ4jJ11xmg6qvqM
         BZtkV1wPCf1QSEECS7b+At5Yaj7zD0WBJlnPEtqc5JCpNcewhlLtIYScD0m/Q0jSlp4E
         nEz1dp50eyoUgEn1M3IY21rft+9rrHM4AO3EnPYHuknBRKn32V+V1P2HBx36UlKVOxIC
         e/EQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1795041050; x=1795645850; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yqnC38uWfwKQrsdALtzn7RtsAAUyiJIP1ETaKtJsGh4=;
        b=j720/APkNMB4KlTPuSGtbxUcf/iLf2ONTwKmWwt8QoG1MMewhomk0jJwJojhXPKZyP
         jJ2IWad1RnF9Pd1LpMcy6XrPqwFPXtU+UKbqveYKpxsMyG0JNeMt5a2TtTz33TBs932k
         YabJLIpbp72FaP/dBJzLjcG40rFglJ+prpmhDXFCtEm9UyzqytW1vsPQlzf9P4NMSjpm
         Y7IUDZpgJzswHMNlR7YOUaEYE2QRuHiWSMBbUcfiiVORCVOGb34+tv4V3Vqgtg0jqlFa
         agSaBIj8Toy1JRwb5EczwR+xtY/WVPgp4PpuW/ZiXQhc8pjSnhjqRjT140ZheX6KHGSP
         ZVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795041050; x=1795645850;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yqnC38uWfwKQrsdALtzn7RtsAAUyiJIP1ETaKtJsGh4=;
        b=uPzWHKhTcYuwFV9rzeeEISVCkPHSlfLurLSnfazG34O0gVLa4nJ6bc4h+uUm1y+/5S
         BKVD3wYO/Dsn9qB5D2vM9NQrsF/rqaXCf4indI9+TlRQMnuA9lUCEBzFLw/u1jNaVA8Y
         6K6csMWRfgQklYihvBxftbG7HD1ZhNllsECnHVGdeqjRM5T9IWBPFkvS3YYI0HKWNZ13
         pcLdSz4amEi4hzuBq97fYnHfQy0j6sVxsrJ7GlvsdUY9238dySosBeZhdqOHYCr9K+e8
         mCPsFiVCco5pk50F1TFYwhpi1lhegvk9c/ibbjwbemSjyHoTdWpaMy1edlHTEyEekDph
         Hp0w==
X-Gm-Message-State: APuU4Z/gUMatdKgsQ5thmPmGllO8bJ8xKKOW6RU8gx9Bsj0165uGL2uY
	1XSOmgu00HM93loIx8z8CQ/IIpF6OsR+wCujD9S8MniNnZGhMS/FGG5oT4rAQnUgJm9MR0qpm8I
	MEI0l09/UBkyWRQdNeU8u8abJ2RUK0jD+SFNyhmrOwg==
X-Gm-Gg: AYBFou34b9q8rujOO0g0la562CRj6sZrYKMYDXrKG+wgpFGjmLhFQhL/xZLsV/+A1zS
	Wpwnh7c0JTvLwc7HN+X+CmZFfMgCpAJjbFheIbtVfwxJDB8FvuEPYp9hOmnc2U4SETb8l+mCShf
	/BNuG6h/C0SwGXZU5X55sFphtTsBWMEo+A2DBeBVsA6wbADu5wbKJ7GRctEXVMA0kuLybktNNKt
	W6Ekz1DR0FA1FpSBTOdPFbxDO+qtaIb2cqABz3nR2mhgRB3EHGkV47BSVOzCZA9mwp1nwEonAox
	NGizvOPj7bQRHYSq0WKLtxDuCRq90kvUkox8yWPru9SGJb/1ObxzWCzJaRQ0/UWc1ODdZgKdtW7
	LeuCO8CST+42pzobX0RvU2sFh7HB5Jdmhwv5CwY8noqH8A4n41virSD0YNw==
X-Received: by 2002:a17:907:3da5:b0:c41:26b8:c49c with SMTP id
 a640c23a62f3a-c510e169389mr367702866b.10.1795041049337; Wed, 18 Nov 2026
 14:30:49 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118150247.972732815@linuxfoundation.org>
In-Reply-To: <20261118150247.972732815@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 19 Nov 2026 07:30:30 +0900
X-Gm-Features: AclHuK-6KSFdeiMC8z3chBPKy6DS0Q8xZ1fgA_xjvJB7kCL4tYoOxjNdA9E-2fQ
Message-ID: <CAKL4bV78Ze=q5THC2pbgfczSEH37KbaYKBerS3eXwadJGpx+hw@mail.gmail.com>
Subject: Re: [PATCH 7.3 0000/2651] 7.3.6-rc1 review
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

On Thu, Nov 19, 2026 at 12:08=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.3.6 release.
> There are 2651 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 20 Nov 2026 14:55:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.3.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.3.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Linux version 7.3.6-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.3.6-rc1rv-g62eba995b019
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.2.1 20260810, GNU ld (GNU
Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Thu Nov 19 06:29:24 JST 2026

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
