Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FE73033DE
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 06:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785566909; cv=none; b=CEpyVuxHlaugMSViTXcf2wnKNJl6UeFdQUPJ7xvf/Axmpt40WBK1IEN9zRwLdwQ6xbwU8qzLUyb0yIdNSd6y1y+KcIWjb2F7h+p8pXTrZK1KfqEvWIWDnjZblN00ZJfAsmgRsrFHKBkjK6wGx3eA2a3BQZMjayzaySYWXBwcg40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785566909; c=relaxed/simple;
	bh=j5grJwRUJYq0YA/ewI/TYDijk/BSUwoBPp8rxDYsxtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=olyEgk8JMb0nGiP6P192axGwRFP+goQtrgIIkdORK/NIPBfqhMnng01bcHoSxMI4//mEzEDOUgQ6yv/K5dMwlx1+Nk+npisiOXrbircTDiyOVTCOSFliSlZB2K+Crzs25NqZoXRppBc6aQtAHTQ13k+BGQYU+18ozQyVeHr1iXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=rO+h9jIs; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="rO+h9jIs"
Received: from eig-obgw-6005b.ext.cloudfilter.net ([10.0.30.162])
	by cmsmtp with ESMTPS
	id pePkwquJkQ4O6q3UhwNezO; Sat, 01 Aug 2026 06:46:51 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id q3UgwRU3EOYlBq3UhwjwWz; Sat, 01 Aug 2026 06:46:51 +0000
X-Authority-Analysis: v=2.4 cv=FLYbx/os c=1 sm=1 tr=0 ts=6a6d965b
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=UTrMyZqyYUwXjXkO7ZAA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xbkqJ5Gv8agIBaTZaEXUCWrENE7QXwvgxS5L9DYc5Yk=; b=rO+h9jIsbL3Q4N5FksHnG1tzIu
	ugYkGvyGoR9xGLaOYPYb58uvZvWC0ReT8eUOSyqbVi1rEnjEriZgnlMCzk8B1e2usPlHxsZD951R0
	PKxuHl+UjY9H01y/puYFXqSH7HD05rVg9iDlWx5mQ6SXKrW/5U0JCrS42M+Sb4dfHiDHEjvcHYiX4
	s3rrl9YNKYFzJxTnRbiBjVY+HASaJDKOsSDQU9N0IMgrW1/FASwhRQNHd42AT2gS8R+E/IsS1LK+Y
	rzyh9iOX6gIhlq5i9vPQDl0kxo5tqAyTyVS67YG3tw2MAhgbL2/tS7qCTWHtgj6JHda3vHq9d//32
	pDx7qItw==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:59552 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.5)
	(envelope-from <re@w6rz.net>)
	id 1wq3Ug-00000002fzc-1DB2;
	Sat, 01 Aug 2026 00:46:50 -0600
Message-ID: <3662dce4-a9b0-4b72-bce0-5e4a49c3cb2d@w6rz.net>
Date: Fri, 31 Jul 2026 23:46:48 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/602] 6.12.101-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260730141435.976815864@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260730141435.976815864@linuxfoundation.org>
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
X-Exim-ID: 1wq3Ug-00000002fzc-1DB2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:59552
X-Source-Auth: re@w6rz.net
X-Email-Count: 59
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPa+HCI0KuO8VC4rlNvtigk+K2c87xN3GJtp2yHaKh7fjGEQsMlnXVzwSgE2051q9iPDJyUfIQaiUNVHVMLuDUAyHqZ61qhgxk04gXa8wTEYyvGDet0r
 OM3y26D5rj7wuhGtq1kYt9Ij1lOmWMb+tjPPkvY1T/J/CMfQAJwY2ke3/oHFFxLyH2fQcoHwTaWf0A==

On 7/30/26 07:06, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.101 release.
> There are 602 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 01 Aug 2026 14:13:43 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.101-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

