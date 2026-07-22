Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF5A4457BE
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784745652; cv=none; b=bdsDUsRXe3YAYjQFJfnfjMJla4Quw/3hnKw2ZtNqa1jyg5XdkgDdWmyNA8Qk63qUVaxvD+rJ+Lt4TDlvPoQZ9z15XJJCexzCjGjQekenG9sDf7Ua3qQz+RREVE2dsK3IVqf3dL6jjJI5hL71Nk0E92WdtQH8pCEnxo/50h7Gu+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784745652; c=relaxed/simple;
	bh=7qZBQPeaTZoAMVx8IfJUlVURpmaaUj1MqqDnq1C4U9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xj3qDc62UZ4N36Lt+D5W0TkKJn0wnhSs5F05qe55YM8wQWVfCEoSHymO0kTJd1cui1cYRdG1fNSZRdAnYsrKZzA5m+o6kLvSHJJ23RTVGPrqrwqdLhzAx20oA7kdrRdIGhc1eXsqCFLR7qUY3R3cbzGbedJaDk8IccBg84liz3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxKhLAuk; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxKhLAuk"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so166041a91.2
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 11:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784745649; x=1785350449; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VdNCdLaik619FSQBqF2V5/e4A360f7gF9xZJF2Ihnx8=;
        b=SxKhLAukUC1AonUVPytWgUj3y3B+YwLVnrGQnZfJDN3lURzocvvRJx9CoByVwvs7qh
         ZPWorifAl5mqdf5vGyWPGd4HbffcitPkgJ3arcI6+rSN6wkL+F7l+aAaQvflq9u9hbvi
         etj3mBSlYfXyXZwNHRtmDsi7hflYw3Fu1cjoulk6rOaYqlagdBRQIWFVHV+f5djoUQxG
         9daFyN95KYLfFQyjAdl9bshLnMTxIOQSSihfcnDE842JZ5lHglPcazHa9AJicJtAMfpP
         DXaJgJn+olQn4mt3z7Ejz2R+ZhuIWETj3QHaDxWbxKMo+0+/GkgDdSoFsVb95SoabIJS
         Yaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784745649; x=1785350449;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VdNCdLaik619FSQBqF2V5/e4A360f7gF9xZJF2Ihnx8=;
        b=dMusdXj9rzHltKqs0baUHG2CDKAVDs/OP8O+U8IoCYqbslI94ZnD/xxF/slQONkZRi
         WKbxjdxP78AcgTD8QpjIXV88zIezyo/RfFytaBHHZxeOX4cmrWqpAPP+HRPpnlOlY0du
         +RaBC11AR743qlStTwq/nHWp+tZOVsEL9HkyHDrxy1IUrbff78IQao0qHzcKDQQ1ZcoV
         etJMT+qW2h4ytp+xRjlX45q+E8JExD3/gBpSih0DfnpmAGhXct7T89jKZP/NU/+CphiB
         pz5YvM/wqztILd5pWBTGO6NHkO5GcnlPLf98VKflgI2qvmkiyR3vCHk9pfAnUcWTpeUO
         vZJQ==
X-Forwarded-Encrypted: i=1; AHgh+RoHg0X5wFe2sPH6HAbmDquhHVrnOlwGd7FYm/W6/3bDe9R66MYpPqkmG5UBjSL2Medn+d3AEGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9WUBx0R56rdeOkrIFnCRL3+ZZ3OvJmX+cCOx30fRuE/8xC3tv
	VuJ8utaHhosGCtd507txPKo+VlQT9SwOE/oMqXIXEtLR4YB1X2HTlMK+
X-Gm-Gg: AR+sD118VLfuFybsqZ2JxtUiCqTkDbnM3Lyh2vDutM6VkzqrA610vLu6MQu6g5MRvGW
	T435O39sPi2ySO3atA1dgyT2313CvtmaFrI7jxSqcgXuDVZf7SEyCmWvds6fgosnwD3vfzRLCFw
	qvex/Noge0D86PqM7UyAtS3S0MVYkH5ULwgQzFgSjyZErZ0TTIKqCj22WXwE87CeG8kpxMNV3Aq
	0deA4Mvsavn5PhTjruaGds5gpmajg0o6BSrmBUZMgS6kAACkCUCJUaapjReR9Cr3i9DeQzMOANb
	GaRdcGqNCNdIR4YntSeDwsIrH13qKA+lat9OTzr/LHBy4NPIAv9eY3lJkpVmyXAACd5MBuxBJs/
	QUwdG02MC28f6XarkGH1Csx8PZnFoyaTkUiXXXl6ppMgLw4ctM0ZVemHXp4L/GotE0HwdZAdCwr
	tcPn7vUroy786yiMkymhg5CXjC591H
X-Received: by 2002:a17:90b:3c43:b0:37f:9ce1:735e with SMTP id 98e67ed59e1d1-38e4b537ddemr24352815a91.31.1784745649456;
        Wed, 22 Jul 2026 11:40:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d13003f12sm14193359c88.2.2026.07.22.11.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 11:40:48 -0700 (PDT)
Message-ID: <5d794ae8-1aba-4394-8937-4057c1998d46@gmail.com>
Date: Wed, 22 Jul 2026 11:40:47 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 0000/1202] 6.12.97-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260722142834.868902312@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260722142834.868902312@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/26 07:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.97 release.
> There are 1202 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 24 Jul 2026 14:26:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.97-rc2.gz
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
