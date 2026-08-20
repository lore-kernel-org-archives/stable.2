Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658113932CA
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787250517; cv=none; b=S8sRvRreE9fQjBgqqN5MMTUsg4M2EXeS2jEMrwlyUvxXzNc2vhTc6OC33VYfEDkby5YuNJx+ynKcq6m6J/ZQlsdj3iRo70Jwimm/YeqnyF8YfpG9G/qn/uptIfRpG8LZMVXyvi4ZvnPlZjId3JwrnvN8fmp297n8p7F+zVk4onM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787250517; c=relaxed/simple;
	bh=K62eQ1yWB1U2ESSd/iefWVhvrDEsPea2Q4oOaQaWyCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqPa0rq8ynLlkmxC61QXsOUi21OlA4W5MUfh30x/VaLj1Gf2yrT1zzotpEjLD0AxW20Q66WLIBOV0OSYZ/cT9mF0JEFW108t8vfDEb8/YlWSUQmawCVLThifW9lpecec7MYiUwIXwHhmtLkD3zOpmEZJrbngpHSl6J+pU8iwOHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZ04TffS; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZ04TffS"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8edda5d56a5so2103876d6.3
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787250515; x=1787855315; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7KHPib1wqWSdOYjSbO474SAuPKQRkPz+9y+jPIA9olg=;
        b=AZ04TffSzhZTNnyPMR/s8B895tKjPMqfrEw/SPbseNKqlAUamH7sZS9Tc8U6NFSG1P
         yji1cTQACa2bHTQEvtBvVclngx9qESLJMUOkj7ItLPwjDSgtwYnsSz3nGxa1hZgDvcP7
         Zoj5oh9/S5mMkgY2v5olGk4ReIC8IQB58UTkyqs5XG8PWouEXHGqGwJQT1wUG7+iKOHA
         S/JXuJB59qieJCr1X3wAqiNeFVFuChHW1vqge52L9Iuh4EsXG2RVF7VgUdNybq+Rt2k9
         oLm1b9RBjz1uokupQUqqlVfEpRajWK72LCw/nkHDoP0DLwRnaXQWOLuLBJE/bLYZjQy2
         t2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787250515; x=1787855315;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7KHPib1wqWSdOYjSbO474SAuPKQRkPz+9y+jPIA9olg=;
        b=eCSq6oTDkFX9jXbogW+vMWnRQBn5LBQLhzMbA79NenUqsYBGFPjQqs9RTaEOsqBGix
         p2JQMJASHwb7ISv3uczrQ1ANRylqkvsDXT8kisYFGQh/rTYM7696AUzynbGz50eWgsZr
         83URwWwTnSUhVrNEt5nl+zTlBbO96k7UXx/7vDlrhrok95TetDEeElEKH52sC3Z3W9p+
         kZxxJrxOJqt5L8NOojwreZIcXhgkrykTkYEgVAE08u2MJSuiY5KW+rAgb+wKmCNnx8vt
         JLwi3TBaaQ5HdngyivOyesZcF/TBVW1CLiSleWs+tNn4jd4yORIE4cXtv5oCY7VJpGTD
         iGfQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq/xb0AEDJIAc+kC9AfIzYmhgV0ZCiQ+YATlAZP6dTG8N9By4I1QqK7tlCHRKoSctKuvazi1tU=@vger.kernel.org
X-Gm-Message-State: AFuF++n2wZc/z8DlHT4rM4VYHFvVExzdj88sUDC5b1gbyT7UaIkiZ/et
	j715y45k01eI378nk2xLQEcD885/z2dXrZv7wh+/O8Xb/4EPg0OlNwz5
X-Gm-Gg: AR+sD11elRAzJZP8gGhTFfmY7qeEHGPYHRA3TrDAf6mtwQtK4PYZgXYkuXeQDF+UEun
	ZZ8kEoNaEsudeaY2B/KAGl2GdADtMJduHIolmioKlxnCfmOTB7P4RkVEs2HxqEr4s4x7jWcIOUW
	DMw/9tbUtD+3ZqBsA4ZaIMVWnZ6jpNyAIUeLn5pKrhQeSZSJiEGCEEiwJNP9S0ngtZh3TDXPOKJ
	7Q9KyjKnq2W3yaXnTeAntuuwZx5tXxYXZ12WO/8moJbelzd0NVxM0lDwLTg8rg6g/L9O1qBH7AE
	fBndr3NSXgW3cupfcCH0iyWo5oZj4p5KAS0Sx2/gGsdSJKGR6lZzcDEtsOtFYrrdvbIV0RVaQ0V
	JUFMAxwVcSFnoNX2zuKqPTRYqhqJ5IsyBTPXIFFN+c7uZph0D2iR8csA15lVLjMmGntWvzLGnrs
	5X8h2BBtQh6+vt6cLH1T4bsiUBVNqD+ru8K2EQTUbxRXhwY2ABsASmw1MrgsZEqTo6knBoq2Ifs
	hF0PRwmU0YJOVk=
X-Received: by 2002:a05:6214:c49:b0:8f1:d3ee:a8f5 with SMTP id 6a1803df08f44-90c80df8b32mr1076996d6.26.1787250515072;
        Thu, 20 Aug 2026 11:28:35 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5f2b5ccesm44072686d6.46.2026.08.20.11.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 11:28:34 -0700 (PDT)
Message-ID: <bc48a982-e8db-49fb-914d-ed8751570c5e@gmail.com>
Date: Thu, 20 Aug 2026 11:28:31 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/303] 6.1.184-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260820145253.200766705@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260820145253.200766705@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/26 07:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.184 release.
> There are 303 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 Aug 2026 14:51:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.184-rc1.gz
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
