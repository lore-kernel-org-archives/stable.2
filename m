Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A913EC835
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785497020; cv=pass; b=Jf3rCnZtEy3zizcXTFVja83BXHWHVXdjWc4rSuraYb57zB1IOzXWHV+Uy7QvL7TqXAbGPAK+aNw7uBMs2HIKmjiKtUyXJ48L7lSBi48Mg2cGaWque4JpJz2Ny4osQk6TOhhmBIaFM//+HTxUlVxhm4enNK6OkbFhm2ttRJ3oFqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785497020; c=relaxed/simple;
	bh=Tjxrngnbb1L6fKIjskcna7MeeUTYCRbwtPNR2IeZhks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOqJ8L905DPyWBsDnyqAq+Nkcd7Dlu69YkJXwz9nIsoqkjuCfCjinvVWmGLgZA61mywn4zjG3eoX9S2GD5HTEFyPOIOXG3j631T5E4aWkyBVe7AZRtB12kJR/QkYgzUGIvNfkwp3Waq3hr/ja5noDRa57HD+e+NSpz1MUL38E0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=DKhJRnyV; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="DKhJRnyV"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a082b3671fso1391471a12.3
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 04:23:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785497016; cv=none;
        d=google.com; s=arc-20260327;
        b=Qrlkkzaui26c1qSvk8i7SiKZumHvkXaqn6aKa1KJHCyP1DjwrcFBvZ9O6unbGSK7UZ
         spWNzR4cjCgJUdQo3BvewW9g+UftCOcRKovfXA0C6C52eoJf+ovbF4JlJKw906KOFMv2
         ALxP/eVVb8s2DXC4OJ422leag8jx4xOiGVcmJl0c9Uc+jOLyH+wogRgXpzXArHJgtD8v
         WhG8wMRbLoKoPIiiQEp+BghY+GJL2D+Cr/nzl0uzXeKaM80CctJqYMw9ka8mzHzZeR6E
         +Ox5hUvh9gSs9+NOkGo6KgMxT+xT0E5xrtK9/lpW9VHZh1R0XFa26td12kuUQVCro1py
         rWsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DCSOnPh7d3OM5NtLNdoViyd21RmfOfuFsm28QcChymw=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=bBSePA2KjQPpm9RCvt0JU8e52lZbf9vGdzLmvfxI03lnHoS3SOq8js+/FKyoT/6fBL
         6xQtuJvgMmHgALldnx0s13Fb1fqCYDm7uvqE1hN7bnXznqKPoiaFyS9XhlIkBJ99rwqo
         ZXo6ud0mg6e6VOGNn+2qepJG0F2AqJqMvPgUyHFKu2oLCHWjldSTLbl9DrVcXG6vyZ8d
         wJDqamimzDVfsyZAHCdz7Ukd8qX6S9JX2j/DQ+xjXjiH8HA69Nvsdln7/qlhDOzyVUEH
         Tmy8LdH0Wj71/gUm0UXDVHoxob3lUlgzMcgROD/+xV0wKUZPJ03wcknarG4vH//mntwN
         1ROg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1785497016; x=1786101816; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DCSOnPh7d3OM5NtLNdoViyd21RmfOfuFsm28QcChymw=;
        b=DKhJRnyVO53idGr+6V7Gd9ylr1S4MHm4qjz+6Brm5iQd3fQO3FPdfUtNcJLWHtllFJ
         +z9gfgmoHlvJEUykmADbL9B4vQed7J/iOJ6Xp1RvelM6LI8p5cLdxKpW/x06D+4DoujK
         Fb922MJamZhnfkU9PFnk6btKZ2xKyE4WnR3/yYmr108OjW4CMjYAwgh3SZ/mCvn3lMSm
         pyAel4SYPPKMwCl16n+oWkfbdv5ieAKm+hM/r7yNHjPlQ95yiysCETjhGlYTlzIRVdpK
         uyhM+cWt8QykKOZwNDLJc/eK+cr7GCjj02wVco0ffvJ/D91gqdC+t2z8crTRR+p8wqXI
         EL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497016; x=1786101816;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DCSOnPh7d3OM5NtLNdoViyd21RmfOfuFsm28QcChymw=;
        b=UasfJFj+OQ3pV85/j8lFoZEzoFcmfE4Fskn0bLsK6aIvFAlkz8IK2APvEb/BBiYOky
         t+ApwFLbOTakqFMWsBX44L6JeoNuRZXzO0saDseCdX0tBfva9MD9Yp4yNW+WRpJq8lku
         StQ3VKAw2JUxPtVC4e78nn1Y5r9gGEwT7YqD2XK4YWErBvIE1GZe1VV1v7rZ7rV2c43C
         dm6jyMX/uIUVVUV0VQ8ZvBVloQ2ZGWYV9OGxsM08OTx3swIfZIh4JoDp+Ldb3WsS/Ivv
         RuqpkOJZYjjIplm81b7kXZnFB+C7hnWLqd6+flY5zdv2tN+P45jzCOvsU7RcvhNvSEsF
         ePyg==
X-Gm-Message-State: AOJu0Yy8odwK3tC3PJgN29y7V68tYKdZm8yHaA58CetUPTpUC9UyYyEU
	4ckdwU+PCP+8hQmlwg/Vqi/690NJv6v8MsdR7/KvUNzUqWjJSSD5xKFHW40iO2Jhm3NveaFxncK
	nseKxbHPqdrm7HMj+fLBYbcHVEiBb5ewMbBFm122wyA==
X-Gm-Gg: AR+sD116AZAMk9uvAGHJfGlhWH6YVRvss8GY8IWl0WLvsmdcVyx4arK6misuIgL7d+w
	AeMF2evg7gy1zp05l9bXGiYMV+LMGOhuEhvIRElAMWm9EhCdP66tHttwuHn3RCxedmiudV027F2
	3WRNwl3lmUP6RwP9w0iGeWU5FU1OmWdHDldx3SvA1b+YCkZYGU32yPMP5+s8cN2ZtUAfxJcuWNL
	0IRnQAdZCulsqr917qXTQ72SBTWXonFikWBiDK3wZJDo69EJJqQRL/38YNzM8pFkJFc996BkLMr
	65JJiHn1sbDnDy1zvkzePqxQusbSeYKFPtqo70ERUnrLqw==
X-Received: by 2002:a17:907:ea8c:b0:c08:417e:3696 with SMTP id
 a640c23a62f3a-c1fd1ecd84dmr109074566b.20.1785497015732; Fri, 31 Jul 2026
 04:23:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730141444.267951807@linuxfoundation.org>
In-Reply-To: <20260730141444.267951807@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 31 Jul 2026 20:23:18 +0900
X-Gm-Features: AUfX_mw3hd-7UMBmhngr8a7ueuiKz8UX9MJTHvwheDI8VI-Iv31bFbQRyyRd-nI
Message-ID: <CAKL4bV5XWoE+AmOmgm-yCSLoDX8M+KzvbNgnDyNt5JKzH9mHbA@mail.gmail.com>
Subject: Re: [PATCH 7.1 000/744] 7.1.6-rc1 review
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

On Thu, Jul 30, 2026 at 11:43=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.1.6 release.
> There are 744 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 01 Aug 2026 14:13:38 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.1.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Linux version 7.1.6-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.1.6-rc1rv-gecc0c68d2044
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.1.1 20260728, GNU ld (GNU
Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Fri Jul 31 19:44:25 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
