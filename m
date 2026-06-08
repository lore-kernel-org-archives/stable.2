Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203283EE1EA
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931984; cv=pass; b=NKVaMK6SgzaWtMaAeB/VRMRcyY4Ks6h7oXV9IAVMilzxJE63HsEiWFIfRgFbshEF0WEKWOpF1awcwaWXh2pRJsbU/WndqmCLv7sxHxEcJtL0BYhoFekXOwAcpMCkVRSLKpar1vMo5l/KKZCKy79l1GPjvm1gsnxwWuUg1phFmos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931984; c=relaxed/simple;
	bh=g9C5YtZTmU1NxdMueziYBeIH6PBdski7wanO95VY8dY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXxYA5Kf55ArNdTcl4sToIJ7hwJKc1juqhmWTjBR/q+S93D18FmwPwKcf67frBOTCVOp7HlqmEVpmWorVcCJKVT6d7pzgmw9Sqa83gWeMTaop6VtGCP4aED7uy80N0dZveAmyp3mO8B3d+b0eN8oHQxy7jpSvyL0lfmJmzOujfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZ4jX469; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZ4jX469"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa5be9ab1aso4147412e87.1
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 08:19:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780931981; cv=none;
        d=google.com; s=arc-20240605;
        b=eT9bbPCxpDrO3SFbarlAg1tdVbzfaFVTDy/hTfWrzJH+YzgUDdU1xFcDGmy8bfAICH
         KjGqACN+IwVVRjpyFRRoD90BHJD3hoUiQfBid/AJ2rlGBulw24xFl8AP/3xSZsBQC/Hf
         gElcrOCGjxGffrmY7wEwxWUVFLYuUvd87ZXv9ShcW42q6Vnai20Yb+hD86fXSHYTrpjq
         mbVoDcY7RaMOEcr2XuNIAwcb1VH0YEmWcl9lc1B5ZTq2+IMvAsQ33+5/KnazSQZjXA3I
         bpIIJs1yf9uHPtD5bVS9dJ02dPR2S/U/sQtMov6L47rvHM8oa/Q/mnqzz1eUY3IETMip
         WfRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vXk1HD8jDBLdfN/s8w4XsyhJnLEeKFkiXtViPqwERKg=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=CFv1s5xPR5k776OX50vSKOkMTlqwd9xnl5CYrU3zw28wOK9JqH0iKv0hpmVabk5Hcn
         Qws41JkroUAb2L8hBlnvNXoPpIvqjZFoqhv7201fPsXvSAPawq4aSrIrCeRz//wZYqdr
         9BHVWtuymDIT0tQkgdbUh7G3iG5VaWXaw6B37cDCKjuo2/5Dr6zAo/SZZ5oAaiE6sGRe
         QQV8fyUkaPfAUnLRNPKwlWuCCjJqsb/0lwTWf1gFZlpBGzSQBBs7fwDkMo5B5effs1er
         CQ0GQYq01oA+EKu37V4UQXDETDl0kjykOljqvLybd/h654Zi5gmipPeI7gPyW4SVGvi+
         YkPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780931981; x=1781536781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXk1HD8jDBLdfN/s8w4XsyhJnLEeKFkiXtViPqwERKg=;
        b=hZ4jX469MWOiOMcrMrC3uXtUrEJIqGWQnV2qf+xyFtpdmqbbcIfX1nye8q7TcOtpbb
         kUQ2YPEG/I6rE/c8YRv8MeIoJ68b9HZcWVhO84OPyGlMiSiuyM3slPbwwfa9jeI5H4do
         7VmmRbI1R/bOF9Yn3K4hG2D2kNGjMBI+JElYeo75YzR2N1E5bB3cpp3y/33FzhqpptnO
         KgugAodtZpUwJ8wRDbwxGu8eiFxJQUesnbiAxB8CowUJtgLd1pR7/FkbnUEzhbnVuBvp
         SVg9LH64yJC9FVItJxqvV8zPK8ayT4/52payyEGqo00HNtUk17hSlpuLTr+Pw2hxULX4
         qB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780931981; x=1781536781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vXk1HD8jDBLdfN/s8w4XsyhJnLEeKFkiXtViPqwERKg=;
        b=hzVCI3blAyh1JQ3QkeKZgOTHSws01czcpL44mFgTWCAss4K3oayQIz/BKz26H43JBU
         lA6dtIs+YRm8ED/hCFQI8RBnxGOlr2RhgR0rtSq+rsnGjLGeuzMMD4An8e9lpoHDLl5B
         UKQkLKQUNhBhAX4D+iElV1tNrqKzHqI9WwUkQIUPYwiqMQuR2qfvuPZQFk3x697S6k1R
         KtiM47RCI7HWZFa4nTsebxAy7Yw7ujlTN+IgvLrTyWnZ3Xt3AXju8BXMH0IFVEKhpkZk
         itY3FVXaw61kPqjoY6Rb7wR61WesMQb18AqQQANZ2citz2vevMjdPxJodJyVURVdRzZH
         r7+g==
X-Gm-Message-State: AOJu0Yz0WJ/bbQU3oWpgORz06Qv1rZS8oJ0ARg/55WvxSOBX6cXl5Iz2
	pgkdS/uLI6+Tzun4xHIciuUmy3rW+Nqreuz34Tky2ZEPOfi3nl31h6krSoY0AAZ8w/KfSMiVHCL
	HWepGXNlpAtVHzeeZkTJxob0aw3OfhRo=
X-Gm-Gg: Acq92OFs0dMHa/xJaB6HeSal3GeXXFvEZg05v4Yjg/mRkInuBOoCPYzSGKHM2T/Je/7
	EfNYeGKYdnKHWTgHPbAmSbklVDtoFyRAgNxFpSmD0L6zCnV6ti5Xz4liU8tEyVeobarkOqPLmGe
	BF8uNMc8zuREjFZlm0NbNY8BR/1uZGw11udEl/Yw0u0Nq+EJ6n25xV4XMf2qF6PRVb35yxw9tu+
	crs9WhavL7/4T78LZo4TqzcdWzr2KMmFGw3zi2Z4SntyuqzhGXEI5yHsZOJ/fLkNamsYqlPw4yM
	PFhyzsdd6ASCP8BljNaoGD9feq+WL2Kn0rBdeY0gYdh3GDKCfg==
X-Received: by 2002:a05:6512:334e:b0:5aa:6f0e:8404 with SMTP id
 2adb3069b0e04-5aa87bdd11fmr2789965e87.21.1780931981030; Mon, 08 Jun 2026
 08:19:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607095728.031258202@linuxfoundation.org>
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Mon, 8 Jun 2026 20:49:28 +0530
X-Gm-Features: AVVi8Ccg3Zr3aemmSHt7GHXbKrsk0DAsls7Z7yyiG3r_z6vUzVOxyRDNWRLOd-s
Message-ID: <CAC-m1rrbuVGfALvHyDt+qgju7Cu4nSdo3VjaWi7K0B+_9i1PWg@mail.gmail.com>
Subject: Re: [PATCH 7.0 000/332] 7.0.12-rc1 review
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

On Sun, Jun 7, 2026 at 3:33=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.0.12 release.
> There are 332 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 09 Jun 2026 09:56:44 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.0.12-rc1.gz
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
The kernel was built successfully and booted without any issues
in the virtual environment. No dmesg regressions were observed
during testing.

kernel version: 7.0.12-rc1
Configurations: x86_64_defconfig, defconfig
Architectures: arm64, x86_64
Kernel Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux=
-stable-rc.git
Commit: 877a01113f80e75b29ea891dd8ce9e1822a04a60


Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Regards,
Dileep Malepu.
