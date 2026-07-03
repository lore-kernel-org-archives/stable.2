Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49A137A824
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783088279; cv=none; b=mXebWQQ/bYC1Q+COw9j8TgbUrZ63ACkqCatfDU5sCWUbEtC6PUiXmfFewxlcRA+c/DnYlLaqm8y99gYNC6KD279rUNu59JQJaMfjixPsuqoCb6uyOp04tKhMMVP4TIecO5FIbTjhFhFZ78c3+xvRGaMqfs69cNQMz7wBz5kW1y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783088279; c=relaxed/simple;
	bh=203q+PZxflqgUVFTbOXiCcOwXlYDSd5zcGzIcr1Q+Tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aac4F5lII4TM2jzbHHkGBnpPZUnzXhcIVeKVXXF6AsBLLCL/1qptuI/GzuNrPz0Xk9jCjuIJGaPJlILj+kt9yCYkpZPzLnjWP6Pu2V46iVA8amTuF495flPmvZzTU88kgdt82RXD2UTm4mGFzpW7NscI2awbqxV8WlNEq4kKzsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=EHfU0imm; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="EHfU0imm"
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id fZkiw7KNTlPo5feiLwOICb; Fri, 03 Jul 2026 14:17:57 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id feiKwjYRBFb3lfeiKwkU5E; Fri, 03 Jul 2026 14:17:57 +0000
X-Authority-Analysis: v=2.4 cv=Xo36OUF9 c=1 sm=1 tr=0 ts=6a47c495
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UkCVNYp8Pn6QCfWAZTxoWtIaR5MAEWjBiSOwsSzYnP0=; b=EHfU0imm/eASU2YQi1y18aUJmc
	CzBL4XMgq5zQ6lSjp+N5Sr+0jPVTAAaRAlDAQ0wD/LU0W6XX3hv0uYa3kNUUBIyvEJXaFYRPOAgL8
	Y7n5D275mN8QWhYlpNyyEV3MJzzOK0vxMsU4tyCuRpGz4dvQu3xTW7X8dOLPk+wVLbSRUvZYC9DsP
	QGDzqfE91wcyXtmATWG9HDzB97ryZOfzyHh5e2aX+LEzEzzW/AM5yxdqvBwxUq5NAx7o98Db9fMpP
	GZSwMC+gyHsmLpa+vYAJwLVzICRA1fcImncJEZrtKkcvqwfuuGkwhC/F4QXJTYcIkTGdUzg4mHlhZ
	CZ21U0Cw==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:54732 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <re@w6rz.net>)
	id 1wfeiK-00000001EoK-0Ans;
	Fri, 03 Jul 2026 08:17:56 -0600
Message-ID: <3a7eac36-24d4-4534-9431-6700a422110e@w6rz.net>
Date: Fri, 3 Jul 2026 07:17:54 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/109] 6.18.38-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260703072816.644513463@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260703072816.644513463@linuxfoundation.org>
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
X-Exim-ID: 1wfeiK-00000001EoK-0Ans
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:54732
X-Source-Auth: re@w6rz.net
X-Email-Count: 39
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEne0DslobwDCzkoHcx+NC0zk3cehEwBMMsCq459RNUBtgJhKjLMUvO3zvldl+9M8drh/2uKkZgbjAOQQSUL5JWMDaCsnnsofW2erdjVUVRqVdJizIky
 ZwT//1c6iEVThKYfB8jfULzgUdAstaYE8EsLb1+HcvEX+i6GCWYWM/hh28CPXBAIPQMmX58U6LAQ5w==

On 7/3/26 00:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.38 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 05 Jul 2026 07:28:03 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.38-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

