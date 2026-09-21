Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C8D4A4EEB;
	Mon, 21 Sep 2026 15:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003354; cv=none; b=lEsvZq9+bIqAcrxi0tQF85TAUR4OoqMMT7QcMLCv5FmwX1whWkbvopRXD+RvnNwMWB0CgwTcJCcjy2VgNBpo3YmWRwvUXP40V5ZPpCyWpcJm99CZLw4RNZilzFMbFJBHB7H/ROmLlBNhi62kEAMm/VV3yl5MqW0Op3Yk/WqTGdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003354; c=relaxed/simple;
	bh=LAciJTKpRwJnWObq9nGHD5XkrGVwEpdzJh+RGirshCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJBQCNmrOZ1HiRkP1ZyDVbDZwSPSiYW1sGRDxWBi0Fj+dgm1d/Nl4ZRfX3nmjwp3PQjtBZsWZ69tCbKFBUca4DpCw9723jtgcwZXCZQm07wwKb6YCbGlNHJf2+OTDB9+/U1BVVPqD6kFlZT35wsd5Eotb6pV37BPjRwcXBLscSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTvaV/Mo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTvaV/Mo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE401F00893;
	Mon, 21 Sep 2026 15:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003353;
	bh=o8UxhF58k+iaCX3wK6PvC//NB+h9K2uQAHX4G8biYo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fTvaV/MoQu8wj+zrBmUwZE8wh8FxWzufcvu6B6NZmI2qMvSvlXGXibBUsSbkqD6Dq
	 utqLArfucl9AG2xdDrcR55CkXEdaawYr2rqMoTH8ilRvHwbypN5sC+IkynIqwnszqS
	 rLcdyB73cj5zYKxR+ot+gc2pJiOu+ai3Yxw4baGVtQM63Y5H2VgOULQL6RsJ1H8re8
	 I7GRstr91pWdYouzhRvzzZCMMkPTopDlIMilED2xhu1VT5si5ckn56bgrhQ60PsSkr
	 +YkOr0PnzxQt5bZQ1iiJG3+gzWdqMeVuvbw+3ncW3kiCU1HRlCv0d0H7BWwBC2Av6d
	 6rZRe/ri1kIUw==
Date: Mon, 21 Sep 2026 17:09:10 +0200
From: krzk@kernel.org
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, 
	linux-sound@vger.kernel.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
	Mark Brown <broonie@kernel.org>, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
	stable@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
	Thorsten Blum <thorsten.blum@linux.dev>, linux-kernel@vger.kernel.org, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, 
	Cezary Rojewski <cezary.rojewski@intel.com>, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ASoC: Intel: SST: fix platform device leak on probe
 failure
Message-ID: <arFIkzfs0FGy4W7E@quoll>
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



