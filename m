Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D431A3E5EC6
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 08:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787906643; cv=pass; b=bAkT02f/IjBjBFd+OyMX8Iwxo5ly3xVotKB3SpwSkjtWIfbf6KP/SzCqUI/NEEinlC7vMipWUrMQI07Qhsp5H4/317nFHcMAGrNxp5a64/4asehFv91QyEE7NataRLB3ginN0ddJvGA0dYoENtwTNRFA9aY6zo5YVvnvjOVVL+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787906643; c=relaxed/simple;
	bh=+SsljDUXUlaGkl/5WsILjVk/5Y4d+UkaNdguJIKngg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNKvPrmYOmw5s5lRwP3aAAs6MFegcLhLpatAA80D+QEHmgmqLV/hRVyxEWyCuP1Xk1UhQf6cAcuLpPLO/RW9HLAwmMaiDEf7f2Vyxabq8t9Fo+rgmQciNoTPlpfV7EsPLZlL2QJxewbRZbr+Ih4W8QMz/PT7SaifF+lnDJL066E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJxqxCUi; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJxqxCUi"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39c95395230so5813201fa.2
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 01:44:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787906639; cv=none;
        d=google.com; s=arc-20260327;
        b=b8UQv//Cs4TL5Ti19wu8x/rVJUiBqygLZnkkxmBGid68v6zIugdtv0OR5oOIamFStd
         PBYMWMX9snC2JAyHsEvTS4QiTs79k1nc2dbjYpWqOGLQ+AkB6zXJ5im5GXw5LPPRxNvn
         d89id78UhOP89Ds9+UW+QzG/8H2vldjBs+TXBw0lhTST1xk+B5D4pFAxux+qChx62fNH
         suCB9XUJmzNHMOV0MNGaSxy2DCRD/ZGeA9LO1ndSUlzKaDFZVLuprOXs8u3kyxuagf1A
         ATNUd/RNa6ly3p5n+otkIui4TNduN8WX0NVJrDr/thfvvy5FvFFnsVt8C/QhUACRucaz
         eLpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zhsiaAmVjzmzESFqvr2tri1C/08hg86tA9bCn5YqmwM=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=WiQ4vUyX0/IuU0dKvU/Hy2u2N9jBAa5+6EJxUeYJmwqlHdVJXPHH4SNmZ0ulXskfqw
         h/4mxI2VnZEjuSL4D7LcES0l9eaVpwyO76nZUeokvhxZZaT4+v3feVZlEgT4ZD8uzsVX
         Q3p4BB+3GA1h/IIJqV5FJLb/2i65lupTPecuD2Wclnd2+QGjtv2RTGjGm5NiYnKbDh2J
         UmZi8mbxvmh+gH5NwYveiDuGW8SqxIRxR9ZE2Q7pef5wRg1HxSpZi54xTeapNyi+v9wY
         qCnrhaLBc/rsYLl5Z/3KoWskAyvlN5nea2APeZbphKLF+u3tFj9YxiV76MoG+TwsPRQP
         DjZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787906639; x=1788511439; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zhsiaAmVjzmzESFqvr2tri1C/08hg86tA9bCn5YqmwM=;
        b=MJxqxCUiRoJIE5Qatenl7pu69VjGL37LU8XrEU8F6S/bD0N2wn1waEbQLvyrzb9rRC
         7KMvT8HwQsyojBBkZPlA8syUGjBMjQiCFbjrPtLZeTurdP+BDaM6iVt0PsWhYgfFg8Ud
         zbIAqTEL4CMMT58wkfToDMXGBdk/SE+Ab4dueSgNewMThW3kSkQ3Bj84+llUOidpbFkb
         6CNbbmoTOgMEZzFN/l1kfZXTZL/v/mwUCXfK3aPrex2wtFRO1CgIHD3MDHzjh6GHDwKC
         Fjroq0/52tN56RVCXSnljT5P3s3HdsM8X70lZxyTeFimyvHqYzI+0GQGXbnckG7WwiAz
         g6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787906639; x=1788511439;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zhsiaAmVjzmzESFqvr2tri1C/08hg86tA9bCn5YqmwM=;
        b=Tj3jCChMeZBcq1TpyYEjWAVnVF52c4moe1B/la2ng2crNGE4THl+1B6VX0LMCMiZVq
         O5iNozQWzWE9tavLcDOCc+KZ+6m4YiSJueVylZdgIj8EMQeWrQUCxAA+8/SEi+RqQJnQ
         vcw7t97koIwW5oeL17aYt43SWL3ABvG8/ia8+AYwd8WGaaibkgYigGqNuL8vgP/nCOjr
         8D8eTfAGj4cW8iQ4ffXWLyxxhX0/BR+2Nh7QE1dHfhDKExnGmby13zq41KIL48rYqBMA
         VNG4gUT0lSLHR8X4P70VUyeM9KHRHs+zIR7jntzDUxoage6yutGcdMxL7LD2OkVHtYEN
         wKFQ==
X-Gm-Message-State: AFuF++ktb6sz5QSqy7Zcs0onfa3al8UZTd5y+CxJnmkJJgnBgGqX/JdC
	Esgz6xl9oCJsk7V/tFMCIq3w3Zd9v6OFcTuzv+97YvuAKeCpnwJb4Jrmkdh4+VTCuOr5KlVKDie
	ANmx3juZ4uggoeU5IgjfpADSGQXejbgTmgaDZ
X-Gm-Gg: AR+sD11WSat3zAJkQz5KG+2iR565hz5+eZLBh268+IkkQy2LSt1PYllFYpGIK9H5Wr3
	zhJxzzhBQIWwlOsZuj5XB+7S9NUy1NNN/7Hb9kQTWYjY0R8/mSlExBCF7YuFh9V1lCkHhy5xwgy
	FWGOjvMhRbT9Loa4yYPyJEgSvoVY9kwroaOSEc2fM02qL2K/UyY41Ng14YshMTQBG+iFeN089B5
	nUo403IuKYTZsq6S/lMdPjmVbNSBFPt0bl2c1sC5Fqo0FdLST1fVRB2apUeqSeSboci37aM3jPp
	dmWnN9CHS8GU9yiV4Eqcimm8wnrT/RaBs1kIPzbHQLhoa40SSA2lRaITIVufg/3KoxbTq4rbaLw
	0yH0=
X-Received: by 2002:a2e:bc0a:0:b0:3a1:94fc:e1cf with SMTP id
 38308e7fff4ca-3a301b26568mr8446061fa.10.1787906638442; Fri, 28 Aug 2026
 01:43:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825132541.986300899@linuxfoundation.org>
In-Reply-To: <20260825132541.986300899@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Fri, 28 Aug 2026 14:13:44 +0530
X-Gm-Features: AcwNN1UhUoRQqGS--MuKqVVwHa7REQ0stzNan3AFZ6MJrTOOBIX7BijorBSHvPw
Message-ID: <CAC-m1rq1FSDpRMR4+hYrg0KnJVuiE4R6ggPyCKGfFKu8OqFdKQ@mail.gmail.com>
Subject: Re: [PATCH 7.1 000/101] 7.1.11-rc1 review
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

On Tue, Aug 25, 2026 at 7:20=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.1.11 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Aug 2026 13:25:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.1.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
Build and Boot Report  7.1.11-rc1

I built and tested Linux kernel version 7.1.11-rc1 using the default
configurations
on both x86_64 and arm64 architectures in a virtualized environment.

The kernel compiled successfully on both architectures and booted
without issues.
I did not observe any regressions or new warnings in dmesg during boot.

Kernel version: 7.1.11-rc1
Configurations tested: x86_64_defconfig, defconfig
Architectures tested: x86_64, arm64
Kernel source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux=
-stable-rc.git
Commit: 822f846a60fc16f7c944c77d54276d8932b2c4e0

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu.
