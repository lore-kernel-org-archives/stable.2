Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B973C5827;
	Fri, 17 Jul 2026 07:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784272306; cv=none; b=ozSl5tBfp6W4HAp5ZXhV5DerAQ0LO+GAW5TUMw1NxskOB0l6trqz1DDBaJ+GyqrrnqLGYrPhYZURXy1kKdGPjk78DA21J/K2R1sElvmC76RP369fLtEnqMvmyQl7ob26t+NbYFUjMMCoNU1myhUZqpDf6zHPvcodiKS0ajJSKKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784272306; c=relaxed/simple;
	bh=zdYEFdYh5Vi5p0/dHgLRHxYa1qzgURg7xqg7EQy4tLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lM0PMWGHpJRVJX/BpGobLGIcF/NwUEvzLf5BHmB5eLtwOjllode5iYaTEcJXF8vUNw7uDT1lHuw4fvTt0jZ++aOzF09Fqvu76dxC/IekScy7aHE9JPK1YEzpqCcH+6cXlEi9AXF7cG888F3FZtDFwFoT82zIazY4+ZRtgMXWrJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=rzx6KkfV; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="rzx6KkfV"
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net [178.82.120.96])
	by mail11.truemail.it (Postfix) with ESMTPA id A269E1FC90;
	Fri, 17 Jul 2026 09:11:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1784272301;
	bh=vMFc0iOErG2mFY0W6+KC9yd275wehQJaR1fY2C6U4PA=; h=From:To:Subject;
	b=rzx6KkfVCcHeiQQmfbGtDb6yoWc96Nbz5Z1YU93uwxeXInl+fiMn1KCLVPau0fO3z
	 i3z5Ex/0XtlI1EDwCUiKUuaiN4f0gYtVqKCdoGJ1lcY5AqG65H4dAXq6apiBFu/7j0
	 7zTxfFhxSAyXLVu/rhGvw1Sg8Ulck1RWsg96ipDIzILL+YZ6nsnuSnl5dkdOqFSdNQ
	 13GR4i5tqCEA3BWcOprnU5g5/oMCb2Hhilbm2CXLH+zqN6id4Yy/V5cl3M3SGxLAqx
	 i7/6A+9gXU755btz01kgGfFLGVrjtagRKqOUsnJmlOGzi9ItKhgeENxQdo1H3f+bzc
	 OE6xIWE8jXbPg==
Date: Fri, 17 Jul 2026 09:11:36 +0200
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
Subject: Re: [PATCH 6.12 000/349] 6.12.96-rc1 review
Message-ID: <20260717071136.GA373902@francesco-nb>
References: <20260716133033.287196923@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716133033.287196923@linuxfoundation.org>

On Thu, Jul 16, 2026 at 03:28:54PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.96 release.
> There are 349 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>
