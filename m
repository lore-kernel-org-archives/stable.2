Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701626;
	b=TWTqnBpdXkqvQRcaFyOB6GFCIeStoS4qSdY8b27mK/dg21ZihSmaqyEjgr90JLmNT8Zw
	 Go2XYmWEAB4cC+WdiZT0+2rVcmpk7OBy4neNJRnCppCS/puQkgQqkHVsUEDpfqO6f2oyx
	 VIC8SEqbPMWDdu2wTrY5wRegAC0k0k2x4ElT70cHg2S1bhpiqsW+yrdzBX0HXbX5TRbux
	 N8K9wcSsTE5d3cjCj0S7st82VLubRc8esJD3SvNcghxn+FDuiAFtiop0aZPYIjtje3lT5
	 cFV1rBAPYBo8ol1pxkMed4zBZU0xYJr4mMqdxCBlkXHVy99A2nyGrVrkDChyycdFY5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701626;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wGJCpB30C0eoXg6rT049KGsaSsKMI6A0wimQvcJwM14=;
	b=aufrBe0q91YInFxOsy5aVbHRTbQMfj6niIOsI8o7nHC+QknDvwnb4sF9PIv7EuhmU3fC
	 Vj0/giVG4d3JVI+bH2Co4PBy0LzddYrlxZC3Eck0qmLz8+Y4K+Z+QaLIX1NNGAg4FW7uR
	 +r9+FF+Y1agZHGVHzxKeRLPPjJT2L3WJ6FgrRIvdHEA47niN04XipUXvyOHtSkfjaeNtY
	 AZWI5U79GDR9v1OmeR4ZBVOV5yHYR2Pr1aFwkcDYUMdm1sA4DfSAV3WitqpXylZYQs/eZ
	 jQ/Q8VkeCqfgJZdHxXlE7SGuMjaJVXGWNZIdcFqHzGpYczg6BbHbo97yqpOQD37MrhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LnGkaKwm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE116072CB8;
	Tue,  3 Nov 2026 10:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LnGkaKwm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F80E1F00A02;
	Tue,  3 Nov 2026 10:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701625;
	bh=wGJCpB30C0eoXg6rT049KGsaSsKMI6A0wimQvcJwM14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LnGkaKwmU2Pgj6dYUxKTioOxMCmTkev14EfBkt2mMQyiPJYAGSkiXfFFx+20EIQP3
	 3cC46g/CkFt9dMpAh16Tm7+DVu7UOoY6SyopUw9YN9GFbcojCfIjRr5GeBUD5NueGK
	 t5tVzvYLFrSYO6DAKEchif8wL+kkauU/IPbFGSm37EWjhJNHDzqo4d0qGlxfXwFhmj
	 jFwoplUEgxFnsJmzt0tVHo9QVN4J6BqGSt2ELcQXQ32//TD/8WH2gxPlEnDqK7nz9f
	 eZwvmjZKKiIj7H2klj8Oj4B3y/wTZjOEZOffDIgSDjdsSQ+MIdgEV3k2QGTPBuSY9l
	 hMWrPOP+TV9gg==
Date: Tue, 3 Nov 2026 11:27:02 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org, 
	Matthias Brugger <matthias.bgg@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Bin Liu <bin.liu@mediatek.com>, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] media: mtk-jpeg: Release the decoder device on job
 completion
Message-ID: <20261103-refined-lorikeet-from-ganymede-ede5ad@quoll>
References: <20261103094612.1289250-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103094612.1289250-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 09:46:12 +0000, Wentao Liang wrote:
> mtk_jpegdec_worker() resumes the component device represented by
> comp_jpeg[hw_id]->dev.  When the job completes,
> mtk_jpegdec_hw_irq_handler() drops a reference to the master device
> ctx->jpeg->dev instead of the component device.  The component's usage
> counter is never decremented, so the component and its power domain stay
> powered, while the master's usage counter is decremented without a
> matching reference.
> 
> Release jpeg->dev, the component device that was resumed, and disable
> the clock before dropping the reference as the timeout work already
> does.
> 
> Fixes: 0fa49df4222f ("media: mtk-jpegdec: support jpegdec multi-hardware")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
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




