Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED1B429CEC
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324051; cv=none; b=lIKaKWdHQA7VpP13xxKEBdbEHvimFtJfyF7jl9c/gb5LbUSG40cgIIV6wzhHIG+xEWcN6HgJkNLCFGWlVdSP6w07bVlECL6/IBglUREwEHRogLlZzcc35ggIaNInTEXVGHlhW//J/G0BIVZJ5yZ0qfgLOOUFpHq58s5zFliPR/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324051; c=relaxed/simple;
	bh=+QWOHi4iDKzixCrf2abc7549MNGBHqZ+bmmF209jmrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kgaLWMgHNe+RnRQupq6vXQn0Y6otwQIpHnj2sha+fGFxBpKUenKB9PdL1k6L13zbbVHXh+VjVPUDLO26VBLxxaws5SurNnWp1owudVpibOCh7zpO9vI6xMtWw3c7hLHY8IcwxuiDJRzjw3rJF/NiUBSlEIkdr9cQ6qvTbIr137c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BstbqW5Z; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BstbqW5Z"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so15401665ad.1
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 07:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787324049; x=1787928849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3hR7JQQteGF/jQra7sps0X0N2A4rZsWeUn2t7Q0mVcg=;
        b=BstbqW5Zg6VjLE/txdM/089MPLwPY3XTpAtD9F3N/j9W9/Js4eZ5aLUuGsinnn7ut2
         lIGeJPqI+lpGcugjJDKlukGk0Pb5Jz0rrGECbmFEZ9LqiCbC+zQ9KmB7cGTWRocH/74G
         DAHdm8viM+0FYFg1Qh0aVjoYGcglbJFWd4S6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787324049; x=1787928849;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3hR7JQQteGF/jQra7sps0X0N2A4rZsWeUn2t7Q0mVcg=;
        b=GxDVKTxKniJRYtxG8kWCauJJloB8IaV71qNjNMG+VhkbMZJi5Bc5mf9HIL02C6zW+m
         NmzB7YWCYmFCXcC3UGvEbt+WXOu5GbQRdPhJbhn8YYOliFhRa2RBiz85uH/bX3vDkpOm
         y5O5N8VcPcHme/mre4rZxnworY28Mmgjbkaf6bGkF7c89siAWmOWxy7FAAyQkKeBpWo/
         VXYMV0OqSUcjiw5HSXWrZJ9Y4tFTzRmmawAV2/fHxUsiJqdg3pYvttv5NFsMbr1X1cUj
         9f7QSMWje+SxlixEXAM4X+IAYMf9vWyE8nQ7EFjSUbUTEBZFE5NGKdPbkUFyk3xquMOp
         bCxw==
X-Forwarded-Encrypted: i=1; AHgh+RrN/7X4NUiPjj0eTL2CMmwyYW9JlrwsOFyQaXtmv+VfxAbZMoedpMS+rj741TPIMv9KcFyeMRQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mxDMGXTMlKl2osM4/js2TKqzuufzR43hln4zvgHtuXW8MnuUpR
	IpGX057F12WK7i5dtRGapUr+4Iy8q8Fiw0yF3yxiEt6M/Dn0FsPe95CGbf3y7V4OVKs=
X-Gm-Gg: AR+sD12ETIKG8QEyDUBUUN4vH3KGFX0YZV4inO3xRPu+kK/bGsW0LPTT4doNBli5AWi
	8BUtYLPEX/0AxuZerwiKupcG9SFxNh0LdkInYDkDJZLnA8V+imhsq547wccUA4gK2virdiHADRY
	FA9l0911tJL1D3j18UIgoMuW1ZcSOlM7639ta2NehFExQk/6W92WdzBDSTRyhMO0I54qROjivXe
	OOmJK8/fcwYLHdJ6qiokYFuvTXVtelDU9fhQIa2tE5DTnwWXn5A/FgCqB2yJNDZaJGBjpKETghZ
	Gm2pxy0RQXcgss3mOiGtJSrzAfAup+L5Gryzg3fFXheIK3AFPlMqxWeHDkFKyGvskdoj1CxVwcM
	H2IjkR1M7nxJcdbPMTOekkMYoyZdoCl1mULLDyBm16p24aHEcDYjhmXgZJUI5DUa7tokOH0BCzx
	15ZezrM37Ge8XZ6kCBGf49k0vgDQmmVqKA8kmJrdiiPLBGEBuNAPtWkeJ/CsFp2pczq28K0g==
X-Received: by 2002:a17:90a:d004:b0:38e:2517:5d1f with SMTP id 98e67ed59e1d1-395c35ba4ffmr13492259a91.9.1787324048499;
        Fri, 21 Aug 2026 07:54:08 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c8e2d7e0sm1059140a91.0.2026.08.21.07.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 07:54:07 -0700 (PDT)
Message-ID: <a1d519d7-e861-43bc-b4d4-c4221387bd9c@linuxfoundation.org>
Date: Fri, 21 Aug 2026 08:54:03 -0600
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
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260820145253.200766705@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260820145253.200766705@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/26 08:52, Greg Kroah-Hartman wrote:
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
> 
>
Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
