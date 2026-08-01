Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6540648988E;
	Sat,  1 Aug 2026 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785599691; cv=none; b=SeX5eyEwuvgoo9wwyRWiXY6Ls6/lxTB/H9WrRMmQeh67IbV5jda9AAMKO8phtdIhMWWJglkul7IV/UBW6HrpCTIkubRAZ+ijzyiig32T83CUJ9f7YuO2bApB7iy1UKbUequ3Km5k2eGq7Z3x804i5Len37YQqUH49mMyW1A0ipI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785599691; c=relaxed/simple;
	bh=NfKQ3C27ZyOXt9VqRC3enedGJ2XGJRoP1zuJttga37I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EY1xeUzTsnG5er6geEqJG3mqA9Uv+XI1yUM1NGalfFf2E4zVldE9KQ2DnAgGZlsTiCO5H9GECNeuV48Z0FpxYyfuZ4eV5onB526OGoNgKil5xYLyOKAVadqV4PFUtdDArr2Gat0v4gDNBYbLktsKq7nvBZt3puzSm3dVNy/hzvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bs+ZHpN4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bs+ZHpN4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E43D1F00AC4;
	Sat,  1 Aug 2026 15:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785599690;
	bh=TbA0K6FaORwLguJmxTI6dO/8Lbfn3XfQz2bYMu5MwZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bs+ZHpN4GrPfwUky3N9Rcqx43ht74mG+AWLewhEaMADWyBwB0b89GRRH1eQ2vL/b/
	 ElQOnvXs3xZnqeao2UzKhA6GZeT1uFQIMfwxVUsGLpnQVZMfh0S5WXWQmdwk+obR19
	 sj3ZHfI7rJOhzeG9Fr1ZdI6R4lMCHB/96n1Q/m6I=
Date: Sat, 1 Aug 2026 17:54:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Diogo Ivo <diogo.ivo@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>,
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	Dan Carpenter <dan.carpenter@linaro.org>, miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com,
	Pascal EBERHARD <pascal.eberhard@se.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] spi: cadence-quadspi: fix probe error path and remove
Message-ID: <2026080123-marshland-curtsy-8a64@gregkh>
References: <20260731-cqspi-pm_runtime-v1-0-ff0bfc9e8e56@bootlin.com>
 <6bcaa81c-d52a-4a4f-9bba-8c61f6890fb3@sirena.org.uk>
 <72162aab-ac18-4089-9a38-ea1b162b2610@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72162aab-ac18-4089-9a38-ea1b162b2610@bootlin.com>

On Sat, Aug 01, 2026 at 01:27:10PM +0200, Diogo Ivo wrote:
> Hi Mark,
> 
> On 8/1/26 1:48 AM, Mark Brown wrote:
> > On Fri, Jul 31, 2026 at 12:53:45PM +0200, Diogo Ivo (Schneider Electric) wrote:
> > > This series fixes two resource leaks in the cadence-quadspi driver's
> > > probe error path and remove callback.
> > 
> > This doesn't apply against current code, please check and resend.
> 
> This series is meant to be applied only on the stable trees, as there
> was a backport there that broke probing in certain scenarios. I should
> have mentioned this more clearly in the cover letter, apologies for the
> noise. If I need to resend explicitly mentioning which stable trees this
> patch should be applied to let me know and I'll happily do it.

Please do, as I'm confused :)
