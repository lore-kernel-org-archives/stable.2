Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795144500;
	b=2iXA5gtLBcc3wgs10WbEKV2dWKg1zfEVB/EYqZchu13KiGEBoxzomtwzrlnDM/UiI69R
	 f4b25KkI56XvvoZZmxXWkLExnfwMUO/8d3L53iqiEGl/lKnlx4HwM4ZXX93qCqvkRy9lb
	 hn9L2fTGTFkgZKURbWx3i19Kbyuck91r5blvzeKv6A6spY2XEVIlshLRxV32qR3+abhkU
	 +kqxxPY8wTOZ7oU0OQ1B/CwnMdHe0nQKnUBypvgd6AtB3TNfpe8y1mOlR+U3A/Mjay+jB
	 2iNiVi5EcHfhMgMNuCvnfh8k6yp5tsuoHxPd8mfXq8o5jgkkfgbfoT4/MZ7K77TaOxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795144500;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=sIt34kRTlhv3m0e1Tfl7/Dz6yo53/Myg2aIV0V/BzPY=;
	b=Gjz/8INtlHzborvWKtJQztZSyFqyKqkTlx8b8mm4ntEn1VpU+U18OszJQD+Edb0IQtP2
	 GoTUNObvlBHJ9oBWbLzMmWTTJirUjTr1FV5fQkWuFLTVBgPuCNlzda+jZvuUv/roJw9YA
	 Z8g1uNkAW8D30NLHzewEYrz0mLWTK2k87qahuupfxGGUQX9AEN3pzRgd0+pyAutxJH5je
	 61EySYxch0PwcdyvrA/7r5zRXqlfXH2YaPckwPogKn/KaD8JAs/CQ+0Mw1O7L2v5dJEu/
	 1aFKw94wINQbNe0oYO/uFPPcVMG4xe5bDlgEyp7n9kpiUESDD8ry16BdFEnkM01dQxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=w6rz.net;
	spf=pass smtp.mailfrom=w6rz.net;
	dkim=pass header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=PvRNqu+x;
	arc=none smtp.remote-ip=35.89.44.35
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729DE606A32C
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 03:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 729DE606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=PvRNqu+x
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id U9EhxfIHURiNxUF5Vxz8Lm; Fri, 20 Nov 2026 03:14:58 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id UF5Vxr2z8YskhUF5Vx7wO6; Fri, 20 Nov 2026 03:14:57 +0000
X-Authority-Analysis: v=2.4 cv=CKMqXQrD c=1 sm=1 tr=0 ts=6affbb31
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=B9BhxveEpzRwE-jvybsA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sIt34kRTlhv3m0e1Tfl7/Dz6yo53/Myg2aIV0V/BzPY=; b=PvRNqu+xHfCL0FXt+aqRysimgk
	/HrN+J2kBb0T/hM8BKSOpZgCg2Z7Yw8CoDHLXVGH0xNsNJHOIFacu1G2Hw4v+1NiLhXTmdz38yuZR
	dRiFI9PVQtOjpHw1JUnwN3SMJXZzEXbvavhc+fkEtXx5FzFHS8pj55+t5jnf4qSzaZ9vzs7I9IVQK
	tqY4vfQDv1Q43ukfFo8Jvi3XEsetX0mAjgiH3SVpjVcLgV4K/ns6i7DICLYuxcMF1J7DlEcWgAej0
	kpPjw9cWY3xZwzQTbHB8Yg+/Bc739Wf12fsAUV9AFqJaNRiUTB+5zoB0IeGEWM0TL4D4hZUO9nNiD
	RdmL0GaA==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:50260 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <re@w6rz.net>)
	id 1xUF5U-000000010vg-1CBA;
	Thu, 19 Nov 2026 20:14:56 -0700
Message-ID: <91bdf95e-74aa-4911-b874-cff75d92224d@w6rz.net>
Date: Thu, 19 Nov 2026 19:14:54 -0800
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
Subject: Re: [PATCH 7.3 0000/2651] 7.3.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261118150247.972732815@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20261118150247.972732815@linuxfoundation.org>
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
X-Exim-ID: 1xUF5U-000000010vg-1CBA
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:50260
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLJs7deeHQpX4Xk4nhqf4JBZeOqX/lR1PoaMrWg9QadgiK6ogQlx229LhYAmj5yppHF4HQzy9COppvUYXUeBJthXhFiEOx0eHx/vpGjbG6V1y02LgLDy
 Zf90ZiWrHfGww5IOQK1Ye68nyrLyD6KyokiHJevlfQ91ZaHKzraPWaq5u3Ccrumco9XHWgbKO2CTOw==

On 11/18/26 06:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.3.6 release.
> There are 2651 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 20 Nov 2026 14:55:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.3.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.3.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

