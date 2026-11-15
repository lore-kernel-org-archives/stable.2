Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794752010;
	b=MzHiuCrCcaGCpiGUEsG9Ur1Z9eWtLPlIy+HoADZ0XXZV4/9MDhj03s7WuB3mQagh+Qj2
	 S5LrACZRMWv7Fey261HmRzHYw6rqzPUvmt0D+xH5/hXWHnB3NL8VXLRptQUiVLniiLlL7
	 ZU4jfaJL+zqB9gKCZjDLxjFcHfGS84doqeF8qengyuQmi26E+z96I1Ur/er2SbpN5P3Bu
	 LYa74IUhfa2xG3CfMypMuuPcXQnl5biDZbgDAZdoYJaqA4ijdd3gjGF7FvumFPGEoncuj
	 CP2JM/AW+ivVAcUtWXsaqMB8n6GzJyfY4rj+qju+6XNQH/UiVC2mRVi8GDVQOriPCrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794752010;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=0xim+q1z6hKsGOa03BvjGqO7rsl/bsEW2TceTriCWhs=;
	b=Wuc3sCVQnG6TZ/J1V28j5AjPxc09Hwtvo1CU/vcAwW1rHJANES97xEgAZYwrsloTEX0f
	 flURHhRXUPDtCN4AS1Jnb9plko3Jzi6LOR9Lji+emzaZbtDFyZtcydvvlFlRKrDyH5lNc
	 Sy5IBfqlWUBiJs89jRSpaEyESp0m+FG3JTpL/sTYXSuujliH5mU5YKu0gDredGl9JkiW5
	 DH2zt+AAAxIRMoI+5b4LgUmLnI34VNr93irHJpA3JIEhPHRZfF8H9Yv5I8x1dVHUKK5yp
	 M42tPNhvQcg+DctGnUEFxa61soCZADar9sc0eTAvL16XKqfL27RZU/fApwMG2TTC/fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=w6rz.net;
	spf=pass smtp.mailfrom=w6rz.net;
	dkim=pass header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=iOZau65r;
	arc=none smtp.remote-ip=35.89.44.39
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E548B606A31A
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 14:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E548B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=iOZau65r
Received: from eig-obgw-5007b.ext.cloudfilter.net ([10.0.29.167])
	by cmsmtp with ESMTPS
	id SQTMxh5lpyb4YSaz3xkNjS; Sun, 15 Nov 2026 14:13:29 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Saz2xiDeQxqjjSaz2xb0uo; Sun, 15 Nov 2026 14:13:29 +0000
X-Authority-Analysis: v=2.4 cv=bZxrUPPB c=1 sm=1 tr=0 ts=6af9be09
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=lrVcCulGc5HbUcuc2QIA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0xim+q1z6hKsGOa03BvjGqO7rsl/bsEW2TceTriCWhs=; b=iOZau65rg9utc7aZzy67lPpjHG
	6Pfcd4FyUKX48RkDBWa5vcrvlgUCr/xpH8lX4bPfaaw7kWplKHUc3V65zfXlIaqWAoe3+h9hhc5ri
	pXsJVBQBtkhsB6Szw+1nVei0aobOXL74P6dFwRKp3YceqcY7rLFWmKyLNfWKMeFMJgra4ARecBHGS
	a7zkwtPs9ivQoVZKRXHNciW7GBJ4x3q8zNZ21aIK3yEhqwIhCujx2UdEgk1rcseyCgW8Rp5DOOobZ
	VK3kxYAmAPgAPgaja0hf4ErIeXJhh2OjTJmxvUhDLpAq7T4b43tEreN0of7PU8WTjoaXycYT+AJuD
	Q3zjVybg==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:39976 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <re@w6rz.net>)
	id 1xSaz1-00000003Pm7-2fd6;
	Sun, 15 Nov 2026 07:13:27 -0700
Message-ID: <0ebe7e46-ed0e-4afa-a4ca-6921a2d2fb9e@w6rz.net>
Date: Sun, 15 Nov 2026 06:13:25 -0800
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
Subject: Re: [PATCH 7.3 000/507] 7.3.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261113153753.358973689@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20261113153753.358973689@linuxfoundation.org>
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
X-Exim-ID: 1xSaz1-00000003Pm7-2fd6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:39976
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJfcNSBgIefTC4Y/IL/7uRqiKsu408LetxYhnyRFsPzQafEg90fHOeADMqDaUXrn6yFl06OojKDLj6Ne7qnBVaOBPGuNHVnDVlg+mLvl03Fs0bua31Ci
 +VvfyvmRPFd7jTazRRcNSLZoIseqqqmuOd/J3eOkG3S8m+brq4K4NcUna3LfOcIPZaNFSMoKt816FA==

On 11/13/26 07:45, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.3.5 release.
> There are 507 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 15 Nov 2026 15:36:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.3.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.3.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

