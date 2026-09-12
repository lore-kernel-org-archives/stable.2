Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB04381B0F
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 21:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789248157; cv=pass; b=uDOEIj3Zq8C9YOr5PjFhVpJLLCJ2rDusbbC+IYUylk1Agq6OhbiV9GG1jmz2bKRqAISXedVHIBaek4nqx38Q2NeM+YKQxm+rabjGSH4rbbcb5rgIf36GrDIz4NhScECnDy9g+Ix1QFc78+BtJSuTDpAfYoGZkjeEc8JRjlicHnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789248157; c=relaxed/simple;
	bh=K6b4Y85zB8F+BBk4idWUHIeZSzCGOJi00zwSBhhsVs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bG/no9qqDnhtkrCddSrhWq8G/wGPrEuuF42ts63wbSd+PCqCTVRhJePq0neIukOS6ETHw/dvJ8Cjbx1Npda/Vk9RRypsBEnrrC68aLy3vxczb0lEEqBD/IhbLcazaaK1zY6poC4bB5fk+n/jrYDqKiSgE+z3A0BCqEBXFj6kYwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=JfeUDq53; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="JfeUDq53"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb470so192286866b.0
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 14:22:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789248154; cv=none;
        d=google.com; s=arc-20260327;
        b=KSXP3OzXfjjVA4Z7YfKvTsTofWUU3smxVhQEM8JjyvjBdukfeZYw/ZUtdqcQI8j7ig
         KhF7Z9it9E/M2vkB++ipyW7yg3bJgA9Ma/KatCOVoCNF0GjFHViKHDXWoVEfZh4YLq3A
         arDmXBE/bZxGKXOitonj1jzvfunRSvZb4wRwIZJ9RSEtPSjwcBp3MBk81zbkMIgLHTI+
         f6y3Rf9qLrSc+NU1VMhz7ROdblw6eis6Qnu4oIFREQtHK8qIKOVlnv4ECXh7xymtZnyq
         XIqgkmjVMs1WJVezUseR2ms1L0FU5oO5vBqT1JXaWqo4DP52r1OnhV77HQ9CERvEDpXX
         ttGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4+uRYIalsrhw+jlcX18QMk7mu25CKrBRK7xynbg1dqE=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=IB0gEwnnMQIVXK86/wgUTthm+lj+put930s+6SSC/hiCSpGjq1OfXio3KA66o+NdQc
         NKaPsDqhaduSyA62rDCI2Z3lw6ecAJkrzd1Jt4xaIK9zrg2CDjlZxqIphAy7y/ib+VXJ
         Y0hw/CxZ9ujdjjpxkCxpkzl/AyC19/EWKI8DZXJ/3+S9zCmWG1Ak9xGDJjhWwiH+W2/I
         zEMo/P5BIcAqL/8XBPsGyawFhHY10QBlZl/aP0SIbqtZz/6ihVN4hQak0EgVmw7ZVO3a
         P0ysji+i44sDTNPJwgfO3QX2H/jIhXG9PDwpYfWHgI0jyqIuiN+fu0NNlFkFvzqGGSRl
         aHSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1789248154; x=1789852954; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4+uRYIalsrhw+jlcX18QMk7mu25CKrBRK7xynbg1dqE=;
        b=JfeUDq53jcdRKrQtu7bUXKjMkqNRBIw2Mepg5BfAFgnwbA0AyFAWkgIDpk7aDbBXl5
         57htJO/RZodMMddRa7PYLwqyuxoe2vn+6S40SErhnc66WyDdnRhtwHAODXuok/Q3N2W9
         2as7MRbhayh/YiGSjsfBECs4VFVEzPjb/ebv3w0Tymh+EdoeW6hB5L5TG9wKxCMS+TVq
         PwS5LL5YV3iGEHzAdZ+lq4QZmVfodSY9KsB3PYm6nXuk9P9WLO3D9OHOZkSI+TeBkEfA
         ZNjUlUnQcru8rE3uQoEeuS/Vhp740i6cqYzcUCRsKdrv1o/TmJmQAfKY0bbmGzjjdBCf
         SYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789248154; x=1789852954;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4+uRYIalsrhw+jlcX18QMk7mu25CKrBRK7xynbg1dqE=;
        b=qtqRstj59RXQsOsKYBj1/b5SbXMLwIadE4RWRKT8fYxAxOfZproznvE35GByRQyqrM
         YlThXR/2f30JQ7VxudEjfcokNnDuPZe/39iekME62wDZ2VMbQ6dinU7EGGYViDDvGfmW
         RlF5ARB9maQmL8hMuLxXGSvSYkReBLwGbD+U4yBVI73xQzmZJwLfK/rA0Flb67SiexOp
         L2i8ZYIf4lAKAaFKFNQEEyNyanPJAZirBvqAWzQpr+8xK+WoikQj54NjbzAusotxCpYA
         BhWjf9Lsli0njfCyIF3z0p9/d357JjGrpQzXbhvTWf3H2tAUM4w+gUYOnmSu5Vm3/Aik
         gL0Q==
X-Gm-Message-State: AFuF++lDjLxRJBU0vrc4ZGF+pIVhmPxrkuRhDK6L0vqE0J7RBQDpHE4x
	8fKnCB/qJGMDEloK4HjzrczTE+NtcKvz+3SLY7mRa7zYcr73ZEY86zMWIcVN7k9VSKOzc7f3ozm
	sYBvpPfoP3U/7rJzAgwAy5ihfM/tJn0sYMsuV28JrDA==
X-Gm-Gg: AYBFou1iwUeFs3/Sl7w+6xUT2+5CH62Q1dcsmN1pb7kMErHEbC0kOHNcGBJQHJw20UH
	AhLFsb9dYS3pPlSTmufkyEWfyBJtvvRh5xM8dugfrraYW0ArFef2KJeeq9zVEJ1X2ldZD1bTHB9
	s35JqymxcSZ/w+Byy7tdz+URLU5rsVuFJwM5DcqbHkceA5NI/WyZGhspWaoeKN0eSrjDCzW8zvL
	gJ2wAqD/4cp2s5vKRG6Vo+v3ONeALuEcNIvcRyb4G8uRe7ARJyRG1ihbxhaPZgz1xi3hJiZ65hE
	IxR/6oS2XvdiM05GD40GWZqR94iYhxKb4jPMPLQNX+k2DAl3BzlDHj3k
X-Received: by 2002:a17:907:1c82:b0:c29:6291:e38a with SMTP id
 a640c23a62f3a-c29665acdfbmr1025781366b.1.1789248153717; Sat, 12 Sep 2026
 14:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912065648.999753832@linuxfoundation.org>
In-Reply-To: <20260912065648.999753832@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sun, 13 Sep 2026 06:22:17 +0900
X-Gm-Features: AcwNN1XKQfCG5_IOzoP0tn84TLT5vhownt9emT4x-a22NExaXwsm-snsvHub1FI
Message-ID: <CAKL4bV4_Pdw=pFU5RcCTpNuWmbYNeEB1jkCtwuaVNWJcMSfBsw@mail.gmail.com>
Subject: Re: [PATCH 7.2 0000/1815] 7.2.6-rc1 review
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

On Sat, Sep 12, 2026 at 4:07=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.2.6 release.
> There are 1815 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 14 Sep 2026 06:54:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.2.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Linux version 7.2.6-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.2.6-rc1rv-g048ea6124e84
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.2.1 20260810, GNU ld (GNU
Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Sun Sep 13 05:45:30 JST 2026

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
