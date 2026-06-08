Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A267A3128A3
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 10:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780916233; cv=none; b=nnsuDtwPkd36tjY3TeGBqfXAD7Uiz8PE7bFr38636WyYLdqceG9TkpNo+9m4ZlfHj60XJmX5IjajtXUj7bQPRKfnYCKCZwskq5f6UwwEFo6y9qYp4CaOq9t19SO4Jt8KHlpzu5QOpgGzHGg5AuL6j8W02guaLp1RDA/cGwepSes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780916233; c=relaxed/simple;
	bh=0vn0MVBVt7lRwVyhjwIAw/ZTQAU2EumbcQrS4nQ/D6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5ABG/NvQoZpZdsBR0hOKLmMVglK2DQvwF8WU2U8QadiqgrobHiwnbDmTSiF78Rg7b2pZPL2UEnbAbtJGhnsoW4JthQ/5iOU1zMwOWiKw52Wu4b1XEKhjWXoxC4SBGK8HFrBwMkhlO5FNOGj491KR9/HdV94CLOvyewGs33ybBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqzkGelM; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqzkGelM"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-46019edc13dso1895473f8f.1
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 03:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780916229; x=1781521029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QyQpbrcj9lw9mGc0nK+HUbc4jAd533Efk6gZmiy2FdE=;
        b=jqzkGelMlHrTSilBw0eYdjJivpf5SfKUPPlwoUpOzYLfec6Jr/aErUS82BpxD90OBl
         WjRaUdcGIyWd/joUpPSuxHLo8i8WOVWwmBEBIC9802Z49leKBQPo63botShXfrYy6t/+
         7V84Hbn8yVUEWL1uxqDYpZlGroZ28B6f3ZP0Lv15mBeijPjpykLn6SUt025ce83Wa3++
         oHEgh48CKVrVJf/14poaK8Z8y/lPVksECl2r1MHMIg9Mzn4M8kUDYhXkTBHHY41aTiIG
         VKpGLGrddljlaNbubvt6U9WdzsdiGagRtkvsRm9NfrZ8EdLJydwojaav2Jn295gZaADA
         T+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780916229; x=1781521029;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QyQpbrcj9lw9mGc0nK+HUbc4jAd533Efk6gZmiy2FdE=;
        b=T75Bmrrj3bIYx7ZsJ0KIZz90VfEsm9bxZuybI/K39uZm4ETKBmyLy8EF7Dbkj/wdM0
         haIhT9FZ8ZEqVIp9jr3seHytA+AZtnHHHdkhKvoQ9fRpuDwI8M/YolZMKae9yY6vNUyN
         4SaO0YbNwAi9LAGcLv52bNgxMtVVfyCTxZdhiWm//2sRLkFRmEVarhZJ3DmX7hZV2ViW
         wc72TWIxLq8IBtQ3z/Qrq/8eoAMAvChV20vKBMPiZnMhRiD7/LyRUzqO45sb+CzGSuHO
         HZslu9uauFgkxbABCB0FSb2livS9K17ZotLYf8ipUny9AR68i4oOkBeEr4KE58RaPkp9
         Suwg==
X-Forwarded-Encrypted: i=1; AFNElJ8SzuM/Z/PYxjR4wuKCpWPMcpbe07w18DQSIgGv94PNrXDG7MfXGHMqfvLezs5smRY6mkYZFuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0grHHxjXn5lN0ybkXLr+yhh9cCij9D32/lgJss6+SV2JPH89r
	HZvYFoFiAxrE9XQfQQEZ9CGP1thADBAFLyJQp7G9jxZ1EX+WoQKeCVHj
X-Gm-Gg: Acq92OGGdmg0NrxcvR4Fv7GLV3sIf0D7r5pr0TqYJ7YV877q9dQG02GxU32OMWjJYv2
	fest4JIdXSqNVSxqSdJnvIKsuYKISPAdq5aDh3chjIkoDQFCdHZCzM4tVUOuIFcBObUNGDWfiJd
	hme/abD+Sf0mfFORIe66GUljN6yhEzYnz1xLClwu8y0KPs6+x7ctPRxaAtkCANqiGQ97nO5SjOT
	PPd0iGPldBz01VIe4D6qKidmIxiOPp6+wEAoxYcFUTUhuTeCFkatYh0meSqkrxojEkAq8gOkZKn
	n2RDx382OWc2e93sM6XKDFExFrAFxgdhzBgiekvt5Xd5A5of4QSNAk7WRqbRL5QhHiMPq+0brXS
	OjphVlq4w9uZnbdDVQ2fiaxbZoFCJxU7uLznIxvORWab1WdgbXthuTFL9mgQiZDPN726SRpJFJe
	9gx+lK/Ph4zZ2zzGqGoYPLxV2zvoS/7/xzsdLyFlWEDWW00DIPCl0e2/ztrddsgXrjxVF24sJmi
	k7qpndL7k/nhls+Z6STdw==
X-Received: by 2002:a05:6000:46dc:b0:460:1d74:a1b2 with SMTP id ffacd0b85a97d-460305146c4mr17352616f8f.16.1780916228827;
        Mon, 08 Jun 2026 03:57:08 -0700 (PDT)
Received: from [192.168.0.105] (88-187-52-200.subs.proxad.net. [88.187.52.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm93075906f8f.29.2026.06.08.03.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 03:57:07 -0700 (PDT)
Message-ID: <52d2ce00-d1fe-4c1b-810d-b99165cb9d3b@gmail.com>
Date: Mon, 8 Jun 2026 03:57:11 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/315] 6.18.35-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260607095727.528828913@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/7/2026 2:56 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.35 release.
> There are 315 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 09 Jun 2026 09:56:45 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.35-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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

