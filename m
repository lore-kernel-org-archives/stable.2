Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8152D4AEBC0;
	Mon, 21 Sep 2026 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003092; cv=none; b=sZC2F+bD6/Ikd0LNKnprmxzGd2LAaXnkDOaJynOij5Uoalreed8H1D6VwCEsq5cbUR5RkLlX9YcoNjnB5/hdJbk9GjZ8nyArgMF4QXvCMCwnBTXUQkV7A2k7OpjxoS9cBX8KbkrgIIsOjRshF/ETmnFmAuN9unwQH1W94EyF6E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003092; c=relaxed/simple;
	bh=l/0uyKU0j3b0Hsy81D9q5ChbY1r6ifLPmD5MUXhvpTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6NiyUbPGhXAwBbtauMH7P0htgwEE9K0T/6REhnNh1I27EdWY4W3CLDwn86dsl7MKHFhXPMb1OP4ZepngPk4Ss0LZ7ozGqxgx0lrabXWjkY2Ro0oL0STkSR2Bt7Dzkwa1Rjoj5QABqTdXLEyOv4QvYfovfLvNYt/v28l7zpcabI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZX5i8G/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZX5i8G/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BD41F000FF;
	Mon, 21 Sep 2026 15:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003083;
	bh=tAJAA4AFmdQlgFZh/bqseoiGcQUpdjeeINGyxieAAC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bZX5i8G/jLPmpFFX18pebpYaJ+3hk2ULfAyNRSO9zNSsv7IwyXOKLqcTtQq7ED3IS
	 IzyIO3tQhFARJ1KhrYGDz/T0cAbaNUNh3BVinvldQ2Mfh7Fri3ao3Y9WwOHUAeRvnh
	 mz9KYlj6TCmkSS/D8ZgbabmEJtwOq+Vv4FbQnNWSdAuAvSwfjKe1Zd7lYSGEUgoV0M
	 lPFa1pDpFOlvNF+2yKb03NjHgTVV+a0LjovuHE8Dgv72nA0lLw534i3aLd8rt9PifO
	 xOj5EoPtKvlgbiCARdTZhpbYdXC729BdMy/HOYu9GRg3Gdc/4gyRvxLeWX9mN7I0MN
	 rLYhG5jpApXtQ==
Date: Mon, 21 Sep 2026 17:04:40 +0200
From: krzk@kernel.org
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Perry Yuan <perry.yuan@amd.com>, platform-driver-x86@vger.kernel.org, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, linux-kernel@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
	stable@vger.kernel.org, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] platform/x86/amd/hfi: fix platform device leak on init
 failure
Message-ID: <arFHhgygVBlggeA6@quoll>
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



