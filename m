Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8863F20ED
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473060; cv=pass; b=XUeOf66+wZGNqzqiyTiHiTtCEB4WZDfhslOjiKolG7fA2HaVGFeZlFkxxhUOS6FMZ3YTMuELizQiLaY4kNub3r9jR1phbvl55YQCTEM1VGfqMD06zq/QY3v7T0CgCj8Aek8y3WZ2eg+61yksULhm7o3U8jrBGWog4MmC5ToLFgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473060; c=relaxed/simple;
	bh=xZ/R/Zt7PgmJhxoYoeK4UlmlerKBzAq/QB/jVDYuvU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+rcuncyg2j71WQfb883oZfmwOO+FRjUX1yb6gu/LlvNdb/6eylCrBS5V7WPHHETbmswaz5u/hWFO2zDd0uoCh2jWPhpHrdBErjfhrmNuQsXAdCE9wZwjH9FcFVZEIBUU/VEO6oK0Yjkl+lNOYs7rm00kPa4QMOO0Q4k3Im6AMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIYEyu3H; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIYEyu3H"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5ad4d262fc1so524404e87.3
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:24:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782473058; cv=none;
        d=google.com; s=arc-20260327;
        b=lvaT+WOBk6v8d5Jl65LpruE2I7xdRd+dehAc7Rd3wnD6A0gJtETGVr0admAZ6PLeFd
         m/mJG/Pt2tK+Sk4K/KSfzFmRDioASqS1LJ+ShUCfyy2QnEyfY2ku45FJ3Tcm/MPHQdTW
         MEA3pe2M3IdW3YYn42FvevuKZUNRAG8mg+W9g6pIy2TlgOXyCwl+Tui3UgJcMrLmUwZ7
         rt7QqwEYDRNEoIHQ+3uoFjSnui3iAWf+O9jmsmA0ZSesCE8sXUgoZHamugUfBwNG2yAF
         EOmLDmY2HhPvK8kY7OGR9rXhjxochpzFHZrDE1eKOdqOmVILeQLXw+6cg7jXxGehhtOi
         29jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5n1KTYhtjeLxiVXkDdVMmsMn8AUalKdq3qTEM8mYquQ=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=fbR6nIeOh9ryErd9HlguEWyQ7s53fse42M7iJZlNLEs2YJFuNdFccsNVa1Xq9axDIA
         hyaQVUNqrBPVCoHfvgtxglbNEFR13yZqH0TGYgbuMSh1zPwnGvsCju+TjPPy9FYC1kvj
         8A4gJWc7e/Bwpd/IL9QV9KH4D1zhAjWY28XbCMfe4tB9tHMP9PYMLmwdkFKF2hBZAJRz
         Px+H2TbuW8trNpp2QKhYzxsl8cyPVJM9NtDLoKXhY3jzUWHVdrOL2qxOmf2Bsm9DQy3v
         E7RhgsqGcpiTMywnhizseDNuRaO9MzU3vUFsA7gMnJz/ikE8KUeyQB8bmiZU01EprFX3
         ZjyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782473058; x=1783077858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5n1KTYhtjeLxiVXkDdVMmsMn8AUalKdq3qTEM8mYquQ=;
        b=fIYEyu3H27ZB6qq8ZOM/SqvkrtssnOM/thI7KFPc7ia6FEFzw+JQOduv+F1T24UCg6
         AMWduBbqo6x36/ZCAFYFbrJ+RoOwvaSqjKlkhto30aIWB+0HS7prz33pfydTpW/Crx9x
         X44059fSFt5FSW+N3trsfRvHzVIG15sAx8Y/WtK6ej5AhHJTUySukcsocxujdN8gHht3
         nZW9h/uBrYTegeC9w4VyYP8uOssxInhWT2t8Afs6SIDhd4s4NzDP2u/8nNiio1ZfUx/f
         3WuKNG77K0sWv+JLP5JaW9D5WblnYF0FjBmA/kof33RKQWt5oesFM2mImO3cPufS7PrU
         hzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473058; x=1783077858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5n1KTYhtjeLxiVXkDdVMmsMn8AUalKdq3qTEM8mYquQ=;
        b=QhQrVNThNVnbY9PHUYMg0c367MhH7LmWK9L/zVHfb5fx21FXVvREOLSfc5zMt/OTCm
         4LX+HqfZdhxLKrJ6Gd26amCMr+uAK1+4xcOcysMtwjSLCMe+zrEbfXUXI4BPl1DZ5QQT
         kZY5aI6cfYFpQFiRAhaG1gCP9NQMypIZ1ZzEB5eYw04znjvO05KZlApTejAH53VoC/a0
         5QBxTI/7b39gNrCJ3ldlgSfZG4oGdmHImhta9yjCDeWWPpcCBtYr7bXCwcpwoMhMJchg
         dh2w9UsNjLJ2Jnb8iSIEHC2F3BQLs7DBfPnoJpt5+dhMEOjx7BB0sdXl6IkbhANxZiHF
         r71Q==
X-Gm-Message-State: AOJu0YzHVmy6XCVWVgayW31or9+IXdixt677Oot5EqcGkjLq19GGGgwt
	drK9i/fvYmRQTLnMlVFdvgmfFjDTbNQME+BN0Fd7goZAyCdPzfjBZFKcR76nLRipKwZrQqDppgA
	I4P/OMEZ7Cu95o/rE7rfyvwFOddzSk4A=
X-Gm-Gg: AfdE7cl7H5Ud0k7bed70f7LiIjV/gb75ScwnQh9j2jWEi5NkyMPhnN+R66UJroT8/Jp
	JTJkzGsrv8LUrRWTu7ITqCLwKM5nAviIxPrXMp2/OAW0QAuj5V92sWsuQ2BcjPdpvw+5Bh7yBH7
	aHfnwfFp1P656hwG6Eydckf0wo0ENuhTVPoOlughSjCTODFqmMtXPAycuW/4OIvkUJ3KTaolQXk
	pvCTLP9wNR39qbpi8PSucxOCPyX8mp1jJydaVF6ZRrA+GIuo5FXnZm3OKDi9du9SXGsKnpFmttz
	BC8P3uZc9TVHVKaT3aQ2M/uxuL0Zng==
X-Received: by 2002:a05:6512:1192:b0:5ae:9c52:b9d6 with SMTP id
 2adb3069b0e04-5aea94ca463mr29530e87.46.1782473057477; Fri, 26 Jun 2026
 04:24:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625125637.527552689@linuxfoundation.org>
In-Reply-To: <20260625125637.527552689@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Fri, 26 Jun 2026 16:54:04 +0530
X-Gm-Features: AVVi8Cfmrf9dbL33Y63jPkddocZUucSkF5t3z0qFMUseZDAM1JLI1giLXR2lfeI
Message-ID: <CAC-m1rqnH_xB35szbw0BDWpit7FBjiCx3++YRYwZmKhi9KJtww@mail.gmail.com>
Subject: Re: [PATCH 7.0 00/49] 7.0.14-rc1 review
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

On Thu, Jun 25, 2026 at 6:39=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.0.14 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 27 Jun 2026 12:54:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.0.14-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.0.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
Build and Boot Report  7.0.14-rc1

I built and tested Linux kernel version 7.0.14 using the default configurat=
ions
on both x86_64 and arm64 architectures in a virtualized environment.

The kernel compiled successfully on both architectures and booted
without issues.
I did not observe any regressions or new warnings in dmesg during boot.

Kernel version: 7.0.14-rc1
Configurations tested: x86_64_defconfig, defconfig
Architectures tested: x86_64, arm64
Kernel source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux=
-stable-rc.git
Commit: 3fb5acefbc963081c2773b7adaf1f2ed05fa47e9

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu.
