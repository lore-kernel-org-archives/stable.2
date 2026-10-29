Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283465;
	b=mnonBDEChjohzrde2+IfOdOYLTYeZ5i3+7RSP7muTfCj4iheotk+j1ie1NqhLEJT9vBF
	 RbXsvwa7GyHbmpjPDSqIHhR3YUvSSScvfyb+/EdSxzizCcy6e/yau8rGHGl5sfUPHpMlv
	 RdvBv/c9iANYxFQnubTVjHMwVQRILRYfojRynwgXyFKh6XOvT0VUYPM4OqqHyYlsSiauH
	 Ho3KAv14LnqVBYkKE5EkPr1M+gY4jUPxJIw6okAC6Ij1EITTRimc7uvMcKxMGh27nVIFE
	 CBzamhUiD/yGwwy1vgPuWMKQmc1VxYzCzPdp2DF4k3fYfzuC0JGcZxVj9+qZLg4lPCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283465;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=j6tezR2bbFOEa7WomVMs7rpcLRiBTmUY1XcdPftvFZo=;
	b=4cO2PGLp+fJ9/ZJZIMXcF01700oOQyrfC5btxI0nyk79reW44Y/NUPuXHLbTd2ghdYhh
	 RWRVj5GPEwVrbPJRNZdRgeTlS5lF39VRThkAFZwl+oxmO3MhvwQf0Ccao/619IM/OvzUq
	 h/S6FqOuxZih10Wg5qbqUhM3uFow9Qqm8wlhg0xYcop7sMMIBTfm84PJ+PGz/D/3TplPR
	 6QKeCzZG0ajDoeqwYNn9ArAFrc1ZNCf7O0km+IMSKEsdQJx5XiCWKR/kKtgZcM9rQBHit
	 OxlNHxxKcbwnBg3rb6TSjSEy0bFtfp77Cik5NFdpPctg0aznG27RU/m9+Z0/IzCwSbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=w6rz.net;
	spf=pass smtp.mailfrom=w6rz.net;
	dkim=pass header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=R8h8nS2F;
	arc=none smtp.remote-ip=35.89.44.39
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6034C606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6034C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=R8h8nS2F
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id MPOWxQ92ac3XsMQwlx1nEk; Thu, 29 Oct 2026 14:17:39 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id MQwkxlMDn0ULmMQwkxwTMU; Thu, 29 Oct 2026 14:17:39 +0000
X-Authority-Analysis: v=2.4 cv=JJw7s9Kb c=1 sm=1 tr=0 ts=6ae35583
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=GxnsrCybi4LwF3y-YhAA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=j6tezR2bbFOEa7WomVMs7rpcLRiBTmUY1XcdPftvFZo=; b=R8h8nS2FLrx4IergPvlH4ydsmb
	YwI98F3OoBGBVhZ2MB4pLEW350dXqbVaN/lGRh4QihNxIi6uX7crSB558yDT05DQ14vzkXYPN2xE+
	tNEESuqTII08BEdES5bjRWME5n1Y6NtsvQ7HJXRJkekSRQuss+oIRnqpq7PVpRV+x2dr0doZC2tsC
	PAU2HCfn90ps8YKls/X3QqCuS5KUHMLXDd7r0yych1nUs5dqUk4JQpakRzG43OPWanottPsxSt8K1
	8iFBL5zQ3OXqGT6lipUgYiEhiMrgW/aupbAsOxEG0IlWfVrnoVTLTqe4TBmpm64ER2UNJ+IpvImi9
	4BV1sX5Q==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:52240 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <re@w6rz.net>)
	id 1xMQwj-00000003wiX-3R7j;
	Thu, 29 Oct 2026 08:17:37 -0600
Message-ID: <4169401d-5dcb-46ee-ad65-3c14569c84aa@w6rz.net>
Date: Thu, 29 Oct 2026 07:17:36 -0700
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
Subject: Re: [PATCH 7.2 00/88] 7.2.14-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261028165942.107695352@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20261028165942.107695352@linuxfoundation.org>
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
X-Exim-ID: 1xMQwj-00000003wiX-3R7j
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:52240
X-Source-Auth: re@w6rz.net
X-Email-Count: 39
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfL1MCNHfkV9k8qVQPpE9PKC1/lidi5r29vcwC0MxZjlmdRi2cBsAXYaZb1V5NP5fYhRfJdvdhyjriFKumzl1GSF0EZ1Yi6L7rS7hsJ+2hEXmX2DojREi
 EjY1R0JGGlAz5pfJD0CuA06B4tWz25/oNI7fzIkxQoYkyfwJPzCuJQNECUKPrbzdt/LelFWmK4R4VA==

On 10/28/26 09:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.14 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 30 Oct 2026 16:59:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

