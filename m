Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFF443CEF2;
	Wed,  5 Aug 2026 11:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785930662; cv=none; b=uVhLlVz1xb4e0tkF9i4GR1dqaunbliaDXq+pwhDppHymVeO6AGc+JhMTga6YppBosbTQvzUNNOX0iY0O4HLipjy4liyBHyYWFMToHpkIqx+uOaL6oWEo1ePEU7//dTgRr7pSLmuF0S2O8UlIAGstWSV0yt/aZCwzKHWZcSfZsxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785930662; c=relaxed/simple;
	bh=FGFLoNYfQOigdPn+U3bGU8JL8E+3i8vMwhkbY2lxZko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1ubAqZbLW9vV8F3jNetSa20KwHasm7MeHnttrkxGI+z3mxDCDYRWsOJ7onV2PdZm7cPcFG0aozB7bCfMclHuRu7Gn6BTJYfl4X9TOp5OljDBWN3ee5EskVnq2fDocP2G5CArnp4kK5saU06Dd2jC1yuiCs/622wM1muZ3QmU6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dV9k9Qpx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dV9k9Qpx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EA21F000E9;
	Wed,  5 Aug 2026 11:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785930658;
	bh=eTbyRcaHZJfbqY4hDC4Y7qe4QDmdHoedHcKvvdXn+Ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dV9k9Qpxyo8j7+eqRf+dlHq0nv+3nB98HqhjbIYDiQF3NqJytfDSpDEd/FQcIe1vX
	 2IeKxLN6T6hkEwbeZVClNLElRVzszpCzGd2bpjEO4cYpxuAkQzvHRC8CDgtqDK9iyB
	 3qK1jiE8USlAQHGX7gUQ3hJsgI05024CXxABIKrEz0QlBST7T8Pz0FnnHyUwAKOA1E
	 L4K2siK+v0Pe1i5o0ImlczmyP2vz1K1Nf1oWNbvtkGKtgNxYnDBtr4YbPftDrW9OrE
	 SwV6fpA3pudLfvy7bpNu+ALaF4Ixvij1FwfDA4aLrP/jqmEbg1qWIQ8vtr4SeIPZ7k
	 +Axy3+gHndNdw==
Date: Wed, 5 Aug 2026 12:50:54 +0100
From: Simon Horman <horms@kernel.org>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: netdev@vger.kernel.org, david@ixit.cz, mgreer@animalcreek.com,
	oe-linux-nfc@lists.linux.dev, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3 0/2] nfc: trf7970a: fix lifetime ordering around
 IRQ setup and teardown
Message-ID: <20260805115054.GR51943@horms.kernel.org>
References: <20260801051058.354165-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801051058.354165-1-fanwu01@zju.edu.cn>

On Sat, Aug 01, 2026 at 05:10:56AM +0000, Fan Wu wrote:
> Two lifetime-ordering fixes for the trf7970a NFC digital driver.
> 
> Patch 1 sets up the lock and timeout work before the threaded IRQ is
> registered, and moves the lock to devm_mutex_init() so its teardown is
> part of the devres lifetime.
> 
> Patch 2 depends on patch 1 and drains the timeout work across removal:
> it marks a running handler to skip completion, handles LISTENING_MD in
> shutdown, and cancels the work after the digital core stops issuing
> commands and before the digital device is freed.
> 
> These were previously sent as standalone patches. Per review feedback
> from Simon Horman they are respun as a series.
> 
> ---
> 
> v3:
>   - Respun as a 2-patch series with an explicit dependency.
>   - Patch 1: switch to devm_mutex_init(); remove the explicit
>     mutex_destroy() calls and the now-empty err_destroy_lock label.
>   - Patch 2: set ignore_timeout before send_err_upstream; handle
>     TRF7970A_ST_LISTENING_MD in shutdown.
>   - Patch 1 was previously sent standalone.
> 
> init-order v1: https://lore.kernel.org/netdev/20260728031021.230831-1-fanwu01@zju.edu.cn/
> teardown v2:   https://lore.kernel.org/netdev/20260728030716.230626-1-fanwu01@zju.edu.cn/
> teardown v1:   https://lore.kernel.org/netdev/20260721133539.3195899-1-fanwu01@zju.edu.cn/

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>

