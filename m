Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC61344044
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395655; cv=none; b=AWQueb1R2y2DaSnuWVyh7JRGUE8djyetuOKSs0tm8alNsVFJLCOoNKHUMQ4wE5/nnQcA+KglPBwTN45a3Y2eBb894z5bYy+evRnex/i4cEeDnhXnsh+V+SGNB3jVNJNcPpP6E+FKPvTC/+538mhY0mEiVBYP+W05jOh86EdEDHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395655; c=relaxed/simple;
	bh=LG7nLw7OUYoPbNUTIUvO+GzE1e3hYi3mRXdDreFv97w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UVaQi33+oKqp0tFKeCrnYn7lLHCctoEpo9E+Y3NXxVIqU3Da5Eyiq51dBojY1VHDQnaJAipVTT0hm/wsyATKj3Ry0oc4uD4/lE5GejLzJkMqd2l5YKO0q8oE/Dk5xpuWH1Nvv3/PkPiXQRCClByrC7bVRoRPACbzUFtSWMOydGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OE2140LM; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OE2140LM"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9157d3f2098so205524885a.3
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 06:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782395653; x=1783000453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kvt21rKieVMVkzHlfovU2dRzd6brOlyRtBK6C4duChU=;
        b=OE2140LMg4Dw2ojUhaFkzA3KJAElfbxTYlMd9CTcZvqRZ+D2rOuaFxyIBdCP5BNccx
         tEB54/DCXo4TiuCvGVAgvE1+2M+nLO1WGSXtBFCx3pKQiqh4FmZvR6uVldptFbouCnEQ
         4OvSwnldzqiDRsUUxhSWtbEfOvQN4u3irf0mdVxc+sLuRQnNfPp6qpsf6Yoc5gISnsiL
         wqvzTGxY2cBxDJARNMJnZXI2LWR0iZ9rtRvnCXB4dHxoJRR5KlKUTWcvs/c0uDYn6aNL
         +jGDbVL+C/ttz0tqUJ4QlTijnElhA/Gg8VOc4KaqiyUJWftPnbmFflDMnQZNdNbwg5ZT
         h3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782395653; x=1783000453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kvt21rKieVMVkzHlfovU2dRzd6brOlyRtBK6C4duChU=;
        b=mwOVWoFyE/V5MSE3PQQwrg6bT5Rbua8Cg9+hR5eF8/DVVwMtbs0LNp9P7fbGSrjrc+
         Df58eAvmIqU9FA4RZm5DC82Jn8J50cr0iREWXL6kUXyd1UMvDwzy+MPSHVlq4jGQEWWW
         Mjrpp9j/ajc3K4fXK2wBdO07/KFJhGh1VN66sCHGlhJV48JQ/7XaBVo8CDY90TAN5Ux0
         In0pvDu9Kv1TfvpsKyKxKb+zEAk+QK3i4E8581NYf1qtTFkWQNlrP0zzw0R6/tXiqH9P
         H9S3r6IovKDd6jlfY1Aze73RokrK/3vrRiLo/dq6L0wgG7qjAxT2xQ2ZSev/Md9u+xDV
         ZFiQ==
X-Forwarded-Encrypted: i=1; AFNElJ9CM5GADyEgwfpju/Z8l8qe8MO6kHW8dKeGfPaoneibvP+0F7rkQh3jCtrrszdNihgRYUtospg=@vger.kernel.org
X-Gm-Message-State: AOJu0YybaMsQx7tVJoGwG7pKEQNz44aUcuXCJD2j06WmKkXDX0WVrqVK
	EJnM927hC7/aXaiGq+3del9RKdk/y6gje7aKBKx/lP9qQjYs8veny3b0
X-Gm-Gg: AfdE7cmNrYE3w9EMazoE/UeEgaCsvP0UVwBgyf4HbNwEwqiuL09poe/3KgdaG5xuLik
	9r+Z6QfS1z2GAA6NQHdny+WY3aGmFAlgB0qKaTh7Rl7HJdGCkn/bikb7QOKMeftEhKG4YzQGqvU
	c1VgGls813Wdg2UwI0hLqIN8THNe6fTx7ZqgWQon9PHxM9yNGEY02Av8eSudhT35UiFUHQlWsAD
	/A7cltnskhWIxjZFroevma8psGBTetaaVTq6wTssT0Rz13kaaE0nxQSxYCCp8gLdpCYweDMdcZz
	8qH0INWpq7q8QA5JxZkoVSBmO53hx1nn3DFbwSa/HVD51L1QC1OgkN14vxrOPrOXCQEXGUxHbfQ
	1U+y2WUDW3JehPsg7sLVZ2e3rV2GxTjdolRJFH1uBC2zhq6I5nklBpN0DPlx1azQ3W/RCTg82La
	h+RDtWw3YYc+Ap+8zqQZXu31KhBxSpUQ==
X-Received: by 2002:a05:620a:198f:b0:915:8f76:8029 with SMTP id af79cd13be357-9293cecd3f0mr396331885a.44.1782395652719;
        Thu, 25 Jun 2026 06:54:12 -0700 (PDT)
Received: from [10.178.4.71] ([192.19.176.219])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926000c31b4sm844933285a.23.2026.06.25.06.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 06:54:12 -0700 (PDT)
Message-ID: <3c85a618-4a8e-4961-8e47-882557f23e12@gmail.com>
Date: Thu, 25 Jun 2026 14:54:06 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 00/21] 7.1.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260625125613.243729608@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260625125613.243729608@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/25/2026 2:03 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.2 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jun 2026 12:54:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
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

