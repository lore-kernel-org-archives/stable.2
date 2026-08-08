Received: from omta033.useast.a.cloudfilter.net (omta033.useast.a.cloudfilter.net [44.202.169.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C138D1D6DA9
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786229360; cv=none; b=S2IW9/F9qJI6A4ab8rV0RGdBbdy2jXLsfw6GRfECTzYg5+7Dvxi4gGzkz+E4aKY9xAvh7XYYvwYMHHe4JsltEkdCca3db6GhEr+3eOmMsFYzCjSlcQ1tF945ZqlAnXWUQ097n4UpRGWBUi5vPZJotxY7KVTCtA+sVlLmlnOkVGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786229360; c=relaxed/simple;
	bh=nbJkoYtHmRYEXv4rbytcG0uGBDMhVlChoKbBzE+ihgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZUvfiK/UCMl6wYaeBvDrM8KbkShMLFk6624bTlIhoTF+lkKJNqVLaDosnneetI0e/bomHFjoxwdMeRVTW6EBP+E8OnjN6wnTTCg1gKSJ04ezwmogovrMdmLgEbIKZ99JXCyuVmZse9+qNO0Lx1AreFbHm5kN4Jyx8DMeyAVEHjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=2dVbmWiL; arc=none smtp.client-ip=44.202.169.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="2dVbmWiL"
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id skChwKgZSPG7QsppOwBqkg; Sat, 08 Aug 2026 22:47:42 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id sppNwg62ilaKXsppOwbKdd; Sat, 08 Aug 2026 22:47:42 +0000
X-Authority-Analysis: v=2.4 cv=GsRC+l1C c=1 sm=1 tr=0 ts=6a77b20e
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0UlE9Iat0v3nRsALuA2RnjzlsgagZ0aC8+Qbq4YVHx8=; b=2dVbmWiLvokTtyeDgFFKoBIUJP
	iTnAL4QGVGj0T0WBs4t8tee4kbgLVxHyIIYl1k3jtZ8L6DZMg/gP/m8PmWlzgC6Jg5WPQarm2GFm4
	a8NsVDbXaZLL5CmSOUNm356S5Tt19Ro1adznPTRLYSLF52GpHnVYQDJRP7CzkVrmPkM2ExOTdccgV
	XZ8SsyWr+6kHFphTUK6Cx8990CY3IgNMe17kgrc4lQkMxk6E0vTAOfLmsA2z1ZL1VUge3ujmgF8rf
	Z1CjDWQgssI9Q6i9b63awUe4mlaKf/gW9BqQBp6ipM3EGDK3SJs8oYuRSBXFEZS8ECZ9w5x3boGQ2
	fafEGtIg==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:34710 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.5)
	(envelope-from <re@w6rz.net>)
	id 1wsppN-0000000342f-0MxG;
	Sat, 08 Aug 2026 16:47:41 -0600
Message-ID: <d69355a2-a52f-4a97-8536-b6e3ff66bcb4@w6rz.net>
Date: Sat, 8 Aug 2026 15:47:39 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/396] 6.18.44-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260807143424.272339768@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260807143424.272339768@linuxfoundation.org>
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
X-Exim-ID: 1wsppN-0000000342f-0MxG
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:34710
X-Source-Auth: re@w6rz.net
X-Email-Count: 39
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMNYBSfhe8xKdXWLX1XrU68ULmhE1wSflfZ3ZsC/d7C7uZCbJDPuVF5JW1CfCkPfDakGnEv6AGI5tiEfDjbjjCV6rv/Qh8JSg2RRjLjERlKs7+8WqRTH
 rPPTupfN3o3VScRpFHU21UzKuWjb6JynpU7srtMjAVU272gZD9pq7gCZe40GNXFVtTZj/vDY13xKsg==

On 8/7/26 07:32, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.44 release.
> There are 396 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 09 Aug 2026 14:33:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.44-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

