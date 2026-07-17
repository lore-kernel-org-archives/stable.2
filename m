Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1843E169E
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 08:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784276992; cv=pass; b=NhBLevgSWqzZ1/cvVw1+THQb1AlvAYteRrZeWplAo6pkVo+L0e8Ay6xVVftolx/dq6tR+VgJ2kowus6DIGdwf9OnKqILgeW+y5pTEGCL2lmAOHuk/69nlq6wxgL4o03ikLprWBXWsNska1hiAvLVWRxgtCGRdv/4Ix86YcR4ctE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784276992; c=relaxed/simple;
	bh=0t9JFG9qYMxku99fuegP0SFobvht98c9pfQEgjYuBo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N471woKyDbF6zxmfwv0SgljyVwOkg2Jt7/Kow+A+iOvlW5aSsLI388M3oB3LUH0+FQAy9xD3YrF4vWvEOivo/FJcpHv21LtoduuOMQnGRcyLFBwiSAq+X8xFeWQMs+OSCXE9FLjWOQ/GKXYA+ArspzTKY0Xjzyx9V1PkIWSclz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=uBDfMHh6; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="uBDfMHh6"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso5223000a12.2
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 01:29:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784276990; cv=none;
        d=google.com; s=arc-20260327;
        b=nyPg1jK+mlXWjIM2iFVuvgewujCtXJvul9SGbP3abetucTgcjbHp9QlDSQAF6OEnox
         Sn8GZDmgCJE863dqjatt5TukhjcN2TGT7+1XDnPryid/wUNLmSTNUcQbofiHPO/iXQVE
         8Ssxkd3QJrQAPpMOiuljyX2P4Ky3ZN0Ij6rS7YMuYNGVKQkzwiGtgFE3pZhxAkV8ZNJ5
         7c35MHD36xt63e/sdsK439e9l2ju42httm6zN3RR1/DbUuiUXgm/p8YclXUX9lS2YJsF
         WRviWlEL8hm+2Qbt5qoY3Gr2sFfj24Km/mTQ8hEQbBpLByJnYy3Dn2EJISasyAhnUuox
         ztjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bsyN6n1X+GJ2Z5rKNi2r3QYlGOgGQhzgZqC6Hvjv0XI=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=rHt97efVawbYWJWGebGbY703kHUssxuZMGYqsgG0alPG1XWV447gjMiR7EeuMpB3rZ
         MSwQRZUeubzixMLv274aMf6BuQ2HRBFlz65VTuMZW2RIrHN2aBaDxPyMm1inRfXpS5iR
         rRi6LAE8xx+fRBcJjMg0w1KZ/aMf2gzzh+ZAkpZLhVLjioDGEg1ljvrj12ZkFqLZulVl
         2H0Y3RBd/jsGt2aHH+iAucwka/wYnYjE21thZumzH6JY/KeSM9HqyiuCPGsx2TVpnogD
         8h/evGRoqk8F7Gj78ChOiSnvZwxlrd6x2q0apGOdj3ifoERBvFU+m6xISGghsgA59usp
         MSPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1784276990; x=1784881790; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bsyN6n1X+GJ2Z5rKNi2r3QYlGOgGQhzgZqC6Hvjv0XI=;
        b=uBDfMHh6HSRiMvozwxOo66PKtG0ZfGQQJqAcXAVDzHkyYR5WQer9UUMiBcPGidMWPL
         FaPLfdZaO6Es7BQuCg/Cb3RCu2mvJDVV7yjEFNJ15k+j5aeY8HuReoFMyX6YnntltcnO
         DX5hDPacFEgOBdySPUBB2vf/yvvYgdrMZk22/jxNi816X+gDVt5Law6uLkDz6PHX2LXP
         QlmNSgpFFZZG9nZ1hrQvLDfl24NnCUYwnFQClpCYlSZaJ53y5Urh7jeXTu4vNwPWnd+M
         bfHHYPV9/wgEmHEBoOFlr5bOW7fPn+O0Z70yX5GP37s+ctwrDBPqj9HAuOiWBFxc3Xgu
         ekng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784276990; x=1784881790;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bsyN6n1X+GJ2Z5rKNi2r3QYlGOgGQhzgZqC6Hvjv0XI=;
        b=pnAkCOBJSogOj1XnkjAV1QllwTigcadbuYX6czDpa0d7Vv1eHE++OpgoQZ2OB8xqtM
         LFa4qjXdzmklnanPHAkJm1qZ9qz4CykEEGbDH00G+3rTSnwt/V4bn74RL1BqcAVVvbw7
         xEtFud6U6QKrPK2naolIM6y+nxu+coSCagYzOt57H4Y3Dmqg7v/tD2EKRntNX6bvh1El
         4zroRHBeS8FHmVcdDRtfdGSvTaiLsVkV5jZAQ8xFb2xbc6o7U05AO1GIkKROZKt70cix
         6Kuhm+0Fx4QtOJq53tSqJ1mo4vm1AjmnjgZRKXUw8nOJ5GGBap8tFps7AV2F4d/Styjd
         OWkw==
X-Gm-Message-State: AOJu0Yy/JxZQXYOV7V/lGMspASWmtINohY1Ic0AON4r3XwBzlJUqhYWW
	6jvav9KxR3xAhCkQnGAnH04CUvRkQsSmxiTIYHTGk017KMRcNORXRUFrmmrflhGh+a42l5nRdbg
	sR5KMMwxJdktyWbkJBrlYnIfJ0Y6+KAfUYQO9WBrEyA==
X-Gm-Gg: AfdE7cktHjMJ6DrwzH3odARhDRJNtISD/Jx00AN2SOPl76AVykyMZwA8oB4bbFAq7Ob
	V9iTlynAgXDBi3nXPs/kb8zfffzZ4Gw1vYqEocr1m9NU57+dkCZyaGg5xx5HDukGsBvPNvY6/4Y
	gFRqUdutGzH4OW2zRKgijVEtNXa0gkbdQnO5CpsEyad3tJmhzG2STPJRtj5Q4qR7cbLvABYSAdV
	ueKvM0ffFm/BXoCkHoy+Y1IjDdg//auiTGwWt1HZBC8ahCtNWP3ctxnqgIigHD8QB7Mj5pIanFq
	rGLWBo21H4Fay2AC17s=
X-Received: by 2002:a05:6a21:6e95:b0:3c0:9c1a:893e with SMTP id
 adf61e73a8af0-3c3ada3e2e6mr1770184637.70.1784276989861; Fri, 17 Jul 2026
 01:29:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716133047.772246337@linuxfoundation.org>
In-Reply-To: <20260716133047.772246337@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 17 Jul 2026 17:29:33 +0900
X-Gm-Features: AUfX_mzoMNdeZUUZN06JT_8hRl2lSZ_0mLEjp5zCBlYqYm4zCoRug6tYz9ObcTg
Message-ID: <CAKL4bV4EODs29Ra3wO77kmvu+UHnX3N8rELbmHRFW1RMwbfizQ@mail.gmail.com>
Subject: Re: [PATCH 7.1 000/518] 7.1.4-rc1 review
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

On Thu, Jul 16, 2026 at 10:38=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.1.4 release.
> There are 518 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 18 Jul 2026 13:30:01 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.1.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Linux version 7.1.4-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.1.4-rc1rv-g01c8c5ba0d4c
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.1.1 20260625, GNU ld (GNU
Binutils) 2.46.1) #1 SMP PREEMPT_DYNAMIC Fri Jul 17 17:03:38 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
