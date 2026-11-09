Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217404;
	b=RUfctvAcb25xa7XcQolE92kqxX9HklzODFgu791AI2wKs/JMyHinYjKuNv61TW/dEXYd
	 MP33jx0Uvl1zqDGSTvr0XhApND3dGlbdWVczQNuKV4GZG6cjxdi4jCcNnNZIaE8y/5aCf
	 1fIem/XkXT1O3dqUVL0mO0h77NFmEsTYMUAhpysZMAKBrPU3WHvX6i33YB1W0Za7SViA6
	 WRbAkaAnt64BMSs5avhgffjEbsxRxfWhnN9l/ZEZxXpvqhop9z8rLa8RgnhTlKnxtactB
	 DlZhdgLLEzHfplPAwkW5yJ8GQnIdo11OQ1PTh+gKoTGF0DJihuyYJW3ctGRxhItnktg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217404;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=yi1ow+G90thtWMFWQw3RlqtN48nJc3tJpdrsLfQiqXU=;
	b=Rnedf0u93yMUXZ0gwPxElsD7yZlu5sRWEh9Zr0gFNKVLEA/QLjLThnFA1uwPwYaxds7R
	 WzA44VCvNNQ2IKXzKpSNIFwE6dwkiFMnyY/UpomKbrpCaq2ajTteGAnH3zSVUV1iNTZF9
	 BkTmuuTcTxdehUkh2chlBWQiLe0i9riKLteNljlSj5gJb2mXK/S+dKnp3OXiLAfOBIkoC
	 wDr4ldCbps9Zv+QLRBplcjg/E+GbYwo/+CkiTR5g0YuCAmDXDK43MJiZ9iPKNCiLHd4D2
	 2HrLF0poiXibcXDdfN173LHlp+8iHLdQ2ckhn3ZbE5YbG1VKacm6zDIovJu2Es0KUZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=w6rz.net;
	spf=pass smtp.mailfrom=w6rz.net;
	dkim=pass header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=2pyVIKuz;
	arc=none smtp.remote-ip=35.89.44.35
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBB7606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 09:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BBB7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=2pyVIKuz
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id Q0d1xkH1tRiNxQLuMxHE7h; Mon, 09 Nov 2026 09:43:23 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id QLuMxOHqFxmi7QLuMxzBVI; Mon, 09 Nov 2026 09:43:22 +0000
X-Authority-Analysis: v=2.4 cv=KuFN2XWN c=1 sm=1 tr=0 ts=6af195ba
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yi1ow+G90thtWMFWQw3RlqtN48nJc3tJpdrsLfQiqXU=; b=2pyVIKuzjdUTdaJnBEWHWWr6mQ
	+7ouAwbeyIN2sPhEnSub57XusAYAnkL2jlFZR8DKg3QInmhOkriEcR/txIb7c72HHXeJMhear5fae
	DX/qPaXYzBHKzsjzwJfeVndEHF/VTnPf5ssF6QShmqbtAZSU9b/vO85J67NCQ79ENbbOWzn02RDo4
	wjbwdeziYucIBsnEbis8Bz6PQoYIqZ32dT0QphmYeKJX/meDAwUEf3diIXQjEUoA2nq+Wkxc+6yYv
	jEoqKcU+AP5ZW6G5SC1/BurMAXxsUWbmM6iOGbg04rvwf6W9GhqvfjBeomZMvSYCnbRxp52v+JYXO
	AWA2Hy7A==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:53826 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <re@w6rz.net>)
	id 1xQLuL-00000001Z40-1Q8E;
	Mon, 09 Nov 2026 02:43:21 -0700
Message-ID: <a0116c6c-e947-4a65-9202-6a8b06a7e127@w6rz.net>
Date: Mon, 9 Nov 2026 01:43:19 -0800
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
Subject: Re: [PATCH 6.12 0000/1536] 6.12.117-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261107134957.653319350@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20261107134957.653319350@linuxfoundation.org>
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
X-Exim-ID: 1xQLuL-00000001Z40-1Q8E
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:53826
X-Source-Auth: re@w6rz.net
X-Email-Count: 59
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPS4YbWe1ru1i+LfWSaScUl4lW91ItjAmMzNOPVYVByEK0drihjcbiNpiBmCWwkgCGZeUPFmcVvihulM4ZzGkoJVX0TbeQfJ45+2LpmyeIDPfj0FzXDU
 25DDt3OaS6adunWjaDk3b4NH/7TD3exyhCinpS62jGsaOoOLIckZf6mVrEtCj8NmQXq0kA706kv47g==

On 11/7/26 05:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.117 release.
> There are 1536 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 09 Nov 2026 13:46:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.117-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

