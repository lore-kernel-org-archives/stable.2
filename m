Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6B434844C
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 06:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783060421; cv=none; b=DHmNlqhMiL53iOwcyWSi2UtWDwgDA1jN1udf7GWSw+txZANl7gOq0HApQf7pVM6647qUB5yxWbZufS0UKqapPF9C4mxTUORUcnCQxeoHKhOMPhqlVQBqizqpW0Oca8jO+uEgKMC6uLASKakfqKOQjIDlAlDUxOA+3KfJMMyYzp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783060421; c=relaxed/simple;
	bh=llPMnD9CmTO/YJZHWYq4xGkXOuYsf1H2zGq5uGLzrL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WE5uO7dONeiAiLP8FthXDh/rnOzFS2z1Ih2keBo8zW7I7+bJW+dDqEHgZFf5lZAu6J7+5v1kXvjIennfdsVE3r2mXlGsd61gHKz1+0MHSfNloiMttBBd2jVfeofrSYgtGhTAnqWEa4PaMygftiya2iTStGZYYpwb6+WWxSlvHHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=NnC7qgJd; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="NnC7qgJd"
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id fOXJwKgGXKSRRfXSvw6xJx; Fri, 03 Jul 2026 06:33:33 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id fXSuwAuEown18fXSuwdDsj; Fri, 03 Jul 2026 06:33:32 +0000
X-Authority-Analysis: v=2.4 cv=ZbYdNtVA c=1 sm=1 tr=0 ts=6a4757bc
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=QUYbzp3p0A3I4yDEf8UA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XiPJyo+3hduYqvapHluQcwtJSbaZiATUs9s0eJ7l3Cg=; b=NnC7qgJdaosk14D3pUgUhfCC3m
	vyvmkM92vS8XIVocKQm/sWCW/X932lMO5srckeBN3XLr+1eKAQzqZIGhZF4WPhD2jFKlpiqaccMHm
	+bm63RJp7Y7FLZqGra+vyumldd3WE/Iq1ZsxLh6Isc4RmEUQZKnQRO5K5LgRvIKq00j/+dilGbM0e
	Vmi204UMXzAJtVnLKpv9f0Y/WqsjfIU+feKzDU7abYBql8tg54m/gAIKP91OcI1d1PxMeGlVKqXqh
	WWLE86RX/8VEVsSvEvd+SjEc9/7gqLzH/RkOWljvlVkPVdBzlxT6uQb6F5hyzBPu0dyKzWbTxVIf6
	jjIQSs5g==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:34798 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <re@w6rz.net>)
	id 1wfXSt-000000013NJ-47qb;
	Fri, 03 Jul 2026 00:33:32 -0600
Message-ID: <e14a4bab-c513-409d-b3c3-33e26ece23d0@w6rz.net>
Date: Thu, 2 Jul 2026 23:33:30 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/175] 6.6.144-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260702155115.766838875@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260702155115.766838875@linuxfoundation.org>
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
X-Exim-ID: 1wfXSt-000000013NJ-47qb
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:34798
X-Source-Auth: re@w6rz.net
X-Email-Count: 39
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLiUp/t2Jc4ImR8uNTu9U0Ap5jtPFXW9rfUa9gfPto8f0LsTTT+b8/g0bMXoGrFG2XT7KzSFEriLTHigNszxOIu5up0jix5hFDu5tiREUnIZW0Kkc/Pi
 YDJZRD8zHb0yLKU/cT4nvruoli7xukBfD0Vcl6NVRZRta0eQbs7kwTJHqLGJN9B07Yv93ds2IWDYcg==

On 7/2/26 09:18, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.144 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 04 Jul 2026 15:50:58 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.144-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

