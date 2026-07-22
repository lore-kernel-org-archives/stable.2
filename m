Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E92636F42B
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 18:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784746397; cv=none; b=d05MTw6LoK6l8dTGXRWTlqcghb0AyK/Wrdo7U86jyuax8zyfUROAJhIHoYfG9HN/c4keFGyS4WjFqMUldhzYZrWQlCv9ex2TcnytHiz2LGl/QUw2aqwbxR2RK6hVPxXOugndPMYG6q/qjr/akZGWMT9JQ1xqbHR4Iqbc8GLa01w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784746397; c=relaxed/simple;
	bh=xHX2A4sv2rM+2brXiOgKVJbKrjsMa9e/4o1mUzXCf0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PX0FTb48Bvm/B4dvtB62Z7dx6/DcCfLHOiqXZPBlAVc3JqjhawdLl9a2l9c+d6lE4d7LsyujUUEt9C7XqicEzoolM95hQ+oiBFN3pBMqnxEYxAe0UYMyr2cMToMw9USDxprHjwIACKn8ZbjkWpl0BfMTo+bOXpq+YMhrMT/hB50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqqR+/O1; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqqR+/O1"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so4445300a12.2
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 11:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784746391; x=1785351191; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ya7nSRZ8mtp6nOk3koQyFUTx87xQOXf2E7S2pN7kN8A=;
        b=iqqR+/O1AjhuRZ5nIF+xcUqwoBq1crSXhONDKF+BsXPPPRc8k5LnsL8Bo7U2yC7gQG
         1z5ujCPkS7IKOqZKl1gAhNBJ+7XTue5X+vg55IvCR5sguajPyb20WACHFSuS1ZsD+tyG
         gD03DTGaKro/2Kg5Q9PQVOXXUVbpfKYfcYXya0ECPBZcYSOF27FXt+ru2OfK8mybFA8r
         FGGN45Cmkwmq9kvmhgP5+qzmOr9OAUfynAtA1yd1sL6Gzp7oAPLd3qz9Uv5xOXdgWqwL
         paz9pvsdd/Qu14z/TQTvEt53aryC7aIW1B0ZjEUTbeZ9OZOiAxiBFVRhQE11P+4Q+G14
         +z4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746391; x=1785351191;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ya7nSRZ8mtp6nOk3koQyFUTx87xQOXf2E7S2pN7kN8A=;
        b=LxQTKZYZ/6bsaCqqeAV1I6lZ3NzSd6/0kDKW5wOfujcve3A/Wrttg67dm3yh9JKOzW
         bQB4RYpOiuW3ji9y2bLhP57OhRoavEuIGR1knYjL17cawDtIoIZo8u1PRfADH5vHexDw
         PXFELVEhYMkJTUcmjncsOF4BC+GE0sdZ/dKvV8tPUuEX14uDZp/YPVK/voG6YnIPgxtR
         Qn3MIqf0a3Aeeu05eBYRbfI+32gq4iEOnKpWlk/ca93ip2tzXYsLwlRbphkRckpKSicc
         eeGH9ijbGnJ6rzmhmE1IIG2e3+SviRoJZT0ysFmwPGBIRG5fjJ+19qzpsieWrtZoyGrN
         I8Dw==
X-Forwarded-Encrypted: i=1; AHgh+RoPFTa+9SeiJcV8Mirrw96Z/rZABG8mxD/dk8bOBarNvVBlFFRZ8AHRWJhfhBetOqV5HjAmSQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5+drVrGM5OdcGlCFXbk3+8+N7BgeNpxGG6bABUdmr35C3jnMz
	qTPETmWXwrJ6hc4ca7iR12F3aDCiQR7KP0FyEHcPHZRyV+bkUYUpAiOD
X-Gm-Gg: AR+sD10dB8fCp29/7S6Ijtyh47AFngbhk7YLt1g4Nyp2BKzymoUw5dGgwoyIRJK8cCo
	Q435ADPdkXJruz0uRariwZOfGj/FV5NOL4htkHI6PBeAw0QjUSNzvyO6huEu/44a/tvo3xmo7XB
	vy/kmOPuMsQGoZ+Wy4XQKiTJbgnwEosAHF1747NtBT3RSE6OoRKTk6Ax9J05BT3dU+H19ccEjl5
	kNWSY2gTYfA8HcZ8rGw8h+9go/VkgwjjPgq1m11Z1qvU9sJ+FNxJuP1uzE0D5RJFepGWlW0jbxn
	7LNUmYfy1/1VsWon36hFunB5e+1qNg4icEjrtot44tXfMiWpSwC+KLeHr+uM8N1TWwF3vKY8X+s
	UwFdqhZuiktwre9aFcPwHx8Q+8e1qZx2xNkHfFQj4BYQJapFIVOHHmqa0MIWcfk9PI7RiUArct4
	hNwm4GNTWHIgObykxa//FZOEkd5IgcGUU2uEsJr3c=
X-Received: by 2002:a05:6300:2289:b0:3c3:a546:12a2 with SMTP id adf61e73a8af0-3c3ad975d93mr25752726637.52.1784746391374;
        Wed, 22 Jul 2026 11:53:11 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc8b0cdsm11500673eec.11.2026.07.22.11.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 11:53:10 -0700 (PDT)
Message-ID: <32ba501f-d37a-4868-bae3-e0c402c35fd6@gmail.com>
Date: Wed, 22 Jul 2026 11:53:09 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 0000/1624] 6.18.40-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260722142910.893804136@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260722142910.893804136@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/26 07:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.40 release.
> There are 1624 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 24 Jul 2026 14:26:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.40-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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
