Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702467;
	b=GjsLBHyThNl2H1tPY95zYC2VKlHAU4Sr++qqf9Suzj+8+ZwqvH7LNlgviknHfy4SByZn
	 TAchcUxFjKrP2k1Z8ybic4jw72tdQcrtdN+SUNBgtPUuWBV+ueCQfrhk3ePduDvkNurTU
	 ZH5BC14cgoLfjDHodGNbZ2oC1D9mCylTKH7lqNh/v58abxlqWIDqZAJaTnQ2aw71ho+q8
	 VuqwjpVSLvsSI8GvnnvSL+wEwwD6HyGyKJ5vwfDYDZGE8ap+/fKMuj17Y9LFvgx/RgpvQ
	 w0qWOjHVUt1NQ4FKO9DbU0R71yDkoZlirF9rVpqkbEPmA7LSplsrV/cK13Ni2op4vzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702467;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8nIUAdKhQOdU5bD0Ebix2Rj1z+5vhf3MK7JazPI6O1M=;
	b=vONFboX61U4bAEy//3Png6tov+yVjEn+NXmkAvv4vfUUYslQTyosT1RDMfrKlu2LaHrx
	 rvvCB71G784CyRLIRmKWnDojVyoRGwibeBe3fI6kwHaKrfV6xhLVyr2OuDJcl1T6lGF3+
	 LwkO970YePX8Z73m66UN+iFCZuocbK9j1zqBFRKucHUCT/Fa+/KMOVXRoiV37LVk5Kln4
	 tSIM7g+0KUxI3sMg0nMT0Q1+E262HU6KOqQuQhOitLHwUz7ikP3YetCN2KUr02DsF1aHf
	 JPIh1wEcjk1953QOull9QDPRt1BVL1k63zf83RefMryXqNFXNb/5uqylhl34Y/uLp9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PEKbJfYv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954526078F3B;
	Tue,  3 Nov 2026 10:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PEKbJfYv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE49D1F00A02;
	Tue,  3 Nov 2026 10:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702467;
	bh=8nIUAdKhQOdU5bD0Ebix2Rj1z+5vhf3MK7JazPI6O1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PEKbJfYv0gQXOfZZKZgDdS0Xx5ADDeTDUQg46LyAXCi0aBZAYa7GhmO8hOkC2p7dX
	 5C5O0j+rfTmjTlXSr7QRAbOfu66F7Zt5wmSxzn9iKBGyMF+cYY8EY908q3tScIltod
	 xbwED2+h5Nabfceq8hjmD8tX7hbXgGTQ6xpLjyhoQspuZOualCNlVQUGUJnlUAJgN7
	 wVgydqMcQrAUDYOyENhucAc1Yx18K84Rgxf/0Fb3YkNtl8vuuEz8Ni10yW72bdTZcP
	 xa1VYJMczhbO9NvGFetMUgUxMrSgYJX63gogW+TdRO017GJeoLBXlBkqF1UcNgPTlK
	 YRC2gUD2q8XPA==
Date: Tue, 3 Nov 2026 11:41:05 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, ath11k@lists.infradead.org, 
	stable@vger.kernel.org, linux-wireless@vger.kernel.org, 
	Jeff Johnson <jjohnson@kernel.org>
Subject: Re: [PATCH] wifi: ath11k: release the rproc reference on teardown
Message-ID: <20261103-complex-kickass-reindeer-f5a0fd@quoll>
References: <20261103102859.1340835-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103102859.1340835-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:28:59 +0000, Wentao Liang wrote:
> ath11k_core_get_rproc() looks up the target remoteproc with
> rproc_get_by_phandle(), which takes a device reference and a reference on
> the remoteproc driver's module.  The resulting pointer is stored in
> ab_ahb->tgt_rproc and never released: ath11k_ahb_free_resources() only
> tears down the firmware resources, and the probe error paths after the
> lookup jump to err_core_free without dropping the reference either.
> rproc_shutdown() does not release it, it only drops the power reference.
> 
> Release the reference when the AHB resources are freed and on the probe
> error path, so that repeated bind/unbind cycles no longer accumulate
> remoteproc references and the remoteproc module can be unloaded again.
> 
> Fixes: ba929d6fe31a ("ath11k: Remove rproc references from common core layer")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/wireless/ath/ath11k/ahb.c | 12 ++++++++++++
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




