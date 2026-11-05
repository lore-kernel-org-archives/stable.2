Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793920557;
	b=WsUsd9oWGxsInEwwfNAK03S9E7/uu+LDgL5fQjibCBOLb8OGSAoa83OWDu5rjCGhsB6H
	 6JsM91e6UandthVHKKVmraAn7PdQnzTuqM9o42aV5XKmuY1aDmREu8xKB72Xk0aqYkoS/
	 5nKaLLQ27XcjGIHp+PrjKDvtHl5f7IM/YUWIAcq9iFhMFyMRPITk3dLe7DCZpy3aLwtsV
	 ELMA3QFEyfbFA8wwuPKil6x80eOQ0dOrDKUFMaoUKKeG828o2a5LhYtg9qTcE1Il7Y/Nd
	 dJaninTg1YaaeKCtTrLF2RgI1cRyhHqyDoDwB/wGcYsiGbT8bSdzfXkmqI3Y6BuqJcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920557;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZIBbko/XwwoPcFK6nltO836d/lcp1X0dnZPX4hmz20s=;
	b=4+Hv0XRAj4lribCbP0Ke01WvzFHFLOPtPey4rlWg3mR86qxSnyggQd9JEPBl4m6BXxKA
	 1oXzTgs7AGbqWM7SHldu2z0JoOOZrjQvUv4vn2NMBJjXnmhECXXgrLBLEEr13ya/1RZse
	 GDOajjfM5PQcM+r8BI3gJZQPqZTwRDEyMg5vokrOVR+xcdoLl3glT35bFQaki1lf0aVMw
	 QbSVZzfk3FJvEF0u8cKDgFcvcxNkC6RhvpeZneGB5p2n7EvsVjvOfaGWy9/jVYtMKO5K/
	 QEdqBnhdXCMSgEgrFm72QSIgYRqD07LMUbFC16JrbQfAJEc0DWS2/YdFt4+qo7Sou0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=UgrtqMxq;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35495606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 23:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35495606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=UgrtqMxq
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7f84a55cc06so82180a34.2
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 15:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1793920554; x=1794525354; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZIBbko/XwwoPcFK6nltO836d/lcp1X0dnZPX4hmz20s=;
        b=UgrtqMxq4FYJbPsZrHYg84R8HHaHSKqcodpKFFXdRinWdZ31huS3uNWI57BfltmgX6
         xXWsmKNSsS1kFuevymyoBdDomfL6w8adDswsepy+rYMfmvZ0qo7KmOFc2z8lzKVWffPe
         Npjmt5BPGtqUcGNcOZsHx7I77vGa4HkCfSJzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920554; x=1794525354;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZIBbko/XwwoPcFK6nltO836d/lcp1X0dnZPX4hmz20s=;
        b=uOcKNo1+EpdWDRSCSEdN8c6xdyrASm/ZNafHRrCOaS+u4QqSY1oUpG1ZFyTXQkCKdQ
         KEkkjfUtSFFiWpiqBXm1PD9UXwY0nhAMyyrIMT+MVqO+6IZqMB/uIkviP3EEoy++ndlv
         aWpLsnOS815tqVVQiYICIlOPPAPp1Jg1VEa8wHHLxZT0UZw5V2daYh0EfmczrGfwm0ne
         MlwaY0pl7PCwFy/NQBai/cO2DIjeapbmrD5RCrhHI8lgi712FdHdumHRUOd20+OF/GXv
         5nZfuEb4ZdlX0N5hWAZAlgDm8g/p5t3bo6+QXV1tILebJjmHbwu1XTvTa2Dl+HwLHRPG
         vAJg==
X-Forwarded-Encrypted: i=1; AKwUvByG9b2xeugDA943WwErdj9DeZ9LX3Htbtqqq74YJfVymVed7NHgKdM1g1REQPi/LIR7fiZ5EL4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4f80QR/MvxuO7pbcwuRCHuUWb6E1acyXybgB+BdVGgEFvGphd
	PrrzYJ5mUkSXTCM6xPNNbMUuacwO2XHZvg3JLwsVqYI0Cl1qySSF40jEUdCJNYq8qn4=
X-Gm-Gg: AYBFou1UbQAYRTjzEwAF5Apw5mLUM2H8N5xKRHxFR3xu5oTjtH/YgfsDwb7/nAkvW0I
	NdkrFtFOEZlKyESs3YVVTjyLSluemW8x6iERCsgCr+EcP/WbkhwK1nhxOd2B3qRa9H1QKFoGioP
	Q6Y3PoqoFZOU2qURobLA+0wAOT8CMwg3rKARbQkfZzq9dFHIg2QtLRNBPkUs+24gBCyZywJnizF
	gbxnsPuRM/XRuPxBN1J7HsrJsAPSFVnguHh8jzfeQZ5aukue8yRM/7adUpnSsaniDbnwLnj0sKe
	vPQUHnBY5tg3QZrRHVuFhnIxs6Gnbb8FdiYCqLkriwuUi4f/Xm2VW6TcZmilbyBuC6bWGbJK7Vb
	NFaIRui4tRliLkPF2X+PvU7tEUMP/wXTrPl9lmqYc1UjGWIRHSZKkzewNYfwYECLpdHu5KKbIO7
	RGdUs7UZ49P9hgs67rgvlvW28YUO7ATQL+ZjjPNtPVRT4x2ONdhmetAwYedCB5BhcXEq6ExjB3/
	nK4ExQmhTTESKV40QqmgTT/Zj3jcXVUTYo0WHxFXFHvrhbTb9JkMTvn/Xl0z3znJ0o/fanmIgN1
	TnEZ+lmfCA4fxm/fonmGJc7eu0MJB8ghPHXAdHw=
X-Received: by 2002:a05:6830:4127:b0:822:b35a:a2c3 with SMTP id 46e09a7af769-85f1ce07346mr993561a34.3.1793920554194;
        Thu, 05 Nov 2026 15:15:54 -0800 (PST)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f1dd234edsm541102a34.16.2026.11.05.15.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 15:15:53 -0800 (PST)
Message-ID: <4c7e5229-04cc-4341-a495-0156dc3c39f5@linuxfoundation.org>
Date: Thu, 5 Nov 2026 16:15:51 -0700
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
Subject: Re: [PATCH 7.3 000/547] 7.3.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261104211038.406938024@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261104211038.406938024@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/26 14:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.3.2 release.
> There are 547 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Nov 2026 21:07:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.3.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.3.y
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
