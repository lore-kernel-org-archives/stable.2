Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794252271;
	b=tlyhooiAAgEs0Jn/EkNOQ4R9prny0PY/YU/s8Ek7gqnyQOE1D8ZJoH2qhumdzUrSShec
	 Y17CNlpuIupdyOjNaCMkgeoE9UipglrwNhy/JNM9G9GUGQS+W9wOxsbZW5+0cqCZODnoX
	 PVO5nerfG/TPpKvr+/lwDMOu6gyX3SIs51eQA7MzfqcqxYkC5BxB4O9wbTyN/+C7b/9SS
	 Xh7Deqrxy37RH/rJWGVR+w67KB7y085+cclVdQXLFLIzMIzPe6qvaGDZZWO0mfXbHzfxG
	 D+VIWXVeqVSZCP8t2ym418k1/QZ5ad6tgyG1gErvS67Rv91Q6bBYy2b7WutQ/aT1qtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252271;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=iNVyoaT8eOK1CmL3RYnHrqcQrx2W93eTgrazTaJ/OGk=;
	b=KzRGWzG3Wpcj4stYMWzjapLCdHHqgoUUqxFOdg7veJYnTgEwMNkWLLYZrFUYc3DL7YEd
	 NmFhxT3vyBhVumoTsxH7d6aaCeiM/dPCe/KoNaG4h2Q3FrpTQHwcm/P3rMEgSQ7vwdTh1
	 shqjF9VJs6qA2bErOybpBb3a8qNFmvxYBXdB/kNKDAV+IS9oo3mS5s6sTHwL20IQpBqQT
	 sEW4ah6FcANXsGI1N8P3Q7htgEx3OafjcdLISNunBD5+78nh7FO90P1I/WoCM7dGJDg/t
	 wCQXXqt9u4wMvOfcHt0lhTGvO15XqteFBK0j1N/V31AEnjEHhsDSX13rxB5g+nRYV6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i2YqSEmG;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB4560A2604
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 19:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EB4560A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i2YqSEmG
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93e635220b4so110404985a.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 11:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794252269; x=1794857069; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iNVyoaT8eOK1CmL3RYnHrqcQrx2W93eTgrazTaJ/OGk=;
        b=i2YqSEmGhiUgGCF1XKwbpkQT1UEQbidnL4mxV0S+0NzfyECkuvTGYYhppHzmBPSGXa
         06Ki0yVtX4umRmehs39A406GKW67TaR7zCLo1XaD74+wpXsqbVdhXnJ0VfU9HwXQejKJ
         9GwduBtaM+hZwCWEkK0hJoQ6HsIn59p4+QsFKH3jGbnKa4O3R2rY0oUQjxxcNDA352x5
         PEiE+t1VRsB65mmqKrx2LfJG3gSlFKwen3+FGLhzG6i7nd5LtX9s9vV4LnI+br5PTwb+
         E8ghXa9kQcNIVlepGiA4hT8n3Z8WRaJuSxxJE/cKns8mHxZkPYIbMyjE0e0NJG41Hbb9
         qa8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794252269; x=1794857069;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iNVyoaT8eOK1CmL3RYnHrqcQrx2W93eTgrazTaJ/OGk=;
        b=RFy8n8JnBecXhsf1rRlMDX+9xAEHeHaxw5WzH4BAk3TMPBMFw2aXXJTUcxwde14K/U
         WjLPdRVOh7BR4Fk30ug4SQOaqbAxBA3dnmnNWyW+J4gypg4+gKqiskEgfusNcgLxAB3j
         eZFg3BJjRqnpz+sYn0IFnxNv8x7NDa8Z6sDkWC5tCQ09gBdI21Q1GIKdl70OIcQb5SP/
         b82LGMKGdoq1pDF5v0Sa5BHkIk3bThOJhFT6TXTZ9lHXD1bOebNXgYT/hZFH9al4SDU/
         +7lncwVA3pROnX+rv6r6BAujGMtcWIfjIGIz/MqWu65kMqYG5N9QyHokMtnUaL//p44o
         QvlA==
X-Forwarded-Encrypted: i=1; AL+hErHA0toIS2EA20Fe06aGeF+JfWGUN6iwm+DSRJMGmpCO8txqNUVO96TN/T5wA/PF7IzO3PTWKIU=@vger.kernel.org
X-Gm-Message-State: APuU4Z96z3Wb+0mbyhMqf6IQIx1kBvNzLswsRlfp4v43f5N3sW7fn9iK
	UWLCcKEedO+YCWZ7pjfpYK1/celRwSDk6E3OxQruzHwojZRHGtfHPT7I
X-Gm-Gg: AYBFou1EdV1oZpADdqU3kgqVNu3GH881/mwru/VvboqNKyv93NJquk3pVDq0Sfekncu
	ChLGe1by5CcG81c5EGL7a3VyPZN6s8iut/5xVBZl34JVr8GcHlAQRiuY7SZiGvqZtZkowaJT1Xs
	zYoVm1ZNLCkzz8SN6GBXhXXh+WBq17oETxwbGvHBx1Hteoq3TGAisqPh0TrTnNTqcx2orsrDNr6
	Bk47ueXkD1/SJ3Uy2Y+6t4s+uGOVxY/JetkRW7CioUNfQSxElbmU2yvfYGazRXlisFA7BxuLklA
	LoWpB3i0pR4bSx6eC3+XG0P05epQJlWVFmHt1AGSKb2fjhHKQsaThCJIwSR9bGPpma+8WyYKfjb
	MkeQ96Ca5cyAy3f6hnYzLbsQdQtS5Cd9OpCrc+mQdxvINoCh+3SDcCY/NCJM737MRgL+z1Tsfhy
	NlaflZeiOLD0rM5hoG0vKII3z6SKA/9QvfFZ1oOfi6148UpeYVRAuOmfzvoC7PPN0MKrXKgAwS3
	n9QNIKC+dVlkY7jDveTGGidX+J9lLsWG74KnGSKLLoJDVR2TuXcqTBwk9uKtRsifQZ33PS0dY38
	tRLYDNbjnPn7oIm6p4qJERNAvjn+Ir4olRy+nQa46UHvmUBsYGnh+ag=
X-Received: by 2002:a05:620a:4712:b0:93e:646c:9133 with SMTP id af79cd13be357-9479f3934bcmr75883385a.64.1794252269384;
        Mon, 09 Nov 2026 11:24:29 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e73c9absm45460285a.8.2026.11.09.11.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 11:24:28 -0800 (PST)
Message-ID: <ecd48372-c802-4ffb-842d-73c689bca64e@gmail.com>
Date: Mon, 9 Nov 2026 11:24:25 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 0000/1536] 6.12.117-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261107134957.653319350@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261107134957.653319350@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/26 05:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.117 release.
> There are 1536 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 09 Nov 2026 13:46:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.117-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested with 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
