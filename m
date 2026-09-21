Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B773ED5DA;
	Mon, 21 Sep 2026 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003143; cv=none; b=sVstznZ+G7X/J+wyIPxWjzr1BoPyoxzcq14K77XtcK3uolZOFm5ZMtQfCo8cwrshsZQilC0ztX59aWMeDVhUOK5UJJu7EXMeloKJaOYRrlSBUTW5UEdhTpOADBhRMCKnH6k7qk+ru1LYBZR2TuXZ2QBmaW95idzxW1Xu0HrclM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003143; c=relaxed/simple;
	bh=jSVQo5DDclGhv2d/2izRZByPafPsF9Fn20U+7ZJLgpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOtmoU9E56eP5K0lcMHGAqoP6pmHKZ+MGv60+hvk8MYyDdsa5STHNQuUWg0hNKmOmjRibIhiAXftS/Bsb1P6vqr2qDcFBMqM89cq0S3vj2K9sXoJLrZ1ZA12WSvc24kc23EU3MBwP8hqA+XDlbv5i0eOXOrvUZuf3mQ0oiZdX7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHEqKpiI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHEqKpiI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BC51F000FF;
	Mon, 21 Sep 2026 15:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003127;
	bh=+We2JHXqjpmgc9MfUSu76xwsivNV11yVUPFPYqsRgIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lHEqKpiINNhSk0wbTjApXgaWaU8HFg74k2pDkzx2KMg0S2wEWX7XOAjckfJCJkoMN
	 wSKf6YASyRLhwZMEgIe2MvkmU6irQVRfD4DfjAen9nqg2tSrrqJz2Zr4hve5qxyFXw
	 zkSD58a9Y4ptmamcR3Gf9pUB7Z9ck5JFLfILhK2ch8n9YQXvxthEoJERy5BMcE/49x
	 hzQi+RU38OfVK+NxJmTuEBtyWcyB89x5h6ltRXLfexl8PdtRqEpV/k1Hb7Y/VBLmlE
	 UFO//e9/vM8UgwMbeG9+HVPsG1efj55wWPSlIzUYNhWb22X8fKHApr5LYCce0bdrWa
	 D5YFyhilT4G5w==
Date: Mon, 21 Sep 2026 17:05:24 +0200
From: krzk@kernel.org
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, stable@vger.kernel.org, 
	Antti Palosaari <crope@iki.fi>
Subject: Re: [PATCH] media: rtl28xxu: fix SDR platform device leak
Message-ID: <arFHsuGjlu1NnLkA@quoll>
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



