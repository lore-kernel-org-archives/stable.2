Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4194431A56
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 10:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850168; cv=none; b=l09iu4kM6txxC4Bbz5CLkwWxfgCCI8QUy423zNjqRMfpMNe6ORU3G485iOKUrciBhJPuA5QgYetO92eO1cSA0v8O72R50g2PKdldnYBmA4ZOUrGItzmae3TzZCjpTHAdVVGXiRexjDJ9fhYsKNQZLpUN+Rxw56J9u/03xUW2CH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850168; c=relaxed/simple;
	bh=lYV+aGdOlbyWsCfqjUxoGvGWFrt7Yd53iUUMUCJdJw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DOzhcDbfV8fmKgt2LJaMwVzBZpJSG6qohBHvJmkNfSiDqgcATBvlxL8lBf6xBa1IBxHVDu90YD4JxNK28c8Lv9ZpO4EmuZHqTprx4Hy8d9HyJRw3m4fGtSYNXmJDdF7PcRPThB3cZFJzlVp4vQgLAZFZU17tZ/YDoB2dCp0WLc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=slplXF98; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="slplXF98"
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id BwojxNmYHc3XsCDw6xFwkl; Thu, 01 Oct 2026 10:22:46 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id CDw5x3Dd7369DCDw5x6uog; Thu, 01 Oct 2026 10:22:45 +0000
X-Authority-Analysis: v=2.4 cv=EPgG00ZC c=1 sm=1 tr=0 ts=6abe3476
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=gw1vPjYz7fKNZfABw8YA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=V8ux61Vf6g2GgLRKlVGg9jLngLQp77eO0QTB9SwjYz0=; b=slplXF98G4071zLgakA6IrJqnX
	7MIrU7NRrybzTHrLjAVXHGBzgNRzCD1a5wm55DKG+7Dp2rUPDkifjMIr0oYppWUIAoVdM6ftk47Ee
	H4AHX7K7vn7dvy/uawUhL7dxviGMMivx288VpJJrb3UqAbQtAVap68lyS3CCixtUIstUjNNlWKorG
	N1f4p8DS7JoJi+69W8OR+6QlpC75ZyQjZaD3sCV+qWzuxid/ZHzHEmlx19k3r6QZuYdLHA/gL5+47
	e9ZU50H3o4JBmImn9MlaRMLfyFL7Ojz5Zf42MhtqCLw4CC5KpKsuY1mnWRkKbaUED9HsB9uVKEq+U
	zau04MFA==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:46824 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <re@w6rz.net>)
	id 1xCDw4-00000002BgR-3ALX;
	Thu, 01 Oct 2026 04:22:44 -0600
Message-ID: <5a9cec9d-ef9b-4f6f-9daf-201c72ea626e@w6rz.net>
Date: Thu, 1 Oct 2026 03:22:43 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/982] 6.1.189-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260930152416.775402466@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260930152416.775402466@linuxfoundation.org>
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
X-Exim-ID: 1xCDw4-00000002BgR-3ALX
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:46824
X-Source-Auth: re@w6rz.net
X-Email-Count: 79
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCpK9+XpD8PnbHz1IcYQ3dsKAeHpL8ZD/iFZ/a9wCNMNdv87u1igzFnku29SiXzPmBbHN6U8Pe/bLmrnFv5MxjEFe3m+MUs7E2GnL6Spc4MbygWTABkC
 jKP6TUx0hoB1z7DYzbFvoiYbABU+tSj75f7E3cFLAfJM9UNZjaixLz6FXrJH4LFZRKgJ9G9vLEytzQ==

On 9/30/26 08:12, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.189 release.
> There are 982 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 02 Oct 2026 15:23:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.189-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

