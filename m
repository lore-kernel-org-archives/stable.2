Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D27E4CB8C8
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 18:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788633195; cv=none; b=UzhttQabZ31e4dbH8vyqW2NLL/dMCgYbj9IhuZMHqXLVuYVxiTI8IlJyvxaJmSBMYvy4rHm/NYcfCkt0I4gseoCcguQbh0rgS4v58WyVYQhzTTKiAHXdOWZQAnSwZAGGosYYCJYrNu/Kbuj131wzkGmQxyCPqKAkOfnI7Hvg34Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788633195; c=relaxed/simple;
	bh=FKq1NryK1zRIAl5XiNjG29K9lMik2CrHrXoz1VuIAd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emaPpESaTkqLSDy3EGpCI1bq7rFx0Iabyc5ZmAz8ZkeijfZVB60PBx60f/shoSwCIusZxY+hgd8e8v4SS/OQ53c9BJ3BE1ocR9cSEVgKmHZ2F5oDZiq5Hsop4wuaBr1aJ4qVs8GNaRT6HHqCUbuPUDnS45DhaH1hjB+4hRaQnTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Ij952aks; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Ij952aks"
Received: from eig-obgw-6001b.ext.cloudfilter.net ([10.0.30.143])
	by cmsmtp with ESMTPS
	id 2nDgxkJtBc3Xs2vCOxukHt; Sat, 05 Sep 2026 18:33:08 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 2vCOxebIi9tXG2vCOxfL1L; Sat, 05 Sep 2026 18:33:08 +0000
X-Authority-Analysis: v=2.4 cv=KK1aDEFo c=1 sm=1 tr=0 ts=6a9c6064
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gbyM5iepRbt2HiKDAY5QzxK794j5w0WSQTiLxK4/ce4=; b=Ij952aks8mVP0qWnn5Pd5yGF+5
	QqmN/DMBmha3GdyFRbQBaMgaZAT9Wpxm6ZbNjVGFfWFE2zmzze9WVlXvz5q9eXaQpyoWi7gFJUR1v
	NNeGNOKEY6wYSHbfTvpuQFH1a7tud/kx7rU6VVgT8afs0dX9TqhofOZZDVRn1A6RN1L8e1Lf61p9l
	S/rtrVd9kF4dBMR/Rdkclkw387RL+t8ykkuhh99Lzi1eLaGN3VI26kl4da+7sEk1bTcMHOGUquril
	8Y33bCVNwg4/zXSCdlRgqfqIeRag8oTVJ9n+JiLSsJ4wq/cLiSMOPIZPjP65jpMvVsFOYQTVfS1QH
	swxpXk/A==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:38816 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.5)
	(envelope-from <re@w6rz.net>)
	id 1x2vCN-000000000ym-1zUU;
	Sat, 05 Sep 2026 12:33:07 -0600
Message-ID: <135238ce-d960-4e91-93b8-942ffcbe366c@w6rz.net>
Date: Sat, 5 Sep 2026 11:33:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2 000/713] 7.2.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260904045803.810145556@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260904045803.810145556@linuxfoundation.org>
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
X-Exim-ID: 1x2vCN-000000000ym-1zUU
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:38816
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfL3qAsHXAWt4nowft8zcs/S/SS2H77Zhtk4P3qy7XxcUF4lJFUh/16X8qvSv84tapXxnVbkTE68YyPMNZsajmzv73ag2QidNUtNhFNDWYT9Lksvxt+rf
 8K0bBaHoxznb0N9S8IwHAQbyuGO9daO9iJQBIAR1hU3yc/8w3/glBc10BYJLsmQ+ifxDKCE1FkY+YA==

On 9/3/26 21:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.4 release.
> There are 713 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 06 Sep 2026 04:56:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

