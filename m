Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0583D9DB0
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 08:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769757; cv=none; b=SVbbDP1Tp1+JnhBFpM7CCou3+djZW60KeDWmPyhvjQWMlBXM6x0JIgx16L8V1TE+4Eex/h2oV7IB+IpI7zpC7pLH9oqbh4P6CuQaIB7d2L5o3C9PSngfDHnYJWXX2W1s/5ZNehNQu3S1HrswbZWitbFDluCmmC+Rn/EolQg+JYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769757; c=relaxed/simple;
	bh=TvFE4tGHf2RZ6ILic0wX5yx04G98MgXtRv2R8lhd14Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IJnuiQzJFVRsYre+CUFKTFxpyL93Y3uqQyi4AgWfPx4UUNy4fSTV6GKNMmiULNi+xw1lE2vbQjV/6YqrrBYrqfHRWsFvYDpFN0p0g/mKcNlOIPKWF5o3WoaqBHi1Eois3JXMC1pOHRNffDjxoPbQWorINoaojSG1f+0BudNi6Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=0XbmN58u; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="0XbmN58u"
Received: from eig-obgw-5007b.ext.cloudfilter.net ([10.0.29.167])
	by cmsmtp with ESMTPS
	id a3xmw9t7yKSRRa7hlw4JfO; Thu, 18 Jun 2026 08:02:29 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id a7hkwtz6r9e09a7hlwjVIT; Thu, 18 Jun 2026 08:02:29 +0000
X-Authority-Analysis: v=2.4 cv=SY/3duRu c=1 sm=1 tr=0 ts=6a33a615
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=9GQXaQUDpQhx98mIA28A:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xMNwgo/lkKMJCS8Mt489WM0G0veblTtY9Wz5haT6LLs=; b=0XbmN58uYyG/+k888i8TudVon0
	9QrGzOlskpKLF3pd8kOZ8KJKMbAGVqp1CJXt/IbQdwowhLgrZRB14dAek4aBssS4XV1oE47/iOl6z
	u1URdIScXHGmbUU/8z2FCc8stuZe7NKKQQakRIo+RzZBbNfbYRlquDpuTUqyC4SwRWZn+MU/fPFd+
	uW0bE/xZTkjGvIqslirVESVphUXQhXeYiS9hftLxm/18E7iaLCNDHhrS7yVk02b6KRae2UBUzLXG4
	WnDSbwkqBZTCBnV5kjgre6ECeJ0U4hbbaEQ3clKrijjjhy8Nm5FG7yD2xhikLT1Flnh41D3P1yF04
	RQ1R1h2w==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:46348 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <re@w6rz.net>)
	id 1wa7hk-00000002PRd-1QTl;
	Thu, 18 Jun 2026 02:02:28 -0600
Message-ID: <afe43ba2-1fd4-4a77-a589-5a4886615dda@w6rz.net>
Date: Thu, 18 Jun 2026 01:02:26 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/325] 6.18.36-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260616145057.827196531@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
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
X-Exim-ID: 1wa7hk-00000002PRd-1QTl
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:46348
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPdStjuEvsYMMoqM7yDhkHsKLzjR06Pv4dLw4C6Rqf1YBJXVleqWVUC9ZtdDYzI+ttgRACFjxLBITHWBmEbEXnYJWt3olUsvV0jaFM4nz9/SDIdS1meq
 gxOzqtHLZ4keESSz3gVrmFrT30FeNrW5bwfnOZK+lfsHI1f24S9pOi/Z5apUx2Kb5qnmwqremVZXow==

On 6/16/26 07:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.36 release.
> There are 325 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 18 Jun 2026 14:49:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.36-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

