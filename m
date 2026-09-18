Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FE04ABBC6
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721140; cv=none; b=vCSfU4E95duggc0IlhMPk3hg2WnIG8fYUmNexYzweQbWSsOw7ouGjYfyiBOrkmc/uD8CdrH136BeTGQuAAtEStovGlEXuAVUPQrpK4nL6Ja/mO1HmkiK4vUjI0LmOMb6BRqMFmJTJTzE/1JmwDN4eJhaK5yKtE+mJFyeJsiUTf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721140; c=relaxed/simple;
	bh=qo4345K2DRgT+zBVme7jTN8AnlDOs0KOI4ite+KktiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rg5GkOe2o1U15XQ5P+w9r2bP/fWc18s0dOuOJcDs8tY1B4siPlRW6JpGURtaR2GpxYlPY9kqZhFAuhkIhoGrqBwigkdCaOqcPa8lCTTx1zeb5xrTFh0QFeideYBt7TGCtYsOXOaoQ9CrIPVIpb2C4WDoyrax7Htl/Pen8k5+tFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=oIo1uD8r; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="oIo1uD8r"
Received: from eig-obgw-6002b.ext.cloudfilter.net ([10.0.30.203])
	by cmsmtp with ESMTPS
	id 7NtTxklO3JFmF7UDxxBNsT; Fri, 18 Sep 2026 08:45:38 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 7UDwx05HL8TJY7UDwxPBvz; Fri, 18 Sep 2026 08:45:36 +0000
X-Authority-Analysis: v=2.4 cv=S9vZwJsP c=1 sm=1 tr=0 ts=6aacfa31
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=Gzq6y406HWcBfBk9GMIA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zHAf4d3TEBd6lDVNA/O3WyOUHSVEkKySTXdJiZEf9FA=; b=oIo1uD8rbue3Cu1gidrFu1q5je
	4Gc+wmg2F/kCOBf02dsM8wxQFcmh7SXLfAMX6wJSylqBOytjbh2Ub5BhMsh5HQxKa+w9YoiwTVq0a
	oTOUD+LvDGlni+8yR5nCnb7tl02YxilYjy8pC8LVsd/9qS5/uhO9kQBPsEoEBoFqc1Qkdo6x3Qbno
	W3Geu74iUY84uZM2a87OV2DlSktY7QzK4e79WZ+hFJU9/+c1dRx1sp2kPS/cUBgsUmAMdX0N3ajiM
	nJlDICWikb/S7QY3WLRYksB2HzyYe2BcLJNmQ1gYHoX/QeL4NG3yU73lFO/urW42kRcr6nhXv0Qt8
	yTM/ZTNQ==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:60220 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100)
	(envelope-from <re@w6rz.net>)
	id 1x7UDv-00000002je9-1UTC;
	Fri, 18 Sep 2026 02:45:35 -0600
Message-ID: <df230679-639f-419b-836f-619ccfbff4c3@w6rz.net>
Date: Fri, 18 Sep 2026 01:45:33 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 0000/1250] 6.18.53-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260917151551.901433442@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260917151551.901433442@linuxfoundation.org>
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
X-Exim-ID: 1x7UDv-00000002je9-1UTC
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:60220
X-Source-Auth: re@w6rz.net
X-Email-Count: 39
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDPnotwRjEZM8SvjDeMBkMZe1gz0v7BPzZ5Fw9NEdo1zosTiKMJeE5O84HVtmy1uy2hI+cw/k/SHvRAYvmo5FywDZ6jgKVU90gE3V9L6+Zix8AiEAlPB
 7hIHyyEg6In6V1DjvGoWqffL6BBu8NkD2mnGQQ6NjWV04rHy9gpJ2mVfLZd0+BEpaHL1sOTFO1hR6Q==

On 9/17/26 07:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.53 release.
> There are 1250 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 19 Sep 2026 15:13:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.53-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

