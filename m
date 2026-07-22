Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620344C0404
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784718830; cv=none; b=QONatlO6nsXtbWLpBh94UtKZPZp4f2MnWl05AgUehi1Ki+9glTZGOY4GzfarxVaAQwjZuCVgn++OoTvFp92lSMVgPnOWEsCBqWogYnsO/DvraN1JaYmY/fpidmwfQOJno2xjlpPTGMMGf2FzYd44zAbLnkgSpwwRpOF/EGqDONY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784718830; c=relaxed/simple;
	bh=V8nyTqVeinNZs782XGXwO0/h27A+CV465kKrhXFZfLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IubHdvgcEeZLbrKMYDoXxqgTkMq7zJgsW+uoTqIqhF7X1M01WF//56XaZsn+BYp4mZ3dWzVDo/Dr5UGSggmyP7+RiN7omv5NRi7aHqrUYThA4R6Vn95KqB++mYO2Exwu4ieXuNyCcTxkI1wfCnCw/3FwTJosK6LsHhGUoEZv7hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=eK/oHPWb; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="eK/oHPWb"
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id mGdKwN5PBv0ndmUtUwboY2; Wed, 22 Jul 2026 11:13:44 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id mUtTwAIZBR2QymUtUwvDlY; Wed, 22 Jul 2026 11:13:44 +0000
X-Authority-Analysis: v=2.4 cv=fI053Yae c=1 sm=1 tr=0 ts=6a60a5e8
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=VocbDb29xj3l8AXDzXYA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OJ1srMzSBDBcXiVZgvSCPTv9lXoPvUh9oJ7zI4F6V/E=; b=eK/oHPWbEUw6h9rgXNDxZ/xN94
	1gjg/0TiO/6qWW/OSgf6kqClaYk1XaTSigVptl+BY68ij9XyIF/Ic6PvDFuPTv1Qi8vz+0JTab5l8
	3Xyk9dIJ9rWmMrypyNXRCKIRHLYeZlH1Gk8n6T6JQC/tfV1MUj8iw4e9dVN6/3DZO7Re6EZmk8ULH
	Boqk4eMVxBf3Z7NuiTeVUjU4gGRsom/Xiy0BzE1KM/9McTp5yLtnX923K5tVmiIkmfZ1cF5vRvTrc
	XfPMfGMpWyIXB6IBA6rHC3GBMehVtiB8PS9A5+HI3MrqREwRcwH4sYkRGoZ2meU/h3cT3cfI4c8Ez
	gCjiSnAQ==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:36028 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <re@w6rz.net>)
	id 1wmUtT-00000001RrP-0Pmp;
	Wed, 22 Jul 2026 05:13:43 -0600
Message-ID: <4ff61285-8c27-497f-b56b-70f974bb53d2@w6rz.net>
Date: Wed, 22 Jul 2026 04:13:41 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/843] 5.15.212-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260721152405.946368001@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260721152405.946368001@linuxfoundation.org>
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
X-Exim-ID: 1wmUtT-00000001RrP-0Pmp
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:36028
X-Source-Auth: re@w6rz.net
X-Email-Count: 39
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGsP3JOjOh64YI3Bpu5/gnokYlQqobgQDzHfQKTHFtBbUISixOLLbozEpzQzLsXacCVTn53J00s3b+LMwRZem1YuJo4MA8MVXK6zSSrrFOg6upeou3PH
 TLevLTmWcImddbymVjth53WSMDOf+2ciRVIpggqd1b614XUW7xgdpsO833YwzqrwZ/yGCykcvl8quQ==

On 7/21/26 08:13, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.212 release.
> There are 843 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 23 Jul 2026 15:23:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.212-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

