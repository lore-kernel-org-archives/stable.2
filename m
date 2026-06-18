Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B50D3BFE20
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 07:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769048; cv=none; b=OptU0Pt+KTZ3s8UOsbNf9eUKTbPGMNHBS/eqvSlz1aIYLCA61usJEHx/ucNbknleOZV7TmzontAB7qABkq6LrttH+n/YZaMt81yuEv6RVb2ED4vD4Oe9d7EYu1UfyiU3H9wVzyP6PSU3rwHiZQ8qj+DviaC6WJtNXzenkgQONt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769048; c=relaxed/simple;
	bh=rn+zy/e/ZeAC44w/v/H7qg6arj7K1GkOCEd7mlpFdvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rb0cejjOEz87FAplQEwR7RXtvg1kI7QV4oevWIz5BOOYgpZwLWwGxyaXFKLl9LMFq4tCRmybEB6eZ3QYi5QDxQNNxpX5QKHD5/i+b041zECMmbsrRpDbeIpibOKJSW98AY2vqO/jqtLTyqpOQj2sT05Tw3eWJQ5ExRjoasZkjII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=OgYu+9Q+; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="OgYu+9Q+"
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id ZuYVw7IIKlPo5a7UtwIcbM; Thu, 18 Jun 2026 07:49:11 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id a7UswCVkPnfJUa7UswJoG0; Thu, 18 Jun 2026 07:49:10 +0000
X-Authority-Analysis: v=2.4 cv=KajSsRYD c=1 sm=1 tr=0 ts=6a33a2f7
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=m2aUGJL5Bn_ZWkTGInQA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wovJ2Y92WH+qRJQhXKzR+9Q1ewYt5crlA4w5uU81weY=; b=OgYu+9Q+fAPtjBv/JLnJ9Nubt3
	lg298Wc9jGWnKNNHCGwvjrfIYdW0Ue9jaPAEsvAEvrDvb/ipkwg/hkJyLdC9I7r/f/I538OyXUo1P
	YwRdQ+CTdqJrpEwPJ46WWadwHhMkwHwfOwfhr77UdJKSk6xsj6C3pRKi/FBunHuJNY4pJuZQZuMsM
	DDTpNACo2LBAvjIv9hPkvFBK4NFfSdKkxp4E1wClVTzjyxSHEDdmd0D9tR9aUomABWS7otWqPXPUn
	iFa2Y+Y3R0S5z6ecFo+Rzv4btQRehEVdw6+0/vEH3sHxQfizsxE8/69G0aOUnLFXeXiU5oWG7CPxv
	BcUUtg4w==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:58930 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <re@w6rz.net>)
	id 1wa7Ur-00000002GGG-23f6;
	Thu, 18 Jun 2026 01:49:09 -0600
Message-ID: <4ed1320d-2e9b-402f-8684-d798a7d41e45@w6rz.net>
Date: Thu, 18 Jun 2026 00:49:07 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 0/8] 7.1.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260616145523.335696673@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260616145523.335696673@linuxfoundation.org>
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
X-Exim-ID: 1wa7Ur-00000002GGG-23f6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:58930
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOFBZ4HMJ39SbTJL0X8A6OFViah69mtfXdisk5Oeu+5xEIRVCayS69lsr7ebz2r4kqLrCf9YSW0sfF9nEFbV0tWiJTqAHvbM12ibN7xpBtoFZSO35kMI
 cTwdH54Cllsju6zNAceN1JzE1FVmW8JbqQ9T7sCff/3RvS2ULHIyQASYfc19Li8XmlYfOiGxYuohBA==

On 6/16/26 07:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.1 release.
> There are 8 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 18 Jun 2026 14:55:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

