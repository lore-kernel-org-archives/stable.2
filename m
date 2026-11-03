Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698093;
	b=dkzbZwSES/GIhjUcm+tNyS2rWZ/pII50T5LsJ576tfRT557AHbNHKN+3OP8+ksRT7tDQ
	 3juvah14LWmTGWnTo4H+A5qGi2cz2NBzsMMMelv3JcMyb3yENrRV3d5z9SRxwYchy/4m9
	 rEiRrmr7LvCCpoYxE8So2zaOs3K6yFRL7VovbkUJKfeFh9uGE7RjzzSacWHKkMNeckoE5
	 1IY+c2YWJnLTJBg29JDBYwB55hucxVUjrmTh9pK6Gvp48AqsVyZvFrcO+MMqo+s7sY3ha
	 W9CtmtLRO1E4R/aOULYk4XGDIH0X7JfxqgefBw5U6FLP7ryeOla6woH2M/BGqNinwUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698093;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Q+bB5gmDGLtqPIJ6y2fMdQitLLU/dGXPtbUy8Xl3+Hk=;
	b=S3aiz4Kwp/jR3fZDymYCi+1DDDY3t3YKfkvMQ7g9M93kTNOEE1vRcTsc4hRKYQOzYAD1
	 xpA46o/snsz4jrwnMvK62aBvQ6yifdYYi8JmHB/9xe+rVRcb+lNnEFGWbEdRYbtzi+Dpm
	 Il7BtuqqntCcLuOM1ZSL7VjKRd2V0Njn+cxMGlSvj8Wz3k10QsePCwQwaAIBsFJgBoArf
	 KNiZcLP9Iynk5hzkqRIG8phrswPGyVVYDuKM9XQP57QoWb0osKMqowzgS2IcASJtzziDM
	 4GZP8eieXQy+cFvaCsuMdpV+xvyWwsTF98i6UqZDkqsZDe96OjvChX8vsfHCe3HSfLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EZV3WDYp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796E5606A32D;
	Tue,  3 Nov 2026 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EZV3WDYp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BD01F0093A;
	Tue,  3 Nov 2026 09:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793698093;
	bh=Q+bB5gmDGLtqPIJ6y2fMdQitLLU/dGXPtbUy8Xl3+Hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EZV3WDYplktXctFCMYyT618gYz0Xu7ZJHjQx0nxAh44OtIaJZBovtV50QHEST8B3s
	 cURX+VAt5OzRXmfmjqKSr9otL2KIcmmwEkYpR1rbw+Pc0dc4aJsL5YSa5NRTjIiBH6
	 I968Q/LKV5H8tdsJPJ/J0gyKgewMPtS8RXk4D/BDKsyO3bj+GIA4KKI67i6SkKCBla
	 PbvTNuacY4v9lEMYCu/eVXMUDbQlWK+5G2XLZi/rWlXgP8hKHQWXG3jaGyQgzCnUwO
	 gGZtzKVXNMP0OQzi9tIDylUzuoNCgfQGonHkJWqAolwYRUp3cQ2GKYTzsLAaEUS1A+
	 ZAf/m/74x54Kw==
Date: Tue, 3 Nov 2026 10:28:09 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, tursulin@ursulin.net, 
	rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, stable@vger.kernel.org, jani.nikula@linux.intel.com
Subject: Re: [PATCH] drm/i915/selftests: Unpin the context in the LRC garbage
 test
Message-ID: <20261103-resourceful-bullfinch-of-strength-5a54aa@quoll>
References: <20261103080434.1127682-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103080434.1127682-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 08:04:34 +0000, Wentao Liang wrote:
> garbage() explicitly pins the context to corrupt its register state, but
> only releases that pin when request creation fails. On success, its caller
> waits for the request and drops the context reference without unpinning.
> The request's own context pin does not account for this extra pin.
> 
> Release the explicit pin immediately after creating the request, on both
> success and failure. A successful request already holds the context pin
> it needs until retirement, as in the other context selftests.
> 
> Fixes: 24eba7a9981d ("drm/i915/selftests: Check recovery from corrupted LRC")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/i915/gt/selftest_lrc.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
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




