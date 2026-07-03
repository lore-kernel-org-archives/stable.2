Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F463DA7DD
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783087892; cv=none; b=kyxLIfSm7NzpFgB5z/t7mpv1kNaHEmaiW3oNnFBdw8lJJS+XZKaNh7N8cdNVP2Do0PpQlO5tDtE5edIiv33AwpdeqWdTu/jyFRa3hR7d3o7gVs3KWLa/v9JiQYytovKiSUwBrEfrSb8mvSGEbq9sMFTIS6IR3SzBLvaT1YwoK6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783087892; c=relaxed/simple;
	bh=QfaEvWCK0TFbz8Dby4LzGWfJeT8MGmbNwMElNdKfG00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5P/sMYzL2y23rFd/Sj6M48IEJjbm4aMxpyz8SnqSlIb98lnnPm+V1Egaiy7TOoAysjnYUxgKQ8hsByLLj0NPDmSqNcvXh++yLTNN8358hW1LyYIVwvysIaFyb9NFUWGYCIinzC1krJRnQpmQNhxAp4RzbOC70GN06bmCFP3aBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=DrdifLyN; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="DrdifLyN"
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id fcv1w8oLmVGUKfec4wrZM6; Fri, 03 Jul 2026 14:11:28 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id fec4wN5NutyQ7fec4wVhdy; Fri, 03 Jul 2026 14:11:28 +0000
X-Authority-Analysis: v=2.4 cv=E5LNpbdl c=1 sm=1 tr=0 ts=6a47c310
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LXmauMmFM5o8XZvtMJYnhw7usPvzHCs5ijL5IT5TRNk=; b=DrdifLyN0EQn9L/qPsfvH15gU7
	qNj9irH8ACZNBa2z91raM58g9wBsu520X73A4BF0kqh4p9yljmthpRqc5LbQJJPXMmP0V9fF7Fpst
	vokw4OhV0OoPhRZY75jZRZCPt/qH3aJQzH5X35LuikVnShojhHWW+Ag5jBYuoKZ7FoOR21oM60CW+
	Ia3xv2c7h+eJTVA8WfuLcSfxXQGyH3z4L1OZpIVgxZpzeTHmY6G594ULYxSDUXZEQtdm1XGBUaIoX
	TfjrBtSvFYMcNlGXtjI0+LdyJ01YH2DU7whrYLtT5e1a//6YDcWGNfmahgGM1eUIomwUR5LYpZyr/
	a4vOL8gw==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:34116 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <re@w6rz.net>)
	id 1wfec3-00000001CjJ-2EnL;
	Fri, 03 Jul 2026 08:11:27 -0600
Message-ID: <3a841fc1-2820-4256-8fca-590436b8ace1@w6rz.net>
Date: Fri, 3 Jul 2026 07:11:25 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 000/121] 7.1.3-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260703072822.817328079@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260703072822.817328079@linuxfoundation.org>
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
X-Exim-ID: 1wfec3-00000001CjJ-2EnL
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:34116
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDzbu7vQBa8AwSrz26F8YOuMNZ8hDbefJqclhjkZi1d4jgWfSp0g1uB4mi3eYdffQVr9+5RCcBY3/YlJ016KjmD7Ce0UWuhzrpq3EEa7k2vQqFmCiWUk
 uTqbpGtA5BsHHPZVezgyM17PH8xxcYeBO/2K+t8sjGWMKq5BJn649Ao1yUVnaefYoBgEM3N/3dVl6A==

On 7/3/26 00:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.3 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 05 Jul 2026 07:28:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.3-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

