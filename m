Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704263;
	b=n6AB6x+eb+eghj55pKyb/A6Up+XK1lFxlhDFdPcGqhmR2GzFuYhiI92L47muYqyJOIK8
	 2htwvuXTjX4DHe+ocUfN4vrNyIjrmTI0rbzy/zYT29vGJqSz1G9e1QsXXB/3ZCPnuvH6o
	 wFC4Xvd3hWShCO4zYwqd4pAoctw0KeJBUImmYliPfoCVtqooUAGF4ZI/juCKRQu4iL4vG
	 rwOAjVqKO1ajgtFJGjr+JFHk2BZQLjq1OTTrpBdz652WGTXPA4pSVDbRGNWKtaPfDuHv/
	 sv5V1v+NLx34nqc/hUL0GdVzw3zgUkG+yOxSF7kMymhVYZYOfXoJnTIO6AhE0TZq/3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704263;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TpY7gfCybRj7+hCyHruI8lUkdXq2GT2C0QBLYpHMn5U=;
	b=JzNUErZCb7vmQHxX1BIAvNcYuTQcRZcqbluvehBP457x0NuugKZd9OcUsqoVk70Gn+7g
	 zCOg0I40dBeqf2FRU5px5SmpZhb5+YcJ7k00LN/1pFCNqOnEWcgkDiXtT3lTx7g7PLF9R
	 bx4f5uus6BHQutFfMZ8kfvh50umyiu15SW4ZHzwXfRbTfUceKVrxX2/e3izDiFPpsRiTJ
	 eVZCivsHP0gFIIN+DBR1Gca8EYNCpNYcgGVvawfEXmwpIDR0Lp58oaMQQxuwb16DKji6M
	 V9HWBQX4EMuoN+lD3+nHuVvMhv7F+K2suL7LgwZBefmCl2fdxyy5IsbgkliFYiQ3M8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cEzLaXw4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95566606FACC;
	Tue,  3 Nov 2026 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cEzLaXw4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2F21F000C1;
	Tue,  3 Nov 2026 11:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704263;
	bh=TpY7gfCybRj7+hCyHruI8lUkdXq2GT2C0QBLYpHMn5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cEzLaXw46GCElArUYrx2ojVrPAkir1oQf0DqjgF2UCOI5kSYG7Lb9zrxa5trV1XXj
	 svMUHNqVoPkpYBD6XO61ebJYHDsZ+wUrkhMIxpHs5U4s9xFWQgPRb2B0viyjRU77Ey
	 ji1x1gZRIqMpMApHcHoIhUySm2oRWb+kFPYGixlRe1R4IpH7MTmdV34n1atKwLY7YH
	 xtvdnawDaO3/ajig/4F3JKWtB6VDaGsoads3xxKxp75k+WjuQs5clAclcGfnrzU/XL
	 DXBRF2yhhAW8lFzrzMa3Y+GjjeRKZOiWy9wIgVaJjQpXUqMNWjAVRXJkh69m3xbYSg
	 Lj10Pu/NmXq/g==
Date: Tue, 3 Nov 2026 12:11:01 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-wireless@vger.kernel.org, Jeff Johnson <jjohnson@kernel.org>, 
	linux-kernel@vger.kernel.org, ath11k@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] wifi: ath11k: release the rproc reference on
 teardown
Message-ID: <20261103-clever-adder-of-culture-daa0dc@quoll>
References: <20261103102915.1341148-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103102915.1341148-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:29:15 +0000, Wentao Liang wrote:
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




