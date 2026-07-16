Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A89F3AE6E5
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 17:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784222457; cv=none; b=KAM74DCSYmu+5kr1pYAWv9Vh8ipntvwK/8zWA4fFWplzDP2P3vq9Qkq34yEyiwTfAdDjk51jkWbN3WBk/OtGNOKKE049VYUorJHPpheVV1oKHmMktVBAKu5zGeZT6rhzfaJ7xC3cRyOr5GiDrdj5aY5OW7CigOblN+hBZu3hyX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784222457; c=relaxed/simple;
	bh=GWQfN7yjMoPWMWr6hsCcLjowPGOd3T/BfgrRBkNTggo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pWQi0UgOn55SBnd86znixt24CkrZ4rXy33XcuVifLibXa6nDm4OvMgDqzxWuLjrn4fL/Q1PYoF8H1IAPdZ+eQu7rWQgd5DmIZAbfSeQnH6uSIPDiY3D4+BmGhhl8nD/Eb6p28xCQPtLi/TEdTExaXr2u/3xMpmRcT4ewdBeSGks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qx77jhpK; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qx77jhpK"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e5b048375so473975785a.1
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 10:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784222455; x=1784827255; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=76cyaRlrxLbmiOeRadEQjvq34G1DNYWMPHzBVajJa2Q=;
        b=qx77jhpKFekzRbCUSCM9krz7W13aTXw+kqnDQKaIBYP6KQGjYeLrf39DkZmpCNZ1of
         EjzOOnWd+AuoJnvmbSc07pblRUBDNZsIvtDIDnS9rPw4zGF1FcjIZD/mfa4NC4OGOE5l
         whZ1brZS34I1eyQKCZdz3/PY/hsmgWUDNUwnA07vIGrHl4Ga0opTJDp9krxq0ywqntJK
         M9J6DDkhfG/JX+OJyLWFl8slB7rBD35XQvQCZtCQbWnV0/H1RT6+rp6yOguHJDr4AvBt
         pEbh05wngaLVetqXeR3jNVMgwGkb79bMcnpk6fjC0g3wvBQ2cxdTwrU1gNA4VA5fjzVI
         3Ggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784222455; x=1784827255;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=76cyaRlrxLbmiOeRadEQjvq34G1DNYWMPHzBVajJa2Q=;
        b=g6/iL0kB5AfUI1KM2tH+wS9aZ2biSh3MIxL7J7E6VvwytKF+NhbmgVKEWEmQBtCOm2
         GUnMzKOOVtFP2ir7O3VcbDxt5MEGVY3PsnYKjUOzTNP2W4pz0VQqSWo+IP7JEF9BrQXw
         DuOmC10gHCUxyxdkfsBvnXOE2u6pMooJyaGCpZvS0XUOb587Hws9Ic4JyxhJtnTwRncf
         GO6GJaADXfj+qCLsB4pR0SQlmHOKFOvBekOom8wwonEoFKnLS6uR8Rx52VWXetR/R3XS
         EvYDH8IO8lgOjridJjG46jlLZWH+Hzg33B495wWBP/V9m9YVzpUmQLRwyW20ghZ1Bnsi
         SGxw==
X-Forwarded-Encrypted: i=1; AHgh+Rr+DzyptLY78pkhAwFYKRyDy1m9JiN2g89w7iONt6cBnkqdmMe60vyYq7pA2FBmCev3Ox5quR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvKQim2RoTtA2GSuEVwOrMih/MEuZWObYWS2kZy2TuS5Xk03/4
	D1stneNRCLVb5CR3Cjs6qGx4KPAPjE/wKhvYBIzSU1U6+keoXbsqAWZo
X-Gm-Gg: AfdE7clkUtC0N5l5HEoU4hi9SF9kHJguIopWttnF4BgGay/Festv+H3xXqDphRvmUfU
	kQskgqpbhc1vmFAdtSaaV32dwMPro91QhBxqkNh43SSwF7GpIsGAKQCT5UWTi+foUfesulBUfoa
	9+b4zEjPKzsRQDtoNAGoAUz558gIrhe25a4xotp+LxYZSe3BMCVvc5jk6hxJYPwDq5DDKYjKNhQ
	nFKKwrxgvzsdMjbFefYtRSlSirgoQEQoLhx6aXlT1o6868Ik+opnDPvi2IyJceoZuBp+y+C1oVD
	AfYxQPk9JB6SU0bQPtJKnCxUusy1ylj3opmM5iv4SwC8SoxZw2T2RcC+2ZZ5yEuZ5UyY9FWMxIU
	3Q0hEhdECGRrO1QEl99WNVFe2bE4Mu6hqrOilQpgmCSXb86s9+bbSIACpWCWh6nMiF9Qv6BQhK/
	aMUwYGoM4yQUoQjzkf+3ZVrdYTuiaX
X-Received: by 2002:a05:620a:4620:b0:92e:fe10:3f02 with SMTP id af79cd13be357-93086bea8b6mr1312938085a.51.1784222454693;
        Thu, 16 Jul 2026 10:20:54 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b93387sm2197935785a.16.2026.07.16.10.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 10:20:53 -0700 (PDT)
Message-ID: <1827cf2f-2fa5-4d8c-87ee-58bb98bb0b3b@gmail.com>
Date: Thu, 16 Jul 2026 10:20:50 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/480] 6.18.39-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260716133044.672218725@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260716133044.672218725@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/26 06:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.39 release.
> There are 480 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 18 Jul 2026 13:30:01 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.39-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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
