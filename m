Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254263;
	b=h9bffDQ6xcdCJ5UGI4fKlg8wQyrJiFd29PVMMnD9cU3ZixZEfFJBOdVruR7nlFflyNUp
	 rGPDVxKhk/TLs0ugpimMEUuYfxAkr+hXq2IK3qH722+xYjO3XGcaQ04I7oHCKzpIrJVpZ
	 MLVnJda7IvMt/f7GhOQXeJbuwvTFkuc/enZ4j13akBuN1JvH05dyhrnBgZtO1yU16h8we
	 GhJ5CytI962EQQzlQ7cCG+up66qwBS2iphq6SbmjKxYeCUddw9+1vAMf8iIUxxdZ1H4Il
	 QOdl5qnGDa8RxrKECC7fFpC00x6ET6gWhZkKloGTf2ZczB75/qbagzyiPLZ+pw2V9gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ryF0rmPWcCuMTxrcqtqsxigxvgIcsmr1UjpxNs2pfHE=;
	b=uMoc5Rdf7AMrp6H20ORyVuuE9dwSaMwoLaLjhwBgGALEonoqKDDE/RdMDNa3xAPX21ks
	 z4bf2guUJq4T3NGYdEZFUsrDl3TncigvNI6t5kmLJIUhCtc1rh+LXjGU0Y5iCQqDQ6K44
	 oq5uwyzl7cd75kM0anUu44qpppAEuy9PaNcY9i/VZPiaZEnKn5ijhvx7aqJujj+wxvLPh
	 VynrTgABqslT3zu79OBEM2u3MWM69+SLf9bUEvQL/lx+riGuzJef9V5CzKOXTSOWpbAtP
	 GOxoc8To6Biwu07ssFTzmMMmW9BFZXs91T83cgpHhssgarAegW0K3b0560ChkitZLAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e1HJJ82k;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A80F606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 19:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A80F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e1HJJ82k
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93e55db58cfso110750985a.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 11:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794254262; x=1794859062; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ryF0rmPWcCuMTxrcqtqsxigxvgIcsmr1UjpxNs2pfHE=;
        b=e1HJJ82kBcWJUsFuMYCNVRTseii7BKHVa0wrxxYryqX81e3us/3alHzH1L/B9vQnlr
         yW8KYGSJK8wi2+Tk4w0YyOAFYpMgpW5iRSUyMRgNZ/UxYrkMf5oIgK5YqMYZB0xze5EW
         x+C1Uj47YCIiCL09Ut/UY5zrvIwXuOcujegS0ldMoQtIwoN4r48hY+UBmVuPmUmrezPH
         2nJNLdyFUIcwHhnKO+jrLqwmHGaeG+AOFIljl9Q4N374z+Vl2sQDT6+75qxP40MgmKzq
         jRuJIp2BbyN8jIigbr43JNqsVAez50rJPQOeVQv7MzOF5Ic/5jxsUPLrVP9yekQQL5JV
         KSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794254262; x=1794859062;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ryF0rmPWcCuMTxrcqtqsxigxvgIcsmr1UjpxNs2pfHE=;
        b=HWwt+Zfuv/GamV4kQkDbqcACRPQhjYsLfFrGj3nzSPNR6nMCH42spO0UEslQLXDjLT
         58uwvGL6MIsFM8E1Jh48dmd/Fu0U6kA+Au+lxdEhUGonbJuG5wtk0PytJSLbDpuYsr2T
         FBEXEkvVF4QebkArENUbOOYXoba9FxHBy875dHQMWortY9jhBcq/fP6OH2XJMPdVImNw
         ydOOkAXG0uCusoAKthQY8WZH7SJWEPgufEroGmnsnQKe95oABDwq39jDPtUO0kMK9tu/
         50jNThgGyr5EfGxCmZ7t+2+6NO6vxBF412jpj1VQT775VQ2BtiN7bGkEfaKAJCxSyhKO
         FUFQ==
X-Forwarded-Encrypted: i=1; AL+hErH7pf25sV84234crFeN5iA4zYYqMYA+KQ+kxz4mNymfXY0PfMtT5xYTcuSsDDdkUtUW8itK4Jg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9LKW4orWg8dTG48vxM4tTALhAcVeuOkSxIu14vIupVl8pwVVt0
	pMVVCsi1V9t8I6neDROo27DEohDWXgtRDIKpfxVD/+h2p6NYew9ulVKU
X-Gm-Gg: AYBFou1ia7h8olJC/vhUvieXMGlUdZ24s8ql9GTGf/s6Z/hczP7Yc3w0MNlwrAJzPXc
	1wkVsPhVekgnFdV9Bnq7S454/ozcVwKElcrDqpRSgpNsUqMjwPrgwZb5bnOoObMs1Ss4MqTBewH
	G8Sm8XS4YdEGBt8McxnBpyAByeWUgzNGEfLyqKYRNyuGfQ0N4ePq7cCy/ivzReS90ZL9pHa7YTN
	O9ERDZyXlWql7g54YDjw2ZoYPW760QkVByjwhoMrzq8NemqYwQ7eaORT477cSKA92UaXDUBB09D
	C9CuNZpALgFcZhB6crzJ3HoDdAOBY4Wb9EBgxrrWvYlWEnoI+FIvxFkXIoss+696k8mLGfipMgX
	zddFvmFBNLFJwqQSyD4rLk/tdNiRyPKml6sZMsfdqvMjY3p9D5dBPNa9dkFNfgGes5Cud6O5MQp
	0qkrIuxnehEPHypUksH2U4F44kz3PkQM713xX12Ky6JGrPcsQyuZKjUkl5a2eIv2qf9FKsgnc+X
	VV/B2O9c/TqhbB65SHXaqs6Aazh1/p7nRj+9Gc+eG/XH92R4fivhVKEHhtzkt3yYgCkZ9zixO+q
	urMZH2FI1ldGsInaVY5WiACGpnMnEgXcZv3BKJV4Yn1+qBbl+NxApHo=
X-Received: by 2002:a05:620a:439e:b0:93f:1ed3:a9d7 with SMTP id af79cd13be357-9479f2f0ecbmr86867985a.27.1794254261502;
        Mon, 09 Nov 2026 11:57:41 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e61b8f8sm54770985a.1.2026.11.09.11.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 11:57:40 -0800 (PST)
Message-ID: <4bf059ba-3a8f-4378-9f4a-b2704034ac9c@gmail.com>
Date: Mon, 9 Nov 2026 11:57:37 -0800
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
Subject: Re: [PATCH 6.18 000/869] 6.18.63-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261107134852.069646174@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261107134852.069646174@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/26 05:44, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.63 release.
> There are 869 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 09 Nov 2026 13:46:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.63-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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
