Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701580;
	b=h6rGylK0HgKfhD164EOUrwyw3j0lpWBWMiOUq3zyVoVQpLvlK0zzkgziK0my3UhI9C3S
	 SdKoiHW9Y6QjF887NmP8NvpB6zTkClHtyG4XTgsJNSFGtB82Ev1rCEBEN/yAqsEI6LCPh
	 8j4I4So0+p2NFFJX0tqTw0BgZkZEBQmXSSwxEEciiEp5ptstBHy3FWTLNK8I4mONTAcEK
	 E6uB1m6KhHerL3Z539phf6pV0xj4fsvAHKyftaBkR59Ap5LeptODRRs+UTweuFyEfRZOk
	 H+icWUwhUIW1Gvr9Q0UYEBn6FlKWF+l3DyfNuza/Kae7vvvm6pJqBvsExBiO0dWOXig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701580;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qt/XERH9JA6N26gnj2KjkQP/rhmppH53Kiuwbw79Xu8=;
	b=1JWGM2fJWXubYM3BsIjX71x5NM4Sbj6YWmjNRKpcakS74kr4IiabmjXdTC3tlRxcJngZ
	 nAmeeKR8HQ192AjXjREQ/toi5pLRF2x/2vFYIXv5ixLMXMyiFxQDqBMzaJqssmI7V8EFs
	 q4f/m+mTTdXsB7lg2zvfr0Fw8W7aerzNjb2WvznGv8ozUOTyIkO/u7YNb3TVVHy8TVmWA
	 ZyM5OPnJBg2KU0aOr2bLf6X5xZiL/W1e7w2JKfKPdv8lHrNg7qveOBQEQ3eRlXsoXV/IG
	 6MuDiKrxOA8saZBV5MgP8g8vzJC2BQyLM6IypdXw0o5Ur5E2EHfS4UlQahD+NLpC6Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NQ3J97Ml;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB816083618;
	Tue,  3 Nov 2026 10:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NQ3J97Ml
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265711F000C1;
	Tue,  3 Nov 2026 10:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701579;
	bh=qt/XERH9JA6N26gnj2KjkQP/rhmppH53Kiuwbw79Xu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NQ3J97MlzbGvbPfqP+8jmcqpXwFhQwFkdoBsXHSVlYt4kgfqM1t9TPAYyAgjsHuEz
	 xPaoAhx8x+Q+NIgUVeOo5FKZwtT950eA2hNgOzsHNWkfWEImJZAWEZNdozzsNjqNcu
	 Z/1D1JdCvRJUIYSOvtNL7gUlofzKee/IrCIgAXDV0iZqZaVS+DqfY7XXW3VmQrrWui
	 n7nmOltb0QuCZPq7VcJiZRB9+inv+mW7MvE7tJECWLPlg92yZ9VBp+TIRltfSsT6Cb
	 VuKob6Bo8aPZnFPntFJ0A+3EdWo4WMrT5Nh/hEIqSmV7SR3PEnp7qiSBHpFo4IpmOk
	 DKQK4/n1AIZLQ==
Date: Tue, 3 Nov 2026 11:26:17 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: stable@vger.kernel.org, linux-can@vger.kernel.org, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	linux-kernel@vger.kernel.org, =?utf-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.fr>
Subject: Re: [PATCH] can: sja1000: fix netdev leak for non-contiguous channels
Message-ID: <20261103-enlightened-righteous-leech-e92bb9@quoll>
References: <20261103100528.1309863-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103100528.1309863-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:05:28 +0000, Wentao Liang wrote:
> pcan_add_channels() stores a registered net_device at card->channel[i],
> where i is the hardware channel index, but only increments
> card->chan_count by one. When a lower channel is absent or fails to
> register and a higher one succeeds, chan_count no longer covers the
> used slot. pcan_free_channels() then iterates only up to chan_count and
> leaks the net_device of the higher channel; the LED timer and the
> interrupt handler also skip it.
> 
> Record the highest used channel index plus one in chan_count so that
> every iterator covers all channel slots.
> 
> Fixes: 2b61972b7421 ("can: sja1000: add support for PEAK-System PCMCIA card")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/can/sja1000/peak_pcmcia.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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




