Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608265;
	b=WxEnnLOlZckMkE4anVUbSehUkGGb5sgkHtcxfw/fJGpxlyG3DzQa6crYAhvo7g071bu4
	 +2lTgt2VTtDmUbObh4VpaX7UIRFTSivXbTCvP1vRl7C1NL86ZhPSsYuIxBT2089r/L5TR
	 ZQjWp+FURyDKVqpWvumMlYguTqwT38qjuKSOXym7X1RYg/9rwbVTxCHXSyxBhsbdjLGDG
	 XKKWwtLL0AxUvb0/0cz9U83P4/sjC4fI04ZceDeJVKpRvgkmIvq0DCqwyKMRWfjYnNxet
	 3VTYC10m0m/1XU2X4+lbkT4aCQMsDwbxj2o+Ef9fssUul05RjEYbwRjAPl1rRWMDoKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608265;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=+FYlbmuLGJTM1hbgPeNeKHRfi8RnZORpiEHmn2s12IY=;
	b=myBNCmPcx2Iq450Tw/osPJ4hO48+NkcsRRvUVxHpoEaAzUaSoT1Xvh99QJT0Nsuk5YHN
	 cAQM5HIbhc2B7n6wiE4qenva2anevpMi2xU6nNXWCNdrFXiuGMz4UlnqA6y5my+9Dv6HP
	 XcfIF+vezTbioEXDjSlINb/eZTD/2cECu3kY7eoGfgWSNfIUHn1S8JRdL6gmL/G/gM3wP
	 cTZFNH0S1FqOHsPsVT1u+0Fw8TsKnadpmU8SCNe7OBv6Wmvb8i/xCLB8e7aTPImIzfo6H
	 56qaXOka0kQNV+NIY9NnsnwvOE4aUHjwwIE7VscpLqOQy7x33SL8SoV+AzukYzJBhcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X3xJiGDb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EF5606A323;
	Fri, 13 Nov 2026 22:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X3xJiGDb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDB31F000C4;
	Fri, 13 Nov 2026 22:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794608265;
	bh=+FYlbmuLGJTM1hbgPeNeKHRfi8RnZORpiEHmn2s12IY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=X3xJiGDbyJJIYwO8k1+QXLJ3XPJNSkHWx/IHVy8GrBUXicdw7s9Yaoqu6ByDIrMvd
	 fM4TWDxtav+BNfn7gnPnMicW4RVxJW39LyiNwpp0LsMA7S7vUhUgMgxOTiu20wZ+B6
	 al8XcIExUqBC83z7erv9E30rUgJVcgkl5HloiRVhx+o8m33cwIIGhBqs83aBHSg3Up
	 nZ0H+K7M/wmyUVK8VZ/Zcu4TYFLPWEpryROA2qcJYRi6SZ491eHdFT77ZAuQ/hWzpK
	 S8JryOUx1xv4NPT4LsYIxWIG0s2LtmaCUG/GME2z8SIXZJ2xVKrfvcyFpMIIAR5kYq
	 LT2HciBuX9vHg==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 2FA70325F698;
	Fri, 13 Nov 2026 22:17:36 +0000 (GMT)
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
Subject: Re: [PATCH 1/2] spi: atmel: limit transfers to the bounce buffer
 size
From: Mark Brown <broonie@kernel.org>
To: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
 Ryan Wanner <ryan.wanner@microchip.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, stable@vger.kernel.org
In-Reply-To: <20261111154024.543546-1-angelo.compagnucci@gmail.com>
References: <20261111154024.543546-1-angelo.compagnucci@gmail.com>
Date: Fri, 13 Nov 2026 22:17:34 +0000
Message-Id: <179460825499.448985.3170295057747053339.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=802; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3lNillkmyVv6bRE4zL4+iIGLaUjQuqcV8seAnnxZngo=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLK+99Qf2O/IcW1+TF1GyZ8dlXslZ5+aopOqNv9z6Q/h3
 Cd/fTLkO0pZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjCROn+GvzJeGkLXnsnWL/jZ
 YBEjfmOt/zTnS+kuE2t517wou7jt421GhoVuS3uj/h17HhNc+bPNpvzHy3277j1y3PrA/XLuQw7
 2QjYA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> On SAM9 SoCs (CONFIG_SOC_SAM_V4_V5) a DMA transfer from or to a vmalloc
> buffer goes through bounce buffers of SPI_MAX_DMA_XFER bytes. The whole
> transfer is copied in them though, whatever its length, and nothing
> limits the length of a transfer: a longer one is copied past the end of
> the buffer.

> +/* Transfers from vmalloc buffers are copied in the bounce buffers */
> +static size_t atmel_spi_max_transfer_size(struct spi_device *spi)
> +{
> +	return SPI_MAX_DMA_XFER;

This poorly namespaced driver specific constant is 65535 which is going
to cause problems with 16 bit words, __spi_validate() will end up trying
to split transfers into 65535 byte chunks which isn't going to go well.
Picking an even number would avoid the issue.

-- 
Mark Brown <broonie@kernel.org>
