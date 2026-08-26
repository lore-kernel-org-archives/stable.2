Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC90633937B
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 05:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787723855; cv=none; b=anL+gq31aQLucnO/dXEJgqZ5VWvRW05WsOxcNyLIV/1J/oFWIX5NXVTLsKhK2l0/YVjfQ7OK15CLYkMICeg5ShZ2wq1Xejds0GX9KIn2GFSuoV5m50UWzydVxgx+FPBr1BlsRffUIMUtYVdagD5QiRIpCP3EgObGZwQoxVd5+Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787723855; c=relaxed/simple;
	bh=Kb4zXA/7EKlfHzyKa/blTu6mmK9yfF4dEutV4ZSBq/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2FRheKjmLDP4Mg5cuSLvSI+MJUCDvVX+SwbrSHv2zkfwUvOjdXu4l3SYJ2THK5nS2iU/cHj24br7OBzWnPAFo4c4+cuyrXctAAxn66hQ+6J580Fkr8PQqf+9HiZF/C6jSjh7pbuEmCx+0FPiKO7IgqRXQoa+xblRUmPSg3IEpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=WO+YCyO8; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="WO+YCyO8"
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id z0ZtwyTpOhJKMz6dbwwVjM; Wed, 26 Aug 2026 05:57:27 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id z6dawqb5cn6N5z6dbwWGBn; Wed, 26 Aug 2026 05:57:27 +0000
X-Authority-Analysis: v=2.4 cv=LJJmQIW9 c=1 sm=1 tr=0 ts=6a8e8047
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=60u_ompe4jvr-0JMN7sA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vQUGvzCftAGF0Kwtxy8vX1y6TzTfxwLNVfh7O+RzosE=; b=WO+YCyO85TFIR9gV2DXCO9L25u
	B24H+t5moIG9VGZITYSf9V3ii8BD15r+IRlCs18je9KkrCVA6kNt0q/MyJ6mof7/P7v43fwrWy0iZ
	5791GbbVADk6VtuBWEWUsquK7sNIFjC1ejZCm2iikNHwaV6WxN735OqqaGjWSzEjPl6atDitjhSLW
	8oLUJkuVZVlPSC9N7zsGRHMCdGLNnROh8hsin9YL476esqBhDfT090TU5rBRtKnzZyjNujlJnyocK
	PVHNLeQAwOgy93oktjBGxKY+/axjFouNZ5WuwIiJZtom3c+Q2tn2Km/hs5CTxqAmyHi8zGAgL3jPC
	2iWaaOlA==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:58022 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.5)
	(envelope-from <re@w6rz.net>)
	id 1wz6da-00000003rxZ-114o;
	Tue, 25 Aug 2026 23:57:26 -0600
Message-ID: <40f84483-e8c7-473a-a9e2-8a93c6963a24@w6rz.net>
Date: Tue, 25 Aug 2026 22:57:24 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2 00/82] 7.2.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260825132541.560541185@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260825132541.560541185@linuxfoundation.org>
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
X-Exim-ID: 1wz6da-00000003rxZ-114o
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:58022
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGUjPPcb1Vl2hn1Gyt5sUV8mhjeu5FHiWJmUZfaXrwp/XkJVDWXrZ0NPrpu8BNFbbWTqsycFsQzEQI5MsiOdGWIa0m9t8gsXwtc/XlQ13EAO8Mcp+fLZ
 5YMF9dz+kCijDIDS2BxTQUsS+1AjFupIMisWEqzMbqFhHDixGGCdqarbo4TSrM9nk595bqs1fbFUVA==

On 8/25/26 06:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.1 release.
> There are 82 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Aug 2026 13:25:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

