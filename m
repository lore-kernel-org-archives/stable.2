Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599E01E5201
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780279834; cv=none; b=I8bZ0Lhk0WrdD4dhEJNCpY/I4Abee93e5p5XU813bQGwADONvJ3BryuuJNUHvojSEqonvWyugsUtkwtGtgJ+RsZA529jW6E98Lrhylkm/K0BnhjagmQXMoRGbqGP6O8kvRkHIJzOJWkM0dZamnBPR1SXY+kFY+FNALi4NlfCRwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780279834; c=relaxed/simple;
	bh=fN6ZAPmjC1KT89ZRwLzHO526BhwwrqeIL5qrOeC69Hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=geQDZCF5CfXC9rZMmn74+dzz/L893X7HohOVBCjQtDukU8hg7HTgwo0f3oyXXmhfm4UBiswJX3Xw21/Y2tD8R1BptqCvhdwipH2S2ZmaCS7VnJpdcg5ToJgotpKYrw7CXfGJap0tLIUDKk025UHujLUUHyA78ZCrIfPo6VCIKGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=n1IIuaPx; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="n1IIuaPx"
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id TovuwFW2XMFEgTs6kwF1im; Mon, 01 Jun 2026 02:10:26 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Ts6jwUPKB7Q5NTs6kwfxsi; Mon, 01 Jun 2026 02:10:26 +0000
X-Authority-Analysis: v=2.4 cv=UIDdHDfy c=1 sm=1 tr=0 ts=6a1cea12
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=orxGh90K4GmqgqR1d9oA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G/+VodVezhYEEYX7ciq1egDyX2LcPy3ByuPpQFaOJGI=; b=n1IIuaPxa0A36ZeETBhxELh/y+
	LkFO+QdcU6c6rBLD/ODHUoaQyU0wgmUn8EAWvfxHpVBftKfZHD03yvjEXZbmkIJinWIgZlnct0vBm
	sRxr6RDBPudroQUtOylR5b6hImM3FsK211wdqxEKoMKVC37EEXDe8HCRcALFnhPCvv1/mf2C1u0At
	35bpty/0/AoFN5G/kWfSMq0cfzRxroSoR6yER8hKuuFm0AdqDemxz1xao69HnC7tbJsmcUWc4fKGU
	dRF0m2osAHWPHnsCC1KmyLSP7x+E24rpSAa+GiW0oSE9vQlLaQTzicFWtI/KArgHX5/62k59+vgR9
	F1GlTUYw==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:53850 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <re@w6rz.net>)
	id 1wTs6j-00000002Bia-1PUA;
	Sun, 31 May 2026 20:10:25 -0600
Message-ID: <a69e6390-8285-4d19-9f03-d97444064801@w6rz.net>
Date: Sun, 31 May 2026 19:10:23 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/776] 5.15.209-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260530160240.228940103@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
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
X-Exim-ID: 1wTs6j-00000002Bia-1PUA
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:53850
X-Source-Auth: re@w6rz.net
X-Email-Count: 39
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfI4XwCeE2nMw8xUEYxJqHh0JTKxI6gB5Yr/cu9Wrj33gQZk6Rs0N9QylwLSL1rOBWnUBgGrOJswntBD6Jo0U62swkKw+E4gH5FZgxQTcayornir/8mSp
 inFG0AyjtaMKNQVjKx8ikPQI1WvU6yV3Glc4pX8q8yeIwbVAQv1PxRNIm8xgTWAZ1mINwxA588tajA==

On 5/30/26 08:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.209 release.
> There are 776 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 01 Jun 2026 16:01:37 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.209-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

