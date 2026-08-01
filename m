Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90CA23C8A0
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 06:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785566489; cv=none; b=dDcbQJeAThiTRlAUHAj3Lc4Sa9fCc75IQ7RgXpvEaiQ7buI6neFHyu6yuws565yj4bYFPi57U+4gVvdhlrQysC6hFt1l7IOKB6nkFFFjLGSkun2kf7SkqDiPKbUOXzaFuq32IEIvN1qmUL3/zMOv1Q2zWTaCBC4DQaJp7VuV9bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785566489; c=relaxed/simple;
	bh=0voBj5666eAKSMgBSMLhF0eOAYxfL04Xzc7jcaGOh+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lqOMk8ilMNtgcaSSpfrZSM2f3ApmXO4OPKa5h17eJx7wibtKLCy+5QTxaTjN8tECspzP3fynYiopn+Ax1DJwskLyarJtwFQOSievkLTj4OPIAdfMVsHGOxOULnELvIZcpiN+JyApNd7NNs+5TOAvahKybDVm4S++6ZGpNdPp2rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Gfjvdv9n; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Gfjvdv9n"
Received: from eig-obgw-5007b.ext.cloudfilter.net ([10.0.29.167])
	by cmsmtp with ESMTPS
	id q1pKwIjOIhJKMq3PNwiFMf; Sat, 01 Aug 2026 06:41:21 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id q3PMwj20q3bwfq3PNwBvX4; Sat, 01 Aug 2026 06:41:21 +0000
X-Authority-Analysis: v=2.4 cv=fv/cZE4f c=1 sm=1 tr=0 ts=6a6d9511
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=JzlCH241G2EvDqtJx4kA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YSiEByqmOzziHwtFLECNeU8kWLa91Ic4KCHURNuCSE0=; b=Gfjvdv9nRp+JvMwIZp4ViOfUzr
	9aktMEC8/WR91ZbK3PGpcHLwVxYjz8bphaRC90p5wgA4f8sSdadOVtuVZ6RHl/ujUJCgPKIjMw5qY
	MJQovcIWxqhRJoun6CqBpMUp/V57EQIc+Ws+ogI2M8XigulPjpYMBSvYFmrzxhK9FK5+l3mGQ6pea
	PxP8WkwtLAby/jc/k1jIfqpAjcrd9Ls8uryMKZ62ld49ghT2GrGlfrzIhGw1eBp4w2SbUzC/Pt75/
	DQkraFIlKzY1zk0hfxKtTWirbwbR5cJn7DBRON4J4nvFxt8irpKhi85QHHV+fnFuS9hzWd7C+m6yb
	415JRt0g==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:49368 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.5)
	(envelope-from <re@w6rz.net>)
	id 1wq3PM-00000002eOk-0ddF;
	Sat, 01 Aug 2026 00:41:20 -0600
Message-ID: <8d4bd01b-842b-49e0-ab71-8ef5d3a555f2@w6rz.net>
Date: Fri, 31 Jul 2026 23:41:18 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/675] 6.18.42-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260730141445.110192266@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260730141445.110192266@linuxfoundation.org>
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
X-Exim-ID: 1wq3PM-00000002eOk-0ddF
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:49368
X-Source-Auth: re@w6rz.net
X-Email-Count: 39
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNDdkZA3r1qTQCNFtJ8fnBqXKdpvzWDrN38pk6ahvFleAgcI175o6F/3WPvm2rHCKmAnDd7lJkGjQnhJvrTCiA6fLYKDBGL+lVmeQBUhnJwpsDO2lqC8
 78qOtks5vWU7yP/7sXrNobmzpSaApe8Wwk8apAX6kQyO7yzWRGUrScnkLWhg/bRj9qROc7PRbGbopQ==

On 7/30/26 07:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.42 release.
> There are 675 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 01 Aug 2026 14:13:45 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.42-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

