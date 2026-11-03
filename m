Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708771;
	b=lsPgLeBbi1SlB98QCqB7ojN2OmZMuq4LKTqz4jKj00shFPmfHEqP0+GXiOSP8X2g8Iks
	 dlnn6QHiOUbjIHR8JkD9Q6eZTX4o4Cqj5jC0ZWLOI5f6I4OOKN1D12g79mevRpugDoEEI
	 NNMYzfNSKFusd5/ATR7uLsv2tDe6KD/YOFl+uWQYDBa6Ou0ey6z8E1PXn6sDnfiIkkrbn
	 1vh8xQO9LHu4gkclxKnznpGqn2ZJBccymHig/C9lnPAmHLAnaei3MWhyKv07Ji0yqOKiH
	 +zuvNqu3LnhIQHaLL4JiY4vkCtZPLeZ9AHVj5NDL9bLO6TWswEr8vpifFeiJL/zX9lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708771;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=orrpCKDFSt9gDgtM7J88eOaGMeMvBiiqJpohCbwRqEw=;
	b=CVi0a2BCq7nFiG0KaXvSvzT95tU/mgXwcXLi70y0saaC5SrAKpJ2MnEMj5XyVbGXM/OF
	 nHrxmZbc7I6vI+iY6Qu+EtQmJkemKsgSB0R01dg7cZ1oHeADl24kYj14NVYPTFooDFbi4
	 ZCN4GftihNDMnts09dfdLZshuPlFRrGykq9M326u/x+RtOlwzKA2E0u785BZPKkAmQPG0
	 9XnsxC0uA/S8lACPyInDL9ki0fZzASQOxNORnHdGHBp9Qf+gai+yX/9ryuCM6g19916j5
	 AZg5+wRmfrqG7UiwCyJZkFgo4hi+qOIlsB4UXtA2vz3OOUtC7ThQPaWSFWEGrCv05mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=hYk5cVnY;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68271606A326;
	Tue,  3 Nov 2026 12:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68271606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=hYk5cVnY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793708770; x=1825244770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w0Lxn/wh2HtjjqJ/6yq2K0YWFQ62cFd+21xnLqoOMw0=;
  b=hYk5cVnYTFC/P8Dn8vAcU86IELcAx9dddmX+jnB3GzilPJWJ8IzaXd8K
   3joUHy2vgcjQrxhUXxdvwYAmPRiPo4sl5EZH4pCMXqL75vAA4grTcVrcd
   MMz/2m7IWROF3ZPIbdqu/FulGoGFptdM36w9sgVIMUqVS7xOTCtUB3YdG
   DuJSeO7RK7nHxxte5p9ssxEML40UQSnNSaKysgdGo1hKm18wdg2x2u3tw
   DEnRE9DN1MVOxEyaxWnRiPdlg7qy3vyH5+oRNkKmcr6iWQ0Ly15YKgLTz
   w8iEiOXeIYhUbJCkeNR69+yFbPQFP/W/cPphafR7E6S3myP6fAqinZV7J
   A==;
X-CSE-ConnectionGUID: pEFwRhSlTGmrax0Bq44i/g==
X-CSE-MsgGUID: Fls9AbYkSxaHozdYSpUTww==
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="66194078"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Nov 2026 05:26:04 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 3 Nov 2026 05:26:03 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 3 Nov 2026 05:26:01 -0700
Date: Tue, 3 Nov 2026 13:26:00 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Wentao Liang <vulab@iscas.ac.cn>
CC: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] net: lan969x: fix page pool leak when RX DMA allocation
 fails
Message-ID: <20261103122600.5tk7iirkrrvesfgz@DEN-DL-M70577.microsemi.net>
References: <20261103102854.1340615-1-vulab@iscas.ac.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261103102854.1340615-1-vulab@iscas.ac.cn>

Hi Wentao,

> lan969x_fdma_rx_alloc() creates the RX page pool and then allocates the
> FDMA coherent memory. If fdma_alloc_coherent() fails, the function
> returns without destroying the page pool.
> 
> The failure propagates out of lan969x_fdma_init(), and
> sparx5_frame_io_init() then marks the FDMA IRQ as unavailable, so
> lan969x_fdma_deinit() is never called on teardown and the page pool is
> never released. Destroy it before returning the error.
> 
> Fixes: d84ad2c0d80c ("net: lan969x: add FDMA implementation")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
> index 053d125eda65..bc293ba1707d 100644
> --- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
> +++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
> @@ -169,8 +169,10 @@ static int lan969x_fdma_rx_alloc(struct sparx5 *sparx5)
>                 return PTR_ERR(rx->page_pool);
> 
>         err = fdma_alloc_coherent(sparx5->dev, fdma);
> -       if (err)
> +       if (err) {
> +               page_pool_destroy(rx->page_pool);
>                 return err;
> +       }
> 
>         fdma_dcbs_init(fdma,
>                        FDMA_DCB_INFO_DATAL(fdma->db_size),
> --
> 2.34.1
>

Thanks. The leak is real, but this init path has another problem
of the same kind:

  - If lan969x_fdma_tx_alloc() fails, lan969x_fdma_init() only frees
    the RX coherent memory. The page pool and the RX pages that
    fdma_dcbs_init() already took from it are leaked, for the same
    reason you describe.

All of this has been there since the FDMA implementation was added, and only
triggers on allocation failures at probe. I have a net-next series for
MTU-dependent RX buffer sizes coming up (very soon, within days) that reworks
this exact code and its error unwind, so I'll fix this (and other related
issues) there.

I'd suggest dropping this one.

pw-bot: rejected

/Daniel

