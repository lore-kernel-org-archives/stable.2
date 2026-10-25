Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792930373;
	b=5nG5dCJim8Z6FFfG96kGUMcUdPblKPLY6tA5IzJ+t3eOJPXL9czzz9LyvfM2Vr/esAib
	 rPMtyT5iAtViPUyD0NHChmPKQYZLn0C5UgSYTt/xSHV64Dso6LsndkB78svvtBBtN6Gp8
	 Ow6Dv1FCbjjrA+wkub6G78BNaI8mk1r1ZsQfu8MAqHF3YczrDr8YWff0sM/Irbkmle+7R
	 TseVqL8ZQnSgGfYPKsdC4kB4V/NThHQufdhw2UFfLNaQPx2/cyX2bzaYc7EsPAgdGCWB7
	 bUkzAKoX1x1BLZCqCyndWNeEhhurw/MEklZhj0/j4Y9V5Y+jl8qzdmTkVN0eo6tEooQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792930373;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=1FkAHFrZwr/cZl6m1vojFQ55ADEqETD6Ysw/d07Oc7Y=;
	b=hYli635aPyJaE8PrebgBVjnF50nwxOvoSxD4tS4YsR6idRJ/wRWVxQE159SFPvlRMRW2
	 qHYxPdQGZBoOV/5UucIv6ivtspiovGcPijWE242dZFDYfTrrGPmURe6uTusQmJbl9qLHP
	 TVNRdwnvmiwcb/N5w2nmGFAn7REWbtdpuitU0kpESHohGwDVsvMnXi780/6pNo7kUW5WU
	 TmyMe/oC6nWXFrLEcKnaDNf1U8LPAPst7VuyuKrjix4Aha0WCtf5RK4c/x0Dej1ksyPK5
	 +R7mkoNJAr5DMknyqoaVLyLxKPrHpGlSvpd2pOx+ctHDpgwfxvIDY9eFwTwHGTYaGAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=w6rz.net;
	spf=pass smtp.mailfrom=w6rz.net;
	dkim=pass header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b="IXYtTV/2";
	arc=none smtp.remote-ip=35.89.44.33
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCB4606A321
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 12:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CCB4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=w6rz.net header.i=@w6rz.net header.a=rsa-sha256 header.s=default header.b=IXYtTV/2
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id KwtRxhJ2ZaC0UKx5nxMJc3; Sun, 25 Oct 2026 12:12:51 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Kx5mx30TBLWsIKx5nxklwE; Sun, 25 Oct 2026 12:12:51 +0000
X-Authority-Analysis: v=2.4 cv=PPsP+eqC c=1 sm=1 tr=0 ts=6addf243
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=3X-YNANvarMDBeD6avQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1FkAHFrZwr/cZl6m1vojFQ55ADEqETD6Ysw/d07Oc7Y=; b=IXYtTV/2CWD0yeWGjVN4k3k48J
	H7P4RGT6fcWXNIakTvBGy4Fv1aqpTMfrRXs3mT8GuAMXckPMgIIYHSeASbykYiNOV6XzNJ3BlPl0a
	lhee0qp2LhOhxa9uzGl/v7UqM5/D1PcKbkZgnhmrDg+qeSyumbfotfvm0s1thlp9QUrFV1WonSqwY
	6PUiiyoYwpDCufaTkSzKcv8zLVSSKVcKg1P1+ks3hoCOqBdTHUsxtfB3uSq3Z7klGLDwcjlFev5p+
	I8Sep+TUeXNBxYWyOfHxauz7ADSK3iwaCk8wgH1goNqV4x9QgDZDCdsqrGng+FniDZvaJdfyz5B7N
	R8Tqb4MA==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:57588 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <re@w6rz.net>)
	id 1xKx5m-00000001pF3-0Y36;
	Sun, 25 Oct 2026 06:12:50 -0600
Message-ID: <567fa279-bdf9-4634-8b4d-ec64c627ebb7@w6rz.net>
Date: Sun, 25 Oct 2026 05:12:48 -0700
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
Subject: Re: [PATCH 7.2 000/243] 7.2.13-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261024064731.125251200@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20261024064731.125251200@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.162.206.103
X-Source-L: No
X-Exim-ID: 1xKx5m-00000001pF3-0Y36
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:57588
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfN+PosXfRDhhcKSOjlL0X9ot3pf1c4VJ59KyxKNW51r3mWc/YJRtNy0sckPU8PkrmOj4cg+KY+w40P1esZtNMw8PgzIpxH8L9pZLR1hb+61C2fz0bdiL
 2YU0cbazqNoN7J3i3SYkHNFZ/MtXsmSKCotPLZ9iC41ZwIDw7wrfSDEhFMC5JHrSx/jXS8ersDkY1A==

On 10/23/26 23:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.13 release.
> There are 243 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 26 Oct 2026 06:46:54 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.13-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Upon further inspection, I've found a dmesg regression:

Oct 25 04:01:40 riscv64 kernel: faux_driver regulatory: Direct firmware load for regulatory.db failed with error -2

Unfortunately, the bisect fails to boot on the very last step. But it's either commit "fs: stop sharing fs_struct between init_task 
and pid 1" or commit "fs: add umh argument to struct kernel_clone_args".

Note that in the commit message of "fs: let idle threads share init_fs" it states "Note that kernels before 7.3 need a different 
backport.". I'm guessing all the fs: patches from Christian Brauner should be dropped.

git bisect start
# status: waiting for both good and bad commits
# bad: [7694d244b4f8a6e187060f1f66cc734f5ed16d7b] Linux 7.2.13-rc2
git bisect bad 7694d244b4f8a6e187060f1f66cc734f5ed16d7b
# status: waiting for good commit(s), bad commit known
# good: [cc9de5d4b5ab6459f5774946aa3195ad51236fa8] Linux 7.2.12
git bisect good cc9de5d4b5ab6459f5774946aa3195ad51236fa8
# bad: [fa9a1ea1fe845ef8d55048bec58f0c1914f98190] lib/crypto: arm64: Fix lost Poly1305 carry when resuming NEON state
git bisect bad fa9a1ea1fe845ef8d55048bec58f0c1914f98190
# good: [8e0e8f6a2381e3a945953f522af34add71424c89] fs: notice when init abandons fs sharing
git bisect good 8e0e8f6a2381e3a945953f522af34add71424c89
# bad: [77d6387712803b293c9735c1511a70d38d746590] ring-buffer: Use subbuf_order in available memory estimation
git bisect bad 77d6387712803b293c9735c1511a70d38d746590
# bad: [25afd3de9842d1c1f2c443fb673bf9dabd2e5ea3] net: hisilicon: hisi_femac: Move setting of netops to fix crash
git bisect bad 25afd3de9842d1c1f2c443fb673bf9dabd2e5ea3
# bad: [fc4fb8a05292c20b1f7cdc310e10dad30da3ccdc] fs: let idle threads share init_fs
git bisect bad fc4fb8a05292c20b1f7cdc310e10dad30da3ccdc
# good: [7af0a9a193154ea8818b1d46930646d94818fbc2] fs: make userspace_init_fs a dynamically-initialized pointer
git bisect good 7af0a9a193154ea8818b1d46930646d94818fbc2
# bad: [14ec8230d78887f5018867013520f05e212aa701] fs: stop sharing fs_struct between init_task and pid 1
git bisect bad 14ec8230d78887f5018867013520f05e212aa701

