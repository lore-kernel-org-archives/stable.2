Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA603905E4
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 07:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791616871; cv=none; b=ovbS7ojekH0dfzEDMumLGGkw2NhX2xH3ikaB4VsAHs+Qr/puKyvxHjgFd6u0vh1VlrFeMbY4YeaasC2HIHJGObi7FZ0QEGyazfrg61VKSw6VHwfp9fetSz7mwvqgzcgg5y3E8aZYqPuxrkflEqFXS87qmsDuLsxm/sRJLHUvmwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791616871; c=relaxed/simple;
	bh=4Jyhsg8tONGiU2+o7ZYzh4JKA2+hVw7bZNNIAvqA9Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VUA1UNSwK2cjoK1OdqXTuw3uGj58MfnguZEk+Qa7DYPoyHTdjwL7w3Cv/jGzHBOzAeoiWlGT7qSk4KQIWONygg7+d6UgWMgHKPsaFkZfzIGvT8Dsn04pslvs+NjMaV9koE0/gRcY5N/XKUP5Z0OOvgnVqtE1XGrhyrMylZwM7XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=BDK4RQR5; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="BDK4RQR5"
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id FGPexFLZjJFmFFRMix5yne; Sat, 10 Oct 2026 07:19:32 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id FRMhxB4la369DFRMixbnMI; Sat, 10 Oct 2026 07:19:32 +0000
X-Authority-Analysis: v=2.4 cv=EPgG00ZC c=1 sm=1 tr=0 ts=6ac9e704
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cqIuIlqTxJG9piS4zYBvcWa+FVCUM3JqjM1i6LfyJa8=; b=BDK4RQR5d+1D0cVUztCLBr8Zn9
	M0hdHanMiCoMrzJ1QFxblB8yKjJkobAiaDVNgYaWdzVecF03qGr9zE6KS6yIQ7kqGSg4fhBGVRFCU
	huL8FotZPPeSFKAgsrW5g89fT9Ojjbh3T5d+RCvwkn4U9EEYu2q1B71H7C3O0vQnOVcSCM5E2xXp+
	4tjP5tDtpzF+Fm7epTVwaDNYjJJO/C1SxF6sC/zRh8jLiSMV3xNm9X1kGVDw+uUeFV1wHP41cYi8M
	lFCxHhLJltgSrbE1yrEcyDjagvbee/bvBxaPXJdAp+dLcyPxayhDaSgNaB08BMf5mYWAggCeqOx8B
	tQIiqXQQ==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:57730 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <re@w6rz.net>)
	id 1xFRMh-00000001XSv-08i0;
	Sat, 10 Oct 2026 01:19:31 -0600
Message-ID: <baef05a1-7153-4243-8f14-c1e0ec4b76bd@w6rz.net>
Date: Sat, 10 Oct 2026 00:19:29 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2 000/428] 7.2.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261009140946.008206689@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20261009140946.008206689@linuxfoundation.org>
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
X-Exim-ID: 1xFRMh-00000001XSv-08i0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:57730
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFhUX0ruXNiqEL6PAHOlW+3QzGA0BYWh3RW1yfokKX9jzYPx3u7dYX8E/DSWkfxT6T+WW5Td69MH0OKxL29U2GghhHmGxwjokMb0KamI0aZ9HVSxwsvM
 f22KvYCGcWKHRV8l/vpq6SJUIWbcmi3yUq4/UUlfZ8AQ3lgVJOBVc499QcQTlbNAk2ScFRGWDmvTgg==

On 10/9/26 07:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.10 release.
> There are 428 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 11 Oct 2026 14:08:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

