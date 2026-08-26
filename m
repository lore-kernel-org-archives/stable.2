Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18DF3998AF
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 06:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787725359; cv=none; b=R1NJLl4wNm/8HupLjdUNqhOUgRm2KPkxK4/62Aa9utZjD8C2KQKadTKjqX31yaFG/xYtrA0tt7g3mYpjMQZyOZo2Pc6aY98U/v8LV9ru02Zg/4182wm0dkwbPJZu8Hx26hGggjrrSHWAohY9UrbljzAcN8snzPaG8qbMjvm57lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787725359; c=relaxed/simple;
	bh=L5/eOz3u+ftmTHpLndkXpBrjJS35b4uEzHwmvmcQfY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dIv/gOAoNuId1olwq5ZMNu6LubGvuR7VhWvBDO1pQ8kYDr6m9YHh01eUQ5hDmMKRydzSWPmZleoLq9yRgE8uPSb34pKhDPSaNcgsLUaNnApJS0gL7uZP+IFXQdkhf7bvDacxItlqWgwbyDersKJsgsso4GVfqPKzF9gcuzr3mq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=QdmZtvcO; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="QdmZtvcO"
Received: from eig-obgw-6001b.ext.cloudfilter.net ([10.0.30.143])
	by cmsmtp with ESMTPS
	id z6g9w2xNMLvgbz71wwk75X; Wed, 26 Aug 2026 06:22:36 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id z71vw3gr79tXGz71wwgDde; Wed, 26 Aug 2026 06:22:36 +0000
X-Authority-Analysis: v=2.4 cv=KK1aDEFo c=1 sm=1 tr=0 ts=6a8e862c
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=60u_ompe4jvr-0JMN7sA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pPrwSDfIjORNeI3Lpv9NXvJLfOONwhPq7rKRCHu7XC4=; b=QdmZtvcO6gS6G3Nvrng9g8jpF+
	Bk0bvblgnkZS+8t8F7IoBd/2z58OJ+Na9FtMmspjyaFOpAFhk+Vw+wU/uJIEtGm3O8YNgGY6OCdoP
	2HJ29+Yxw+zAmlZ/20l4PICelzgFn35jsKaTp93hZEfYe6xZVnB8qtkz9izHa+pwQIQgSv2323VOa
	ve7UC0ppulTLGDRqFBb0xmuS3oJsBEr5kyz/z6vB1blnaSH/4spavi13SMXeepKM+zgz+SgMrrwnv
	bUXPmtW6/1GiYjndXV6M0sjv0BJIMX3WcEZnjFOI9jWkeeTI4qRpUGB6mG5xzNrMRDbaFVLHH02Jm
	b/l2zCsA==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:56830 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.5)
	(envelope-from <re@w6rz.net>)
	id 1wz71v-000000044J9-0wHB;
	Wed, 26 Aug 2026 00:22:35 -0600
Message-ID: <7cbabeba-663a-4f40-98d4-545c425d64c4@w6rz.net>
Date: Tue, 25 Aug 2026 23:22:33 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/87] 6.6.154-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260825132541.813800447@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260825132541.813800447@linuxfoundation.org>
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
X-Exim-ID: 1wz71v-000000044J9-0wHB
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:56830
X-Source-Auth: re@w6rz.net
X-Email-Count: 79
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLLVlGov+shqIvfeOn7YZEv2DKisWo0/MXw/2vPCu0ZOGfOrcQZAfSS8LqiTye+eZlhPvtkYpOWdACj8Iin8tdxkU726gb+90XTHqganh8fvT2JRvs4C
 1x5nj6tz06LONR9qbvVjNfoMoDyKBVT6C9K9nk8z1zsH+q4GWe2yxwEWVENGL9/cFiudCkf/MdqvkQ==

On 8/25/26 06:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.154 release.
> There are 87 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Aug 2026 13:25:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.154-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

