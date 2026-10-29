Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284140;
	b=uYSWBzIr2gNVEyDwMw2uza3y3F7iVaHlRXBJAsS0CmkWrMcowLxxceHmGjcDFV/0HhAo
	 RftsHmbThYMiZCTEeAxyg0j806NB7LY+4bw4GfOkiRUnT2bR+LIsEPIlYp6z5i/n1hR4x
	 ZYSwXFc4AvvSH4FK4I2ntnaf1THu688u8GaNq2NI9vSHjmOOfmM8rPZJM0nmUEWBDbSF2
	 K33hRpQxpRrsdDKYylEgXM/fVWtvfvX2NceIebSWQXJHZIBN/DDBeveZQcyrVe/lGh93A
	 mhzO1Rl/t6Avj2cftzOXn2f+xdh3ONjJnhLGeMSg0PjyZ0qNN2o/2o0wmmLMIxgbp+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284140;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=sQEi6LuaGIeJmneZQN5BL7xLmW5DY/Bh0bcexktjejg=;
	b=f075Ur3iKJsOmCIq51uZplpQeOQAr2PKnZWuJhK1pVkUpGBrZOrkFYYZ/Jc89EBGHi49
	 8MIqn6mvOfQaiRAjoXRf1tlxyXoHeFitkBeS81LOY0A0cmIOMPU6TXVgNpUbI14lhAXmr
	 DTjY0Dk8Z7gVAiqAI0IYIwUrCG1xp6xh5JWz4x43Xo6qMmkB1n0Szscw2HDNTxUIt04qP
	 BJlN6z/7zNEfiIweCx3pmvzMbf32g4UpP9BZOo+9Pk6vncADQ2Iaigp6AjCFjmHUZzs+m
	 mMQiStHCbUG3YHyf5RK1mtXCfQcIzIEJkmKq4DicQfg65BSnfbFcr6/x87KfTsWvGpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=w6rz.net;
	spf=pass smtp.mailfrom=w6rz.net;
	dkim=pass header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=pHd4korw;
	arc=none smtp.remote-ip=35.89.44.33
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8478C606A31F
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8478C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=pHd4korw
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id MMHXxzfQuaC0UMR7jx18pV; Thu, 29 Oct 2026 14:28:59 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id MR7ix0RLikE4RMR7ixmnF9; Thu, 29 Oct 2026 14:28:58 +0000
X-Authority-Analysis: v=2.4 cv=LuaSymdc c=1 sm=1 tr=0 ts=6ae3582b
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=rKObpUyAQJ4ZdWOludYA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sQEi6LuaGIeJmneZQN5BL7xLmW5DY/Bh0bcexktjejg=; b=pHd4korwQVaqCh28R04T4+20Ie
	/oL409LqQNK0BFHNu/hLItVgGOKSJ4/8+8won81toB+OhJakX0OEe/JL+wRYHS1m1HQi8GdgUdb+B
	WEwQv9fHRmsBt/fRaMq3foUH0dvY/7AJWm5afoQz6/8uyI5OZCM4QrlZdW0UXd/kl90a23ZzKz7tI
	DklIr0sHee9dL9oqTiRGamaxDaiEMBGmQ/1FZwewQJap5uSlhOBQudcgygsaLEWSsHfzNi1LhI8tr
	6QsW+XRLTsyd1L+jO4tvw1DieTh/765Naz/sKLCPkyWfJ17KiTD/h3MyGD0WSMTJLJdT/16IHOCgm
	fgFHKOOg==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:43666 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <re@w6rz.net>)
	id 1xMR7h-000000044u7-2tpD;
	Thu, 29 Oct 2026 08:28:57 -0600
Message-ID: <9c250d33-3ed0-406d-a6a7-a913da10c9e1@w6rz.net>
Date: Thu, 29 Oct 2026 07:28:56 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/247] 6.12.115-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261028165947.349197979@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20261028165947.349197979@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.162.206.103
X-Source-L: No
X-Exim-ID: 1xMR7h-000000044u7-2tpD
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:43666
X-Source-Auth: re@w6rz.net
X-Email-Count: 79
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBSaUUagMo1nlWtsWO9zlz8yJV9/gSiY/oKgr54lVJp9U6nqT+rcEVFw5RzXuC+tE8f2jtm1uTTHC8wYCj7b9Fei0fHshBeisaRgXdi1aDEEfUp4AKl1
 xt9o373Fm+tplXQEYYNFgVoyqeqQIv0zTtlCmOllQWyVVViZXyOUhUGAmhV8/WpY4Ftwox2mn3kXmA==

On 10/28/26 09:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.115 release.
> There are 247 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 30 Oct 2026 16:59:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.115-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

