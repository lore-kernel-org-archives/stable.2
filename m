Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F25846A
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789720929; cv=none; b=EyxMmTpyW67rSEzA+JJMIMQyxlkvqKC2U/ggSis5fb/oED4f+7nq+tNKETJ+Xm+6afNAXkINVwCwoVsjgEEjj9GIYnUuzi6HTZQYiCmh+JircTIaQjDTfBMw22VuzIgObtUJvIvewfL4Hs0Q6E1AqmZY1O4ixXeqkGUuiUu29AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789720929; c=relaxed/simple;
	bh=GE01ZJk1Dnk5jP3hnMdHMT3hWSSM0IaDfbBRWneCa4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMFQZ07rWct5AwkkGKkXvNBaRZ2TWflm/vOFDMZ8w9WWMD0kEDacoQx8H6ayzzl8MUcJu26+Oq6O053l5RROBosP7f2vJmpyngp0i8qNYmYT1SioTjGN+I9uA0NxlvWoQGVooinVFZUgB5H2fcVPncDYxpUUEzFGK4SARN9V9d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=JGUETni/; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="JGUETni/"
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id 7NifxkjW3JFmF7U8yxBMKe; Fri, 18 Sep 2026 08:40:28 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 7U8yxEWiaZOPw7U8yxuOe4; Fri, 18 Sep 2026 08:40:28 +0000
X-Authority-Analysis: v=2.4 cv=H8Xbw/Yi c=1 sm=1 tr=0 ts=6aacf8fc
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=qhrrstFoYj4ExQeanoMA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MjnUq/dY/fWPJe3QMgR+iwGz28UusEz4Z6VVJBzj2jI=; b=JGUETni/P4Wn27DeM/P4APGYSU
	jWVbOTTzbhJeduk3s1TAW4GPoQ7MSzGs9Bemrr4XHFnaHcSm/yGIxLY3ifO3+AR81Bkq+PG7z+mBt
	j5SFDmGWIRC3+R/Lv4SHUe0dhA923rHgSez7hIRXnPsV8ZobBSeGUyin860DbD6TrQoMWlxlHzDJs
	18RMriKCDpHLUOPI2bsWjZd/vJ7ONtfTqJM6GFyKcfPMEjXhxG2QLO8yO1xQ3S9JSeBIZofGLdl2L
	puM+UjVL9BoQ6RVjf69S3sCUCjqmzOKlcHKXNlAQK0imqYauEZWIZL/rCUKYxZlgH0N97ZV2ZeznL
	dMEK2m8Q==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:33456 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100)
	(envelope-from <re@w6rz.net>)
	id 1x7U8x-00000002hF0-237G;
	Fri, 18 Sep 2026 02:40:27 -0600
Message-ID: <86ef5c9f-effd-43a1-8f6f-c6118b5e8c82@w6rz.net>
Date: Fri, 18 Sep 2026 01:40:25 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2 000/733] 7.2.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260917151350.597953846@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260917151350.597953846@linuxfoundation.org>
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
X-Exim-ID: 1x7U8x-00000002hF0-237G
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:33456
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGHKlaZIKPFWrKLSqy8fXTj0RtFDbQBb+xQV9Sfe1lCNPN/fq7E1iIOQA8nBOsrMduUVXADoWRXlzXn97UbzZLBMPXOf/wsIhwMUl1S5nAm58qhEMPAl
 nLNq1PRagNJahw6xaaP9GqHiCOHCRHMpZjlIOS/fbypXpSmP7k99A5OWglCczDv+fNej4wGpedhQ1w==

On 9/17/26 08:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.7 release.
> There are 733 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 19 Sep 2026 15:12:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

