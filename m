Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5344B66FB;
	Mon, 21 Sep 2026 15:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003496; cv=none; b=aDzlox3VALfoG61cxfUBUNHBafvyME91f81mHCNw3YaB+s6Ky8kMc3qcRAVwXQ1SdwwgfpLo91bI3OmgK7Q3V7k4S8ku4sHfpFZwokyTpAym5PDGQUfhraISovoBFu2KQeGxSjRUiUn9glxgTYJR2CSsk/bM8unSmMs+XPgUUFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003496; c=relaxed/simple;
	bh=JTFzjY4vgzT/AnxSG3N3xG5/wFSXqfIGgLm9CghDl5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaOjl9ppfaVopbcNtomOOyuObkaTiv1yxxlbJ3fMQjESBIzE3HDodjHEaEN8sbpb9z5n1IC87R9CNzbE15HDircqXOTZR81dG8X27EfdCV+MdO5WHrOssM+OTOakC5V31BPS8gx3rgIBOwXmRJK0+b6JoBvc1TLHOZ5CghLzQ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NABJZJK4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NABJZJK4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14F31F000FF;
	Mon, 21 Sep 2026 15:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003494;
	bh=08OdX+yksKIdesxlWgroB9wwvCpB2/2SsKbyedTQ3/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NABJZJK4bv9PgqrfYpMQMiTb/MMY88pxAB2tV/n5QosMYMqfrQNwcqPtfqUSjAIF6
	 qmAX/umojU2KxWrbLikbM+cDb4W/RCiu0plU2MA9CI+SXC/vdfyUvKt5DpRCDVT2Im
	 gTZhAm/LuxCTQgL2SOWtcX2MDUTSbB/XcvXcUJJU+pKIw4mV3aRs2yjXxGhGBjUZ/M
	 1MqS5QKW/7euQM7BwUGRUsGK+kIUxweRjh6wabMuI3Xkr4nP3oFhM+ocd2fbAfpTHJ
	 5yRGrTzJAuGV0W9zo7IOdgGjqjBR/BOBKxC76oIxOu8KsEhNi/8Q3TG8sdRSwLoTvx
	 aKqgRfBPmavOA==
Date: Mon, 21 Sep 2026 17:11:31 +0200
From: krzk@kernel.org
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Tony Luck <tony.luck@intel.com>, 
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org
Subject: Re: [PATCH] EDAC/versalnet: fix memory leak on device registration
 failure
Message-ID: <arFJIWgBN0HXl7WQ@quoll>
References: <20260920055519.3778269-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260920055519.3778269-1-lgs201920130244@gmail.com>


On Sun, 20 Sep 2026 13:55:19 +0800, Guangshuo Li wrote:
> init_one_mc() allocates dev with kzalloc() and registers it with
> device_register(). If device_register() fails, the device has already
> been initialized and holds its initial device reference.
> 
> The current error path eventually frees dev directly with kfree().
> This bypasses the device release path and can leak driver-core
> resources associated with the initialized device. The existing
> versal_edac_release() callback is responsible for freeing dev once the
> device reference reaches zero.
> 
> Call put_device() when device_register() fails so the initialized
> device reference is dropped and versal_edac_release() performs the
> proper cleanup. Return after freeing mci to avoid falling through to
> the direct kfree() path, which remains necessary for failures that
> occur before device_register() is called.
> 
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
> 
> Fixes: d5fe2fec6c40 ("EDAC: Add a driver for the AMD Versal NET DDR controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/edac/versalnet_edac.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
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



