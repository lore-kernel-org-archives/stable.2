Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.194.8.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164549;
	b=LS1IssW/+jcS2Vkf+sUAxX/v2nkBZsIlwu8zc934+edsPRk2qdAjyJ8eupXOCM4+OFHJ
	 jypBIrKnwLK3tB9RWENc9WSKl3JH/urctfUF3IFSrUVhoFZvBn/IreHm/5o2r4udoZh5k
	 CHcFu3T9nyMNqFlVnitkjZtNi96Sh/ljJhZ9MpjYqXb/q9R/1RtZGeLyFWvniVgIT/xl2
	 fF8yvqrrpPewNGcuZKv9VFD8SEtH5pOJRSYr+8oqfqQ5rSjUqzaguzqJEU1ixot46z9xe
	 pCIxQKbiHNH8mPsDfjDfnlKYbfUkdjcVWfU7q29NJHdpT8SKzGGHoJBiHpTn6pP5JBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164549;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=TgNRGTkiSsPhM0kbYSECshrWZcnJhmnC2kdNSG+ZJio=;
	b=aR/GBo9zDeDIBJLtKpJ43OU148aiuRD59G2jAPpp0PP5l4UHhtWT2m+xEN47ziHqEKqL
	 DXbGH88JrLl6W4/hjGGG1X3b/0iyRSq3dlhluM0KvbMynWRqrj4AIWGo1kVFlBP1p+KMV
	 0yWSdOXshDi39RfySJlLQAuX0gPn9r76cJAcl6ETJnlLgWh3fMSqUpS0ql2W+wCctjbGu
	 5kyD73zUsdNtZbYt4Gi5n1TggbZOUNOItoqWWhFx5jbqmjmiUbvkzCyNUcxI9v4H6gUR1
	 LUGX++2hZHaVjgwEQoWoqMI/L6qxfLETWNv5tF9dArfWU4te75Q1LQn07aaQGn6+g5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dolcini.it;
	spf=pass smtp.mailfrom=dolcini.it;
	dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=HGGUvL9k;
	arc=none smtp.remote-ip=217.194.8.81
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07770606A336;
	Fri, 20 Nov 2026 08:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07770606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=HGGUvL9k
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 4ABC61F916;
	Fri, 20 Nov 2026 09:48:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1795164538;
	bh=TgNRGTkiSsPhM0kbYSECshrWZcnJhmnC2kdNSG+ZJio=; h=From:To:Subject;
	b=HGGUvL9kps/7z/rtUC2hLEVlEO7wPoPJ5jW170O9BeDheuJ7NY1ejOgGf+YioV89a
	 hCV73ng86yc4/W5nxjIZQHyoznr0g6QtRgfsKFZbixJDvWO3muPIML9+4iPSN1npSw
	 x3ZmZQisvUdQoEZiFrQXs1Xbl9x2jZcMVkgEzf0+hbNrjIfb75CJ31nwxaGWvcnXCW
	 Y2jY8SRRSUBBo5ktxA9sMAMaZ9pzHMbsNgnGh2h4LW1agQ7420cCJ/iTguB4uSgmz8
	 fgX++uCgTFJNWZTn1MKRz2yxFTm47HirUe+w3RL/cab7VZhc5PvfmJFXiPdNhTN2s5
	 8ONe050TdZ09g==
Date: Fri, 20 Nov 2026 09:48:52 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.18 0000/2144] 6.18.65-rc2 review
Message-ID: <20261120084852.GA41768@francesco-nb>
References: <20261120055114.182757740@linuxfoundation.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120055114.182757740@linuxfoundation.org>

On Fri, Nov 20, 2026 at 06:58:10AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.65 release.
> There are 2144 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>

