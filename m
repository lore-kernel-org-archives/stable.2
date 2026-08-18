Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B013A381C
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 10:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047541; cv=none; b=pB6Rrn9Aj9i9c5Nq6OqBNNFuQ6pqeIYzG4UKh2y2d2/Dg8awYyemvAQxpfrRphFuB7My/1KrnU8agV1fhgTU8ZJ6bJN1Auornn35zvRIRjIBwlGzIeKhElqtdbNtKI99nPlqkNJc1wJmVO7fLxIht9UHJMrQZOp9P2CnZuXzGAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047541; c=relaxed/simple;
	bh=QFBckaYk9XqU5F9TE8XIrlBL4t8kCU/cH/emXb2z1mA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Onfa/10tXEbFWPkPusG8KNMQbyaY7CksZZSCrSdq14SOdyBGZACvuLf3O6I26rVyO3t7uKj3w8MURGxSbocsYcxRnuoN2FkmntjY1Dc2oNAApTWCy41SrkzU0bqd8F3cIwuFuGiONigAILGa9c70Hg+59pMufTVrk+RDHya9WlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=gWibWY5H; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="gWibWY5H"
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id w2Z1wMWs1hJKMwGhPwpOU1; Tue, 18 Aug 2026 10:05:39 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id wGhOwL0yOooyIwGhOw0ioW; Tue, 18 Aug 2026 10:05:39 +0000
X-Authority-Analysis: v=2.4 cv=AZ6xH2XG c=1 sm=1 tr=0 ts=6a842e73
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
	bh=8jKBAO/7BNap5iOtVDAuawwbhAJbBlRjBsfuCs4oyr0=; b=gWibWY5HK64BzEi3yt0LFOi64X
	imLuo7Ucsa63gZBqXoBDXipjk8QFvhyrYtsC7VPZTqmfIIOva1X9SbFWl8Df0hVzbqdR5SzAC/ezl
	i1jMa5cED3yqSDLYRWmqWUvxGGzwJVhekuKinTts6Di5XdEMdk8GX0HtpzTsr7lv1vLa7vPWUlSpK
	y9seQbAtCxIVrrxKiXRpo4W+X8sy18MrjUPEcVQutyvrtbt1gHhjWhqwStHYK/J4WoZle9zEJ4jw/
	BY8F63IebxwFq+OEbI8c7qeoxqFvSNzaXNUzgqwh7S8mwXcAu/LIW/kGMuaWD0xv9o8lgpXNpt219
	aoENSupg==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:37848 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.5)
	(envelope-from <re@w6rz.net>)
	id 1wwGhN-00000002I3R-3ojn;
	Tue, 18 Aug 2026 04:05:37 -0600
Message-ID: <5c9904f8-f43b-4fe2-b999-f7de1a506599@w6rz.net>
Date: Tue, 18 Aug 2026 03:05:36 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/156] 6.6.152-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260817132534.666299318@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260817132534.666299318@linuxfoundation.org>
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
X-Exim-ID: 1wwGhN-00000002I3R-3ojn
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:37848
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCKarO6YxXrqmxx+SJW1HNJJPHRBZKajCcC92f4K51V3Xt+84wnjreK7kXc/o99EzPIm/W5ecPeOe1q5hv8M9Cr3PM7QONvwJRL0jg9RVt4cT6iEcedv
 d+1uTj+v0XgfAVG+bVYEYBveGg6MeAbjuL8fWUECUV/CtWGMjs3HVTo2GN7jlLUuwuk7ETktmyWtag==

On 8/17/26 06:32, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.152 release.
> There are 156 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 19 Aug 2026 13:23:44 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.152-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

