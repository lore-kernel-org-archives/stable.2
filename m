Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DF34AD4B7;
	Mon, 21 Sep 2026 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003377; cv=none; b=kqgNU8OsRcxhUkzqclhjMb6LiXG+/SI4DMNa0upGy5UW0qn6/WFLxE+PCc/Pi2YdPU0aa5GIQYZxLfnbQYUySlJBsiidk1oFKtkvt83gX10uhGNaMksZq1USdOYy16dusRlYRH0BCsd4223olafWvIcPdkxrCsvigZtGC+pv2oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003377; c=relaxed/simple;
	bh=/fCqJ2qTxNm3snRd2x48+oh09EsMTsOzYCwCEmFu7/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fp/B8UfVK2rYaZgCYFEzQcs0sqXRpU5ogTAC0M6Mb/qqDCp/F+W1K3M9N9HFbiRUXWqnBVM4j3rLFtcmkWlj+mbuVpmxNqrBWrbqLO47WwdXz9s7XU/iM6U6AqGnjchcyTKDts1s1yfymOBJpdgBPu5kasbMFXa4EJ3K36ksPaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a37yIKpR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a37yIKpR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B120E1F000FF;
	Mon, 21 Sep 2026 15:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003375;
	bh=Pa7Ft/ijJMnGxUHvP/pkiFeMmDY5E8M9itOTKRJ8E0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a37yIKpR7CmkgDvDOsMGCXKWaNcNsStWl6fHm32Bkxy2yk9jYr+PMY5/xrmyUplbq
	 oJi7fzUcqK7fwPQNuR7INp2S4DAQMogLZEAGYG2G0nIsaBHLyh0hQTsKIBqYH4y9e2
	 NiEC53Fw/gEJuaPz1dH9NjbXatVo0vMpWDnWYu/LQM/ogXGTJdGnXEGJxLxfYGmLy9
	 vG3D7eKr+u2KYDr0dj1QaFLrY2qLH3vEdi/zGXA1aIc9sibhgdKyltS3FANi3Rf8s0
	 mWPnKly3hK7QVeNUm0Yat1qCFtJuW8ZjBai4YLTG+r1kiobG6ZTGifJsi0t9NIHapg
	 lBUG6/S0xvAXg==
Date: Mon, 21 Sep 2026 17:09:32 +0200
From: krzk@kernel.org
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, 
	Simona Vetter <simona@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Jani Nikula <jani.nikula@linux.intel.com>, Chris Wilson <chris@chris-wilson.co.uk>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Matthew Auld <matthew.auld@intel.com>
Subject: Re: [PATCH] drm/i915: fix mock ring memory leak on context
 allocation failure
Message-ID: <arFIqOl-H6DYQ2k_@quoll>
References: <20260919171710.3699710-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919171710.3699710-1-lgs201920130244@gmail.com>


On Sun, 20 Sep 2026 01:17:10 +0800, Guangshuo Li wrote:
> mock_context_alloc() creates ce->ring before allocating and pinning the
> context timeline. mock_ring() initializes the ring reference count and
> returns the initial reference to the context.
> 
> If intel_timeline_create() fails, mock_context_alloc() returns without
> dropping the ring reference. The same leak occurs when
> mock_timeline_pin() fails after the timeline has been created. Since
> context allocation did not complete, CONTEXT_ALLOC_BIT is not set and
> the later context teardown does not release the ring.
> 
> Drop the initial ring reference with kref_put() on both failure paths.
> When the reference count reaches zero, intel_ring_free() releases the
> ring VMA and frees the ring allocation. Clear ce->ring after dropping
> the reference to avoid retaining a stale pointer.
> 
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
> 
> Fixes: 75d0a7f31eec ("drm/i915: Lift timeline into intel_context")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/gpu/drm/i915/gt/mock_engine.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 


You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem, how to document usage of LLM and how what you should not
do if this was posted in a good faith.

Best regards,
Krzysztof



