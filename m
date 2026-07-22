Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F11F339399
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784716836; cv=none; b=qB7RygaowRMWB95Xwxp2QmJs/A0Ei98nXldOPGTsTGkAQnJv8yvjL+ExYSTFuwG6VwqyBd/ctMB5Y/FjzvWUEALNhWpchV0YDn9VgJhzRSS98b3sJ2+sKGlvL+wbI15TvkLzErAimERlEnwX9Fw7nlZrfwICpsQZfOSlYgMUJd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784716836; c=relaxed/simple;
	bh=8ZsiCUDb/nlYznnS1GfY66bdWDGuPxr1dgqGsMmXJ4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tbv7wN+5ovCmUQ5NtdhdIPdfberY33EL8dNX/Y6s+0YGFaJYw7BxUKFm3H9/kXwfD7sVDIYMoq9aQjtkpBwnwYmP4zT0XA4s8uB01xEJyC6XgGi/riVCWIUHX9h2IWzyMRMTFxoHt3FMxrJJPv/CXvXOS8O+vopiUeDGkeseJCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=AidyjRYy; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="AidyjRYy"
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id mQpIwH1pkQ4O6mUNNw3UvF; Wed, 22 Jul 2026 10:40:33 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id mUNNwsT9zFb3lmUNNwoJnR; Wed, 22 Jul 2026 10:40:33 +0000
X-Authority-Analysis: v=2.4 cv=Xo36OUF9 c=1 sm=1 tr=0 ts=6a609e21
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=btLXYk-BEA0ieRnlDc8A:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Kgx/OkRXPUEOJAcyUMD9nCgFGQet2bBuI5FYrDUaHGk=; b=AidyjRYyGhFGU0MCLTSxeXaFCi
	IjTCPuJQjLsQRw7Dt97tnZGS0YA614h0UiCg8mEiZKcnZo9jbhEvM+Q5zR8vchQueMmAHMRKnKjWV
	xa+uGDeHohL6X0lnifmiT2nBNPzypWaCVOFJUqjVjCuXU8suqCDGpopsE84T8HyM6W2oX2UAmeiYi
	dpEKB6QgojDyALNX0+tBH4X+5cUWL3IdnK+4E8VByKjruYYAvS/sxaH3MlqXQI0JzBnv43C7IXss6
	DnOZiPLUzZfihopQIlPLH/2kKTSIWsZ20Dj6WpOZF3NXZ2DTaCbEBhKEB+yxNVfNWQwNYYkkc2p8H
	jSWeTaFA==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:58490 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <re@w6rz.net>)
	id 1wmUNM-000000015QD-2m3V;
	Wed, 22 Jul 2026 04:40:32 -0600
Message-ID: <3093d16e-9ccd-4edb-9fbf-8cbe9274ced2@w6rz.net>
Date: Wed, 22 Jul 2026 03:40:30 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 0000/1611] 6.18.40-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260721152514.750365251@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260721152514.750365251@linuxfoundation.org>
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
X-Exim-ID: 1wmUNM-000000015QD-2m3V
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:58490
X-Source-Auth: re@w6rz.net
X-Email-Count: 39
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJOts8Z8y5DZOwEzhulLpUQWoL/6WPhi6y/NeGU0MfgOKMyiYs8jp7N42+cAaQvb7LURWJw+eoqdvKRZcrsjXX4cfiGpkTEWlIKGMDXZgex4MTZ8wdeX
 r2nSWUtfChC3dQuOxZiyclq4A9+uKognLNzP2LzM+YwCW3Yrld9xpnZ5gS9AqleFekAG4HpYfYOuTQ==

On 7/21/26 08:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.40 release.
> There are 1611 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 23 Jul 2026 15:23:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.40-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

