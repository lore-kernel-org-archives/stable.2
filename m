Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110893C37AF
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 23:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783033949; cv=none; b=jbNnWsVCBH+68oPz392cGgWDekdDXdK8D8fuRzgXSylr0FR6r3kQ1k4lbju6JBvHAa5yiwNIjAGX7FRp0L5Yx+Hny4gmg1z/+gJTCzyZiOZWxeh6JEP+6jeBn74OcMppBEfXUfUeUGKdvK0fM4Ef6FKbDsW6TpQjmMM6E6UIG5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783033949; c=relaxed/simple;
	bh=V+VSp9rwt1yIHJp4oRUaIH+3V40CvEr4yIqWXtCk1ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1gFuhUI5sWZCeOlDNRP1MSus17AGYB57/A3bE93FKpHf+BAJjfuBGhqu332WR8IuwV8LEVQYtWw23LxI1rLXUU2878UM9dG9GKBJ6g5cZENMwjPwiMyVb8D2wkThPaF4mqJlkieMAvznCNEfLmdzCvhUcZyvsQPjpoChFgsTjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=QT/JMoHD; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QT/JMoHD"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-474e7ba9fd6so610f8f.1
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 16:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1783033946; x=1783638746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e1FNGhirFNPRK/vHQgM606Bnc9m4JLZSNgI9So7rAsc=;
        b=QT/JMoHDy3VF6Cmty6SJtXorLgvCDc6F5xx/2S3tiRR8cK4tHA9UK4WYhZfPo+pHrM
         kuWUJ/1ZzImqHOmLX63nx7e2usRqg7XFJHX4Xr+uxqTMatbEP4Pazwv6/fgoDhqLz19t
         MymEDEBXnDq4Ox6jJGC4bZA45RIvM+IM3pSih2p/ufA8wYzZaXvHX3fy5wnaRP2qfiaH
         Nqjoi7BBin0LcrI0aBSFgWq/XdFqgcDiHNjCWIpWp7NR1PY08VK8dGYu0Ac3aIVb4GMh
         ByOoumOsD8sRZpWI3j/vgcKGvHzkMUD+dwdiE/DB7P7Tel5TxX0pkJI/73ddpsdeRtQV
         CXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783033946; x=1783638746;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1FNGhirFNPRK/vHQgM606Bnc9m4JLZSNgI9So7rAsc=;
        b=NsBlshmYnSnMeaB3sC1QdnKkAzd9GxuTlEwxxHdUkGmCEtscUifoezwh2hCnMK0aTM
         xOtKvb/2kSiGk29FPOYR09r11rRKNxa++x8ehklUJ/bq+AuPlQ2cdddUAufOw2DAcyKA
         zzF9SAxbPja7Z6WcWVKZ++Ot9qrB5i84KHW6KblMMsZTm8jiKnjlBjyNollomC5XmWih
         j3f/PpsYpkT0tCoVmTjEy1bN9dk27yU7gEgBWYaGsSCaUCXre7yWei72RpHR8fis/xUL
         6f23R8AG75F3d3NL2OB1YKLGLRpABEGCdsDS7b3xIOnuIFrCPuzJ8PB2i28xfWtMQfpE
         G0IA==
X-Forwarded-Encrypted: i=1; AHgh+RpFnE9xCZOmCqFkvHryCwhKbFrHXk/rHd6FiKOdDaRDs0kVXFKZAz96m7rvmT+kfW1+asa0nJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaEUArsXooNG5pRbIX6zT+7FSDxS5BVdKs76wZJEyOszdFlwuo
	Lf4HYGn0DwACecd6Y8HCmMxa32ITpmyhVRwuexGhKOQJq4nNcjfQ5io=
X-Gm-Gg: AfdE7cnFn3T85JGYjHDoGupxowx9z4nE78Nu74/b3pCuvKjPNUhouyK1cE3iAr4U9wF
	7K4JMH24ocjhGlm1R2Ircq3tUW9oCX7ujsRqwRVRnDlMkvnA+O56U5P85oKM/A37iEMz6EDb1BI
	97BUdKFdbAs8Svt51qGpPmRbf34U78cKLdi4eOLDZfYeYB2O0FhnaBOaB0YAsS8u4zX+DEK3Wmx
	jL+oDuR7cgc09Wptv8K+1ike+rkuCG+zXYDqmKywVB1d7KSmPnZH8WAs1+KocHZvWITU7tnjE9G
	a2UFnMpROnqa7FFGoc2vQg9O/QGkdp5oIXdXaXtvL+2eP5h+xvvgal53F6sd+6dOhONcD2leUxX
	ayLmFdtWZ9yMCxXzrhNzPaHYjB+BYs17nVAadKZn3Yw6cAZNmT1wq+js+tuDD7y+KfH8nExSj6s
	/MZoNQySxH041JjI2F0rxfxMQcJHf3veNx0anENtc8PyytChjnLo6fksrNKRTUqaU=
X-Received: by 2002:a05:6000:27cb:10b0:460:71e6:e3b with SMTP id ffacd0b85a97d-47758db5955mr8723966f8f.27.1783033946248;
        Thu, 02 Jul 2026 16:12:26 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac307.dip0.t-ipconnect.de. [91.42.195.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477db8a4b73sm12539955f8f.15.2026.07.02.16.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 16:12:25 -0700 (PDT)
Message-ID: <075e465d-bd07-4fd9-8641-30066e966d07@googlemail.com>
Date: Fri, 3 Jul 2026 01:12:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.1 000/120] 7.1.3-rc1 review
Content-Language: de-DE
To: Shuah Khan <skhan@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260702155112.964534952@linuxfoundation.org>
 <0585b5ab-f9a1-4922-b2f4-167d0402758c@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <0585b5ab-f9a1-4922-b2f4-167d0402758c@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 02.07.2026 um 19:44 schrieb Shuah Khan:
> On 7/2/26 10:19, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 7.1.3 release.
>> There are 120 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Sat, 04 Jul 2026 15:50:58 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.3-rc1.gz
> 
> I am seeing 404 on this link. Maybe I will it more time for it to show up on
> kernel.org
> 
> Same with 6.18 link - haven't tried the others.
> 
> thanks,
> -- Shuah

LWN has the story that there was a mirroring issue due to a misconfiguration which led to the deletion of everything 
under /pub on the public mirrors only, and that Konstantin is working on restoring everything.

https://lwn.net/Articles/1081015/

This is the ticket status at Linux Foundation:

https://status.linuxfoundation.org/incidents/3y1k8b4ky71t


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com
