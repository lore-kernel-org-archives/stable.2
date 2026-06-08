Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABC1382F07
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 06:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780900837; cv=none; b=aS5Ygew3mDjXumYVA5mTnTOH8s3sWWKvyxNgM7gEEtMHLW/Y3YZWS+MSGS/i4wz9QGRmCocratYtIamaWzPLNl5gIiygNxL2YdahT+CEXqY2qz4amB3/cZv5iAOuzX3ivoEXLnYloBfJmVvNlm+fbu4YVZmkSv+TGwRfb91ygBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780900837; c=relaxed/simple;
	bh=hCghwfBfDsGwLlCjPRS++AQGBETFexOunJqwDuAhJzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lwcngr8ffqNtukxOX8eEePmbkX1ZcBpClXLpBuLDSHg2Hg9GcJsp56h7o2B06z/cO/ZRn6rxmfIryYmxpCx11RFYvRpg6yGjBrSJlh90938/LGbBVLrIs6CfDGg1ojQ2nRc8LZmPTCdNEk2xV3aqogHK6WQPouX/UzrxET+IiN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=ZxHPrRWk; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="ZxHPrRWk"
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id Vy7fwmpgkjgweWTeuwwwSz; Mon, 08 Jun 2026 06:40:28 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id WTetw2ThIDvkeWTetweocS; Mon, 08 Jun 2026 06:40:28 +0000
X-Authority-Analysis: v=2.4 cv=RaOQC0tv c=1 sm=1 tr=0 ts=6a2663dc
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xXI2k2ThDbWjlS29H/wBX1b7plGsL0/2PTxhF2rfBn8=; b=ZxHPrRWkSpYAdX5VxpSBI2KcUI
	c41fJIh9aau6Y3kUUmAPhzprsCYYQ2WcivBk38SStSyOaO+Y/DTcYHaNxe410fWxeYgKQVRgOIx8W
	DZk+Ko/r7nCUfRKWd8LxmY6pzuUk+iAHvGiUZwHAHDqGTEAAYQFWeYuHYrRgfGyOMZGL4LZzCSbxx
	lX588pE3NymBAoMgBwY4oCCul7Ke/ssrqFCpf2Z1nRuivhJ0b5wtdCq60/tMe1XQzv+tO3UA9deFN
	E+MrOdpGG6/BwjBOInHENMjQXBi+B3JWfpGJjxCRy1/IIwzTQsPD9pBDo//op+T3s7gsiRRzgU3VZ
	EAcr4SUQ==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:51166 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <re@w6rz.net>)
	id 1wWTes-00000000Z2b-3x5R;
	Mon, 08 Jun 2026 00:40:26 -0600
Message-ID: <84dbb397-2829-43cd-b630-38d42b5fda9a@w6rz.net>
Date: Sun, 7 Jun 2026 23:40:24 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.0 000/332] 7.0.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260607095728.031258202@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
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
X-Exim-ID: 1wWTes-00000000Z2b-3x5R
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:51166
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNnSYYjFm9qGWJXRvihrjN4SLzyvlBXxKDc5F2CIgQ3CzMLtBUjs9gxkGl3IVj3TArjYK8p11W7hJ1vNZ6QQdioGE5XDaPAD3Tv5Vl3x+6C3jfKDed7i
 dl7Qu5dQ0jlZixa8gkayz12M4IT49jhUd/do+5T5CJ90za4fs1OHdvBALrWb8bLsqT/XV7xu/o2Jjw==

On 6/7/26 02:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.12 release.
> There are 332 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 09 Jun 2026 09:56:44 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.0.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

