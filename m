Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D41F3A59A8
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 22:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786401044; cv=none; b=tnDXOK/7TP/eIT+MeaX2qm3DXN05TbHqLDedADDZoK21JnselFZo1srHQhzRRB5QAv6bpO8ide/5YLmfg1m3D7X1VK7dJgBI0bm4iatcs1usfBBMz63GWZvJjFk5fk6PFHIMti6epjxoL8/s4wGYw4pmonOi09Xs/EOR62tfQQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786401044; c=relaxed/simple;
	bh=hsHr4G4ly9k5dRJk92lZAUzitwrVDUCT8/JP7brInqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KvbvzLa4kHi8qlIn9TnWxc3Gx/9SbMMeo7+vaLcDSxF4in945n1FfuZK98K+qP5FZugrCBgr6tkrF/Yf4JRafop7d6XvaWH4MjWA7iDiPjtDAWETTyx7kw3QmHrL8K8STDf48oYQIy80Rx83pUfj7F3uEB2gYvIe2W2JFs0v08s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ig/93KTM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ig/93KTM"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d004f135b1so2487245ad.3
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 15:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786401041; x=1787005841; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5HufdBgIAJR7/ctK7fDRqhrzMJOl3BE9kKRvhiw5OD8=;
        b=ig/93KTMVJ0JEqwDohJSVVzhJ/GdpWBd++78EAbiYvlroPaoGpzOESEY3qyeHvu56f
         ye0Di/POf3BF0czUzVj+TwjvoRXsSkHXgfpKe+N1RS+SZDyEujgRQEdIa6Q5D1aIyoGB
         4AFrU9grONOPlIayDEu7cvwVMiCcO20gYNgm8sAwcY3jC4NpFePb+Xb3BwzQd9AB98ub
         lBxKUx/ch2iXSSFFZJm83SsfhsCF92oeWaUlQkXdncQQLFiiKHFGF+g9hMJt6P3f58S6
         AmFFWHf2h2yx5Q+z1BymnfKcD7+n1iYYyW9RdasCxZyJSu/BgisdM+KAYPdte/Vfx9sj
         pliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786401041; x=1787005841;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5HufdBgIAJR7/ctK7fDRqhrzMJOl3BE9kKRvhiw5OD8=;
        b=JHCA2Cgf+OoamO9VJOc8bhPL+sbFRJkyXuGXSDy5t1S+MFjtjOyK1gkkj5FmrpgCiT
         ezlLX1c87xQRkQ2DaiAlTL3BQ8TYgXrjpVsLDGi1CT23TKoeNvkol5TXxzRdo9/CZO1z
         WXYb7BzdWY1wpNtX8z6U84iBtGYD77fDujWNIlEGFQ+6c47EIrAbM2pz6ygpbSJ5aRwF
         fVpHkOqf0yrRoS/VUDdrUp9TB/YIGExkIwmHPvXVkB2CmryXvcoseK++zQgxteJnuy7x
         ElcguDlXK8yZP5utVwu7WXOHgujFAsYZc06VmtYMkPVnV3IKsO0XpnYoDYrFZel47Pvy
         i8bA==
X-Forwarded-Encrypted: i=1; AHgh+Rq5TpvLvS9nFqMQGK1xXjFLZyVMQrulaFO5c6aEvOKN2vwGTEGPDQ2zsctk4adlJvp7NQ8suJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6qhIKRmCB5xdA6mMP2pOVZRV9lTKGhvEbTixKTYA6zEigrxt/
	py345KwpJiI/YIiDHOO4hHKLnsn1DEE0qpYhMn5dxL9+P6Q4kHVP72UY
X-Gm-Gg: AR+sD10scmgBiNbXpzGhlfZgL1qZ7Hn/d8wEybwzatGbxbggY6EskVelneTvKFaMYym
	noGHLrmJBf6SYtOI51HCU5/vsuae97WuRJL6hL+msv0mw7sjC46WvBKtUu42CnYbD2nNfCj2erC
	fxz8C0OAOqTUaY4rt+S8cRO1QhQ9hm1rdg73S+K9XUgnfcEdKFceXNBRgM6YOGZAf4QS7Rk8J3I
	cO6uL2uHxn+liGP9oGeH8n+DD3wSd7kvy2aq3MWr6wNSrDuOxcl6JvU43DnCe9x7+GE31Pp3yvW
	PMJr5n4LF91AQV4Hf5bVPWTxaiGV72wMK7f2ufy7wIrd08NciWnXk2biKPpS8rUoPHA11Msq7vW
	yS/5P0iZe+Tqt6scqv6XxPl8HMLNqPGxr4Yhj0PZwH9XD3eSTqClaPTDy7fzaaAdrI+hicrpuZP
	rLE3JHqOv6I7hKiQ9x/6Mr4SZz7gcceSFDisDmuqLD5DCQ6ttPDtCZQ8O1SJvsyZvzkULFB9VGh
	OLTrJc0RgUO+FOY/6e0IQJHgA==
X-Received: by 2002:a17:902:e852:b0:2ca:10c6:f69b with SMTP id d9443c01a7336-2d0ca7b54ebmr482605025ad.5.1786401040876;
        Mon, 10 Aug 2026 15:30:40 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be8a6809sm49065994eec.10.2026.08.10.15.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 15:30:40 -0700 (PDT)
Message-ID: <ae1a6450-67a3-41e3-a79c-3b9f69e3c79a@gmail.com>
Date: Mon, 10 Aug 2026 15:30:38 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/337] 6.12.103-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com, Ilya Maximets <i.maximets@ovn.org>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Sasha Levin <sashal@kernel.org>
References: <20260807143418.516897842@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260807143418.516897842@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/26 07:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.103 release.
> There are 337 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 09 Aug 2026 14:33:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.103-rc1.gz
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
