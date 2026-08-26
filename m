Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F473612E8
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 06:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787725699; cv=none; b=eiyeFStJP4HB6oaLeqNcWAJcW7fs5ru3bDms1BCtxBjQ4AU7YGMHAlbxjMnqc1LFYeDQcCEuqA7nXlT2SqCtJCmY+BzZe3luUP0TvQkeJjacFfmbaR08g2wY9rveJILHzrehaGNUB5KKBrXRjf5InaPMNoRk5lcdGNHaczDxtmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787725699; c=relaxed/simple;
	bh=mvf9fptHrIytQWVX9TK4rpN4qT7IqRe5pzEuP38eHpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/7H7hadIruYn5tq/pUr5b3/QinH76oUYXD6T2iF3/yNCDaQSOY86MnLO1Wrj4i+WCPom1trewjiHBsjH0itJTVqDVNP6AOq/RKGejMGNRKDJlnaN1ojmsCVbRQeUM4ccR6v8F3SGRdlM6idcxQAoT5k2GxWNsRorWC7CF6SE+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=IG5WWDFO; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="IG5WWDFO"
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id z4PhwjEp3v0ndz77SwA7KU; Wed, 26 Aug 2026 06:28:18 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id z77RwxsdbUNmNz77RwHdaX; Wed, 26 Aug 2026 06:28:17 +0000
X-Authority-Analysis: v=2.4 cv=BpKdwZX5 c=1 sm=1 tr=0 ts=6a8e8781
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
	bh=c1G0bHz62+Tp9r3PtaGtCDkfb+1PsO87/ndv7A4SLXE=; b=IG5WWDFO9/kfl64k3H/RsBG0Bq
	Ez//TKCWCeL/3sDdJb5yLYexuBrtzKisGsz8NwJsV6UK4TjFjHwzethjWEPBHstIhX0/IYZTQYed4
	oNfwyI6IdpUV4jw/d8pqnixlAug0qQ5S7QDWFgkFQEcr0O8ZL4m2ghs3YQ1bBbrlIBK9mXP4Jcf4x
	BvdzEkiVW6zzs0clKwj6VDIofuQUQ5xqK1K0rzv0OUnn7r0A0xThXhQyEYNTuLVFohzYfj0o9AsqR
	MBQIoRVL3UlMJSvoqq95EiwI144u57O0DcvhxXY9fCPRkY6U97z+Nsxdpv1NIPTkZ2CihKfytZwBX
	0Bv+XVcA==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:49304 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.5)
	(envelope-from <re@w6rz.net>)
	id 1wz77Q-00000004A1b-464V;
	Wed, 26 Aug 2026 00:28:17 -0600
Message-ID: <c5771e16-a355-4825-8c10-84c1034c68c9@w6rz.net>
Date: Tue, 25 Aug 2026 23:28:15 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/79] 6.1.185-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260825132541.677185791@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260825132541.677185791@linuxfoundation.org>
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
X-Exim-ID: 1wz77Q-00000004A1b-464V
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:49304
X-Source-Auth: re@w6rz.net
X-Email-Count: 99
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNwuQlYW5jty0cAK5/WKSazyu1PLUeEDJK7K+ViLG8bIXm3JlscChP0u8iSiVxas3l0NY+4h0nLr5Zsul4jON0DKM+TPzl2SMLI42fM57nvAr29EDkmr
 ee0joV+IsDM5y2ThsBwnxwHlkizor5FlXcjkCdFkXuSlfL/L5/aoi58V7cGha4rZ4E/tMY7s+T794A==

On 8/25/26 06:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.185 release.
> There are 79 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Aug 2026 13:25:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.185-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

