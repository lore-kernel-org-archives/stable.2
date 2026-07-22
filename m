Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3EE421256
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 17:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740586; cv=none; b=d+NcEx0xXzLmG7pfubNZVTbNj1vBDTEe9obvRmhAYnuOvnrdXvo6nN3/FZPU1sWNyr5SUQYwYNS0mluNQnROiztHTzKycumz7yflkLp8OeY0peaC9riAmEdrO019/RwCFLU5qm3qjzz4xCW7qUhlIX2mj9KguigzJlHl/POnfIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740586; c=relaxed/simple;
	bh=kI484T49IdlFyKZ6ymqSXB7r/2MnN9NzxJVXNfyNpr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QFm7NEUFSZE0lIZpkCHyTop+LX6ZUN+4hpfW1GMrhxn7bf7/FXvZD27W2c451lu0LGDzTCwpXdpNMPScfIq1RMpsJ3SkQiPhcRiNkpwGDJLgLCyAHBRrlP3aH4pHm1KLleAtcrNkCjH4c94reMkGz6GL7+88TmGLm/bPeRkGSaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ALT2Fk6l; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ALT2Fk6l"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e6b554044fso9957221a34.0
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 10:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1784740584; x=1785345384; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F8i2hMLvis/bSEBIldeXCE1A3TzJ4qPXzcIblPSmycQ=;
        b=ALT2Fk6lhQT8kE8C8Zo1Q0MHh5JaIC3Hk6pAq2X9zJ5sPv6ooCggkDZy/FwE0mOt13
         mzh51VJhGTUHpii0yORHyazl2xqEaO9cLMsMnjraQILsBnGoHFNtq3xS3V6G9dIClvWt
         1lmtlRw3psyNvEQ4VVUsHr5NCQ5ov/cy7nfO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784740584; x=1785345384;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F8i2hMLvis/bSEBIldeXCE1A3TzJ4qPXzcIblPSmycQ=;
        b=HsTDrGtBT6GA99rRHJayRxSTRelnZ3tZqrev5rm2uSz3p9KQrGXljSLQdkwweG1PQA
         bXjFtGmBCrtrY52R9t6GFfE12lJiBxrpjTj/WJZKhUS/gfAhQJHds3zEC02OHb1aKtWs
         hCWf+giDVElsrIlXDfEMi6kogpAO9+XLRppsU75hux9b2VtkAaPwvBAmvZXlHQ3rkA6s
         +zROov9wK1Klhin7ZvebeaCD6DSi7ASlldc+D0quBPWT6urjsP3+RW+2KAvZJyhUqoN5
         f73yM/S/7k1a+ZhqZipQ3Xh1HB+pMdDvfGM3lLxuPeM1jrQWTV8+OJaAf5oOnkso7ZVZ
         xHKA==
X-Forwarded-Encrypted: i=1; AHgh+RoAsIeb0UEymrqG1eVITuH+PIXYlxbCa3LCObclZeFTfjvTprkiqkV8MQNTUDoxYRJyzSNrGYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YybgfmJwOTwYkME2mymxtOKjf35+zAYoDjUlzQdSJSm/NdieDmR
	t4+0YO799qBwHmL5WsK12q5V2cwZ2qFVrx/GbuelJ2Eypp8mPFQm8UbG78wax75jNqg=
X-Gm-Gg: AR+sD12DW5i7GnfPuDwH9dZxwwPMftjTZ7GXpKK1CWLYWhVdVuc78gdTogOdR49+M2H
	yz1o/cfOT0bZ+yIcp/Mx/6g+K3dKBR+1bIRTLU41bRLtNY5D0LOY1W7LbJXT27akF9dq19475+A
	lJlqBv9ozU1XQyj/4LGzecvxoEsDUP1QSZlC9fIPZ4KEPw+xNrLlZ/D55MCNxGVhQ4g/aq+Dmjw
	jx/NRVOdfOs0Fl5PoB6IBVI3Ve7kcebfM+AIrYnuS8+vt8S8oLfeRqAWMmX73DkrgnvMlUTBOTf
	aQOI2hHy87EXuoM8XPaiV7ojb61kKU6o4BmL1zi/8pZxzAZKkO8f1fElVJLXCaCP4u70MZVRcdE
	U2NJOFE/Rv6cjUH7/7J2hvZAeyHv/g8hcbz6BzTfTUf1HFUIRXeLQem2GYTuiuDktq23K0Tko3P
	QmnB8zDv/IunI=
X-Received: by 2002:a05:6830:4195:b0:7e9:d3aa:e391 with SMTP id 46e09a7af769-7ed9aa5776fmr12417851a34.6.1784740583864;
        Wed, 22 Jul 2026 10:16:23 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee29e0ec50sm1872169a34.8.2026.07.22.10.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 10:16:23 -0700 (PDT)
Message-ID: <01cf96f9-763e-4c20-8494-1b0388622678@linuxfoundation.org>
Date: Wed, 22 Jul 2026 11:16:18 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 0000/1067] 6.1.178-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260721152424.521567757@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260721152424.521567757@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/26 09:10, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.178 release.
> There are 1067 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Jul 2026 15:23:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.178-rc1.gz
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
