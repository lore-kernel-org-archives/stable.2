Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690827;
	b=RQATYkRI++SZiJLHRjFv4lwzGzsm/H2z2yR3n9ZXUMn/X4PpALXAhuiXEg8658GGqxPC
	 YeDyYZ1t5UH5Z8340g6Hi9bj18iSDFCZYdSz6TKQitTvIBvXT35jjBBJ32itUIC4gpQWl
	 l8wUW6Dl1U71Pcln0k9OLyyt1kC5lwY25bhjAdJkqHDmAGgmFCrlPeHtVwWLcKcWHtqRO
	 c92/z8NvZvg8l6qVJCphNe3OI3Nxj8HheOpBWnnTokMAQn6gTDZ7IiLVMf85lmVuf7/pe
	 CV16tfdPQIX/jl+2ma4l6Sb4GanxUGHZFdX0nZldW31Lip/Kkl0aaAAqTCt9OiaPqgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690827;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=V+/klBUcfcTRm8IMCJQU8L8tHCdvn3hjNDZ9Ft+EtVk=;
	b=eF1jbNCrUdPab2zFC6oCXaly4SLTAGpwYB6ImsnL00h0U+H1HhEZ2+AsYAjmxN9xn+a4
	 7Vo47+1FF8HtwZSEJAfuUG+TdyhHe3eb6XjVm1EqAVF7k4WyfGS2ORDCNgkBXx5GbXPM1
	 iu5/da89xswm8ii4z6MjO3MDmg5VzKZsUKgljyz2mRq4S74DQnn4GKJdkn/JETVsYVCSp
	 RTVK/miFW51Eza3G07Q6H6tBzH0bwqFfFoIRbvFnWQyyf9F+0Fdp/y/Uhu54vUtzLDOTz
	 NUtBsBue0pVLJvZ31DZvuYCAaLfaz4CMctNP7E3by9xDlebVe6/pajN2oAvZCY11ldg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lLIJ3wD5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830C5606A331;
	Tue,  3 Nov 2026 07:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lLIJ3wD5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C981F00A02;
	Tue,  3 Nov 2026 07:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793690827;
	bh=V+/klBUcfcTRm8IMCJQU8L8tHCdvn3hjNDZ9Ft+EtVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lLIJ3wD5Mh6L8SP90f75YzxQJ/RXZO/CeQ6MEds9Gzx0k85j8RVPXYUjGY4/0BPTb
	 lXyKHkwsSWIUMKuSCYilbTMWp6292pBWhX909gwASw2ba14boN5woGfSJN9P8PDqeW
	 KSc0IQx/hUu5pHnApZgIIBE1mTS+yZPQL603SsmHzo2M9hpFkCDN5ZssxA1/p8mkV/
	 LXiDGXyr7WqWiOSk6HJFr07zcDE64ynGUxeYtBovtHk9CJ8eHflojb98m0teWQdyzS
	 8ND+AeP+vZD23nnAB5HzCShKmG8Nm8x2PSKQrZRvzw3fSVRr+saxgh+Sn3yAHmBDev
	 Sv3hqcECB5LKQ==
Date: Tue, 3 Nov 2026 08:27:04 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: zhi.wang.linux@gmail.com, joonas.lahtinen@linux.intel.com, 
	zhenyuw.linux@gmail.com, tursulin@ursulin.net, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, stable@vger.kernel.org, rodrigo.vivi@intel.com, 
	linux-kernel@vger.kernel.org, jani.nikula@linux.intel.com
Subject: Re: [PATCH] drm/i915/gvt: Release GGTT MM if scratch page setup fails
Message-ID: <20261103-supportive-olive-barnacle-93590a@quoll>
References: <20261103065407.1070225-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103065407.1070225-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 06:54:07 +0000, Wentao Liang wrote:
> intel_vgpu_init_gtt() creates the GGTT MM before allocating the scratch
> page table tree. If scratch page allocation or DMA mapping fails,
> create_scratch_page_tree() releases its own pages, but the GGTT MM and
> its virtual GGTT and host GGTT buffers remain allocated. The caller
> skips intel_vgpu_clean_gtt() when intel_vgpu_init_gtt() fails.
> 
> Drop the GGTT MM reference and clear its pointer before returning the
> scratch page initialization error.
> 
> Fixes: 3b6411c2c205 ("drm/i915/gvt: implement scratch page table tree for shadow PPGTT")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/i915/gvt/gtt.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 



Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email, thus I doubt
   that we speak with an actual person.

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
letter), how to document usage of LLM and what you should not do
if this was posted in a good faith.

Best regards,
Krzysztof




