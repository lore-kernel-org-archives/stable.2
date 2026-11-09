Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254678;
	b=i1bFO6WBNjAcw15rhIr2R66m5FMPt1BZLdsme3rlxLOuMH0ji9dCvPDeNU8gOPOyDs8A
	 MSoTIF4BfaHFluPBJ34g9y9oHmMyeOhC3w9A1u5N2H2rzvf/bTdtxkg0UJHNSQdseIZWm
	 4ddv5FiGTi6yE3gKmLZfwy5yNBhKLzQ5WT4mXV0WEQG88hj3ieJga1LPuz0hlqJasZgZp
	 //NgCMojCQV2YEOfC4q+JMRTjWxeIcXD/claML8E/xQtdOIIpwEia9Opg0L7hZPtjMHdM
	 LZ/YYKZQkVpbC5+CSQlgnwT6H3EyzxGpEMC3fpqTPV50yIcP0GYziiOazNsMuW2e/Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254678;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=xd+uOmFlCTqBx35VwbGKRTAdMuAG82Z60bA1tWcaoFU=;
	b=d7A4MbFx352lsXHVrpAO3KuVivXJKyF0S9RE99rVar5ek2w/wEoxE6Ul/lnrZpwjJyrP
	 NVyu8kE/W9MqX66jFEJS8j/cs8Zf/ECJAO7vz7OUD71PG42dLOCNdQMRCP5vVmV3X8eMg
	 JNZOKAedDjzSRPDujzMwea5RSl7ii/HiQRu0woEgSsAoiQEZnsUr8zfBrfLEXcmKTGF2c
	 mHOub6178sjsSJamv2WIi3uENDAZP6oqtdAGMi1WZ+BdmDGkmTc/k3QMzVZEbT+GzhzbT
	 uCg+5hJtJcXsesS+0TFQMq41szkkiCI7pVZN+rxtojEPOrsdwwpFAppt/bNU3POIXbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=blTvc6Bl;
	arc=none smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD92606A33B
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 20:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FD92606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=blTvc6Bl
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4911df1e196so657494fac.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 12:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1794254675; x=1794859475; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xd+uOmFlCTqBx35VwbGKRTAdMuAG82Z60bA1tWcaoFU=;
        b=blTvc6BlYcGGI6KJg5dM+qWKET4pDY1ud2Oj/a1unbJMmw46E+WLG8z9eFbr8sYS8h
         pOW6VbchIsKbbpCd26NAkGgZYp+1wJZ9Yi3P5BJRN4Bo9ib4V3OnYYoZx2t9/L30c1pi
         89ek8Eld6YRVJr+WCzwVvwHPDu5RtRs7eVsYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794254675; x=1794859475;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xd+uOmFlCTqBx35VwbGKRTAdMuAG82Z60bA1tWcaoFU=;
        b=QcItNWZ7+QllqailcC2o0Mom3Eq9ZALjauJyC4SGWIQ9ySbWeBhpRwDAekCq5hIuxg
         BV/xwo8zgfH/HhrxYfz4IhX25xfPNqwiZdNayBJHoSCBPYBF9YZ2xv8LK3BDLmqX8i5/
         Ui1a8+1V4iFJ8gjjPMkpTtO7hY6m5A8XTLGmXXY9rYI/NViYRvZM2QPdL/CDrrhdyn9+
         r9TSCx1Y/zzKOLLDpTt8uLu05AuDCm5T/Ryh1DEfBFlJcDTMz1LxfI50HmGvfFqbB5LF
         U3nh8Ol1RskOWdX+ATG1avQ4avZ6oYhMS9vgKIKceH7N670Y5r0ElMa2GuNx7QkaFabx
         SqWQ==
X-Forwarded-Encrypted: i=1; AL+hErEPN4BNukpQCT93iqELczlQFberWvVxrISR+mOTzNb+Ps0X0EqblmYnxK2+v3Axrlnm1FDjCvc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SwnSPGQ9W2QuL7u/dEcICgFAaYtxak8fuSi1vcPvLEdMjiIKq
	naQxsWSPrSrZ9YX3pxLUdlBPXPEJLxTWdlgWSvJ+rD8ghRhAdrLlESNPL77+AuK4HQ4=
X-Gm-Gg: AYBFou2H64h5FlJtf3YvVxhkBPNoUOdbFKSpJqlP4QI6BTa1xWAukN1vIHdJWdOjZZO
	YIhjGnElNyjXwdwBMsceBjNFBwptPJhzU3Jn1o2BKJouPmJDOMtWkPFREfO0alQR93MJVMu2MyK
	LVCTJbdyzRMHu86YiEFLcvOqmNgyKYVlNBrZBV99QteuyCo7A3XWo8uB83Q56uWkamMOlDlo9YM
	77MNmy2IME+4/1ooUa3YMV5pfcestJ/RBEawY6qzoBIUpauqhfwITyoBbRPziHBwF8uEsJ+9fjd
	3f4Phd1rItAtRAj9HgJq+iwPyO91T0pEp61cYOykPHAIK6EXpGMElfbQOc/WWBQi9CDLADZsLlu
	9F/RgSUkaIMk9TvwQteUtYCy8j+ZdHSYLO3Cf3wRnl8lPhjt1ixL9hQK17aBQEteBeoNGM/+iKo
	aN7MkJ09E49FwfoykU8/iGpgc+Y3eQaM7LQAkUAkEEfkhxynFW5aeVc2u7sTB3YKRSeySLsw1ZX
	erGV9A5Xfpi+gVm7GnIybxTQMlRwYv1IH1Q10C78MfjNoMKflHwQBo5wv45JLgvkdv1VDSm6rlE
	qOXzwSPcVTn13giSTnWJR2MWSFkuNcmWo0hn
X-Received: by 2002:a05:6870:b4a5:b0:494:a2cf:8dce with SMTP id 586e51a60fabf-4ae222eb9f3mr174206fac.4.1794254675391;
        Mon, 09 Nov 2026 12:04:35 -0800 (PST)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae22d1d541sm114412fac.2.2026.11.09.12.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 12:04:34 -0800 (PST)
Message-ID: <5dc4a979-d814-44de-bb4c-8cb8141a6f0b@linuxfoundation.org>
Date: Mon, 9 Nov 2026 13:04:31 -0700
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
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261107134852.069646174@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261107134852.069646174@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/26 06:44, Greg Kroah-Hartman wrote:
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
> 
Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
