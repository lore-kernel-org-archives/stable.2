Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCE92931F7
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 04:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790742882; cv=none; b=Wea4NPtYCjO6xbs1lDqfQ9IUNpem7quVX6i4ySd6kiXkGi2GCnmliqL6fHPWCdeI3O/A8TXhoMU+hGgcvfmQbJvNEld2fKHp4OJEAahpAobjrbuOt9exoSsLoXRnwzPAZSNj70HbBX0k+0AYC1UVSitQ64QsQZ1WN7nqTToAbek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790742882; c=relaxed/simple;
	bh=9aYrkKUWOrXOdWIHgBaiAAqnSKLIQhiASnP31di3Wns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apm1865WARFRameeQ9wAC94W1d6p+JbZ/d3lvgZZX9ymeCSTvP8OmNHu/1TVHLd/K4rt9VWe+SFR95mS+arZ+oHgV54dyYmtdqNmWfqSP7yVfFh2P8oPbq0+bv6/ZEruJMM8ZiOLad5aznDZR4J7taSq9BsaL3WQ2uhq/D4qYjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=TL1Q1npF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jG4+0BXp; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="TL1Q1npF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jG4+0BXp"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 6F2541D00746;
	Wed, 30 Sep 2026 00:34:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 30 Sep 2026 00:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790742879; x=1790829279; bh=JLulzcVa/W
	K6lmBd/FfUg7TWeRoWtWwD7NeYkNuqITo=; b=TL1Q1npFQpS29dh59UKvQPWA5c
	7toirsT32c6zvHFJOotOYnsnlbxZ8SH35GHj6q7u7oOiARPG2xT7do1/PAs6OwJq
	8VgQSmbj7uLtn0GwQDUw0Yrji/Cs4ZMjp6hK5tebk/CX/DUKdaY0YyvRQzQb3VIh
	7oBZ5PzUj4iWMbH7Y6e2rP8MspswmXDVJNtAGOaTmS68qgRX2EdTtRjGFnogeCK7
	n5WoL1bsdDAkql4OE3r93nr52VE8ibuf2pyFd8dxO/zcbIyH0QjPVZpjUCNHc2UA
	UbvCSLHiCjUlQYygpUY254RuaSrhYfuyvLS2en6ZjBgoIppqvop/mKnecO8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790742879; x=1790829279; bh=JLulzcVa/WK6lmBd/FfUg7TWeRoWtWwD7Ne
	YkNuqITo=; b=jG4+0BXpqcSyIpYrv4WZUp5o2IVs+IRdoEb4hBUU7C9FnNLZ5fo
	h/zJzN0faUG1oXZvJyIieb7T24+5SrjwPgLCrcsgYc8ZewWSeRgXYWv8aLY+dvoI
	01tp4ZTfaXe1HcR4pHUbdM03JLqyAKHNbwxmom6q5iGj9A53x8SO8PsNHnkxFPm/
	XnjNsVfdISEFruMgyrWzXUQWtqUxMeBssprWYrOXh+zrZHED+XulObVJ6TCtjtqw
	jRMyoX8JFuA8Aj5ERhu21HVsxkJFOvgM+hlF8CHQ81EC1xGrP2gGwRV4tCv4h756
	c6BrMEPYop7OLbH+2hap/4wa/Ek2Eh/4mgw==
X-ME-Sender: <xms:X5G8at2vVWG0hWZ7u0sJMfHcFhKkL8JQNlkiYbI_FPYi9jZSxnIY1w>
    <xme:X5G8asR_qvUi_Wp41yuYUVdKm4JPxAmHnoBGFXn8NHeed5fbcDvbZhY1nFpKp-67W
    bfENWSiAWeG5C55czZ5Ozmix6FD9WXsetXypVgm1bwC3sJb>
X-ME-Received: <xmr:X5G8apdAjRJTrYvTV_NORpFl2scibo32ls5MeqF3fMBbJn98B8SrYkrB-fibB7f86t4BpTVUoZhyYTVFW02f45IqQ7s8qs0JglUKPl8F7dQ>
X-ME-Proxy-Cause: dmFkZTGyp7rMHAfy3nL9e+uKUZLdCwgUHsCXRJLD0F0aH0gNyeudAP0xMdiGovC7uOhe+y
    i3Ge4pxgNEr6Gdud5e/A0PDXJW1DUthuWREIW6XMRy2c87sLTIckIn2bNNXsCkzkMHvbzu
    82EfNizvNyL7A+ss4YEb+e727GzCFxbwaU2BBcz+ddPPwknD/KSCKXGTGKr0U9qEg6SjZ6
    3xTxhBV5SLRjh7m5Ei4HFpWJVi8kxQDBK0K8gjuoHJ7Z16TB/0Ugc1GRxz/FstVmW5W5s/
    pgzwQ3hR3EnXyKIjBYer5ZYraajkPYrDJgXcu+MLMh0bSTay3FszD+xQFFcgVUH6zkafJD
    ZiJteOStJx5fxsNV3IjgM7m36uzw570gH3zUu18fDAoSK3eOs0KdTMuqPwKi1zlf59vxLj
    YpU+SrBV5lQZUlQqZ17ftHsmi42ABs6+7KvfRq/1fDDBmaW5JpwY2ldGjEhbRqQcn35xzO
    k3IkOnBChVgFreBOyc+7bo9vf7YUtX9BZVU0Ns1EAUTQ6LR91dqyWj/CUPzpHfphjqDloZ
    90vg4I2IikjshuZETCUBHeycI7uNRZCi/ZCjl7zp5W59ilCWPW0VGhBndxEEfH6HNjP/Z4
    P/6muGYG1zzLGQntbo6qCmNPmrGGUd/poHC2/TO3OUhHsDAVwuz+0c9/cHMg
X-ME-Proxy: <xmx:X5G8alew2K1sbyp9RjU3xCoJeazZJUAK7aYKepITYgGVgqi0PD4XAw>
    <xmx:X5G8ar2CM62MD3eBoQFg_YfgLhDPPf-axHVGgE1OvSCRmKakeiFAyg>
    <xmx:X5G8al9LhWls4_5To87UwxU0yUOROSCak9zuH99G8b63A1owzz_OWw>
    <xmx:X5G8ao6M11zSO5NXeHunUfc252fUG372IIFpUcvcGGLTMqqKD7BzYQ>
    <xmx:X5G8asmci6_p0K0Co1f1yQPP4OvxlGdmh0wMEAUW4HblTt9x_QdmTRti>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 00:34:38 -0400 (EDT)
Date: Wed, 30 Sep 2026 06:34:35 +0200
From: Greg KH <greg@kroah.com>
To: SJ Park <sj@kernel.org>
Cc: stable@vger.kernel.org, damon@lists.linux.dev,
	Liew Rui Yan <aethernet65535@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.18.y 1/2] mm/damon/core: allow esz to be set to zero
Message-ID: <2026093025-cadet-late-bf00@gregkh>
References: <20260929174456.9251-1-sj@kernel.org>
 <20260929191319.10187-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929191319.10187-1-sj@kernel.org>

On Tue, Sep 29, 2026 at 12:13:19PM -0700, SJ Park wrote:
> Hello stable team,
> 
> 
> Please don't apply this patch.
> 
> On Tue, 29 Sep 2026 10:44:55 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > From: Liew Rui Yan <aethernet65535@gmail.com>
> > 
> > When the temporal quota goal tuner determines that the goal has been
> > achieved (score >= 10000), it sets esz_bp to zero so that the esz becomes
> > zero.  However, damos_set_effective_quota() clamps the esz to
> > min_region_sz when quota->ms is set.
> > 
> > This is a minor issue, the main problem is that it doesn't match the
> > description in the documentation, which state that if the goal has already
> > been [over-]achieved, the quota will be set to zero.
> > 
> > Fix this by set quota (esz) as minimum as possible.
> > 
> > Link: https://lore.kernel.org/20260908135413.97570-1-sj@kernel.org
> > Fixes: 8bbde987c2b8 ("mm/damon/core: disallow time-quota setting zero esz")
> 
> The problem happens only when there is temporal tuner.  Temporal tuner is a
> feature that introduced in 7.1.  Hence <7.1 stable kernels don't have the
> temporal tuner, and this patch shouldn't be applied.

SHould we skip patch 2/2 here too?
