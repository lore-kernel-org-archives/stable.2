Received: from mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B7A3E2771
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 07:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874959; cv=none; b=sb9SPlnnlCfCmtj6DTAV5jvhW2wZOAdEBJbAcmfyb0QY9DAbyRfeiYrwj2U7uEd6DhJcm/v6E4JroqT0N11zjPCUuc6AWlBsNMm4vgHLmDUOSYEG7V74+CJbJ9C1FOXOHNz46O3B2lrWm/tuxpb03d/8H+dQAR7XwZiAhiD2OHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874959; c=relaxed/simple;
	bh=yUiq5iq51oseANDtP3Z+8R3RmzVahs3k+89exp+vZp0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RG4g1PwFl2su4ej2z6b25ET7TffkaWNZmmlwGpP4G4cT1kvUVaogQFMeA/hfbVgQqrSZsxxKsKqPMk5MNjXo09p4s7y8Xq76xGrUswYWBQ+HWeg6hrD/uxova/bJNdY9pdQt7LzxOarU1MqKzw8ctiGRn3xtROlTZRroIy5NTzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wnjmv1yX; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wnjmv1yX"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yUiq5iq51oseANDtP3Z+8R3RmzVahs3k+89exp+vZp0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791874954; v=1; x=1792479754;
 b=Wnjmv1yXhdJwGV0Fgr/5KeJ223678u0B9D1VIZ/X4OpIr3HtV0LGK/46sZr6xmxWjkmLyGyq
 imy837Sgtp3ygURqPGSIr4cqsTJeLpGEDR5u+GId8R2DjYhkvry0NFvmuaTmmIi+t/b1tnJ/cqS
 HGdYr0Yvcxu7GlLcJ72bBlmc=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 90f89cb3ca4609ea;
	Tue, 13 Oct 2026 07:02:34 +0000
X-Mizu-Trace-ID: 90f89cb3ca4609ea
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Oct 2026 07:02:33 +0000
Message-Id: <DM3INPS04NBT.17RGVMX2K5ZQD@linux.dev>
Cc: "Luka Gejak" <luka.gejak@linux.dev>, "Martin Blumenstingl"
 <martin.blumenstingl@googlemail.com>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Ulf Hansson" <ulfh@kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH rtw-next v5 2/4] wifi: rtw88: sdio: Track running state
 and cancel TX worker on stop
From: "Luka Gejak" <luka.gejak@linux.dev>
To: "Alastair D'Silva" <alastair@d-silva.org>,
 <linux-wireless@vger.kernel.org>, "Ping-Ke Shih" <pkshih@realtek.com>,
 "Kalle Valo" <kvalo@kernel.org>
X-Mailer: aerc 0.22.0
References: <20261011220755.1673367-1-alastair@d-silva.org>
 <20261011220755.1673367-3-alastair@d-silva.org>
In-Reply-To: <20261011220755.1673367-3-alastair@d-silva.org>

On Sun Oct 11, 2026 at 10:07 PM UTC, Alastair D'Silva wrote:
> When rtw_sdio_stop() disables interrupts, in-flight interrupt handlers or
> delayed TX work may still run against a powered-down device.
>
> Track the operational state in rtwsdio->running with an irq_lock mutex
> (similar to PCI), check it at the entry of rtw_sdio_handle_interrupt()
> and rtw_sdio_tx_handler(), serialize state transitions in rtw_sdio_start(=
)
> and rtw_sdio_stop() under sdio_claim_host() and irq_lock, and cancel the
> TX worker synchronously in rtw_sdio_stop().
>
> Fixes: 28eaf7971a20 ("wifi: rtw88: sdio: add TX back-pressure and retry o=
n page starvation")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  drivers/net/wireless/realtek/rtw88/sdio.c | 46 +++++++++++++++++++++--
>  drivers/net/wireless/realtek/rtw88/sdio.h |  3 ++
>  2 files changed, 45 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wire=
less/realtek/rtw88/sdio.c
> index e39284b71837..7d4f17e96648 100644
> --- a/drivers/net/wireless/realtek/rtw88/sdio.c
> +++ b/drivers/net/wireless/realtek/rtw88/sdio.c
[...]
> +static void rtw_sdio_deinit(struct rtw_dev *rtwdev)
> +{
> +	struct rtw_sdio *rtwsdio =3D (struct rtw_sdio *)rtwdev->priv;
> +
> +	mutex_destroy(&rtwsdio->irq_lock);
> +}
> +
[...]
> @@ -1843,7 +1879,8 @@ int rtw_sdio_probe(struct sdio_func *sdio_func,
>  	rtw_sdio_free_irq(rtwdev, sdio_func);
>  err_destroy_txwq:
>  	rtw_sdio_deinit_tx(rtwdev);
> -err_sdio_declaim:
> +err_deinit:
> +	rtw_sdio_deinit(rtwdev);
>  	rtw_sdio_declaim(rtwdev, sdio_func);

One nit: The rename takes every failure that lands on err_destroy_txwq
(rtw_chip_info_setup(), rtw_sdio_request_irq(), and rtw_register_hw() throu=
gh
err_free_irq) past the new err_deinit, so rtw_sdio_deinit() runs only when
rtw_sdio_init_tx() itself failed. Nothing to fix while the helper is a
mutex_destroy() alone. If it ever grows, that path would miss it, so I woul=
d
either let those failures fall through to err_deinit or drop the helper.

Best regards,
Luka Gejak
