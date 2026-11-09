Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216857;
	b=oItVPi1do4XZXT6uqQHc4hMFyke9mASFhNqiRiWGcbAroRJLgGf2YpjbHREcGw/YIx74
	 ak+j83srWfR3HfPG+/jpzHIvKe9EGhEkRQbzbZask79U6O+HDzJZPFxn8jb8+Hb6ONeb0
	 xbykzyAj2HcIoupQsfh65x66Z3EfG9l1X0LgpmWAYxGU4Iql9fy9wk6iKY0i5G5txuhQ4
	 wabVXbmz0TtfiZK3OuLesGVHR4Oa/LzjZTwZJAU3+YHs1CzDqzoaczaLtseV/vskMhZLi
	 pWeh6EU7UPqlaYM6WIYhPnHm9cU/t1BnYDyshd/B+IezUJnsQFdjdkq8VhlvvCgfsdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216857;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=GQyZO4u8YwN90ZByf/x3nUIg6XKgQaPmDNuRTLK33HU=;
	b=hx2AsofwYPLxlkEn4tE+ZVgnrrGQE1KPVXnwxwBTrkkDNNrCJWr0knqaDFGwKcvwPCSK
	 KrGBXsmL1lMYAhuxfXYlnRn+6eCyEt3uEts5AfM3YjP3aR2cZewgS+MgTe+c76WLLslkg
	 xSNJTimHjRWw89KfTHHEiX674yn00E+Sn/dhycXkjC5y5RTrtK+VBAfl5g/G2+Yw+x1+k
	 ORYCAnuGkd7+n4g/XNWQ88NExyyddA3goOl4p6DkpWmssoM6cTvbyhfbW3kHtgAflDETY
	 j5Wt38GecSt5W3PJHwD+lGhd4CIUZEoi47DNWcd+Qjt44MdPC/5NjSV89BFpjtdKCDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=w6rz.net;
	spf=pass smtp.mailfrom=w6rz.net;
	dkim=pass header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=ffFzwrsI;
	arc=none smtp.remote-ip=35.89.44.33
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D2D606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 09:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40D2D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=ffFzwrsI
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id PpOExIyqnAR1iQLlYxT4hM; Mon, 09 Nov 2026 09:34:16 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id QLlYxKqv0b2qJQLlYxdXkg; Mon, 09 Nov 2026 09:34:16 +0000
X-Authority-Analysis: v=2.4 cv=A7tsP7WG c=1 sm=1 tr=0 ts=6af19398
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
	bh=GQyZO4u8YwN90ZByf/x3nUIg6XKgQaPmDNuRTLK33HU=; b=ffFzwrsIihC2IZHN4c1Vhl8QT1
	qaYnsD+LnO7MW6D8+IPLNJl6xT2jlZRZ7ZOCOGIfReavOz8WIkKmYaGFlYH6GfLPYLY6vQINFC7+3
	P/tS9ubF1T7yrgbOrHdqQ5uKF0FJjlOd5S/165JFmeqSyt9VFGrpbmkqHYz31At/woc3BEw52/+cm
	xuwWEu32SN5jNykKQQve9XCfPKqtcxfJrPCUfzEUh8sVjhyjIxQHs7UnQpdeKgsIRD4jBsIzKEqcf
	KRQZTTeAIOWowkwvAiup157cD6eReVAr8UMDHbmM38deGnyUekzv4j8aK8k5rOtQUChVOI9imd/wI
	bGHax+yw==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:57736 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <re@w6rz.net>)
	id 1xQLlX-00000001Wnh-1RD5;
	Mon, 09 Nov 2026 02:34:15 -0700
Message-ID: <6d323bf2-541e-4cf3-8b8b-b5d566bd6f71@w6rz.net>
Date: Mon, 9 Nov 2026 01:34:13 -0800
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
Subject: Re: [PATCH 6.18 000/869] 6.18.63-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261107134852.069646174@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20261107134852.069646174@linuxfoundation.org>
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
X-Exim-ID: 1xQLlX-00000001Wnh-1RD5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:57736
X-Source-Auth: re@w6rz.net
X-Email-Count: 39
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfB099JPDS7vVlT9H4gHtQ0RaWqIqCutYnf9+2F1t1HwF2j78CJyPOE2mO1neTA3/GGfC6g0h3IgLXour8kMjjZZYnj43fP8LwH+i0nrrcuOm6+eorWv6
 Jqs900Y2OPH91focrZVNCGN+7ps20yj1ujsV3ELkH5sIjUmI1oKpsDSHRL5lQNZJpWjhpbLeBL8fWw==

On 11/7/26 05:44, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.63 release.
> There are 869 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 09 Nov 2026 13:46:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.63-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

