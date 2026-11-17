Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794956677;
	b=ra6QiHhgDI7RkJ7sSwXqf8IHgfBBUb0VsooEURUpqN1w9VyErDLH8gSosPK8AvMHuVTg
	 mtkfbAn4bRGFWb2jjq/DHLB2kjZRXh21SfC4H+L/5+YEP4T2XzXQXbn0PxT1m1TbwUBSW
	 r0ZNMv6pLdmJDPQQhc1lz3/41uw7z0R9T8gWPsb2HMWaONhbYftyq+RlcEW5IAAPvs6g4
	 qx4n2Tvio2cPIs1zrQec5Fj6/6IcaXAfUC/uiH6nQLWB/L6bGaETZx0Icse4GRDU2VIlW
	 GGnfqjuMQK8Lcnvk8v2unN1LYAWU6sNUiL9PA+rtN9+BxdnGSS2cdJ5f0mYFGpIJIyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794956677;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=NpQhc381XiJQ2fH83GjkO0QvX8xd4FEwf5E14MxfCaY=;
	b=joRgk1h4Z+LjWJRIMKK13yic/P057jyFimPaVhKdtiMBoopm1oFZN9lW+GX2tEjIf5m4
	 cxyoIP2bJLkfG9rGfuCS5gcZtLzycLfRfRUF7akpGfNKsKKjcFkh8BqCcbZVOfqM+H1za
	 IsoRwJaCjnLwa3KtZoCnwzRyE1lvqJqZU5G4LnrpwIhBjz6QLg7oe+4Ii7mc7GJ6MoI31
	 cxt0dd94UQ2zC61fx829Hv6sQVTjBVWL/F58h943nlyKoi5ZjuHdi0bo0lAy93hzTmZjv
	 6gfubuQPVUfvH8NI0mAqV1HXwM1D3FRSLzouAw8CSx19z4ty7XobQx8kThR2g1414Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YbWhNvws;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B8A606A31C;
	Tue, 17 Nov 2026 23:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YbWhNvws
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369851F000C4;
	Tue, 17 Nov 2026 23:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794956677;
	bh=NpQhc381XiJQ2fH83GjkO0QvX8xd4FEwf5E14MxfCaY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=YbWhNvwsaIj18DW+pogt8GI+vju6DCg1lXO2FTzH/nE6fSIKoHigtpnAIdMxLT2Oq
	 JSmwFacANLecgpfE7voYDdkBpgXXHjXlZlCJsaEvEvFwIC/oZnL43q35NZuQBp25V5
	 Ymfzf2YtGR2VNHXJHgbqE+P9YfTn+M5mYN2oLvENQKiy5fTjSRkVJwEPcXzzdt9OTu
	 fI/GQfCwVr85map0ftHa71RMA+jNCaU8pAUSzz5mLt8AQdKd9rVMDEJxcW90GPg9Ug
	 S+uHMOz8LsrB9x/yldB2137mAB+p0fslaAle3Wwy2N1VDXUKrRRaWUU9H6tJZbl80O
	 VppkNUiQdg4BQ==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Marc Herrero <marcht@proton.me>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20261116-q6apm-fixes-v2-0-ea89fb43316a@proton.me>
References: <20261116-q6apm-fixes-v2-0-ea89fb43316a@proton.me>
Subject: Re: [PATCH v2 0/2] ASoC: qcom: audioreach: fix S24_LE playback and
 route mixer disconnects
Message-Id: <179495307219.2707353.8339502612153999902.b4-ty@b4>
Date: Tue, 17 Nov 2026 22:04:32 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1652; i=broonie@kernel.org;
 h=from:subject:message-id; bh=5Z8ABWEC5xPS6lG2iuk9aWLFYo/9y6R9jHXMcCTNkGY=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLL+3G3c+c7UXefvnCbtL94ti33Y6pveJDDN/S5tNE0nZ
 Z5Us9GVjlIWBjEuBlkxRZa4LO6X9SWv1/AdXNgGM4eVCWQIAxenAEykKI/hF5OTu1DCuULzpLZp
 aTceVL9a8uf/m+aVHcu2Lm4TvZq6houR4YjCteNXZny7tmzHx7cfrAu6RIRnzDq2puuyug2v+dK
 U/wwA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 16 Nov 2026 20:16:19 +0000, Marc Herrero wrote:
> ASoC: qcom: audioreach: fix S24_LE playback and route mixer disconnects
> 
> Two AudioReach fixes found while bringing up 24-bit headphone playback
> on the Radxa Dragon Q6A (QCS6490, sc8280xp machine driver, WCD9385).
> 
> Patch 1: S24_LE was described to the DSP as packed 3-byte samples, so
> the ADSP audio_process crashed as soon as an S24_LE stream started.
> Using the 32-bit container size makes S24_LE work.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/2] ASoC: qcom: audioreach: use a 32-bit container for S24_LE PCM
      https://git.kernel.org/broonie/sound/c/feb416ba626e
[2/2] ASoC: qcom: audioreach: only disconnect the route a mixer control owns
      https://git.kernel.org/broonie/sound/c/562b2cc2aa88

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

