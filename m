Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387B33F44FF
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781715951; cv=none; b=GBxuWFFpSXz0CwQiT/WHsqD5AExhVCwRHNxd7af1OkqHtkD0POGz8z0pGS12HJ85nTJnr7yBVjvcQKE7x+hOSzZe6cgyU6ErnKbEWpugwthmpfI6qD2Q4LEV2TF+nriADWWkBq7qt4nBX4p6MFzmOwmAz29A8j1oPigwyf6T4tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781715951; c=relaxed/simple;
	bh=QWiUt4W65Yol1oqJQVCdl+On8yL1ocMTAIdDcP5QrmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mC9teQM8hBh+y6tGgq8UUmW1HZvLsg/J1MRStinLdhu+qWuosUB7R5hrKOuWbR0rrHWk+O0W3juyz7XT0lZZ+QxD4noPKyWU4fRaQ0v4HfesO449riLW8EIaLYwpq2ZiFfvyIU2kKz2CiRnwlC1894xoFQPQD0O0uF30+xteQZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=i5AX9sd5; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="i5AX9sd5"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4626fdc829aso36816f8f.3
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 10:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1781715948; x=1782320748; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u+aduyT6+K3d0mjQ176gNz47/6BLqnF1YE2F3LafYgU=;
        b=i5AX9sd5CnhUqnsURpS+U8t7XZgnGaCgfzqHqgK/Als1FMzqnrPCZEgYZ5euhMTiJt
         Um2X+Lr1+J7sCiI9D5y+2c0W5b25ZUwXctPn1JMj89l6tdnngdxIpp9ztsL0rN+cTHGO
         a5QOrKvJIbcGpeFIETQO/44S1sYfJjMeJryug1OXYITQ0RMW7SVqj680s1vIjShsdVJz
         TCQfeJdiDlkEIAjIU4ieiRAjhh4DoNniKsFcoIHbWiMudjEydhOBwa6jiqCRQQo5L8mZ
         KU4TwoFccq4ckYVmDz1zsob0Gnfa8w6MK6PkcessVN2T8hKduWIFAdkoAxhItN4h4Rlo
         AozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781715948; x=1782320748;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+aduyT6+K3d0mjQ176gNz47/6BLqnF1YE2F3LafYgU=;
        b=BvbMMh1wtoX29AQ1cQklvoVwBIIzDM/wsjRrE6C+m1Oj3JF72JNpXN51LlZSeMBx+3
         yM5BCx/mpDFlmewbpvsG3WAjiF6YDjK6zP6IPmeUGBaJkn+wdAjJJsOwqS3k6w28NNPh
         f/IICciWcFEGxONIs13mzpK96G6xJ6pt5fibtQEGv/l+m8N/cvczK/ffap2fVL/ctdnI
         6/OILlHvrcqPbtIxRJnxFgrA/9Kild7H4inqJW6txjj15UdTcKw09LZ1J1dPKWqkhbh0
         RrbdmbWR7HcN+XFLLU7bLRJIYSAMLmwzu5OavF/5lnHLYkgt7SpzxGDxLg6wJHHt83zY
         yGaA==
X-Forwarded-Encrypted: i=1; AFNElJ//y5SWTkmpjT1bTxntsPX1hCycbOgMorcXAKTPFIpnj/MgufaD4SPMXBWm/upkIH/ml/MOOx8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc/8Br/4Kft9TJUYknoXBljzJWKMkFWgjD3TZuBwyzboSp+vRl
	u/dYCxGRIW6GD/w2MgzI/CDIScyO8jZ7kUI3Lo+rTSZi7NMIiCCwGus=
X-Gm-Gg: AfdE7ckMVv8SQ9IoUTpukwGXLvhklFFqQQPbRO6Cn2vOOWa82TmuX4r/2y3UCSIBaE2
	mGKVy0+MDh/0vtwmFQUu59LN8IhElCiwzFm/8idosnETRPF33PsVkrbqt7sWO/2mKcLnTvYVx2N
	vvHbCgSefIec081qiXtVU+IsLz/DZJmGGWwglVDIKTVZH4w2YPQrmdTf4ur2Q3Jj77uquSJaybh
	WlHz+pe43Fgasf0Qr+GEWtlTqW+pwEoURB4YJLldiVh1tG/vxE6OmwiOBJEADbk6zLQL49vMQdW
	KmTEzu/nCvMV0ULueuQUXoEz4+B7y2Kl4Lr9VXHpEf/IZ3fKZn4jxje6U1eMaA5N578wbpqTLnY
	+Oz2zwsoQx2QQiSMhudU3Ct6YGbu2LKniO40W2zguxgqvNLUPiaZ7LqdvSbx/Lts+keY+APc0xX
	PClQ6eBuxgZNXAqzn+5sCHW/iaQ5LKSJTU9x4ul54Cz5rqPBypn9IlPtVKKMDmTQ7f
X-Received: by 2002:a05:6000:470d:b0:463:a7e3:9f71 with SMTP id ffacd0b85a97d-463a7e3a5e4mr178035f8f.15.1781715948528;
        Wed, 17 Jun 2026 10:05:48 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4777.dip0.t-ipconnect.de. [91.43.71.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2dbfb1sm58842472f8f.35.2026.06.17.10.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 10:05:48 -0700 (PDT)
Message-ID: <951a5d24-f36b-4ccf-939c-b741fb1b3a20@googlemail.com>
Date: Wed, 17 Jun 2026 19:05:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/261] 6.12.94-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260616145044.869532709@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 16.06.2026 um 16:57 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.94 release.
> There are 261 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


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
