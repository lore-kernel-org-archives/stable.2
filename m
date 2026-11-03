Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698102;
	b=sEPouEbJZLYfUHInb22UmgNIlXF3P2RG/gb1IWG5PYQAkQhSRyy4S4BX4Li8D2LikKqS
	 U7S/f+JOE2KsVon2eV/JRvKyHhg7QgRJdXaAqTvvJBiKbJ86AlullAkpB68c0ER3puBvn
	 TYEDFh6MDao1aClS1oGmZ/tg/jWXKHnSuAVvl4zk2PhYQ/wys9sG8rkWWAFpNDo/F+V+r
	 2JgPjpyTlKwVgHDy8Ge2DNvx3SUSVgux5NPhhTNd0bYe9zQraLHAT6XUqFJm/w6XEbpoZ
	 M08V+j068WkU5L/XLVVDj8BNL75uePUkcMozoQj1q1PoD+oY9lNQJtGFQjvsP7mgtuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698102;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hH9PlPzoP3U94hf+L9Pm/adhsp5Uc+pQd7zlXDgtirc=;
	b=2NSaBsc54XQMF1bWQkNAjRdG+5uPcQRWz/Kf2PAIkd+BuwiDEccmLDCkkSBQGunkuglq
	 fiMyeYIoV3RoNureEZSeU8TjlMpVpcj0g7MMQQycgYiVo33UWATgwS562tJS0gp8f7S5/
	 2/mlCIFlNDHXCESXkt76rMGGbU9GylpP9a+eN38dh4QkRMfUrzMKJFhg/MH6ZiYx6c4Hr
	 XqWOFFIXeuVD/KBQ8JJ0rkvV/vg3iZ4s5UMMyxhEF+Mu3lQK4Ch5OQmr/xZcytpBU/i2M
	 EFNjKFwvTYu8CUXrHOCqVLmf6UK7yMjfPAaFjIv7w4uPM/c4V+P5H8l6QyOPAtgMmuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FqV2AiVf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9793D606A324;
	Tue,  3 Nov 2026 09:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FqV2AiVf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B350B1F00A16;
	Tue,  3 Nov 2026 09:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793698102;
	bh=hH9PlPzoP3U94hf+L9Pm/adhsp5Uc+pQd7zlXDgtirc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FqV2AiVfZgk8d3wFCCs2c1ayH3IZli6QMy4WSWgnRLuQu+g2IGS5Ij/gQg5c12CS4
	 +P3x/SpT+HIC1yabLkjolRfIDROPYOtebAIAmZLs6UJoP07bIPR8hxif1uiWXMBh2E
	 wgjJ4qsuh1Z8fz8ZPdD6HJVJ2NKHpx0P3ppkcp42+8j/pt3aQiAxYyE6GgzEp02koL
	 QAYdH1I4UUFP7rnwMK0mLZ7LJpnvgdaGqbzwMJS0fC5kNqHCNQXtcn3w+QZeTd0KXL
	 MN+npvwCZ1L+vGf3A2l4lfA8UHhMUrdkObnwf8wJYgjemrzdo6Pu1j1q3cMmia2q0w
	 B1DtWZ4CWlMrA==
Date: Tue, 3 Nov 2026 10:28:20 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: jani.nikula@linux.intel.com, tursulin@ursulin.net, 
	joonas.lahtinen@linux.intel.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	daniele.ceraolospurio@intel.com, rodrigo.vivi@intel.com, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915/pxp: Unwind component binding if HuC loading
 fails
Message-ID: <20261103-silent-strong-wren-74d8cd@quoll>
References: <20261103075914.1122975-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103075914.1122975-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 07:59:14 +0000, Wentao Liang wrote:
> The PXP component bind callback publishes the component pointer and may
> create a stateless device link before loading HuC firmware. If HuC
> loading fails and the device is active, the callback returns that error
> without clearing either resource. The component framework does not call
> unbind for a component whose bind callback failed, leaving a stale
> component pointer and an unreleased device link.
> 
> Clear the published pointer under tee_mutex and delete the link before
> returning the firmware error. Check the error before the suspended-device
> shortcut too, so binding failure does not depend on runtime PM state and
> PXP hardware initialization is skipped on failure.
> 
> Fixes: 087b681805f1 ("drm/i915/dg2: setup HuC loading via GSC")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/i915/pxp/intel_pxp_tee.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
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




