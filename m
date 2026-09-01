Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CB035BDDB
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 22:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788303588; cv=none; b=ZnQvfnrRR9v0PC7xv7RMjd9ELoQasOrMmHvsT2qrfMaOdxdtPzue7p9dwTEk5+wFLHJIEnp2N4247Gu1EyA/iPh18rfHtSaQL01346g55ULGmndUtwoeyqfgFd7Sb8kJQ1KS3DxAtB+aht+jqQpyoH9gjmxAkR4JFAXwg54cIQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788303588; c=relaxed/simple;
	bh=4GMS+/yBL/lJXcjtveSASb4XRsIUTAywoH0nVOmZOp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qiyMqbf6KK3mpF3P8cgdgI4mBMYdQNGSaDc1utJjtMM1IviPYzXJYynlh4++d4whVARmVJj/pNjJpkrPHdqGtYIfE+H1QtQkggrw5CydJ8WDjoSZbaAHMPsRvj2U8EpHb4t2DcPVR8+wPNOwKqUN5JHwcQVOJ2repmUBeYawWhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=AWic3lz7; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="AWic3lz7"
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id 1V3TxRnC6hJKM1XSFxoxXS; Tue, 01 Sep 2026 22:59:47 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 1XSExDBCa0FbV1XSFxrQnu; Tue, 01 Sep 2026 22:59:47 +0000
X-Authority-Analysis: v=2.4 cv=Nv7Rc9dJ c=1 sm=1 tr=0 ts=6a9758e3
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=y2ERv7ko0hlTFnYyMTsA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iXNZetiU/q/ap1rhP6NZk7Y9tyvDwvMyrxKwCTccJGg=; b=AWic3lz754FRJknq3+4zE9j3DF
	roUgnU59DKSA8FerByaELF35WjLoeuH41PAnhUI7GbclPMDVD6lISXjhdty1PdgAgjEtJo3Oq2cQs
	Jcr2Ni9IMYxKSVMpQY3wfId4goAFzRysamnRuXMMycTEOXyfbbPwK89dHa15siZ8ohND0F11iTwLb
	YmXLaNo0tVuulFFIwHTlePRVRO4fnDxh92dAhPiBHGSkQiiYbYa909eSJyZwYJxDyF/3WFE1EETak
	8um03KaG7OPSN+ff+l28tOgqADc7etH95pE7+iOxP8S9mGgPApKOPpcVzoAY2uqKs4Apajr2vxZRC
	FvR5nPpw==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:52242 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.5)
	(envelope-from <re@w6rz.net>)
	id 1x1XSD-00000002ANl-491M;
	Tue, 01 Sep 2026 16:59:46 -0600
Message-ID: <77ea1387-4712-4289-a1a8-d2d849884908@w6rz.net>
Date: Tue, 1 Sep 2026 15:59:44 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 00/76] 7.1.13-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260831133359.185608553@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260831133359.185608553@linuxfoundation.org>
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
X-Exim-ID: 1x1XSD-00000002ANl-491M
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:52242
X-Source-Auth: re@w6rz.net
X-Email-Count: 39
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNRiojdeUpk99FDQcvL0mNQDAo0xegSbXlj4u03YGCIiOCQbfsy/ejWY6cjHSkrdo2+oxMuU6/tAmh2VWUzv+eJn8nO3bZ4IpsRMizsa/+pjdFpOtK87
 xINMbSfAy2n//WXfbaZFDhqNOvYMQXkeWJ4258jwDwHoolAGryKALtTV/vbVYdBZhvjtKuRD9sXpFA==

On 8/31/26 06:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.13 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 02 Sep 2026 13:32:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

