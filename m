Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDDE3F8709
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 10:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790849685; cv=none; b=pO5hdiJX0XKhU9nysUk9HpBlNiDyfNkUkGJS3OJR3yhJgZQmQWeLIUAZqG6lfujvDzxh9yd6NXhyCf8ch/Eh5A4IY2Va7eEFsuLw8I5r5YrNWdg6GwC7m+CSLP5NETiWy7SzDhzwUV3bOBSwrMa0MVkpQXTkDkOhkzhwwfWALcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790849685; c=relaxed/simple;
	bh=zNYMMASuVkfNXipT9zG0D2/RD9OFsrjXnkOdkjtQAwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mOhgNqkKMmn386rrWEGx15XrgbFBrzpYP9+y4zXXanIskaAFvjvihNpsD1Ric0ywnTk7E2gWPFQxTjpHISI6undD7KMyKJJxGigcCFbrCSlrz8JKbfRwbDpTvTABDWcLKdgr39FjJuGEVbyAZBnNMzTZ0gbTPxYAjnm6i0HiMcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=UC8GhJUd; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="UC8GhJUd"
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id CD1sxcfknJFmFCDo8xsexu; Thu, 01 Oct 2026 10:14:32 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id CDo7xVLuAFB8dCDo7x4WRC; Thu, 01 Oct 2026 10:14:31 +0000
X-Authority-Analysis: v=2.4 cv=HcoUTjE8 c=1 sm=1 tr=0 ts=6abe3288
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=pF4DXh_ntd8qpgTqFRsA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8F2aHt8iXBiooy/jOsQTX2APuS4aBTvgaZpOR1e05xM=; b=UC8GhJUd1nGUgnZSHDTxuTajor
	dt17h+RSmdN+r/76UW7YEvA/jiWgv/oaA3fDr+LdjuGiUmtvR3TCu+V1fc+cLnvzOMLZUrKmVcxfu
	NOvPM/pZB0roGc/bLigs7kU6TC87rzuO5A2VoMRdL9XQN5vxatjw3fBzCnc7teOoCOrq8WQVrJX52
	inig7JOShpd9J3vr2fht+P7JgRAjC+pWFl/PjDqAVMrT0dK9t/BCDuhMsP2DTYpM3qFqHl0AZdQKx
	7VHLDA1B8dhJnSAwZ6e7P42GIh8itdRbwo2Gz4DCpCzVDQWsCk4moQ8AZ2EQIIqUEpnUsaAIHZC4x
	5pNKxeCQ==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:40388 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <re@w6rz.net>)
	id 1xCDo6-000000024sC-37tM;
	Thu, 01 Oct 2026 04:14:30 -0600
Message-ID: <35c8c03e-f440-4bab-b53e-9d457ed2149d@w6rz.net>
Date: Thu, 1 Oct 2026 03:14:28 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 0000/1193] 6.6.158-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260930152434.301151190@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260930152434.301151190@linuxfoundation.org>
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
X-Exim-ID: 1xCDo6-000000024sC-37tM
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:40388
X-Source-Auth: re@w6rz.net
X-Email-Count: 59
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfP2xnTtK8KWhBqcOSstJy3mRlTuwKbORBKtVuBCJWy27r+e0iRpnHxxh1Coj4mLMb9JzHEFvi9+GcBT9a7SnupHNIMJ6yNJ+us4wnTIFIumutbMWsu7H
 ECOZGsYzAc9kCg0zFfJBJ7DWeJpLtDyz9M8fNhOavi7Fa9SVPF2pW31NSivloYGlhv0eolb/z4FSuA==

On 9/30/26 08:11, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.158 release.
> There are 1193 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 02 Oct 2026 15:23:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.158-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

