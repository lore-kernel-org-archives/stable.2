Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795146025;
	b=XOv8Gbs8PdZI2ute0PDaRfWacnVPwba778oPDkjs51MADLgPybDyfIat3nMQq47Tonpx
	 DiX4Q8d2hLD4rP5gphNtj+2zYZHotJf0tXMDg+GXljZ9mABX/jk2FRS3pIAvTDlOF+ces
	 iS+VH5uixqimSxLoj/tsEJxvnQ49TW+qFfldCpmlrj1hbLIk1V25eOgHFzGHjpVUIRKrV
	 VW7xMwR0SmWXwzS2/PI/T53JD3iysvTiIbHmsAEXN5U0SztJhmUw7GzOAhF0NTG1xo/lR
	 d3MLR5XwVnM5HcU+HD8doDuHLAd2q/VzSGGWR5FWoRkAMmWHgl2HdesyZg09vwHERqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795146025;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=xFEuU+Ig2XWSeIveBUY4FuqtWKaIuk8y+p/wf34XVVc=;
	b=jJvD87H0dIeX56w6IO3pzTQKe9HX3r/xn3kWmrIKOTu3YDsZOAsv5fy7dywP52V5ENPD
	 V9RyQaCqEbiTo+bDRUXT+ClYGLZX9qHStwXINYcYKohz/xic4Jpt2tgIyrky6yYxEdeWH
	 gZMStGogqB7RtpmYBigygCMfm7rwV7UP2ouxmnpYHGOEjJx0RQxbqm/5m/9bSFYk8nhsv
	 ZIDuBJC+qeOPe2BROeL+5FSaL4txBxKZGkmQWRmDFS8Bwewfyhte8UPCwxqhC48Z5ygGA
	 3//JPY92MiL4xY1NkpG5uV/mS49J/o86c6OL9+m39S7l2UQfJ+WT3JlEwdiNyqCUwUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=w6rz.net;
	spf=pass smtp.mailfrom=w6rz.net;
	dkim=pass header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=e+AOtmR9;
	arc=none smtp.remote-ip=44.202.169.37
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1141C606A325
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 03:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1141C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=e+AOtmR9
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id U9IXxfEeVV16IUFU8xS0nm; Fri, 20 Nov 2026 03:40:24 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id UFU7xvlVNuJrPUFU7xKjRY; Fri, 20 Nov 2026 03:40:24 +0000
X-Authority-Analysis: v=2.4 cv=WLZ/XmsR c=1 sm=1 tr=0 ts=6affc128
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=uPKWhRKihB2-fsaYkyYA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xFEuU+Ig2XWSeIveBUY4FuqtWKaIuk8y+p/wf34XVVc=; b=e+AOtmR9kjpy8RYN0RrliqALDF
	Ej8CpKgTzaTFvsnm2kFygS1Wmg6EwWWZB1Z234Dzs4ucBrHaBnR2HrA5tpkFPM1eDOSHiP87N//FC
	8Pq9fYqANmqJgJNADZvHo8QIUCE9FjKDVrqMRQjaAp/TuJxDM+AoiFYOjQdIeApRZEwV7GTmmx/VO
	JS04XJENot0CePJsd73VnPzVZMc5I2QeA/8Lx3p/Y8H6TDT6eL26ESwF4E7Y9bQSvWJ9jzMSUemoq
	FXS/83DCP/Woo0lCTgisa66ZIezwt7m7bIxLr+uZng/u+2H+kKEp8RizUJSLu7hO5HkUqy4t13OKK
	epTec/yQ==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:56318 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <re@w6rz.net>)
	id 1xUFU6-00000001Gjg-3Vnf;
	Thu, 19 Nov 2026 20:40:22 -0700
Message-ID: <c27462a9-17f5-4638-bff4-1189ba5fca00@w6rz.net>
Date: Thu, 19 Nov 2026 19:40:21 -0800
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
Subject: Re: [PATCH 6.6 0000/3318] 6.6.163-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261118150313.527275416@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20261118150313.527275416@linuxfoundation.org>
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
X-Exim-ID: 1xUFU6-00000001Gjg-3Vnf
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:56318
X-Source-Auth: re@w6rz.net
X-Email-Count: 79
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJPOAH6l7EtIkiEL44yyZgwgb7as8GsIZsJm9Pm0bl2s0HN+Ue9auytegA8wOFdEUf3yzpuVTAPuL6QwT+IW4HaqsdbG/70UxvcP3AuG0F4XDNEZ577U
 CXtsPJRAk/HoNbZM7iOxwerSKNaS9yElFqg7uW22uGA+rLezCh/Nvj8ySPgmPY8KPKdK0ZP0yvcALQ==

On 11/18/26 06:10, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.163 release.
> There are 3318 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 20 Nov 2026 14:55:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.163-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

