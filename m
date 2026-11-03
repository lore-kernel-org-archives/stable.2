Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701629;
	b=qagZ1erUcku9Qub3clA1wYVFmY3Ee4I4PUQwzJ9dqYu7RAcaMoRWUbysznMcUPpFmF/k
	 74ujnfo9JZNnOkTekWFM+HtY1Fw1yMS3ae3IvndRvOKOiCiuyHHTv4LQcbQusmxb3IR0J
	 PSAevZ2MgJRBSVJPFpNKodTd2pZeHCh4ZFnKDTUjGnMt6UTE5NUstFqFH2QtCbOBo7DpH
	 j+jXvOLMKd4PxwEiralZZZSROwtK5l8Ftn4eeNWw1HPynAqPA+P/gzsebLRG4xNMes/Pb
	 jqok/WMZK3wPncPd6w4ensexsSwqaudWNvdX8jTOcxEI8uCx1SY6Artkos1EL+R/33w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701629;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5JCgmnnBV7ODGkM1qXDPR9WPLQTgtUl6RjPyn6nE4gg=;
	b=tSKabpH08ysT2XXoGJCiTC1MwSrlruJMU/LLNkAyJtJQdP4bMSPkgd8v78/g+0D2SMIh
	 ex/hHFD27y6giMm5lwiU+rKrmXvewPIOVIt3KSY1cG/D3KiO7yvwZ+oSOFup/LP6pIKsL
	 OJsmcp0Fnh2jxPhhBG+dA3ulnd3MbeYAhzID2BzdITcoJ9WRXXd7D9FbGpvNDEMpOycsy
	 K+aijB2R/6ScW0kzMhDIeeDfzMHq6M0iEJarQ71saMxJF/NcF8NTOZZd8TmSRSQIU1JYn
	 4Ap9q7VzqhVjx59Uxd3MknqOjti+jKRTLRZATExTPUU83lmmIqF33lqC8yZJtrq6e1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kW/9Nqnl";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B87660850A5;
	Tue,  3 Nov 2026 10:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kW/9Nqnl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125B91F00919;
	Tue,  3 Nov 2026 10:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701628;
	bh=5JCgmnnBV7ODGkM1qXDPR9WPLQTgtUl6RjPyn6nE4gg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kW/9NqnlCo3bKlu6H7GShjdIrl2ZuQjd0jl/USYagMnaMCukaur5fPw1Zt0dTzIFF
	 8N9o/UYYQcuDD5fFf/4Za154D4g/vCE88R7+sUYXSD3oLBcB+1wp2fAfrntRnfwBvK
	 L3JCWGVm7Ala9fj73wbM46izIadxvYRukOEejFBDlZHQn/831Bl0ZO/yzkzR9rDghh
	 PY0i6acxuXXa18jod7zvUIyzzq4uqfyG8OKIrn53ucoVhJhFvCMjnWMI+FSiVQVpzn
	 FCZPq6UgnZdnJPXNCprsweuFmzSZdwghMPJ+HA+eJjaGs+gbwebCsrFKDNIEOAn276
	 rFyHyzjp20XLA==
Date: Tue, 3 Nov 2026 11:27:06 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-mediatek@lists.infradead.org, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-arm-kernel@lists.infradead.org, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, stable@vger.kernel.org, 
	Matthias Brugger <matthias.bgg@gmail.com>, Bin Liu <bin.liu@mediatek.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: mtk-jpeg: Release the encoder device on job
 completion
Message-ID: <20261103-accurate-aboriginal-jackrabbit-dc2ddb@quoll>
References: <20261103094613.1289270-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103094613.1289270-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 09:46:13 +0000, Wentao Liang wrote:
> mtk_jpegenc_worker() resumes the component device represented by
> comp_jpeg[hw_id]->dev.  When the job completes,
> mtk_jpegenc_hw_irq_handler() drops a reference to the master device
> ctx->jpeg->dev instead of the component device.  The component's usage
> counter is never decremented, so the component and its power domain stay
> powered, while the master's usage counter is decremented without a
> matching reference.
> 
> Release jpeg->dev, the component device that was resumed, and disable
> the clock before dropping the reference as the timeout work already
> does.
> 
> Fixes: 934e8bccac95 ("mtk-jpegenc: support jpegenc multi-hardware")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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




