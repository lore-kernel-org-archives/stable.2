Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086B747607A;
	Mon, 21 Sep 2026 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003242; cv=none; b=aXjl0u4V8pjiPc393ivwLxB8hqE2Gt/BWgfI15uJB3OlnYwBh/kp32DSTX+a5qgskPcfWMlF1COJAqytHExjtWwszht04EYavV72Ric0PNAkXr0n6XQQduPkOvWLxarlqG0elgg8i01Kq4tJQXso3uq1ZH6rhwN0TGpT83C4XT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003242; c=relaxed/simple;
	bh=feog7uodYBs+q4YbR1VpaCL2OMRtRJhnYK2voJL0USE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2RTxb8YRPo9OmdrNfAPXmHsYhj2ctVQObl5ruMc6oFJWZ8E9WYubsyrVGuQhRXgDaWaYbWLgSizIKap4L9543IKg8Wuu8WjsAJVNUuMXj+xgM1KV9JFyj9d9wvyNsXazroCKA06S95JWbXZExgqMzuiLh7j7yVg4w4l2GqKEvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/PKQEwy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/PKQEwy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58001F000FF;
	Mon, 21 Sep 2026 15:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003240;
	bh=C9OuFK8krYG5CFJQY5mJoDN0CmcjBiY8Df4psmo7f7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C/PKQEwySgSwNGafp4Sed39F3rpKkgJQ9XIP0UYxKqxZvrMvYXyt6ySX5tsVuZxtC
	 RSIe4qkmkI/8xo5pUSmj+b00/rzYZG/O/+NjmfTYri9F6GQCday5ZSCBk/dZ++SmHi
	 yDJ5oVf3VsfjfgWRSliRTvrU2goNx1jIs2e+vTPfdHvqAW2uZzlbqr8YyDKiCwp5+K
	 aODTlXJN+FNQIfmh7Wkcm690cvq4z+0SYEXJJD7z36I2Nre/4NAUYriP8EoES8qcu7
	 2DmPWmMMg++gdD1uKvCsAj/LuqEtyNTKRF4EDKjEGvWx7mkbwWtXkUsooLBtCMTbQw
	 6VM9txvXC8xOA==
Date: Mon, 21 Sep 2026 17:07:17 +0200
From: krzk@kernel.org
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Yonglong Wu <yonglong.wu@mediatek.com>, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matthias Brugger <matthias.bgg@gmail.com>, Min Guo <min.guo@mediatek.com>, stable@vger.kernel.org, 
	Bin Liu <b-liu@ti.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] usb: musb: mediatek: fix child device leak
Message-ID: <arFIIXUAYO8OXa_5@quoll>
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



