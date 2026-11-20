Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795146544;
	b=0/Wx3P/bI8riu8Qt2WguZPf5eIBs/C09NDKD45yv3YddKYRSmHU6W3IPPcEyvSetzNyQ
	 wKtpAhrbnqtmq9ZXUwEnHtipTfMCgmDXgAYniMpu3r/Lup851kLFvsDYkIbJC4BNUZgz4
	 6tXBeDpJ1ji7Qw7sy86Tonbw3Dl8l1Mbm+TQwJ2RR9D9+k9hMtyOMlM9vd+uxCmzMHwsW
	 WcoLl2M7iav3iEY5WLJoiX5hMHgkExAHuWeZ3aef6tEZKmpY1g3ms8abkiPiPCy9GWtGm
	 zBeo5Nh11gBQyhaRvLXt5EPPKExdWGaJvRByVktjKCAZqpEQLl7I+Op8XvHiwsKBJFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795146544;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=Zco+vsDiuTkuchE2V0It04Q7u5Lrw1KXwk/PEY7WmKY=;
	b=B7vJRTTWJURoNP6P3cUkJxfIMFMkOwZ4ysvH/LfiJBTaTik3BBrBsLAvJ2lVvOwb9hn7
	 a/vPkl7xgsZm/IwT002vnqI1R8LU7uZ7THcoWuaQtkWrejnUrPKZW97y667KcZU8pMgg4
	 N3nOYmcUeDVf36pKKJNrDMABsY2tBVMEb0Tb37UcFDMretD2kONVKvm/MOltirNLtwc02
	 4+WUXkQmI1eBi+8DQWaAz7V3Uif6Gs7+rfWpJCAfHCOtGIGnWMpebnGTKx0doyKl6D4/C
	 pusjVBnlJGmevcFWx386A6l8fknOz4Qm5xVTdvnsQlGwNtB2VwtlUIZwNzRyNImaF3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=w6rz.net;
	spf=pass smtp.mailfrom=w6rz.net;
	dkim=pass header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=y89H6vHF;
	arc=none smtp.remote-ip=35.89.44.35
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F4A60A2600
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 03:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49F4A60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=y89H6vHF
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id U90mxfEIcRiNxUFcPxzHps; Fri, 20 Nov 2026 03:48:58 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id UFcPxmtTfb2qJUFcPxMZQp; Fri, 20 Nov 2026 03:48:57 +0000
X-Authority-Analysis: v=2.4 cv=A7tsP7WG c=1 sm=1 tr=0 ts=6affc329
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=NwvxdXf9XnxnMUXhnXUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Zco+vsDiuTkuchE2V0It04Q7u5Lrw1KXwk/PEY7WmKY=; b=y89H6vHF0TVfVCSC15wAKsTxRR
	2Rg9Ul1BM2HyE5MjlU+FsqZQwSFtulpTXykeUo+qktbNZPsLP1cbgBtH/pG3Gpxemz7wwAHJCuBB3
	kD3ymuAmPv/cGa2C0tHTtn5lhxHLpqDnx8mcRXhyXLCKWGLI2E1PqsF/kA2Iu20x5nmQ9/ZTWdjpD
	GwA9nY/n+oIrBYGldA0qMw8IqEXT87Zh1afiA8W9n0nXNnNDoQhLmNzVIdkQSGSwZ/gaNDaAxKle1
	f2yR5wIwj8FvEZUD78fiyExOMYxQ6FUJWciyuZyDVmc672ZPN1uBYCtKRux6mj+xVBOsxuIzDfvaS
	tqMZ9M6Q==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:52370 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <re@w6rz.net>)
	id 1xUFcO-00000001JNu-2GMl;
	Thu, 19 Nov 2026 20:48:56 -0700
Message-ID: <a05b808c-3046-4850-9f34-8c399b6c5c9c@w6rz.net>
Date: Thu, 19 Nov 2026 19:48:54 -0800
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
Subject: Re: [PATCH 6.1 0000/2857] 6.1.193-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261118150201.293410965@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20261118150201.293410965@linuxfoundation.org>
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
X-Exim-ID: 1xUFcO-00000001JNu-2GMl
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:52370
X-Source-Auth: re@w6rz.net
X-Email-Count: 99
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNZKf9xE1++866vnJ/m5uK2eY4WZvTk/DAoFAgBI2HcnyrxtflN57NQvaPN6YRMFzXUalRDeaRbYYBY3lfbFKybFpGFxPOmtwmbxheQA65GSVOP8EGGV
 DIfcT+X88Omi4u0bgZlBUeLZpndTcGH4u8+Fb8y/Bs4Dmt9b6uDSIzRBQcABqdBIBAcfyy3TWH3o+w==

On 11/18/26 06:17, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.193 release.
> There are 2857 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 20 Nov 2026 14:55:40 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.193-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

