Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA663B5847
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280149; cv=none; b=fpzMyeBzGESYJO16A7IAVrKDtONmn6X4l/4J22Yr4W6RHrYSL60r0Y8zNYlSIzskuPuy2uZudWBUSbPNPvVeXmEyB0vDvm/M6ULKXrfSXlB4b7c2Q8LFhN5uQgQigW1tp8jBEIWVKz6LXjbz4r9n6v4sxjVaQz+QYgEZfVU02is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280149; c=relaxed/simple;
	bh=PwJujLrYe9yVyeeghG3cqBLpLaoy5VmyJJs3s87CVK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WIDy50Bn+9en31hQUbKasjQlqc6rrsw4fwGEA9R/zBKuzhTAoi1davf8yw5tXcXVep+jjf0eJY9NqiFM/NN6hcm8pSfun7y/0DlTCCE0ylnj4ZLgdzzIMxnfFIM3HiCu6Bicq0NNYk0xoEJJWqHIrws+AVfhRICflHNXn8N3qcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=dWmfZQYy; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="dWmfZQYy"
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id kcfCwuEKqJFmFkekVwyLUA; Fri, 17 Jul 2026 09:20:51 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id kekUwYLYJtyQ7kekUwuOLG; Fri, 17 Jul 2026 09:20:51 +0000
X-Authority-Analysis: v=2.4 cv=E5LNpbdl c=1 sm=1 tr=0 ts=6a59f3f3
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=Nghn086io5pY4Qe7T5wA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=h63PRg3jMRpAjuyzMHQJJcfxducx/cZqSd4dk1UT2A8=; b=dWmfZQYy/oSngls/ihsursNmNp
	G5/eiVYUkwd/jnnxro+GHcGDmkCiyzts9oCIroeonsNQQMNAEUmfF0umYSTSwLo5YB2f4UeuOYBb7
	T97EDIgunkxvD7aiqgqE0l5OjRDEQxHLc9EEDwb83gKeyUUrH7XQmpvqobOseF0Om4kx72zgLIsTt
	QXP/jt4FFvZ7x00rGhtTCesJmgjmI7heO6VlGlyu7lB/fIYU/59D42JqoLWPonUpbJEDE1YHE6eU4
	ls9F1nxy5WRHbbmEMyOo2wu5yDflbhhb/E/8vBG39XbsSp4quZi8BqTOoRMLaU+QniK9Ka8GXUe/f
	nzsIgFHA==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:35060 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <re@w6rz.net>)
	id 1wkekT-00000004AsA-43LN;
	Fri, 17 Jul 2026 03:20:50 -0600
Message-ID: <69e0777f-0002-4496-bc9f-a2a7d61d6c64@w6rz.net>
Date: Fri, 17 Jul 2026 02:20:48 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/349] 6.12.96-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260716133033.287196923@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260716133033.287196923@linuxfoundation.org>
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
X-Exim-ID: 1wkekT-00000004AsA-43LN
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:35060
X-Source-Auth: re@w6rz.net
X-Email-Count: 59
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOcr8J3cY8hOsWoV1DHAHPx2m8zHxKbe83TblykPp9vk/oMarsiYbiVF8fgp13jlmOVv1d2YAp33zSP8r0twDtc+YMII0IFSIyBitEs0xWqqcyLGy0lG
 bqEDXqiEhFyIi0oy1s8GjqSqvSPADwX0IF0D2yXoT2Tuyp4ChJlanLBEL6JUq64HhdMyV+dkui2d/Q==

On 7/16/26 06:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.96 release.
> There are 349 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 18 Jul 2026 13:30:01 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.96-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

