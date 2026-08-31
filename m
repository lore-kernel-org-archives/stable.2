Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A3738399A
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 21:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210093; cv=none; b=VdZnyvppW87KCNF7pSbLGCjqYV2Ui/3FT/A1+g5iR4MwpX7gvV/eZBoSm487JQ6tvDSnbaqbZIOcBqaRBU2rxxRYWYAVKMq6xqmxRfxO0xgKHOTZtpXsms+RNeZd5O9r6k8XMn3APyBjXZ/mUYoWpvepS/oUcdYs2B0wqx2K5lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210093; c=relaxed/simple;
	bh=pE+8eFdRKh1hGGyR4Z+bhB2cCRSgLo/w1hS3iEaFlJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvEU6NoFDcrRlaTBJrGLpmJuNc5n1GVSgY//ORixCMxYcAE7eUz9Q1bOQyM7tlRRa6SpyJQbq9L885R3jbN1CTvvEeoe8hxduWW8CNNX531Pk3QL6+kURV8M1YMXoMG9TyJa3mCXEbztvwZU4YMo8hJvluiR8owEEfw36Rdwor8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=FGTdeU20; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FGTdeU20"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-499ac87c92bso1749225e9.1
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 14:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1788210090; x=1788814890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T16UHF6O50SV9JqJ2L46KlCjGiQzlMBW+cyH7AwVLTc=;
        b=FGTdeU2021I/13KuWB/bs6SBNPDulLPcst9tCt0x4grsho00cAsY6ZZfrVnCuIItPq
         vM1/n4G2SIeEWJ8zbtd0CIvvDX/6WdSqmKy6/JUJUeXyMxHmlH9EJlBuONJK5QIiimyc
         YEBOMiZlDGKg8xTzTQIDCFKBmrXn8DTWzHRKRhMdsV7k3WRxNvvHne4+RP5POXD68ztn
         nLXzMIjl6uig3cPrInzAOWGYy3Ko+6jdk48l8NJoXr00u6apF4Cmklupk96hJknvlJ4Z
         /xKwnwO3xzvgKunIYD/jknGHXy0Hxz/nIj5VFPbLgc2sZyHz/XSVi1S5jnh+RTDa5ojR
         z5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788210090; x=1788814890;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T16UHF6O50SV9JqJ2L46KlCjGiQzlMBW+cyH7AwVLTc=;
        b=Ly8gg6bXehvmFzMV0ICuxmP4o2WyKXNskSuE7Q+nL4E0uex/a4Wj80CggZqEfM0XRr
         azefNG6uou7x1BYVmbjSh73rHdtshy8RJSEGzsK2IjWfQwYdfjKyoOQ789BDthxogXP+
         EjB27EBV0oGE6oHGZQJTrqzkVLHIhDGJrhAjQm6FZhyuvIDLtg4/xi7IjYlAP+618JDZ
         LAIuDstDtPS+PeBhTVNUr+W4fAymzTPYijezo1G+Wnsb0Ndp7bjZrRChGz78ojYDxQ3X
         ZUhprqpEUoZK80TLurL7NbFtAgBRn0zMTAO2uAXoJiqoKZ28lAQblq/8HBh73rht+LuP
         XhSg==
X-Forwarded-Encrypted: i=1; AHgh+RrU9TToOasLc4UH54FMwEkBxiRKjy1r0P21fedaQ/LHrzyXll7kB/MGABgtqnONEH16ECVMbdI=@vger.kernel.org
X-Gm-Message-State: AFuF++mCELnV5d4yzh9OimHfKHzW1OPIB79xe5K3kDuzyxwjEHwH6ZOw
	i9MkSKCjBF3yLTYMbL1FbxBUUCevrlLc5bdbpBTP8+Sa3xStHM0MbgmfqXX/
X-Gm-Gg: AR+sD11kebv78dzZMlnKgBPmvnKcvUAZA/oetQxWKSL0q6mYzg1bERIHIXRVfmDclF4
	72QRdB/rxv1HYzcXMnSQn2YNQcaU2P/vtzTAz8hyVMoJeQlUvXTWuY0hsOk9j+vAyHxJzav79rb
	meRmgBtN58mpoy0LSutz4QSft9UH8CeDbxyRz5FPImuf1BH8DxDqZaaV4TA7QyUGZVpIEhi8Ds4
	f6oxxJiCzHcD9G1GwLpksl/OLHOx8yZSIqmxrXq8J1RBOzVcg5nWhc8G1odwaDoinaIESn2qyIs
	pO4rNNFFadeGy76dywAJ8Vf6FdUuCLCYaJA3WcdMzi83+J/zhbPzuuusqgsmjBt5qvB1HjWRbtB
	QhLrRsNf6YwDjj+DAzNNZN7Uerv4RVzMypFDCdlnJafbwL8FfNtnmC1yHUiVvgtJFGzU8Z2vdz1
	X7FqhM7I6fn4vUyRaHzSl9tYd+kNeby4ERuU4X0MFjF+1Z5QK/sUoDYKoYgZVpwFxLdnw8bght3
	BN0N/TyH8FQbZVZu3ytrf35x8xeMDrZYKCnmso=
X-Received: by 2002:a05:600c:5490:b0:49c:cf18:494e with SMTP id 5b1f17b1804b1-49ccf18498emr290412295e9.12.1788210089521;
        Mon, 31 Aug 2026 14:01:29 -0700 (PDT)
Received: from [192.168.1.3] (p5b057bfe.dip0.t-ipconnect.de. [91.5.123.254])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49c5a903eebsm196381175e9.4.2026.08.31.14.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 14:01:29 -0700 (PDT)
Message-ID: <22743da4-c97a-4e89-a43a-31ef43bd576f@googlemail.com>
Date: Mon, 31 Aug 2026 23:01:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 00/91] 6.6.156-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260831133359.468089036@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260831133359.468089036@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 31.08.2026 um 15:33 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.156 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com
