Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5973A9856;
	Wed, 24 Jun 2026 11:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782302333; cv=none; b=NeN6lJcMj7WLrwoopltHWR+Db9ccywLZRAtThH6gw7NoJnJQISflINYW4VVIgcH6ViwoV+j7tQCyvyKdnDi1eeOJjI2jnAbbpcyHNndqqEfrWK/xtBVl3J2GvRyd7uYGyaZQnjrHfyr/AqWHh+BUY+TeGtioG6w7gIWXxsIRZe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782302333; c=relaxed/simple;
	bh=Afjq53kjtlJtWaM/iynRMo2B4fa28T0aOwWngmX1NHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjImPJBzYB2lwQEmNq29bdjF7tqWTvwyjN+invQ/eabMwKC2gfH9zavtC6o5cmb8VbG0xmijY4loEKDuPstUkSWmjTC9mzkfgQNHlGXIzZm2cqEdCa6saaPbSvVFBRx/SZOYox570fc1pD1WHN22UZyiMBE8DurMCnZUeUIax98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OVkmIq0O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OVkmIq0O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878791F000E9;
	Wed, 24 Jun 2026 11:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782302332;
	bh=FgVZL5yjF1lvBvWnuYIQDHGkjIANCmjkiCOImFrhE0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OVkmIq0OgK6ozwJCfT96eLni0mKCGIOEblshJgP+XC8zElVQukV9PL5Zcs8jmJu7H
	 RdkUPdtbaGyeJ7zBcpjJgdp+JuCXxAR5qR+keD/JN1D4Id1jimMRVIPGyDMDMbRwcC
	 thmOVSiHyW/aYwTUw42x1b7jk+MuJmQUJmBj4fEw=
Date: Wed, 24 Jun 2026 12:57:41 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>, stable@vger.kernel.org,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Jakub Kicinski <kuba@kernel.org>, Patrick McHardy <kaber@trash.net>,
	netfilter-devel@vger.kernel, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH 5.10] netfilter: nf_log: validate MAC header was set
 before dumping it
Message-ID: <2026062417-icky-dissuade-7379@gregkh>
References: <20260624140117.19799-1-alexevgmart@gmail.com>
 <ajvEDFOlP7Bqb-3j@chamomile>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajvEDFOlP7Bqb-3j@chamomile>

On Wed, Jun 24, 2026 at 01:48:28PM +0200, Pablo Neira Ayuso wrote:
> Hi,
> 
> Thanks but why only 5.10?

It's already in the following releases:
	5.15.210 6.1.176 6.6.143 6.12.94 6.18.36 7.0.13 7.1

so 5.10.y seems like the only one missing it at the moment.

thanks,

greg k-h
