Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6EC3B6377
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 21:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262407; cv=none; b=RwrIlHHqnOqSfdvR8rFIYVt8E9wkV3+/WfUTEUDX/Q2Et09ZLkchNcKul81KrbmL1tq+rQJxIQ0tFLBj/sF/wIFETkshMIeBC6TLEWm9RoDuJ8Spenvx/QbDFyIIo0RJjf4NPV9msIqr7a5MnNELGBEGKDUrV3J9mYIyER505fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262407; c=relaxed/simple;
	bh=2lT6OB/GtPMoBr9FD1+AT1Nwzq6OXqGxFpN5k/e6z7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F11GhM6MnRB2SCc3FASE03Qnt5TdipRIfd9Yx8V/iFOa8U3xXaUN+YRu409gcGfcy9akInufKhBl4EDu40/eX6174VM+kuZ0f2YGCLNqdCz5vpGb9py3IeIL5zezSgtZYlY7FimXBGDsEC7Sr839oR+l5nLqc1gKM3HMYq65ItA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZHR+B8F; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZHR+B8F"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38f0f132f56so1015948a91.0
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787262405; x=1787867205; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mQXCqKcyXrhHXx5UzddqfNL3pKWNMmyEzCsuSg6E3xo=;
        b=TZHR+B8FGz2V0rZOGib72E87QzqotYzHa7JaVtIbD1Q9grgTq9JA0Jfya8R4szoQaf
         AKioaIDvC7QSBttO7+FZnZZOlnAiVemDPAAw5dzcpA8Vl/3G9Srr/Fqx3RDP6OwP2AwF
         S2K8Cnt6g9hFC7MXDXIxAN0dbxAixgTINrTFZxhoOu2wYhJXTv0CnlwYP+i7QcdJv/4B
         wxTT0Wpl7tb2FS+aAaswgou7g3EkCWtyY8F+CmTtn7MBQAJ0Ip+rg+hFK0bZZDKcKjOJ
         rEhl2rVZr2wcj1dVXUQ/Y1ELu4uX3/d+dAmIxAGsWxDIwnJ8djqc7vKXIHKpDJHKwYgE
         xFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787262405; x=1787867205;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mQXCqKcyXrhHXx5UzddqfNL3pKWNMmyEzCsuSg6E3xo=;
        b=eNF8kDiCPB9hj+R2X9fl4pyaa6uakZIHZZFQuc/vOvjdSoY4qXljuq6O7IrpedDw/4
         UBQcyuM2elVSNOd0uxy/hFOPbelR28zwYNSU6XMrq0PEDFXse52tRNVDSU6MejberntJ
         aNGmk8in34ODvOnJ3qEodMoqXG9wn1DHh9vZ8Vl3LmKLDa92vLJ6QcW1xCLeCKhcwiah
         7LoEeWgqiVYnunt9Z+7cPL3cW071hF/AOC9abANj/VghnE1V14ei0vTf9GTsxveG+6r4
         AyM4O4IDZ6E3r8HAQZEW5XrCItnkSBYiyfn4A6NMNqRWV/Ar3unP2M//xe8hY95oNyhM
         TnLw==
X-Forwarded-Encrypted: i=1; AHgh+RrACWt4iKb5UHsfmBwQD1G+XZnG9xAokOiDJTjB1+jAkCnio/2j9rqeGcnu4RkGGoEwJu/9JLY=@vger.kernel.org
X-Gm-Message-State: AFuF++lAahvS4005+3Lwp5NziVrPwHl/6/4gpV5SXNDPemxr64ydySkQ
	9ma4LYwhHEa16AuyXMfc1QNpLcecTxns9nVlMHf0HGWYXKCYNLwNIkgY
X-Gm-Gg: AR+sD11nLwQa7Qv+0bKtzd1N5bIVOeSiJSe2cC8N+Qwyy7rmBkk3ZSF5fbFNq2Q/mH+
	u5Mmu96xuqlx09fQeM2BWhTw51gh/810xexXECxt1yUO29hFTvpX1goZiz9if58LT+IDpWUGTec
	7/ZQQ7TJ9YjOn7I652nQrFHZDe/gJSmjFu6bIprW0ayMdpn5BXVM23+Xi1JgzUwCBOv0tXUpvjm
	pMWw/AAuou4Qbx2+pSZKi3on3PBisZzs7+tzW6wxSBJ90VwwmbKbuGxowokep+LNQ91GsQ9m/my
	v0RCXybtatPEKZGVtxduSD9EZ9yF/uE65A3jlejJiEszISH18/Pdyuktf1xpAa4HifbTkNERHxH
	qSI5ZrZ478XIv5kAkMlgu5srz4HL4uzjRM2YdPrhn7ZSFiSl9pV7DIle3H3TnO5d0hw+YKGFmd0
	SfeXVhLyA6LxRHRCTT9+ohaB8aZS7opj6Ax0LP99MgqJ5lecZ5H8DeXu18O2wYsnC797M3OwCxT
	LcP3XVEfeVdKfkOqPIzJ0QBBQ==
X-Received: by 2002:a17:90b:3851:b0:381:10a3:8b10 with SMTP id 98e67ed59e1d1-395a06ac272mr11204850a91.14.1787262404673;
        Thu, 20 Aug 2026 14:46:44 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327d01ff056sm11764692eec.19.2026.08.20.14.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 14:46:44 -0700 (PDT)
Message-ID: <2fec5509-7247-4279-8973-2183a6f0ac01@gmail.com>
Date: Thu, 20 Aug 2026 14:46:42 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 000/228] 7.1.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260820145244.450574346@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260820145244.450574346@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/26 07:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.10 release.
> There are 228 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 Aug 2026 14:51:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
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
