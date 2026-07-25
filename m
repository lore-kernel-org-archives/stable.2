Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA8030B51E
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 01:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784942662; cv=pass; b=ZQDR9Xyp8MoL0fI3+w+MoYJqXwfudKaCKyvZS8k4gwHBWCo4RPdKVo6h+G+heM04pJlwQAdaReKUWmWHpCDPSPO7ggY7aa0RoRDIPW2Up+ClK+fwAfU4qFV5EJ+TaqyQFkhjkihbbFOSW1aJteyKwCjrFO/Jk716e08Cif2+GDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784942662; c=relaxed/simple;
	bh=RR/N+7U6HxpMfVUnwIY2W1vRNETeHCqGINXb3mjcJBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3xgG+fAqrml3raUKbdpd960vOL3QFAqR07x5VEQjCUSsAolMKNdmWsSTuDX2HLRhcmLxNwwU6kYz0oXdNekMozm/ea/JqNPDNQjJuVWiTzaFwfdrY5GbvJEECuVXIi3AuVs1Xtusb59XdcDmbP6+nimE2BjJtuYVLGnjV+Malg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILzkNQco; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILzkNQco"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39c9452243cso8754161fa.3
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 18:24:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784942659; cv=none;
        d=google.com; s=arc-20260327;
        b=YEw6+sFuRa8qxbGn7JWTYMI1bpZ4wNweraj0UfF8XcBjy7juW9UtCZF+7lflbr0sjO
         dtd3cqTUbakFd9iCz6BXEMdaBDL8T360AHTCEnEZGv2PAb9CVUyL+nClcDTb9xUYbAf+
         4J3qwa0wgW6rLQe4735XoK+T05D6vYo5lJZhqaHb29wgx4wYdzIN46Nsyga6VDiv6vj8
         HJYMKqBDZb++1w32CtqRyizHQWsdWLGn55vkmCuYIGkIXIHU71ecRQkgM45xezZhF1Jy
         YpqKsGApnLkl8DfUgrslN5a+uyy+rhKENDhWbqbwXXvVUG0eKfrS46me20q3AUf5Rq5H
         teWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N/CJCfH0/SDNKO9hky1DdcwmPfaS2frL/4dsCfTjLhg=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=cAi0CvEzRTtyFmEGmAAWcu9qhCqRxKYFCzRUHUfRUxIXw/pj6fq7vGD0uEhmIxpzUy
         eCb+ZNkt0n/B4KlY5H8uQa2O+0iiAvAR4C/PZACqsRHFoUuFDmxGW2z+aCLNL/tAdxOZ
         GHvbPxRA/bHc6u6jGNDZ+VH4OJx/CMhXaN5ZsT9o7DVEFtQTNAB/oqztUVIFP2wVEkfI
         qd9q2sX0OKgotAoTs1PzFDfnjpnNWBIMRCRcnAQ0kIGp4A73UbIVKDjJxAvJ1jN+Aez/
         sfV2++bapyQaVUvVZVq9DoorGb9KGthHJSMWkdqFhRv+SWGnUvfOPxKUTiyls7KVvTjH
         vDoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784942659; x=1785547459; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N/CJCfH0/SDNKO9hky1DdcwmPfaS2frL/4dsCfTjLhg=;
        b=ILzkNQco3I0bPegXLmY3HBUgX8Sp60dhXvAgn+kQJDgglaTjOO4CN75s140YOifxPF
         3y0bB0ddBXXnA+PIyGNbJKqy4eVF71gAGOBzgIIfmv6tGgxJ0VPDi2vh5xbnwJBQIOui
         XRPItXBpMvO/baLNXkbuNOdBtDfvA0WLV/iHjS7zNLBTA2vFvHxN21xosIOR/N1aEihY
         0SLwoROjlL+IwWuUa4IHd1dvp3mWha2CLddA4qDc4QDhkkMNpUVpP6LGjrUY/6aql9mB
         RvhnUj8YCKcQetYohk69CJlnlJNkM3zk2sQUGVbKRCjv6fh+zJsAjvIzrYsD8EWjuueo
         V81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784942659; x=1785547459;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N/CJCfH0/SDNKO9hky1DdcwmPfaS2frL/4dsCfTjLhg=;
        b=NA5bkdWbaAQ1+mJAbG2C2uqdi8J0NJP1Na2smwgD8laMzWplqmxKw4qcA4x2iOMdre
         fF4bqn9f7Wh1ILZFbbgrQEoXt3LggYP/QqQI+XFw4e1MzWXwnj4rpBdh1XBBsW9Rrybq
         pu8ba/fR3rqnUTa7BoRCPzziJc9dmmSweR7aaYf3YoFW31VQaMwDrtrgSYppjJfVzBlW
         gMFIcXEJFeYdJ5cfV/23IfP+MEWgVDndplD9CV0DnX7VqFx/2JfURLbvdp/35F9ZPd6Y
         ONSKbaT98Z8X4VmxKaiSy3Weenx/d7P8famcsUNxFcdgPQ1HtkQ2RFIXwsGCPSo4mxdb
         3zNA==
X-Gm-Message-State: AOJu0YyiR4zzGJnBTvhIYLr9GGhcKCyzjafxOxn3YpZPPRWpwv/u4jIF
	8hFC+a5qTl0DLesOdq2NU4CtvZxqiSCpPWcr8Ag08TLM51+wFcfWift/Uh0EET16IHqpNWsM454
	9NEF/bI7JM5gnxdIbfTwLOfLDaf5V7TE=
X-Gm-Gg: AR+sD12J/LTRwVdW9mQveaHfyd6RRGoT+LNwTRUPEwjCwMINzgCMdNbkEFxBAMPx4QF
	ZJ9SHDoN8TIbTlFb9irI3bd69XHaKWK5A7s03dnjDVZ1TvvdbYjAnRr2xzA1Az+VQ3OJvYJAVRq
	iSaVh9VFf5vYW9J3J35GaLzvR2LT8F3hnRjRcbToEzspHVHm8NWTZimwPUEd5456srlwBUdfPi/
	VbxhaHLG0xKdtMVh9EyV9o6ehRtjTTHDqxnPSUCN/WdkKqpZ3YemYxXSZMgIDe1FRQglYdrGlEW
	YHw9HJKdrG6XFMh5EnM=
X-Received: by 2002:a05:6512:3d21:b0:5ae:b75d:8c0d with SMTP id
 2adb3069b0e04-5b2c1afecd8mr59784e87.12.1784942659075; Fri, 24 Jul 2026
 18:24:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722142947.085426486@linuxfoundation.org>
In-Reply-To: <20260722142947.085426486@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Sat, 25 Jul 2026 06:54:06 +0530
X-Gm-Features: AUfX_mzIyZ3MrkOex7XlD4dMeTTVkltiwhpKNUAGs3b5-mmzTOIMJycxWGA2hag
Message-ID: <CAC-m1rryTBYDDfroX1kuLa262NaMh4ppoFr=m7RaNpoUYVxMoA@mail.gmail.com>
Subject: Re: [PATCH 7.1 0000/2079] 7.1.5-rc2 review
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

On Wed, Jul 22, 2026 at 8:09=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.1.5 release.
> There are 2079 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 24 Jul 2026 14:26:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.1.5-rc2.gz
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
Build and Boot Report  7.1.5-rc2

I built and tested Linux kernel version 7.1.5-rc2 using the default
configurations
on both x86_64 and arm64 architectures in a virtualized environment.

The kernel compiled successfully on both architectures and booted
without issues.
I did not observe any regressions or new warnings in dmesg during boot.

Kernel version: 7.1.5-rc2
Configurations tested: x86_64_defconfig, defconfig
Architectures tested: x86_64, arm64
Kernel source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux=
-stable-rc.git
Commit: ad98fbfe8a23687c534125422868b050b67eb6ad

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu.
