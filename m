Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690844;
	b=ZqBrSq95uOmxTRNKPapPnzcbdGwuK57HMumLzdwlopjaBPKmGFksC7sf1v9sSrQp2hwW
	 dVdeDEOkLcBK+d0DOq7+gguNY1XRcrr/nv9bxwe8TMyf8HrZ10VzJiflFsL2g8DwDffK8
	 DZ08onCCJjTCM+8lT8ZmEjgt22l/3uYSmCO4gXxlvUs5DmGe03jvsLK82xGVGU+niahTB
	 BqZwltg2yfPjLTg0K1pwwFPKNxuDRwhlr3/HWt5b/BpAb5zMb3mt8pNYlJexyMFsJdgiz
	 SI/2kKRd94WTP+9lkmteQpBEo4Bj9GQS9VjcF/PGL9xzz4JqQC84Ni4RNiDSNUWrUFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690844;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xM3fZ0DeX/mIM0tXabGWnukqQCpCqfaj/WoRQI2M76A=;
	b=b+DjH39xcPCKMnw2A96Ypx9A//8gST7/0/0IFx/uItGhbQCsmClhnUuHTJVX40A19YfA
	 X+qTNXHs1JgHjBSHX0JBkMmLdiuZU0hI4HG6ihqxZXvcEyduNoBN/LjxQuMHA41533WIx
	 vlEa9f13/pRBDN+HUv/VP/I8akQ37Ha/v246gurLNAW7JiFoZ/8fijnb9ttzm7Yfr2foe
	 pmnMaE5yUwkPmsyCX6PL80nrgoKvbU6m8dIJ9f7P3CJdXqQUHqwC0ouOOndOXVXBrAT/I
	 rkJz8WC8+UCXpUh1gbCuArHmypm8MZSSpj/+UtN1rDZFhp61byxraC27lP79mBM61CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BHR1QXCP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDDA606D805;
	Tue,  3 Nov 2026 07:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BHR1QXCP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4011F000C1;
	Tue,  3 Nov 2026 07:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793690844;
	bh=xM3fZ0DeX/mIM0tXabGWnukqQCpCqfaj/WoRQI2M76A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BHR1QXCPq21cyEaTcSEtOMw/y9NQh+fLQxxtBdepNjhYEbM3Sh+rHoShJh7K5Zgh2
	 +C85UKOPVr1aNp81RealW7rDfru9iukd0+s1S20WpyfmUd1Qzittzh+lSSQqXeMjQ8
	 26oyxQFEW9PHYLDGzwrP6VkzmS9CNOJVoF0RS6qBqJ50k0yNIZfqbqVZva4wHzYgWx
	 ZgmKC/rSI7yCLfhnHF3EVr3J+J0x7WEHLGsgcGijy4AslEMs5WLjY5zjiEtZyIaVIx
	 KKUpbF78PtiM6xHgp97lvfj8T8O8y1ayCLem/7D1V2ZLk1Zs9aYZkv9L7D9C1D/zyo
	 cM5JyqMKWLKsA==
Date: Tue, 3 Nov 2026 08:27:21 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: stable@vger.kernel.org, zack.rusin@broadcom.com, 
	linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, 
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/vmwgfx: Put the buffer object when handle creation
 fails
Message-ID: <20261103-violet-goldfish-of-enthusiasm-1afde0@quoll>
References: <20261103071527.1091375-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103071527.1091375-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 07:15:27 +0000, Wentao Liang wrote:
> vmw_gem_object_create_with_handle() leaves the allocation reference with
> its caller, including when drm_gem_handle_create() fails. The allocation
> ioctl currently skips dropping that reference on this error path, leaking
> the buffer object and its backing storage.
> 
> Drop the allocation reference at the common exit when an object was
> allocated. Keep the helper ownership rules unchanged, as its other callers
> already release the returned object on failure.
> 
> Fixes: 9ef8d83e8e25 ("drm/vmwgfx: Do not drop the reference to the handle too soon")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_gem.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
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




