Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81978351C14
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781717360; cv=none; b=g5eb+PwYwh1Ezx5AweXSzpJvx61TMTJ6UOA7yRmmt2Hg9OjB7s3BP9PIr2X21E1omfvV3/dJ2UUpHAvJM+PPd2aWLquzNBvgBbYHgDU6J441UTB9EZq8jNu7Xh1SivUjG3P46MbB/VBgOy0eVaBN52LatRCQapnSQpf9yy5upLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781717360; c=relaxed/simple;
	bh=02BJK2ZfcsamB2bEa8rD3M8pW2i0eiOTfmEB9cAJ3iI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nhg2W9Iw2hhvrVLSqn+8DdCAmLkQY1G3r5j2fIP/u8dkOXtewZcWMLwIpHeDIym1Vrn1dhMjMoIWwtl22zAo81k8IxogficoVxGP2qRKKboolRfcXEJODEusSMfkqKk2UHNDA/HSf7pESzRpUyhDtNVezk/Tfkx3VXL4yxzeyYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ftiejinb; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ftiejinb"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-486304fa184so4569b6e.1
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 10:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1781717357; x=1782322157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VpJEmEv6Dlzji0c1FgDwTrEHITjYvzcZOoSTVPustG8=;
        b=ftiejinbG/Kc3eC9XUIszgFdmDToHrbwKeC3KclyuRdHMLZyWlq0hJT24sFTtqdA3c
         UJcqtB1/jlJgmd8KHaPlElRUh8lfmu+IDJiDcdqegXDk8NkRqR+MS+49W8POEGVbv55g
         niye9p2GoZV8BdGyyx+wrItEkUNF3ofwak/bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781717357; x=1782322157;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VpJEmEv6Dlzji0c1FgDwTrEHITjYvzcZOoSTVPustG8=;
        b=YeyJxJjcDqnCvc/xFuP2DPrlllgdUVEaCVSBJrzCGRneeTe8Z8KmQB194NrkGMo2hU
         rDCbAWaLvs/BK6ID2oNdqsf+Rh9n2FVkBXJ/WCCETR+cJnROc/wT+GCzM2/tGLylO1j2
         Cv3/lzl0VjJh1VO+rGjtvOVaftn/PHslZCSWz2I4+1l+0iwfkKhRPFTv2DHfTSZZGOfz
         uP2TkzZ8e3C48+/rgv9j5n+ut4Y1UHjSV7wKMMyApsSsDYUs1c1S9pIU6+s8E1ALrxO1
         COQFewcMfpRcnQv9jnUJt9sZjBSc8yunE/IJF3tYllmFg0lmN5mozLro9H1nMX2LL1Eh
         uvOw==
X-Forwarded-Encrypted: i=1; AFNElJ+KYHe16BeJY5GRLyoTPQbRlMYr9rLHI29mQv8JI5U2W09qSA9nw8I0LIEDYBqGT3Ybe05vpfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpyuZmKM8nRS3KrtgfYNRNJrhYhn9U3PzOEEexFX+GpLIpIodU
	PES80/YjELHGCiQhKCZ/fGf4oiFkOvWXnWWa4GUx2sViWMZ4uB1CqtbygGPpFmC0ScM=
X-Gm-Gg: Acq92OF5h0KGS9lQzgS02hcRGQpmimQjm9CKNpW9SV+6o5mSStpKxKOuWRKTsYTwHh8
	TfzvNt4q1KA3+BBtxxbJ0mfPuuPmqf9Pu8QFSz0dJY7DGT8tGxUF08ZU9O5HXb5W11bdpXk7o51
	1RS3irEl9T+FcHe3QHpg5CIvOlZxMLIh9u6EXFKGgOAhyrRdlRHvO7l5Y7o/rE+Tp21MWAhFZtr
	CBMLaCGIDeX4rgNLbGU+VJR1l0VXWcGPkqEwxwTvsDV7oCrzJkjy0fWICEtorR2R/Itht4qYTgw
	YScvaKpXPYpl+SIvC4deJ/edKK1rm4V70824+OZOp2p4Y7cWoWa8gGtBL0QZOXZeyTvNFF3hQ/g
	Yq35sVV8wpS7pAXoVhf9iPSHt/76woZ9wXDDMO2SkHlop97LIj3cTt04tIjTLQfsdEnP4P2qWME
	jWD6dqpD/FzKDqNLs918hZkF+AzXOqS68=
X-Received: by 2002:a05:6808:1210:b0:484:c3b5:9b11 with SMTP id 5614622812f47-48942bad140mr3688005b6e.36.1781717357498;
        Wed, 17 Jun 2026 10:29:17 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875ddda6b6sm6499310b6e.8.2026.06.17.10.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 10:29:16 -0700 (PDT)
Message-ID: <cdf1b806-9327-4c74-b3b9-090b9f78e236@linuxfoundation.org>
Date: Wed, 17 Jun 2026 11:29:15 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/452] 6.6.143-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/16/26 08:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.143 release.
> There are 452 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jun 2026 14:49:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.143-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
