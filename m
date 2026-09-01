Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E7243F4BF
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281229; cv=none; b=aJCkF/DgzeFOTS1XGsXfjSRTJQXxCffb67eDnZvcd0+rAqZE1+qZgKzXce7kGfnoqiW4/rzjErXnjFQuCInR3l8EpndLO1GLFNCdZuLtewDPJP5SwVcn0rac9Ze2XTpERJUK1xjr5QtKtmjb+meZFLOq5Gd0+kjBXWy5nAcZ07c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281229; c=relaxed/simple;
	bh=bPsnUJ6dQf379tAgPrkAWtTN/5CZ/7hAUIkD66QNzTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T0Gb0FLl1B2oTt6sdTqvd4fAJgGRwiXW5gPsw9VtjPXPlLAVwxpnLn8QNzwYe5DHOuN1CE5M+BBitZ7EAT+Tg4akAt3wc/I4Rsk9IkTG2WCKajocGOznJKvLSwYvS16mTEt/AHwS+OIzzRn0LLUfmCdcd7PCB3inJeJaapg+Uwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I1I6xq6u; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I1I6xq6u"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7eb34c17b96so4366175a34.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 09:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788281227; x=1788886027; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0UuquAVnKS8MT/Txp2C9I3pztBXGTrckd91hiHPlo0c=;
        b=I1I6xq6uofmLEV4swfbrVEhBWXLIU8nDO/YS8/WbGRjgB3F0MFfvDDNFzQaDrYm54r
         /+njLYB9OrVyXjQhwjdFaP7con1kGAQvA/rWxJW/FpB+1B4VvmaB1BkFv9jLuTFatdXf
         vAjGbjQpsDodbE2LFFe5GGGbhVo8JR8QKxy+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788281227; x=1788886027;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0UuquAVnKS8MT/Txp2C9I3pztBXGTrckd91hiHPlo0c=;
        b=ew6iTCN7QbCLQdZl9CHhVr+CXZUF8h1nwi0J9nMwpwJRMO4Wj+kgmwtgreafPlT8xe
         Qrv8MOOgVToKS4rb+3qILwCw9eUzgqASx//ylKH+tEduffV2t/tV1ysIfu/EiC+qBshW
         9qQYz1QUw8kFpp0nX65H1b5/JnLwKX3g6HSG6MUw4WVhR5sZFi0NyxtMEkG6VHQcMk87
         b5nifD90xZlb4+WySTzdquLbW1PNyqWBwRJrfgnRQYARc6jasFwl4JFm8hctd6dLoY99
         5WvdAtPfHahxwwX3jNcautsvHdCfm3JxnipIsrC4FdSHMffkD2vSnuqfcN4V+MbmWHPE
         uY9w==
X-Forwarded-Encrypted: i=1; AKwUvBwH3JF8foFR9o/ALIv0l5Cai887B9YRNJwC79LdYZBr5RKUNeAcy7HHOt17vTN5XXOp4aVYkyU=@vger.kernel.org
X-Gm-Message-State: AFuF++mwHZ5/kv6Vy5CTllMl9nNmYD+OtF8/ICYk1+aEBHrFDi/tFsDv
	fNi3EfEnw4x5mX6TVBikyx+voLhzw1JnvptBfoEXkbVEnxmvVViD/LoIoPdEfg/6byM=
X-Gm-Gg: AYBFou1iV00uJub2sFAY0fGR3rhtrIbDeY0+Sg+dRANy03tfblkWtIwgZMlAhra7CjO
	n8ry6FNrlzXkeBHPduac1TuATURYRHAwNItnLYNIjgmcTA54EW4Il0QFfe3kgSR+z2o6kFMBK48
	dI+MdKFhJkjvzl3rQsWCi3ilECzEFaBv+MH77aMnbe9Au4UaOfJ50+7pMpS0A/gSdvFGunYmPTu
	UWsnh1y/ooRaFN3UHjoMU3RRdk7Q81RAtSe4WtebJ6DmNwGGiz1it83c5MFs3NSZI0h4NEdG+UZ
	GDUuicHJWD86122KfX8pK0BUhHXz1I0NI6PoSiYuCbn7WCHqY+RZvQkKEeUfP/O8L+HFYj7LuZu
	th4T/fDRMjta5Mcg5S02VNI1BqcJ0IxIJw0dDyBz7JGagZLwlIJZIrmilWPK/IdFAdEPHdVz78E
	0cXqKRxJIXEHOSouyJVtfRyI4BQhXISowfNpS7ndzgkWsjMyt20vNU/h9iAk2+i01+9QvK
X-Received: by 2002:a05:6830:4491:b0:7f4:eb7e:c8f7 with SMTP id 46e09a7af769-7f4f2365bb9mr33007715a34.5.1788281226907;
        Tue, 01 Sep 2026 09:47:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4fa96ce0dsm11170515a34.13.2026.09.01.09.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 09:47:06 -0700 (PDT)
Message-ID: <a804f5af-6716-4f2d-a87c-ccdd4116c4ca@linuxfoundation.org>
Date: Tue, 1 Sep 2026 10:46:59 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/92] 6.1.187-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260831133359.482388899@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260831133359.482388899@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/31/26 07:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.187 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 02 Sep 2026 13:32:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.187-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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
