Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8130B3C0605
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 10:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047383; cv=pass; b=tOl7H6NHSe68aDkaFFRvNxpevO/2yt8BLp6mbyFQPcdampm8D2v3aEqAo5xZa2Wh6Iwibo6BypAlOHlIeUGfcpY8DVfVqzH2cVsGG8snPqHhOg9/Az+R0v7HkySApZNDdpfrmmXr/8lYXPIsMTWNI5g7SSL1It6lPPAN4svADXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047383; c=relaxed/simple;
	bh=78uTA45DXLCX7o2HwRklFyYI73EcDwhCvnZ3/iY+SBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C42XiA5HToqEiiHx83w+jgDBR3DmWjDLgcwwcC0wB1+5yZQ45/jp1Tg66nPxEeMtxTRHnwVjpqv6ogC1RA15l6mAFrNHOtkoq5KmCG+wPe6otHVPqlMfwZaj3R2MqErKkmZgDtw1JxJMbdlpv35h2meb3Bb7hrjLqR/fhi1cRcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=uIwK8FLx; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="uIwK8FLx"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15b1da6b82so519796766b.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 03:03:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787047377; cv=none;
        d=google.com; s=arc-20260327;
        b=o7X0czUNj+9nSYfw89A61B3sVCuzaski6Doy8yHEmxRfHfBRnVWR13v6czPlKxMF2c
         He6iW8d9vVUy5s7I9rvI6V/vjb3tY/ZywUVDMAhxVbYDFvVcSs64cvaJUw32H3S6Xh6k
         Kopb0CggE5VBP94VclkpVQPpOa34hx9FS4DN73RtqvjICiT8Kr9fDSp0iK/rEBDyT2jf
         hjFea5OhAJ7vzZlDQhCDMoK71+TUJLQLzDOVT3euadA+5oWlV8YtWksKHTuTJdtCYR/S
         HhWF8WXLlxbp8sBivRR5X6k/n3BY3HvlZOYdqwB7jnVmTT/RsoQ9K/1ZTSiupe7miktz
         l91g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aR7I93O4QF6pVY4R1vWgpoacJUlAWf8vZMgfdYCyiF0=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=f1IURBZmeEs9V4eW9bWzr9jvWtJOU45tPV2Va+9p+EmbEvOIk7L8UF1WGhk4vYTnyQ
         J6x+TU7HAeGvmHut1Y8W9uRFETbKg0n8nvn0Db8J+OcwJ62L2phYsbCkUeZx+hxB/CFM
         0Af1XaSLk/QcmzKXNRFGfLaHY9zTbEPG9B7WQRyJcFr4HiJ1/erN1IL/5XsWSG8J590n
         Oqvnt8pvQCAUc3MtFMCYKEfqWBv8Rqr5OvskC+3/+Jtq/KHiHLr04IgJNlcgkPvbMavb
         ec17VzR0huanN/mmJ7wfY0YJkvQPLgNbuQj/lDc3f6gdm3wKxE+KyA2SxKzZYy5iimpZ
         JajQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1787047377; x=1787652177; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aR7I93O4QF6pVY4R1vWgpoacJUlAWf8vZMgfdYCyiF0=;
        b=uIwK8FLxv5fYv1PiTPZANzw0REXVlLjcR11eCKbPJ/sh8mlQp3/XBr6FA1Lp3p7CCJ
         4HGl5/oqDDyAvWRSZ/LT/Bls8q5hcg9FZ/nUMGlt3hG1/eZjCT8WjpesbdwRU5gFpkxS
         SnHwW8ksGBoBq8sWZTVNTCqihd0UB3Eb5uZG1+2zW2eVxaGacn/23lG3w7AjtwpktORL
         XZA/l6TFqbs9LfdVAUOjoNz2CIk3YPFKFwhIB744CvZJjDgpNeOmTrhNMkRUTVLopvw9
         Mr83WsuKJRbm4X59FQFfS7dvCP+u36aH4apDlT/t/+7LbvCKYWpalzFtjcwoWVVHiFD4
         oGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787047377; x=1787652177;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aR7I93O4QF6pVY4R1vWgpoacJUlAWf8vZMgfdYCyiF0=;
        b=ga94mqE0HPXl1n7mp3DORDx3Pwe/19qz4xVAffgn4a9cEbk+qb3QO9V74xe+1FC2GI
         hhEY5iUnfKpJv/MXqRXH5jMdvf158drMozWgvwv8/FQkrdOl4Moak3HpPdaB5WIOLzOj
         FN8iOgFaerjEIW8VZ21lB/lcDHWjcHtsms4qQmQBO9q6dZKtsgQc2UyKa6UJjdXEY+YO
         yuASfKTYSVWsrq76XvA4Jl5jFwV4KI03NkV392udlf038cKUzBqgNrOEzx/qChPkoZZk
         ofhJ/Q6D7dzfN5VJv5txtH2sCeH/A4ri7NsAf/Usc9yVGsGDxrpsB/IUhibPoXLI5KFD
         akqg==
X-Gm-Message-State: AOJu0YzL1rGLRaL/Xki2DkU+T63OoCKUGW1LqW/1PXx4V/KLZYP2h/aD
	UxuGpHpv5oyXUR5JKzeaQZFP9w/6ozbNyQex900TQqPCS+zrKTwlIV+vHTWP5TOzbdDOKGZ02oP
	96bLfKa2SNrpTGR6PHnrmJbq7wcK6wOhtK/FxSMan9Q==
X-Gm-Gg: AR+sD12EIXHIAyFmkmlAZ4wTO3Qzjd9xxwgFJF90qOr8dOE7uy4CjBSu7lODy7XArUI
	x5edpl+ol7DMXg/FfMjp1zFFEMOWKUiOn7nYhDj/+yXi1JevniZjPDuHnWCA39YMe3aXFt7ry11
	wFIUtWNILVVcCdWEE7ltgIXEjTkPQry7JI6qyILe2TtLlu48Zk8XHnxdbC0Y2Lq2fVDftqVecqQ
	a+2xkuoiS0LHpOAhFwf2ZTqQpmO0GwrSBbtt2dl4Xwo4E9/k67dN24xUYWP0Nx9N9TCCpzSVrOs
	OeJ22wtNeOYHY67ucCU4tldOGRgGhXA6pcXouWvCKYaXuMQ8FS8S44F8Ie3RjG7nfKrj40/nYwb
	ROA==
X-Received: by 2002:a17:907:1caa:b0:c15:f0b8:eb91 with SMTP id
 a640c23a62f3a-c212a092f29mr1387506566b.7.1787047377259; Tue, 18 Aug 2026
 03:02:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817132536.752504388@linuxfoundation.org>
In-Reply-To: <20260817132536.752504388@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 18 Aug 2026 19:02:40 +0900
X-Gm-Features: AcwNN1VSv3tFMRKcB8Zt2MmvSfZEIcWruvB_pq6_KadCv4U1NRYiAfbL3JXZGaw
Message-ID: <CAKL4bV5_5nvLXtc4GKhrvgjhdCerbyzqyVb=bfZwj26NUnJzYg@mail.gmail.com>
Subject: Re: [PATCH 7.1 000/271] 7.1.9-rc1 review
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

On Mon, Aug 17, 2026 at 10:42=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.1.9 release.
> There are 271 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 19 Aug 2026 13:23:44 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.1.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Linux version 7.1.9-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.1.9-rc1rv-gac99063060a9
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.2.1 20260810, GNU ld (GNU
Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Tue Aug 18 18:11:50 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
