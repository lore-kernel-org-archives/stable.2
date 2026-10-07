Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADCB4AC146;
	Wed,  7 Oct 2026 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791382367; cv=none; b=ErR2ibGpQ6ESi6REA36qQNauVv8XJKrNBLzAZQkVtjvl7iv0PytbR1nliwb0OsnpDRSlFBpnOyWTxWoNGeuXaIUXkblEewReQx2/3fqey0pERlDSxuF/gjH4wMR/TW1E5mRNVDyLY+MmRIh9sHm/KDd+K9wM3SBtqMA0uBbC+uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791382367; c=relaxed/simple;
	bh=b81N1V48UC8vZgtuLNAuK2/sh/SykjrS3Mb3ZQkYWFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7M8ikQkaEurl0Q+G3Gjcbv2mOVReZlElpz3PNDwfjzp+Qcekvkyt25pmPqfpdJevnfvtr8SmWpFfBygtAitaB43osGgckxaRafr86QW4fXUuVofyzjxWEu0HwBzWKHkFnPMg8AY7VNcJyHvctej8X3eIMrKFdO0Er7U9Ltx1qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5QdRUqI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5QdRUqI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DC51F0089B;
	Wed,  7 Oct 2026 14:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791382359;
	bh=aMZAkybkZ2uV80HBjooHNeYh3q4QfwasfTPzlTKYwdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W5QdRUqIFobkM70wCS3M1Fc2LPoQxCCvZDu5bsUHpnaG7ZKYlmBIrlZrwkw/wGTOb
	 rdxErDSluqqvnMU860k1M278FM3r0y2uMFMfWM+EgiLTzkwAfZ8mGtQIU7bu0qtz7u
	 VTqOXdfZm18Dn6+AyO2EQreRUodj+7fYCQDOgPSpoiC+TJNrlCcBw07v8A6Fi8+Rpt
	 lXuPG6y+9MV1vDhWiRajxSCK6kKMYk8HV/i+OHayhAUez/rzu5aA4ztm0ZNHOw0OhL
	 j6XDntoOh5WZSjClOfX8bkksT3mLOI5TZyA9W4XKT120VTYMmrwkMkDzyDGZ5T419B
	 7umPzZq1mhS4Q==
Date: Wed, 7 Oct 2026 16:12:35 +0200
From: Vinod Koul <vkoul@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: perex@perex.cz, tiwai@suse.com, pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 3/4] ALSA: compress: add missing OPEN-state gate to
 SET_METADATA
Message-ID: <asZTUxqHo_7-VZ43@parshuram>
References: <20261007132509.18237-1-peter.ujfalusi@linux.intel.com>
 <20261007132509.18237-4-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007132509.18237-4-peter.ujfalusi@linux.intel.com>

On 07-10-26, 16:25, Peter Ujfalusi wrote:
> snd_compr_set_metadata() calls stream->ops->set_metadata() straight
> after copy_from_user(), without ever checking runtime->state, even
> though the function's own comment says a parameter change should only
> be allowed once the stream has left the OPEN state. Every other
> metadata/param entry point in this file (SET_PARAMS, WRITE, ...)
> enforces that gate.
> 
> A codec driver's set_metadata callback can assume SET_PARAMS has
> already run and initialised its private state; calling it while the
> stream is still OPEN can operate on that uninitialised state.
> 
> Add the OPEN-state check the existing comment already documents.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
