Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795145454;
	b=FzZkI1X9Ew42PYJrGnogzcNCjX9Csd3kOXMXgJMqog6AKlRGMzOzL0oVtk2wYqjGBHJ/
	 ICTrsoznFA64IIZ88i0uJfeFardImFAY9/n1PWtJbitvZTbCUaFlbKx4V/gzt1ELhF9GA
	 9Oi2MOGoD993NMa/yxG52B8P2YY3EYhqBX5b85XRrAVrdzzzUdKrTZsb3xBNX1j99hDmL
	 9MiFpKpnvOcuwwF3Wo+AJjQ23MnUP0Iq3o6l+Tc3MVvN7mVF567zAI+bANIWKbfELU4D5
	 eHh5vQSSC/GHx4ojYguFGj/9W5zJa0dZsig7+Zia0x4ZndKniOXTq+rXlGYcrhkt2JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795145454;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=W/lM912r9uvaLdL/8q5HJWR9397l3o5ybZxliNSzrIU=;
	b=yeuO3H7hAblGeLVLwRkiDzPnjms6dEBB7ntX8XlWYAdHEovN9p0Se59bMeDZ+QaMMDly
	 7JJURd3ZdEqgeFI9FXrmLAnkfeqBbXtfauOUfR1xwDJYB0MX62yrEU76NdwU/DR8b4QVC
	 kWfCHTDM9DVwqloVg6Q+lUtARpXpoKFmHI3gpog4QzAFODcwaWUWfoz3vaDpoZ4DV2Cie
	 cW0rHfpKt1orXjCJLOUH+5WvS+GevrQP/KkhOsTqgkYvh+R4mKA2MlTSKQdOJ0eeX8vl8
	 4ewSKCRGGqEAhSS7CWUHw/Ymwym2pONZfjP7wyVdbVx55/hQ+D+JyJoPkuEAYH5Z1Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=w6rz.net;
	spf=pass smtp.mailfrom=w6rz.net;
	dkim=pass header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=hE18CXLK;
	arc=none smtp.remote-ip=35.89.44.39
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338DD606A32C
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 03:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 338DD606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=hE18CXLK
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id U8Idx4b6Myb4YUFKvxTBxP; Fri, 20 Nov 2026 03:30:53 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id UFKuxmXq4b2qJUFKvxMGfp; Fri, 20 Nov 2026 03:30:53 +0000
X-Authority-Analysis: v=2.4 cv=A7tsP7WG c=1 sm=1 tr=0 ts=6affbeed
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=J9IsvJP-md3V85Un95QA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=W/lM912r9uvaLdL/8q5HJWR9397l3o5ybZxliNSzrIU=; b=hE18CXLKRtZLucE1H3DcejleNq
	7YE6KUFQeFMCNGmlM7k6I9v7B+t2EGYE2C8sMby35n/9qpNz5QAcdwq5VD+OBJXrbRQ1bJPBZUVgn
	p434sVU70PTTzxEQb8TNMkX8T7d9ZMOtOXdbx60/Hf2VQ/FipTQxk7yN2XHv3eIbVwrT1QY+icXLb
	3BRJ0EPRqgK3qlsq82/IKAcNLOM414ZV7I8WSXhackcc3wcI4tRPjvA5YODFfU2d3wAftkqVdgmc8
	Alb2bJb31lHvXiRMFisw8npZZ1QFQnA9/2mJx0xgfwMuyzTlZJXDlCcrfz83aA7ple6a/GjDUOClz
	X+beGEqA==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:38204 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <re@w6rz.net>)
	id 1xUFKu-00000001AD0-0ZzL;
	Thu, 19 Nov 2026 20:30:52 -0700
Message-ID: <214f8c96-5b09-4646-9d82-35c0d0a9b5af@w6rz.net>
Date: Thu, 19 Nov 2026 19:30:50 -0800
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
Subject: Re: [PATCH 6.12 0000/1756] 6.12.119-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261118150007.957976754@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20261118150007.957976754@linuxfoundation.org>
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
X-Exim-ID: 1xUFKu-00000001AD0-0ZzL
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:38204
X-Source-Auth: re@w6rz.net
X-Email-Count: 59
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNPyGS4KdKC9xi4tEQBxeCk0GczJf95z51q6XwqW7Uiw8o/U/JhLxu6XuUlgSWuk4YAqENXsxmfuhqGHmnZYErcCgDR6YFXFxecBOyeXej/tU/jHVZlf
 Cfu4FJSp4FjYbO80d6+pQmIZPUwX44aBC4CFjdVTcm5idyLs9hIp5dpWFYalghb2WrQW5ZINCQlaYg==

On 11/18/26 06:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.119 release.
> There are 1756 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 20 Nov 2026 14:55:44 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.119-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

