Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5E54B3364;
	Mon, 21 Sep 2026 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003842; cv=none; b=VckbiUk4lnU4RTID551SJsKU8ydogTu2gBNCKldU0XlZie+79IAnF6L6WMLMR2UekLOi30279zbfm0egasx7EJ59dtKbXRJzl18I7FsLNYq8sfn2KJOEoJWSbyuPMrOkLKRgBPVGbcya4sWbgV9k79Y1m2msFV75xNUOUihCCFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003842; c=relaxed/simple;
	bh=JTFzjY4vgzT/AnxSG3N3xG5/wFSXqfIGgLm9CghDl5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6GFzKbCYHbhF6ev8NQwh4CsrTTmSn0l6SKj9J3UM0mXu0Z8PoXOzTFL7Ps9fOeqiLxDx6uiXOd3byl0x6tvNp6TQgC+x2CGi1NI7eVT4yuTM86EocYoRPR+6g71nW7UNd/nmlaURgW/eDxopRb+M9RxIPqrdp6RN+ZoirceD3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOV1zOe3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOV1zOe3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39D11F000FF;
	Mon, 21 Sep 2026 15:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003841;
	bh=08OdX+yksKIdesxlWgroB9wwvCpB2/2SsKbyedTQ3/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TOV1zOe3OkjEI9ot5xW3UGA1tGpZ3PJDdg+AlWZdMVpOCeq3dCZg2D77BAwrg5jIU
	 cPlmU0FI8pYxCMNNav2AeICCyYmHsUrfi435wnv8y8zx+o6X79zEhTxesUOr+cdJpU
	 iOXgfXOeFVLd/gPmEaZh+Fm1DOJB/xeZpbF+hT2ZA7d4lkPOeUA4ranX3vAPxdDDTg
	 M/ckfSbDOtYkmTihM/wM3nIr5KEvVCAvppBfp/JcmL0XhKDcwPiolYxlZs+wHMwFGx
	 R+xVovDgFgRFSLRvEz0VkxXEpgogtmN/1+DgjpUiJkxdynhmQYMW4CXarZ3ODg5tGt
	 dBRDCWDoM5Ijg==
Date: Mon, 21 Sep 2026 17:17:17 +0200
From: krzk@kernel.org
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: linux-edac@vger.kernel.org, Borislav Petkov <bp@alien8.de>, 
	Tony Luck <tony.luck@intel.com>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/versalnet: fix memory leak on device registration
 failure
Message-ID: <arFKfCLKbfAT2iZC@quoll>
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



