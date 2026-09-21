Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3A14A5EAF;
	Mon, 21 Sep 2026 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003739; cv=none; b=fp+sTa7yMzql93QxL8GgrzOZH4hiAglQz7gs9QQoFwGpz9mmbxkBeKVIGgQ38i+HqJZfya9G+VPJ7cHF5b3/VWR9gZ+b0j/k3y20eJ7xwh5elpeOU/hBLc2cudQ1Vh8BMZzzjxc4VsAqetLKLYJL66RKjBMcimBfTjVi2H8+yIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003739; c=relaxed/simple;
	bh=l/0uyKU0j3b0Hsy81D9q5ChbY1r6ifLPmD5MUXhvpTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbUxdVky+HnZwwaNYHgOkZPFaod7K80kE6MN/2tWZ/raskfWes9kHmm6m/HPsjdtEbpZauUYCHZXpZksdF9v/wP3x0s2zCLQjD2ALK7xU/ybLmD/jvQ01iYvTsbJuM371Dquol+XNl9yh1r/ah4KFyt+LFZ3hIFPvQZ0B1S7q1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpXQKolZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpXQKolZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138631F000FF;
	Mon, 21 Sep 2026 15:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003737;
	bh=tAJAA4AFmdQlgFZh/bqseoiGcQUpdjeeINGyxieAAC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WpXQKolZSYG9018vjTF2eYTUhQBymYGid27HDqLOC4NKJeQOw8Eb+4rJJLMBCEpeF
	 eOnu30EKU/oe2jSAnLlj1/L0vLGcAlWVSN4Ozh5ev3Lf7/zTXg0nluL5y9yst+vF/R
	 XhBLx4McacsKBb1F0hXr7apralL44m1b3yLfYSQ3z5IyAzMd11ax+Te7Vtc++eKWNc
	 S8+lRbYYmq8M0KbxIGLRumCtK0DxfQu5Nx0h15N1EOw8TrHxhASZprzdDMt5IS5r15
	 LxNRZR2Gas7pFdsGAPoSnwM6HGfDBmt2iUjLuS7dTYqA99cJlm/G0mr+eirXPo33/y
	 wAFttJ1Ri7iJQ==
Date: Mon, 21 Sep 2026 17:15:34 +0200
From: krzk@kernel.org
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, platform-driver-x86@vger.kernel.org, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, stable@vger.kernel.org, 
	Mario Limonciello <mario.limonciello@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH] platform/x86/amd/hfi: fix platform device leak on init
 failure
Message-ID: <arFKFmkpldopUIMI@quoll>
References: <20260921082609.244774-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921082609.244774-1-lgs201920130244@gmail.com>


On Mon, 21 Sep 2026 16:26:09 +0800, Guangshuo Li wrote:
> amd_hfi_init() registers the HFI platform device before registering
> the platform driver. If platform_driver_register() fails, the function
> returns the error without unregistering the already registered platform
> device.
> 
> Since the failed init path does not run amd_hfi_exit(), the platform
> device remains registered and its reference is never dropped, preventing
> the associated platform object from being released.
> 
> Unregister the platform device when platform driver registration fails
> to properly unwind the successful device registration.
> 
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
> 
> Fixes: 5d902ee5609a ("platform/x86: hfi: Introduce AMD Hardware Feedback Interface Driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/platform/x86/amd/hfi/hfi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
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



