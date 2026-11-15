Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794752675;
	b=MNjl53BLKnKy7KovF5Gzu8E7zgoYkBSzz4/H48y5DgzXRoIUz7XEYRUu/8GZSMpoPmJ+
	 y2xw8i2/wSFixY0w34zIU0Fscgnqyx6D5R+Mmb+EuNrguGRabR6OuGdu9iIlWhTHZrrhY
	 /9lhSgE7R0jeMSI5/7gSzkiNuL/4nBjY7gnUWGPI/egLoFd3OcV6bNRAFnUQbmialkJKd
	 Sqtl/EuuMEIZ2sIU+QBmSTJwnpIVy/34gYH05AdMQ50YEtlyWjPBKIs1vrwHZ7bhG94ZA
	 mmQtndmGNwvP7jBrtes1DievqQZ0u9ioUc/wGowKel4pt5+c1eHYCfijcwgu/YvLbiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794752675;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=BrhTUW8fO+vcw4Vv2AeL7c2TqR5hb5priFcmIXtft+s=;
	b=lIWuJY+9YaSXK+jTWPMvNKaFj54zs5+VF4B0/EItofQQQsMwyS4q6/Dy3SkHfDwVdqdx
	 3swtIihRpu//fljWjRfZF/yY7tPiCPP1l9sPxSpQTr820k5b0STmxOilxchUKNEDgoIke
	 0paWFCln0NRHQwjivkuTWoKhEbOFUa+fn+cI7wxJDLYqla/HOz/btYYwJ2cXN6Gy9TS3S
	 XyWSrtaHxpEb5nXfzpSNhLj0eseoU+KW5iNwUO9RlHyzXFEuZbxKm+p7bX9rpVL0PH9BZ
	 8m7NFaUfj0V+r2uRZC1WrWOLeKyJdDrSxGgEm6SbyC36vdXpRLqdhGg+lLiBSFnKStA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=w6rz.net;
	spf=pass smtp.mailfrom=w6rz.net;
	dkim=pass header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b="TnBj0/n3";
	arc=none smtp.remote-ip=44.202.169.39
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20966606A336
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 14:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20966606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=TnBj0/n3
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id S5rvxYzpROOJnSb9mxzJzr; Sun, 15 Nov 2026 14:24:34 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Sb9lx96U0laNKSb9mxL4wa; Sun, 15 Nov 2026 14:24:34 +0000
X-Authority-Analysis: v=2.4 cv=UbpRSLSN c=1 sm=1 tr=0 ts=6af9c0a2
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=1ZHqKQNBhTtskWZSVtoA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BrhTUW8fO+vcw4Vv2AeL7c2TqR5hb5priFcmIXtft+s=; b=TnBj0/n3PFhFHXX/5t3jqzs3dE
	oaDXxr/SgZ3AtgEjxkPBG7QNlPUOC3cf6+bfpSW7Uq0X6OhprYk/1kuTdtRb26Hkr+/pDcgj6Fxq/
	QbwrbSlEW6it7ilfEC4xNNFVRl1wIxrdeeqsRqYv071mDtifUF/hp8wsb1tn7PIEuzezxJVyKgKMV
	14pTg6VUNA8UD/pK9DDdq/1A989nFIwfRwlIQJfuDDy/Hl2hPIK0wGxRoulCVNIG+fILO4GKrRgnV
	C2/pEM1w1wm7c8H27f735POYAEWKcdXgnv9xs65xCHHsmNUzWeAgypH8YT7jw7l1bX1MT3jKqDM1/
	Fj87iXkg==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:37292 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <re@w6rz.net>)
	id 1xSb9l-00000003Sp9-0GqD;
	Sun, 15 Nov 2026 07:24:33 -0700
Message-ID: <f5817ba1-8048-46ec-837e-b502ed10cf2f@w6rz.net>
Date: Sun, 15 Nov 2026 06:24:31 -0800
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
Subject: Re: [PATCH 6.12 000/670] 6.12.118-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261113153811.177190860@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20261113153811.177190860@linuxfoundation.org>
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
X-Exim-ID: 1xSb9l-00000003Sp9-0GqD
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:37292
X-Source-Auth: re@w6rz.net
X-Email-Count: 59
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGkD5wPXjn5buTwlYUucE+biDqLgScsQv3vw3AdAot19aUyPNoXEt9IEpWTJb2m+WT63EPCEIjd9hzs3u3ymuxDvZxTUUVOA5F0CrbBAdBmd69f8aGPn
 0xQS4tjV0A0FwIEjq5chLWCz+C97ICE/Sk0FOkZXffufcf5ux2YK6NcC9zOJvXe+XXilzc9xm6aL5g==

On 11/13/26 07:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.118 release.
> There are 670 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 15 Nov 2026 15:36:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.118-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

