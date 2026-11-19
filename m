Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094728;
	b=2TwNp99YV5JFSo5rEBUW7YNRTUFLjQO9NNbml5SfZteygoPVDwJdpnCdcrUPMxHwIroI
	 OVcyu6oPEfW8U2ZZkOrkOVhQBQhzi8KNMcwJK4gakq3HjxUjCzqRAdoyj79n4NwUzHlUp
	 fgVQ2MF1LSkJUzu9iLUTs3ng9cWL/QQ2wlWgC5CNi/kT3xNeNq1YFlACKl/zbKJh03WSo
	 Fga/YgM5d3viqBIxcW/VKI+LSa7eGCvKAQoTnmnkCajQXhebL8PK0ZSCv56hGxIRAHs19
	 abJrsVHgVo1BoHXKMbJChV/rY+PAuvFkZ/miJfsIinBrWmty+m1KHqsRFvhZdBteAZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094728;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nmF2olN54VJGeow57I/1yS0cpwDMcPArd5rCiskemd4=;
	b=5qbynVm7D1igdYC7zcVnd2rp6tJXJMI0lmLzBxF06Ud0Y49iQoKugMVgplwLUpS1bQmC
	 Mp+DV9AX/uOlCGf2H9H1IW7iMKwmNeA8j0tgZSJ+cp9pBIy4UdBe1k+79+tm9hGN2mY5f
	 s+0B8AeiAKrjCxqJZ298lY5sHwTLGnjyv4gxtSK5/x2oWF0Ylg7m0ymM3oNTYAu1pQqQf
	 9SQ945ha6dJpXsMJU/X9MzzXoPZV8sJph8uyrsJG3i0216Rche4ab76QJMu/HphsZPcJQ
	 0D+gHmSeTMjgFeN+ZAfkCRBOdnU2mCP/xsvCpr71JvPidoa3dJ21IgRGQ9TfuWtoyEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KQrf956S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 793A660A262E;
	Thu, 19 Nov 2026 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KQrf956S
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5F82F1F000D3;
	Thu, 19 Nov 2026 13:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795094728;
	bh=nmF2olN54VJGeow57I/1yS0cpwDMcPArd5rCiskemd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KQrf956SY50m3glTo9Sd++gO0A3liy0EAp/0PVqDicIghA/0du3Dz0oBc9idKAgCE
	 TFG3O7UKWrKnt1qvZG54FSfl1Y0XeQV8wFpSvBr41qIWohnsbiqrk3lgDW5KTCcrhK
	 GQA51bFnAAUsZMUhtt3jAooe/Uw5hZ9+kQ36p7xuPyzjIOP5ouamERZ037+e2iMhU0
	 Tqqot1tVJBiGTx1ZPtbDMbFpp2b0sjH3jtNAbLyrgunJftMketqtGCQDX/Ruesu4kA
	 sBRZauYbYdRHRYhEm3C6riZxg8YircGbtj43ebsBeTRacT9y7yNMotBdYp/GdVzi4r
	 sqGxtOM6D38+g==
Date: Thu, 19 Nov 2026 14:25:24 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Srinivas Kandagatla <srini@kernel.org>, 
	Khouloud Touil <ktouil@baylibre.com>, Linus Walleij <linusw@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmem: keep write protection disabled while writers are
 active
Message-ID: <faiy43d7khj6d3adwhnbdkkq2h2cdg7bue4lpawtzrhv3vsm3f@3372slynbcbc>
References: <20261117-submit-nvmem-wp-serialization-v1-v1-1-539d121f8f5e@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117-submit-nvmem-wp-serialization-v1-v1-1-539d121f8f5e@gmail.com>

On Tue, Nov 17, 2026 at 03:09:08PM -0700, James Hilliard wrote:
> The core deasserts the WP GPIO before calling the provider and asserts
> it again on return. Two concurrent writes can both deassert WP before
> the first one finishes. That writer then protects the device while the
> other is still writing or waiting for the provider lock.
> 
> Count active writers per device under a mutex. Only the first writer
> deasserts WP and only the last one restores it, including on provider
> errors. Keep the mutex outside the provider callback so providers that
> forward writes to another NVMEM device can still nest.
> 
> Fixes: 2a127da461a9 ("nvmem: add support for the write-protect pin")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/sashiko-outbox-219526@kernel.org/
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---

This adds a mutex where there was previously none in nvmem core.
Synchronization was left to the underlying providers.

Can we not use atomic ops and avoid the mutex? I'm talking about
something like:

	if (atomic_fetch_inc(nvmem->wp_cnt) == 0)
		gpiod_set_value_cansleep(nvmem->wp_gpio, 0);
	
	if (atomic_dec_return(nvmem->wp_cnt) == 0)
		gpiod_set_value_cansleep(nvmem->wp_gpio, 1);

The only problem here is when we put the last reference, start setting
the value to 1 to enable WP, while another writer bumps it back up and
we drive WP pin back low. But then we expect the GPIO chip driver to
handle synchronization in this case.

Bart
