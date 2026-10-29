Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284987;
	b=JHkLYVjcN3mRv1vbjdpM53E2qy2x1NioAPyZZUHyPYtWJ2AAvOo5qQKYgd3Rm4Zh+kmY
	 mCpbPQLeW43WBm+EA7vjA1MS0FKWBU3PfDuLriS0M7k3EBguQqD4GRz4uAoH37+YKhgAh
	 EsdqKvYiVkzxmsjnmPSkJm2f7TdlU9efLlXLfHvTgw6rMGdkc1oFDVlfrJA11OvKh/RHG
	 FBQE0c9qIJ7kul8PR4xn0/04Y5zRoNHPAV9Cg9CuNCoHljpyB5fZMuBKaJ48wodVkX9Ca
	 jcTo4n3w8InIyxKOFhGjV3IGe/c+CfN1IS92XD5bKryLSixSs+kjJq8DVwiSE2xv0kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284987;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=eyh6Jg30SC3q+FdYZBg/GM4D+RvJ56ziKJ7PTcUL5uc=;
	b=jAYQ2juoRUsfDp+Uv9qDxaSla+cFf9pxynd/PFShpBMHO5mO5SyXmihx3HG97qJlphyY
	 sBQVUPVHSFlHWaTrZVYRt/idTJMSrYx4gNJyrniOUiN5JpV+WI30SLlO5iVwhMCfMbwjc
	 4FHOag+Ytp1hvB5r8xue7zojk7hhaTgTjgNCcPE7YG1pzlFOXJ2L1ZH494yDABiwXZTuD
	 VzzELb1xOPpQn+o2iAKuAmbWYrKrREZbUUP34zEYodqd+2eJ3+4prA0AmEy+fFL1/Lt9X
	 o1BdpcHdPVJV2QLcnTh77UcjZY2yFehZU6gMBEl6UIsk89EkJsBpihY4Tp6sRp3bWDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=w6rz.net;
	spf=pass smtp.mailfrom=w6rz.net;
	dkim=pass header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=RmHGhRkD;
	arc=none smtp.remote-ip=35.89.44.37
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7F7606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C7F7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=RmHGhRkD
Received: from eig-obgw-6002b.ext.cloudfilter.net ([10.0.30.203])
	by cmsmtp with ESMTPS
	id MPTSx7Zhfv0ndMRLIxfkQw; Thu, 29 Oct 2026 14:43:00 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id MRLIxdIcj63hBMRLIxIelB; Thu, 29 Oct 2026 14:43:00 +0000
X-Authority-Analysis: v=2.4 cv=CYsI5Krl c=1 sm=1 tr=0 ts=6ae35b74
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=gd70FcSm6kLz_1JTVnEA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eyh6Jg30SC3q+FdYZBg/GM4D+RvJ56ziKJ7PTcUL5uc=; b=RmHGhRkDP7VD6lPusB2l3sOgMh
	ca+9yVfw+mO6gznMAr776gM5TBfju6Ylo3vAvgtRsSvhBxJ+ztJWZ7QZeWs9n2/g1NFQBAG7Kid7h
	iLFj5bTg0SPRT2BmfJU31BwFTbLNQQQHO0jWs4muvIzDK26unREAAo7MZ41IJqL53dKYUjImDxUse
	RxftZRzA4o6stumcIvWTbcpYLAhL3McgrqBwSUf4vIpKTs7BRHjqqxRDWt5iR9xLORv45HyTIIqd0
	I1aY2E+pPFC6q04c4pduA9TQAy1H7ea+j812qfR7OQ/wCEtAuQc4DqkKRVQy5gSczWdRfqQF2YCCp
	13A9rpDg==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:44566 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <re@w6rz.net>)
	id 1xMRLH-00000004Ft5-1NoY;
	Thu, 29 Oct 2026 08:42:59 -0600
Message-ID: <8f04d550-2acb-43a6-b102-2e513c3804bb@w6rz.net>
Date: Thu, 29 Oct 2026 07:42:57 -0700
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
Subject: Re: [PATCH 6.1 0000/1879] 6.1.191-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261029073135.159947193@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20261029073135.159947193@linuxfoundation.org>
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
X-Exim-ID: 1xMRLH-00000004Ft5-1NoY
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:44566
X-Source-Auth: re@w6rz.net
X-Email-Count: 119
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLhpM1fFLzHxUn6DukPYgWJM8z3xQJ3T5d/vgjgLRFdjRsjU1VBnZvdQm3OcKL7cH+qyAeHFecESnP2OJP+7qj4IYWX10nR7/cDo3+ZiGlBOg4+xy4Qb
 5C3TiGS1kPpX928NEvZbKse3BWa6MzQsQ1XTY0B0MItJmOrv9HZfuobrum85cgM6f5ZI1WmzvEPXkg==

On 10/29/26 00:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.191 release.
> There are 1879 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 31 Oct 2026 07:28:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.191-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

