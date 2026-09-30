Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FB850EBE8
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 18:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793990; cv=none; b=Qd3uRuaoE+453sWg/asCcbe51xlFOgnsncQClkmO01J/Vzm78H2mY1r7BNJUVTWe90FWwLKIv+GkBIRnUJ8BojxdIz6qgquoBdvhe3F0JuaQ8GukYvWPLZXV8miwUyZIwEas2A5xXHk52uK5EfNK81EGaRK/1DGIN+SH0UeCQ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793990; c=relaxed/simple;
	bh=/Dih9SrtItbcUH/2CE5n62UdEiJQyuq3ooSxlD3/Fp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3NRgVZHfTwY2GwC4a++Uksiy0eqt1D4QsxV2u3q0vgQZ9RnQnUM/AXUz5KPrHcHgEE5ONcUawlP7nrCrFA28xC+V//lWNuGXo0vh8mPMmSjQ+0VTtil+mCDpFAmnUTkBIPArmz1dPqVmSBNb6ggR50UjW9QIucsuwu/tUVufF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMFM3PT9; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMFM3PT9"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34c2a97ec17so1101409eec.3
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790793988; x=1791398788; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+rnVWzcL1s6imxSLl6Sw7NlkVC1rq2Qam6ENx2rJYs0=;
        b=CMFM3PT9jeyDDL5eKFfjwM6RVD10O9idpNDH1PoEzTRqxw8SOYDZMD1MUwE91NNrGt
         omSd3XNkPtT0A0NG3yNzWCCeLIW7MeiUYN/HDlCX9N8bvK1bmoZ+F2Nzvspxh5i0bfHb
         Wh1ji2Jo1HEmWtmjHt7xR+3FH66zS/CaZkV5yWdX4Qdp1g4P/MfI6VmThtvAPHlaUGqo
         gy9fmXTvUWSwTq3ZSfWn1upkdLi0aK4tO/U8vQtrKtzS9mlR0ojxPT/g8jqvcYetEq75
         xLDraB/3eaITXN4UuYEjaus5UZBgxD01cDgC+NO7BVjeG+PGGldtnxG2TbtpKy8bTAzK
         GdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790793988; x=1791398788;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+rnVWzcL1s6imxSLl6Sw7NlkVC1rq2Qam6ENx2rJYs0=;
        b=cRZqL7XOK1K81e8WGhEHSXMPQRJqFvud70JGQxg8n4LjexuEpPanfQiillogA2zPE2
         A/wvwNSowuMCxYHCSQ59NHUi1uyvPwVOMVoeFpmcVb7wGWYWfXaRRBA5ZUpmaPVct9Pb
         u3DTPHs3RgEKWmcRs1hSFPXUYe8+sm+AOPtMVFU1f4fq01aQJtIG0ZhsU07U0yXCKpDU
         btFfZVwp9rT3Bvgj/ZubHmjUnZXAGmTQVas62xPhEUbHi7c0ZUT9dPjdpLXF0qDG7T9x
         fU999sPxEacZF7ZuV3N58xiYEc+YmeAR6gEaT6z7b8NwIELhTU57kORjjyrNanKjlnvq
         Bf4w==
X-Forwarded-Encrypted: i=1; AKwUvBzuTArPS3oeRwwApkGxwTPK60Lcszo2bSDy5bx42UCc01YhgeX2YW1lmmqOvnsGSUkiq29Vrbs=@vger.kernel.org
X-Gm-Message-State: AFuF++muhxSNcyWQ0jqGY+MRD9vHefGJxggI46BnMP1UCde3n+viJQA1
	shONaxPe8haRhaJi2Ggu6RuqtdHKfTvyfO4aay3sUWJ+R4OHL3K+YGq2
X-Gm-Gg: AYBFou2xOdclEhKdL+Fnb2pZnYSkbgbO2jI2HYEh2EFgWgqGSYhK70oI+C8IWRRoMkf
	NKSMOQ0ho4pgR1Tpm1YnkJVS96eHwJNXoc2b89QS24Z25EyGw006lnKJUzhxMKv2yyAlpGlPqoN
	fIYO4L9+JtakCgpXSXmyT+64RUCijy9iaARPqIRo6+ftbxhXFnGFQRmXCRKvdeSTY96By8sgQI8
	ep9Tce9NHtQFk8R/UMK7fJan3kieFNekMtTf5Clz/SaXAnwmL8c/vYLeyUZQFRWe2Mci1xRgrp7
	sgnY8ukupsphp9z019K7hwXk/XWSHnkaQ6Llgi4VN9cBQwhaUFWQTSQIsaXxlXTfDrhHXtiEdDd
	xGiUINxFFOMSRIcy17vZwhyoSmY9QwBHXK2Gke3/2Y5eIDZhf7MvHhMEsXaj9vFKzRV4pZ5hMjf
	aPTtsrUqyP2DvCxdNM2L0YFXQ5/h0LLoNIMf84lubtmfiM3EXJ1TuIdbXaF4UebE+OIxk2why7l
	no0Im/NvvQl+gLGdSeKSxbvTscPmGX6DxRhrP8=
X-Received: by 2002:a05:693c:6385:20b0:33b:fc68:9790 with SMTP id 5a478bee46e88-34cdc3c1deemr2690727eec.21.1790793987430;
        Wed, 30 Sep 2026 11:46:27 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db491fae1sm814955eec.24.2026.09.30.11.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 11:46:26 -0700 (PDT)
Message-ID: <67c415f3-99d0-41aa-88b3-5e94a765d7ca@gmail.com>
Date: Wed, 30 Sep 2026 11:46:25 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/982] 6.1.189-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260930152416.775402466@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260930152416.775402466@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/30/2026 8:12 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.189 release.
> There are 982 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 02 Oct 2026 15:23:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.189-rc1.gz
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

