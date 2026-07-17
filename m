Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D6E2F8EB4
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784312812; cv=none; b=io7D7uwT4R/irfnNo3SA605oq7cOyBBEnYx6KuELUyYd5Ja/CoJegTwZfcZqIY2wFbsRApHWxOti0g9vusHDvjgoS0WAEY76ElP4AnXPtR/tKu1xokJEkt1q0M/SHa/FiqeHopaTXOollCbVb2vPYtBdCpV4ZV3OsAcO8y+wjJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784312812; c=relaxed/simple;
	bh=tKyySihkT20xIqRU3Wp22Nft9XxHtSfOyRrQ/6QIdOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ofZDkeoDcWFfWh5bDv56Rj4h2+m5WvVXB0fG8L0V4VkGVAPIjwLErv0+Ilmee7XxfT651A+LbfKNR770tj7mwLNca6DlUi9+GdtTlcOSiT8aAUfpMpxg6/8et59Gc6nmbq8Uw7X8s9dfrNQeLYRVZ0USxfV8m0215FYuw8UbbKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsghO3LA; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsghO3LA"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38df94d4dd8so3464611a91.2
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 11:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784312811; x=1784917611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CXC8PXJJavATSwTaY4dMubvNR7I9l5U7+WOoLpAqGuc=;
        b=lsghO3LApuZq2M8kZbYzEI5vdl5fX8hl6ycawS9mKQkhdWnWFRR+ZdRmRHQJLBleG1
         7xh5qUccHJbNWgxM53jKqvO80OmvFPjqVRJ97uqDptE9ap8KhwWNvKXcfKB5saE+Hhpm
         YHxIwj+qeDRXONZ+rzCC1ASuHXSXDJYYzxF9zpPwPPAJ0oiHvo7hCfvR+2occE8ciKv3
         J8RpFzORbom1Z85o0nExvQib1g9VjA22lh5qQpUG1T1eeFCGedu6mmEZOS16D8vO6WDa
         +GT2SpBHUDwEhznKA5Ocsav35PgVprJ17LCNZ2oCdBhEqyXLQSazQu0laLYX/18rIrSK
         bN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784312811; x=1784917611;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CXC8PXJJavATSwTaY4dMubvNR7I9l5U7+WOoLpAqGuc=;
        b=I3W3tsl/pzV9nkp0kNE1PnTMT63B0suqSnVu2FJg7QzRGAyn1ZTNciO7aIYYOvlD/J
         EuRxKDE2k/mYb+6WZAYbRUA4XOIb2CehU6NUaF54Vgzv3cfzD8mkHchIJ7VOeyeZz730
         zHScw7U8woIHzucI4JOHyaFcdfDptueiGI+/A7RNaf4Ms+NMklRa/KJvpH2JtReOHfo1
         YAyGgpSMRFOMjjgEVS7GzNBJ0EstI6pBD6AhLbLIwBU/spuVzRJ497BbPUIiv01j0i7J
         NePKQ80zMB3OihoISu3QBiYOGBEZRBwnRwPIO2N4Tce2x45zIKJiECwDnxVRqxehv8r1
         VGdg==
X-Forwarded-Encrypted: i=1; AHgh+Rpf6szhkaiir88D5UCOidWa7s1Ch9WEFSn0kZgGpB8iXyHnGFE/SD++IzsvunynN4aJOGVpiS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGNpf0CD8UgPNOBq52LrWlE86pSu0vOCQFJvHQqfoMd5rdqcP5
	13dOAz2f0c2cPH7vnpW7W4Vktrmzd4Hmced+5/Kl1wLIEmaaM2oa9Qsa4OsDJQ==
X-Gm-Gg: AfdE7cm5ggaxD9c90PS8L+Av0C+j91A7xoSKtcnNGrY7nNMTk7C7ByRc3l0h5pDEOLR
	hECYrYRTorpahGoUF0SdvD0BSJoEwx8mYoGlIOic0cFZp9S8h/RxTswusFRps98BF9VDU9P0wRs
	GewlpCMEA2xegU0lDkbcqM8mLeAw/D6NSDyViZQx8Nti7TZtfK2fWnU5mSC0oej4SDgmwsifCM8
	BLsZEa62oeGmlkGKCgYv5AepwEj2h6/OeUh2gDYa7oTwLhzP4KUaUTp6HcmkX8vL7kKgUra+/hq
	bB9PwjYOvw/TXvJprZjTKDl6+c0JzEPkyyOaG71ZNJrREa8YVg3tu96N+9xRSArQFT24gP28R+M
	AdzXxs9YPKWV5NfZf0atjN44fFnNfvTmoeTXaxGStZpncjJzQNImf6ID9JKDpd59msViWxDnv4j
	iVdlBQK0kxqpcbXTD6QpAfKW/HBEc0
X-Received: by 2002:a17:90b:3886:b0:36b:944b:fd81 with SMTP id 98e67ed59e1d1-38e4b3d27c3mr3989067a91.4.1784312810914;
        Fri, 17 Jul 2026 11:26:50 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429cf22b3sm9811189eec.0.2026.07.17.11.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 11:26:49 -0700 (PDT)
Message-ID: <7dab6f4b-e7e1-4df8-ac29-066973055f4b@gmail.com>
Date: Fri, 17 Jul 2026 11:26:48 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/357] 6.12.96-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260717101823.379399592@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260717101823.379399592@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/17/26 03:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.96 release.
> There are 357 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 19 Jul 2026 10:17:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.96-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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
