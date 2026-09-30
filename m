Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB286472089
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 22:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790809198; cv=none; b=IuyS6/XtakUv3EFfj8veDSzgjSYXvAOE81XGHhD/6UD0mLmto/5BJEzI6qq86ntflF4HzJLcxIiWj38jdWkAstUHNoX4UolDbk/1/PNxOVNRqT2hfzD7k9RfU+oQl6MP9Vg+fZ9PFD22NnQwM0mtc/uMcL+GairC/9kUbtuErHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790809198; c=relaxed/simple;
	bh=V/ugLR6nvLH60ejVCgRMpkVVC/3rQZq4w3LOwnT6N8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rbHVip2NsEuF9I1ezNWEg4rp4lLkgKNlW5BOQPd5DcAUBXh9z+GkvlR9TA0dkjRnR7J90FGpKjSU9DDon15eBgaLdMt1J+yXguQcVa62X5BRIxXFTmzw21N+73Aj12h1XcknQsE9nBedJ7PWYaWeO3vx0J5hsj5geEzRKUtAnYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZSRrgVn; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZSRrgVn"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-34c4a0868b6so259204eec.0
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790809193; x=1791413993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Or8VFCzWUmGeHAUNLqGvmA8mAzXjKCrijFaz9WdWst4=;
        b=eZSRrgVn4tww2a9Bv3lfd404I8zUvmg1GF7cORM5ZSkdeGnIQqGrsrFl/U0q67e1c2
         eD/NMyJySLUHuWstzYEngO2rHShepOWzb2p6dtk87O6JGCOZj9Xvq6eANstgE91i138h
         nXEl/fApn4hDyZywSSdH0lbck8hcd8LO4LrAiO8ZTjY5TlaPpZzbw2chsfEJqFXs69D/
         b63DXH3sqGD4dKuKCgnsYcofcd/DeK6cJR8l/qFHTNUtKK0mz7/R1S50RNukhRU7B983
         Gz3DfvScqTWQ8vVfF7jTiiLuEAmUlexXdAYivs5Iu27mght1R7Fs8P9Wa6H3xfAH8Dr9
         i+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790809193; x=1791413993;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Or8VFCzWUmGeHAUNLqGvmA8mAzXjKCrijFaz9WdWst4=;
        b=wbSGaD/02LgNG2pY4GuCRBKBpoxl+ITOTjldQzzM6kX9thXmzZcAxBZdXcczkwJJIf
         LwgiRWGIBrQeZioKB7ZOG8IAdr8iHVf8mGmxPKgE8erinMUeLOILy4O6+dTDS4z39OtI
         Fx+ai/zJIEHXSMxL+GXu+hjrdxcF2QKExXE5lcU8kuZQrvCez8ZJV5TjkteEL0o8hWRx
         u0NOTG9vZ9eNV/hxYCL6rdatxp7bhbC1fB9298KIiElZlbhvYCyvSI6g2cD8zyab/ZK2
         2k4WX87X8DKuisVYdtRRxXvs76qRvExazwdiN4gp+2+BOoRSJjwLcnuSIE3j40UhEpwv
         raVQ==
X-Forwarded-Encrypted: i=1; AKwUvBxFAZA8oH43yj63C7dxGqQortECmgl2cQSSJv664lQnt318gf0L41v62ibkcBggqtV64u1qc6A=@vger.kernel.org
X-Gm-Message-State: AFuF++lWLLiK190o9X+JyHPyqYIUN3usFyIBJehI2DEmmZPKH6GMqc70
	jn1Lmc0k8wFJMVrxNF51TaCktYhbhES8WG0SDCqfWyc/ZcmRvY3wSrMq
X-Gm-Gg: AYBFou248t74VB/Mq/7GkpFGwoWYYDzSoxB0sfmqy8IvS3KySCrTtyPHqLe8ySt63lO
	4n9aB8ihNYWKuipIsA/Kf9QthC9rGqtip3KjVO4W+A87d6+p4JcgD7A/+Orzrqobul/FuAyjjTh
	EqVNcH9SJMQCNtLpAwaP+JP5xVTpeFfUPrXfmXBqYcT8Z7BmZS+/3sZ1+Z8raVfy2fwWIbTgc7z
	P3S46Q51GcoLLyYJinRU4By+y7yygZeberx0zA8k+YqcyYL/BYzMeAiPwIEbedBJAJHK4TEa9JT
	a3xVFEunY5IsQthCZWEQXBxwuM098gqTVi1WC93JE2VaLdKk4v/CYMhPq5j3V8OxPpZnZSOWdol
	qevRJMc4qlc5tAfJWk/am4Zz2ViEqSABq1m5ZPoT96BPvJyBG/5XGdiDloHDs1WTGUKgdGBuCfn
	suW8Mk3UQoZF5yVP3cYBa8Hvd37ThbTv5+GmB2hOn9ZvtkYgBWZ6ZU+fONZgU25BZnLoZ+tgSmi
	atg63F7DCLWerqtvI0ASF/u7FoYXvY4RRtvpXvPt5DJX3VS8w==
X-Received: by 2002:a05:7022:ea8d:b0:14b:355e:2888 with SMTP id a92af1059eb24-14dd21269bemr841140c88.27.1790809193194;
        Wed, 30 Sep 2026 15:59:53 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14df359ee25sm1527465c88.5.2026.09.30.15.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 15:59:52 -0700 (PDT)
Message-ID: <00c2577b-e163-4f0a-a6b4-d067fe7c1f39@gmail.com>
Date: Wed, 30 Sep 2026 15:59:50 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/752] 5.15.222-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260930152358.131179731@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260930152358.131179731@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/30/2026 8:17 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.222 release.
> There are 752 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 02 Oct 2026 15:23:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.222-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

