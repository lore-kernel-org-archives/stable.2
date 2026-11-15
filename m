Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794752228;
	b=DLh1mXP3hwTOaX7yGdd2VEnE6az96hPmsk12LI56B81gDvSbBYwr5tEgt1uhhb16jwjs
	 ZiRAo5WQVdD8biMCZc2A7iEJupNBD1AAIM66UhtpbE1uFGb5KH33CfEKHgCdG7EmYYmLO
	 V97TKaAKkeqtt6dUbe/chrUc5IMm2QiyHpwUdTaWkwrfq3ICR8RU1930CTWrmaCY4rT+i
	 KiRJaMBqGdudAoP12hnsEiq/7TviXXqzMGdwZlogRrjM5N8lWA37Nglw9CNmfbfB17h6r
	 bwxmAQ2nxdFIKCVA9/WihpQH4J5D0JzOR6ptiFuoyVq5LhFH8k2dU0hgaZ9oYi6Vjuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794752228;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=gS08nx6E+GdMwUKMxQlq7yy6Ruq9fXBNYObCE0ELEws=;
	b=zQ6EEHswf8lpNTmC7UzolzudxkApYfCLZ+Q8x7BdEm5hxSjlTkhVkPFhmwYZegvZT6KW
	 Uwxd21UIbdNzLpIXkrUQwFgKa0v4CEK1z+wl6zb79SqZRmz93oCDiLGhyYu9pIW+UXz8K
	 sjrDEvZbzSP4QbvsTr4fOFVQmyn8HzsNvFPCZoWC1sql1edxSMTGzxnCyX9Ny308QVN5q
	 f8pnXZ4jeajHKUuFEfoWA/pDhJCaLNpk/7Za2ILfbuoTe1AYxF8iu7TtQDfoWuIAnuSzP
	 L7WBSIY1OOFw7OZIsx4udDaE9HIhNtqOvhIEZjbD0Ddmdd5tee3nVuQ+VAJWySf7JmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=w6rz.net;
	spf=pass smtp.mailfrom=w6rz.net;
	dkim=pass header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=Stma9F5U;
	arc=none smtp.remote-ip=44.202.169.39
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F009606A32D
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 14:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F009606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=Stma9F5U
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id S5rvxYzpROOJnSb2YxzILt; Sun, 15 Nov 2026 14:17:06 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Sb2Yx8txwlaNKSb2YxKtWy; Sun, 15 Nov 2026 14:17:06 +0000
X-Authority-Analysis: v=2.4 cv=UbpRSLSN c=1 sm=1 tr=0 ts=6af9bee2
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
	bh=gS08nx6E+GdMwUKMxQlq7yy6Ruq9fXBNYObCE0ELEws=; b=Stma9F5UZHhgevnmeD9nA02mr1
	Gj/1oNQz30asqs/8yuH01YseY5TvROFF0P2/iIXTuuV2zeuPlD/UMPTli/NBtiW74BmjwWi5V8L4k
	ojJq/6m4NKAkRkmxHmlxOENvYMgJyQVssTHwxxzBobGIwHWKNarsHNfpjdQibEprhH6q619A7ioof
	DmM/CuUB9ARCXiDJoyOV5tOlP6wqFIC0ZiliZZj8Hdj1XnysSYuEvWqkm670dsY226ubpJpF51Twt
	3IXi4l2BnQIWEg3dLuaB8P4E7EXyGTfszwPM8VmLwaDBeCKD5W53l3F4r42SRuQZsfGh8Wxah5xla
	3Yy6r3zg==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:37548 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <re@w6rz.net>)
	id 1xSb2X-00000003QmG-0bGR;
	Sun, 15 Nov 2026 07:17:05 -0700
Message-ID: <e87f68d9-da69-4528-82ef-be044758282a@w6rz.net>
Date: Sun, 15 Nov 2026 06:17:03 -0800
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
Subject: Re: [PATCH 6.18 000/686] 6.18.64-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261113153820.902362109@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20261113153820.902362109@linuxfoundation.org>
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
X-Exim-ID: 1xSb2X-00000003QmG-0bGR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:37548
X-Source-Auth: re@w6rz.net
X-Email-Count: 39
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKbxdsJCfy6yhIHJD6sm7C8Xdh3hdF7l+AEsl4mqry26sY38XbSQSdyizmWGyC1xacMdAEOZC+NQofvnvzjC8aev1suvcnrKl691DXwbo+QEsYee7NHj
 q6ca1h6Ej6MXj+W2C4xnFinDG4JxduosX+4b5AJlTGN5SUUhIJQgJHlP6poiydzCD341tddh8kIDWg==

On 11/13/26 07:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.64 release.
> There are 686 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 15 Nov 2026 15:36:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.64-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

