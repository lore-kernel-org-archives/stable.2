Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D736225A38;
	Thu,  6 Aug 2026 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025978; cv=none; b=d3pz+6orfHuQrKs8VjagzmH/lULNQeZH8LpeH7lk4I1bmr/ox+QgLyOIf+dlmoCy+yD63Mux/kFoAIq4ytXJfIcT+fpT/XzOLH68cYe2ebaWzApL5Awj2zLdoEUCoptlKnKEMJB4aYUBDZpZCKw8jehfF14Hvox/I3UWIgQgmg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025978; c=relaxed/simple;
	bh=rX+HsKuVVgQn99B27TF9dOPwxSk89SxVgU4tMSIfhSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8cLO2jUJRkRH7RlFB4iT8NMaPm1XyyDC69y+7BpEmHFB/d17MmTDc8silCDD+ZawvjPtD/8mKindYlEht5zdwnjImUQGmHwu3T0baKnu5JuqgpqUx9/vxpJflYBhSMHcCFukTp4uXpDfqOh9WjK4PPXwmtqVJy2dxShkQ5Y4tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9ffD5h4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9ffD5h4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117E51F000E9;
	Thu,  6 Aug 2026 14:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786025976;
	bh=8do2kFmBSOv+/uKb1XGKjU7Bsw08uLrkcUMutyauYcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j9ffD5h4Cp/79vRyf3/kRMXdm8vb1n4FunUdUh2JZ7xiiUmUv8CAR/2BHBmldF3ZT
	 Gkb7K9o7EYvCS45vmzS7Jx1S+cdtkBGtDXFAbtU8OXl4HHmcbJnnwtVK03TSspeWzy
	 ZDO5yxtMN0Lt7MLz/2ciFtJUw27DVV2phEZd458LHz1RPHZM0ve0UUe1Bs4Q9kH6EJ
	 LnV0zY/WNZT7cSnjtZF3WOUVflaS/F8paJEmrREGRkZs2y8gT3gjSMZPSkLk03WXu0
	 rdkFyQt5GK4wIR24A7pYfehZnuQMQEAavlx9ovvuP3YL8Bfz40YiLCKk4PxvnktxmY
	 uwFtHXKChUxzQ==
Date: Thu, 6 Aug 2026 15:19:33 +0100
From: Simon Horman <horms@kernel.org>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] fjes: unregister the netdev before destroying
 the workqueues
Message-ID: <20260806141933.GF51943@horms.kernel.org>
References: <20260805011410.414431-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805011410.414431-1-fanwu01@zju.edu.cn>

On Wed, Aug 05, 2026 at 01:14:09AM +0000, Fan Wu wrote:
> fjes_remove() destroys the driver workqueues before unregistering the
> netdev. The interrupt handler queues work on them, but the IRQ is only
> freed from fjes_close() under unregister_netdev(), so an interrupt in that
> window can queue work once the workqueues are gone.
> 
> Unregister the netdev first so fjes_close() frees the IRQ and cancels the
> workers before the workqueues are destroyed. force_close_task, which the
> workers arm on the system workqueue, is handled in the next patch.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: 658d439b2292 ("fjes: Introduce FUJITSU Extended Socket Network Device driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

