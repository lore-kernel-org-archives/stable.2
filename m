Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E8F360EC6
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784744079; cv=none; b=JJfWvqXqrG3BEIGF/54Fqusk8jco6KhmtY/wRAEaaus35HtVztTuJ+/oPzCRjRH1dq8+ZPqtALH3dVG8+J4izhV6vEhke8RTVc/8zH6OFH0V8yZqdAMuIF+cUJmuVWEVaCrTRBy6BqdRlTxV4VwNxjf+uG92x2e/mtRAAKdU0hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784744079; c=relaxed/simple;
	bh=nMt6B4/q1TBCAQ6F7lNKXLoEDYctWbQcqkd1+vkzyak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3UChCtGU+hPynZsscA3rNn+e7lNT02kxyOxpmnNcVuKhTczPu6jgFahU3XmXF0t5uZz265hE9QqBhX/mNLJBrvRPc4SIjkDMHsLk5u65kyvzXAMQOYxbs12u15X1433Vlr+ATLjvLODa/Yd4PquHhEzYdJDgwY7WoKKsBvwCXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pmx3zf1A; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmx3zf1A"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2caf228a910so102881955ad.2
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 11:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784744076; x=1785348876; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6f7oFf4DmJuS0FEyIve6i/ssgkTTmEBTgdClK4vAOoQ=;
        b=pmx3zf1AFv0MFij7FKBQdwFKCGIgQ5qTt/8QB8hBqLJgveCedHP3629zdHysJjusr7
         SMm6BTnDDYQiR9w7Pzn5lnJV4FhASL0NBNpgYIJMD/vcCt2mSKT0LlOT0PP+DCj74Hay
         as9NhyW8uZKreB9487frhK80j4gTBC2RQuI6owzo5pHEusyl5TgoHGLMKZL9mfvg9ueK
         67a6Qs53Pm1A/+rTZoj93OWchjGDKo+pOENYvaFE0LI+yXlcEhD9+3IGxiy2Tx6ycZQC
         s7LdtE8a5DsiW2aatdCFCxe+QUo+Q+3/TaxUXoVoaifcXUtseDZrs6akgfNPyQkVdlwG
         61Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784744076; x=1785348876;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6f7oFf4DmJuS0FEyIve6i/ssgkTTmEBTgdClK4vAOoQ=;
        b=iHdyFnr6sSiTeHtKK74mFujrVcMPlm9fqq5nXs+xwtoRGLLovU2YiXj8WpncuSJjMU
         7Y+oqD3w3x+Z/DmPuIrOtO2A/A+sJtR5akQu1y+44D9HqSymDucDYx+qYijxZ+bvPmqN
         8apNZvOMaMkLLXn1IfJxd3Qgnwt7rLyyvnuF+HyYcarvED9h72e+IsyEM6aj4FfdHwI8
         NStuE8YULdXq42wn+iONVr6aEMXBLOZQUcX0Q5fznKg8/6Z3uiSc7iiRzPNIGQ+I9QS7
         dz4vPzVn9k9ECg6I+d8Co1dGaNsxl/UHwrol+J9iYiMFxDOIxuZcNRsUkBkmzNWJrQAD
         cSNA==
X-Forwarded-Encrypted: i=1; AHgh+RrCRrZ7TvY0VZONPiPHN5R2h8YBcele2xLg9wInMhYqFZj6V8rdwp55m4qNELFZCciBwo0OWSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw117jobbFT11SyEuL2hWa6nXExca+rmGSEmnWfZ3zhjXGxGh2C
	84BFHjkmUhmRpZrRZpnGocdEpbjLTdJDfwQsJqqrL9oLcg4XjJG5/Oh7
X-Gm-Gg: AR+sD10Pk5a2xUYRZou8WujSTuHOv5NwIUV7EicO5m/hCK1Ao748nQHmYLey5TmkQzi
	s3KAh7Bh8qfq+n4yvfnXFT4aKn0LawZJiw6I9Ux99tU3pB1/dWAA0cEbsesTgvG+KWpSXCCpHLj
	LUKKM7L93iChX7hpXXWjNMy2w+4t8GSo+bTm2mf+qtCnkQJLEidZ3yH/0HKMWgOErBH9TrYGK1X
	By97gBnmLmyoG7+LoUNBJbCSH1OQQWkX0/O/VM+v2JWgJPxvfAondWUwuuEek2p2gY5VnUziYkR
	Fvh5cTnVjfvdGXDcZIgtyoBE5YhQK1vS20rxFErYuQDTLN0zx96FvSEWPqbLaMLv9Vc0Uk8LklQ
	rFio9kKIiKeEHsieH9kGUsQ6Vxyhx7werq/UP6iBlG9+W1QTmftFbvlZN0ZD3nVYsW1za4DJuDb
	yvhVp09GYSLE19Cju3WDk/cf7HkSyV
X-Received: by 2002:a17:903:13c6:b0:2c9:cb1b:64d6 with SMTP id d9443c01a7336-2cf348686a0mr256025365ad.19.1784744075796;
        Wed, 22 Jul 2026 11:14:35 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1bc886sm10928008eec.26.2026.07.22.11.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 11:14:34 -0700 (PDT)
Message-ID: <b1a98c21-f0b6-4608-83ed-63c49188a33b@gmail.com>
Date: Wed, 22 Jul 2026 11:14:32 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 0000/1029] 6.1.178-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260722143218.909123637@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260722143218.909123637@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/26 07:32, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.178 release.
> There are 1029 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 24 Jul 2026 14:30:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.178-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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
