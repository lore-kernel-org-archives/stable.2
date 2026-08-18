Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5421E2E8DEA;
	Tue, 18 Aug 2026 08:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787042830; cv=none; b=MGHNh+p9RFRt+CTah6kSJ7Opq+N0jM04yvmh5VTND4PmozSToAAhoxMqX1Jxas3TxA8JS4OG7L7Jb98xTPAJX4npcVRsosSu5Xbz2T9xfuY2VvHEC2diHyVhhClxV5aY5jAkCxo7ut9V1EsmkFwQOVey9fLKpCp2cH698+jml1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787042830; c=relaxed/simple;
	bh=ShCjcT9AK2+AwNdZ42DdapWG8Nhfz6Gc9jLmZHc0u5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqxU9kHqlYQ8XXKodfPkIbl9P8W97Wwkq90BBGFmUCvv+2xqLbCv9Q1qd2ySst/fbs2lY99J5VJEenhkBhWMKLZ6akXNJ/MuVO9I/e2d1mzuQQfL7xhp46ZqzYL1QeSjVH3cGuiFMYC+03gJwbTZ+VfBxixD5nmJGhxl8m8j3bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Im3KipxB; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Im3KipxB"
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id 8B4F71F947;
	Tue, 18 Aug 2026 10:47:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1787042826;
	bh=JgubjlH3uI7vh2l/1yiPRb/q1lF2YM80LxwGRC7xPEM=; h=From:To:Subject;
	b=Im3KipxBKHftsxj/SSHIjSolh4Fu1IZtfrl/wxGaQ8/ET8x/Pa4apvSWVXWdXSLBL
	 QEjF91ONx4vsf7UVtH0vQKpVMWBOQ2xkxVJe9XdjYBBpnUjccfuGsLSDpWTUiZWhKk
	 13bho9PlCgq3O1CWVa2DSTHvYm0APh+EvnW4vIO0+tJJ7cGdfcz2pRYTWojifJGFiA
	 Q8wt3dFf0R+RWuFt0/oETEXdiRl9DIVGY5qQAIdi4xM3O+OF12ecJGKEuqakNaphQM
	 ZukYyRYVFNNbbEfpyCL0K2RYOnt8iNIZdCjpx2x+s9wmbtj03YAT5Ebzd5pHc5iZlW
	 LlYMZ34pTmPPg==
Date: Tue, 18 Aug 2026 10:47:04 +0200
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
Subject: Re: [PATCH 6.1 000/609] 6.1.183-rc1 review
Message-ID: <20260818084704.GC119228@francesco-nb>
References: <20260817132543.039278408@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817132543.039278408@linuxfoundation.org>

On Mon, Aug 17, 2026 at 03:24:56PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.183 release.
> There are 609 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>

