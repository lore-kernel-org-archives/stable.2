Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F787477E58
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 11:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790250681; cv=pass; b=kyRVfaklupwqVEzAmSivJb/3ko61cagZJD+H1LDaip9d2Znr9aFWPaLOYVf7WDeDYjTlPU8F0vzjhyB+3uIEi2qE87AjRfXKVGk2+2bInv7m4glLjWHCUvbZHPAgTajob17jbiy05Dma9v2KH2zAOT10kAVFdSmu0Vry2Kb2+ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790250681; c=relaxed/simple;
	bh=beqzQKKjoxSVK9Ait4o2AWQYoYHmh36alBr6u7mmw2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PsQwZVvwH3s8sCSubOc13sfUMIh681s9EP6XcfppiUum3h7Ll9nJvXjZYwAkDX9/2Fg2Dg66YOud5n2ynKvh4e45kBFrpwzrOsd9+EU6cYSOMDDgGFMRgnOk3UDIXVNzWgugA7++r2eS6QscOotz+NGQogdJFQ9rG+YJBP2w5y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=DznRrfa7; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="DznRrfa7"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55eff0so283993966b.0
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 04:51:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790250676; cv=none;
        d=google.com; s=arc-20260327;
        b=AsD+oAxnOvwqDnxWxDjX8du6x8J53wIP+Y6PojjrgX3FvsJL+JPs8rvAIEsmDa6kuB
         qQqBAtzhwPOnGk5Yp4NqoRNZ++EEGNYCO7REUwe/V4XpajEUwLLKhH+/F/vNQxTg63+E
         4qPZQn5tybAnJ8Bpy0GbjlY07e6mvIoPNeoieqRczsfMMNgrDKz5gQLynGps/WyXrfTW
         Re/xmaVbiL9Q2ZK+4Jg9dq5MK9OdQJyWWtRIVCa9Jj7N5jQ5S4qELGbmUm7KbUU6EhkZ
         RMHtFuEQFCdr64xexlIiiPPYylazLzCtjHw8rrFYlrbzBEsbH28kxXLdY9uvkjBWjmVO
         1qSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=omFqe/7YRCaMs7Y6/oYqn8ZEqPS++HtW5gJ+iDHObDM=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=kvlq1lNRpubHF8oi/YDGIPuxVSg9lsa7CBOG5Xgb7K5FJiswwfM1I6Xeuz2zpsS8qn
         2zf/+hCFsa3vol7ZJnTjDKfSKkc5aJotcOXdtJhHtdoxOmngkRJBG7X84zqmB2p0xcr3
         JNA4Ag7s1JyM10dhr/RsLxH7KhahIThwiGkscv7t1XvMRIew5OOPR7deOsl2xMJLx4mK
         YNhrbKPOpcqCyT2xHlZ1kgU55JM6Pw1HVj2e7xQG1Lq4NovsUInQijvXom7vlqN2vnlN
         tAE48pjbONNnsFgxdj2o6J4ZHI50lYd9+jdc2cSyUALaRVN9XSA4Fb22w3za+lAaagWa
         jaEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1790250676; x=1790855476; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=omFqe/7YRCaMs7Y6/oYqn8ZEqPS++HtW5gJ+iDHObDM=;
        b=DznRrfa7ItvCi/j0cWXpGUaxAND5iPx1l6/8I/B7W8ysFoKCzPEtyLjK23J0dp4Zqp
         ibdgZ4S4qHIRCrWG8ILW/bgfmMVTCmRNsdyBn+j1Qh5NESeQIZ2Kkfo5zJmdM3mhgl1C
         lg0RT7xbUJ778K6ex1fwNPAo3fHUUh4MIaqX1zo3eshPw81WEiUsG9qwM5gGRQ7f1che
         YjqbkIpaE0pqY7JHD14RUcQsysD8JFmgid+nbk3YAkPMhbD1bGuLclLTmHybGJw14njo
         oZA6eadjq0l1GbcM2bF350pRuy+0fcnoWm4xTx1mjPPG5/f4/nl5bBOmhgMNgVf9+xHb
         f5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790250676; x=1790855476;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=omFqe/7YRCaMs7Y6/oYqn8ZEqPS++HtW5gJ+iDHObDM=;
        b=L2XufD2adIrhS+10rOJLU2ew8drHBQxBNBUT3x1/y6edyKiVj+b1Kjq7xa648OinX2
         OJ5GxIXXCB3QuvYRv7WI/kPYPSJw+K2e65KyKDga3ihMAc9MN2SrvPbf8MXHiXMeSWFC
         1YNSTIdV9WO4GCDQ3P7DBVK9D/KOXXl/eEBvd+BLZqtoojJozCUyJXcQq7NXv+BEAKdY
         U6GBx+8AiFZ/67gM3FIT9RHawZ6FxLRxdotrw6qxYyOYVhCdILdP6tKLVPSUGhlPQnbq
         dyDKiSN+5yofphASRWLi1Qr5XtchfZYMFQYdqo9znxPXoGTvpmBoVZQnvlSNKLBse70k
         lSQA==
X-Gm-Message-State: AFuF++mZiQcPIgl5+Zz5U6TPErA4BLzwrdMe+QVnHMH8cH2k2j1SBYqQ
	Xfhhx2Y97rMjG5o2DBTvlhqWtbIbAiWI7hXXrzfV9w567AxEfTjhica4s9iBimxeh95XIZcobZT
	/9sIQz6TgSiUnR7eWSK1BlwDj0MoN1zy0xsbaGC+MKw==
X-Gm-Gg: AYBFou2Xw6hkslG46txXg0HlriSVAWjQNteu3balAXrNnOkOjAOCGW8Rz3kpSe+ONJX
	KUkauWiOBsyG0Kdk07Cl8pvHre0XzUrCzcW4JRmXfCWDWtIzn2ohIAJfgqH+l7UO4VribY30nz8
	OEW3jq9oZ8cV03dP/etuKHM8hCC09CTgdKgBMPxEZfHl0g7NUGKtysqT6jMbIRZQwY2aq2eqMzW
	8tqspcNJ1YYLPAckachPCsQ2iPsp3/D0KIfU9rQ2HPPl7tJM+GG9f0CUgH72ZI5J0tq2f/aOqoR
	h+1lG5qCTTiiS58bt66GmChQHipba0o04Z0AcK11rfwErWb+KX3oGSii
X-Received: by 2002:a17:907:97cb:b0:c25:6230:dfcd with SMTP id
 a640c23a62f3a-c2ac239eb52mr194296566b.15.1790250675739; Thu, 24 Sep 2026
 04:51:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923140644.756254324@linuxfoundation.org>
In-Reply-To: <20260923140644.756254324@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 24 Sep 2026 20:50:58 +0900
X-Gm-Features: AclHuK-Phr3WDpb7SshIHOAYwI2RYTxswDPC0MCmKsbJLi96tShPIIuezgDdacA
Message-ID: <CAKL4bV7H-9F-JEM2ohs3G6GyC5Gi-C2sb0wJdixuObcE-bSuCQ@mail.gmail.com>
Subject: Re: [PATCH 7.2 000/438] 7.2.8-rc1 review
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

On Thu, Sep 24, 2026 at 12:19=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.2.8 release.
> There are 438 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 25 Sep 2026 14:05:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.2.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Linux version 7.2.8-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.2.8-rc1rv-g54e8ef17140e
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.2.1 20260810, GNU ld (GNU
Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Thu Sep 24 19:15:39 JST 2026

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
