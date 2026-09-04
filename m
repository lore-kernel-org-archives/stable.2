Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E933D9DB6
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 21:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788556328; cv=none; b=qCwIKiOaaAfuwO1c9NLsR/yac970vtRxMUCdVzx/ecdxocagdNKa81IUz1QTXmn1OfYM263+spqeE+TVrCYGvCKv2EW03uELEeYzZMUkt49kD9bbglEUl9nkXy2u7eqs+4hqyzRi3w0apkA+5A8bdAh86+FM68wrMrSfJnwVQAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788556328; c=relaxed/simple;
	bh=XZ2O6+CuggsNKjJUiXGcVa4gfM4JZiv3nmeSny7FCe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BzRL+NwMUF8mEulTctfs9SsMq4Wr9yfGFiX2ZLk2EpgDfwNuq0tcOBTgyAIVOad289P3aNGOpX2WmP/GacsdY+qg6o7RfrBCcdKKzz9rizUOduW+3FDwyjLsH2wFhLGkAtjvBbAfcw/tcTHnSIP3z4+Dhwy2EC1VSZGKSjABgkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y1GEkaYu; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y1GEkaYu"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7f4f3683fbcso1670223a34.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 14:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788556323; x=1789161123; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5AT5dBqnr/v+Pip1Q+2K4mDw2hDT4rcmlPRVl1ccW1U=;
        b=Y1GEkaYuRJPVsuyM1iyN5x5+9Twg/UlZOBeCAk1v97/vyg12JfXXiFUUZwwELybSkA
         +K4smh1eypeywKyKW0ZUoVPA6pEJ2VqJmycx4vPxtMLoCIUSGv5uzZdBfKzHcJyAjzmY
         U0VUqvP5Dv2X0OeOjNhqanARKofuYufywQYfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788556323; x=1789161123;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5AT5dBqnr/v+Pip1Q+2K4mDw2hDT4rcmlPRVl1ccW1U=;
        b=GuBzR7zxOxxAleH+REK6k+U7HMvFlKNpnY/h195rlxg64i3A3zt18nWjuVzkcXq4hD
         H3KjRqudPIe4YjkizI9xhoj5uuPoHTXBa/Ka+zI/hFWRfz5Dvg8pOb+HD/XyrVgAeqte
         Rl/MtdRqVLqVglUBH2TA3OdRZ4xHX35k7GlcHaM6Wk4KJwYdjezkZ6ICW6X/RU58T2rp
         9eZFNqkdooQ9PFHFxNfBt3eJZf3Q6ew87TlCmWHaPRMw1QPqehnas7iSNUpASYpIH56D
         jLzhQFu6m2pZ66yqDECl/3dRtX+a/eYV75M9taRFmt+/TQKLn3qGVtMqM0S3yycvUPI+
         mgrA==
X-Forwarded-Encrypted: i=1; AKwUvBz3FFZx+xrOOxzsG/W9FYw8rvP0g9/ssm/8mNN6Mt5JKTgTMdj1Fj/Q4OiOVq7x7O5JTpRJi1M=@vger.kernel.org
X-Gm-Message-State: AFuF++kSUkhQdhaK4XChjlKH7JDmROSKRcKwdBAfdwUdZdVhB84oVG0O
	6txtFoXuTJ9PMyAHyfDzw3twVuddTaItqtCwjRE5PZxdPYHzUzWIaNs+yQtr9mK0+IU=
X-Gm-Gg: AYBFou2tiFJjOoQ/ukyIKh5LeEUMrAU7TIEhDHV9vNaCHDz/mugaSBs+g5LEsbtymPZ
	rVfzXfXXla+Xi6me4juCBFYm5Op0oDALJtO2aSuL2CQtCYjR/Sgl3hb+rThS+jC4r5g/P6+MxfL
	L0xCL27iNF89AZQ3AG5gb/b/jXXjXRVwox7G+jzbsadabP5E1qr7nHhkJuDDhqDPxeC2RB1j475
	on4uCnjNxp85FLMiWH2hT8ix2oYBW1y/+7ArMeksyUfaqKLhjVXtOJLClzT//MeTg6IzATDmwEQ
	KTpLTFGECSbPZkZ2XBf44SrOsexegC2BNbvr8OzAMlADHqkwQeXDE6rks2vLSjuiU5sT3CSzrft
	x17FTJAa0BM1wQkxXnCZT/kfQ1d1pd8tibPqHjNbLh4bB8L/BkDthLvSWauxVtUZpxCyNFpRG/p
	eqnw0slPC0fFH5ffZ6B9ia2o8diIXO0XocirfrQjAphODb8QFJkKuXaYkUT6JgzPMCMU9e1Q==
X-Received: by 2002:a05:6830:4392:b0:7f1:e04d:fc4e with SMTP id 46e09a7af769-7f899a8aa7amr8040035a34.2.1788556323643;
        Fri, 04 Sep 2026 14:12:03 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f7aeac18sm4031241a34.25.2026.09.04.14.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 14:12:03 -0700 (PDT)
Message-ID: <82febd53-023f-48e0-a0b2-c5da95f069e2@linuxfoundation.org>
Date: Fri, 4 Sep 2026 15:11:55 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/403] 6.12.109-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260904045734.806166532@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260904045734.806166532@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/26 22:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.109 release.
> There are 403 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 06 Sep 2026 04:56:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.109-rc1.gz
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
