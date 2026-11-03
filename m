Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701548;
	b=kJgDyt/OfksNKfQWyTWQP3Iib2WTdmGzMclJON35Is7NDBdwhdbT4L6HdmQFrmsvDkmU
	 6ZSxY+Hpvf3p+aPBIAWcoFdMsS6OoucQYnK/KohmniXUofND1K1WiGOzqdJgsmcvqDjnN
	 6OuJKbNOF1qWv0mMubvYj4xx+z5Fc0V+FxP0RzJB+ZKPKUw77PS+7zmLAa7tSqMJGhWEB
	 SwUe1ztucasy1xVbTPh9zwFFMoxufz7aj7NI0/xxk4wDhzx3vB/j9E30t8MYCbYrRAyGy
	 ppC3YlGXSB8CtKxOiWxxqS6xherCZgrizSNhuMU7tN+p7Q8uLxDxIIAQUXJFrqUyLpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701548;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=eVBfRz3fVnCcRJSsVqH9DYQP76908hbJkwajsue4xn4=;
	b=TGyuVTtCcs4MKLJiHc6bCyFmwi6Pqi3MG+vn7B5jFkyS2BAG6GZxo/7o8rl+BoJAWso/
	 2x+ogNppWNvbUL8+2tBlIW6XfQWmXPxi3L9GggTMOQpsliBvuOgiH9UuewXm5Jn4IRIeD
	 of7Aard0/1V0XZBrY/Na1TPkhGtVkzPTQUtdxwgkme85REg4wE776s6nnJj+J6Y3qVMo4
	 T8keqAu3hC3HTrvU2YgIH0IWyU0GWzbbBkPblUK7SLDrtDdnh3r9E0N5fC/X0LPl8Op3b
	 Xb+FyR/NEHqTrJRd//v/OYMRP1a86RyCh5Z8sJl7ci2s9Uhqrdw/Rxeqy7+RdWkqmVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OOr+PLEa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA748606A32E;
	Tue,  3 Nov 2026 10:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OOr+PLEa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37031F00919;
	Tue,  3 Nov 2026 10:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701547;
	bh=eVBfRz3fVnCcRJSsVqH9DYQP76908hbJkwajsue4xn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OOr+PLEan+GgFITMCObTWVGJcHeupjMJKX6wkkhl6yq8KJYZ1qRR0p2OjbdThK05y
	 uNQ+H6wZNWOJMQU95+3NfBEFbjuCX/+6iOzLxAE+ZHKEpG7lD4uuA+DoyBFv0caF3X
	 FPgL/c96MRtxhPcnTObVzPthB0Yk9WVsg970YAAAXqtOL2t2cU3AyDUed1BxV9CZrH
	 nzd11OoHLxjCiua/k0ByAFjIfqx6jMb862TCwm4VHWURWY9kRayEFHzCSGKZyKLLih
	 /EfqsoNioud1XBmlNlvGDRPzOWWe4e6Gzam0s4WQcvjp81BV2mvk5AojwJ5oxK01sk
	 g6dJMjTTel5wg==
Date: Tue, 3 Nov 2026 11:25:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	intel-wired-lan@lists.osuosl.org, Eric Dumazet <edumazet@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH] ice: release the VF reference in the switchdev trust path
Message-ID: <20261103-gigantic-vulture-of-support-ffffa4@quoll>
References: <20261103100530.1309907-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103100530.1309907-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:05:30 +0000, Wentao Liang wrote:
> ice_set_vf_trust() takes a reference on the VF with ice_get_vf_by_id()
> and then rejects the request when the PF is in switchdev mode without
> dropping that reference.
> 
> Return through the existing out_put_vf label so the VF reference is
> released on this path too.
> 
> Fixes: 1281b7459657 ("ice: Forbid trusted VFs in switchdev mode")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
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




