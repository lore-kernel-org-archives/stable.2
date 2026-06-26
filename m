Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA5F3E5A11
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473738; cv=pass; b=odkIPvI+nDb5q0lT4xlIjz2AORKttUUyDokWPw/EB/MqrlgDS9uolwVB3xXicAGWXOUk0hcbaLpHTzddanNm0OVHiEWuvnPLLXgcogcSvHUB53X2M98qfkDtXOXkQeRiGo2kPIoF7zZ5O/orug99DR8OXgNdR3HeUeo3ymCJ6ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473738; c=relaxed/simple;
	bh=Rxn+mtVvN3Y7QxGK90T8elQRrDVsU9c8naA3aeDQiu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IgODTm7OZhm3qkVgzZeI3+ms1KfFSl0rAC2MLv+lgQYuYTncwa5c+dn8MFwfeJDikMp20TgU3p8AG4v9QLA7a54Ikva8JGa8ftfcJ6H4JxOZK/iW2Wb9w5328njRcr/9Dh6CiSe6miPxH6ttgKWeZvYJw/0o2VjKIt7DlbTkgw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkNkY6L7; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkNkY6L7"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aea0fff535so931070e87.3
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:35:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782473736; cv=none;
        d=google.com; s=arc-20260327;
        b=hbgMASps1z4ZGMSRS4yxu/uBwhQjshjcvhevmik6O2dHOsEu+nzS9a7fZq+4BdCBFq
         SQux0094ZeoD34NHuznrWAozgtQbbX6lduladFhp/bm7HoEFb2CLl5TAeF5EeYHsy+md
         nkxHZysyYxZmlBxBaoRULgejwagElrOnj3gmwIPEVMZqEIiSeT/fw1RIWeEcra0kgZBa
         EB/Hgj5xEvavqiEFyT4N797eLxLJJvgPO7oRnXdPriq65UfVc5idfVa11ecXjxFcOUg7
         aREagLTQusDSxCN2NVO7wUY9lU9lvM1CBuz1B97lJbtzueatNogNKS6PBvfUKz/1Flys
         cVFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ayvyuM9q4TQVTTnyXokuwNJ9w3R2Smu2UIPkUGwjdlI=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=TNYFDiNEuFJGUmR/hVVyFbQdwjidbwsUNI6mjEYZNysYQf2Ig/7hH1tBiYVNIrGTXY
         s4Ah4lVMH0Th5LYnL1dFp58YUyEu/1zdyLJuASj3GwX0ZHm9aosy/oFpM9eXIWua29vf
         6ximK+UwkIGj2yhMu8lRDr+LRiYJdPeD63TJM45L7Kp8PZDB0MsAueJjCusyB7LfCvP7
         15jKfdZfIhaJU6XiflFchDjW6vAha1eVnT+19PJHf1Ftclxqvf1sUWZezjaPnS2cUo9f
         NxzzkuO3e7/gPRNWyITVkIS1zkAIhBorOqbP4NGhuTNsC+nJrDyRqB4/P3US6XpMTVl1
         yZWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782473736; x=1783078536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayvyuM9q4TQVTTnyXokuwNJ9w3R2Smu2UIPkUGwjdlI=;
        b=VkNkY6L7pM6VXmy6acjKOIn/m3B2XVnygKrkpAeB/nbrh3eDOvTvolvD/Mq8PYQGoU
         6PiIJlfzzj1/Xi3pPEyCZa3lYYWcuMxPek9EdsT/ZVfu7QjabYIvTwLh5pB1SozQyFce
         lKn1p7ZU8vN1I4ddgFsxW8mwwE83gc8alKAcRh3vjf3eY8IVN2QEFo0+S3wJXeSh3oRh
         Iz4XwNkGKrU9DNMqbqRaFhOglmB2VVlklxVGrsy3oOs6Qk2dzR5aQqCLlDY+e0XSiEaA
         5HZzi+CzEkPJvhOqMy1/lELkBVye3RlR5xcv9i+JqUX5YZDciAHQnFwklJuvutRbPDBK
         HvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473736; x=1783078536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ayvyuM9q4TQVTTnyXokuwNJ9w3R2Smu2UIPkUGwjdlI=;
        b=AFWvfc1RTltNGjDcGtzjNFSLS0XuiAbvBoLzU/fGHP5koPWivHG6MUTyRFeErcEyHX
         RjB/hRv6BSukYQ85Teur3TzRapokmk4YqxUqKW0//wtu4r6J8Pa44ZgtBLRPv9P7dqie
         bWuoQFZ9tfBdC5hb3xYF+2/vPgtXEfpuQigXsWcrge/sjqzZkqlTwo6UqaMtigo0DDeX
         fXfGgjdvRRbH6ZYGiw664q07fGhpSHiZXUOCwBYXVHVUuiouyQbtD8A44iadrfPL1u70
         ykmnXj3f0pUAzCwOswXn5Qu0mNx1m+M5xjD/8oKlt1upoQl8+VpHKC68839oGrKB+167
         v/zQ==
X-Gm-Message-State: AOJu0Yxs5Catz1ekVQI1lZfo80H2+WtlNuXE+6iUN2vd/XFwi3AyWtW4
	QDB7jqdMVDC3Xniz9N7VKt6w/TTFDYrlh/m5l8PJmr6QJ3MIHG8PSCJteh9dQ9vPrLys1H3hDvh
	50ua+1N6CpyzkFsc5kgbTM2mQ8WqbwLgtskDG
X-Gm-Gg: AfdE7cn8MfC7cbDHOLO/cjMNeC8D2elqVjFddOJhLeqVnhpLZEopm1YDj1qSuQsyPo/
	f9aJJoaBxV0saPOoO8+hEUVndAdOFQYRmoDRsh1zUcc7jBRx6gKxKJIZ6R3EhUJbVN2GZo42RRq
	MNLMYOr7/WcNj7afmcIyPkTxoTSyxTuzki10ZedqrQRvMB/N02w4uohHwCAzm8H2E4zu5F8PxiK
	z1pn/DdUpj4dODa+ak4UMgOTna1GQbh+xEoE6L0I+92GS/EX4lNxD7w7O2yGxEPgzADKIzdXCG9
	LWFgbApBNlbGrj2tuXSComEoX7XAOg==
X-Received: by 2002:a05:6512:8056:10b0:5ad:3035:c2be with SMTP id
 2adb3069b0e04-5aea1f564b3mr1482278e87.51.1782473735324; Fri, 26 Jun 2026
 04:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625125613.243729608@linuxfoundation.org>
In-Reply-To: <20260625125613.243729608@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Fri, 26 Jun 2026 17:05:21 +0530
X-Gm-Features: AVVi8CfsdNoBWQSE0v-Hs5YLIHWBrb_3kjwmFWlET_3LOf1qtneq7ecokT3qaT4
Message-ID: <CAC-m1rq+6Fx3AARN=bDTLQ+oGV74mAdRCtq_iAtw86Qu_c9RUQ@mail.gmail.com>
Subject: Re: [PATCH 7.1 00/21] 7.1.2-rc1 review
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

On Thu, Jun 25, 2026 at 6:45=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.1.2 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 27 Jun 2026 12:54:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.1.2-rc1.gz
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
Build and Boot Report  7.1.2-rc1

I built and tested Linux kernel version 7.1.2 using the default configurati=
ons
on both x86_64 and arm64 architectures in a virtualized environment.

The kernel compiled successfully on both architectures and booted
without issues.
I did not observe any regressions or new warnings in dmesg during boot.

Kernel version: 7.1.2-rc1
Configurations tested: x86_64_defconfig, defconfig
Architectures tested: x86_64, arm64
Kernel source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux=
-stable-rc.git
Commit: ecd7772bf73899d9b6c14b7efe6d713949f18e74

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu.
