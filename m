Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BBC38B15B
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787248900; cv=none; b=IhUZOfQOr0gv7X3AVrteOzytWK/EJpTUvnHe46kFqPmP8TiNw0tqJcOe/XmzEfoaLRHJpCHX9T4NjNMOQcuohN0jvpztyhudKEOol4m5TwoDjE1ftuxzTA3PSZSPcaab9zV3f4EaO518FMwnMRwDcI/c4k8LFRpp4TiCbGs+7CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787248900; c=relaxed/simple;
	bh=KxTpZF2RsrhJWGZKvLp6hljlhcEuDals4RgmZO58QVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oPDz6U3FWD734lSm5d7QxrjZHTOd2lHKqYyK90nhQYEJvM+iyH7CwQ2tebk8VGtuyCbhTtt1qVwp/N2uO4L4L2xY1Aj211Ke18JId2o174igYS3dm/WHb/IeMjcM2pwLQUSBgwWYcIQncrRQ9WP9KP6Ov3RtPq6IPNXjWKYh/NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPvTWsws; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPvTWsws"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ce7d2adef4so2039265ad.3
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787248899; x=1787853699; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hlqcwbHmyeOGRtWViVrwh5tgOZkhPcaz2pk+ge5vkPk=;
        b=BPvTWsws7fAky9dujUG+h3oZfFIvB7iLoWt0vzn7w6womNURGTouSi6vqsX8jhl2e3
         Ip37OWaxZ7uy7zwpCWGhd9t3Lc9oI9+BxOQoP/KWRuF2v+JoGu2c2FnUtmJlU5lToCZ1
         a+tsq1V+EYTiHAPn/sM/LlarEHJYE8jsWsJecSXYVQUdsVD80hUpoqysu2AyMePOBOsw
         RImosF2b6JUlS4W4wA5Y5GLg0Pfoe6O6zHLp7B1qhPab6lZvUiJluKIRYv/zIjuvp/ph
         PaI4EjcBFORHkY3Dqvo+IM48ymf+0dMUJJIU5yfcW5cc4QsLhzE6s686PLj2k/HtkGr+
         GwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787248899; x=1787853699;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hlqcwbHmyeOGRtWViVrwh5tgOZkhPcaz2pk+ge5vkPk=;
        b=DVeVpBaJaRpqCeYTx66ZGe1MaVxvOxlDK/D0tCKEIjP57wWQt+9DdVmNi5aPsy7cth
         pbNmHZ3lkkJU+V4OHh5ckYSSx09kBPZX6YAIITGgfHgOY8UQV79zZn/ssq6Sl/s1BHTE
         OZ7l7kO59RWPqsbG+GlHrAUEwx0byPVa0tyGg38otChIrT/48EHBkYPLLzyIgKatRdx2
         5xDJIolV/c0Ai3i6Uu2l3cL4gt3N/l1MKPwGGbL7crkLRAh4ByPOZAu6Cm9brioLCKjZ
         hvOnqcgm2HFD5PYNXxo2chFCMbB1p+AwVKFWeCF6WA+FbBNYB6oBtzDIe5jQEp6PFAj1
         JwNQ==
X-Forwarded-Encrypted: i=1; AHgh+RrywdhTiL15GheKGMMzDqUiwg2d+gLzlznPjToUXvoRlmi/jN9bt4RLMknwpzGRcirhpZhA7Io=@vger.kernel.org
X-Gm-Message-State: AFuF++kEZEFikOGPJo03+v5XZPwYhESpzezMZZWuvbSsouiT5qp4EVyR
	PctRvGNf4Vpl4XgYAo43rq9H2ZRK1mex/NE0wHtVRL8KimUS/ubgSCZo
X-Gm-Gg: AR+sD12rZInK0GwIxFnrAsAt2nUiDuA093Bg5S+MF6DGqJ5GkF2OB7w4+uCKFATTZ09
	zyLIL26uRVwmRTgzfhH6kToyX3Mj7+4jHm4isFbJNIM42F/5QgpCYYRFr6mQisfOtRuDBOx4L5i
	CgNfThOrNYu69tp9zmIV0/fta/i2Trf2EBKfoqKNxhF0E+NBTBR4GIF2awJBkpwRHCzz3nwC+2M
	DppqzEQMmS9aMNyG0Ttg9u8xTXg/8Ni3H+O9G79i/Ggl6FibJ1frsoWL544ozkKQg2taSVB80T+
	xXod6Fa1QlPBNOVT4rWAJt5s2fYPQE0hohte3KIrJ+X023Pqhs7UPkP4WyGKcSK0nFr4LYekg7I
	SiLNdmKImJqMN8W4WrM3kD2T3AdPdVlX+YvyLoJAoqUnZ1r6N8vzq773XcIO2SmjbM2XjWhJW1k
	R6gPJ6oxlUY//rJ0CT4899ZGec5zLfSYsweUSNKjB875tfxB6Fr438LBTKEhR625o4UP4cHryWi
	ma0yqrnAhINRyA=
X-Received: by 2002:a17:90b:3c84:b0:390:b41a:b92b with SMTP id 98e67ed59e1d1-395c3542369mr616048a91.4.1787248898010;
        Thu, 20 Aug 2026 11:01:38 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395a9e16aa1sm1217463a91.1.2026.08.20.11.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 11:01:37 -0700 (PDT)
Message-ID: <52b90ab8-2503-4cf1-a6aa-767b3c2981d3@gmail.com>
Date: Thu, 20 Aug 2026 11:01:35 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/272] 5.15.217-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260820145231.229664293@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260820145231.229664293@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/26 07:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.217 release.
> There are 272 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 Aug 2026 14:51:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.217-rc1.gz
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
