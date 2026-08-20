Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44D439792C
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 18:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252389; cv=none; b=geIn3BrfRKOM+Kvfm++lsB2Eb7dlsJz3XsJXFA9Qdy7ExBzTSxFOwtyduDFryhWwR1pRK6GMCjL4bRpSlnz4ruOCJwNZNdCcpjnvyqhhpYOAgnMnbHs93umK/CnzmuXTbFOS6FlPc1fPG6MP/gjWE1yxlMG3onCL81+CKnYDqp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252389; c=relaxed/simple;
	bh=BDd+OjFuKXtDJJyZsrBeFFzavNnjpluXJm772BjomSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CKOPoMp10JZP2aqNd7s4lfxt6orR46pR05woSzZ67cYoa1bZysW4YEL5LppQPUoGH1kjrfAezmeHU/UwevAgZx15PshYIc6a877gfIol4831539buH9AGy6qEyB2QRMAEkfhDmr+/oSYv/4Xm1kArufDMOlJeOXL6QW9gzQMQN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4EEwLuD; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4EEwLuD"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-90898faf46dso1515136d6.1
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787252386; x=1787857186; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FBwNVs6vfjWzL5MbwewH6/bqwmW0UG6ceS1G9pzdqCA=;
        b=R4EEwLuDJuKCfgjSsha68bjbeMuAwjnXMufjOzaqmEWJ/QRRbtzTTeMOcRfxazG8eu
         3ZB72f/AwXei94gnAjIDArKPcEEh8w6DdYZZ9XOxAGRdBSMC4ZQNEqfMvQo1O8zuUYTj
         z5uE1r9CjoXuCO1R/yB+U9l5af0t6wHypR7CgaipVsl6wbi3sKnRkiHt5uWMw1XbIn77
         joTP+m4Bk0MDXkvpW4N1BfRsBlPASWdNDzjW8yx9cED2C/7qRD4x7IrFywLLUM7WFx+I
         bkjXD4xRST6ukkxHPEIV9iXAGzPzDM5hqKKnldGyubj8qKMgoxrC201BwoZkLeUXQTzH
         0FhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787252386; x=1787857186;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FBwNVs6vfjWzL5MbwewH6/bqwmW0UG6ceS1G9pzdqCA=;
        b=F3q7WFwZct8r1ye3mrhQt+p3ynwZscRsjLNaxKj67fEA5CZsqh2l/cvvcJ7rsHBMI7
         BYPOSE67aCeTutHGjZktvlM5DYIpVSkD+OLrUAMeHQ59/L6WNrzCsYujcqDxLQdGJ6hL
         opjkupOb8D4qC9dAWxhEjk+6py3KI7jdpJB8N5XvhUGNdvCw1rsLAjc2jmg1DBu/RcpQ
         TVUHFGzCmse6LY9FGb0aRYhZmexbLC9vahLQCLEehQv7Z55dQxLoGyPd1n42j5CEsw/I
         Rf99TK1ldfWS1IErwlIriCjqMhc7uF8cvgo7vD7/99Gj1Nai7hMJ8A+vsFgp8p+vV2WX
         xIsQ==
X-Forwarded-Encrypted: i=1; AHgh+RrPqWoGdw6E7fo3XWUKX8RKjlzPS5C1xgHPZIEAfFlz3qjKCc2T49P+3kBLnTgt9msiugYzjns=@vger.kernel.org
X-Gm-Message-State: AFuF++lE+0nJazjnc6rxmdWeJTtJxPw7pfwR6AeSjrU8eHUpyqDV+XTs
	TosmM2S1MUedzx9F4iq5WdWtJS6uPaFZquZlc2QWkFvbax/f7qhRKJqN
X-Gm-Gg: AR+sD11ppHfc7AWZxvElmdvaXsFbfKQ1tKoLbJpje6a7iCTqRVuCSfRt1X/+YuekNgI
	J7Cnd9xGTEr8Ncp0jJro3dhTMmjIwCmFrRN0FWs/UnbJ/+/Giok4tWIDKS8xjBRNpjllY6n7NcJ
	te6+90lB5ZlZTqCcIiMcFe4qZG/oTlgMbdqeMOQT0I6SCyW5A1G1ZZTrTK4ixpgBtbGRyI8QuV0
	+BJpXhl2ws3THph6gPV+SvOtXPi9+h+K8rbVU7bNmiBthdAe403kdn3s5jYsDsexgjoebh/rZ22
	LNbYuEM5O3y6cQFU52YP620CduxbT9hZwmYbm7DQMWPoq9dEfV9sQUSaIfprvvTNAXKp/5hOrR3
	VRDaDwwV79Ye+rZqiX8XYFmf/RHQbh4vkA/LwzKy8C1M/zyxqar0gQpU89ruzXOmE9+oXlys3Wt
	0NSvkJZcnaLd2jkvLIqZ0kHPPaG059dDqnztDk0t7frkAyAQWgA6HROH06DcDtGn7DKUpdIPKW+
	iKO0aXgQtFwyjg=
X-Received: by 2002:a05:6214:1302:b0:8ee:b05c:596f with SMTP id 6a1803df08f44-90c810541d0mr2631886d6.29.1787252386301;
        Thu, 20 Aug 2026 11:59:46 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5f2b2b38sm44686326d6.43.2026.08.20.11.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 11:59:45 -0700 (PDT)
Message-ID: <26c988ef-f20d-4af2-bc0d-8e4bd13cc21d@gmail.com>
Date: Thu, 20 Aug 2026 11:59:42 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/220] 6.12.105-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260820145223.480031205@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260820145223.480031205@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/26 07:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.105 release.
> There are 220 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 Aug 2026 14:51:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.105-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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
