Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7560370ADF
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 06:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785566285; cv=none; b=OJXJF1rAhnw5HgWVRKitlX79M1c4i9o12bpE4EMdMsxFtudw53iN0QOH0XTrdyponPRBehvo7szWSxRfH8ChoKge1GLR7NtimgrJyxNwQFt+x+okkaX9rF/OW/PcRHswB7vOkZD+sfPnG9hYsAuPbsu3x5P+KaqZQXvU9fnxJg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785566285; c=relaxed/simple;
	bh=nSlRvfWHHGT8rvs66KoJO3Zdj0mE+4aGZ2jC/KyG1uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eOIfbyxbCEEyqMyUtAT+CRL62U3tbuImc1A+GQteOejKIER2T9RlBbFoMrO0bC7Ouf/87ARAOgFFLuAOH+8CO8xBBigb1F2/Dlcxjlj5WbwUnXk1iEZ9RspLfc67Rd4eH+DvH1Y3+JikDaP+5IQUVzu/p2u3mFDHSNIlkzdQ/mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=vmrRXeQn; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="vmrRXeQn"
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id pnmNw39p7uFzgq3Kcwtz56; Sat, 01 Aug 2026 06:36:26 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id q3Kbwp5vFXiyOq3KbwGigq; Sat, 01 Aug 2026 06:36:25 +0000
X-Authority-Analysis: v=2.4 cv=P7w6hjAu c=1 sm=1 tr=0 ts=6a6d93e9
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=ndgsLbHvwxDEyycyfWUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GdqN6QtRaAOBea/8yNx/LkF+ozdnSuKqep6t8MW/Mao=; b=vmrRXeQndX5s91hMLejZAYjmlK
	CM/mTV6ssXPSBiZrPlu0vXbrs5uQfitcoql6dIJmeBmCyAtBhiWkh89cUWTiJH7C74Gau8UbLL4Vq
	a/MTNTLAbq+WZQ82xGO7/k+PNGp2CUcsvOJLQEP8UFiTL6sAYYX+YsfWtjUsbybjxtwFguwtHpXhE
	IyPATspf0OdG0qMUF3/NKUELwVOFSuqDpj8ErDROtxGHf/ivwOxU6r0A8SVAncSDJgXdo4AiqiaCE
	p0B3z+yI8+oHzbnWey/4O+OMjISAq4ILQJcvXy3tWfG/w6b7S5kdOyWLfN04p76ptsNAUveQnEQ9x
	sQWfqveA==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:54368 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.5)
	(envelope-from <re@w6rz.net>)
	id 1wq3Kb-00000002dYF-0AXf;
	Sat, 01 Aug 2026 00:36:25 -0600
Message-ID: <dbb6f920-e481-4821-a8fa-c458bfa26b72@w6rz.net>
Date: Fri, 31 Jul 2026 23:36:23 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 000/744] 7.1.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260730141444.267951807@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260730141444.267951807@linuxfoundation.org>
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
X-Exim-ID: 1wq3Kb-00000002dYF-0AXf
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:54368
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOlxEzqZXUPGTr+mIVjGL0/nBmnW8/IdL/lsRG/rA+uvOBCL5VWPhkzdOc5OW9sRHXEa+2x6B9Lt7MB2hZWncEPibqieTvvcx2gzSa3LkB6yw7dS4mA5
 txVJhF47Cj+cZMxuvaGbim/pwfmjQadXuY3XPbCKY/Y3ibOIKD3mW9elS0KB639io8msHzIpWfgJ1g==

On 7/30/26 07:04, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.6 release.
> There are 744 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 01 Aug 2026 14:13:38 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

