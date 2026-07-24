Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF904756D2;
	Fri, 24 Jul 2026 22:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784933538; cv=none; b=sim3E3NiiyalG9enPwDmes51X6t+ht7MhKz+NDgMVAt/dAz1RSMs05QZvKwMoYNZ3k/66H2K3b5vUN3NvfKAF0JGg0WG+cZIjZ94MVsMxkN45mudtBaIf1mwr+KCtpPgs0sgrd8qfhizSzld77CbKr16AkXk1jjEpuCSlSzMh4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784933538; c=relaxed/simple;
	bh=WdvIp/kHz6bdqgK6nK7yN6X0JJaQRVefDEDBBWP4sGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkqlByCHDQ+MGaousALLcbLFtbfvvB0yBpluuhZQ3PJrY2yn9q+Uo8VbPa1VJZVqjdj27+2owoFh25AONNaZZvdsNCLQ47/f+gxWLBRBscFTvJ8YVns6HgAHmwQwd4dOJPwNH5I6hSh89mWk6AuNeUXcwvM8nz7HvGX79GT/aNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vx2PrZUN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vx2PrZUN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C821F000E9;
	Fri, 24 Jul 2026 22:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784933529;
	bh=j7VH+I1lcj9KOCqFU/y/KDTXauZwmnuiNnkt0ffMsyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vx2PrZUNdbhNA5e32im1FcrlqlzID9yIgWaOccGgWy7tnwVk696zvUlJSPHsKYlGi
	 gKzSo5R5i92N7fE27fNPAnKJWCvj/pKBWM9eX44lq+/LkGJ4v44Gzsc0YBaBiWIvpo
	 ffI8bb44JNyeAGjZudK3SM3U2o96mFxxyubGxfJNlTgYEsHiQ2UDq0dBD1GzwgZhm7
	 4abwKjyOoolzDVXVsPUsfSzF+8M2w5ngb67UfNJ7kwAvpVt+v9YJO3XBBIVzXn1EyX
	 qZKmxhumcavIvL+zLez0aTYn76FQlNqsqt7iS6zP1SSeOFk+VKFegE3oApyhwtJ02p
	 2j3efIWm/xDHg==
Date: Sat, 25 Jul 2026 00:52:05 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
	Yixun Lan <dlan@kernel.org>, Alex Elder <elder@riscstar.com>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] i2c: spacemit: request IRQ after controller
 initialization
Message-ID: <amPsP5o2wWqszbfU@zenone.zhora.eu>
References: <20260722094302.2284191-1-lilinmao@kylinos.cn>
 <20260723021140.2293844-1-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723021140.2293844-1-lilinmao@kylinos.cn>

Hi Linmao,

Please, next time don't send the v2 as a reply to v1, it makes
things confusing.

On Thu, Jul 23, 2026 at 10:11:40AM +0800, Linmao Li wrote:
> spacemit_i2c_probe() requests the IRQ before it enables the clocks, resets
> the controller and runs init_completion(). If an interrupt is already
> pending, the handler runs too early: it reads registers while the clocks
> are still off and calls complete() on an uninitialized completion. Request
> the IRQ after the controller and completion are initialized, but still
> before the adapter is registered.
> 
> Fixes: 5ea558473fa3 ("i2c: spacemit: add support for SpacemiT K1 SoC")
> Cc: stable@vger.kernel.org # v6.15+
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> Reviewed-by: Alex Elder <elder@riscstar.com>
> ---
> v2:
> - add Cc: stable # v6.15+ as requested by Troy Mitchell
> - collect Reviewed-by from Troy Mitchell and Alex Elder

No need to send a v2 just to update the tag section.

Merged to i2c/i2c-fixes.

Thanks,
Andi

>  drivers/i2c/busses/i2c-k1.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
