Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795147030;
	b=C737s7dmd9nNIdIRf07lhflfu7AZNRFofE1mI928Ano3TZf0s1bNIDn4NyhyB0Qj+ZAM
	 Ec/zIq57ymZ1HrLHqBkhjG+IdSAmiji9pRVTDQSw0YcuNKkhBOriq13wnBkvx8pEdhgq7
	 /FT8sXo1J2KiHllD1vbZWunp8EhzzMCrvbE9m4yE3skpVeGVnC08HNkj2Zr9CCQA14UOA
	 Abb418gDbp8DwXD3z3P6hTCe3I3McasGtS1082mwMl/k3ukHyqez0EE1OwnEjqxvwSZ7f
	 yi+ZmWCqVAK+bUYgCF7+UgqSWLbaKg/TR98Y5rFZMyHfjx1ZLFvCqdFMJZ/ZikX05tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795147030;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=11okyqYHxE0IernNnQyz3EyafRRbkarCz5jl6k/WWBA=;
	b=j4EoF90fNfBBO3E1+Al6izjikL5oHXlmg9IsNeL1YYGY0zTCfWNrYngjyplokZT9V9Vp
	 IM/6HTNJyc5RLdKLYkWM7r12PBEgzjtGsM39X9FNX5FDBWOBElVNeqSlof/WluwLC66vs
	 18/lzt3iPVrWVH45HkS2fWt650vSafwqzFBCpv+7VVGfE/TFP1kzbOe2p29Y1AVvm90si
	 94aSkSwx1UnQ/Y+gqRUd2SKpLor043vzEdHhPzF5aR17JdUo5tompvCoVkaRSAKlHit9P
	 pLDxoMZAatamLwNfsE4Vv4AqHQuDQHGQW4eQjEOenJO9kufz6vEZmqKIzIyMFmz5nog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=w6rz.net;
	spf=pass smtp.mailfrom=w6rz.net;
	dkim=pass header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=JIUXM2qO;
	arc=none smtp.remote-ip=35.89.44.39
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CA9606A320
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 03:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2CA9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=JIUXM2qO
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id UAaWx5Ep2yb4YUFkLxTJF2; Fri, 20 Nov 2026 03:57:09 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id UFkKxBZta3nNNUFkLxKLYF; Fri, 20 Nov 2026 03:57:09 +0000
X-Authority-Analysis: v=2.4 cv=TuLmhCXh c=1 sm=1 tr=0 ts=6affc515
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=UheLhBLhog78gnJQedQA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=11okyqYHxE0IernNnQyz3EyafRRbkarCz5jl6k/WWBA=; b=JIUXM2qOrIubJ6u7hVHK1jHHGD
	oNHMX6yo1YUSyEe5IJC+XlYpOcpCL1IYQkC957TCwYiCskR7Fb3anf3wCGpzsaIUwtkreEWxzHcZN
	hM+ffR/PX6CNwr9bzF2sib9pAk1gA9wJRYIebYBinVDznnbyf807AfeqqOKy7bJfmxQXO0Zp1Umch
	T9YPMvP/RgWNnaKQXaqMWKzjdPGRE0gBj9olPEdHXRUpCcHOJiH2uGpndoiM2v2r/mGrm1FGCS0eu
	JG8RG800aCw800hpyAWFYZ/qv83uyfx8WaCHKJXNuV4MfnFTUwp3bVVqsv5MCDa6jwXPbHfigF0v8
	EWjZ4N1A==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:33018 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <re@w6rz.net>)
	id 1xUFkK-00000001Pyr-14cM;
	Thu, 19 Nov 2026 20:57:08 -0700
Message-ID: <4a210c36-d99d-4a74-b94f-41f6a28d5040@w6rz.net>
Date: Thu, 19 Nov 2026 19:57:06 -0800
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
Subject: Re: [PATCH 5.15 0000/2214] 5.15.226-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261118150009.797899913@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20261118150009.797899913@linuxfoundation.org>
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
X-Exim-ID: 1xUFkK-00000001Pyr-14cM
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:33018
X-Source-Auth: re@w6rz.net
X-Email-Count: 119
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEkBKI8vWXOvg2L3g3TRRxBYqKYEXUbOWx/QZ1F3iizx5+CJEPJfIfLX5Tfc6CnJUYCDHNMMyX6MGmXQ1y9AK3QPbq/GTvbodYqXMOpGOm0A+aa6xG3q
 HW0v5bqUa/RweVEerYmmaNJvu7y8IisuRBXBI4MoBycG16iO2S17T1b05sntHAmCMZPm/gJk5DGNWA==

On 11/18/26 06:27, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.226 release.
> There are 2214 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 20 Nov 2026 14:55:35 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.226-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

