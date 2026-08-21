Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097FA48A2DF;
	Fri, 21 Aug 2026 12:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787314431; cv=none; b=f+dZkaCe02gElgAI30RlNa/hCF8GceG5kbOSD61goGQw4uF59sOrh25/YvKmg0RkuE47pC7EeNaLL5MR3vwL4D0ng/E/n1/cAIhIbrO3Jl0eJQaxzYPeFHxfZ9SlqNahbRlA6DRbnblb9rZNx33T7p+Tj2H8hhJesN1k8b/ICP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787314431; c=relaxed/simple;
	bh=xMx+mnFh4VDQzZTsp2dZLjrem5agd106Eo2PFvu3LWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElFyvnxSejpeuo41oy8oTSPNNdHWTIJTGplHqfkocHMc3cvnM1VG3DwRuLHq2ZX7ayKUpQYdU3BuTTvHw1L+CsRx2kGYUKQSOpa8leFy71a94vVIYQ9EFYBKAdPNhud1RhCx4jH2B7lnkWzFGbPXcZn0Np5FU3WSSmWQqdnH2qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=e+gg7FXi; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="e+gg7FXi"
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id ACF261F81F;
	Fri, 21 Aug 2026 14:13:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1787314423;
	bh=QGJp6tYt47RyYxk8VIlfP4P2jztZeFgnTQ7BH7/4Qio=; h=From:To:Subject;
	b=e+gg7FXiqfoDiIIp3EBjdvklWPCnXBneVYBDDZ5XwncpAGbfza9vhmmUMvY2VDkiP
	 22Ev+HqzeA7z3bgbNhl0D0eywW3/UNOCKHm4mmJ8WBArUnMMj0LCOCe6VRFAZRtNC/
	 HhOyoq1qVIQFjtgmUH2RugN1E16mr844k5avQJCEMSdn97805Etx8f3Eg7rsR7AYbM
	 7GwYjhq+JTYasVgGUUl/pfUWHXdrSxvwr6CCjw/7KZuX4gAvDMZ0p/9cTnEjaU59Bl
	 9/gxI5D/LNe8cR8diMGZ0I38297+uQTBiCaPAXevs7ARrafN1usayJ95/3Bb1PNVAD
	 Cg3RL4kpDKvVA==
Date: Fri, 21 Aug 2026 14:13:41 +0200
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
Subject: Re: [PATCH 6.6 000/166] 6.6.153-rc1 review
Message-ID: <20260821121341.GB69762@francesco-nb>
References: <20260820145211.194104353@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820145211.194104353@linuxfoundation.org>

On Thu, Aug 20, 2026 at 04:54:19PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.153 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>
