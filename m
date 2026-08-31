Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B35945FFB0;
	Mon, 31 Aug 2026 18:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200161; cv=none; b=pom1IOlMR4yQD8ZS/oXqR2jYg6J+KqnysvRY9CNieC2cXRBdVJHQ+pM6VKkPm0TIWdOhMFHxpgRoR1g4lR7TOGKgnOPw/MUVzCScyXmlOJ064sXTamMs2uHMveP1rC61MpJaB8qY9UyOxJqkpHh4R9DsKihu5ii8MtcwW6ZyU70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200161; c=relaxed/simple;
	bh=6ehLjiWbn9QAPPuVQZvIPbWphJSz5JnpQn8Ko+ndaKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbtPj/Tg2zPmFZp3AUN0siczdtWtPauq/aM+y2tQTsNULrRFGg9UaLzNGG8t7ypbgY+gzz7VTKeQIvXMH9wP/BB/7jzKlZ22FO6I36Bmu6v3X45fz6YmG023JgbUwRWceB0deCyP2Wypi9BA7N7+gXK2lAXNyZcFfF8Nw7fcprU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=ZT0YSSvc; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="ZT0YSSvc"
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 876FA21E5D;
	Mon, 31 Aug 2026 20:15:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1788200157;
	bh=CjBQBtgXdZMeKJGXXRCl/ut1ypHvjslBrnTtfGTjdH0=; h=From:To:Subject;
	b=ZT0YSSvcFKA6jJRPPSxlLDQ+i55NP30E9chmIOPTGmLphSXWi8yWxAqsSevpArRox
	 8ax5s2SabApvoGls8QMMS4jRQhBPwiY/MbyRcG0De7bRWO030yy0Lf2GKfdffx1Hmi
	 yBSPVE2kXey5eD7IK7ulvjRT9pVM2vJUEnDPwAEiQQeWGO6ZpVD3AmlIIdyK0RT6vn
	 f6HZiWf1CKx314aO4IcTYPHc5K4lyEKfK/2g+1CLmxtUCaKC2ZBLEJgVGfukbuvQ8m
	 zrDmb9NU1i81tyFE6Zp1XB0CGGpJpBRflcARpFCjMvUCiX+P7ul8K/SbfB9IBa7CXw
	 8sIaRZF/38tWA==
Date: Mon, 31 Aug 2026 20:15:54 +0200
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
Subject: Re: [PATCH 6.1 00/92] 6.1.187-rc1 review
Message-ID: <20260831181554.GB124452@francesco-nb>
References: <20260831133359.482388899@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831133359.482388899@linuxfoundation.org>

On Mon, Aug 31, 2026 at 03:33:58PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.187 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>

