Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FE83BC696
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 06:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792391167; cv=none; b=EodtBcOeUYpKEJrOQtwYCZvOLOzwL/E+e02rJDkZl6Xq+Ta8YLEl1ohMG1AsL0DV45aH1ut9tzurGWXZiYp/eOiz3uflApxt4brJKP49hvhtv4e7w9Y3nsbEmEr/8U16BZIqFKRff1oo43afC4Mp37ZHdnaZ/DyGQOr11dbORh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792391167; c=relaxed/simple;
	bh=j+TJapDpmYfqZPFHprlVF6+tOgaNaUREk5h7ejkKKV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CxQbgRmulpN94Zxj6ch6R46cuWBklXP714VkJaJ1+AW1ih76RQQ+4VCtF86GH8sWjpfZAmJ5IJwRNCw4MpK2qWD38osIK+0YRvsJkmjOUdbNRznaBGZvHMOVNyQlezGYLR0It45Vejn5r9sW0ZJVhzSzkuhdfpCe3YAVWJh9laA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=1K8b7/wV; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="1K8b7/wV"
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id IWEfxD3alusRSIgooxrak4; Mon, 19 Oct 2026 06:25:58 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Igonxh5vZgKkdIgonxU9HA; Mon, 19 Oct 2026 06:25:57 +0000
X-Authority-Analysis: v=2.4 cv=a9cw9VSF c=1 sm=1 tr=0 ts=6ad5b7f5
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=fSA-YJl1BVv2D8DOKtkA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uaYGuNn0i1tun6haek209KJoUHEVtgzBYNBEkU1rYVI=; b=1K8b7/wV3eAXLi0ln/HsPD0Z+c
	97A1QFKwNVBwmBRJrwZhli/alyPDtcNKx9mJKSxy1jfAlrlZsDcFlYBaELIpGyWKWevVpif5uILrV
	cO+LKUZBlI6fGMUxQBUKxDkVXoIC40i4Lzj/wzeGalJjg7Ahe38k6ORTaj5H8rfGAKQOE90EoEG9G
	Iepu6pyWIlItJRkZo9qzxV4AEPao3Vm32YGgXsdwAcxOqSVgJPcMbQfuJ82akMrZU/fexDhtOzA1W
	Py4chbE+iBEsg7LJNQWlo13897UfyP+3cTnfyA/MzG4bAsK9nGSr0ZXzTXzDbQCeK0opo4Jrheop/
	16dAexXw==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:36108 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <re@w6rz.net>)
	id 1xIgom-00000002qW0-2L0C;
	Mon, 19 Oct 2026 00:25:56 -0600
Message-ID: <efe4ef57-1b48-4532-8d66-3b75980d35e3@w6rz.net>
Date: Sun, 18 Oct 2026 23:25:54 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2 00/10] 7.2.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261017155059.698368299@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20261017155059.698368299@linuxfoundation.org>
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
X-Exim-ID: 1xIgom-00000002qW0-2L0C
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:36108
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKIGr/+v6yvCzj5z3gp1s7rDiR6ebN1WOQni1B7YdJL8mvF+SdoaNmR2LeyohpKJUgnnpnj85twOq582zb/RgKYrMI6T6GTxP7xwydK76ldjetg+JP2a
 gMgwucCkZGfDD8ObIKWq2Et6/pY3moLb9YVSYbrsweksq7dFE2utSHou5khaL9sm7I3Ydq2CcPUdQg==

On 10/17/26 08:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.12 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 19 Oct 2026 15:50:51 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

