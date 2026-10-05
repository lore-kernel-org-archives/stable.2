Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3FA4CB8A6;
	Mon,  5 Oct 2026 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214992; cv=none; b=kGzqAYxQZ6CNIip1wcd9SJqeoEMBYgR+LKaNHXpPWuwtferGeHHIRKS7ABzq9/Kr+CpKgiWqbTgOH/kFrpm7oKgxOMIrOgCBKLMOQ+KuLC0zwO6c7Dfs3coQdJ2Sv4Ti92g+SIkwHsnsjwEyQd6TNEmBfkN6EsR9eM40SMnkgK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214992; c=relaxed/simple;
	bh=GXAQZUSWpy4hKJwe2mGmv4PutXDENGVjexFI2E2MPYk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XQmraznhjjW1ooqYzpT3NvqMldKSis1RxVHUimTSBX5OumMBo2FbzLOEMpcGBQFBhSbC1rb33GcHSuI94sla0s+iyMK/Q6fXBgogNX/JSZq5DWlybpSAbGr1dlEHNpNiZLIod/n/ZynQSebBJgi5L0xr6K8RR6/YGstDdDbITUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sx4/jEcs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sx4/jEcs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7146A1F000FF;
	Mon,  5 Oct 2026 15:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791214991;
	bh=0gYw3HiLxnLxVmIB/d2DZS1XkezGBNZsq55r+hnmTl4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Sx4/jEcsnd5SS+JfzczFUpSgaTqrZcwsJTCDtOH8jwvEYHBPA1ZuuWk1WSztbCiwG
	 5aOSovAvIgLmXWW0E7cS39MbTxRh/vNn4g/pRfKEuhJaA9ldLiFmnxJTBB4JW4vCyT
	 NjQkW4NcVMai2F7QdSdcNulgeJCBDfPQP8t6c2jg+Uf40RvfxsE/G4tg2WT8e48SsY
	 n33YS50hQwO19Nc+RkrEr/hU/topY2rC6SgChKA4UQlBJiicrDHc8PW7wl4AYF13y2
	 maVH1NtbDyqJTP+peyZL/vuVTazTy28SZWieQkoYQJfudXP+StxbL7A4s8Nda51xIK
	 t0H+S72Lw4kXw==
From: Vinod Koul <vkoul@kernel.org>
To: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Frank Li <Frank.Li@kernel.org>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, "Claude Opus 4.8" <noreply@anthropic.com>
In-Reply-To: <20260905062833.272484-1-diegomancera.dev@gmail.com>
References: <20260905062833.272484-1-diegomancera.dev@gmail.com>
Subject: Re: [PATCH] dmaengine: loongson2-apb-cmc: fix descriptor leak in
 prep_slave_sg()
Message-Id: <179121498909.358863.17544428904174593757.b4-ty@kernel.org>
Date: Mon, 05 Oct 2026 17:43:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sat, 05 Sep 2026 00:28:33 -0600, Diego Fernando Mancera Gomez wrote:
> loongson2_cmc_dma_prep_slave_sg() allocates the descriptor with
> kzalloc_flex() before iterating over the scatterlist. If
> loongson2_cmc_dma_set_xfer_param() fails inside the loop, the function
> returns ERR_PTR(ret) without freeing the descriptor. At this point the
> descriptor has not been handed to vchan_tx_prep() yet, so nothing else
> will ever free it, leaking it on every failed ->device_prep_slave_sg()
> call (e.g. an unsupported transfer direction or bus width).
> 
> [...]

Applied, thanks!

[1/1] dmaengine: loongson2-apb-cmc: fix descriptor leak in prep_slave_sg()
      commit: 4bbfc1d7e56134336dd1f792f51ee88a600a27ad

Best regards,
-- 
~Vinod


