Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795145001;
	b=bsDk+83Hzd1b9tT0zi0/8kuY7Nu6mNdue9dNcz+zA5bviKOMIzeud7qntsPcD5+C+G32
	 LbZA6Glv/Rv0pGEfu4a3j5dipLtfyXrQAtelCQ7Xg787d8TaOuey5DHknAhnWlJoA6tQ0
	 ipleYemWn+fsQCLY6Etatxajy4bnfGFzsamKx/dQ5LUcNnI4kn1SJykkDF/vnAFpFYckF
	 YYBrhCFaQkmTV9b5Pc6Nvjj96C5yPdYL+MiX5D2k/7G3QlNegMxawr+cuFbzzJzbUDENA
	 2/+kau8u7JcrPhVE5xyOcqruU314WphjK3Mgl8hshAs23RKK953GNSQAlMURoNHG0Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795145001;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=QwSbqqhIeCd3lwJK3H6J77KqNCgiR19fVC1pv4z8yCg=;
	b=r57Sx6mTeNhpTri8CGOgoPFhm+zcCOzSWayGhmBIKEbQ+nNk+F0Oy5f/Eeh0XdQZidbd
	 YufSxFsjJIlpKDJtw8f4J0etI8Ia+jsY+SpcBXaP4kP2hInKh7joM7e5ssEZkv/GIXG9i
	 3C88cfvxWAuAwyuehd/Pnt4EWnCWIPY5ZT1Rp0CSoSC/IBISSff/KXLYf7PxEbBOecv98
	 6UNsZwpgLEF3WqZsxBOCw8b7HFV2sTz3BcDmd+AM+of/ZSgZElGLH3z6+9LHQQYkBYNEr
	 DKi972dZomUarb105U+6sZWQ+LW1dFmpT7mGvdPOxdBk9UXgR6LreWtpQTZtfmwhI4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=w6rz.net;
	spf=pass smtp.mailfrom=w6rz.net;
	dkim=pass header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=smRbKp0k;
	arc=none smtp.remote-ip=35.89.44.33
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38124606A333
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 03:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38124606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=smRbKp0k
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id UCHXxFebbAR1iUFDWxB4lR; Fri, 20 Nov 2026 03:23:14 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id UFDWxPbrAlaNKUFDWxKOaV; Fri, 20 Nov 2026 03:23:14 +0000
X-Authority-Analysis: v=2.4 cv=UbpRSLSN c=1 sm=1 tr=0 ts=6affbd22
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=j10-6H-SaoHoQRfmf2MA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QwSbqqhIeCd3lwJK3H6J77KqNCgiR19fVC1pv4z8yCg=; b=smRbKp0keZVyrUIkaO8OdNHX1v
	XgWJGX+DNL/p+oMeAx/RJTNgqTZxQFdjupg541c8Vmp+4rPu1Q3fpZ3vwDVq6RwfQk+fvNHxdgsp2
	+T1Z2lTzVu6Vaem6BNWD+LYB6yEGg+QO6Bm3i5v40nKPvZ2uqCMKcBsnJjyIKBD3kcDzcrK8nM+bD
	zfUpQpUHOvCWN6pkvzQkh8h/L2k7pSQNsqXImU9jQtGFTSWTHSNnFz8+PX2sHPFS0udl3BODyk/Uh
	d/BQfHllzkr+IPVjbuhipJvsw0m5HXPWRO65sGZiQgN9xA9zMiPn0hjVoJFS/aSfjvQOc7RVeXIdC
	+BC/qGKg==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:55626 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <re@w6rz.net>)
	id 1xUFDV-0000000185z-2FvK;
	Thu, 19 Nov 2026 20:23:13 -0700
Message-ID: <508f60eb-3665-4aad-bb85-8180d4330898@w6rz.net>
Date: Thu, 19 Nov 2026 19:23:11 -0800
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
Subject: Re: [PATCH 6.18 0000/2151] 6.18.65-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261118150121.603863898@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20261118150121.603863898@linuxfoundation.org>
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
X-Exim-ID: 1xUFDV-0000000185z-2FvK
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:55626
X-Source-Auth: re@w6rz.net
X-Email-Count: 39
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLSV76LcY//rYSM5uAUMTbktyrNtEONmb8dji3C3VcNX13s9sTQ3ychqIbdDmzAlMSy+/GPjljt0aYtg9P3Xcw1JzuBAYyeX7tDUuXwqTVI+3VnpuNTt
 fkmkdHr6KirxcoE68sp1R6POaESrnCtJVpqFAde0r3fWaOYuR5bbQcfrlyUmQYvD0/m7x9KKs2sSsA==

On 11/18/26 06:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.65 release.
> There are 2151 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 20 Nov 2026 14:55:45 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.65-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

