Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212253F076E
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 17:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785432265; cv=none; b=ZE3ynxuUBtKwIayjon5H4sORf1Ebo4ISMVSWO6809Vc4q+rIcgpqsXyn4zMub4LQw9vZc9DuyXUBbukOvPHPpIinOrLvq8VcGSqoBvqi3V0yHoOJsz7flDqY4bYSKnRFs5WMHhoSzuNz9331ATC7UfUtS8zguDt5VtXHmi4nOXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785432265; c=relaxed/simple;
	bh=Bt561/BYlsljphffl0GVHsslSbyVvsEBKuebmKyXk7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hZ5vIeFhE43vg7NxYWflFP70v7su3T0SbZJhAwMYt4srbq7aSXMmIhrRGzQkPFr4xa4fisz/tLsliMbE/rAdcB1TfdD8WvsS/qFZFa0P7rwpxS582oynBDuW2SA1Rv/9m+yySiy3hd30GrtWhxbosErQqvfBwgUnne5VjAIwI0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gor4KYBz; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gor4KYBz"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5c2c46a428eso66484e0c.2
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 10:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785432263; x=1786037063; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oDHSPdU7eZliEnYDKkNe6n4EnFUD+dLgVWZ4qb7cmmg=;
        b=Gor4KYBzwcruO4UU42+8R+RFgVq10yuZYnb1R9zoaUodE3lypaeQGvWaSwdfXT27AA
         npKlueSkAGIWVfmJNLgXCx0pzMW1Ps4ESsMYiZhebiimv/V1GlW5sI/JKn8dTAY1Qw/W
         O9/Bi95QhH2IElBr3e48fNN8AmnLNZGwsc3wTjemUjOmYqalCQet2QVpwIDiB0Clxe/W
         SwBchKDQFye722cwI3wWrHBQopNWtHxGQbOKVF+65kWC3oZqGx38sLjezxmGf7OaCD3b
         m6iN6Gtb0tlXzxSAxSMHifp/n91tVxoUIkU6eBDDp9FAUiSkJoF34gbR/ZswIBh3H5JX
         qgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785432263; x=1786037063;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oDHSPdU7eZliEnYDKkNe6n4EnFUD+dLgVWZ4qb7cmmg=;
        b=R0Ia4xwBVsXoTJ5JlVouE6EmAG2r/etjiSWOtJ4SjXkNGx7qkMg7B9zf3ED0lG5b2W
         vGBoO9upnqlbFvTmDAqOVeMBCvJme6S/yb2sKxKUiVkiY5X742gl868Xf7hAzaeeiQHx
         /TNWq1es5G6QBB+k0KTTxQqcmX7LRQR+iUbL+VLxWHQ2OGBgy9pLe1a7ijdJx2AFS6TW
         HwGis3Y+Ji9dWLCXrVCGIzwgXMyrtQ79CTJS8XcJxv6haH8HvxuuAFdZWrmrjBhuvrPS
         ccYu9ElYRHpegqzUt71K9In1h/cQ5/RG70tLswH35hZWMtOKC2khwO2Wrl9ZUUtn03bp
         hq5g==
X-Forwarded-Encrypted: i=1; AHgh+Rrd12fYJmYhviJSmRre+3YNOfnJfiCJUOp9f+PjZLuFSoMSCTaND+KVj3WROpgaW37gO0MEj/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww8MNKyS26RQG473JtIw0Z+I0i9sgyp1/OQhhM2UhNnFukymyY
	WkUYii0Q7xBeJqzctbJ152aYql6FW/A9N0pa7apsWFehlDOohlJype6S
X-Gm-Gg: AR+sD10wBO9dSTxttJdtY9XnVoev//ze4Et/EHhLR9MH86lYj9dkSsageEdOsa0AypI
	vE9MIvA9G0LSuupztKqo8DvLSm10bQ0E9LU5ko1/9q3x0JEX/OKJt7FuyUr1UOpYUg9TG1UkfAf
	7qwkRJZuB2fjnHbkynV6wre7raLnSayiLthj/ftjZ0ITiA3sL7uoD4YKwsOKcsI4fO01IuVRCqS
	Tx060Zo0fN3v4RJ1erDmVboPDX+CQnFWV3tJ0LKSmsSgN7qUn07XSE/Q7Y0G9OTajECk0P0kyfg
	qUdaOclo+Z+4T0SCGFD7vvOAg5yya2Fa6k2jh2iN9/x+nNehh4RFHVWtdjwDFkPzK7E4h9AKx7l
	EXT8mPYbqdkWH4KUbWSazUvy1Ky8YMM8caTpuQXARd8t5mLRyDnRWx27+yk0G5vENQoiALFCXJO
	Stb5/z2RBhzuseHn3TfKohKiAnU5sqKM25QX/3slokqLlxc/QqNN3MzD/VHNut5pYNcpwOeRiPb
	jSQ/QuyIN8WyL0=
X-Received: by 2002:a05:6122:da1:b0:5bd:bcb1:453b with SMTP id 71dfb90a1353d-5c36614578cmr1208498e0c.10.1785432263066;
        Thu, 30 Jul 2026 10:24:23 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c36655f076sm1972973e0c.5.2026.07.30.10.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 10:24:21 -0700 (PDT)
Message-ID: <51d1d2fa-8064-436a-b0ca-7a65ccdeead9@gmail.com>
Date: Thu, 30 Jul 2026 10:24:19 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/484] 6.6.148-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260730141423.392222816@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260730141423.392222816@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/26 07:08, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.148 release.
> There are 484 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 01 Aug 2026 14:13:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.148-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
