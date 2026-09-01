Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A5933AD8B
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 23:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788303925; cv=none; b=P6XbCDTrET14IERYP1F+ObHkWsudJpK7FwwcriOLIzWlA20UzkF93PyEA7kbmgj/mnT4qGGsQuZWdkstXauDPbSyPBmTF6IYdZUkclrk1F4rxnxxLbsNwIFuipGywK2o3hEse6cyV83EOGmRQuYNasPUUj/FmbfS7uWcv5SDvHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788303925; c=relaxed/simple;
	bh=6NXnX2IrD7bpMZuaPt9/a2lirU66cCGgxnPhonn42EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uIUZlwUVQ7D3oNJOx8wAAKjh121XEJ0PzARfxOyKVIzLat4m3UO6fLZZfN3E6hF64ZGtrpF4lTdWaIe1UyZ4ZTe9DuVkY2kGfRWtn5CF/7a1G2LEk2+Z9Hpdmc1W7USCWGxxIw0dgidPPoYLYYfoor70W+MOs/7Y0kZTF1wJdN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=FO7KTp5Q; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="FO7KTp5Q"
Received: from eig-obgw-6001b.ext.cloudfilter.net ([10.0.30.143])
	by cmsmtp with ESMTPS
	id 1Vtvxt5WmaC0U1XXZxNvY6; Tue, 01 Sep 2026 23:05:17 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 1XXZxQAHv9tXG1XXZxfNjp; Tue, 01 Sep 2026 23:05:17 +0000
X-Authority-Analysis: v=2.4 cv=KK1aDEFo c=1 sm=1 tr=0 ts=6a975a2d
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=y2ERv7ko0hlTFnYyMTsA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=m/8HHcfW/ezO3N2QXJFHhl7sKGkvq9UMy8GIvPEuUZY=; b=FO7KTp5Q5TiA2uyn5uJcdS2hO+
	1GsuePAoMzQpg1808Lr2XbC82w0W0vLb3TRPzkXRDSY1D2IChjaXep5hgMOI8+ZAWEc0NnAAtPbZk
	1Gi9JRUcg82zLdCHs/ZWzwQgZdDhOIFTX2vBW7xRrOViH0LY+mqw8GbBXlVgtDjSBkCsUlGSnGL9R
	5ikzTrnU3Y6EUNJm0rqig0Om3Bxz0ebWCmdoNwdglsqYnqGMwFdM18MolDUJCWPOQbpcWCTBamQNJ
	9evy3XvdvMJithg4lbLzCwdMUB7ANYWlbrLwK9OrJ4QdmiKrVQamIzGZks7bfEOenuAPTzXAyJbLe
	ieHJMDlQ==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:36190 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.5)
	(envelope-from <re@w6rz.net>)
	id 1x1XXY-00000002HO5-3FLH;
	Tue, 01 Sep 2026 17:05:16 -0600
Message-ID: <1965058f-ea07-4154-8b7b-feb72b40b4ca@w6rz.net>
Date: Tue, 1 Sep 2026 16:05:15 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 00/83] 6.18.49-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260831133359.207714926@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260831133359.207714926@linuxfoundation.org>
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
X-Exim-ID: 1x1XXY-00000002HO5-3FLH
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:36190
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIspa5GxOEgiD0V6jtGJsMc+H4XDN5aZ4RVbZ3px9bFu2V4YFvsTebw96ADGdXYGWUOpat33OjZ3iE/UUR/E2/jexU2CtFJK34j97951icBRlGvrhWBe
 r+Izp0zybmHnY5vthmEI3PxQ9smusChXz7rdMcCM2n4q2PamRd3D/zdwmb8ZbPr5x4Ro+4QWRrljZg==

On 8/31/26 06:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.49 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 02 Sep 2026 13:32:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.49-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

