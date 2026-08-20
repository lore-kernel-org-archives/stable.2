Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34E933A711
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787234421; cv=none; b=Kvece1zw1ovKZYxm2SyzrRrfzpS3b7VSt0hdNx88o7ZpuDeE57z1b27K8kU+4UmFFlcGW2fUigZNRHhmkjlYhO+JvpIs369nVps4658J6/yrEDq3kV5asecp04pBuqDXkix8jjMDnNAwGqn2ZjAggUmUt5Hfu4d+XVsu2X5uXLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787234421; c=relaxed/simple;
	bh=US4RrSHsoNdEPSlgRpjd0iAOgLKz0mKWToYCeP0AziI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKwPzymnOizmfIrO81tjmRsgzKnJx8LG0yINmO71yz3ftY/79K+5lrywqHOt8PtdDxp88zvfNJvXGMeMsvFOLrnyjxW2oJAfrQ4xTGU0kYaX67DzCiud7yLP291ZcoPJ2nImsYJOLZJKS0rsOcrvBNjrWwzUlz2+RzdpUBEV2Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ydyLQHje; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ydyLQHje"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A1F1F00A3D;
	Thu, 20 Aug 2026 14:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787234420;
	bh=KIktxc8Vs2PC80I2X5AdHu/Jr/9/LU8USRCgRYjEjJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ydyLQHjeXUTtG5kZvHNi87Z/C9MzL4KSF0oLiCCN+cEuPZPsJRnWRbE3TlmS5p7Ad
	 Uqn4XJX2SQ8+asVpV+5j2rUQ5R5giWeXJ3ZNKw5SJ6jrgU+FX1nYFO6vt3RSFhypl8
	 8lMpjRaMSg9/I2b6u76dqVQd6l4k/Xmzt3lAC7tw=
Date: Thu, 20 Aug 2026 15:46:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Robert Hancock <robert.hancock@calian.com>
Cc: "sashal@kernel.org" <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH 5.10.y 2/6] net: macb: use NAPI for TX completion path
Message-ID: <2026082011-hydrant-magma-549f@gregkh>
References: <2026072142-acorn-watch-76da@gregkh>
 <20260729165749.3661232-1-sashal@kernel.org>
 <20260729165749.3661232-2-sashal@kernel.org>
 <17540efb399007eff553a13009be65fefa170a95.camel@calian.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17540efb399007eff553a13009be65fefa170a95.camel@calian.com>

On Wed, Aug 05, 2026 at 07:18:28PM +0000, Robert Hancock wrote:
> On Wed, 2026-07-29 at 12:57 -0400, Sasha Levin wrote:
> > From: Robert Hancock <robert.hancock@calian.com>
> > 
> > [ Upstream commit 138badbc21a0113ce783270c426210d6451da5d1 ]
> 
> FYI, just seeing this now - it appears this patch has been cherry-
> picked or rebased in some faulty way, as it no longer matches the
> commit description. In its current form, it seems like it would either
> do nothing or possibly cause regressions. Same with the 5.15.y version
> of this patch.

Yeah, something is odd here.  I'll drop this queue from my mbox, and go
drop the 5.15.y patches too, thanks for the review!

greg k-h
