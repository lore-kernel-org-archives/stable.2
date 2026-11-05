Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888185;
	b=H2KJpVxXjSnPn/4BbZXlMB8D54Jgie40sX/ryAzbo7xRFHrUV986dVppNWMUWaGt7V+e
	 tBMt3SPLSiTaqgVirEgwFotESAKZHfWKcs92EuuhOUwzeDxfH3MwWZL43YKCcluaIlKNz
	 QxyHqa+3fr253QNjmhrXTJrqXT6W/j6eyoCYNLXwczcZqmX1hhRZJBWF0OhHI3udZgEnA
	 fN0vqnw9Zd0DS4jzMTdjAA3jy26e+ZllJqirnXjmSqqMleFbAMOA2kGu7nxEE3kpmd4Uk
	 KT+5Vrl77fQmku5zOh5ZvkhD/jyMYXeuw2PnWYzsNM2UiEg1Wdy5qo5yhl2gfzAVBog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888185;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=rAJsX7tX1O6eyar/UVT5L0lDjUzhUYuddF5rtYMCgtU=;
	b=gFekDLvAyxxJSyAChm1B1R8OigoYon8IIixrOukV6/u2hOIb7saDJQiWlSBllG0WQjcp
	 ogv1BENJl+pbIucgwTUDh5RmlKGeroBtax2PiEq5zQfDJed26nBE9RvCZEOjIDDMvdHWw
	 EJ4TFfHZqGgQGOHsdKVKSawOgF5Grkh7RofnknAVCZckIdQhGfg9s3f6fWDamF9LbWi0Q
	 9K/tTVYUE+vCKFaImq/XWlR1BRuIJOQeWv5so8hatXhTqvS+KTlRB3HNdBlYpsMfJ9Lui
	 fQyEBCoOYKmrzY7bP/GlBeCgznZRVJ/mSjd4wI/uHSsfB2aQrCub3JpJMtRsse0LDSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=w6rz.net;
	spf=pass smtp.mailfrom=w6rz.net;
	dkim=pass header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=GUAw7TB5;
	arc=none smtp.remote-ip=44.202.169.39
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF73606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 14:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DF73606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=GUAw7TB5
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id OtB5xnZZTOOJnOyGNxZxYT; Thu, 05 Nov 2026 14:16:23 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id OyGMx0qrMVqSeOyGMxKTcF; Thu, 05 Nov 2026 14:16:23 +0000
X-Authority-Analysis: v=2.4 cv=eLETjGp1 c=1 sm=1 tr=0 ts=6aec8fb7
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
	bh=rAJsX7tX1O6eyar/UVT5L0lDjUzhUYuddF5rtYMCgtU=; b=GUAw7TB5T7sbZkip1C2bDIqUHQ
	VoZfxL5dfLJeDnCOzd0k0/SJB0MmwdXUeWcGzdaRD/JIDce9S/Jf0DYRbsbrbjtX3cLlftnGko17J
	6ZgjTBe1tnS8GkpsyEFSdhBeXy1QoUVyRIqAOPhU0aP5opq4WAX08d0rhTSJ8khfYGF6BtHijorVP
	GVWQAbY/1xNSfNJGX1OVvn6qP2MMPcsdKjnaSpvUhTjz4rYZcPzpAcwdQUJxxnHmnWNgTyOGmSnXL
	VaE3xRRJ06FATMnOZv/TgaiiL6waXHcg5haAQKe+ViBKRgRbJrEPu9Io5BozYxGm3SoolMfEmjD57
	G0XnLeAg==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:33262 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <re@w6rz.net>)
	id 1xOyGL-00000000VVf-47L5;
	Thu, 05 Nov 2026 07:16:22 -0700
Message-ID: <788c2383-1bbe-48a2-b667-226e311bf8ca@w6rz.net>
Date: Thu, 5 Nov 2026 06:16:20 -0800
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
Subject: Re: [PATCH 7.3 000/547] 7.3.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261104211038.406938024@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20261104211038.406938024@linuxfoundation.org>
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
X-Exim-ID: 1xOyGL-00000000VVf-47L5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:33262
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLWidq128bIGctjWu9XDzDuG0RBZmkbuD8umd0AuK+Z7/WKfFMWIUpJyUGGF9+Ff8FJ4tilOMcJuCG/ryAXBa6Amj6P0OXMzDmf2AKjS8L+9sXJ6CzYh
 acryqdODXpVO0KeD/g5nZlyEjFE6RWXNTx265MrvPVqLU4mWIXoX1Naw3RiHo1zT4XDr0Dn/6bZwsg==

On 11/4/26 13:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.3.2 release.
> There are 547 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 06 Nov 2026 21:07:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.3.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.3.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

