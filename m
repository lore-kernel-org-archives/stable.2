Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AD7387363
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 06:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901298; cv=none; b=OK+0wu/VIvwR2iCJm0Od5T/udHJEgeoDkngZnxqecOuMcHr5cZjQIilc/lXRQfjrY01bVEVHiDYhpHD6Ku73r4VxhWmOmBydVYSvCdqQEUbnQTdDIEDX5FHs8lsCY2AA9XGqTHcrAoqe5vJdQjfcK1G6uzjz8qJmzxp6lQCw+s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901298; c=relaxed/simple;
	bh=OZTg5q8E/WhpYY7PlTL8wmoNxa1dpa0kQw6DHD0fu5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ad59rFsmMtUQeUxmO6rgPHtwFxP831hjwBL9wfcLnUCkwr3BhDydIa7dyET3tj30y70KKfrilQZ95oT8eDHetG46mjzIARIQ1Kr58IFGnYBeapeHwM2knPL0p6nOEwP5NWojKyiNkDLVWcDgjC1a8niMs/5v27xv5nrXPLY8ps8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=016EYaSw; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="016EYaSw"
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id WMTLwkI6rMFEgWTktwEeqK; Mon, 08 Jun 2026 06:46:39 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id WTkswpTJs5zk0WTktwWtgf; Mon, 08 Jun 2026 06:46:39 +0000
X-Authority-Analysis: v=2.4 cv=GPEIEvNK c=1 sm=1 tr=0 ts=6a26654f
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WVI2l1SUsQOqE7ouKX8itAqHEXlK88rcBydm/T1c0d0=; b=016EYaSw98kISqk4/omOiVB34M
	qFcyxE094z1onLrD9PebuCY6RskNBlMpuYaI2sFCDUMi/cSrstTu8R5pEkOlc0lYpAuTTASgbCF1q
	KbYjXfnCrvQQGQh8oeezOzKVNx1ZKudeXc3HID9vEOV3hNKEmoeqMTaKp7kN37IjVkBVxfJ8feubH
	Y3JAtiNsQVdzQVsPAZFsT/WMUXTtYOA5QdC+F1NLFkufUkpvBRC2iInm+s9i8N5lxjV+ER/liuOis
	4TKfm7EH9x5TGZAXaTOvJ8HfpWTzUEWBJsl0SxrsqdXimnzld4hKu/YTpWTvjBDL3KSXDVEsmqe/h
	s7MXi5oA==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:53990 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <re@w6rz.net>)
	id 1wWTks-00000000fkJ-1KnH;
	Mon, 08 Jun 2026 00:46:38 -0600
Message-ID: <f9e1e05b-d2ef-48d9-8c2c-57978bbb6701@w6rz.net>
Date: Sun, 7 Jun 2026 23:46:36 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/315] 6.18.35-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260607095727.528828913@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
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
X-Exim-ID: 1wWTks-00000000fkJ-1KnH
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:53990
X-Source-Auth: re@w6rz.net
X-Email-Count: 39
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfG8wyt4Nr9j+S9iDsvyuzawFi0DpgUEeO0uV4doJlHKhWSKwjtbcz0FU1EkxLFRGxno+kilKyxygc9mKvALTx+R2smpw/ZzRZbYaFiIikR5fzhEqkJ5H
 RFsurGLjDuo55P0IXs2x5YcrXQAmTJ7AcF5OJrXmCe+PsaTYTtdE5k1/AyOERe62DAMcplkGk+an3w==

On 6/7/26 02:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.35 release.
> There are 315 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 09 Jun 2026 09:56:45 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.35-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

