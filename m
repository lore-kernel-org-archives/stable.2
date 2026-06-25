Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3348D9463
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782394428; cv=none; b=q6d3SbxkIfIUVgxx5N79VmQ3PK6Uy80dHRp1Z6XwPbfqQVr1Cm4RFjb6NHQdOXo1RNmz2scQZJ8fDwL8Z47FaF+okyV1XrSNM91eEtYzSDHIqYoujWG8Y2uU1EdpETc7MBUrm6ty7aDcRN0blQSx8LCXmsXf0gnL8IsFKxyagPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782394428; c=relaxed/simple;
	bh=Mh0dKkeL8aXK2jemvLY5QFtmT5IYufo7jHyQTtv6G74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IzGSSB8qWUJofLjUYwjYErJSdKNe0hcuHtMteD7TbiUePRdsNQnvuu1PoAfMPO+7iZHxMqRv4SeeafQINupSF3MmaIxsmA87hhRxWOSM6tmcTfbB97BCc2GiMZ3z91BNofKrmVVsv3pMELVnwAXeZLVm02djqZGcZWCFQ7hv0wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJyhJam6; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJyhJam6"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8dd20fa3c41so13325336d6.2
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 06:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782394426; x=1782999226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e8jaYkk5SwnwbHydDYQBOKtKgzdwEKCVkW4ZXTKn4Pw=;
        b=TJyhJam6INREZ8HRpHptnjE5kCyyzz5ghda5ZiRSkdWqioAPrl1rO2iRd43j4+Gymv
         Y+ukUeeQjw37IMarC99TpSlXH9LKCs2idROJ4dedmpKvJHWiLxJwDRBczcGR3A7uTwyU
         bUImj+jYwunLn58BrCW3Wwo/MvnodgP5NRYplY6eCoN/e8oK7+caw4c6vl5sKlXlDq4b
         L7Uo0K4C7IBQDdb1G3JZr3nf+sGXef9jp1vZCBzSAmWB4KtOiKgNPGeeaAcdcUopx4vo
         MSbq+5AqqRGvx0oXq+Xlz1ivjhxDhVe2oM1wnueOQPkH3CA+K9hh516ypW6ktetKS/Y2
         tsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782394426; x=1782999226;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8jaYkk5SwnwbHydDYQBOKtKgzdwEKCVkW4ZXTKn4Pw=;
        b=tBT2CMERyyw6GCrzQToWtgaopQ8ZwP+Lkk7mCLvXBztezn9zfe+dVzkznRJJ7yna9J
         GSMGeDTpcBYhnGxrygTAOw2sGb42jmnena1tTBYvITRc4l+Y5HcXZ2y2/awQ5wXMkch+
         sLgQcEB6liR1JE9gqj+Up602kRZ7zRdW+Eft1Y87Ze8hNE0Zr5Y45H86yNKKDFut2NQF
         MoA2rovjGjfvomISWSSOm88z0M3iAOIc8r8CggvsBNheVMNGfW3NuYsI7kvZRPjh7VF6
         4bpxl9cT9qnbhUR8/zOE5go9Os9yfuc6ZvPmldQPp/iLwZc+iElb0h1Spkeg0vbUtYFp
         lOlw==
X-Forwarded-Encrypted: i=1; AHgh+RrCXLpGQyklLHqD4hu1AgjMzcPS9UvenofsKZQLU5SeAsBrdp3fA9/hZB6dBltpNAkzK3qHWu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGv513JtubR3fltKBZd6wnIEsp8Ck6rXJVhr0aq5icevPIe9GW
	tfeb4d5a1uqxrI8Fug76FFE6VO+omdMlfxgtnPc/ndnsqL5c8Ufms5lM
X-Gm-Gg: AfdE7cmFkWaocYeI5K7PtNZgcx7JqIygYFvV2tKfSBX8YF+rJi9t3f4Wzwc3uHdJzPZ
	qePyOTp8thDzvYD4qNdV6+7MYHZ4bbloOt8NXzh//s0dAeA2esUN0W868UoWUSCgdB1xJAmM9bj
	T6piadG/17Bb1jm8H/RWa5oSg+GbaPdBZOcG0y4ELssEnTsbd/ToqMPPuIjt9mYvYO+O7XnZ17q
	lr3Iy1jW/24nwWFFsq9fY8EAhjMSURVl33tLUC5SPnNUbdATzs4BlpRASYUBh3iAlttgh68ZM2k
	bL6UBLjNkgJC6W/vih02beD6+ZFAhD0ZdnOUr8BjePFBgf5/NhZrrP3Yz4C4LduTbgjxxRycuT7
	JYQZBSP3KZNBUtKFHq0eCXI1mLwQYTRgrQPnUS1BLp+eIZzG39c5ZzSlknKSyxVdYTJZtVR5Vun
	D6oVmVzTawq+C7FSDcf68K+9H7MLOA9Y6jizOiXRbc
X-Received: by 2002:a05:6214:4698:b0:8cb:e63e:2a45 with SMTP id 6a1803df08f44-8e6d6c63088mr46861146d6.18.1782394426116;
        Thu, 25 Jun 2026 06:33:46 -0700 (PDT)
Received: from [10.178.4.71] ([192.19.176.219])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df8303ebe1sm179860586d6.49.2026.06.25.06.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 06:33:44 -0700 (PDT)
Message-ID: <a4a13196-7df0-48c3-8ea5-b56f5f362679@gmail.com>
Date: Thu, 25 Jun 2026 14:33:39 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 00/60] 6.18.37-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260625125645.554579168@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260625125645.554579168@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/25/2026 2:02 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.37 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jun 2026 12:54:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.37-rc1.gz
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

