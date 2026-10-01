Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92964E4C24
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 10:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790849210; cv=none; b=eD1Oac6YwAD8+In0Dv4AronVO8M1n2UjgkwsvwfeXdwGEfbfOJT9oOxZ8ltcktqq8WAKwmCH1dTGzmm8p5wUNjbh25IsZQD7GEoJ2AkDofP2hl0578iJJE5brLe5K23fP2KwQ04bGVqfMqzGWXFpcEozjQ6jjLlqi68KELt5WjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790849210; c=relaxed/simple;
	bh=ZK9TttDiNF4YjKf0cgn7ppTK9O9oj8za/sQdUKR0nLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NO0EVHtqHntJx37YpBpUqlyqvwsfEYhPtT46y7Ob0ltqozdSwrDRtYnXZkmaIARNXhlw5rTb+RFkRqT0PY06xOyYxQXnm/R+TinYnliibXkChdx1d1zdvFt/QlA5/bTzqoTzM45IL85vrUtJV/LNFny1CpvhaIkUGpUyiO4+1dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=a9UpO6M+; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="a9UpO6M+"
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id C8zqx9hCpv0ndCDgTxtVHq; Thu, 01 Oct 2026 10:06:37 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id CDgSxwDp7FNcnCDgSx1Ufw; Thu, 01 Oct 2026 10:06:36 +0000
X-Authority-Analysis: v=2.4 cv=K+UiHzWI c=1 sm=1 tr=0 ts=6abe30ad
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=cQwE5TCehGVgXj1d63kA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zPQhjhK1+Ka07Rrc5WFMGDvPTt9n4eaqJNvBRAVMQ8k=; b=a9UpO6M+h7C3JTunQYs3EK2tKk
	5vZgLLyJvunp3gSgUT/0N40oUJNZW7XzQ+GP8vM5bO7uU6aMm5tb7aw8XXdgubP/gwwXD/G9Q7CWa
	s0aiQuYksmPvP0nQD264czlW4bRLWpLzo64oEhC+4eNeaEsajfrGpRkjHtVKg12nvmXWVU99KH3F0
	Z4FLr0da/YkeOmIh7ik1PSmescADfI+PGn31wVFt+zJ9xaETVNv6n7MxY3Yrv46i4ce4M5STHne/g
	eh16TRZmNmHgJTdkhtcl06qdiirip1yP3o283B5EgEzmib/ICj74pflP5UfxQ9IE9/tsNlsnmM5GL
	TwB7tQAw==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:33908 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <re@w6rz.net>)
	id 1xCDgR-000000022HJ-2srk;
	Thu, 01 Oct 2026 04:06:35 -0600
Message-ID: <90ecfd23-33c8-405d-9ebb-05ac019d28c1@w6rz.net>
Date: Thu, 1 Oct 2026 03:06:34 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/877] 6.12.112-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260930152414.738996857@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260930152414.738996857@linuxfoundation.org>
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
X-Exim-ID: 1xCDgR-000000022HJ-2srk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:33908
X-Source-Auth: re@w6rz.net
X-Email-Count: 39
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfO1gMp8Bsr2QAGf0O278+zhMiVTZe+BZG/7Ztzr7eD6kkIbUuyp444vL2cT6uLbaOQx9JNtlIUv3THGdh8GqcykcW2ubna/uFiMPwQmTY926frH/y7io
 OWtkxzBHkX5/yIoW5YGbhlpkj3+SCQQJUUACVCEwVLS/0lhg8cy+cMWxCGzskew4Fp80boW8OUX48A==

On 9/30/26 08:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.112 release.
> There are 877 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 02 Oct 2026 15:23:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.112-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

