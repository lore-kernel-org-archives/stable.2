Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741CC3CE49E
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 21:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785446563; cv=none; b=Z2IDmoSmz6/rvO8Vwmm3y8S022NYxobreyT9ypjgicMpb1LcDldHUQS+QQrgcRja/jRw67ecTQ7egTy7Mx/J/gfxWK9Cju8Zrtyyix7BP/IfOpglXwveCNagsWpOIWgAlccJWac1OBcpe2lor56mJjivAcIb24Ym7NxIaPxXt6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785446563; c=relaxed/simple;
	bh=arzwFI5WYUmMyzG3CocIJ5GXzBGSgkQoEQQ0OFRRdzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ruG2ixCnFL22CAEUkHQkUSIS+0sMPkiOVuViHe9FgXfdyBXdb45VxGm//bjguHURstQF7rykA/uSuwOVhJvBEWPhbchZXETkUTaJ3hOMsTPg/ExQePUdaZXRSgKhY6h77QqlLCWjZmLfWSywX3I5DB7IAMLTZ+uQ9Z+CUGxJ1Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fW/kObeP; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fW/kObeP"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-497d6c2d000so231418b6e.0
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 14:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785446553; x=1786051353; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EI5eCcvvzGYFaq9MnUQPRY9aniV9C4ZQS6XVKA0HQZo=;
        b=fW/kObePDY40jVqn4Y9rheTXcwIHkCuk58t1itlAVQvp2hdiq1v9Tvp2LWD5z3YJo6
         7qbg6dJb+KzbwEjJ4eDyCUPSl9RUul7cVrOlhth//7Y5s8fg6+2OxhDLWNbDae+aH9Tu
         NKboT4Oi2I6UK0C5w+Cv7yKfgXvizALDR7ngQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785446553; x=1786051353;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EI5eCcvvzGYFaq9MnUQPRY9aniV9C4ZQS6XVKA0HQZo=;
        b=LkLyzdZ4gqMrCpfnZx2d011lZz4TWDAAg7S3MYt+FYAZ8hay9oAE9fymgPKHZkewVY
         Q1H0Cs9FEKyN2tgzqMtQRYPNzQ/QeTs9zQptvv08ErGnT2nXJ/skQWzyGNCTl83SfeQn
         v4c9F9za+thOlRop3d+F9SBANnbJZkt+hdhc8ziUQVw2u30fxj2NhPHv6fnWu/gzDYvQ
         u6HJXfhbD4c2KaceS/tt03+6TurMtk8yVZHg1DL7Vdt1QrwsDZFl+Z4iFyz+khYQkJ8g
         zEDZwVkgtz4gQ7xl2Ivf3XBAYsXzMid6B+RzSltvLP1wV5zWtb8rD00+Z/v6x92v7UWo
         P5gQ==
X-Forwarded-Encrypted: i=1; AHgh+RpNup/qlULCPLZd9BD5RxS71Ab90F29x2Cu/Z6TobQ1Un3fOPJwo9Ofe3alc3GAzKPiiFx7uQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf3Qst9lhwPlsIDOllF+9z/28spj3JcbvvRqJdvZT0zJCKdZkd
	3kcKdzW+euFB8IXOQR5CGgsYzewbkDD0g7Q9URY0eucI/pYEGq8Jyleh60p2WCG6erc=
X-Gm-Gg: AR+sD12UtTudBfsgCZLwnOsxTnytzu/+ZMrCpLzFrh3TEIDOc3qJZtGYsZoa1DUUknO
	AVJTXh1eKclGnb0GAd1vgeAA83gfvHwbJI4SWgZ8M7vYBtjOQJTctNsuvFSKUGbngQoHZNiCFj7
	xNO3YK8eIoYj41b5uRd6qG9sJ5kjjoNIlq1EVBfReF15H7wh1fAVW55x6Fwqimn4niMm+aLxTHu
	nnw41C+TfSvNW2yrzAnWRlHfmyXnurcJSXoXn/E4zi+bedzy47qGZOVVXlgWskLZpPMEiKVSWof
	T+lVtTwqUeOcz7bY7uFCtKZTjZn5h4oKV0nB5ShTNnGJd+4weu+jWw3QjZkntrOT6PnRqOWLrMy
	tDO9XScoeRQGM4q85J4e02tz1HgHYn2YNYhqXDh1liyBLiMgpA68oZmBon4jYQqHawxqY99VjTA
	koJ63o4mJL0UPqBLj7Ub+JM0XzJ38GCrzyLEg+4sQUR4/Qq+SEnojVxgZD9rXyzU+jikfn4Q==
X-Received: by 2002:a05:6808:15a6:b0:492:cdc2:80e0 with SMTP id 5614622812f47-4ad952c5d94mr1740722b6e.23.1785446553084;
        Thu, 30 Jul 2026 14:22:33 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ad6ed31058sm5137841b6e.8.2026.07.30.14.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 14:22:32 -0700 (PDT)
Message-ID: <45d77663-ad68-4d1a-aaac-6e0157eac8ac@linuxfoundation.org>
Date: Thu, 30 Jul 2026 15:22:29 -0600
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
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260730141423.392222816@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260730141423.392222816@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/26 08:08, Greg Kroah-Hartman wrote:
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
> 


Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
