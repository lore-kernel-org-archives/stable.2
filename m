Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B8823741
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 00:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787702965; cv=none; b=KlGU3Ku31TXpLLd7CMPH/AHzw/lygKgXK5TuCUFEC+6FbdnGqwXqEaNLGvkEzQqWEhZblsAfebtwlo8d/iBI5wBCbfWkCd71MUcVtNkblfCX9mPS9tE1pVyIsgQr8+Alps6YpDs8ER2WjFw2k431nP/XW0+Adh+PqfYJ62BtTuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787702965; c=relaxed/simple;
	bh=FaH2Tq9QFNbgeAH8IOjswCrrYKuq1yzZpbN2j0BlXFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MzsY2PeKT7dX/GkfRRdtn66vpCpY1ODcRnxMjehA8ZPnPXGb7VQIu7tb9gtsppK304/SiP79SgrlrHp2HrzkB3eZyZ/zC61ywLpRoP21nPwwLc8RT8DrGKJws7CWUMkp+LrDddWnLhCl5NRZt2kMFoDfbjaCdjV/2rTwRLKXlss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f39XbyCH; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f39XbyCH"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4569e871502so383230fac.1
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 17:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787702961; x=1788307761; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lPql6cnyypO7jMwx4hb9J0beiqnyW7fxD+DB1zPYgkU=;
        b=f39XbyCHLAcz2yyDe4MaMN0l6gSw2AE32S1mUg80EmRfJgotFVcbophXOqSbFy9fuU
         PwR5kBegKSSbgquTlHFuKKejjaubwVdZPCC+5P257xmGLHdG5hvqyTATkcnSy8lDXPOj
         8FdlVJoOwDXBoAaRfGFEOQsuxxyqRBiLlFfiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787702961; x=1788307761;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lPql6cnyypO7jMwx4hb9J0beiqnyW7fxD+DB1zPYgkU=;
        b=FN0nnKSHPJ631VL/KnOwFGQ1UKYPJTCifosrrF81dIP9FcPQGhkOPKytiSp4DYHCjl
         wdAiqEMU48zOoPPRVLq3KaszNmlFu2ikbee1ygNfswAmAJKg0hx9pY9aVBbexaserNTz
         5ZTLY434MN7TtgmDwEAEkb0eNyUCLC8h79An/IBxkMQ5E/C9BvmPw9sQIL9yVlkY+UNi
         7XUEb6hUyYd2YFy2pYjRkc06skeRsAqnxKqcoi8GtzCLDEz5RPJ4u4CbDQLy7KXul85j
         qe2jCSb/cZva0AR3uH4wy1QFZXP1O6Mn4LEy3yPNLhpEjc6ky70hxb01LvXutGc0Bd/o
         k8Hw==
X-Forwarded-Encrypted: i=1; AHgh+RrCnZSv0RAu/mgWEF8CNqXT/bplBwBka7KfNRj1UEYMifaqahNULCAI8vlr9+QpvNctVF8Rh5g=@vger.kernel.org
X-Gm-Message-State: AFuF++m6lUW7QU/y0DQsN0Gkb17vHqYLVIHoZPXmNO1MuAuFYPo9NEcY
	5A2Y0iZ6nJUyPieGQBZJ2kXrKICQMS8LxPtAv4gRzk0z7eUNofPbrx6WZF5fuF5s49BC4sh0vXh
	rJ/UMQi4=
X-Gm-Gg: AR+sD13rEtfVs3IdacMQcPLzRigiK5DefLB3dkWCEZ+5UfHKbHXWbbH5ckHj4sjZDr5
	JsIyaxdCmzLxE2p4cCp5AoP2rSNToUICrJRePI+PFrytBWbZUulHLvw14WiL+IlJCc5g/uvyWWO
	vEkpJeqremV/NSRTy4vBvvweSzFA7C9AIkODa3lFCZ1daNy7xgbiHPf7S7Fv6KRZUkELZTXHpuq
	Q8p4arEWVDqNbPm+EVvOWjFlCZqTx57f6ZmMlKxrGReYVT4n4UpWehnRiC1htwmierX5QJtAsLw
	aZg2mz+ICrR3JtPoRjScfIWpQJw3YkEgJjsFHEJLn3dUqDeV6Tv0cxoAbLqsMApb9H2l2vITeuz
	BBSUUArye42V8I4sWbx9+mNnnJ5TAILxuFC3QJCSvzxQ6JhH0UwripkyCq9hBHkqCucS5ZTwDtO
	ASKwG2nKJSSFD8sK7A0kkEyWyB0gYJyHTGUSYTnjWGzwBSPVXu08gz4vkzygTro5S8NoY6sQ==
X-Received: by 2002:a05:6870:aa97:b0:456:55f3:b8b with SMTP id 586e51a60fabf-465982c1799mr4010595fac.5.1787702960757;
        Tue, 25 Aug 2026 17:09:20 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-465afa1f389sm739700fac.10.2026.08.25.17.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 17:09:20 -0700 (PDT)
Message-ID: <bcb5d410-92d9-4c22-87dd-286866c96723@linuxfoundation.org>
Date: Tue, 25 Aug 2026 18:09:16 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/77] 6.12.106-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260825132541.580275153@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260825132541.580275153@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/26 07:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.106 release.
> There are 77 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Aug 2026 13:25:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.106-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
