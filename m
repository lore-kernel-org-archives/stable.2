Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6303B8BB6;
	Mon, 21 Sep 2026 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003726; cv=none; b=fZ0MXZSCZNj4T9vZcZUGaxaK9AIYFeZRdwYHAFii0qMAVndBxXLQSWV3B8uGFozNrHMErZE5DhBAvh3RpYAbBSfufhdhQ6hPRquJRrDwWS+gPfKCbaKmtDR8gqcqf8pGnHa8rJYMDZ+CG6W5WwN5/T5H0nEOdPNzyNFuHex0AiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003726; c=relaxed/simple;
	bh=P1C8Ui9zIvki6oGFNXKPoqdJt/ROpxpZEaMEXA8rt7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KC7amRjH0dG8OXfpSGm+xnOqx8r7eTDw3KyV8DAVyGz3k/PQb+RF4dZ197fUFSTAd1e76qMhqa4ySG7HDKY/oPZWiFHS5ITOIfEt0VPOePxEtc5/5RbPJ3c71//tq8c0hRWySiQEyaqXdbNTP+2sqK+aRW6tQkivLIVA2TF7oTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8foQQ+V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8foQQ+V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446661F00893;
	Mon, 21 Sep 2026 15:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003725;
	bh=6KxHVHlGXN7ASG0nPHwW95I26gCWvcT93+YSRvr9FAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a8foQQ+V1f28MYEdmzQl4UQq/uMYuC9TZvwvVjzd8IhZdMsepuVr8KoE5i0qIXmvE
	 fB4wWiQRx1lQnkxUw/c11iZ52izTQLzmFzdnlBLyBYoYRlrH9OzAwHaPUMF6O6rzAi
	 WjCZKwLvc2IxQhtY709vriOxvpWmEI1QQaUWrnYv9iChempoM9TbJ2qXoD9XsIDW3W
	 PcxOyNLqSInwssJvZLwbHKwchCpujAZzU+0iWAXkDDJJhLNz3XHWU+QqDRRswYinux
	 WW4dBIGyDFiPmIjRCP+VrVM/lnt2b2bVo1X11srzSuGaMmuQg1JGrL5T64D42fCBSh
	 /D0bq8O6vA11w==
Date: Mon, 21 Sep 2026 17:15:21 +0200
From: krzk@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: rafal@milecki.pl, stable@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, a.fatoum@pengutronix.de, srini@kernel.org
Subject: Re: [PATCH] nvmem: u-boot-env: Fix mtd reference leak in
 u_boot_env_probe()
Message-ID: <arFKCfqF0ljpWjTC@quoll>
References: <20260917123839.2151503-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260917123839.2151503-1-vulab@iscas.ac.cn>


On Thu, 17 Sep 2026 12:38:39 +0000, Wentao Liang wrote:
> of_get_mtd_device_by_node() takes a reference on the returned MTD device
> that the caller has to drop with put_mtd_device(). The probe function
> returns early when devm_nvmem_register() or u_boot_env_parse() fails
> without releasing that reference, so add the missing put_mtd_device()
> calls on both error paths.
> 
> Fixes: d5542923f200 ("nvmem: add driver handling U-Boot environment variables")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/nvmem/u-boot-env.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
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



