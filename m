Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1D5492E56;
	Mon, 21 Sep 2026 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003309; cv=none; b=lJtzaOcsS8j15RdmgLX+8dle58Mo7/zFkTIALHfcuvbVFxW+TKtATK4OPYxkjmK2pQOJMYKJC5Rg1qcIpPjg6m4V3mlO8k+h3/vCu+jw0tqbtfm0ygWiSVa2vczSsnjBmHyrzuV6sXjlvHj/TCo6ZjA/l0pPzBASmGDG+0nHNbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003309; c=relaxed/simple;
	bh=jSVQo5DDclGhv2d/2izRZByPafPsF9Fn20U+7ZJLgpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEvApqG+ZwF+2DRGye79iQwI8/GxDwD3R7x91LItWLeBqOjMLQ+Tryf1jdU+6EOk1HEsVuKPZXqLJdyASSAzUUueseX1ZF1ZmZqOVYHtRZ3uvlRY0ZISot0pu9sjjgyOagSE5k7IwBvJ7cPwhS/VQAdevMppxIOYnMmF/ssFH1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxM/za30; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxM/za30"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571691F000FF;
	Mon, 21 Sep 2026 15:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003308;
	bh=+We2JHXqjpmgc9MfUSu76xwsivNV11yVUPFPYqsRgIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VxM/za30iBmA2gyhTw21dpk7kX3LGDWfOwHTrgyqj8V7JlzQR2gzLLi9dutB6e84C
	 2M/qfZkiqxW2q+HpKRGVTXVoU1IKxU+tWlqfGXI0qWlqdSdybySEQutN5WWRNyg/eh
	 RSSPtVU5sMsr/kk4StnJQ2+918LNXe9MOHwUm9zsofyfVjAUDjICvNmzeli7hvxRm4
	 bjKpfBEAxZ7LmYrKBzC1ikywlyBMPCEd34tKdDSDSes5XIMk4d3qD4ltlD6A1oSRcc
	 5b4yjPLIVXlhmtHVnthgy4+2z9Nobi8MGoaQiCt5SrbXSZEZuPMqs5W+XCXNeQB4XF
	 uh7Ygza9oJRfQ==
Date: Mon, 21 Sep 2026 17:08:24 +0200
From: krzk@kernel.org
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: stable@vger.kernel.org, linux-media@vger.kernel.org, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Antti Palosaari <crope@iki.fi>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: rtl28xxu: fix SDR platform device leak
Message-ID: <arFIZ1e3P2KOzdh2@quoll>
References: <20260921081542.210151-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921081542.210151-1-lgs201920130244@gmail.com>


On Mon, 21 Sep 2026 16:15:42 +0800, Guangshuo Li wrote:
> rtl2832u_tuner_attach() registers an rtl2832_sdr platform device, but
> if registration succeeds without a bound driver, it breaks out without
> unregistering the device.
> 
> dev->platform_device_sdr is assigned only after a driver is bound, so
> rtl28xxu_tuner_detach() cannot unregister the unbound device later.
> This leaves the registered platform device and its associated resources
> allocated.
> 
> Split the registration failure and driver binding checks. Unregister
> the successfully registered platform device when no driver is bound
> before leaving the switch.
> 
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
> 
> Fixes: a2f7f220df5e ("[media] rtl28xxu: switch SDR module to platform driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/media/usb/dvb-usb-v2/rtl28xxu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
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



