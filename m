Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C33499F17;
	Mon, 21 Sep 2026 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003542; cv=none; b=nu5jNmdDW07UkVkJ3GZRd5SlSaznL4oHzS4FnQioGQlN7Ag6eftA6h2hX5e1JVJvM/E7Vdp0CZbjyU2SgeOhZ3r81GO3QkzL6Sfr0op8jtIGBdVVCq32ikRsvX932K06BXw2uLr3w4LPtC0ERNu/LoU5EbkCqzxssN9HdwryyCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003542; c=relaxed/simple;
	bh=feog7uodYBs+q4YbR1VpaCL2OMRtRJhnYK2voJL0USE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDvp5qslm3mkDek3AyATvCEbCMuAPwbEHvoHQVyDc0PpSCkc6l9Mh1DQve98UMYnFljf/oKDCbG90zBmeq1LByvyIcRJfxtKqPPcF4/ykabsMsnF6/rCHLdcl7LAQj8tp7JtyyAt4Pylc26HtZOf27lcvT3lttuvVxIyUsoTvNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ll1CjiAP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ll1CjiAP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7491F000FF;
	Mon, 21 Sep 2026 15:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003538;
	bh=C9OuFK8krYG5CFJQY5mJoDN0CmcjBiY8Df4psmo7f7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ll1CjiAP/Ipjm1dHbz/UzwNVf9Su2P2qOIF1JmfRmgsGSU25vaCQ2xhjcQ1JLOaz4
	 EfWNN+ckuH8zevwEV0XQBK8ptDUjLCv1HjxSFkKj5eeUQmVDJlcrD8ayhqK3wOEBSK
	 3cVnaTQYVPioq0KH1+A2XfU2ddu58foJDAKEHR/9jP0tolYzATNsIURq3kcnkjU9cU
	 lKJYn7IToJuUKRUUX8u/zhpe+XdEabg6RFg+Wmb7azT7uw0H0Rr0NxFzltQXI9wdhZ
	 YAAp7ozwP56WEdbxFryz4ovhOso3trE8rzp93innvh+2VQaqdZodZbHALaKXJIHVaW
	 /2nWX6PpbDydA==
Date: Mon, 21 Sep 2026 17:12:15 +0200
From: krzk@kernel.org
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Min Guo <min.guo@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Yonglong Wu <yonglong.wu@mediatek.com>, stable@vger.kernel.org, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-arm-kernel@lists.infradead.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mediatek@lists.infradead.org, Bin Liu <b-liu@ti.com>
Subject: Re: [PATCH] usb: musb: mediatek: fix child device leak
Message-ID: <arFJTmMczwQaRL7B@quoll>
References: <20260921085119.308981-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921085119.308981-1-lgs201920130244@gmail.com>


On Mon, 21 Sep 2026 16:51:19 +0800, Guangshuo Li wrote:
> mtk_musb_probe() populates child platform devices using
> of_platform_populate(), but neither the probe error paths nor the
> driver remove path depopulate them.
> 
> If any initialization step after of_platform_populate() fails, the
> probe returns without unregistering the populated child devices.
> Likewise, the children remain registered when the driver is later
> unbound.
> 
> Use devm_of_platform_populate() so the populated child devices are
> automatically depopulated when probe fails or the driver is unbound.
> 
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
> 
> Fixes: 0990366bab3c ("usb: musb: Add support for MediaTek musb controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/usb/musb/mediatek.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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



