Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFEA4B1B24;
	Mon, 21 Sep 2026 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003549; cv=none; b=mtNwQqf9vxSCU11Ox97jiut01mwpI1pneXjCIPK7rZRTEOKZaZKgM8WdpBmOmalZqkU22NzfRaC4pkXD7ENXpJwXi6dGUd02u8k/nKX/JlH0tVQsIPDMswXZSlRX/OWgnVDk+T3JroPeVA8LlHhqY5x8H7APlXlHAtx9SdinC+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003549; c=relaxed/simple;
	bh=LAciJTKpRwJnWObq9nGHD5XkrGVwEpdzJh+RGirshCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOx9f6gKL+3qZAZ8AZdBS6Y7MUFoyPC3PkBnOR3Zt4UAc6QHy0TkaN7jCC0uTufRAdBX3I3+ptjvV4xw8P/v5xkKRZ58kQW5AfbG/WbRnRVxywV1JgqRKqv/og/Rja4gofNtNE9LMbe8pnxC+9q0+occTX6Ac1VNN7ArWRrF1wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kkkem6Rz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kkkem6Rz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD8D1F00893;
	Mon, 21 Sep 2026 15:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003547;
	bh=o8UxhF58k+iaCX3wK6PvC//NB+h9K2uQAHX4G8biYo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Kkkem6Rz9nbgHhsk0FSU+V9gPTTVQZRitviKsPNgWsaxtrEErBZcTRzDrsFTY9c8F
	 onBFOHeg2t0A0daT87XeW0TM3rs9J6765xgWyQdCd9zXLVMze4CIGxM+zU5gM7Eh2q
	 U9O3MMmjTwxOQQgZgHwhbc93J4+fxJmnGrVWfRrLExYJViCo9xW1TxpkYs/OshOfnd
	 VAq4jHfh0VvOyP95xgMYTxe7RN010zPv4vzZTaxJCIJ1wCgr5orBBQA4hWbJbLBPUE
	 +1IBXBOoMFHdh9UxACogvjjakparQpSzYfAlKC2XNUcpoicDHYSzpHysWlX0MAoZf/
	 sOsDUE4UnC3Pw==
Date: Mon, 21 Sep 2026 17:12:24 +0200
From: krzk@kernel.org
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
	Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
	Cezary Rojewski <cezary.rojewski@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, stable@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, 
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: SST: fix platform device leak on probe
 failure
Message-ID: <arFJVyhJK57m5oyd@quoll>
References: <20260921073847.63505-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921073847.63505-1-lgs201920130244@gmail.com>


On Mon, 21 Sep 2026 15:38:47 +0800, Guangshuo Li wrote:
> sst_acpi_probe() registers platform devices for the SST platform and
> machine drivers using platform_device_register_data(), but does not
> unregister them when later probe steps fail.
> 
> If machine device registration fails, the already registered SST platform
> device is left registered. The same leak happens when
> sst_platform_get_resources() or sst_context_init() fails after both
> platform devices have been successfully registered.
> 
> A registered platform device owns resources allocated by the platform
> device core and must be released with platform_device_unregister() so
> that the device reference is dropped and platform_device_release() can
> free the backing platform_object.
> 
> Unregister the created platform devices on all failure paths to restore
> the missing cleanup.
> 
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
> 
> Fixes: caf94ed8629a ("ASoC: Intel: bytcr_rt5640: fixup DAI codec_name with HID")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  sound/soc/intel/atom/sst/sst_acpi.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
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



