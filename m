Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AAE429CEC
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323829; cv=none; b=uX8bBM4UqHlGOM1agDaZmVTprIrYBo+pAXt5jOiTCiUy4KwrVABsvtX6g1FPotIjiFm1yHbXAdRMYGd7zYQcJrsfVz6hnw926BPZNI/ci8pdl/r3oJdNNa8sAERMy2ISGS/yvJ01hAs9n7Bj4rIvxqYwT3LlGimkssxZ9+FPT94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323829; c=relaxed/simple;
	bh=V5y9o7NMk30ephKJdJV+5n9ytvSBXHDxANwEOdnD+vA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eWoVuz/slCLYudJtvsNRktNTrm8opkB475m5joc6CiU2NgqdYOMrQ97nZQ0e7b644eUVkxiEuE6r73Jci1z7sTdK5D57oGN9VolvQ00njptWM7TUp0SadwvCPIaVyn9fBiLRghBJhxUEmqAAvwtv6q0JCTcLf+gShcksetSE51Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ql4FWsdI; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ql4FWsdI"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-44cf70de986so708223fac.0
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 07:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787323826; x=1787928626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I32wmWttHHzW4Q6gfxtgpGyjxKkIWFyf2W71REhQGbs=;
        b=Ql4FWsdI/k8WAOIKGSjgKDlws8hd3i8uFjmfPMy10ry+ozA7FJ+m0SANE/I9AKFXky
         kWzxsnWsKTUl+siJDjgxOyodPl15dyqaM57nJfPa0y70kwO3MSDHoiH2CAiRVEgFecvy
         fkc0SqKMb1MAwHmmnkNKjjedFZnj9tC5dZj6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787323826; x=1787928626;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I32wmWttHHzW4Q6gfxtgpGyjxKkIWFyf2W71REhQGbs=;
        b=r2Ih5eQLLRCT0eoq0O7qqlu11CUrv9m8B7omOff9nKopmrHkWI8byRTXJSCMWy2ROc
         aCqnjO7QixrmhQ8YedAx60z7hI2hRrLzJaPxFzjUXCiLQ5+edG79FyfosD1kRJxS6LIN
         2duNs5m7OyPpuL37fyyJxwZOIYfDth4GY8ejMLKqtpvVc3MGhROvjkQ1mfqqxyk4y+q1
         32iadwJifLMIorWVWoNYTWuQWjojVSjbhR1rJHkSKzLvoKEQBYuSn5+xOO6M7Drsc1Io
         dELTerJN72189dHwScxx3DEvzRiOBch1Wgn/E9c6ZkYEIHSEmraSLmYq5F+CBdoXixB7
         oStg==
X-Forwarded-Encrypted: i=1; AHgh+RqVk1cR6WYV7zavCOzPnvfLDZrKAgQ7Rp22rTyMrvxwdrF1BiuHZN6I0MQCoTDGhwJO5/4u1eA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnDOGJVrXZ3NudneXBqAoqmss8ZHi9eQbjabiXLlV0aIcuOnme
	4R9Q36xwd8q4xr7JyOVvw4j01QsOka/WK55xAEozI1dMfEs3u42E4k4uQNs7lBnix4U=
X-Gm-Gg: AR+sD12tjCjAqbyZEv820cObLhp6R2vrCzD9w82jgCCsf5H3orGqgoD7Fmy1XWA0sz0
	oh0uqA1JFPQinykEYab/ZYeE7xysYCHz6YlFrCtYkq12JX7ehyHT33yFJD4WN9oOogKogyjqPWu
	V0QI6A3LV/p1SAdmxbpJdOs5D3zgKR3QVkFZj5XyBHuhbX+R5As6J1cQJWB9zS5D/g/UY47qjjL
	m2wv/YO9Jx2QhXeyFF+z7mQQjAG1D/hK0c14P/ql/ek4uU0mrCHyCm/TZ8Ed9vtUQa2cCp+oXnn
	k27+Q8c93z1AXwsLiIFugIUFrB7ALOaCd75JIWuT5tjJgc+kV2UMfcpSttdNEY6adzlmCPRgOeu
	vwojfOOLwcHlm3topSCXy05MpKlU6Sw219VdG/XknoSnfC7m+0BkVNa1V7st8qdNDAF/qq+f9jB
	P/rNycVk1/qh/Ac3bF+L8Aad+c1iRAJsuvt+1qG41fGfcXf/MMcUfIkoUvHUlTDC4rUil9FvQCM
	uS+N99v
X-Received: by 2002:a05:6820:a511:10b0:6b1:4250:6a43 with SMTP id 006d021491bc7-6b159411a9bmr5136915eaf.17.1787323826434;
        Fri, 21 Aug 2026 07:50:26 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b13cb557c1sm8758083eaf.2.2026.08.21.07.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 07:50:25 -0700 (PDT)
Message-ID: <86155abc-5a4c-4f48-b49c-54d7f005089b@linuxfoundation.org>
Date: Fri, 21 Aug 2026 08:50:22 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 000/228] 7.1.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260820145244.450574346@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260820145244.450574346@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/26 08:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.10 release.
> There are 228 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 Aug 2026 14:51:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
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
