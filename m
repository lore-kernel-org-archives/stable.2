Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3EB329C48
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787681877; cv=none; b=M98+oW6jgi1NnFb4w9Giwqw2AfjRf7zAOMIr+rtTE0XiepjG5Mgcw0tZDZSxKDR86Vq2LCCydugNgGQ7hvbJxHtNIbspan9nv2Pi78xFoRVvg6YwUqZUO6JIWNPLqbtCF55NgBgw2YLeNEyXeVHBOevHFMy8T9pBJnctFGur31c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787681877; c=relaxed/simple;
	bh=Dt7ncDe8e3B+3I1UeOHquBqkDmI9/orsxWf/7aiwomk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LUwIh01p0BOu8S6dD2NM3PB3bv83c/deP5tHIcKssc7Jqib8UGAVfGUiRZWsN3ZW1C+0jJeAomi8PBx1ZwtLm3uw7IcQyxaF9wE0FupKGOZxLfQLHeoJGUtOSd9dvVgXRLLIj4DoPR4O5nPNSs8C0wjWJrp3ywaXvLgxUQL14zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q0OSkanx; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0OSkanx"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-936ea476db3so1175485a.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787681875; x=1788286675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VxAwI4Fc+L+F4zd+LT3xyEmwERxG0KOHGZbxsUHLJFk=;
        b=q0OSkanxnXDrosnFHE3gQX8wR72KIVAO3TumvMn/ZcbNfVeOs/SHTwAaykPwHwaob/
         Ds0GibPshHl7/aeu4tKkUrAw1PWZqtt8HKyGRVw36M9o4pYAf+BYhdh3YRH/y+TjDY7J
         erJWO7cyTCm1UfubHBG0XeFA7cWmz5nvgd9K6WkUNHspk1ypWvWdA/V7nxW2THCElAXP
         +ImAlTx2XqZKp9mUbIFJdXMYgqYyjPYB8/+J41I1jVqYShCMzMnhs1Njka2OqCDom5x3
         1tS9j48OtclxBWVBNb8OQBB5VvwHYvyhUeYXXDoGvkvUzSZA02Aw9SK9Re4D1PaWL5vb
         e1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787681875; x=1788286675;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VxAwI4Fc+L+F4zd+LT3xyEmwERxG0KOHGZbxsUHLJFk=;
        b=Ah3eVOevFEjoS5jJxrxEZEoDwu9B2/qUUTOjcB19qfPFVN6nG1F3RyeKbHjD73BI4L
         +ZIsozPknU8oQLyXbnH0bOxMLeyBTQNl/TEl1829UzoT7FrsOpxhGO4bLxdi8mLaxuVE
         u327y6aWwwn6nLe/ZtsSng++0N6t6NSctbGFisfR+XfP2T7uNKF5YCllO5eTqGqaDist
         KOAzKHmAHMxTdGzey3NFHmsYAPAFsCK+5wDGqu8f5dRGJPvGE1ZOgjVJQQDLO4j/wSyP
         WEbtfyH9vnBEy2I7NrizH7ksBNIgwDR0x93tfmBVqdP/qHBkBHyMKHS2QjBUjT8uk0TU
         BL/A==
X-Forwarded-Encrypted: i=1; AHgh+RpDDUCQKLzz6k5loZBzX6wBVt4NhetHB7WjDflXFOOQqvoIhcivOhNY21536uUxiFYojJNoDl0=@vger.kernel.org
X-Gm-Message-State: AFuF++nizhflFHx27bK1psduYkQIooyJTN7/9rccKRkoYW/pF3L5oOya
	I+FGF9UKsDWOi7Gn31CvroMCFSunH50h1+DgPulY7cjicPkYqWEw0Jv9
X-Gm-Gg: AR+sD101j+8baQvXISyJEJt32UKVpwKCy6+w28k+tJ5xGM4vDraovwqDiv3bZuFEu+k
	MeLUY7ahid8bjA0ofGBhM4zG8Ee8G+GH4xE8igwbs+06c83ReIPdApjzDY/QZDctOPbu+PRgXzZ
	1vPB0NOJfApYhQ1W8tF8OQ4g6pzhxPB6UyYkKe6UXbMZNGK/is0HtSe5qaqP+uSfgkhGRVf36+v
	3larTnhtgPPbCC06xUSfd/nuU41CgvhE3rkKp6lNvMju2QeWmn6jQ+mmhldUX1U6GtezdsUrHjW
	YpPiNCbs3kyuzsO8oQdZjSgXdy4XY2Z32YhVa+/3LRWP1ihTr/1TY6trwIPBkblnbOwimvv3OrX
	icJOhEBLEO2bTsCI0C33fhlf+F1535w7BJS9j+FCSKduagYAY7kGYaMIVlgVCRJD1kym8ffjpIr
	28CH7tMMYURLWpTtzd2Kw8IgfA5rwU1e1nuvBynfdKaLYFa1L+1QeV5IqGDD3DYwfMGtChfISoc
	P5lzfceTBjJPDo=
X-Received: by 2002:a05:620a:a80a:b0:936:315b:a5f4 with SMTP id af79cd13be357-93780186a47mr38178685a.5.1787681874939;
        Tue, 25 Aug 2026 11:17:54 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377f217c5asm22804085a.15.2026.08.25.11.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 11:17:54 -0700 (PDT)
Message-ID: <f88e3144-f38c-4053-940d-cbb1e0cd45ed@gmail.com>
Date: Tue, 25 Aug 2026 11:17:51 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/76] 5.15.218-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260825132541.568214149@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260825132541.568214149@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/26 06:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.218 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Aug 2026 13:25:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.218-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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
