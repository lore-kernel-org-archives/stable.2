Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4AF4EE87C
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 10:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850583; cv=none; b=F3QS5tornh0UM8JNzvpHKoiX7rC9r99myO3Ew2M0alyXBUIfEO7OP40751wgpA6SoLD+TfgRoYToFR0EjOJfKdgaax21nSc5zVzNrZf8cAEbnH9AFpGNRR1y7ZIl+lOIEHLGYzGm1Wz6ox9Ve9u8qnwtAFecu0h3S3fx9ha1/3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850583; c=relaxed/simple;
	bh=sP/DbQmp3AVdY02b3JNmJFPkJpOWFYAVJ+aoLcNuDzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cdbgQdcj7Mfu4Equ/myIcR3VdedROreY3gdcpKMaFrhDEqZANsiFjAPxY5SCNlb81a6ButyMitosXQwVDxPUfR06iagU9WYxDe0tetpgYkSjV/nOnuhl5/Wj3IzLJDAM1yCREXDVgZbPqgO64BZ4aw/BeKo7B2S2TwLMgGdDYDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=GEqOTacT; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="GEqOTacT"
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id C8Hixd5rrFNWBCE2mxaxPM; Thu, 01 Oct 2026 10:29:40 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id CE2lx195jouFZCE2mxXkgw; Thu, 01 Oct 2026 10:29:40 +0000
X-Authority-Analysis: v=2.4 cv=Zd4dNtVA c=1 sm=1 tr=0 ts=6abe3614
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=1U6l_maTE9sjzKSKvmAA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=W/lt9wqsWakalvOip/DfM/77f/a+Tpu1hx0kRdRuBTQ=; b=GEqOTacTW4T2Z5vGWjEDBhnz26
	pMaxxu6cprKxVyDRblfzQqtWKey4cA0Vdr3Siu7YFA093VEjCYswWCqaTEphiWlSF6b/gS2sxLiln
	DdbcTWkOMdK3mCsSyFfKcUvvWUqBGL7MhaCvy5HnkTQA96FnrFiYbh1vaW4aLL03SgamUy/XEWdJj
	ThDUJtxNJYxPZHtGODQILcfeVDhOuWFOM82iH6enQC31JXQNoKoyLPVLGZBwYy0y3yi/nAWy6+n2u
	hT7FtEcEc3mNuXGfi9cmJnm+ZN63Vmp6GTpcEtpdFsKai9SHIwLeoApT5UE7ARlkr1+ynEE+D2e0k
	LWpP8ABA==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:47712 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <re@w6rz.net>)
	id 1xCE2l-00000002DAR-0mPT;
	Thu, 01 Oct 2026 04:29:39 -0600
Message-ID: <688c0ec0-6a22-401e-924b-384758c6f383@w6rz.net>
Date: Thu, 1 Oct 2026 03:29:37 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/752] 5.15.222-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260930152358.131179731@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260930152358.131179731@linuxfoundation.org>
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
X-Exim-ID: 1xCE2l-00000002DAR-0mPT
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:47712
X-Source-Auth: re@w6rz.net
X-Email-Count: 99
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEa3DTx5PoLn7MvSI81KSE5kZg3Ftp10cHSDbR9IQ6I7nHexsL2JuuW2AvJTpcgQ3a9rKs/c+tiz81PccSQCutOmpYXUvQLx6x/2nX8rT4cvpWpUH5oR
 NjhydMpL7iEl2qd0uO/J8KAQtbgB0qehyFDsYMLSS8A8UI14pWpx4ppym+xiwQ/Cd21Du/2eoazUuw==

On 9/30/26 08:17, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.222 release.
> There are 752 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 02 Oct 2026 15:23:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.222-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

