Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A3B22097;
	Wed, 17 Jun 2026 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781701388; cv=none; b=LxFChQ+hwa2haCDw/w8yQR5KeAK5LB+hNEKlhPhpZkOJWjIOI3vOFzUggz1xqBj/1FS9+qeVYVvl0BdP5fdphA3iXq/Dvam7gt/epG5XcxWUr6EM3M8bkaX1K8R6quKjnQM9wMbasHyWO0Uvb7wHPRnkhbWlEi55c/5H2oYeheo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781701388; c=relaxed/simple;
	bh=0lsMmjAs/2Q8EOI4mjIOEbG4E5I7eGD/uwFJ5kFhM9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tt+NK+jyGAW2RzKA7rwRvtTeiQc05wTul3zJd4TpKDBZWiSNpgE15wXS7+9Jo7ZYEo1QUDrWsSZPk9OstqztJ2uA8LrlSdT72tNEf7Qs7QGKkLX3nMRdChpLxCodLs9DGDnMRVCd89WZ95yaKY9oRd8C8gV1mDq2hbWTf9ZqsiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=infWk4Ip; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="infWk4Ip"
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net [178.82.120.96])
	by mail11.truemail.it (Postfix) with ESMTPA id 19EA41FBE7;
	Wed, 17 Jun 2026 15:02:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1781701375;
	bh=MMlivkAnm4TvS0mxxeHvMExihjVoruMbjvrI3cufwXM=; h=From:To:Subject;
	b=infWk4IpQg1Axf+9IlTLoOtTPEb8a3Jx3Om/znf20ojBkU5/OXsIM/gpXvhn1vl1S
	 dALH8falK/Xop2fiPPFiheX2Qny42cfGYEnC2kyWljkFyo0VDXsBlH661BdDlsVHq0
	 YW3LQdXQFPlNtv+NN9SgpznR8QbvM9mFf13CVZdu15Bs1EewxNmsB9ChYLjO8XoBf7
	 e/vcM+6iddSZedAQGoxwhjzeU/DiOTn/2rfjoW/+Jfoyy5O+BB/rMBpjiwk8ZqyMAZ
	 sQSb05dJbj4ry3Evhpd96UWjQR7JuNaU8bpPJ+OE9Ne63SAio7QugF51ErM7Q0AQio
	 D5NxAI358HZZQ==
Date: Wed, 17 Jun 2026 15:02:50 +0200
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
Subject: Re: [PATCH 6.1 000/522] 6.1.176-rc1 review
Message-ID: <20260617130250.GA90253@francesco-nb>
References: <20260616145125.307082728@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>

On Tue, Jun 16, 2026 at 08:22:27PM +0530, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.176 release.
> There are 522 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>

