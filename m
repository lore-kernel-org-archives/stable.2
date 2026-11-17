Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794907568;
	b=U8V2bx/av0xh2YM1n4qypc7O6d8WimR73k3MNB0XHwx8oSuxvdCOVQ6J+8uubRFOlWmf
	 6wB0c+Z6PWjceEPM1gzJbvJum/Y9Bn3uhsgDEPMCOrygdh4R4FshXwVTi9J0YXjPBLSlE
	 V4JJ1bzQfnYzg284HSYTy/ejl8neUT5ZfWn839eWda+N8q1GHK9N//WlM7mzd5tRwmUb/
	 EmAoIXqn5OBu1KxMb8kKlAmKsLaeqGbMnpPVcMxR+qwPTr/aLA1JrxwrIEYyXa5LkSRdC
	 3F/A8bqCD/XAR8wOGMY5idNGiEUD3SrfsHZ+RfW4GoGkTpiyAjJZKVH5IuBLYFVa+cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794907568;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=WArVX4RHsDBbDlMB9jeJsbFXO9eOXVjEfVktWuU8cPM=;
	b=Ff8yG2Rncyo0mUxikvXhP8eVWn0xZM7ZELPsGc21m3UZ6lMYU/CkTHuSMyiG7aNwIbUY
	 hC5o9733ZV3tt5MBPh/rDxN3Nfxhoo4zZfCAbhmC/TegGmkXhflI9Mhn75qDFeqLxTO8n
	 +lkJbPzhBo2tiONXFYKbRxxpkcOlEo26KIGHgE5pgx2fpR8kFvSJ3NZGpPp8KhPMdSRWc
	 RHT3HRciqB67wKpICVozPp2XQd8cZOzuaaRZxMiQirY97UlojtwrvfDR/3lMq1Z/ys5KB
	 9J1lKB+he6xRMKWNqSZbQzjBVClFgKHOaoojgRW/JB44WXYCh0eBlLib8GLuB/3wWnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=FW+OZ4fD;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42719606A329;
	Tue, 17 Nov 2026 09:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42719606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=FW+OZ4fD
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3C9D3A1649;
	Tue, 17 Nov 2026 10:26:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794907565; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WArVX4RHsDBbDlMB9jeJsbFXO9eOXVjEfVktWuU8cPM=;
	b=FW+OZ4fDSt2alBajQx7uaqezbygOJtYL72/kkl7KfcNuHwWUB3oBK3KFvyyZiPWWCXMDD8
	uKvAEAu1EOBgDwBYCgXs4rhB+h6QmXiJXt+j4zArt3v+5JWppgfws56/ulFuBNTexuO2Ro
	t5/9q4FYt7yz9keCy3hrLfW3q2JjrPNRRIV9z+6Yxup2xbUcYHh6Bv4tYm3AwG3HMd3XEL
	qWoAoIRRPlnCLEZ5GskvUK129HDkyp/Pl6yJwKHnDEyYF6bldUdV2TK56hzyhBWoeFojH0
	QQpU+4hh3p4AqTHBbHXH0nYQqzS2miZ2XA/gM4HjiGma13u4B6EyAoj4SzbBIg==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 17 Nov 2026 10:26:01 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Zxyan Zhu <zxyan0222@gmail.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 horms@kernel.org, 0x1207@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: re-enable on-chip parity checkers for
 XGMAC ASP 0x2
In-Reply-To: <20261114015554.2187341-1-zxyan0222@gmail.com>
References: <20261114015554.2187341-1-zxyan0222@gmail.com>
Message-ID: <e041744a3817153bfe5269053d0a9260@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 14.11.2026 02:55, Zxyan Zhu wrote:
> Commit 669a55560e4b ("net: stmmac: Check more MAC HW features for XGMAC
> Core 3.20") made dwxgmac3_safety_feat_config() bail out early for
> asp == 0x2, assuming that configuration has no parity protection.
> 
> Per the DWC_xgmac databook, the ASP field of MAC_HW_Feature3 selects:
> 
>   0x1 (AS_EPPE):  all automotive safety features, with ECC and parity
>                   ports on the external application interface
>   0x2 (AS_NEPPE): all automotive safety features, without ECC or
>                   parity ports on the external application interface
>   0x3 (AS_PPE):   all automotive safety features, with parity ports
>                   on the external application interface
> 
> The reset value of the field is defined as:
> 
>   (DWCXG_ASP_ALL && DWCXG_ASP_PPE == 1) ? "3"
>   : (DWCXG_ASP_ALL && DWCXG_ASP_PPE == 0) ? "2"
>   : (DWCXG_ASP_ALL && DWCXG_ASP_PPE == 2) ? "1" : "0"
> 
> so ASP 0x2 implies DWCXG_ASP_ALL = 1, where the internal FSM state
> parity and timeout (MAC_FSM_Control) and the on-chip data-path parity
> (MTL_DPP_CONTROL) features exist; only the ports on the external
> application interface are absent.  The early return therefore skips
> enabling safety checkers that are present in the hardware.
> 
> Drop 0x2 from the condition so the FSM and data-path parity checkers
> are enabled again.
> 
> Also update the safety feature descriptions printed by
> stmmac_dma_cap_show() to spell out that ASP 0x1/0x2/0x3 differ only
> in the ECC or parity ports on the external application interface; the
> previous wording, "All Safety Features without ECC or Parity",
> suggests the on-chip checkers are absent from an ASP 0x2 device.
> 
> Keep the early return for ASP 0x4 (EASP), which selects only ECC
> protection for external memory and has no on-chip parity features.
> 
> Tested on XGMAC 3.10 and 3.40 cores.
> 
> Fixes: 669a55560e4b ("net: stmmac: Check more MAC HW features for XGMAC 
> Core 3.20")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 6 +++---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c 
> b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> index 1a88cbaed70c..6b2bfc241109 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> @@ -859,10 +859,10 @@ dwxgmac3_safety_feat_config(void __iomem *ioaddr, 
> unsigned int asp,
>  	value |= XGMAC_TCEIE; /* TSO Memory Correctable Error */
>  	writel(value, ioaddr + XGMAC_DMA_ECC_INT_ENABLE);
> 
> -	/* 0x2: Without ECC or Parity Ports on External Application Interface
> -	 * 0x4: Only ECC Protection for External Memory feature is selected
> +	/* 0x4: Only ECC Protection for External Memory feature is
> +	 * selected, without any on-chip parity protection
>  	 */
> -	if (asp == 0x2 || asp == 0x4)
> +	if (asp == 0x4)



>  		return 0;
> 
>  	/* 4. Enable Parity and Timeout for FSM */
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c 
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 25894771e9e9..24f887df88fa 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6741,9 +6741,9 @@ static int stmmac_dma_cap_show(struct seq_file 
> *seq, void *v)
>  	};
>  	static const char * const dwxgmac_safety_feature_desc[] = {
>  		"No",
> -		"All Safety Features with ECC and Parity",
> -		"All Safety Features without ECC or Parity",
> -		"All Safety Features with Parity Only",
> +		"All Safety Features with ECC and Parity Ports on External 
> Application Interface",
> +		"All Safety Features without ECC or Parity Ports on External 
> Application Interface",
> +		"All Safety Features with Parity Ports on External Application 
> Interface",
>  		"ECC Only",
>  		"UNDEFINED",
>  		"UNDEFINED",

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
