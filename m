Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56E8471269
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 21:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787000836; cv=none; b=rk+AYRE2DSPChHR4UU9rM2hCmtdWmVKZ9O+7gB7J9b0BdcDsqlwzxRFyyNk62YPdoVqof/vlu+pjbo4Co4djgCKUqE5/+wE6V4IJ2nmorThhrxKgxbl8LpdAMYi0mfKGUDqo3QDcO4TkU9tzkVac7IrH7k/jyD7aPe4HUCPGOuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787000836; c=relaxed/simple;
	bh=LfKFQ60MGbt3oQUU4UeDzk9gNNM573Bv+YOc2QstpIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/dMAAml/0KG7j7MUTQppiCk4b1QYKdCJplvQL1dkxiKL6ldmjavrPT+LLq6haIKLoDaL4hUTu4KD7fTGd3w3ffgOBI2AVTaflw2DsybqkMw7zdpXzUuZQag0vyBKbxlok9F3cMrmlC3g34Vc9v90vjqvxIBYE4Rvg4TnGSVg6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tJ1NTIx9; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJ1NTIx9"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e50a650a0so220936485a.1
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 14:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787000833; x=1787605633; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ys/YTvaoT9w4FLM9XG0rthYcw3gybAoEJJ0PsMkecBs=;
        b=tJ1NTIx9ZYlz2PBWLXPLZ07EJHwqCE5M9ZawWH6XnMYb9iKsrC8i9HgPf5G54UzTMx
         HwbHas7e9nC9AQG9I/fyhEqX4tqfpjLfNo8j+Kwu2bmxDtt6r9PvBWbWbu4dKod9/IlN
         M6B58JDU3NzGFEGaHN0pC1GzZX5LDx/Dm/Z+2NotD456AzbBe4wNIIowDzuT4ozUnN2r
         WJzci1NnEsLdnVkrDC7AWdCvGWlYdDq93yQXYaz2Ym+8US14iNB2oXHUL7LdTm7r5Z5/
         QYRmSsiWlBq6gBsYCJlzdjlytPW3tHHfchHiOd0I1+VHTSbuos3gBBzJ9wKfoV8lCn8s
         VREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787000833; x=1787605633;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ys/YTvaoT9w4FLM9XG0rthYcw3gybAoEJJ0PsMkecBs=;
        b=TCdATCPzugczeSn60Yds8TBLSXxgpvvJh9G3WXs6UbXOPKmCtDAwUJrCVQdUtVL71F
         bzAim4bCu0XTFt4p7jlZWSzPWkmPcwqo34AiJdl5ImAEPHhT0lYibXhh/FaNz1In+vWU
         L7e8naOX3qN78gId7JRpV6W24/5CS/aPS8Oip+rXzJCynvYIlGAR7TWHdGBMCGSfri6P
         gDUiJNn9jOvRPBYL2vG/zuFDbtm20uhXNXxS3KSp0bORrD/KLMr/yLdQir55PWD8CoZO
         ezzjRuqlbKoNq0Fj/94x9LeiKYB+6QjaUBu5A8FvVlVy5tKcb1qJ3xIMZPlMOv2MhGpt
         GFEg==
X-Forwarded-Encrypted: i=1; AHgh+RoMaWjig8JOCkqN1AH4qfIvmuKUFcRgBx2/K3f9s+HbQBsrFiTM7W8EWRtylo4TApbcXCc7E0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDCbvd5jZjd7VZe7WetouBfaRg9LNhlIofkGwjain2vkABRc/g
	TzB2bpw83uzaU+AsSWCNlasN06Bs+7yKbQFzV4BooK1RCpUppg2jeahP
X-Gm-Gg: AR+sD11EjxQAVPisKLrBFhxgejrFjlKnF+sYS7wnJn9yu4JQpC85CfWp84JSwLDm4U9
	EuiNqxHwBfXfjJhoFc1TqpkEcDLn8qFi5DnL98UxG9POhEotgiNnkF5JLjpZZsBLndKAiyvOd3+
	XzPcXebJBUF0CTyczXyXES8pKuEB3pkYVoi1HbfoDYbEmJw6/ixmbPummUdj3d5jXecB48Xjlck
	LAszh+D1DfhDYojp2cctWpKUSKFEt6jE9Zg91x9udeL//fX0ElZR440J0rvT1tzomyZdATrS6OF
	od1dayKFK5kgvatALpLhRN/WcYsepx/eEiCuuaBXwILx1bgVA3wna5SJU4zXOuZpFUXZXUFsNai
	mDHaUfRQK0wTNl+6RACWWqRrtcZZXX2ncSZG4MUJZShJ4JpW2DX/6wocHETz1SXaQGy4DXOFIv4
	+ARQ2frUzXvd3/RxWrMBNJaAMGhXjwrHa1BJF0OLzPpYvN7hrw7ZsfUOKw/o4C2DB2eQ5jrNMC+
	geshs15ZYlNQb0=
X-Received: by 2002:a05:620a:7086:b0:936:af34:ea68 with SMTP id af79cd13be357-93704bd0e9fmr362373085a.22.1787000833554;
        Mon, 17 Aug 2026 14:07:13 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937033cf5fbsm135628885a.22.2026.08.17.14.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 14:07:12 -0700 (PDT)
Message-ID: <82c7d4de-6358-4265-a250-32351cec0f3d@gmail.com>
Date: Mon, 17 Aug 2026 14:07:10 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/156] 6.6.152-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260817132534.666299318@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260817132534.666299318@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/17/26 06:32, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.152 release.
> There are 156 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Aug 2026 13:23:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.152-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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
