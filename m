Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690820;
	b=2Wp7tR2zOd0ZQvA12SGAmWwkH3j98CZJrTQ8DRnoXuIBR3uLCbWD95VkD7C7fTJ2RLJk
	 xFeBXy2u5AxF7Iy3QuXzAqliJFR9HdH7e2lYmPiV9vCquGLzZxXTBADXKApk2i8icdwtu
	 AHeb+6TLbD2uIgVfd1ruYUKY+xLSnO4+Ra1Wg4sgJQ3UoBRxSHe41b6nU+M40YNFF/hcv
	 YEeaveRoxw5PTItwzAZh/Fdt1ihidDJ77f30in4vc/TBqgcMu9mCONFkm/K/ve92fY7IS
	 C7dBkjsiiP3Nr5nBnkJumvdLE4TSDnQCEnyyarYN2e7VN12xPBb97cQvKwOhN7Wq6DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690820;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=G6WXuYVuFVaqWLX5G0w7v21yMWKT2qQz3bCPmIaySXM=;
	b=fyOcVOR09OVrdYAP5rTbKdMHtBCHbX45R2CRLXF79Zvw+aqIWgg6tps8VvcbxFTX1D61
	 Z0B4zpHuAJ4bsRxFKSSmKvklI6wLh0e65YIBaTTSrtWbyhwSnvM+u/XsT+DF0jOhk3Cm3
	 Llru/8Sk9epTAGld/PH6wZB8HGaXzlOdo+/+Zz6vJwjuTBdHSIvbpNb0pF4hy23gu54oF
	 bX2Dcj5lF9u8cx0OCvXRJWCJPzzUI1h0UqVNwv7ZwJ5qAjSnpWKIjXyg0rjMlRKvgnKuN
	 j1kOVAFmO38nE4xtjj+43elPNnBxLAa1kUdYKTr7jpA8ZdlaGF7B8MOvlDnA6RmQNSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FI7wUr13;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DC6606A329;
	Tue,  3 Nov 2026 07:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FI7wUr13
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6B01F00A16;
	Tue,  3 Nov 2026 07:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793690819;
	bh=G6WXuYVuFVaqWLX5G0w7v21yMWKT2qQz3bCPmIaySXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FI7wUr13qUiCZjI5Cfxbb+wytm4cVV3/lKY2i+xGFDsEoJWw4xuc0SWfVMyNwCQli
	 GfGk87l4VZqMNz1NgrcnMA+ugAdGCVibsvTbAcLcsZkgB6WR3W+HtfS1B0ko1473Df
	 6X/x8yPB3FoSRWnPZBhcYoX+q2NEWe/ssJU/8lG8y+weFcwW9kyefWtaCqG/TK1Fz6
	 nkpEPgBVJV2Cv/rPCwAGimB03lq1z2pQql4PKNj9YKEYZytLgkFlKTmZJ/43jri9ac
	 wE2n2fXTCW8aYJlquNKwpx2umsCtpk8zxXTlWVXrzGTBkP/1GogeNATFEq3ypP1dh6
	 3riqd62KwmdPg==
Date: Tue, 3 Nov 2026 08:26:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com, 
	stable@vger.kernel.org, thomas.hellstrom@linux.intel.com, intel-xe@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, matthew.brost@intel.com
Subject: Re: [PATCH] drm/xe/pm: Balance the runtime PM reference when ioctl
 resume fails
Message-ID: <20261103-cheetah-of-inescapable-engineering-1766dd@quoll>
References: <20261103065810.1075142-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103065810.1075142-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 06:58:10 +0000, Wentao Liang wrote:
> xe_pm_runtime_get_ioctl() uses pm_runtime_get_sync(), which increments
> the usage counter even when resuming the device fails. Its conditional
> runtime PM guard only runs xe_pm_runtime_put() after a successful get,
> so failed resumes leave an extra reference behind.
> 
> Use pm_runtime_resume_and_get() so a failed resume releases the usage
> counter increment before returning the error.
> 
> Fixes: 23cf006beac3 ("drm/xe: Runtime PM wake on every IOCTL")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/xe/xe_pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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




