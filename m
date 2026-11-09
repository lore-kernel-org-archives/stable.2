Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216336;
	b=pe8EZPcoA/QAKDy4fFgcjAt7OsXI+n22uJAX5j7tFfsWb6cRJoghpjxklyw2Df4KGKY2
	 8VK99tjyHPtHL8y2ArHuzY6CVOXb4riQTul+x8V1b21TOKof8nb1xwDbFk1REPtTZTG1m
	 YVWakV9kvoadG5qzBRcH+RvYvVMNvDmSpZfgtwZ9Ni48zuLYmfjuJqoC/4Tmq9PBFLzj3
	 9uolNYHUHhFHRrc3DNk0C/Jaii5FwqmnpCM1L5OprX7RQkpqI99ECPG1qN6a7ZXjf2XzH
	 hBw1yquZiKrcHm3icgTVtNSBazR/BjHPcF9wcdm0W2az1RN/rSLZlwNAVxycJCqhigQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216336;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=qomxj4lfoPO9QXwfpSMD8HRawzKzamUyZqL9KhD7jvc=;
	b=Y4TUpM/8sVyZTo1giIDKX3F7LjTOy7cXpeXvVqecW3vvZycMQuuk4L2Lb03locZ/GmUR
	 YoL1zSfRDPdwOqaIllG65Vamqk7dptjp4X1CVyaJqF6/ygT/y8tb90wIp689BnDHt1adr
	 7WOGyS61SANxYl/SoPEXxoWCpd9QAIakI5ymStoBhHwTm5DTbE+w7R0UGEKl+BqtTekX7
	 etwoucUo/gFBfwaN/0c+fcytshK9LfXcBhULTr6EXEF/C+SP3kwlpn9vYZibjPoGTbSyv
	 +oVO8sZH7s3p9Nf0/HNFjkGqgdGKqwLeVR46QOlvWlxrL47sup4CM6NW8nX7YGI2GNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=w6rz.net;
	spf=pass smtp.mailfrom=w6rz.net;
	dkim=pass header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=WaEydoSY;
	arc=none smtp.remote-ip=44.202.169.35
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7912606D80A
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 09:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7912606D80A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=WaEydoSY
Received: from eig-obgw-5007b.ext.cloudfilter.net ([10.0.29.167])
	by cmsmtp with ESMTPS
	id QIQGxnHwH4vCDQLd3x5HHk; Mon, 09 Nov 2026 09:25:29 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id QLd2xbyTkxqjjQLd2xvV6J; Mon, 09 Nov 2026 09:25:29 +0000
X-Authority-Analysis: v=2.4 cv=bZxrUPPB c=1 sm=1 tr=0 ts=6af19189
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qomxj4lfoPO9QXwfpSMD8HRawzKzamUyZqL9KhD7jvc=; b=WaEydoSY1b6VZq9hbDFHGs7Q3F
	Im0LrirtlkJ+QqFUwT/dtsFZl9wrwSvQJyzWR0Yb9qOWlNxmEfNEajzbOMognzYH7ZIyiCa2p2CEP
	UuriQ6ZyKovO1FemgRyIKe9m01hr6irwLzy9ChNrSkIFo9oZStxCsOReeGnr2cTHGSulbZMChL2NM
	ZaBU7ZWtkNEBpRylrrRfwQp+INfUMvXj9rI8EgVElXyaxOJjQvnvs4emisitz+olruyI8Sj6xsbVf
	/qw/I1/X7R2o218MMOMl7uHMzxOAge5cKVsuFtYL5i1Cv1ZDQMPLuIhLnjFZMfq4SjGsL8s+Pq5YM
	F8IGONfA==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:46368 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <re@w6rz.net>)
	id 1xQLd1-00000001PSJ-3UGa;
	Mon, 09 Nov 2026 02:25:27 -0700
Message-ID: <49dbc035-4651-42eb-b6f0-884c7a55e4d8@w6rz.net>
Date: Mon, 9 Nov 2026 01:25:26 -0800
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
Subject: Re: [PATCH 7.3 0000/1257] 7.3.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261107134939.434104957@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20261107134939.434104957@linuxfoundation.org>
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
X-Exim-ID: 1xQLd1-00000001PSJ-3UGa
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:46368
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfI962fPAc1SjdpgYUuJsm+DvH9/LsiKLbMSFVCmFTzqaYeyZoZqb6Lzml354QuhoqRLpCQzc+XdnuLOUI+GxMwAHFK6PlV2wkDeTPbWOGWz6+hvd6syT
 Ee6gurKTT6TjcTDFIdFR1zPAreCYSkkkLImQVAV2E1m0GraBxdpN7B9k6KJZLIXOoz9WP8NuJ1h+Pw==

On 11/7/26 05:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.3.4 release.
> There are 1257 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 09 Nov 2026 13:46:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.3.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.3.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built (with CONFIG_SCHED_CLASS_EXT=n) and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

