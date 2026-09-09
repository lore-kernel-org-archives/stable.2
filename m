Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B49136F8E5
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974892; cv=none; b=UbVwBX+pck60n1rmY8JzlzLD+uRJMx1CtyNZJwGSbOZmXebNCSV0z2uIUuu8Bl+vqWRsae1n6jKjfQR1gtShwDUXF4YvZgXk8PKWpKvzZLy5EcFkhS3HntdsS6Fuotx+Jk794IQqiLVHib7+l43VBcPt3gW7e/vdm0Z5vocFtn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974892; c=relaxed/simple;
	bh=8NppacfHdLDtG5JzX2FZPUFkGO0XjyIiwYMs140ZnjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCPcRQrLfhCzV4pQl2VA1eydixnYiMn75vCklfi18voY+1CwiczDBnx1W47JAjYUsf/nvfAzNkQg0fuRxTfTBydqNuTdyxjhvtUBtIzc+CAXl5n2IRSfgYoqrfpsxRpnMTonETZ5F6mfxr8BU2KGicxEc9GyqNGSURoXNisJ9E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0wnXL3e; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0wnXL3e"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d90ba1d807so6908275ad.3
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 10:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788974890; x=1789579690; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7iMcbjfyMphX5/lME4IhFQ/AbOnN1ivDHYpPPxczf78=;
        b=K0wnXL3e+a0Xg+ju9TofH2rpLNcivHUTzxjaV5C+n0HVnZ62drz9e0wfu/WvR+bnW7
         VLtYl42chhRnOsAHuZF2eiTN5Z7SHHyfkWbSAZEmVeTtbLpxsEjuFP009veuq6vl0Ky8
         8nXjjR0v7yIbf4eW6zBYdQBnmChHLUeTUbQLKCN8VbxDw/0nYGuCPeD0yRj9Uzie6vGY
         BncO31hXgtd3yaSc5CGUc/SKoTCvE5r/1pQ1EgnOvduq/1/X9lN/YuMONSfjtQ6Z8aJr
         IhQhuxEOXbNxSdWVE6TuC7ytFZHeJa0BH0HRy32ALJ0sEcM/kE98uB3/jO/QAHR6/Gr4
         3zOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788974890; x=1789579690;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7iMcbjfyMphX5/lME4IhFQ/AbOnN1ivDHYpPPxczf78=;
        b=EzOVXbNGm6Kwg6QURU8pkVQiXMyQAcMcy+U2ith2SIcOc/1K4Oc2oJnIERi+oKDyQb
         JCSJ9y8r1wxU0iH723bQ62vlsj/vfYVkSCKvYwuKfjTLnQJYsyt8YEC5EvPJtjxGBF+/
         pEoNwofn/QMsPkGBzt3dOud+7ExNpr2p6AzS2iQFqIVTPRXN2xwBl3JYZ++BngWgOdmT
         2vi4PX+ZElsEy0XYeEka95Os6fkUBwNTh233tV+WXEO3EYn3bOzKbou7uWGpTwbKox+v
         Vqbp5ndyEofj0F3EF3zgd+az2yPg4bSICL4o2mf1a3FMw+od+NaFqfRuCgfBUD558BBx
         B3rQ==
X-Forwarded-Encrypted: i=1; AKwUvByqEaSNNPBdsp8TBS/Nwh02c4AQYBGp2Yjqwz3wPfWj26WiRGAMzWLhQi9WIB2aU+PpBRGrK2Q=@vger.kernel.org
X-Gm-Message-State: AFuF++nGEeepK4yRfIbshrBQtTtizi2rLuzyCzxfAIt9HyRn//DzPKKG
	+lbYQmHVVzjkUBZdIygH2YVYwP+R0IHZihPWDjZGsh38ztYV5lWp+RzM
X-Gm-Gg: AYBFou3pBh8WMbDsr2hbU8hHxXkAp8iUyVaTCZmfVMFOnwy2/LW5As3F7jpm1pHKvzO
	+10sWRKAzkQbBuByHBqR6dVS59Lgd19SskE4FwLrUCwd+qY0BZog1NNyJb1aBcebIQLfPC6ZuQt
	FkwIaTxEshJiN2zffMGXt7YrWuJZMp1SZWHMl7CLWJQv09Vl/Iri9H8kUga8LHxs1ATegqXBMGj
	VtNSmwBJ52CHEn4sQd73AfozJT6ziJ8gG2gvWKd5PTEVXGp7p5qAxOpjwG6raeOkri8AwzHuGLf
	Ja/J/Q5eZf/tfvRg5PdjZmJb5fzq1kMqoqopSYmZkDy4v7d6Jp8yZ1fnfH48RlrHr5a1PkjEI7H
	5hvXvAvqEJKfOtTUehkgJUTMH6jp/Ooqk1AzgGR55TDrL1GWPYRUBeCetq4hQOJGj2jd2+Fq9Pj
	fG02amiwtSYxgb5+Pn1afC7vcUa88zQ7bYVvAsZhKKcb2eekYsz5xR3Gg2cKcpltglTGcT9UzrH
	8I3Vhp+Ythhtpir3f1yzED6ag==
X-Received: by 2002:a17:903:46cd:b0:2db:39da:90f2 with SMTP id d9443c01a7336-2dd07809f49mr31004255ad.8.1788974889883;
        Wed, 09 Sep 2026 10:28:09 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1497e9e5sm76340935ad.38.2026.09.09.10.28.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 10:28:06 -0700 (PDT)
Message-ID: <04d98c16-9f87-483d-a4e3-b79cc586d537@gmail.com>
Date: Wed, 9 Sep 2026 10:28:04 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/583] 6.18.51-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260909134237.773280130@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260909134237.773280130@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/26 06:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.51 release.
> There are 583 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Sep 2026 13:40:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.51-rc1.gz
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
