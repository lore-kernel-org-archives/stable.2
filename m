Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608826;
	b=BruboPAJM68MdC5QZ3lm/Gh/HaNh2UIfFIe40IWTW3hJ34EL6hFSVd6InW0d4It46fYn
	 kRjidGH5AnCrPS57xwwUA3J0PvVJYyZZJNmcjqowOPUJMR4CSydyGnR1wKI2awYTzgORb
	 50axbLMXd4M340KLULgZPVoDTS2MbF40rRS1HdZTMKgvYlAwi0YjreS3Urk0lGLpGuI5d
	 85UlU3Lx4KP9Z/2rCwY43/RPERxmQSEOo7JxMm1vqsGIjpJby8irEzrP6GoqvFjN06D0/
	 ICJPxA9A0hXsjqAMlLG7OrqLuqbA6mazPXf9KS//TEXbSEYFdyqI4mwKzBTD+lbuvpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608826;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=8JTpanzVHjsYyfTqgNv/v2AlQs8qfVxkL+bAMQRdOVg=;
	b=RDbnDZn2ZlBWmRZl45ZhHw17PMSKomkOJVVWDCQsKnmq0KCMlUR1XXQUU/pRGYTfhMfF
	 LJw4/psGTn2u2hacVy87JJUsb9pLVvauWNqJ+RfhGfCOHb3W6Ef0Rxils3X1e6/2RMgsH
	 8VPfGJMJ2Pqm3by9BBqecRx8HDNL8sthyhf4BSGP2BhKS2NBI7Q43BtdjeoDjmCJajBq8
	 ri8Fo5ZSLgeu/yVVRIZkCHMstlBoqUv3QtoUorr1rBkNd4Yi6sap8G9zeWEltYHD8BGI/
	 u6cbkfxLdP1RQr6T6WcJJzCKk4CqZKTRCi42YHa8W8DodF/A2xjVk/DUf0IuO9k6ccA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=HTZmBt7k;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6D2606A329
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 22:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F6D2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=HTZmBt7k
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-862a19300b7so62934a34.2
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1794608821; x=1795213621; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8JTpanzVHjsYyfTqgNv/v2AlQs8qfVxkL+bAMQRdOVg=;
        b=HTZmBt7kVlvIFj0VHzxypN/lFbppQC6d/M762WuWYQM+v+gVMhPK0c6HemCCH1AY2m
         oOtHvuAofxZ6p7ijl258adFNAw2gUli3rZsYkdxCay4R6bixPoT+XEl0ApoLsL4DnRdw
         zPBfaAUrPD/d9bYFrJJrPhKblwwUr//Qd5hqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794608821; x=1795213621;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8JTpanzVHjsYyfTqgNv/v2AlQs8qfVxkL+bAMQRdOVg=;
        b=izjbuS0b+S2sVX007JKkOmYZQ28za8aVHL7e8/9a4U4eLkA7NcCeNPfug89UBTOinb
         mHcCAN1WbrPJooW8xzZO5cox0x4jvkXvfmA73NLWyx1FKwVmtkioNZeKP/CIccNjA848
         qhSp6pwCtr3jYh8aMoS2jD1MhSegJTinpf5ubrDjEmKn3l2cUrDMVX92rTvtpptIxFKf
         fhWDtvFWGTZmgk5oUs6e5WRgo6BJM72DOM2IVHmIGQpgP/MBWQT3hzABeQ6zHpbc6ZsN
         rhsaVBHW/AIG7Mns1B97tvwcMz3TRiGJDZBvQwUfiOuxhhM4oC8NwK97hcj2pLF3vrdk
         VSYg==
X-Forwarded-Encrypted: i=1; AL+hErGvvi/RrORJXVdESkPNpTOLczsXhsqTvBLvS0rfzbaEf8T6WOmUfBPp+AEWpz3fDwp5Q8SyKrk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9W4N3d4NG4zVmm6FGZx+dP50kNBNgVHS6JkbJ8U2/8C/pxCOYV
	oRV2AGkVMwJkDujrUb4XWLx5msIlHwRTmUehkoIMk7wUMJGh7nxCkvKoremRBF8pwag=
X-Gm-Gg: AYBFou2soVZdgVF5BgcjuF1k7jsRzS8lfPLOQTR5okL/6GVuL21j/XD9L75kJXu7o0S
	PI3N+oqAn0Qk2R09hvF3IEYgOMcbDJTqmj2KFFc1IiEVVo3tFOAANnwnKr3PE2UMxacnHmDCGQS
	IfySZNHcf2T+XoK2D9MjYyvpyXqT5hawlanS5K3WMM/G+3L064B/smcU75IgFkEUhgonOmUnH/d
	qA/J7NYuK95VN3fJ5FaesigKHqpmBXZhX3OUnK8FQSd01J9LjKuFOQYNbc9nfp3isENBbD3GU0e
	gze5bciqAVSaVuhu3ndNCxfk4ynHcsbdqTHT2H+79sJGt7tRW/HyBVkMkJ+Ygvx0T99mj+m4pJ4
	RFbDsYybRH0siuhvGxZSELNIaILjv9Bz8WgFM2jwX2+d2Xl75BVJPXi5vGYzSHucYnzC7t4gqAK
	aXGrxpafZTPGGeCpIA4y96bWRJ9VrMZR45eqs8f/ri3/7m2w+fZhKMHox9IzxukV7WUIP0TfE6U
	X2SS6ym5ctAaAeG/GKv7b3SaoF0ZKqsp2dPNR76wvyP1YmlJpp9q1z/vgxSkJxuK5Ms2oTHU1wH
	Q2JlYjgIXfQFAh5o4AihxTusvWerV4rSCKJXH0o=
X-Received: by 2002:a05:6830:924:b0:7dc:c7aa:22c7 with SMTP id 46e09a7af769-862895381c3mr4868916a34.0.1794608821646;
        Fri, 13 Nov 2026 14:27:01 -0800 (PST)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8628813346esm3412398a34.17.2026.11.13.14.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 14:27:01 -0800 (PST)
Message-ID: <0b626ecf-3c4b-42d4-887a-9b11dc473edf@linuxfoundation.org>
Date: Fri, 13 Nov 2026 15:26:58 -0700
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
Subject: Re: [PATCH 6.18 000/686] 6.18.64-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261113153820.902362109@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261113153820.902362109@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/26 08:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.64 release.
> There are 686 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 Nov 2026 15:36:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.64-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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

