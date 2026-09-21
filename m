Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E7F314A98;
	Mon, 21 Sep 2026 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003282; cv=none; b=ah6aOllOmuZ4Yy5Bi+L5rfpo+4M6y9MUcgXeWDl6hvgMTbPMQh1GHYpfEZgOfbQLT3b4zvIO3lj2aSvfPVB60p0i+iVn8o7ivwTSifruvrGU84J0CByNSr0K672KCUV3D/hjLMoKzC9NSlYvvwX6futInizdjR0O2MlyMPoEjhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003282; c=relaxed/simple;
	bh=l/0uyKU0j3b0Hsy81D9q5ChbY1r6ifLPmD5MUXhvpTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyNLclCnFbbiF4MkmZ7UKgKt2KgInzpKLmRon8F7tbScrmhHDCN62EF4r/CrKVFzCCx1BgW4bsJKBdNSaPLAuHeJexho8DFrCnaozoHtTithMKZsUBtzGP3XmJ3FhRtEPYfKSOyAXIGGEIDGOk54qv4yogJQEvAN6B8mdkgsI/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqmsI0qz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqmsI0qz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2531F000FF;
	Mon, 21 Sep 2026 15:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003280;
	bh=tAJAA4AFmdQlgFZh/bqseoiGcQUpdjeeINGyxieAAC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kqmsI0qzjGOPe7gVCLbO6uAQbGGSZ8KjokO8HscKCdnABzBZrPBEniZ5S5EGM6Blx
	 jKRiEH64462ZBhqxiqoZWaQxiykoSH52mYNV5qcmCB8j7b3kgieWS7kSrRbVezSFgO
	 acw0n3w8T2JCJTKsSNEtWcWD2Uh9xDoxP5btE73MvVRm6/9PTfJf8Ze9tOrjTWo04S
	 yGDrdPb5ljnwEuQt+2SqTZ9HjjwD3IOGXj72kPEzCZGOB9La93QRyasIcgUyqh6plB
	 yVjdj6TiIpNEs/3KJ1hTSXQ5KdXUCVa108yY3vE1lOnrNCIjyZkVso5/ByiIAvrmRo
	 tJQKCinMIVNHA==
Date: Mon, 21 Sep 2026 17:07:57 +0200
From: krzk@kernel.org
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Perry Yuan <perry.yuan@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
	stable@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [PATCH] platform/x86/amd/hfi: fix platform device leak on init
 failure
Message-ID: <arFISwuMuEpFQR46@quoll>
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



