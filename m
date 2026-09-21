Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48EE49CF36;
	Mon, 21 Sep 2026 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003213; cv=none; b=b9k0pgdXhDemBGHkjaZ1jn7PFx7FH+7qn8KrZ7DsF/UD4DOgFEmc2wkdEAL3IBW97K7d2thzp0AhCeVUUMCaR40lfp9/FwM032w9YB19HWTj+ZCkdLV964bKSfknWoGONxTtIg2+d2PWeCMaNrFgiUGTREbUgevfpSVSqfnDF+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003213; c=relaxed/simple;
	bh=/fCqJ2qTxNm3snRd2x48+oh09EsMTsOzYCwCEmFu7/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkEWOlgm+XCmHgU4XMz7UwOqa9MtzFw25qFkMNe8vX9kU42SdnvuJY2rx6GQp2DSS8xl6aM4OBJT1VBZhc/Ag+10jN3PRSi2BOcQbuBK2X2DjJwtWiRw91qfUu7BkFTzBtpTXUb5J7z2TpyDiKVJ32fRO0aCNbchyoQEtN33jGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjXi4MWU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjXi4MWU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA5F1F008A7;
	Mon, 21 Sep 2026 15:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003205;
	bh=Pa7Ft/ijJMnGxUHvP/pkiFeMmDY5E8M9itOTKRJ8E0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YjXi4MWUska829Ripnk/wWccXf7whhoR+eq2q+djP79wgcJba+rnsOCOQPOx9fOXs
	 cRTsbUhcx++BzmXSfae1jFqx3Ce9FGKiaOa6+6yZ6EZ4+dKF8pkkS23cTowheQpeld
	 66qoS1RWGzcfH/8xg+mvPplB6HyloRd0nDwjV4FEtX53R8L1GmEc4E0kQ3uMCKLYYO
	 oXv3ltRdzIPuNQZr5hXNrbxKWzce4hATU98WOq84J6Yk21CA1uotMb84mi+W7PrAV/
	 CC3zkvKkt1T/eSop835tSWwCqhrLDoDGTZQ67IaDGudWeA3aKQQzdy/3W0Dt85jUCe
	 p9YCc41A84n9A==
Date: Mon, 21 Sep 2026 17:06:42 +0200
From: krzk@kernel.org
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, stable@vger.kernel.org, Simona Vetter <simona@ffwll.ch>, 
	Chris Wilson <chris@chris-wilson.co.uk>, linux-kernel@vger.kernel.org, 
	Tvrtko Ursulin <tursulin@ursulin.net>, intel-gfx@lists.freedesktop.org, 
	Matthew Auld <matthew.auld@intel.com>
Subject: Re: [PATCH] drm/i915: fix mock ring memory leak on context
 allocation failure
Message-ID: <arFH__nd1-T-6kft@quoll>
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



