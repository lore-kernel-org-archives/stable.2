Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90D2480DC7
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281262; cv=none; b=DfzgNDJVs5Aq7AoivPb+6v7nmoGoHKChDZGJUEAzxABVmlzizO/0o7lG8PnQP44w+RrQr1/adw46bFm3Oi1l1o+Vpctt71wwDjI/d8WDUemJeh7jO5c2zlyuGQ9wbXdh/r6Bvjgg2r54JQbRdlVCgOFqzwfBaT6yFWkW1t1zdpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281262; c=relaxed/simple;
	bh=hXcx+zWej0g5jt49mEsC6y+RCbKQYJzwcUjDvMMMrbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rA56hQHZotCdKHt2Thyun8g/OTRo1BPknAnIxw+Tp22Uvd+gp7dNKr1nlfZfG0aQycVfLpvVt86tgjiVMS/HhvirJ43uoNqU96J1Ij+Fd2m8bghZizzoyqCymxRq0GFqU4rur8q6Sf9DLCoiENzK1p/+bicNSqzb7kMPb8SsfFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B3gt/XmZ; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B3gt/XmZ"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4650773fa99so43763fac.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 09:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788281259; x=1788886059; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2ZUuS5KsY6EoA6yaoBJmvArPf16bQqatmcGtTHp56E8=;
        b=B3gt/XmZd4m7f5LZ0Npk5/x4+N2o6zlNrvAEeNKMLQe3+CfKl+G0R8LlUHK0qBuya2
         q7UUibJFmJ3RcSzx/u7ZL5hbkE7Ldo0UDagwz8cRuklHS5Yx0McLVG9h9En2DEWyqyzf
         hgNzV/gcsfkSJZcutNmvnIBxWBGlU6ENURuA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788281259; x=1788886059;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2ZUuS5KsY6EoA6yaoBJmvArPf16bQqatmcGtTHp56E8=;
        b=aNK49ulUmCmRDBRGUAUAEGCK8O1QgTfg6OI+rskrZxQ99tDCibojAl83odqPUxVAz8
         h25iRm3CCCY+JCu4TGITNp7i8F4w8xvync5qgcEvg6u9TsPxDY1P0o4PdBDQLltSzhzs
         EgNOY9ECxVX82NW6xHyfC7pro5i0AO4FlOftnFcMKMKZXsdWW0H2c+7D26TQYmG6MSIN
         KYCVy3o0WVoBJeufV120OTNR/Wxh71KB8MXp9JjdmnHLHUGOeLBwH692LjpDWkd95XSW
         JxDSh0vzizkedKy81PGPyLLvYUJC4LGXbr1+OYnxDA75im3/l43kxEgu6MUQQlbKsuUb
         SsYw==
X-Forwarded-Encrypted: i=1; AHgh+RoB0yj14hl2qSogrhD6uPjjFvHGXKDjqWk/you26RmcbAaqLU2vJYEHy4V0NZQZQMXNTRf18SQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kTLmAo8YwI4RaZvrfYgbSPHLdj9VUWaM3reCGotv2n8t5zmoLu
	AxvGx2ztFwyTsJ5y2YHDYN1AmJd4LvzEO0M5B51aMeEH4fwkWkhK+zdSX0sLiyRNN/Q=
X-Gm-Gg: AYBFou14TvESyuLcENxnqPTIIuvJaMfyu3QmtFlr4u1bGbMMx6VfWLWleYoTthKqmk1
	WRUm1Rg88ldbb/l2dnHGOoLdW/jGDW+b06hV1uvvx+b/Lw/Y5lKTCnZ7eiPan8ZtUrIs/RJ8hCD
	+4P6noDf3XDnk31w96UrVWVaxiLSQEbSoucqj+9JQXR8d48pWIxEg866/i28r847WeWrD/fgCRS
	P/CsmhFXP5k3ZAonnoKw0aVB9TKr/N/cDAxKMD0a5FCwXw3GnLS8UmaurFksOHefZAjcrRi+tq8
	J5p/2b+WG8UQZJulR+o5BdHA1K4r61K8QltNYyS7PZ+qD3sfVsrWaKVq/rUE9i0Paf89+M0TbDC
	ckIqsGpppxQvCUaZukWj6EL8peIv7idqb9cOoravaeyj8P9nUzG/mJ78nPsdqdRzGsj2pQL0GmD
	310saP1jYB6Ix0EMCgCok8ZncsJMnKbuX/3MFe/HiROVrGsyaTtVtShDhDJpnbe1tfAiAz
X-Received: by 2002:a05:6870:8094:b0:43a:19fb:8b99 with SMTP id 586e51a60fabf-46af568c963mr9831277fac.9.1788281259524;
        Tue, 01 Sep 2026 09:47:39 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-46f2d4b266esm219881fac.0.2026.09.01.09.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 09:47:38 -0700 (PDT)
Message-ID: <aa5f3249-f81a-4b61-830e-f2702ec28d7f@linuxfoundation.org>
Date: Tue, 1 Sep 2026 10:47:32 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/69] 5.15.220-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260831133358.601894154@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260831133358.601894154@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/31/26 07:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.220 release.
> There are 69 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 02 Sep 2026 13:32:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.220-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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
