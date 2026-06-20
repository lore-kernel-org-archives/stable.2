Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53673397691
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781971577; cv=none; b=pDrAqc1CBZFLm7SNpUmbqMQkZXTNBjKLWohBc3uyK100MW7QQRtv6NpquqiV+/j/LCdt4cFm98V4rmXRY03+HAB1F5zh4UwMtUOTdoKUoPXtSgvfBSSMqxDU+4sR4GP0VM/ezuF8XDZDirCL88DQsZiG2u49pAxBg0EcLzOj82Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781971577; c=relaxed/simple;
	bh=GYBR2fRvLo9AbAN9kQirI7hsgpWWk1FF5QW309PUpCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HOgRostBhskRB8i2HY8SF6rgCb+uyKtFDTZXLcghL9OkOAmuX+BXboQhj9LL+vjsjBem5ERZwRTUjziT7FYM65RdieQJLU0tFmwvULipTAnlCC2LdUBWhNpqL/ZUrb3dJP45zX+P+ycnbmmQaMXPZWn17FGDqRDYSRM7IH6725A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h01gOM9L; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h01gOM9L"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4908b92904fso40298195e9.0
        for <stable@vger.kernel.org>; Sat, 20 Jun 2026 09:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781971575; x=1782576375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wwI3Ux2mpaIvVIB4hspGkGT9Oouh+sNJpjf3AsIcSBg=;
        b=h01gOM9L3imIL5eBB1arkgNIHHB98NRj2fygr3kpYo3aPAumG3dw9OTX7S64Bdao0u
         d7C5Cy3dmB5ibK5B61ME/yPIOfy1u6NNnfmNSDDoE73qu/WD96fl2sUVNcxXb4FBJ53W
         MuQPK/QZORdiWl43dnpH9GAZJi4NLQFlWcJmDH1VNQf6N6fEVSl4+6ndcfRIGiqyIvyY
         EwW+s/n2MNOKpjXgunJhCL/IohFbrQoF6586be8DPVuCeTgl6iYl16Qg/HchhV/n6QNx
         eRyWFFkRCDezT/RKaqz7RMN5sdVjAKeDjBW6UrxVV4sro1LI/bDob6/sr3aSlqr4LqRy
         0FUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781971575; x=1782576375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwI3Ux2mpaIvVIB4hspGkGT9Oouh+sNJpjf3AsIcSBg=;
        b=YrH8t25K5cBNdPa9YwRGnOnBYfMMT560E8mduUr4noRGTARo/KmVWq+4YUWyNhOqNZ
         VNjwrCCZajP3XaCCwq1uwMJk+F+OZ/JhRr7sbyh6RYhAFyt5DVjOSFgEmsEnFi+GVIAP
         mxsmupRu+6/GSt6zm0OPAk9dfDgiioApz4SeCcIwdmAqjCMEaixJrXFjvSnQahg/NQ2v
         Sp6PEy4wS85nKX3UYgaGYKU9Jzb5xh0dUyyNwUdc2mG2FBuJn8R2uGy6j3xt5oSPUCC9
         QfRkC+Be9VXtkkFaw9ESkSmaIZwqAuM+J1RH5q1nKpvnf/I8oOQs+zVNuTNo8RRhXs/6
         pujQ==
X-Forwarded-Encrypted: i=1; AFNElJ8dYnZCjZP2SgG/9rvUSzQPgR58s+Sq0nml3uVe3ewXqmnoAwYsQ/X56SeFqNspUd5ggC8cMDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YydeF0grp8Rs1XWb0P/1Z8Gd0CgGHiAl0iKRBvbJi/YpeUty0k7
	VrsQyWZe8tc4Naw09ct4uWgvia2156HecCO4AWkobLuVG8T85CMhf611
X-Gm-Gg: AfdE7cl0mRu8NN+evEpMNIdOXP5G2h8V5zA8b35U4w2EpyRCcYMIT3smSrwReMYwN6A
	3kdb2T77LYJiuZ2Ckk2E2FNSbK4VxyuMZgEHDvHyTuyiGSZNe0UZEB1w2V/SelNmLiN11yf5g0F
	5W2ymfHPH3iIuPBi32wFx3TN/qxvaLXLWE/YA9iO5eXa4TYLn6ZgUCdjc8hl3WWzEN1A5dNusCh
	y31R8uMgCS0CLyy213i0ft2LbgjfKB+eE1SOsePDl98bI8JDCr77enY7qhv4ksyNCI+y4v6mV96
	iDEhbyalqSWjEj7eHgEOIXN7LyvGAtDc5gHH9QaGam90OBQ0fFoBbdchOvZV/h7lt9jc6k6HGqa
	ubRNBEqa8/yZejn9L94tXyjU3GMd3dZ5XEReVMFzY8NZswZ0Os6jZCxXL0cWf0X+rFL/Z2IWVxY
	ycgispDQmppJjgynCS11euv+2hPLUbxQ==
X-Received: by 2002:a05:600c:820c:b0:492:5030:5e7b with SMTP id 5b1f17b1804b1-49250305f4emr7110645e9.10.1781971574502;
        Sat, 20 Jun 2026 09:06:14 -0700 (PDT)
Received: from [192.168.1.21] ([41.249.60.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492494497ffsm74121685e9.11.2026.06.20.09.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2026 09:06:11 -0700 (PDT)
Message-ID: <989e0b69-8b00-4f6a-965f-1dcc370bee73@gmail.com>
Date: Sat, 20 Jun 2026 17:06:09 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.0 000/378] 7.0.13-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260616145109.744539446@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/16/2026 7:53 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.13 release.
> There are 378 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jun 2026 14:49:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.0.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENEIRC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

