Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4FE4A7CB8;
	Mon, 21 Sep 2026 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003717; cv=none; b=tcT7IrHHDGYR3UyaI2PGn1JgJlz1s02iw7qV7cyEc1Afg9P+QUklEM4Rly4lx7VLvuyVVGdTxyywS2aVHsPyE6EcFaEQKwz8Ytmxxz4qitGO7MmQnwaU4zOjg7keUIVekmBylJJltnvWG+aVHndt+rj2j+REdPoLEiUrl4w31gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003717; c=relaxed/simple;
	bh=a9Wt/oes0p+RAweh2qYEw43OZH/bcvywwHT90Rwtbd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLgqiWe5lzmGAtmTzy4KR263/V9ghhr9+RogRiGkNf5eoRpXky4a3R+1tXCn8rk321Es2UsYlnyP6oI2r1oBYiACM33NJ1m2Iix+lyBwP6JvxdEdEhK9gi1Fu6wosREC5z2BAcsx5wMyCi/2yonYkTs6qdFhG8MszEgDMzp2Pfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUR9lesY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUR9lesY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F401F000FF;
	Mon, 21 Sep 2026 15:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003715;
	bh=smQ5fQPU8YD2azuLpmzclozF5EnygshKF6f3funf1Yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oUR9lesYlnrXV2TdU+VtLdNHkdG5mpf1iovLirdw1wQbYGBzau0/48iiEglfduMeZ
	 XZLwkjt7Ygb6nW5Hgx/tAppYDgY2ndlAbFBCVN7Qd9mQL7McYdJe7epMuuj7kY/eX7
	 czgKGgZnK/UsAhBLCvBaZCA9/ZGP8SmI8iifNQrvDHAmHpxxw284Ypzn3uWvrgIlhK
	 mT2UkrnKKFkOI4yj33n40Wut+XJ8sdnTA1Jn/ReIlpBLGN6W63HoyRrAWocEdruKkr
	 IJn0iLzxpYQ1jcY8R8F1Y3mSEo9/0T+V/n+J0g/w6x7hbwFxdrN7lGI+N4STwiTFj1
	 /5SXLzzSFpmWQ==
Date: Mon, 21 Sep 2026 17:15:12 +0200
From: krzk@kernel.org
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, stable@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Kevin Curtis <kevin.curtis@farsite.co.uk>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] net: wan: farsync: disable PCI device on removal
Message-ID: <arFJ_2HfXWuWCsUO@quoll>
References: <20260916063118.2924049-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916063118.2924049-1-lgs201920130244@gmail.com>


On Wed, 16 Sep 2026 14:31:18 +0800, Guangshuo Li wrote:
> fst_add_one() calls pci_enable_device() to enable the PCI device. The
> probe failure paths call pci_disable_device() to release the matching
> enable reference, but fst_remove_one() does not disable the device
> after a successful probe.
> 
> As a result, the PCI device enable reference remains unbalanced after
> the driver is removed.
> 
> Call pci_disable_device() after the existing interrupt, tasklet,
> mapping, DMA and PCI region cleanup to release the enable reference.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/net/wan/farsync.c | 1 +
>  1 file changed, 1 insertion(+)
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



