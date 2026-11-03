Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702457;
	b=RvBEqPKFn4ixS8UEiIv3NzQJCyKalpe8lViJ2Bui7vC33QgCfgsB6+oaGFMTPQlS7057
	 xb/h87D6wg9bATEOgvyDhZ78dStjDOZAFTP7luDHbEcxWpS63DqvhGEha6KO6Hw6Ty8ve
	 Smbqeb7mxkuDd/eotAyM9jKQdwik2+bt7yMHRSlHDDYv14+3bWcEBqh7F1+04keARJmLv
	 pZesyt+CPgv7bAv5qncW5F790ylhpxqSPinnxicCu2jJyUiLklItfKdLmwxGq+9LsppjO
	 l0pwvPDxMi8IgMZcq3KIbyyvmV6gBjpyeni6VkfV5FMbFF/4wMkEYFDhCJo9+zHkobQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702457;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9gRTKDN36/4ozZWtGoP7ulX2aHNkplmVxuLYjJ9WOe4=;
	b=Jou7Cn+IY0/AFACoE7/jraspaGXw3AGwzzN8PcxjWt66kve0/rLF4XojPZDa+CaEHJ07
	 VoenTfbl45dNXRnzboxuleRskb6XGXFtWxBf4/JAygBICRrQ5LJbGr8ILeaFUtO4XL2mx
	 5zbR8u9uE9VrfGg2axAl4JUENk14zpOWILVV2dmBCesLoMSE9w/nPkFKcAERI4NT4jA4m
	 QQ8mZah5gEMudOo4y1B62UPgK81kNx3GsPFRCBFc82xUhM51MjREbLZjYhP/2jhlCNHEl
	 75ZhqGNd+Uulq26mPQge9xzpcUfPUeOLa3LKDHiy3bUpamnCC2QWYgVVqbTYfKxHcSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YfSxmpnK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EA4606B110;
	Tue,  3 Nov 2026 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YfSxmpnK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC241F000C1;
	Tue,  3 Nov 2026 10:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702456;
	bh=9gRTKDN36/4ozZWtGoP7ulX2aHNkplmVxuLYjJ9WOe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YfSxmpnKzw8lVduPpGEe9IlP7yT+QWryAJnxeEvZwSNINJPlapwroyoNjgrOFvbEc
	 qhU/jXX1kKETv51KmLCq9a/Py3zICATatDpqBTfCEqxPesRZTVpAa+tdZqLH/fg5by
	 YyJyQOLmooBvt7jwYXDSRIjPuFgymMY/ghi4QceCZB95FMwxlOV3+mitX61ynitpJB
	 Fv3Q9jLRknCRRKLn8Iub50+QnEKakZ9zXqjXAaREykRg8Fj9snH1qPphG1RHQvGnK/
	 me3UhCvEIZLfphpk5LjQPKc3MH8chrZwXaBk2EzqRyD7ETMywUjQngC3REq9TBqWIp
	 e5YHFgaBm5avg==
Date: Tue, 3 Nov 2026 11:40:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Petr Machata <petrm@nvidia.com>, Eric Dumazet <edumazet@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>, stable@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] mlxsw: spectrum_ptp: release parsing depth on MTPPPC
 write failure
Message-ID: <20261103-convivial-prehistoric-deer-bcec5f@quoll>
References: <20261103102851.1340480-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103102851.1340480-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:28:51 +0000, Wentao Liang wrote:
> mlxsw_sp1_ptp_mtpppc_update() increases the global parsing depth
> reference count before writing the MTPPPC register when timestamping
> is enabled for the first time. If the register write fails, the
> reference count remains elevated even though no timestamping
> configuration was installed, and nothing will ever release it.
> 
> Drop the reference count again when the write fails. Also only drop it
> when disabling timestamping after the write succeeded, so that the
> reference count always matches the programmed state.
> 
> Fixes: c6b36bdd04b5 ("mlxsw: spectrum_ptp: Increase parsing depth when PTP is enabled")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
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




