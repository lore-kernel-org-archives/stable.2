Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FF34ADD93;
	Mon, 21 Sep 2026 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003042; cv=none; b=Z/R0dEfcw2mxdjls2yOxgvfP6/kULxSoXLR66Cd2VupUdTYKb+yfVKscyRk6sSRWdsK3jdu43Nyfv67TPNBkg7+4n7JAhjQXjvRB2oYSkqJI6SodkxNNg1sxPjfSywRP/QLCikBmdzo53y9UcScVSXSveVUtvDWW89PpuTwmwKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003042; c=relaxed/simple;
	bh=feog7uodYBs+q4YbR1VpaCL2OMRtRJhnYK2voJL0USE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POfU3FVRDtnr0DfTxRPXP7uBg1rd0DuD+h9hg7sHWiDUs2L522ofaYbY036CEHlg9XkGQ7RP9uFlGAtH4uZINPAfAP54h3NKnnYVJDT6maZiz9zyFpzcCrWGfeNR1dBb5lZHOL01Nqq5DLZoFR7PP3KJrScgsHQfGZ5GSqfUUGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKPtgqXM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKPtgqXM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F431F000FF;
	Mon, 21 Sep 2026 15:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003036;
	bh=C9OuFK8krYG5CFJQY5mJoDN0CmcjBiY8Df4psmo7f7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HKPtgqXM8YdJsCLmf/4XWk866/vpIokpgYm5FBBZMXJiBdXigdiDCTg9BG39/L/vp
	 gNFovqk3NNKb2LSzzO6almiWMgLvY+0DPM5nY96vjw2kuVmK1C4aPqNmNqAc7JaeR3
	 BmSyW8ls6DDWGEdAi5GhWQ0h/pmTeVKMy5fWpxX/Oqxb1+UpK678Eqwjj0pATZpyl6
	 gJjrRboSyK6QdP4VLnOaeCuhNRpa0/zQ3M96RAeg56rvyP/U1shNwLfsYp4ZPd0w1i
	 b2a3P6iJBnYD/ggePc0FuzwuO/1/wYbvhM6k5qDRMoi7GbqjsxpDFN4C98xyjJAyoz
	 Nlnvjed8Q1QqA==
Date: Mon, 21 Sep 2026 17:03:53 +0200
From: krzk@kernel.org
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Bin Liu <b-liu@ti.com>, linux-usb@vger.kernel.org, 
	Yonglong Wu <yonglong.wu@mediatek.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, Min Guo <min.guo@mediatek.com>, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, stable@vger.kernel.org, 
	Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] usb: musb: mediatek: fix child device leak
Message-ID: <arFHWJb9igZQPkeZ@quoll>
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



