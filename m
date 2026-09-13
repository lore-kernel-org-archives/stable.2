Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313043CF67F
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 23:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789341313; cv=none; b=UCtPXFShO3lm9t289mlX1Q3hBrAUCg0apP/RXjuOQpRvmHjMsIfOZcn2LA6Vv/krrN0YIy4z3gs629GnB1nmwovvDv7VYWsJKwuP3mqBUF8Zs0UNz9bl0fz0R5eVYKsTRj1YaCOx2C4zuewrzWtIdoSDl0RWxmVY4sy00RJH5ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789341313; c=relaxed/simple;
	bh=M0AUe6EoSdBKCMt/ZoILgDUcpvH05m13IHeVeD49njs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fpmhwfvqhA+yYJ+hXHgP3G8jce4QAcqdg7PCHtpQ5DZG7pmZL0246Emew1xD3hzoYWLuUgp6yN57rztvKmoGdFogmJvQEJl87Ber3bXFyr8n5bJoSZFzZV3KbEPTU4zv2X8Zqxfjm4KUcA+hCiNuoFgMipHDssi54OT5I2WzYPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=4rbVwlX4; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="4rbVwlX4"
Received: from eig-obgw-6001b.ext.cloudfilter.net ([10.0.30.143])
	by cmsmtp with ESMTPS
	id 5YZfxDBqouFzg5tPjxUg3N; Sun, 13 Sep 2026 23:15:11 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 5tPixl9ut9tXG5tPixHlKe; Sun, 13 Sep 2026 23:15:10 +0000
X-Authority-Analysis: v=2.4 cv=KK1aDEFo c=1 sm=1 tr=0 ts=6aa72e7e
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=0hTlX_r29Uef9z-4MVkA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CZcktUzriNTAAYMXbnWHn5jDYdx8tVszpC76pKHqsFM=; b=4rbVwlX4FarbzxggzRjHdxe8nc
	pIRbmStyUtjd80ME29LEPxmmFZxE0bF7ONjCTTh1ty5rpLjrnkxivgWZUBhC4MH72IBEfkGgGGKEr
	hCc4Fr4kfNUbX/fk4tU+bnzUY3GwgxV4FQfmwRSxNvG69alee+jXaAmt445MC7tqTlcO7NfazOCqt
	8f9DqgfGXlPZJQG/fbFXcoZ8qSYMyYwzhnZd2r9ruWmizqwsCtVmfynPe0IReqyIAVs6FOx55sGvN
	HQtVtvvGFVjZtaooK3ueb0AxL+C8H+FAu4opQi3op4iBr60H4biMOlE7DBXYrmlN9IXJ1JF/1MciZ
	LPoyoDyQ==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:52514 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100)
	(envelope-from <re@w6rz.net>)
	id 1x5tPh-00000002T9R-2ukV;
	Sun, 13 Sep 2026 17:15:09 -0600
Message-ID: <a30618e9-3613-457b-8ae0-23453c75ab9c@w6rz.net>
Date: Sun, 13 Sep 2026 16:15:08 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 0000/1191] 6.1.188-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260912065548.086904252@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260912065548.086904252@linuxfoundation.org>
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
X-Exim-ID: 1x5tPh-00000002T9R-2ukV
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:52514
X-Source-Auth: re@w6rz.net
X-Email-Count: 59
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGphZWRfZRVfdKD7rigRfFfMjVdqA3VxObxl2IH359FeNLYu/U1/mPTEtR34O575dne5vqHfJQ/reqjR0yfH59vQMil9yapDubN6jWsPDQ5dYiNVGi3j
 Wtqv5wggyHxy6J/XC2RU2QiW/i0KkS2Q8H6a0QuzNTAvPldLfNX4Yl5IWBsX6qX6JZ0KpIjY3XutRg==

On 9/11/26 23:45, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.188 release.
> There are 1191 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 14 Sep 2026 06:54:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.188-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

