Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284503;
	b=SHp4+RblEEuOg26Ok0i+Z+eyZ3QzW4fydAfsRp7vuCiJlKGB4tNSLkBMNdgRGBM0wgoS
	 z8uPCBBHDBcHPfcViTy6hq47s7UOWyTET5fyVCSwY5jtwgJ9SfEA8bENvfALjYl2Lx7px
	 73GzEl1ujujKa61jjQIJpjH1cBdWhqr3Ar+/D5gmMKh5yvee6DS0wEzX/1xnvsqhSPqeN
	 xQnQXPG+ZI77giUjRVFonvB0vAfr7lhWWn/RILXrHIjcNRrGgL7l+3RwMjjCI8CQliRLC
	 Bou4ooVtep5uY6f7xk6NPgODPrVcaofjX/z+hCcv4ZDOy6Enn0NPEGo9i9AOMragLTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284503;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=ckAV0nPvYeXYAjm19PTQqftmMr99tStlU+WZmOeKOu4=;
	b=qxnJZkSgjpr/MzNIegP6oXQHqrTVakTeJ8hu8y6jhoaDokeE5iGzqkxExSE31FdkWwKA
	 ILrNCvRmhW6VfPvWcDGe33AC2TOytzxOCPR67vZwoXsmQCqqCF/x40QAbz6vgwZu4JA1S
	 M5qgxRoC9t8lYltAak4rQlcWtb+f5yok0t+9F7ygERb5yM/odLqd8hiFUFnXhPdXzYB3o
	 xT36IglJxNm8L9SjWB6cK3vAIg/5jwYJ0vlERpNOoOqDeP/hS3tYTZHr+UyDEwmzKSWVH
	 7kO1j/QYUzQ8q3dGnk/9STRksIQix4WfuZuqauK+e7fJQx8BFpuL8oHBztil+1HYz+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=w6rz.net;
	spf=pass smtp.mailfrom=w6rz.net;
	dkim=pass header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=zCHLpUYR;
	arc=none smtp.remote-ip=44.202.169.39
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DDE606A323
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83DDE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=zCHLpUYR
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id MPuaxAZ2wMylkMRDZxW5a2; Thu, 29 Oct 2026 14:35:01 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id MRDYx3mruvtkxMRDZxwwyO; Thu, 29 Oct 2026 14:35:01 +0000
X-Authority-Analysis: v=2.4 cv=BbzY0qt2 c=1 sm=1 tr=0 ts=6ae35995
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=wqb0kCX3BiOQ9VqcspQA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ckAV0nPvYeXYAjm19PTQqftmMr99tStlU+WZmOeKOu4=; b=zCHLpUYR57yJ4af7nD7m4TvLjx
	DeWq2JSv1IlrVe9uLFvOVOC5jfMWg14wKo6pXX8+Ltc9seYHO6Z0+BkHLCIdjA+X0CeRrhDds3kTN
	aR6SQIBLKYw/g4246N5dVw3FPmIlpXqWN0zNK5mwvd3xpQ/pHS8Qcf/02g3aBNnpGkjNQNL4Fmgri
	US8d3dVb2fuMNVia10p2tSggo1v75clgcOtimOwy7weWugSFTvEneKUd5jPnVVFuzyp8IuDvvvtu2
	rORN6fHVERENa4nNOk3mD976mhAGxjQRSEdHOgo2UFDQPADIaLAGvfXN4mkHGokCMfcNtW6cMGV1b
	zb6ZGIog==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:50328 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <re@w6rz.net>)
	id 1xMRDY-000000048Mb-13iK;
	Thu, 29 Oct 2026 08:35:00 -0600
Message-ID: <f2dfed34-cfec-41fb-b338-4e543502ca97@w6rz.net>
Date: Thu, 29 Oct 2026 07:34:58 -0700
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
Subject: Re: [PATCH 6.6 000/168] 6.6.161-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261028165943.089486480@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20261028165943.089486480@linuxfoundation.org>
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
X-Exim-ID: 1xMRDY-000000048Mb-13iK
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:50328
X-Source-Auth: re@w6rz.net
X-Email-Count: 99
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPq95Hv2Ccdvf+x3cNjFtPTkQpe8rcah6GeMeFp1ESFSsIT7Gpx8xDOa3aHl7erp1t/KxKLhtTya8K6k4f8+VryW4zdFdlphl9SXYhGHE/pQan8GLBHP
 SvnCg3AnqQS50E6ENUEaPAYjCP/YlgCxNj9tE2h6m1ZzijerpUiBKsJmlEVLBfyezIdtV84H4dBkpQ==

On 10/28/26 09:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.161 release.
> There are 168 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 30 Oct 2026 16:59:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.161-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

