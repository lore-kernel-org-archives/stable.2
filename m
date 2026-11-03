Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698097;
	b=JzR/sse/Fj3ltQ0OJEEKtScV0vVsmAZKiB4T4BI8R8wmRAD+gmCsEBp9ZMWhZyWtuQRz
	 NB/MkeVyYGZP1mtOcnJicgXRq5eDEC8NIFXkukDSl6X6Ft3E0eIFitNNR2bWCmpK/gC9N
	 xr4ZFnz2HOWZUzYjHqkU8/TkaRl56BBLtsRH/pPNpYv/yK03YsAAUMwkxDrPuwk+J31n8
	 sLZMdnWlrkNgUskiummbsxO8s556qR/LtMcfuFofvcca0+IXUfRr2gW43DrWcJk5lBmud
	 toAYLFICjDERXQTf9x63LO+foBQs31N6FIARVrfvnYkmF2+e8/sh92RLpAT2Loow++w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698097;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kHLZywTsZAKLRgvfxdfCZJOqF7Eh2MWorebcjzuhWEU=;
	b=1ed8CH7+52pQXtFnMCCNQTLIVrnTyXTqq9UkEAMSb5VzcCi8/mmX8NYkaxnMxZbhJTye
	 ljaWOJjdxvtVp6vPpHgfCcrhKiVkVajcQ8+YdrzST/KRmw4n1J8dDeV+yjzcjIn9SkBxU
	 vNzUzCEAsCLnayNmWKDE3WaIZhaoEw59W4CM4RduyzIcHl6+n5TFx9LF9CGYhtO34H+aI
	 8AHiykShZ6vLba+UrPnZ/7Jx6Ard2NrLm05mw36iA61KmHLbV+nTGv+nOIs8YCKBxritZ
	 B1D5m1RROrD/RdwDxjKPPQma8Jr32OgKWTEXmYFyAq/vOOGpXq7L/1HV3wX4PCBFR7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kT2qId1Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC27606A332;
	Tue,  3 Nov 2026 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kT2qId1Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E4D1F00919;
	Tue,  3 Nov 2026 09:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793698096;
	bh=kHLZywTsZAKLRgvfxdfCZJOqF7Eh2MWorebcjzuhWEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kT2qId1Zp9eYvDrck79F70FvBP101HDFX//4Pvj9xn3JTEnrEDayWXWHeI1D+Gdhp
	 Bp+b9GeK0b5cB4MoKfoSHG+0DYvcfXO8+B2dwfwFjRV953OF6TYp4VlxNDjQOYreUW
	 ufrDUKu0UxNYQm/29EmCnAgo/XBbtGA0NXz+FYICiQDftRU8RxNQU+7YXKMvcZ0A8a
	 reAxiFNwgjsjjUV2ivevXRhIqLxxTB8e1NsjrV0wyeSOZTgrTIqYWrLVu2q90+D4Jm
	 Tc81C9K7HqCCMb6nyk6RYK6J1ks3LuY1pfahYUNgWYZP/CqyzzZbvxDYfSxAesJr/Z
	 ispKMN6o3Xn1A==
Date: Tue, 3 Nov 2026 10:28:13 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: stable@vger.kernel.org, umesh.nerlige.ramappa@intel.com, 
	intel-gfx@lists.freedesktop.org, tursulin@ursulin.net, jani.nikula@linux.intel.com, 
	joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/perf: Unpin the context if reading its GuC ID
 fails
Message-ID: <20261103-charming-pygmy-elk-eded62@quoll>
References: <20261103080237.1126027-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103080237.1126027-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 08:02:37 +0000, Wentao Liang wrote:
> oa_get_render_ctx_id() pins the context before obtaining its hardware ID.
> With GuC submission, gen12_get_render_context_id() can fail while
> allocating or accessing the scratch buffer used to read that ID. The
> error is returned without releasing the context pin.
> 
> i915_oa_stream_init() immediately returns this error, and its caller
> frees the stream without invoking the stream destroy callback. There is
> therefore no later opportunity to release the pin.
> 
> Unpin and clear pinned_ctx before returning this error. Also clear the
> pointer on the existing context-control-offset error path, so failed
> initialization consistently leaves no pinned context in the stream.
> 
> Fixes: 682aa4373f15 ("drm/i915/perf: Fix OA filtering logic for GuC mode")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/i915/i915_perf.c | 7 +++++++
>  1 file changed, 7 insertions(+)
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




