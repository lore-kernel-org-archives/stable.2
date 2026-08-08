Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69DA2C0F93
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 22:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786229026; cv=none; b=CvWjC7HO4LfSjeOO7IBxNbtrkyh+OViaVT0U7abi/GkcVVOYEFTrOVaYAEfZWW4wye9RiQose64xAsjF6CugjkxAR7UvTEzPEzWiHnQjsxJkEJaxbgHBZSKHj3x77MFjLUjbNrCRQp5vdyjOT4kbztcgfzeeumd5uvtqcXO0474=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786229026; c=relaxed/simple;
	bh=WQNO37vNbjBWm/v0T9sYB4LoJdUqvKhHkyJsKNQtHd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6O4gYMEyGHLnvmb57CHGNda/zVn1cye55niB/sHINxoETGlhhXv411z2mpkI5+YTcCc73c6h9zHvQN8JqUNxWlrxygX2SuhZNfFZQpScMdTvB5tA3F+GeWdXOg4qygohwjBCoES4arKhMlgHcHwc3lsOuSXJaNuh/5cJIw51n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=FmnQFj9X; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="FmnQFj9X"
Received: from eig-obgw-6006b.ext.cloudfilter.net ([10.0.30.211])
	by cmsmtp with ESMTPS
	id semaweUOxuFzgspk0ws3sM; Sat, 08 Aug 2026 22:42:08 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id spjzwBuvjxg8Yspk0wcWfF; Sat, 08 Aug 2026 22:42:08 +0000
X-Authority-Analysis: v=2.4 cv=R44DGcRX c=1 sm=1 tr=0 ts=6a77b0c0
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HqJ6fxJBhJPsP3w6xxD6j9r1CBfPL7YdRkdOM3J2fbA=; b=FmnQFj9XBmLgK8+MuFm//VqJkH
	MgjOtRre0FvK5z3gUmYyglWUDxM21ZPmrIxGKeHe89NfTQhxp9DwrKFDS4Fg0Z+rRrV4eN21i2tYd
	LB2VmgHw90ECdx+JqSgbjT2+v+fKKAcqtkgk1sbvbxuaQllo93uzsZoN1U5ak/Tnv7idgFa2Y8j4l
	Xx6AbHpPZenHQr9V0+WdWH6wwBIw4+PiPVc8JzSOeix1WkbYx42y9BNoRzupJzXjNdR2L5fy7ceMl
	juBxuFXxQKUX/q1ZyXH5iGPDPoV1DpjfLukGnkgoP+8FuVIiqKeygk3RXcgS0c1Bd2H3T/cT9Ja0u
	t9pKdaVw==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:57908 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.5)
	(envelope-from <re@w6rz.net>)
	id 1wspjz-00000002yIA-1MwF;
	Sat, 08 Aug 2026 16:42:07 -0600
Message-ID: <0f2c030e-313f-4c6a-bb7c-4f274c0c3d72@w6rz.net>
Date: Sat, 8 Aug 2026 15:42:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 000/438] 7.1.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260807143428.008222056@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260807143428.008222056@linuxfoundation.org>
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
X-Exim-ID: 1wspjz-00000002yIA-1MwF
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:57908
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMDofey1rDmSM/RTD+5XYmr+PDnnZWe2PfH1k92FxA+zd1lmn86mmtktMy+0zWKrCLhMYfzjC92CqcQn8CCgWk4rqrTarBo6Qd52oNQUnfxUAONUj9x1
 vsNVell5JZp79DfjfHAIiU3AH+/QkWp3V1x2aLu3zG/lhwettm11lUq7gXRT2c38qJKY48JDpqIMEg==

On 8/7/26 07:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.8 release.
> There are 438 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 09 Aug 2026 14:33:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

