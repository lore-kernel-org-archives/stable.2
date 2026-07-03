Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97D6369999;
	Fri,  3 Jul 2026 07:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064409; cv=none; b=Nd72v63kvciS0qQsYWsntv5JFb/szrUiiGxTXAIpPwBQj7NgxbpFimzlInagAP5+Uzl23g10ggV4v85Ge3LRif7Us81xfI/qv46C1+LhHHRsnKJeo/iRgtwH5fkWtkq3F4chfzmzbuCOVgjZ/FGRB2oAerYlDsjDvi/Oh+fyYIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064409; c=relaxed/simple;
	bh=2VlYoP2s493psFsAxH8QRjFN+ihJaXZpKwq5bvvay5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejMRZfv0PR3Smwfn7UpplR6bhWcB/ZO1E3MQSH6PN/mxE4iWDlTPx/a7dU3EhWpM81odp8xkqgd4P0/6/WhKscSe4/QKUAzPQ70UysX0aQLBIkX+PLCLKaEHNU7NSTnRaGY7nv7NoGy6IYvgTeBu1491aqnsmCEYMGFOmk77kX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=LK09+ZPf; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="LK09+ZPf"
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id E5E221FF57;
	Fri,  3 Jul 2026 09:40:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1783064403;
	bh=/CrzEIcTkCwtRrhNs0ocKnYOZSQHpwoLsyf28Ka23Y8=; h=From:To:Subject;
	b=LK09+ZPfW554U3kLj/bkHyRbBGwS/ouH6iWHh6B46/y/P9+hMN5omDYsxw/FRND8p
	 6RzC+i8D9HERAKSD49puUuhifDQVjrpJ4uVCTmhE9SDbDFTGsueEhWtEBtdi9ioCnF
	 43/UIBcZtqXWK+iI0ZfLYkSPsxR72MneSU4M28P3Qsp4Du6zxJqL2Wz2xJlfKEEBCT
	 MRrZRv3MS8R+/2crb4txRxtetkXbawPCjjTd8F+5fcRYrVmSBh7b989a9C8XPlSxBM
	 sokCofcI05c5w7uXONBcqHpeYy3Cc/0hqdX91UaOs0t5uiiy+J+Y6xxj2u3MqGiaS1
	 RcNHNGvXQVy9g==
Date: Fri, 3 Jul 2026 09:39:59 +0200
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
Subject: Re: [PATCH 6.12 000/204] 6.12.95-rc1 review
Message-ID: <20260703073959.GA305710@francesco-nb>
References: <20260702155118.667618796@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702155118.667618796@linuxfoundation.org>

On Thu, Jul 02, 2026 at 06:17:37PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.95 release.
> There are 204 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>

