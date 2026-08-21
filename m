Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAC9368D79;
	Fri, 21 Aug 2026 03:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787284569; cv=none; b=elDGvqMG3iDBPdBAZTxPIMOTOamcqOMar2sQMK7uUMJYibJf4kZhCzXFk3byLPv4Xp5bKtDAJPbAFm0kYLQ1FWde0FleHO9Zq+UMavUsNfTlDgWZryRBgROwA1CgjCO2UmG+9Drukc2fRajgML8YZA/zezasAA15U+tbxHGWIzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787284569; c=relaxed/simple;
	bh=rFgyW0CCUOyuL4MGImdIMcHqXvvrPq3DHt7fLWDXAAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUzx+Xhhs+RxSY+la/CoFBysI3HW1egsWddef5uJgQCEhOUYMHiZv7BTn6lMmFtxYImCoc+GEjAFXWD9kpBsvXp+qxf6U4nDvtwNyxjFHICCQiUW4482BDLfDy9/8u5+RK9HFIAT4sJJlpwt0EAgssyJetNWxc2zNSWP2YYZxTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=NPDx4ymB; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="NPDx4ymB"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 1488B14C2D6;
	Fri, 21 Aug 2026 05:55:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1787284555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wGRWO+tAi7xOiIa/HKxTACB8oxh9kJLCOdsyOY+Cfok=;
	b=NPDx4ymBDhGWn687EMBIEoTUSqtjxFP3chgMLMEVCSKiGLi6Jqmwdt2tesAz7+ahv6oBE+
	TfumCkRS87oCLDnhj7FIZfgO9104ncR6GjeOOsUzNhv0NG9wulObq6sbgWG7ErlgDmYVPJ
	Nx+AkBObjMndDd7o8UI65g21kVkU8c0GcSGMeS9L8Qrt64hNVPz4IIT5hUh24IYpn813g+
	95xhOf1hyO9qWmpsL+aB1ZEa6MMyM5TMQgsRjPsXrM9B8PgrgzyNNkzJyULCY6CGFFUYpa
	4iP4INlKxRVWkS0LQHdCgFyaGOA2y+CAMSK5DzHBwlFNg0BT3zITkEfM3Ceg8Q==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 5cdb9e62;
	Fri, 21 Aug 2026 03:55:48 +0000 (UTC)
Date: Fri, 21 Aug 2026 12:55:33 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.12 000/220] 6.12.105-rc1 review
Message-ID: <aofMNfVyo8B_6WkV@codewreck.org>
References: <20260820145223.480031205@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260820145223.480031205@linuxfoundation.org>

Greg Kroah-Hartman wrote on Thu, Aug 20, 2026 at 04:53:10PM +0200:
> This is the start of the stable review cycle for the 6.12.105 release.
> There are 220 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 Aug 2026 14:51:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.105-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.

Tested 071632e1c770 ("Linux 6.12.105-rc1") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8ULP (Armadillo IoT A9E)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
-- 
Dominique Martinet
