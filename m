Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793287708;
	b=xa8DsQs5C7y1ykjfiIfhzanypU49SajP4HBsGIbny7rPU5XbJm+jmHmJaGovf1RmF6Cn
	 BsbxWieBnEDjAiQFrFgxQK6BROKtRfOqN1mjwLr74R/CTYiUgPUL3UzscHbKXwHcseTNX
	 Gy5WLj+cgVj5HD8FUphGALH8up62xZKoD19PgYTE3zceUhftl+nZhNips6hcmJDzNZMap
	 Zunn+FCUXv2i1cTCvGQB42PVOsYBbIyJu7ObyHznFJNitmmb3HUXnzUEc6s8QbxEwVK18
	 W0k1tFfvIamXn88t6DMJEZbX4hGlfzt0VBCR2r2ceEgC2JOhgYPIn3dEw2LWPfIVjSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793287708;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=yZTE4OyXfMuvSFj9u4UbsZSTrlYFDczLFmxLInU5s4g=;
	b=2x84aRNn0W8Tycwi9rHAm/R4WiaSo6qufT7NwnlsrSosQxfpfxLIDI61Yr6t9bdgXkDu
	 cQeG+RyuTcKjGgBnzw1pI7Gw9d8QUeBdRetN2MF9p69W3kG0jb4CtN9Wjy/Wqeo9P9wMQ
	 Pa8b5cUM/ruNwsM5qZCpE5cT88wEJ618crM/bjcva2eEFSLFBsSm2DaAL6UfTwU6pNs/j
	 3+2keHMhREqjX7dNCL40uxxrVLGJ/NxxY2MzHED47f9FtqmMqfTZZ41W43O/vSTZaJAmL
	 7XI1/NIyBGH9Bqz5PX7jZeRuB47liwkdrY2FuOW/r2c2cqMtLALK5HT/UYmnmyDnSIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=TTXhoTzg;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D03606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 15:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52D03606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=TTXhoTzg
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-843ea301d60so1575526a34.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 08:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1793287706; x=1793892506; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yZTE4OyXfMuvSFj9u4UbsZSTrlYFDczLFmxLInU5s4g=;
        b=TTXhoTzgbadNcSaonXWqQF5fezqBgmOZg+URLV1aOo/G93jXRxEYqIayW3y/pjiLpq
         Gy+P9SgVHj6qs4wtajtDVUhLHB2GNX2WaBLhctqfmnbsHtr97aR9pNSl1+6dUiUFDiBE
         L1NluUHoEwshsGLwXzvPlVr1VLVMAI2FPRe8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793287706; x=1793892506;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yZTE4OyXfMuvSFj9u4UbsZSTrlYFDczLFmxLInU5s4g=;
        b=phlnScEdTu8qTe1HH0b7GYD50nA626cblIXOF+S1fZEKW8nm5yQmKz1knWpFt5BTDK
         P4UCBHaavnbKJlunH5gxK6m6mzh2s2unc+oAC70dMv9SfmD9ko0dfAc6ZtYPMag2jKVa
         2yD+donV9pJXVg5wy4Y47P89Anp8zV9ZOX2JwMtR897Gf7UbL7pItNxGZ3qnfy83hd4g
         In7O4TivdxxaTHLD7dIdXs5oJ6L2c/dJrfIV6NvfZ6QtpBxKWeZrGxOTbxVRHHLW2iEl
         9bTFu9qrJAO0IkXDYV3WBw9kNk6lxS1SaIM7jpQrexto3aTclA17Twk+AigXwUrz0RW6
         rBmw==
X-Forwarded-Encrypted: i=1; AKwUvBwpowvf/zNTq+iejD4ODXyxzPHCiFZ98cfEgh91KJhcalG70cEUe4ZnGbBYgtDtZ0Ibff2i00o=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKN1ApTpwsDeY9dDSeyv9afh05e5xuXbowt6X9gpz4F1nztP0x
	NoKegDrS8FdeH5GhqZ73pFBk2ElXsm0yrwSzWDBd6KRuzqxTw6nBDWIYbEkI+4JUh0Vj41xPnml
	sPuNHGT4=
X-Gm-Gg: AYBFou3WwHW9LyaxTqdoZGyC6V7gaIm+wKKgnTySiaN9m9YkTlrINbn8lG9TnyF1eT+
	zb1RZHnNAKjePgpZZrlB33KlzHff46q78wQZoKhsxzeOqeGt79RUQ6pEm+EuBldvuYRtr/P4ilO
	/qhBHM97TkIU8oQSiUVL9tj/NYWp4hc1F61qCE/SuB4UfBCwdjmZJzQvnaaogGRX8lpYec8HVL0
	SGFJ+l0St5//tm2Gb7XrApYK3xT/AdH+AWic7EAtWxbd7cmWc7UqRcjVmhz6n4spZxGX7yhO+dW
	A1eR4uVRYI0rOcRm1sWVWW50P595XMn47UWNuANSZCCKnfPL56iTP0O1WwsDwq51IvUs+4Jmu11
	9/xW51Fgsni3SnZK8PSTeryq+SuwZZaERVvt3t+O3vukVvpYrh70rAFCA3MnobVroafVGu5jpVv
	c9Rdeh3I5cgSj/5qRgTEvKZHwXsXTjdhvui2S/D6Rs+JLsIGbuA2Sh6BRxfNxmB1QJb6yBBuZgY
	HiueThRjO6a3JJvr2zJ30WW4fqbjvR3BgHiutGc1o+drcsiAjizfdpeBWkpVTlItaOjBNxy5/y5
	T6jUdSd09kjHe0kdU0QukLMAUJgT9nPkWQuY6qk=
X-Received: by 2002:a05:6830:4411:b0:829:2af1:a07d with SMTP id 46e09a7af769-85abf966b72mr5093393a34.5.1793287706261;
        Thu, 29 Oct 2026 08:28:26 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d33f9bd96sm72469a34.10.2026.10.29.08.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 08:28:25 -0700 (PDT)
Message-ID: <8c2197e0-d83b-4089-94e9-7e6cf5a080b2@linuxfoundation.org>
Date: Thu, 29 Oct 2026 09:28:21 -0600
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/168] 6.6.161-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261028165943.089486480@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261028165943.089486480@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/26 10:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.161 release.
> There are 168 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 30 Oct 2026 16:59:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.161-rc1.gz
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
