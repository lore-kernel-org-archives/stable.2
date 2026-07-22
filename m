Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA26444AB77
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784717804; cv=none; b=W3qeixovJ/mofLkHlZbsDE/ChaSRALsbiABgg1ypp0INxSWq9Vd0KXBjqil1QZe32b2T8qbZfna5jbfi9NVTzJddASL+9VNQ+keOZVTGcX9M/mEJu/MllXhyxQwFZYqtXoubhzf44nYPcZVNPbD1aaKvxrWyS4YNAmSPqoqaIvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784717804; c=relaxed/simple;
	bh=E+M0l2UFnNBpAGkLEizZBQ4E7zeqhhcDjSAtS+CDh4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5f8A9Y5GHEOGL+no86Q3gEYXXp+qLPtHz8WdVWSxyRKoU6riBFRUaKu0CXdS4JwAIj5XfYm5NcT5cYe/2Ekx6R/b8UuXbYi4XuGBRN8X73ZBWrRN8LxCWVx46CVMOYAdmpNjufKXYFsKdQdW95MIVPnnSYzcLBMfMRuwtWatfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=d7bm70fx; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="d7bm70fx"
Received: from eig-obgw-5006b.ext.cloudfilter.net ([10.0.29.217])
	by cmsmtp with ESMTPS
	id mLJawO3OJv0ndmUcvwbgNh; Wed, 22 Jul 2026 10:56:37 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id mUcuwpSuqWDCxmUcvww9Gs; Wed, 22 Jul 2026 10:56:37 +0000
X-Authority-Analysis: v=2.4 cv=Qpte3Uyd c=1 sm=1 tr=0 ts=6a60a1e5
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=q1FuMKGBw0a8ScfmOLkA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KVym3n0vOmbFLS7plGslzmqPK4yT3IdtQjAHeosz1Gg=; b=d7bm70fxbK45LAlq6Nte9r7+5e
	scjM50KEz9/Vp0ithIM8+AYs53n83Xjl+m013VemZ1Xc5hzyadotQ5WT8MB4Pb22JtZHtWhyOlu0m
	TVAM2kttAzDlBGnAH9EhPKIkFyeA/QR9s5I/es6LNqjnePZUJZ6YTPIsX8WUpyQTLd2qA0NxTdSRn
	2qVq4lAtoonvz2GnXPPE1GEYRNghqAnl11oGgHle/T1GSUz/1uP3RRVbBDee6sz4adaPXxVfnl7Bs
	7BfjPdVpTzDitgP8vV2Whwr0rFIhwY4UaPzGWvzH7AxIVTrM1ZpwujAZZWm6H0oL1aGvUSiR1AeF8
	SWIvOPSA==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:42398 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <re@w6rz.net>)
	id 1wmUcu-00000001Fqz-19C5;
	Wed, 22 Jul 2026 04:56:36 -0600
Message-ID: <8575d344-f327-41a5-a7a0-09a403c44c48@w6rz.net>
Date: Wed, 22 Jul 2026 03:56:34 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 0000/1266] 6.6.145-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260721152441.786066624@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260721152441.786066624@linuxfoundation.org>
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
X-Exim-ID: 1wmUcu-00000001Fqz-19C5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:42398
X-Source-Auth: re@w6rz.net
X-Email-Count: 79
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDMW+7lg1poXnzZxMfKq0vcSZjMDRxoD2XIyxGsx1362Z8BXmMy3EHAFnIW+mgSSS75KILGtjlQmUadFlDGdpfkJoSSC3OEA8CqZJQgrOZa6NiySFUDy
 olQdTaCcZWUT1Ma3cIVMT+TesA5a/rrPCeKKTRZ9X9vztK192UIb6QhesUZb2tytEgTIPa3IcL56mw==

On 7/21/26 08:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.145 release.
> There are 1266 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 23 Jul 2026 15:23:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.145-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

