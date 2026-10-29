Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283791;
	b=V1NFvgjlingDz++iemUkMIS3EWa4P9OlsmLMEm4NbtXbMvyovMfn/E2hbB3IS6VleYyu
	 jdh5YrtubMtE6g/GA920wXuhrUpEAAVGxjNcNIrSmqRmTe5XOHpv45nu/zgs/+hFffp69
	 QftCEhJg+fvJYC/Vc0RW255uB72dtjITrgfNwyuKgDgYQM5rtuAMcUURyGBFDDjxFn7gG
	 smINoaIhdnihfGV4D1Fe6lcDw9ubBe5jtpgv4Ye8q9yAiC1J1H6BN8aehfVGbh4HG+E4G
	 vzZuseghM7851thnLxmll4TUCbjxLhT7SvfASbmW19kH2ti6s2nAdwZYmSQ3TgTQP/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283791;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=281Nv41drxsmzPgkjIMxdxJ8bO6xlynxgSUBTLqbk9w=;
	b=q/9taW1NTALLwopFCywzrACO1lWW7KORWAjIQ6RsfzPfr9A8JUwWJjHA9MXrZtVANLGG
	 fWLrXxO8ltEoW7mUYR93NpI4UUz+caylVE6SpAE/WK7nVOG//z8ZNiOiO1G2vt+c0Y2MQ
	 VlgNcu2JC9kFdS1h5hgSFyPSMgF0mhbeVXyg0Jb3cEW9RkR3PIDwvPAyZKWG9A39NZ4G/
	 6EPIf+W9WRAgHGFYsmSIVMVr0DfhNXHQnC4g8Xgc9k3vfmM5wkp4090SEe3lm5+yt372d
	 NnShNAf2z/aVlqGFUsjNgNBu9VracwsK/nl7/ccBaBkwK+AvrZcNM9G0otrzi67KSCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=w6rz.net;
	spf=pass smtp.mailfrom=w6rz.net;
	dkim=pass header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=MqvWDC9F;
	arc=none smtp.remote-ip=44.202.169.35
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267AA606A31C
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 267AA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=MqvWDC9F
Received: from eig-obgw-6001b.ext.cloudfilter.net ([10.0.30.143])
	by cmsmtp with ESMTPS
	id MFQxxGWXJLvgbMR26xFdFR; Thu, 29 Oct 2026 14:23:10 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id MR25xt1wB1xnwMR25xbijJ; Thu, 29 Oct 2026 14:23:09 +0000
X-Authority-Analysis: v=2.4 cv=OsxPyz/t c=1 sm=1 tr=0 ts=6ae356cd
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=GxnsrCybi4LwF3y-YhAA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=281Nv41drxsmzPgkjIMxdxJ8bO6xlynxgSUBTLqbk9w=; b=MqvWDC9F4nTt8QkWOvzsF02QES
	4t46DTnn9TT2UyDn03AOV/8nHbw+scHefdDOs/5Yn8URg34nBDnitw6TmGhhI1BLnQyAsWzU43nbN
	Dqv7QmoBSehI0W2kpp1BmdK1f/hzJT7Przctu6bbxVagIFhtfVmFPDyxAtbuByLW3OetpGUva3hhE
	Z9WxCOV3FoDwfU3TAniDba6DvKIgSjbz/iR++PfxdyrrQrAeaMKdts3ZiHIGkGugit7YYfH3IGujd
	9feQ5XY6xzh7On1FwEQKB89q7cFjs+SKlcyyydaE/u++XbVzRcxQJ5PiB74FtVTIcCNrNsdYk2FLT
	QV65iWcg==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:42774 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <re@w6rz.net>)
	id 1xMR24-00000003yYM-39pZ;
	Thu, 29 Oct 2026 08:23:08 -0600
Message-ID: <6ff0e9b1-8013-4115-b42a-bac66f2d34f5@w6rz.net>
Date: Thu, 29 Oct 2026 07:23:07 -0700
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
Subject: Re: [PATCH 6.18 000/109] 6.18.60-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261028165942.357251485@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20261028165942.357251485@linuxfoundation.org>
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
X-Exim-ID: 1xMR24-00000003yYM-39pZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:42774
X-Source-Auth: re@w6rz.net
X-Email-Count: 59
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGU9m3BaSifM9EdiuoxS92wpy+W0Zq00syA2Oi4gV3dQry2wXTD07ZIl83NShZYAyLbfW/KVS+SzLE4E7Up3PebW3r+ZcGD7H8Asdcu0pR7yufSn0f06
 r9MkN0CoFhWoYsjZADkucuEd/2y+p6JyDXQKartB1nFjsj9evudTYT5PxNmFE/4PRgWrPZlB+Z3Exw==

On 10/28/26 09:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.60 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 30 Oct 2026 16:59:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.60-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

