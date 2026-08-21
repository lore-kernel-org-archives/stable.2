Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB043624CF
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351871; cv=none; b=rSjU5+pYjjygNMslvTfjT8CGeKG5PIwgJQfAJqzFrZzmif5d6ICu0WKxoclDg3HESFxLn9foqjWBrOGp50pn+mRlxdDB8ADR9ig9/l0An0/RicPhcvzj+znhFPjw7AKkODyHARPlHN+icUdXddSfU3om3Tzl5OtzP8gIl87FkBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351871; c=relaxed/simple;
	bh=DQylWsC7gmpTuji71C8X3tELRa4TAbn02WonvLZ73PY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o83K15MM3DXV1SkAiPwRleZiVF+f9y+cHF/Tj9n5Wr0ezHwd9TCFoRjKzVl+CgnYg7HI4sdmtsPry07VjU+gXlGrJ7rAgIkhg84kAjlgWKm3TAs6x4QpgzdAqnKEaxt1w/+SASfGxqvUSgolNmznCnqZMpfSDraxX9MysxfdNa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=dqHCocIG; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="dqHCocIG"
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id xWijwgl0zhJKMxXrxwPhwc; Fri, 21 Aug 2026 22:37:49 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id xXrwwikXslkAWxXrxw2Phq; Fri, 21 Aug 2026 22:37:49 +0000
X-Authority-Analysis: v=2.4 cv=dbGA3WXe c=1 sm=1 tr=0 ts=6a88d33d
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=9znkghA2arZQ6fEvHFMA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xRp1Dla8OnY8ywg018hTRPXAsoGhfh4jls4UZl0vPVA=; b=dqHCocIGVmmAPnYhbW9dwGCtxt
	tfYTaES74I9TFtD1DZcQMVnruvpSqb76jFWhsM+708DSpBvY0K6FkR0fXlDCKyEoN6oY4yYItGhrp
	KdMlHcxIgKlcrtnsg5bzNGhl7ZQh4Hilog4OOZd2sCOMD5s3fb033nQBahuSKjFn9iGokuhXeLDkg
	Fbev9wYVoj4V3oVFN9ND1pLu1hluPur/yUhmAsFQJRnV3XeBy6QlWYb0O+Z3d2QcvTwNDV5T2qgGM
	etenvM9eHxxzgF5kzRiw1hytcfLqwTqDV1blmOg0Eq6cEfjDBeqeOpfNbKkEPTiqmt7mgS5Wr6QXi
	6+JGOk6w==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:39194 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.5)
	(envelope-from <re@w6rz.net>)
	id 1wxXrw-00000002G4Y-0RNa;
	Fri, 21 Aug 2026 16:37:48 -0600
Message-ID: <1e1c06eb-4931-4a05-a39c-81724df2a807@w6rz.net>
Date: Fri, 21 Aug 2026 15:37:46 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 000/228] 7.1.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260820145244.450574346@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260820145244.450574346@linuxfoundation.org>
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
X-Exim-ID: 1wxXrw-00000002G4Y-0RNa
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:39194
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLuuvk/+kVVddk852N891/vVQDCLbkdXqNu8oI6x7AkdRD8vQf4T8Yp4tdWAidUxQ8xrNQz6F8Ivn/22jadnW45qSafVu5bKsPTU1JJPUcKF1EH6GJp+
 Wk9LHWnnCz7WPvhWl1CK07Bxm92OWZZgEU4KzIOv3D+c7B1azjRtDX7p+azefcAnWHDpkNi5+pjeSg==

On 8/20/26 07:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.10 release.
> There are 228 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 22 Aug 2026 14:51:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

