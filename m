Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4188B2C0F69
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 04:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784348164; cv=pass; b=Bxs7SXSr2n4VPvQmYhWtdWER3XVbB/6chHDlAEk2Y7rCsP1J2VluErdtGnKYr87U4wgFbD3diAtIW+SBbgkNvyu85yp2HxJlT1noLuR44jB00Fq/OpPxZLXssySsKH8RqYsMGc+n/bmbgCtqyM5A42uXO0i1Fz0e6tsBT+urtVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784348164; c=relaxed/simple;
	bh=qKK/SAkfNDjEwhZj7QR5KfgdanKDibPFiEyI626ERqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sgiNBXfCwM0WPuftelNn6zFL0Ke+4ISKuQ/mNU0y6V+VAU/fbOzIybejxkYx2M1MzQzt3AgDAjegIeBwTd8hhd4sKsu3lr1Fry8KSOLnYQJXoCBAIFzw5lF4CaCbIY+yHOGryv+jND6nGf3ZtXZkgKWolUxRVzOQgEuCOoxIahk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=Y8VQjlvE; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="Y8VQjlvE"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so3502850a91.1
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 21:15:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784348149; cv=none;
        d=google.com; s=arc-20260327;
        b=gLMPmoHt/bOHMYrHltHIrntRhXRxRCSvefIhrBqXF9D/VYabwoMHFOA/sh/bSJnoED
         kHiU1Kp0UPILyJ9A1Jefej51B2Y8/CvhSNTbi03HrDWrj4P2KRN1tEcw/zDX/beWdhKF
         4aBKIJWUHMinuu3S6FdU/l5DQzKsM+NSPPOYzfsgqmIaR/9bjU4IXsC2XGgin38Hvx7W
         1LwGTV6M0I1vHO/pmuODrqwIuRxA7RoFtgpnz1lFDe/lFjN24N/hIfAhXx3vfCKuubHx
         0pHyJ1PN+ZQ1ZxMCfBr4+Inl25Pv7PNx1sX/s3naAqIZgUchiZHUN0nHTQjZ6dUMgk89
         J+LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QEm1JYtQbugO6JFmVFknJJLCZpeLY+qIl9NQioPuxJE=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=O3QZfj9My2RuU8/gFjrh+Lusr50LxZagZZJGltjZwZBDPCjTCm3h3GiV/t3saoO6C5
         dsLhuuvfVF4p/3iCoYlLc+Wos7XadDXpqnVojksyCe7lAKu+qvaUJ+QyM6putt8DDvT2
         QqFqunvg6/gsb1N27jVGZKBBNJV/poHd9soykMRLq92Nn2UDvQ801AbXcub58CxboqGC
         xA5ZzPxpqw0otUe9p+cJ0VuHtNB8BJof9OEX7s8NgMU7gHluP0Ulq7nO1exOyV5fBG/x
         3Jd+6xcHYe+IWlFRP0lmkadkwJbr/Z10hin94VDCaagVSvbvGAYa2wsF40j3Dsbb8klU
         dxWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1784348149; x=1784952949; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QEm1JYtQbugO6JFmVFknJJLCZpeLY+qIl9NQioPuxJE=;
        b=Y8VQjlvE4CG4i1F3df1Lcv0qmC8paOcz7tyOxaRFD1DlJM/OgunBb61BN/YfdRRZ5Q
         NzoS97UkK+tZTY+E6Vcxp6ZMEnw9rIw/JQ0rXlir4BviLhlAZRnNO+vtb9tTDQIR74bU
         u+11a8AOWJYTPSQNxzSF/hczOsolMWhFbp3q+bYLYDrbVyEQQFaYdek/o9FC3baaQb+w
         8BvU+pz/YWKRwAcCu4F2shQwrVAV7O1oLIfCNbhKP9G/T2pgqlaN/5lRiZ9X+VEBsgSi
         lCtzao+VYhjyW1m0lDnafymp3x9ECwWEXW2YcTBCc4618ntQDE8LyEEC2iaI+fz37BNB
         qTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784348149; x=1784952949;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QEm1JYtQbugO6JFmVFknJJLCZpeLY+qIl9NQioPuxJE=;
        b=QRehgMh9UWJhtDl8EHKodwwbFZMgmdBm/pFvLGkJj70eWBE+xi/ET1AF3V+sWx0dnE
         Fw1iJAm21g2VmNSP9ODSCL+asVRnkCbefgDurirhcK+qLZs4Zp+Wv85ncodEs62ZQxKs
         oJNR4xMkCC56bdXqQjKHV9gmb3BJLAxYgM2sZQRVeaPVUEnEvYJfkcwF9zDe40NXvGe3
         4dItOQGYinJyVV4tQOcUZ+J+AVNQU6m+LJkt96H3gL+8PeOo/EKKGJ94up0YVsC/RRQJ
         1EefDA9uyti8fS9KuW7fKHfeIeVhZ0jSrsGZ/em6s4uf4lT/iqBRkLXAAfduCyt6KJyP
         Z3NQ==
X-Gm-Message-State: AOJu0YwosIrR/zKlfO8CKBJiv4BFYyc+PdN5BwOpD9d1fqngSM/MXtBH
	zI4vrgA60kkz/4I6z5Mnvi6HbiNGfWo0hEB7coW6O3hBzssnSnPuHAZMBlQXGKhrI0XRTkJITtt
	h/oXw8hl2aYMB9WsgMLpDffcEJTiRwnZOIPCAakPBfg==
X-Gm-Gg: AfdE7ckn+FFDSglvMilTUtpBKZnVTXDHMm81RTT5i/uJG8xVTDsYFikqfILVLbPO71t
	6b3gzfrE6qupX//SxIn32eDY1DW6d2Dfb9TCeFRJrmWSwZjNITF30qN1RRjievoPhuqcxDM38hV
	k6eElyYTFC+NM3J6Il208oDmuuHmAqsdxRBuu/AQR+z4rFKp+WDlJ7eM/s+tHQYFrjOvLhoXSCr
	VWKhtC1LOResr5BFWq351RMlcZ3zBcUfbtup1zNTbqGPdMM7JQocH4B0xEXHb9m3Vq0MLBSS32v
	Zrmy2MmBSlCNcxqdnXo=
X-Received: by 2002:a17:90a:d008:b0:387:e0db:bc26 with SMTP id
 98e67ed59e1d1-38e4b578fe9mr4982966a91.38.1784348148997; Fri, 17 Jul 2026
 21:15:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717101912.682013354@linuxfoundation.org>
In-Reply-To: <20260717101912.682013354@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sat, 18 Jul 2026 13:15:32 +0900
X-Gm-Features: AUfX_mxTM3XDl7urQpLrIfeHKNjranHdbqHS1C-wZDgPl8qmNJpsI-3TZ9HhlRE
Message-ID: <CAKL4bV48m4ZnL-Upd34Y1hOX8VeWHJR0xrs2x0WO_GZCCqqECA@mail.gmail.com>
Subject: Re: [PATCH 7.1 000/533] 7.1.4-rc2 review
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

On Fri, Jul 17, 2026 at 7:44=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.1.4 release.
> There are 533 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 19 Jul 2026 10:18:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.1.4-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Linux version 7.1.4-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.1.4-rc2rv-g2ae9949ee672
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.1.1 20260625, GNU ld (GNU
Binutils) 2.46.1) #1 SMP PREEMPT_DYNAMIC Sat Jul 18 12:47:10 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
