Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372DC3CF962
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 05:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792040768; cv=none; b=CK9+e3tr9xxThf8RdrGCt322lagTW0HY2iSg23Scwn9O//H9cgEwhzBaz6Z7hWisCzjzu5mciczcR+yYvfEFykmc+ppWBoES8eJnN2CAXrhD+vUKuRhFTdmdq+cstL5ULK4RV0mfbGhVLsV+zThhZNL9XTeDIljkfzmN327wiyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792040768; c=relaxed/simple;
	bh=L9GyfJKy0i+PWVDjSiUZqoSjdLwaf4lg66ej/kIviis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLpp3f0fnFxyqVR9jaqBUtEkv1+XZyXxrtKtvaZ+Q7XjUVcqsOBCdsx59IrdJGZXbqUlsxkBX039+mVQkAeFFf4hrds5RIbempwvmwoaqXbcuOueUWFpgJTvqX+3fJcRWCHlmGKGazuJGZIenciHHWgu22cIbv4vizKOzEkycc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=k/p60Hsw; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="k/p60Hsw"
Received: from eig-obgw-6001b.ext.cloudfilter.net ([10.0.30.143])
	by cmsmtp with ESMTPS
	id HCJHxyWxkusRSHDfFxPQHY; Thu, 15 Oct 2026 05:06:01 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id HDfFxRbk2AJ7UHDfFxiUAE; Thu, 15 Oct 2026 05:06:01 +0000
X-Authority-Analysis: v=2.4 cv=UphjN/wB c=1 sm=1 tr=0 ts=6ad05f39
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=_kS_R5bZiuQTXeyLJeIA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oYtDAAFS9VXuY5pzBUjRbvYRT9tsUMZkbpbrrRzoG4Q=; b=k/p60Hsw79fac2nCaViLGWB9Vt
	SryZ0TqpGKdz92O7ItMGSbWLZ4PPz7qvi9sqstX+HqX2yUeXSmFvL2dnC3CXTf2R5K685ab9lypxM
	LMuxBPIS6IeAXUe1DQIIblGOztgRjKnpSxdEgBJu+oimNjCWxbpX6Y3nGwGFJ3B/oop2vPjL0UxQm
	tQrEsI6+gqBNd/9HecqwTctCq8D/+b1SPk2vqUdvjMILeXdFLaV/sQXBQwIza6DkJeB1Q+QVEHyBZ
	3sY2Ide1/eBwMl81ElxmCvTe8ic44ewx5vnzqc+54xzEqvdubzBHxeEjVUmiSyFZplNYgJnyoDWzM
	9lqdMAmA==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:37564 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <re@w6rz.net>)
	id 1xHDfE-000000016Sq-1Scs;
	Wed, 14 Oct 2026 23:06:00 -0600
Message-ID: <ce03e9d5-a41f-411e-8ad0-d3dabcf7f393@w6rz.net>
Date: Wed, 14 Oct 2026 22:05:58 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/632] 6.18.57-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261014123820.008483134@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20261014123820.008483134@linuxfoundation.org>
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
X-Exim-ID: 1xHDfE-000000016Sq-1Scs
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:37564
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfONx6gGGjboCkK4Ay6NXbVdi0mVD0PDhYivKpkMZfqB7q0qI9rySms9yRnJSs1xmtV4mlun6EmjwUwmbvQ38T7HUM40sLZZSx59UNwRSU2tH6gNQh4kH
 0Cz/Xn6Xr+a+oeg1NF7/WPQFCQA2r/Y5mZ/z49SFpWBwVUwR+mUBPArdTAxu5/1e9fhcfw18y4bFAw==

On 10/14/26 05:50, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.57 release.
> There are 632 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 16 Oct 2026 12:37:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.57-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

