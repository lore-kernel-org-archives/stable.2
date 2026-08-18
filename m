Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4295E448388
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046523; cv=none; b=kwiypzAbgSbdg4GWRhii1TO1Wq0BGdtXAOfmSijqJDSR+AUudpCTw0UM6b9lOQbon6Vj4OkmU55fDMEIc1qlQ5d2UC/BNFuxwC4Q/NzcU3eamObyJtxRz67qhDh6cyRkF9A7FErXPLpPDlEXJTQjB46V3o1CZot3TM+rLhhb+ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046523; c=relaxed/simple;
	bh=unQoIGrH+GdH1GgLxg0HACekFDr+tzBFfd3w+6X3r8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ors/x9EdCPC9sLQbDb2MJjqOorGiMOZ5wWUL+Ymf68BQ+D2ul5tsvFEe4qZiCBoqnTqxIh+ITXT9+v/o5UxG7WB/t0fwH5peP1283mbeMdW4yDdx4aT8LtGULniPtz5VSg4zLKkP7mjRE6wTWeijhfs74FoL7nenRKoL8QcXihA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=R/uMBlbD; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="R/uMBlbD"
Received: from eig-obgw-6006b.ext.cloudfilter.net ([10.0.30.211])
	by cmsmtp with ESMTPS
	id wGM5w4ZYcusRSwGPSwk1i1; Tue, 18 Aug 2026 09:47:06 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id wGPRwfndBxg8YwGPRwc1nS; Tue, 18 Aug 2026 09:47:05 +0000
X-Authority-Analysis: v=2.4 cv=R44DGcRX c=1 sm=1 tr=0 ts=6a842a19
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=clWHoDtF10NeT/mzylEGUN/EGi4aulMN63qkD+2LsTo=; b=R/uMBlbDvtaKrPlJ7OFCz0qjCW
	eqQJywhzH6gCUqtiBPyuKC5KbV6jD6DxdC3mnv1ULHmDZh0EATHmY2SbGuGBG5kniH+TYrOoxMHSa
	3qPs9IKjVyeA8+JhVQbdlnQnXEeog4nscqZlVxwwnJpv1N6zX0aalCcIsZofpdRdP0spC1HR/QH6o
	rZpxy8ji0oQ5HQk0X1ZWwKH0f6DZYRrHxCuFlXkRz6v7+e0M8DFBkSAWcd3Efi9bid691NNIR5h3o
	9u/LJRf+9pjmfHuQdUnvjfDApAQA9VcB14byPpUAzovr52l3+0/IUxdFK0GyO5+ZVkzvmycOdU/3N
	QReymiyw==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:55228 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.5)
	(envelope-from <re@w6rz.net>)
	id 1wwGPQ-000000027WE-3jt9;
	Tue, 18 Aug 2026 03:47:04 -0600
Message-ID: <36fb0ac2-ef3f-4be8-9ce8-1cfe720170a6@w6rz.net>
Date: Tue, 18 Aug 2026 02:47:03 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 000/271] 7.1.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260817132536.752504388@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260817132536.752504388@linuxfoundation.org>
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
X-Exim-ID: 1wwGPQ-000000027WE-3jt9
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:55228
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHXRYoP1fHg6oJrlyIpAsYTOoE2Ha1gPpS7Gh495zSrgsAh6crNhNtnSjkyt5SEtCQpjtjKHqcUa3IIMmFwsspq2jFPAPBvsWHIewGIOgWF38HTKdeL2
 UzPc2ZfsyaQViHWrpKeyHrlNo6hU7+m7zRSkjjMoMRNEjUO6y0wpH4cPl4Je5ao7yhODYwvFO6SckQ==

On 8/17/26 06:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.9 release.
> There are 271 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 19 Aug 2026 13:23:44 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

