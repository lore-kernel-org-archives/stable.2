Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704255;
	b=ealNev3pRJmrEz4LOTxfXB2SoFoZzu0mu0KIUpDrXgAPfUCX+WgxZw6CkKpch45osB0g
	 d89UkuL6U2hyb37GxELVhOgeo8Wm6omVzesWMZeiiouzQ1fcBdCXrfD8vB8onf3E2mDY4
	 V1o+5dwaJo30KtY6xpwRXngvP/lbFACg/JJM728lQZXk4DwsJB1Ob/WF2iEOF69LfiBdR
	 /jeTDlFfG/ISQ/vsu0924jIaLZNJSeMYSVCoELM+UfJV0pPChsEPE9ld2hwp0UojryaJI
	 4HQ8+TYRxoYo1mMmdqQr7wsfnRzIIsqDOkRz3+mUNHO+Q/JY+z94IpoeMU9sD1mWWHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704255;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/pg0XXHZscRJVa2E7zhHFbdQCZ7KHQ6g29HtpeDbe0w=;
	b=DZ4UsyolxkYQZPrZSbk3FZu/B68JkFDh5eI9kG9HLpAgZxU7O8neI7TYrIALduLxbQFQ
	 sMvIKr7QH0H5FUXXse853gEA+AisUTrZc3o2P5PseLHysFxuLoPqjtpwGecv2hFwBl9n4
	 BCM/Nxk+xScdJsPgW6bCQ7gqACOVGTudcvsNx3xvKr91t4K/0xP4BTyis3g6nRwRVYD7x
	 IEVInVN0BbMmPjBQDUeQLDzueINA27GLiCHOaDZzndgktM3Ii9BeBD4jN2N/3txxkkidX
	 aP4kt2HH5c7JTwhtjegbTvuE4RNW6G6DcdSy40nDjMXS/AuoB7BbYKyvIuBrq1uLl1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DOo0edod;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B45606F7F0;
	Tue,  3 Nov 2026 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DOo0edod
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44351F00A16;
	Tue,  3 Nov 2026 11:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704254;
	bh=/pg0XXHZscRJVa2E7zhHFbdQCZ7KHQ6g29HtpeDbe0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DOo0edod+NpniumTKGzUqE405H/LrT2mPZzUMpVsrVCDRuUxwO7+M0oC1ghzTi44F
	 bR4kgVp1NJHyCM+bwqQ1UbRA6YtUZsDt5WCz8IDcGQu9dhDG9+1AcMCZ3Se22S/bWY
	 PnZrM0TneTHyzePiMybL9jJBIY4OBWLO54gd/mnWjZ2AWxpqq0tHOdizMDXGL2tqiC
	 zQYOtINtIYphmmvs6akZdMODtZT4K1HGdkDPkECns/876cv0/KL7uF7wDHAjI59RR7
	 TVp8DjCdR6MU2gybor6wEzaDFvYxwDYyPDYG5OEv4vPC6NuTgs7X6Kq8PmdDgaFf+1
	 zBMkT13VT2sAg==
Date: Tue, 3 Nov 2026 12:10:51 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, ath11k@lists.infradead.org, 
	linux-wireless@vger.kernel.org, Jeff Johnson <jjohnson@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] wifi: ath11k: release the rproc reference on teardown
Message-ID: <20261103-loyal-carrot-vole-8e4ee4@quoll>
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




