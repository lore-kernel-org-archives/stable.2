Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7D43D9548;
	Wed, 16 Sep 2026 09:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550848; cv=none; b=gGn1JHdbTannjyO5ohfTHNLePGczpn0/93UY0L0kp3bOnwZvowV/BOUhJ1aQ2s6ZkeLlXx5Z+BHFNdXlSJXiypUbViV2CdD2/Wxg6T5CIDSXQegUilYAggE9xDgOXE/Ae0nUOLGOFmEDA6twjTkWzi0B8KAXmV05KsvjQUxj3gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550848; c=relaxed/simple;
	bh=TCIB4NlbD4MluAxp4WvXvgf7kdvfpVRPiKqnOKD2Bsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8YblzCWNhbEE6+FYpEyjFtQh1SvBzq2FfpGAlToiRVGINU4L3PK2qZ7ZebWMiEF9JZNO/DhpAbQEa0GBk4HCtCZRJ9UuB7fZjQEdHKswm0tc/a8VcRuo4eBhD4se6kYxfK2Z+ishwhDL0jvy5F9+wgh7hSJEJQ42uycqPFWydk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxlsKd9D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxlsKd9D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C7F1F000FF;
	Wed, 16 Sep 2026 09:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789550835;
	bh=7L/dBuwC/LCncorqUmBiBPEI/nqSHfIDCw4avwp2hRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KxlsKd9D75q4P1papf9K7j6IA4uhFJRU+ZPwhp4fY2GrrPN8kGDJCA1b6r1E/a431
	 qymTivRi/i9uPPit+DQ2mx1vJCCyHsxJ3o1IPOCfhGbLuw6TWBX1spkhVeqod2bmz6
	 r8c4PnMwuY2U8XPxjQUrModSIbFoxZFgge3ULSp73mvbNEkVwvDtvW22BRm+GO2AV2
	 dgOyobM9UtC0LgRDHRrj0DdYlECOq8b9ckc0V/kA7FEnLi+/Z50Czu4EdmErv/rgSq
	 cvLmEt0iKwKHHCSwtI2xyeQqHDMb1kmu8lbfBoq9DS2CofVmQyymc5OWCalIbSvysU
	 74FiKaniytr3g==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1x6lv6-00000005xhO-2LeK;
	Wed, 16 Sep 2026 11:27:12 +0200
Date: Wed, 16 Sep 2026 11:27:12 +0200
From: Johan Hovold <johan@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Boris Breyillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
	=?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/panfrost: add missing
 pm_runtime_dont_use_autosuspend() calls
Message-ID: <aqpg8KHXwr2lNK9Q@hovoldconsulting.com>
References: <20260916075051.1353-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916075051.1353-1-joshua.crofts1@gmail.com>

On Wed, Sep 16, 2026 at 07:50:51AM +0000, Joshua Crofts wrote:
> panfrost_remove() and panfrost_probe() disable PM runtime on teardown or
> failure but don't call the pm_runtime_dont_use_autosuspend() function,
> causing potential resource leaks.

No, as I've explained repeatedly elsewhere, it does not cause any
resource leaks. [1][2]

The autosuspend setting leaks if you will, but that only matters in the
theoretical corner case of someone rebinding a different driver (which
will soon also taint the kernel).

So don't exaggerate the impact, this is essentially just a cleanup,
which is fine in itself.

> Add the missing function calls.
> 
> Found using Coccinelle.
> 
> Fixes: 5c0c825ae4c6 ("drm/panfrost: Replace DRM driver allocation method with newer one")
> Cc: <stable@vger.kernel.org>

And it does not need to be backported.

> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>

Johan

[1] https://lore.kernel.org/all/aqpd3viN1UoZBkgL@hovoldconsulting.com/
[2] https://lore.kernel.org/linux-iio/aow51Nk-cet9qaUQ@hovoldconsulting.com/
