Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792B53B6354
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281307; cv=none; b=aRfsC7dkIOonhcODJjFwTNwJMnpTpaJqALLlXAUFzfHzeo68PSNDttEk8tG/qekLsAvVKu12UDnKSkjRvpxd0zvNyIWriQKNhnYXSIrReFzR/8oFWDerddFNGuUX9Ng6O46A+V5OEe6omZcPhFITo/QK77bmPZIq53b5SmPrEXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281307; c=relaxed/simple;
	bh=JeGytasmUNGTaKI+3mZYgM4wqPhUfUAP9Icaw+YJT+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fwmFnf1sNyui9BgxWoSpHH+xsV99TR2q52PmOCFqGm283qDKOo/6DISRWFduSLTlOB4ewMMM2OUDuUqp2QtfcXxliWA65GT4wquTKS7uwt57WtM/pgKRegjKKSpfbupo7mxk3jTsUZzFwVb+9Tdy00fCymToh53cxFr/IbU0QAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fgC5NkKl; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fgC5NkKl"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-469d76ce704so44152fac.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 09:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788281304; x=1788886104; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hb3+Ewt44paEl8bqLWI/Gy1DpMzHCMRbvB3O6WVB5fg=;
        b=fgC5NkKl0n2Acjp1iSV+LYMvjweXwR49RVD5MJPt4xaqq8LopqAms1ZnW1byXbdAnM
         2qYrvv7NhvWmbFtu9FH7DV6dBEmip9Rt3NxwRmGtRbkVlU226O1eZNki96vk70T8hx/9
         1XyDrsMDFP7mOqlSozVA574TsOqE0Z+63iYjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788281304; x=1788886104;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hb3+Ewt44paEl8bqLWI/Gy1DpMzHCMRbvB3O6WVB5fg=;
        b=ny6qbrGFk+x0ihv87ZxtjB+lW3UsJagNYFQhWqNsd5HPfEvuqmqicgqPG0HJq0zfGZ
         Jrvf9mhb4yw8/wWXAOSqyDk/PI0X0lSQmpROsT6mWqy4f5ayVIruL2tR3LjsisLxAMs8
         2zMuddTzNPxckcG2INURal54M6w91jIcoyLlRR5KoqJ0YauLE7z4zHTuUiXrSS0S5Yzb
         Ofz9qr/wndzN5Bs4tbTcCYJds9bUsKbbWVgBiS6lil8CLpf6kBs8o76GEC80bwbd2DHA
         iAYGuKaufwOhfBfJ8kPUtz6/ykj8ZWAsFfOlmejRTh5+D/3S6OfetH4aeRvyVHIylD9T
         ss5Q==
X-Forwarded-Encrypted: i=1; AHgh+RpWaH21X20bcFwp2QPRVKAiTaEF+jKZmzM6o0r/iSAqEgXZJR+YLQz47XbXYQmSO0KeTocn9ws=@vger.kernel.org
X-Gm-Message-State: AFuF++k5iED+Qw+AFBnWiivO4aT8H1dbhzVEkMp3YE2QojDLqfQABqXL
	YuyqISmiK2oPXaPG0vuihYTn4vDYIWQmskPyj0HrdPHkEX10n4B2RziCADX2+1jsiZs=
X-Gm-Gg: AR+sD13YWWkW4sZz2BhG+6nO/w+W1GC+3cp5ag5kTEuxI5Sj0Dq95eSIFg9FlE0JXKw
	QvgQE+oTwKZLbZpEIw22K81UAoakxNfvWSZ/+pcEgogyELCnrYQzsiOMvXow/aVkbJXe3LIaa8k
	GmkwgIPZmnPP1EMO+3isajmt15JX2p+cjZb4kxzPuJWNfuL4KNP3GcoMKgr8lF/PaqCKou0snXX
	WdpA49i7HYEwh/WWQtW+hIEPicMnOAifUcsQft5alwmLtWWruIFQpCDnC8orA5NFcwquynGIfnO
	lOqQzHOi3xc9B9Ey0pDuYRCXjVLr+kk3fRh8rQyMhkDyHzd+Tgp1UaNjPo6uF3ByrtjG03wjc9Q
	ny2bX5HimPZrVhVKe2IXQ7NHEf0WIToVO+nGWFuZ40OQW7yYipjVqjvKHtaj1J8o91s/vZYlkFM
	5YA9IU7h/hNuet2PjKB8C+3F9Ie+VnL7n+xKKv8OnQK//YmIW3U439b1Mwjh1PaxNjb9hw
X-Received: by 2002:a05:6820:238d:b0:6b0:ae64:b307 with SMTP id 006d021491bc7-6b1c65ac8cemr28242161eaf.10.1788281304099;
        Tue, 01 Sep 2026 09:48:24 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b40ba66da2sm430827eaf.1.2026.09.01.09.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 09:48:23 -0700 (PDT)
Message-ID: <93b07835-808b-4a84-b253-bf2b10a8d00f@linuxfoundation.org>
Date: Tue, 1 Sep 2026 10:48:21 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 00/43] 5.10.269-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260831133358.571886287@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260831133358.571886287@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/31/26 07:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.269 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 02 Sep 2026 13:32:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.269-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled on my test system. No build regressions.
Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
