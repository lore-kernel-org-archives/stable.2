Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBB6270545
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 00:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149001; cv=none; b=cPhU0WLKl/O59SE4m3Y4rsuYRiXJmbOqYDb7h69tx+gL1k5gvbkzuqy3w5DcgFsf3Pmtz5dTesghcgSt3YvqFiJ2wV3NdjZPtgLt4tAy8EpCYTG0lZ8LDaQRuHRIQ0evNA96Ts+yEySTaqeGpfDX+373zJlij1qw9wOunVBqIsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149001; c=relaxed/simple;
	bh=yAyhBqQVu6QGz8IzkGfgadWcrV4SoBC5FN9ccplLoRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LSmaZBlo20NJQCGtatCMVltt7jIuz1p6m1GCtNnlg9opHKcOuFFMP+X3vSbw+Q3vRWOU1OiaUMNIvwFyrd9vsDTtsow05IJrRIhZwi2kW8MipK0xflH/wL9AYScilAMlng5paHL+cDO1dJAEiY5J5z1epCyWM8kJRE/eQrfaaBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dhpYBX2Z; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dhpYBX2Z"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e9f1f24cbcso117413a34.0
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 17:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1786148998; x=1786753798; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a79a5YewEDc0g8txCKvKPP6+86xXxUuuEy9pmqNL6b8=;
        b=dhpYBX2ZChvp5WXAkP0vhnZ7XNzSQznBWxzXbvPWq8WbLqhkLx1lhMoXL3bA1nizR8
         LqGNv4gZ5lsixzuByKwTJ7v43L3rJ2Gm9IS83WRTG6CTrrGpnZB/rU2DnU+ZT51QcW+g
         2RzTXo50F+tOLQtGmksPxx8jbaTy7w3wHGI0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786148998; x=1786753798;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a79a5YewEDc0g8txCKvKPP6+86xXxUuuEy9pmqNL6b8=;
        b=kNMx8pZtdkZpfCcaQL0afCTJw7f8DYAw4PtS8Xj5e4nUkjJZciLHXRAxAQOUGoyiW5
         woBQt04krllhwYry9C98/0HtKi7yb+FsUqtRktecozzRQmUPKYTOaIwAvMakc8wW/nv4
         Z2m9/z+04Nis0KBsFpTe0l8wp/629s+nZOz7+/mcfS9aNK0JnRT61YwsxXJ3WICWqU6I
         S3zYcOc/8YyLqk8kGgU/xUgRQ3JuegMmfmdG//aZOfw6lnKSe/Q8FPYnG4wb9Y9XgbeO
         gSWOkzMCh93ka0qh73ilo50RUyKIZCRfADV/0GtMt+Le5z48bhJHAgCMfjY/wwiOpJ8G
         bXMw==
X-Forwarded-Encrypted: i=1; AHgh+RpU6YJIuYTr8Zve3l1vggQeNkBF5EK5rIk13tEjF5hjcBqdR/TSo+JszFU8iDkVXtj5MLwaaNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzZk3TeYVPw8vyEbHK+kkvFOn0WoSX2DrwGgBvF6dc8I9KwyfO
	X/LDX7XwL3myrpmSCssQ8oBvKWiOHbfOiVSsgUSGnTfAXb82vbrO0MQ+thKTMUVdWbE=
X-Gm-Gg: AR+sD134+kzs+PZAcC7uvT5JYYhmk455jEdaCNd5O5WNfYNbhePLMvlHDwCcgn3XRIU
	9hSczAlS5Hl4tWpdcmJLqkFBfzExJTZICLFHNjDjhGHRlJxankAmfgRqxANurtt1o6zCBUNE0o8
	MXigE+jKm6RyNNekBfFkegkBxlaZ4iWCBmj2pQZtnwg6Fjy6QMKuPb9RzBCl9e0sZQEurfiVIq6
	pWNCtVOTFI3CQFkUZU6yhDXo3au2FLVxq5CYGIKe70tl2JW1BgVXLutRVu1doGqUddmma3gWlln
	LGU0rycSlDLiGnlFkqNOgwCvMzk57PVgs22ryDxBBwqombclf1tQj5PRTUMWoHsTSWvmPWDjfNW
	YWDjimA7Baj/fCVv3mhxxs4tL0A2UHodz9I0CmwzT0OvTS+mUp46eu5FJ2Ju3JXrfda3G7G9vTN
	C5mAPALaYAcl+4DmiTyjsR3vfLriLc5e3pjR7NW32+bxxNtovz+HqnbDHNxP23SqgFRhnabg==
X-Received: by 2002:a05:6830:6c11:b0:7dc:cb0d:9e02 with SMTP id 46e09a7af769-7f36c1e22d6mr784775a34.9.1786148998616;
        Fri, 07 Aug 2026 17:29:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b5633f7sm2388646a34.5.2026.08.07.17.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 17:29:57 -0700 (PDT)
Message-ID: <2b15510a-a018-4596-ae80-cf3ff41b6f42@linuxfoundation.org>
Date: Fri, 7 Aug 2026 18:29:52 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 000/438] 7.1.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260807143428.008222056@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260807143428.008222056@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/26 08:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.8 release.
> There are 438 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 09 Aug 2026 14:33:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.8-rc1.gz
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
