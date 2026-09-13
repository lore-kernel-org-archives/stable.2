Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A046813D53C
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789339836; cv=none; b=biORTkz9/IFXJnFHfc6AcaT8vcOon3wG7JzBiKzlsBsA+N5PSsqSdTBlXMWUhTO9BphEB8Tk9afubtFK+Q5tFqBx0EMC455m1Yjb67vKq6UIXAAjGKSH9HJUaXZ+qm7iLb5Kr0p5tQpaFh8siXJTXEimqcbL5l2SoxAhi3u+584=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789339836; c=relaxed/simple;
	bh=1SapwLarVLUKuf2Yct4DVa/wfPq49Tyj8KoGEq+CEGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XD5ZaoblY6dq2y+UG71hw/1LYvGBGnqHth3Cd/bgf4rEpsC5K9RQgA4kOgfHAeuu/D4kWlFD5yzC790cEl8uzLs4kc3odftoBP/g9rZVP4/eilyx1X1hJSvN77ekUp3CUgsGlFi7BBfcZVKlyNVTnLp5VpH9kos8rPX2DupQOEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=bP24o0W7; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="bP24o0W7"
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id 5kkVxqECuusRS5t1oxDa09; Sun, 13 Sep 2026 22:50:28 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 5t1nxpSGkfDqY5t1oxexEy; Sun, 13 Sep 2026 22:50:28 +0000
X-Authority-Analysis: v=2.4 cv=HKbDFptv c=1 sm=1 tr=0 ts=6aa728b4
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=vzNeu8RWQyP7H5n5pB8A:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vt6MSuLCzxqEfCZMKPtbgk5QGLOI7pUcLTqswg7cknk=; b=bP24o0W793adp197BC4Ibukq+O
	2QmRg12xnLgVr9HIGCAHA8SfiBA/U8s5/wINMKXC+H+jaK9sRup1mj6dhaDY4D1Dthh5R5/kuquhg
	06srxJ5mUv2tIF2yNtXChCCc8c+XhrSYzTyvyiHTXSjRDacVzkTpcYihXr0LofV1uqEDO+0anHHhs
	2baM1DFfqWsVXlHRYlKo6nDp40GbRlX1vMOTqaB0c6ReH3DjFmLc0sgIl1ZhX9ZbLedmAmCPtYpx7
	0txSQ2Ef79Qvwbsx/9nFcbflp45KzyExqXgwCs4dGMufDHGwKojGQXJ/VeXQltOJbhl409azGX8sW
	ayhq23Ug==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:46538 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100)
	(envelope-from <re@w6rz.net>)
	id 1x5t1n-000000029Ve-05VO;
	Sun, 13 Sep 2026 16:50:27 -0600
Message-ID: <5bf5147b-2db3-4b43-8b94-aeb3c9da08e1@w6rz.net>
Date: Sun, 13 Sep 2026 15:50:25 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 0000/1518] 6.18.52-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260912065623.398859879@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260912065623.398859879@linuxfoundation.org>
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
X-Exim-ID: 1x5t1n-000000029Ve-05VO
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:46538
X-Source-Auth: re@w6rz.net
X-Email-Count: 39
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLIevyvy+NQ+MLUvPlerA0gUDG1DsxT6E/0TNyHN4gosW9gyrHHzWR2VOKDMStjbHQnI756fbLWrmyjvPiiW2W4ecM61qEsy9Zc4HJCbPWNpQV1XaKtL
 4twM9Z8ROQLw1OHekEyzX0RzAbCBYtHVyVyBafZB6kLJEWusD6H+fniv/FrJyZbVfMP584jlQd+SHw==

On 9/11/26 23:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.52 release.
> There are 1518 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 14 Sep 2026 06:54:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.52-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

