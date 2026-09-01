Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26253CFF5A
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 02:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788229855; cv=none; b=pX+9Xmme9KSxMRGA+o3zUuLVLkGiU/j0lXfXGwB0cRDa4SI/TDcAkWMu3gahoSO7lVQPhdbsWJzxKZK2837tM+y0qZGeJUXCnBROZoPrecoxSaMBLVz+gGSE+NyzLWLiFRCVzl0tMo2Jg240epHdeFPOmc4ke2H6OKlEu5ujwTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788229855; c=relaxed/simple;
	bh=/BjsPLH+mUGnMYfx7J9wd0WyRTwAYMQMWUKvt3WLG3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UyxyPsUDIJj9Wu9MJrWF5DB/RZnSX8W+6SE6mpBOL9VgH9iDbIvc9CyRX8FFDk+J1YM1DAOyuQKceiVZzq8OZ3iYWfBhyPMPYYQo3QAptZgwy3y+eXqMdzEHMQmP7W+UMrZ3axxuoLQdg6nAavcqkvblksG67ct1aRzQ5P29/2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ce+HHwvD; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ce+HHwvD"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d9520b9155so3521365ad.3
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 19:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788229853; x=1788834653; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QamTYhkNj+WbJDRkMGOPRcQWDLFJdElCHgizZeiu82Q=;
        b=ce+HHwvDnJn84VwCn/TFRPzfVDlSpJ03FaoD0N435vIKiz3xQa4M8FHG0utnP08Uzd
         q2xK6O4+HT5qJBqcxXXp7uSpEGllagpSoe2sgCrPcb/L0h3RqcIMJZOnzLERq0PtUCXs
         TkI796O2kkndNaFZki8QYg+EPoZnM46sO0O2tUh3hYPUuHokEO/1/QT7XTRGnHJnJXKg
         xiYoYi76YneEjKvMqmSxgcTt34ukJXgpd55bJB2SwWvbVeCnaH94kRe0smcGdYQiq2mZ
         FZ9UzEkB8cp5P44hpofm3Uutlk0V6nzqnjfSg+gmuSLAGtPNxMBu8g9xGubyy8zE2bGL
         3meQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788229853; x=1788834653;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QamTYhkNj+WbJDRkMGOPRcQWDLFJdElCHgizZeiu82Q=;
        b=RHzTEua2JEpTpNtGewTpGOCB4vM3D9bk/VXOsK25IwO1Au074wyrXgB4oXd2G/3Mtm
         Ym84ZvRe4BdR1hoYWefrlyTEgvhSkX76A9Z/mvuOGaGDuLbBzjjRVOwO7oXaJJJGb1nb
         i3RNOt/2HpLiIbXDWkbTlj2fYX/e41qJCIUhYlKXIDhBZHg6lYuVYBUb7D1PkFQKxwop
         uX4nQ0DvVzLkD4A+udPHczNYvo4qHk3ma3TrGqZ5lK4ibx3lgHfXRxjjtqBkW2uaRAtv
         BsaiKGtMDlfRNX6waS9+KLZ2+fp8gO5jYF9OPZWmH8Rbvv5s2TE/eYoyedrRo163WuJ7
         sjkg==
X-Forwarded-Encrypted: i=1; AKwUvBy0kswT05C6j6IxdLYea7u1GureyxcjCRSktx+15fJvfkC/u7glx6VTR5xBCdpC3oIRyKAPFaY=@vger.kernel.org
X-Gm-Message-State: AFuF++krbeISrNeL6wzItkuFS4Sw7h1aewtwxGeemNODbEDx2NifU9VI
	9meepyGBr1tAR4EYJjpqsvIN/CXYc/Bmrbz/j1ZOkFsIGEEctK6VI1N7
X-Gm-Gg: AYBFou2XRsHq7Sv7fo8H2HOF52bCNf+Svk5TS2QIYJ60XVS6gbH4VCNegnAfGmxyuqH
	xuHyBb96G8ElN7BCY3F+hJj9NjAPCoRTkts27Sl57+EVYQVH0x4ekvlGcAmLr10EPJFEl4n6Cli
	ESz0n4+1ERKH4PkidyBoWIgYyOBSC6+GbVD23ix/4LaHH2k5khNqJHonfO9tk4aR6hv0NfSHXmt
	p50fw1ulyRahUwUURZfOLAqIMS1x2b9J8Bjak4RbZLQDzBb+ql5EY4yembs8WVStZiAgFV14+yq
	bUizfEr1foOk1cazSvZdUtJSznIFjh0fSW+gB3iwAWxTWcrG5KBOnkbY2BlAamS2PvuL4AtHDAr
	2MONI6L4GqHdIqy5GDPHC3noWuHpd7UyjuUEyw2Xvq7y8NO5pnCugKKb3+bQxm0ZQ2kjS9LynxA
	MKO7aJX9AY4Ya7eYd4AsQ1LUXJvFee+JmXHgHwe0LNuWtL2xTkKfN9dAkcj+mFs/64hrwpW8PkC
	dJ4LBuLDWnpqtIMDakIf1ZIwDNiAw==
X-Received: by 2002:a17:902:f54e:b0:2ca:61bc:317c with SMTP id d9443c01a7336-2d74def63d7mr477797405ad.13.1788229853041;
        Mon, 31 Aug 2026 19:30:53 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9ecaa9sm35043673eec.26.2026.08.31.19.30.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 19:30:52 -0700 (PDT)
Message-ID: <68bcf2b1-ebd7-43d1-b2a8-979e6ddf4c5f@gmail.com>
Date: Mon, 31 Aug 2026 19:30:50 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2 00/71] 7.2.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260831133359.055927882@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260831133359.055927882@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/31/2026 6:33 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.3 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 02 Sep 2026 13:32:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.3-rc1.gz
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

