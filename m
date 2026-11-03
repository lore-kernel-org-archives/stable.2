Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701586;
	b=xq6r1bUrcAm1VVpMTwQ5FKyBCEjbI/lLG47buNMEqH6oXzsWnPXtf/zsCf85FFIlUJdM
	 Hd7rvxQjTPuYPDHofoo8WxWdAQ+owDu1tHG5LoS7B5yESnSwgBfvb3miaViDPwXdhkmBR
	 cAkQcaqgd8TEAsmcVDeYJ80lJ8kY/ibh32tjSjSAw00DDkdzSBVI9qIkP6Kdfr/LY15+G
	 Q5KRezeIw02fQXz9XPa8riSnfQya/C+IDd4AQa+F7uqamCGk5drgMToSSU8OO7T/5M3MV
	 rG1DRBGFZvZ7yIXjia+HyAthMW9Zp2K7u5sH3jH0P5/jhhwAg+Rs/p7gNEa/uEcf/5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701586;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RFD4NEWIqRqGtu5uO5m/Wa4jwby/2BfEOciBe8jqLAw=;
	b=GlojUld5M3eOJAvE6yjdw2WOncNWDb/7qryQmtJDPLmVrp3bBY9NbTR3Z6VzJzNDqqso
	 PlKWBjdA2U4AFgS/pF92dZyVYKAutVkgLOQnWVk0oL1Pdp++EJyHgFuU/d8lgGC7zvopq
	 bW6qzR5+ua0Lgtq+m0S2BrCZjmI9fr1z+ZqMidJzmaWxCrWPNeEUh1dud92jl18gmd3hk
	 VOaKd1b5KrVzhieFlt4X9/K6JXLCtcEb9KgzJ04fkuYjka1vWMwBv15elkDZhQ9mFfMin
	 xIqo4wz22M9B5wyTfSCrV/6w5sTwgBdLLZGb1ZsOqMC1DJnpfSQcPlRTACoEXrxYpdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M4fhaES8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C25E60A6F79;
	Tue,  3 Nov 2026 10:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M4fhaES8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526511F000C1;
	Tue,  3 Nov 2026 10:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701586;
	bh=RFD4NEWIqRqGtu5uO5m/Wa4jwby/2BfEOciBe8jqLAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M4fhaES8LjvD+Qqat35pRoUeiet2HgTCzz73C33r8PB5J5ueRvhW4tY5loH+9glUE
	 FsmA7bcXNQn1EZ+gzf/xgC7/4MD3RYl7qpCzV4W4mP1F9TaklZ/3lyVQ0a6jCT4bIA
	 nTTXX3GbPdUbRb8OLpNpeaMoWwWlHgxVE3lxWG7D3GcIt2RgBXVpjyoGzj2VH3wEx3
	 TzW6hKCuDJJpETAQUU8tUqcnx7Mycp0xM8BBMfSJkffFsKS4oN+va06sqcTV7LEiP2
	 it4nYvyJMxcROoG9nEY8gfsTT54KwKf4M9LDnzh87AHyqXuzyHOwhkqCL4zW+tWTpK
	 RrxbtPHY9uItA==
Date: Tue, 3 Nov 2026 11:26:23 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Ulf Hansson <ulfh@kernel.org>, stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michal Simek <michal.simek@amd.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Unregister all clock providers
Message-ID: <20261103-prophetic-elfish-sawfish-c9e22d@quoll>
References: <20261103100521.1309763-1-vulab@iscas.ac.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103100521.1309763-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:05:21 +0000, Wentao Liang wrote:
> When #clock-cells is non-zero, sdhci_arasan_register_sdclk() registers
> two clock providers for the same device node: one for the card clock and
> one for the sample clock.  of_clk_add_provider() takes a reference to
> the device node for each registration, but the unregister helper only
> calls of_clk_del_provider() once.  The second device node reference is
> therefore leaked and the sample clock provider remains registered after
> the driver has been unbound.
> 
> Drop one provider for every clock that was registered.
> 
> Fixes: 07a14d1df454 ("mmc: sdhci-of-arasan: Add sampling clock for a phy to use")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 



Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
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
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




