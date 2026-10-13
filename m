Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CBA541E7F
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 22:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930130; cv=none; b=FUFD9DRTuQ3/c4QPySbc3IjwU//Qckpx50giEfYiW2KqFOZWUl9vRXXAeriLzy0kH+8o6QDOYRQqUy3PPkxt/EKVbsslpnzRTftnbdf+wwy0jXEY6c5/rf1WYuoXv4Kd+cjXe+57sCDuYgPh+7Q2+s6v9lN280rNRnjeFp+Qo4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930130; c=relaxed/simple;
	bh=i/NPyVftPT0T12Rd9vFHPH/Apd81QBDPn2/gafvAB8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5kaEkhgscbFWIzPQUgmBhRbsfTmlQwqxXevQ5c2oECFaQicrrsx0qc5hwmubqBs9s+6+4SvhQbZaoZvm5rcMXgd0i/FKFhlKf4N5qNOP0jqttDH7+s++VGhAUlj790xkWafSAlB+w9EYseBT+TtIdfPdRlxMOBRF30vzCDrQvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZOCnhEMV; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZOCnhEMV"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-825b40f8a26so1723135a34.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1791930126; x=1792534926; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KmKTSpwOIU42qw50Al/lTDECXTvDeMIBF7vVv/OZdxw=;
        b=ZOCnhEMVzvAqvzzmC4nvoLuuUg2gDlahIYFe5hGbc6FEQavPcgYAr9OGcFa0vQF04S
         94zMqSUfSfNJSAVubuLWjGLECJSa+kI5xMvyVbf94TjcXTBkRo0XNQ9AY/PRtQFxr0aK
         7bEO7ds+PNfSacosCqmcqsX5gwHx5okwATBFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791930126; x=1792534926;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KmKTSpwOIU42qw50Al/lTDECXTvDeMIBF7vVv/OZdxw=;
        b=s3WW6COXuxss1svySia75TU06TaUuy920AKDpPEnWMOJxODx1yGeTYzqdTGR2/qnQH
         SIQFShUaNVc4jeobjUeaJ8ADBqu37rz2Bf41yAej5FVRflKyUc83cZy5F7yDuo9xbUJK
         80bcUjXb8i1PmPR75NKDWNwK0bi3sP4lFXTPeUt2INSMFX6SgPuBnlZGLSSAbaLHFqSA
         sAXlNaP9IBIA4fpjvn6iZMRxh208Sf0DfJKrgvqfsXO+muI2uGn1dwIhmRddWb2pCGqy
         kTLJ8zn17PBlGFeo+0XW5xz12ZZl9tKkTA0gDI1aQ9miN/F3KeXlSixFckK9rc99Qip2
         b8gA==
X-Forwarded-Encrypted: i=1; AKwUvBy8BJ0m6gGmwvAB8Z11f/xn0KW1V7nL1CJaSr6VlzG1Qa1mzUi84UuJ8kMElsyhbJBGzsJJGII=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5JyRXdij0LkdmuonARIyA/OqNjI4ecJWySEY14sN9FLwRmZNO
	e9rwPbVKXCldgQc7tLNiLHjma7ydf7lbg+TSPhiJBmuZmburE6U38y7M9AJ5SC5n/TM=
X-Gm-Gg: AYBFou1Gbx9t+dN1f981CKi6kg018awH1VDkCROa9j1aZFI3NSLGz8YSQfv/CqzInD3
	8fDXAiiS1b8WKT8KoGBUp4z6R5odIlLNi2Y/6bJxWlkZNBsyaFRsnFPoPke8RKrhDBwlUV+BH+u
	bCBFnKv09aM3U5rRvlulWWJ5Z8K6dAa8FleixZJ0/ZfLLQCJsv42B67meyOQ4kl4al0ZKlx3lJe
	3KMb54sgjiu3SBRqKsjOPswPj8HjqU5QiMvRKsctSXLlj6cQgF6I036if6T1oIAMSzf5BpsDgWA
	kuRvBsi9KXQNriHk6SGuyhXuq39lgYaKdWJVjuRWHI8zSlPeP1ltdqYOIeERI0dQCgxhFsB49Co
	hUzSosu9RzeVfgsgpzKcCD3hj5jK03IdGg6Aygzk+lr0ZrIRTg1XskQVsZaVzNLpNgPVh/gYCtd
	pcSSagMxb4mgfzZkXCYpVuWH9Lp2aKQcCue5xx4k6rMmP28uERhxeZkB8YskxyHC+fFO7urKGy3
	KtVMlTjTW6qQ2+LeQ==
X-Received: by 2002:a05:6808:1241:b0:4f6:808e:3838 with SMTP id 5614622812f47-50c582328f9mr13009581b6e.52.1791930126129;
        Tue, 13 Oct 2026 15:22:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c0c5fe7d0sm15210133b6e.2.2026.10.13.15.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 15:22:05 -0700 (PDT)
Message-ID: <d204bc9c-531c-45c8-9959-9ffa1aa691f9@linuxfoundation.org>
Date: Tue, 13 Oct 2026 16:22:01 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2 000/281] 7.2.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261013112855.045212108@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261013112855.045212108@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/26 05:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.11 release.
> There are 281 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 15 Oct 2026 11:28:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.2.y
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
