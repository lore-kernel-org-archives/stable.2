Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6FA4DDB5F
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790848483; cv=none; b=JOIxeUCcHPVldT4Ol82Tlw6ntp14VKD6OAqFKLhK2ByOwbkFXAlEsvUhK0Tq6S6ykFIDgJ4meYA5JOKKc8hJN+duvGeFhIXs6nSEDhATY7WXcdnMgX97VGIR/YUAIAGFSI/S8bERlmH9YB+01ag+U7zrYTa1m7h581cCqscKnF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790848483; c=relaxed/simple;
	bh=4l54vCzDztAGtQxKgbgqk4unJ9vbW2nH46UeJ+VUb3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WeVrTZWeQv4W0K0yh5GzGaPwrfu7QChEfAQdysv05GmZjm5d+IU9X76WgT77BS+ruiY2cvTWF/fYZhXrjiLMKVxfp3UZzGZy9WvnQM04EwtAGOwCmakD+f8j2paT/CqvSuGfKXW9fnZo7tHJeQ9nRST1ptKxPPZUkk9+3tLbS4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=iiEDaWK8; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="iiEDaWK8"
Received: from eig-obgw-6005b.ext.cloudfilter.net ([10.0.30.162])
	by cmsmtp with ESMTPS
	id C59XxLQzxLvgbCDUoxTWFP; Thu, 01 Oct 2026 09:54:34 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id CDUnx087TvvPpCDUoxdYLc; Thu, 01 Oct 2026 09:54:34 +0000
X-Authority-Analysis: v=2.4 cv=WqUrMcfv c=1 sm=1 tr=0 ts=6abe2dda
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=ccWbkBLqp_YC2vtNz0YA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xPOgNI0Wu5aODQyfQTZtAZ5Gmq4YbAmlqNVL5C/kRMQ=; b=iiEDaWK86KrzekmITc88chcvSq
	/VqViuVN9hEI4yeW+NerfwGSZzk6TcBFnfAQYZlbn4Tl6vb4XK/RJmJnJlapRyke6WEENJRUNiKrn
	nq46ZA+lfVVC/BvsZvyZtI2mnkpgygMR/5bEzzhGKJDkXyb36ndgaX2NW+bhb9EMxKleOgtfEs2w8
	E9pKyTUSpvYet6H8509EARXpmg0S4DVCx6ysNIgDbZm4rYejHIUIA6Xv7CIHOWnAa1lL78QgOEu0c
	nZJBAtyblLjo1y7bbZyiWcp/2eFeOJWQ4qyUPntmcD4voKlx0aJHemdsUjPsJVEQmgb/qIIsnWeyU
	zJMfMOTg==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:37432 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <re@w6rz.net>)
	id 1xCDUn-00000001u9B-0mM2;
	Thu, 01 Oct 2026 03:54:33 -0600
Message-ID: <5b315d80-b9b1-4834-b699-425bf6f60e94@w6rz.net>
Date: Thu, 1 Oct 2026 02:54:31 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2 000/457] 7.2.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260930152346.024115587@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260930152346.024115587@linuxfoundation.org>
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
X-Exim-ID: 1xCDUn-00000001u9B-0mM2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:37432
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIrTY0Yi0Nyx3vj90Dnrwg7r3qqghs69MUFmsc3uQpcXodMbLICm94/iL+agpQZ91pszwhxyy0ThUVb8Zlq/FqFjejS+tFRcJiT9nTH52y5t9jhTXcC4
 pylsuKVmOlubV7nsO2gpqPrwwy/OxCWfjwong/4D0rdcJV/jV8RGXBtEqoPqVT5GR1phC2sFi8F9Wg==

On 9/30/26 08:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.9 release.
> There are 457 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 02 Oct 2026 15:23:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

