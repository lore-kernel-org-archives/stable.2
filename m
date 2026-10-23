Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778198;
	b=Y0gDZKzZVm73jqAutW7pBIT3zrDI03QraTaBMNjesNrIdbvKr5T0SiUyWe7iLtPlBEo5
	 xhm1kpkTS4SFwM86G/nvk/LTHPBfbzOaLEJeLamLxJG56oFl53ZQoPGuHEyxNC5vdpn1y
	 V5/az3DItwTlSzLg5A28rvgQN8MNDbQwRPKwjJfNavTp/8lK2Q9nQL/CVqWVBiHuzl1+K
	 bL+N8K1aib2NnIJ3qd+3qkSKPnOr6hIFbY2mB2S4Pq6a7Bh2Em0BGk+F/qbzEun+LTXdL
	 V7ZwTJMGkbajUT/UJIFKoj1qVejSvFNOUrdEzGfqx/C37pZW4ZKwHZI7W8Skm7/hjxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778198;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=3JqUDz/KAdOasSKkck14+ibRLRMRPRfN+Jw0cHcpO1w=;
	b=ALJvpVhgBblPEHhLK1lW0VZXNoBvNNYwULhPOZOzYeVUFJ3SwUAsHos3hmp4kFH8wf30
	 bSxHoVYEhdJtk05Zwjj/jdVdegBuyH7U3O4NX9YgwFS4LdOTT/nklqyAGZOXyRvQhv/19
	 KYvh/oMgb4L7fKNbyBM1Su0cQSOZ86dppoIq1RwdPEVc6jDIqb2fHlEsc76WGIBHVUs+3
	 EKaOuJsGcrKlolmH8SEfH8K/bp24nKarCTIXcjmJVa53+Q9Jey4nzQ8z2OaBXiGJgSC5c
	 Uhb9GPF+g9lhGW9KA3pWz/h7QdexTWFR81qrFfc7L5WRi0zJL+7h3QXGUr/8D+DZtsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fWNiA74J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D633B60A380F;
	Fri, 23 Oct 2026 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fWNiA74J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E2C1F01825;
	Fri, 23 Oct 2026 17:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792778197;
	bh=3JqUDz/KAdOasSKkck14+ibRLRMRPRfN+Jw0cHcpO1w=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=fWNiA74JByTG6Mk41hb+PFjk+9VQmCNaNAcF/3vAPYUpSgBZJrt/Mo/UYsadaVPBY
	 zGt3h74cS8XIMKbchXK+kxzjZb8LF5juIEYbQzE2o4NPF19qVP8q64tpHNL8OFTs++
	 2v/YMp0e2De+PAStL2vM4ZAm0Pfrfg104w2K9NLWTR5/G37kQ7iEQZJP41asyVwXsP
	 YtxwjPPV/5UFndSJfVUCdbC1CO4lD0zlJOmzNMcpEQE2OZHhIVnE4g/Dj1drba/tFL
	 6r1Rpzu1BQHFIKOy/m9CxnaL5ZPtsp38k8y/qLufKwJI8rsZ1rGRJ3vn08d0ISH+n7
	 fWceNmuLN337Q==
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
Subject: Re: [PATCH 2/2] spi: tegra210-quad: Unmap DMA buffers on transfer
 timeout
From: Mark Brown <broonie@kernel.org>
To: Vishwaroop A <va@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, Breno Leitao <leitao@debian.org>, 
 Aaron Kling <webgeek1234@gmail.com>, Carol Soto <csoto@nvidia.com>, 
 Suresh Mangipudi <smangipudi@nvidia.com>, linux-tegra@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261016132520.3723412-3-va@nvidia.com>
References: <20261016132520.3723412-1-va@nvidia.com>
 <20261016132520.3723412-3-va@nvidia.com>
Date: Fri, 23 Oct 2026 18:56:12 +0100
Message-Id: <179277817254.3909521.4791519264133839402.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=broonie@kernel.org;
 h=from:subject:message-id; bh=HESaku+2jEMVHtbHnmgS/169+bHBBmzIozynVN0h4Js=;
 b=kA0DAAoWL+9zsLPQOIkByyZiAGrbn76jHCM4hIndnOYnjxzn8i6FQpU0ALKI/lFkPZADpf0c8
 4h1BAAWCgAdFiEEXmoL6X9066wOwaGGL+9zsLPQOIkFAmrbn74ACgkQL+9zsLPQOInrTAD+J16R
 3nhC8HO2lHEH4xxU1ibriHQW+tZHAA/qIT1RCnIA/j12yPLMVsakk/Wxzy6cVWMfIbXc+Q6s25U
 J/53LOhMM
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> tegra_qspi_start_dma_based_transfer() maps the client TX/RX buffers with
> dma_map_single() via tegra_qspi_dma_map_xfer(). The matching unmap only
> happens in handle_dma_based_xfer(), which runs from the interrupt bottom
> half.

> index 4a5933d8112cf..b77ad6990e7c0 100644
> --- a/drivers/spi/spi-tegra210-quad.c
> +++ b/drivers/spi/spi-tegra210-quad.c
> @@ -1488,10 +1488,12 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
>  					dev_err(tqspi->dev, "transfer timeout\n");
>  
>  					/* Abort transfer by resetting pio/dma bit */
> -					if (tqspi->is_curr_dma_xfer)
> +					if (tqspi->is_curr_dma_xfer) {
>  						tegra_qspi_dma_stop(tqspi);
> -					else
> +						tegra_qspi_dma_unmap_xfer(tqspi, xfer);

For a multi-chunk transfer if handle_dma_based_xfer() was run on one
chunk then the next fails to start we'll end up here with a DMA transfer
flagged but nothing mapped.  In that case we'll get confused, there's no
active transfer to stop and nothing to map.  The transfer needs to be
failed on a start error, or the cleanup here needs to handle things not
being mapped.

-- 
Mark Brown <broonie@kernel.org>
