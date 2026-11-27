Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795773054;
	b=ibh4GDbPBRtMQnDlCoUGZZwtt7F8ny/0CdQaRP44SgK2ke+clNspgdgRhyHqLY/axS1K
	 I1KtMF69+rQE9HoiJn+BFNwPJaAOhbCk0ERBeE2PnUKuEFL+uI6JIzc9MAdWM6Vck4zPy
	 K6XRvYv9doAHHJzFqkJbvXGUC3is8vDgy/Fp2zU6fgHTEX+mj1+5ePCcesjt919UmjJsx
	 ThZY5E3BbRvUW5GK0nlVYvV9kKBxyrc1JuvvVRh3Yie0wv9/XFnsfOGuxzsswJXcbn5Zb
	 YyCkMODPmHDler8R9WgRU1zCk8XNGG45QUPbWDoD9tmFt1MqpulVDpNokSx/A9dSIkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795773054;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=RSXrQLNW2s0/hlrSN4h5G8iLSM/6lAnsqJ3mo4i2tVg=;
	b=p2w8Z+kAC7FWgl/0haCUzvyNyLWNI00xyvh8yFLrR/Gn+t7hIp2D8pQv664LwAl3F0AT
	 W8xz1vueb4BbCVZFoBVDUfaB8bkCf2/oglg4pGH/zojpPUEcvB/IS8W8FA/M25Z17IddO
	 rKNSITeb3yvzlYiMYArpmtQ8MIsJWDfawZx9bG2dMNg9HKWKG0s5OONzqkVmDD2bzVlh5
	 rmL9P71008NTor7KAtrJ4Fuj2QciK00/sJS/MgrVhJtTnrIJ4A8uWCMsnaKU0Dho3UfsW
	 z6pAONmo5fiXy6L35QoUcGFsKqRtytiia+O1B7l3vvSsMfSE9LJGFUkj5UbnMOT2SHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=w6rz.net;
	spf=pass smtp.mailfrom=w6rz.net;
	dkim=pass header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=MUbuZDUt;
	arc=none smtp.remote-ip=44.202.169.35
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D283606A324
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D283606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=MUbuZDUt
Received: from eig-obgw-6002b.ext.cloudfilter.net ([10.0.30.203])
	by cmsmtp with ESMTPS
	id WjS7xDD6d4vCDWsbVxkr5o; Fri, 27 Nov 2026 09:50:53 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id WsbUx0Gfu8cn4WsbVxleMz; Fri, 27 Nov 2026 09:50:53 +0000
X-Authority-Analysis: v=2.4 cv=Qrde3Uyd c=1 sm=1 tr=0 ts=6b09527d
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=5gI1kqHO1WKH8RX1p00A:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RSXrQLNW2s0/hlrSN4h5G8iLSM/6lAnsqJ3mo4i2tVg=; b=MUbuZDUtOElybvGsxmuZe26h6o
	XRj7TvY1zVGcoApIi+z82rOjq1NFfbBrn1OBZptLlN+Pdnjspkt5WDrbiYQaveNGJDxsjO3LVjrKH
	9SbKQ0jbzwykbXn1EkJLtWoAIeWNnavMKrsRUA308l0E79UnXUQ0MacTrmq+uw2nRocGZrmKNZF+1
	X9COdI1kqsAekFnaGxmiPqLlCbs2jYPt+BiwFMVXzzjj9toulW7zfYsE1EAbzqbGcD5EF5afXDK3H
	7p5KEdTcVR58m5FWWOgda6K5lgogDDtiWVMHY0DvGgwe4ze2rAfdK5WDE87QwStiR+azTOnxtC6Kx
	3QRQ9aJw==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:36792 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <re@w6rz.net>)
	id 1xWsbU-00000000IlN-14B5;
	Fri, 27 Nov 2026 02:50:52 -0700
Message-ID: <dd3e38bd-78c8-4d03-b998-6c3bbdfc003d@w6rz.net>
Date: Fri, 27 Nov 2026 01:50:50 -0800
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
Subject: Re: [PATCH 5.15 000/318] 5.15.227-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261127052515.841545444@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20261127052515.841545444@linuxfoundation.org>
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
X-Exim-ID: 1xWsbU-00000000IlN-14B5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:36792
X-Source-Auth: re@w6rz.net
X-Email-Count: 79
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFeAs5If2uQukBYCvK8oEEjACcjappgR61m/O1A5cdn9gLwYOWP7jdsW27BKay6v+QLx0p7flI/9NW+tu+iEIi3ihAwkzRxMFtAOzwJ3S6qRcemUIXEG
 KVH2dAhzoj703VjtVPoF14w2MIj1qIkNRe+1D5EiZbxhObox3JuMgNS1OrQk0rfVjUPn0R4vv21llA==

On 11/26/26 21:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.227 release.
> There are 318 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 29 Nov 2026 05:24:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.227-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

