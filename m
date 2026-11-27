Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795772061;
	b=EPwwMM1qts2ZU7jOY8URfsPbwtNgEOCR7CRqp+FfvvSbWs4au1YM6cJDoJNV+TH2OTwD
	 ef0pvspA4DDB6FqOVMUXjdND6O7tdj2g1o0Pd5J4GYpdBk7BceAdyQ2BXPqp8h0E7ncDF
	 vXz6vf6F7WSOv22ZkCxPmsdBMNpzGlBTU+sVILEI8Zc2NdYQwvHPXmTSLML1TUl4+aCtH
	 SFLbWfUvnztpl3tm/kmmDn5TGaZvYTKho7UjdPjWcGOAiMqxr8hRE6c5JIotI/+2vavHw
	 RdQSRGpgtcIow3BL2IHbGELKXp4Epq6vOKU7ODCcobOsMk9aX+YGn95/akJn/eRSKaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795772061;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=ZCkXVoC3SMGDxaQVGjQt1ZsXPslPf2vI/gx469RFFa8=;
	b=nOavD9uwKHNB00nVgJF7gP8+Z/CieiB2MeTUS2EX6s+OzHHP0GHCbzIVaE0ddlo7VsbA
	 bBoCw4rLtGueyJx98sgExrMJomQkk8xUf8gxBhl6m86g0v7vxPWSv/Lh0AVBGK1RgOuR8
	 a35FOlJHcjQ8wFp7x7r6NjHeTkLVDpyvxxtXBfTj9K4PL1xEwo2oCpbdnyAA8BPJ0qDJl
	 h6n+Nbo6n1NUjHhLOAAo1Y1KBuRnLJgF7Gyc7Y3dialIAzG7yj/y5hlv0Cg8hTyjE67jL
	 zZHqhv3tBGNZVpDxGT2+1MYBwx885zDDg598N4dOohpEhtuK9Z56m3hExGuts7jy7jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=w6rz.net;
	spf=pass smtp.mailfrom=w6rz.net;
	dkim=pass header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=oMsIuB7H;
	arc=none smtp.remote-ip=35.89.44.35
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FDE606A31E
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43FDE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=oMsIuB7H
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id Wp08xCzXARiNxWsLOxwc64; Fri, 27 Nov 2026 09:34:14 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id WsLNxlpbAuJrPWsLOxgndr; Fri, 27 Nov 2026 09:34:14 +0000
X-Authority-Analysis: v=2.4 cv=WLZ/XmsR c=1 sm=1 tr=0 ts=6b094e96
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=vOf806ianDT3JLFn31AA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZCkXVoC3SMGDxaQVGjQt1ZsXPslPf2vI/gx469RFFa8=; b=oMsIuB7H8gMlqOssW3wHuzDY/C
	CfAuJoUzgmm3kX6zmrueGcrsXyoV7kP+FZpmsAIsI7u0MEnrjgbBZ+SW4QZDY28aLU6haHYbz2CEQ
	a41h6hiUu0iMPBY61q2dy3tJCWsIkQS/VrRDflp88y9D7jr0eZt6ybdQROsJVt56dPsUeWNKxc7wV
	xZf/O/6liYNPksEpt7Bhtt4uC8+kxSPmsvCm22WAiZA0dqeLC44fT5Ia1EP7nQPZL8zjjkeoPzTvL
	4QjuvsusxqCgWs1FV4Kn4ALVo91JX5FyXpkNDmvDhdZfxFeq/YStSfzEFPSZq1Xnbk80qLEMcY9Tw
	FXa618oA==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:53926 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <re@w6rz.net>)
	id 1xWsLN-000000009X7-03JE;
	Fri, 27 Nov 2026 02:34:13 -0700
Message-ID: <7f9018c9-2422-4a2e-b437-44cd587a153f@w6rz.net>
Date: Fri, 27 Nov 2026 01:34:11 -0800
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
Subject: Re: [PATCH 7.3 0000/1002] 7.3.7-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261126105729.110697432@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20261126105729.110697432@linuxfoundation.org>
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
X-Exim-ID: 1xWsLN-000000009X7-03JE
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:53926
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJwKPjp0NwF9EsXT83TNLAPMzPLcaTfB/qc76Vh83w9PNdHUnuQS5uR/ooP54NhMosPt6gzdFHk3wqyrOLElSlDfsNQTzurfnq3mUGc5eskg/0qJT+s4
 GyrHifV/wTA1Wy5EF+QfquIfqJZEYBoycrWPqEXLC3kf/Ik3vHFBhYSOLSJN+fMLbUeWLA7cx9rCew==

On 11/26/26 02:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.3.7 release.
> There are 1002 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 28 Nov 2026 10:55:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.3.7-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.3.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

