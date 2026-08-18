Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF02342885E
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076191; cv=none; b=qNH0qETrG8B4IfREyzXY6S5g8t+cgUMopkYpys8UfLexYl2RHw3k72orUA2mdmP27P+8nufXMDqCVv1b9BE32PgQVUVZHP0DhWpDgvFhteNRJ+Q1AqmSwaZyIJYfvzWzCoIeAzyYlOvkTKJbQ8Z3KU2Xg+DzH9To6wZMgQWt11w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076191; c=relaxed/simple;
	bh=kux7923xqGElgDtYxjlW1kCHNma8Cxn+0IS7mbJ7Srw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvPjZMbD104aTA2X8Hc/wgaaLWmq9S22xdugGZeuwBTkoLlx27HI0RtDzEuj4pJPIAGxxv+FC1r7DQcpYXhrsTeXntkwiWeZXcItr9pHEgU/j3zkB48iZuDDNK6QEgz+NJqbkmeU7lihCdu+Yn1IEceO+n+kHMwkp10/C3M6x4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D0BXwz3d; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D0BXwz3d"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7eb4d532e65so61622a34.0
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 11:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787076188; x=1787680988; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=86SBJV0XE5iT1q0TvIA359xjqIYiArOaY9A0khfcrDU=;
        b=D0BXwz3dErbpe0JF6bdaeKPos+90VccSSPc66Su0C796YRosXTOqCbxW6NhsBD6MX8
         qcJuyo289I1qUd+Klstq6/S6lhHbWke+6sTiSbTsyhhtEK9YxvHwM3bifaSQ534aqPZt
         jmojhy6/KFNsOdrFaZzX/ZnlHUKa+uf2hMst8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787076188; x=1787680988;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=86SBJV0XE5iT1q0TvIA359xjqIYiArOaY9A0khfcrDU=;
        b=BBEcDGHaGeZHrxYwFOwdpV7WmlADkopkjVAdfUR0Ob/kCZdt2/Qd2sMSQvlYDi66K1
         FBHOp2NxarbI4x1VLEFjz6A7bNqYnDjc7Rq7sLPHqWH8/wYg7IWv6cTMaDQfxJPGEr4A
         p0aLLo11DYm/pnDjNYX/Lnp12kcuGzCA+V2PgOUpjSI3nGdIU4xjtH3c9awx3SD8cME8
         51jzHx7qcyABU7DbdtSTxdtVmarCZUGvvixuie6duxt4aV6DmBE1wEtQxiZ6Dn89LYYh
         plVkGKBxJn/WCoMehkhwULYuIiyQeXCv3FmQwprzBTYabbx2aJ0fLhoXOKD+ruPyX0yD
         1u9w==
X-Forwarded-Encrypted: i=1; AHgh+Rr0K4p4rQexAQ4Xu3b85Che3be76gkW2emlv2oQ0WEE1V/ZoTY6eoniFUOPl6r+KB5O2zGWnUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz47o0lW5+35mK+65a+EbGXBCygBfVelesW49zHgJKhRNs+fiLi
	SflLo/NEkTEAv2VMnPCMPwhDQcnu99zv53EWjzFkWsMWBJcpVkEyEYW46lswfoz0AHY=
X-Gm-Gg: AR+sD13ZkiTPytGOe1gfZlUMo6SwuYvSjk5pE4VNZnaeVFZPI7PGIO2lHvClrLsTKqa
	dHpVOFYSLg6EI2n2B+DH/zIWT9J8PHb4i3ONgHxqoDke5eKrzvOKZaUZLaLeJB0LMbIXT+HZWcw
	2xMjBWjEXflz1SaK2UN4MqKtUY65kZ3+BVG1jfJ0Oagi0xADwTwzphWQaFwX3wiyySg+OwTHXt2
	J5o/iXzqA/kAOKRjwoVG5MOMqIW4S9CNpU/XGGpjS7W10pRsMp35VhvE+9tEuJKeGopwK64wOBU
	Xqs4UJzMuIk6Xh9pkQKsX10YBIZyidNTqpJqibj7MZPCyHn/8xrfUHylB13ZX2zAvh3DRnwi0N8
	tjXyZwaeQn6Pj5S5OIMemJf3P3NpGwjtnFakb2EKr4iMvtp/C1jhuZkoLz+2HDwkCDlAQbY3soP
	yP/h6wfU8BjxjXJ0jCB9ihFD/poMhy4Q0CokJrTYxB2RoWd/n+v69te6//NjhLK6Y14wDVQDY=
X-Received: by 2002:a05:6830:3748:b0:7e9:e0be:583b with SMTP id 46e09a7af769-7f3de71d894mr31867311a34.9.1787076187678;
        Tue, 18 Aug 2026 11:03:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f41c0b93b3sm4759046a34.13.2026.08.18.11.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 11:03:07 -0700 (PDT)
Message-ID: <869474f3-45e4-48f9-9379-4116fcd6ebbd@linuxfoundation.org>
Date: Tue, 18 Aug 2026 12:03:02 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/456] 5.15.216-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260817132539.792407575@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260817132539.792407575@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/17/26 07:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.216 release.
> There are 456 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Aug 2026 13:23:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.216-rc1.gz
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
