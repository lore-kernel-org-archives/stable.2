Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47514AA562;
	Mon, 21 Sep 2026 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003163; cv=none; b=CuwaohR7lYjUd3kStEG8P6NxGOvMtvbdwOEtMRbWBshwsFiLc+k1ewF32c0gEJdgVOXlH3T6MPKfSWRPMgB+4eR41dj1G1qYURmfcMkdHjMLlyXWZjkCZwV7mbi6rKav5A819mEaZKkXkSjttGbbVycHU7mcx5iG2jBbsNZj7YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003163; c=relaxed/simple;
	bh=urNJPy0UTiwY6bL4mBfRKDiGmQGCL83scOaImPYblkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrE5jYZFPNz9us1dPj7whCLQXY0Wv3Zpr0G8zYW3RSPIb+SxGRRWKrKjEmtJYWcmhE4PCduzK55bzhW5BK7PaL61bxZHU8IvfTyHx/3XO5MKxb/p+o0b9DtF65uyXeMmlyGu23s24sZ74NjTEIHvQkEJe0wOER2qv3tbaJehL7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJIrRtM2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJIrRtM2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD231F000FF;
	Mon, 21 Sep 2026 15:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003158;
	bh=PuIy5gioVOgHxn+crCfJ2O95acc9PlnVhjspjk1+bNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eJIrRtM2RcYy5/xRAkqJ/eADyhtLBYLes4VbfyPGj/cGaSfwA7lnxWq/2b8lEyfiy
	 QsEqqN8XsSzggqYWQfRkGUpABG7sruGNx+/yC/4OfdioZFKzuiqsGPIDxBkEINuHXi
	 /cxLfoRKn8bgwvVeemXu42FNgOicMhy2xkFeHzui7Px73KYn2RkDJEQX7amKMxMpG7
	 fecQiDmhRbKfQXj9HCpOjTliOD+kL29LHyP62c2eyI5F6dJ3G/Hy+NXXvKwQhbkSBd
	 j5KfoCtaHwIPAqJiJFAEvbzQfKIDXd3a+XtVyTRJ+Qhk7rM8eyxkI7vTbgRYEqrfUw
	 He+YHiYhBKH9w==
Date: Mon, 21 Sep 2026 17:05:55 +0200
From: krzk@kernel.org
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: stable@vger.kernel.org, 
	Benedikt Niedermayr <benedikt.niedermayr@siemens.com>, linux-kernel@vger.kernel.org, 
	Tobias Schaffner <tobias.schaffner@siemens.com>, platform-driver-x86@vger.kernel.org, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Hans de Goede <hansg@kernel.org>, 
	Bao Cheng Su <baocheng.su@siemens.com>, Henning Schild <henning.schild@siemens.com>
Subject: Re: [PATCH] platform/x86: simatic-ipc: fix platform device leak on
 registration failure
Message-ID: <arFH0ridHWo3Z_w9@quoll>
References: <20260921075312.120983-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921075312.120983-1-lgs201920130244@gmail.com>


On Mon, 21 Sep 2026 15:53:12 +0800, Guangshuo Li wrote:
> register_platform_devices() creates multiple platform devices using
> platform_device_register_data(), but returns directly when a later
> platform device registration fails.
> 
> If LED or watchdog platform device registration fails, previously
> registered platform devices are left registered. Since module init
> failure does not invoke the module exit cleanup path, these platform
> devices remain allocated and their backing platform_object memory is
> leaked.
> 
> Unregister successfully created platform devices on registration failure
> paths to restore the missing cleanup.
> 
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
> 
> Fixes: dd123e62bded ("platform/x86: simatic-ipc: add main driver for Siemens devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/platform/x86/siemens/simatic-ipc.c | 40 ++++++++++++++++++----
>  1 file changed, 34 insertions(+), 6 deletions(-)
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



