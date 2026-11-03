Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702462;
	b=ws+WCvtQFF4LeO1tgXAu8M/GfMZ3kCfvkXWYK2qiBdIRSYsRvySLKOWlJ6kj3ZQ3Aqpr
	 V8unOL1rzbAj/Xtxd+3Lg95tYXVzU1ucIVBOG9F5RfvDMgjlCOlPgLrhQlxEYQ91Ctm3o
	 hebfVbQ+6ne4CO7Ohyv6I/QkVd/jUpw551S9+y0qWR9AQW2wmaEnsf4zDr8ob99qVgyyn
	 74inJe1Fs1PCo6ktaVkJMF+NjWrbS2ZtSIXympAa1DQ4tAGsSS8iveG/bMyJgDkvAiawR
	 bTHXPnk4pNcP2NIQhQr1i7QDinhj+jlYyYuSaWkufKrRd7Z3B+mOd1w50N2rgHCA1LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702462;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tjIG230mhGv1oCH45nA8ShTRVOkOe3IxxB2JzFrwQeo=;
	b=b/0HK5kOKJkEbMr4mcWGMwVZKiHlcZliJs0SeqfROMhjt93Xcd794896QhEY0hCmz13T
	 gfKPjTOaTns3AthghAtw5f2P79yZ0CQgdel4myZDaq8VcwpJjphHyhpO7E6cT4aamVMKb
	 HeHuZk4SG/rmoFZgwkDaPGpQfNLSaG98wUpM1uOAUaJB+88pIOVByUUXL47YZNOGjVQN1
	 KvXLtKPuMtyeE6lMhVXmav5aZx3SKDvd3/h9U9nxAzQIVbdukj/N5L5+Go0VtPdDElo6U
	 j32xI+yZDuhlo8WDJcLdbTCwezc70Xs0Kgqc4lAIOaL5+1O2OwnmJM4YbJhRJRKWnRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GhFvSqJo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC266078F0E;
	Tue,  3 Nov 2026 10:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GhFvSqJo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828C21F00A15;
	Tue,  3 Nov 2026 10:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702462;
	bh=tjIG230mhGv1oCH45nA8ShTRVOkOe3IxxB2JzFrwQeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GhFvSqJor3zOKimRSRifG6qVMYl3H/N/moXCK3AGl52EVOA50Ni64eryNgzoI5SI7
	 +gjx07PNY34O5Ks1MxVPzJsuO/31hpVg7rL38hr6Nz4dZRJDn5up5HOPadh7chB6HR
	 Y5ruw8/vD1fGodVNsBNcGZs/D2OSrbOQ/nOA+3ssFkXFBdGpcFej7WLbGHjfxqcrwy
	 ZdvDzb575i0KtEdohhhyjkcT9bLnyeL55/BpSQK1Yz6+qwS2EIVWtqu6/zyxBRi9ui
	 LTC3qpLc1L44jOc8XiYUmHN8NMQf79edFnhL10OSiabXSEzq+J16g1C9s02XdoUUoZ
	 MnRAWhOuHN5mQ==
Date: Tue, 3 Nov 2026 11:40:59 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: stable@vger.kernel.org, linux-wireless@vger.kernel.org, 
	wcn36xx@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: Re: [PATCH] wifi: wcn36xx: drop the SMSM state references on probe
 error
Message-ID: <20261103-nostalgic-clever-boobook-3c8dbb@quoll>
References: <20261103102902.1340936-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103102902.1340936-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:29:02 +0000, Wentao Liang wrote:
> wcn36xx_platform_get_resources() acquires two SMSM state handles with
> qcom_smem_state_get(). Each successful call returns a reference that the
> caller has to release with qcom_smem_state_put(), which is only done by
> wcn36xx_remove() for a device that probed successfully.
> 
> Several error paths in between return without dropping the references
> already taken: failing to get the "tx-rings-empty" handle leaks the
> "tx-enable" one, and failing to look up the qcom,mmio phandle or to map
> one of the mmio regions leaks both of them. A probe that fails after the
> first successful acquisition therefore leaks the SMSM state references
> for good.
> 
> Make these paths unwind through the existing label chain and put the
> handles there.
> 
> Fixes: f303a9311065 ("wcn36xx: Transition driver to SMD client")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/wireless/ath/wcn36xx/main.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
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




