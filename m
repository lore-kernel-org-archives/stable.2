Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C6453A890
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182817; cv=none; b=DJCdC6cQGyXJ1ZPzWzOCPd/nzgCPKB2xBEbA01A5lWGmNCXht9iSHWjyGXllEJzXew7E9rkneQZA2i7wc54OqVNKI292M8ULHobKPKmWOuApN9DHdX8u1+vaDDi4Ucf4VtM0Ssa79txryvhXYO0qjrczRqU8i77BrX19H7qcHvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182817; c=relaxed/simple;
	bh=sGc6PJ0ESI7aHX7FRKJfITiyKS1azlW6j7agq0JY1UQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nT/hgzmBDznlUIPkFrarxmD09byMLp7jsTfMs20Mpfn17/sNVNvLuG5s5xWPx/BP8Ij+xwi0Z5cRMCvsGhVF7y+jFq5gVk967+GrBNxi+V9phe8JmeSOE+tFWU0+1jv9qhjsiVBiqfEpm1ohq1KEYJGYMk3kz9aakHXuPRDV1OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1BXr7hr; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1BXr7hr"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469b2e1d5so702725b3a.1
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 10:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790182813; x=1790787613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zS39PJcT1oQj1VI+hAMdqo5YKZWOz03P5HuPkkDO3U8=;
        b=D1BXr7hr3nz3+z2BR57/MNCw75SG37vRiam7uTqORXArxmgjvVuoJOkJqGmE57mbTG
         s4s+ElQPhf8Di8AQW8eFxVXQjs1V665EddN79qATTa3Xoex5+SL+iFVaaGbFGJjk1Dwu
         G7kySfdFMfAnZdYiF1FySkPirWClUu3VzLy+esoeLfzQ9LMGNiM5UaJnhl+0dytVaYxF
         pbIudF4DnTq+uDE/4ouwwahVVUiGvLbQXGW1nOQklhDv7qJZSoFWFjy+gS5G02R+NgsJ
         ou2VVev0wVJ3ME7LWaJNZ0VRMWL7tfBe/d1KNgyStSeW1TnOYSh0e6JlBSjVgEIr4hQ+
         YMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790182813; x=1790787613;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zS39PJcT1oQj1VI+hAMdqo5YKZWOz03P5HuPkkDO3U8=;
        b=d4WtGEocbJa1KfeceyyU27iI2HRqRECCXuWSUUK3k+aSFRC4JkuiaDxVPDbuMmZSor
         1a4wWlKWmpki1DZ5vlmGbrk5PVI2HL7pQArJUOPm2QGuIxWzxBr+8H+eP8G2qs8GNewv
         O6naul/eRZbH+MujGKXMuPgNr96ujkC9jSJUntfRV1iR6X3YnMdykwdXKiX/9zbZ4XOw
         LMxf9+gZtudlAH0ChU04GI00WL/NmGOPI96H42YfvHWzf2T9JxojUgbjgo+sEveV1XaH
         Cghcz8rZHj5JztaTU0juLOsVJRjlsnPEyGp/pwhclMrlgTRXbTa84XRvLAHfm11SkdQX
         qXTA==
X-Forwarded-Encrypted: i=1; AKwUvByXxHmic2dDY8hTSLVGvnniNZ8jbSrXfI2ab4DUGhO3owbK+bglbPxKfEW0IgzH5j0S12k9a40=@vger.kernel.org
X-Gm-Message-State: AFuF++lZLP1sujuCvgn5EaRUlS6hQ9AVYqecJA9NZrlbfQPdd8MhUuPg
	rVUlT0a6DTJCGZKyLJ5d6Qb84sH/Z0GpDn+3xTIVhSjNSCzDMNEpjkGi
X-Gm-Gg: AYBFou3fM3k2MV1czMbNFwehupw2rN+5ubMjWlMJPHF5ejWqFQbuO0Jp2OQ583Fc/d7
	GSL/5ECK4k4/vdqlyu1WfnGhqgLJA6Ol4Q+DNfuvmLp8x87yp76X8y0rGJYAZy+ajrueXErwqAd
	vJorgwE2S7wLQpzVE6iaiY9YiWihhGjwnWLENIXGRQEAqxyhsCwmstAJrzDUIzTdTUjVS41AMwx
	3DVuvHfv1qGQuDFhuNVtaIOhjJol+3PltAcY1xLh1Zh00qtwI1q1TkCzpUnZqTV09O47tvnSRyH
	Xq0cQlCwGeCPCaWRcdxDzmyZsgX0xAC4vRtBzYlAZeIYuTa2+briwtRX3eu79lB1YZbLq8sQPVl
	vu9u8PxHRaMcID2ZgrWsTGklxHkU4mZTmzJME9cqOdUc9TJ+56w2mFNU48IEiTY08NcoRmFczMm
	CAH6X1dauLPeObgAQgCo55KBO1GHE3JR7yM9Yh3eVF66sObk1//mFcdMt5Ttf3oOxCgbFwxQK+i
	FhlcOjwmNS/
X-Received: by 2002:a05:6a20:d529:b0:3dd:a197:cf22 with SMTP id adf61e73a8af0-3ddf82868fbmr2949364637.70.1790182812807;
        Wed, 23 Sep 2026 10:00:12 -0700 (PDT)
Received: from [10.14.5.0] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1dadae4fsm1630251b3a.40.2026.09.23.10.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 10:00:12 -0700 (PDT)
Message-ID: <8fbc43b4-c38a-49c1-b6c9-77899760ca71@gmail.com>
Date: Wed, 23 Sep 2026 10:00:12 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2 000/438] 7.2.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260923140644.756254324@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260923140644.756254324@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/23/2026 7:00 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.8 release.
> There are 438 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 25 Sep 2026 14:05:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.2.y
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

