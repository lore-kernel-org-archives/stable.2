Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB554908A9
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 22:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787697184; cv=none; b=DhfoNH6KB0UQ40kSP8IkpVdh7YWI0gR4ifIuhoVk7m8/VRErO22bs6toLMRTaH0O0eOE5bKBuJRFSX/Y+tkGkF6X6nIvJLRCNHZ29QeX/NX+K6SpO/wxHkS9KpkCCU0Du0cj/5iugIPFoEMpamlU8rApax5QoqQjAbI11sHKJ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787697184; c=relaxed/simple;
	bh=hkS+ij/4QIUn/eSjY2s1BHYyQ3gtrdbmnSZQZskWohY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s0K4W3zrsrwZQGcw5ce+Rl5ntNXgCycvZD8pcuUBeKxcOtqjAlC03zVSHYSaM/Y187bAzFGgxp81PePfm8Yj9IyhN3uVOeE2uImLM62I0TuMhye1lfd50UqEy/yFnc1jhiljeYCaoYyF2TghP7dQEQPgCFPBcBlLUAwpUc7UW6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5J9oqKu; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5J9oqKu"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc1c3d79b9bso22953a12.3
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 15:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787697180; x=1788301980; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TJSb9WBld/1/tUPNLwV+CZNLUqE0Mha7foQadGzvq8o=;
        b=M5J9oqKuZa4cidKnIAU/Yhihv0O+XV1kg/CyKf1EdIDqWq849SkXsuZzDVDk09nAdV
         J4A4c2aTOy8tcJd7+8E7DqNROJNNRyoWMqXWsudnmN5O63SELaKVW2p3fibv3+jToUPJ
         851wPq2i2ansS0i/KmZQxD4HN0C63TeDjEz+tvpeo3es0kz5gzKAjTFKJDK9LQRyoU3x
         m9aJDMpxtY2y/jLmmGlbOVRy3bPb/6d0zXcpqKxFZRIYHC052zMN4Grw42+kmg9BQ0WY
         90xpbVElAwD6qDj8NZcN8L8cGoLGe3M92K8MLzvp3aSIVfs8b36or5rW0f8Ggm7NvtRQ
         c/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787697180; x=1788301980;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TJSb9WBld/1/tUPNLwV+CZNLUqE0Mha7foQadGzvq8o=;
        b=khVWNxZrhNrmFwKG+VumKPdhkTpZKap3IG6mprZRj+91m1ToRkiBSYJgu/a2uov+LS
         g0rWYViNa9331034Bspd6aI+wnp/LqwHQakE5qvAJyPtvNjkKMZpeQLeB7n29etsykmI
         INSwV4MYXrTjm3lPJk0XUpM9MIPh230/ICufw3XcwfJqdiOIExdqZcjyG28RmiepMwBd
         nMXJKfha7xp2O8rhJsnl8+Kp0FOyFT78K34mPYt8Bz9/VVPQLAhTlD1KGeyCMaXkDdZ4
         F7F9/S/HJvqIVtt+/iZDYT+FwRSDccDlnouDCCgHj7+6Kb1NZ8L8ZXYGeanK9phGorMD
         wpFg==
X-Forwarded-Encrypted: i=1; AHgh+Rr7qwUqHx82ZwVc6Q33nFZicLOqvCQ7wh+puDBDqDdI/rxIeRMJIEnFPUpfTrIK17Kfz5r2vW8=@vger.kernel.org
X-Gm-Message-State: AFuF++lOz1qU+fgt5vP4N/Czp+lncJfVix5QwYYLI008V7qtSeOYYgfn
	VRdUw7UFMeVKSrhe9EMNw+gOXI+hx/NythkO9ohtzvLCOWHG4VQBjWx/YGxL582d
X-Gm-Gg: AR+sD10iFBXnv/pWd/3cftdpueJ5YptNSHus7asVCbZwekWVNjXbhNxbS47Um++O+4Z
	p02hJVBf8Hdx64KqUF01NpqFd5pdezrbt51F4vlzf9pfKFniikRnKjUkyPge1SbogyS5OmJEM55
	75fsYEKPx4lN1mu/JdJhIFiOm6tspYF/Hfto4maKNSWKKmo5nZlMQEktuGwZvtBv/BjziZHpLOI
	WwwDZ049oXmbVINeKs6thS90mpqMSYXlCurT/3lXaJiHtzTrsCWJsKZZQsCExqhzdr3PpXsSBcq
	sdCQNk8gw6gtqGCD/KB+uvhsM4Qoltv5MjlMcYc7isxkh3gVxGri3yi/YhHTZUCn2L8i2PWrqQN
	EnS9VTkP83fsiVkU7D+1m+maJGGHR1LgQD/nkuV7R7FyrSjHZ1xZqA5SfQpYFIZs5yDXh3k6Roo
	pA7kxfvcA+aTtE+4Tu+RZEESjK/h3rhhkWJK3ct6VcEvZejBtA9g6JkuFxfyyYVmUf5F6N9ZrFz
	VzAeY0jZOEVqOY=
X-Received: by 2002:a05:6a20:728b:b0:3cc:feb8:ce34 with SMTP id adf61e73a8af0-3cf85670603mr2849349637.17.1787697179842;
        Tue, 25 Aug 2026 15:32:59 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8f20095sm2319217c88.6.2026.08.25.15.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 15:32:59 -0700 (PDT)
Message-ID: <5b991549-d202-4989-9e2b-a6a350f1997e@gmail.com>
Date: Tue, 25 Aug 2026 15:32:57 -0700
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
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260825132541.580275153@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260825132541.580275153@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/26 06:25, Greg Kroah-Hartman wrote:
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

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
