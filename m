Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E999F2FD675
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782410772; cv=none; b=rp4ZQFy388ngu5hbi62nfwMSPLdgyPpO6FnVjzVJ0aRdFdS1dQx03+2r6MUDgZLDngbOROMd0EBX07KVu2YO2QpLokzIEP7DTKmREFyaF9PMQDzd3EEmLnXVfJfuQ1SqcWwpuSI9Ccbdyx8dVJYx4++DzLhW3MxMb3qj/xIJ0Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782410772; c=relaxed/simple;
	bh=vNUEyXjI+o2ULLsnXqs69swoN53hDEw1zQ/dE1XtBWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLR8XhwDEqpDJWBKqHUauQmx1nOJwFphgri+yeEHww4i7A7ORklj8FeKsv47JJvugSVA8qcEFnYiqXuLUy1vQ+UZu501R3hzGxRPrqRW/9Np/kIa6Mvqj13H+HpTx4W0qS1r/CTOnvO9jVt3Y/CJ53rVL568ljZ7Dg55SodYmfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=p92XimD1; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="p92XimD1"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4633193af19so16261f8f.2
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 11:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1782410769; x=1783015569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E7e773YfIkcg4yEZ+1XCZxKsk2ksJY4vhy6afCr86ys=;
        b=p92XimD125z9at+j/qUjG1GDqKdyL2f9cZScdhPz0RSC7nqb+WK8YU2XOJX+X9bsJc
         sQSgKVU1mWFK5Wng7Q6ccRKMw1+DZTp8MVRoacjqhdnhMFhB9OeQdmxsjnwpG4ArY02s
         R2kb0JiOsbvosW2Bto9+RaJFpMe1GMNx4OLAw3/W1b9zfR1iqmMXYTkJEyNcJ6YxHLra
         ikUPyDUQn5vC0seAWljemGZVpKMjLXQJMDcWlPrapbKgPGuFgitcPsmFIQBwtgBrpLf+
         +dn9ROKt6etMpkIR4HSSLjQfdB/KOr/MlsmxW5A6UJmHbxeYoQ5mrrQ2gpE3TRJVJX2J
         dO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782410769; x=1783015569;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E7e773YfIkcg4yEZ+1XCZxKsk2ksJY4vhy6afCr86ys=;
        b=rA/Trl3D1g8MMM5Gd4Td7u2RNFttuYKAqsDp/HLJxuSGF1Qu5JPxQoDNF23rGebt+W
         lOARIqMkHhvRmrvi8wg4Je1YSEkgw99GaUOTMvSbkSjaq8i8ev5ay6cQ9a9pCOaSyTu9
         4UezCK9CFBZdxm/kFtazmJFAEWMLGElE+tH6Wxks4j+FtjO827w9S0sdhukbYpMLu/BE
         kxbmp8401Wtlkpph3wx2fdDbD0DMnggvD/TN3M6v5kQqH8yUgSRFxAdGWyCguGSb8xfp
         jCxotZDTeozY83hDsDkNPlrUiGjHiUBLmzkN/6wGX6jmQCkS1EmDpBzFNXsHvEAEmgHu
         yFbg==
X-Forwarded-Encrypted: i=1; AFNElJ/ShTa4euh7g4kQCEno8d4KlFCFDlpwh1jkxR2eYLQAsZY/wgfLtHXajb4xx16glsELet0RyWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHPQCm6Y5u9XgQ+YSRNL2h/bRqrxen8vRkDDhfiVYMBFPQyVnh
	Ii/6k4YEzJ+ovulvllNnJeb9mnKf8devezYCLVgOMJQi7Ukf8nrZnAY=
X-Gm-Gg: AfdE7clrSEvDFh6/Muq33XfPpvgY00d3xIXL2JokxlXQBoAH7bbIGo4s292Ml/vmFkv
	1TcDgotxjQB87LWgd7/i6KI/U14Bp7LG+t8VEhQ7xKge6gefIj95a0ZstiVKS7rLRxbLmMFinEv
	WHoTNio4ep0GS9dxMrTg0fTDIeUoaFeZZK41DZUiMVNxo93tgjOrFRgtIwNIztIesGTwzpJmOvx
	gp4qJQHaOCj3XfMEcjQ6x8uavsYpU5JVHzH9K/H2zaOUCwDglA/OQ1Hh6R2KzC9mZV+H+gAkcbn
	mvfqCImL8ofGHFkf6f91NNhuLfiFIEDjqkAhZKmXhnD2Qz8PysWBMssiEvjX3cx/rPxVgb6elI0
	RBJqYrJqvYd1eXAFB4RH+80/9NeM7ur535CP9ftpij0g0UWMExkGYSZs636rTS2WUNvuhwhD12C
	dMGMBDG+zG6/KkrGZiNaWuyAgDIG2rzVJ6Uc3Joped5xk7NgY3L9cgDTHrff2ch2sK
X-Received: by 2002:a05:600c:3b1e:b0:490:b115:e03f with SMTP id 5b1f17b1804b1-49266865fabmr49746325e9.8.1782410769354;
        Thu, 25 Jun 2026 11:06:09 -0700 (PDT)
Received: from [192.168.1.3] (p5b0572d8.dip0.t-ipconnect.de. [91.5.114.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46caad603b3sm15878126f8f.7.2026.06.25.11.06.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 11:06:08 -0700 (PDT)
Message-ID: <6d2851a2-b767-4177-9f31-956dea5a37fd@googlemail.com>
Date: Thu, 25 Jun 2026 20:06:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.0 00/49] 7.0.14-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260625125637.527552689@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260625125637.527552689@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 25.06.2026 um 15:03 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.0.14 release.
> There are 49 patches in this series, all will be posted as a response
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
