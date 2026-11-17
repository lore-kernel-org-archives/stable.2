Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927421;
	b=SKS1E6ioMOjakt/kTWBQifUo5P1lRrHMoKtscs70nE7yJSuv3Wqr03SJrVNndiqZiWSe
	 Hm9GBysWBDBSmqiqAjs0gla3LDtQYAPMz2NAq2LXe09vZBG4FHt5fpyQGcXKnlZPrMV1G
	 Pr3b8oQDbU/9wYK3T8ksBtRlfY4de7pd7BcRXpSKJTn+0kOJzeybY8QXtDvlUP6Zb/oVi
	 MHy6SGhVbr1EDmhHYoeFXM2Jrs3MeUYlOL5k/WWbg9FsJI6yR6k+8jLR2t2JVSAVqY3rB
	 oM8iAI9iXqLRNnHidg431DSgBMCBWkrG1cHaKoLNL+CoR/hNxqd/lOAGYRNKffBMLbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927421;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=BYDghbSSGp8ajBj0SqwqioXz4gab4WkH6tR1bMEa1MY=;
	b=ORvJex2CxWNxih14lSQh9qdYfPURd0GJKdlLXxJm+boYxvd38RUMPqjYQMuOrlSLY5Ej
	 +idzk8nSGzcsu8HuVfddfBjtsFoGCm1F/n/gzD8vRZosbbgz3jwGVO/WYY1HfNr5VH5KN
	 1f6oZGnmaU7oRTVRF1mvhr4K2TUo8CdUdINT5uMEQh9HH5SlU5TiKKIE94bg2Cycgngu5
	 uSyHAszLJrAKQOYTtY7a3w9C/NYLun47D8UdwmjYFsfGSgZ5+vfzBhJdKaXqLv0XSkT9e
	 kUZ8y0RKnyrn3dq8j2ZQ3BS/zu9X0VyTDlNcdnMZskyPC1rMhudW6azE/5Lviz7zcyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ckKFsnPO;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DCC606A332
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 14:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4DCC606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ckKFsnPO
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4AACB4E4157D;
	Tue, 17 Nov 2026 14:56:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 208C95FD6A;
	Tue, 17 Nov 2026 14:56:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BD32711BC0039;
	Tue, 17 Nov 2026 15:56:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794927413; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=BYDghbSSGp8ajBj0SqwqioXz4gab4WkH6tR1bMEa1MY=;
	b=ckKFsnPOv0NWmOIZtDjV4G8YpEPKa48eiB5p5OyeEE5Idd7Cl3q2mCJFAzgSG2pDRTXU74
	YgTwk7KCcawBZN4VG6jzjFZv8DBpoXJE5IIQBu527JZps6qPQgxFp731qDHduX23lGOy5l
	WlDmrzk0pFKeKKUnljc4Y7fwSMW0OCUd/gzXamxydWs0xqoqvEroD3UIz/H5OESx42upZv
	XaL1TzqXNL+TjyZ7z7ZIYUKqtdGVno5+hTRJ3JnkcL1UhqZs/BJhC7MwnJ4PFqKatiSZrX
	EUGZJpFHqxTdi2+V7LPnCT0+gso8C/e3ded9Kfn3ukx3HgwZxQDcGoBgQGZoWA==
Message-ID: <5231b964-215d-481d-87b3-86ff99829eba@bootlin.com>
Date: Tue, 17 Nov 2026 15:56:49 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/3] net: stmmac: dwmac1000: don't discard frames
 with only a checksum error
To: Christian Schmidbauer <opensource@grische.xyz>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, Oleksij Rempel
 <o.rempel@pengutronix.de>, stable@vger.kernel.org,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Aaro Koskinen <aaro.koskinen@nokia.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261114133640.3285413-1-opensource@grische.xyz>
 <20261114133640.3285413-3-opensource@grische.xyz>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261114133640.3285413-3-opensource@grische.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 11/14/26 14:36, Christian Schmidbauer wrote:
> On dwmac1000 with enhanced descriptors, the hardware sets the Error
> Summary (ES) bit of the Rx descriptor not only for L2 errors but also
> for an L3/L4 checksum error. enh_desc_get_rx_status() returns
> discard_frame whenever ES is set, and since commit 1b746ce8b397 ("net:
> stmmac: don't overwrite discard_frame status") the checksum status is
> only evaluated for good frames.
> 
> Return discard_frame only when ES comes with one of the L2 error bits.
> A frame with only a checksum error is then reported as csum_none and
> reaches the stack as CHECKSUM_NONE, so the stack verifies the checksum
> itself. This matches dwmac4, whose Error Summary bit does not cover
> checksum errors.
> 
> RDES0 bit 7 is not in the mask, because depending on the core and on
> Rx checksum offload it reports a timestamp, an IP header checksum error
> or a giant frame, and enh_desc_get_rx_status() cannot tell which. In
> threshold Rx mode, a giant frame that fits one buffer therefore reaches
> the stack with a verified FCS.
> 
> Also remove the pr_err that enh_desc_get_rx_status() prints when bit 7
> is set. Once the MAC stops dropping checksum-error frames, any host on
> the link can flood the kernel log by sending frames with a bad IPv4
> header checksum.
> 
> This prepares for setting DMA_CONTROL_DT, which makes the MAC deliver
> checksum-error frames instead of dropping them in its Rx FIFO.
> 
> Fixes: 1b746ce8b397 ("net: stmmac: don't overwrite discard_frame status")
> Cc: <stable@vger.kernel.org> # 6.6.x: ee0aace5f844: net: stmmac: Correctly handle Rx checksum offload errors
> Cc: <stable@vger.kernel.org> # 6.6.x
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Christian Schmidbauer <opensource@grische.xyz>

I was able to test that on Altera Cyclone V, and it works. 

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

> ---
> v2:
> - Drop RDES0_LENGTH_ERROR from the mask of Error Summary bits. The
>   length check further down already discards such a frame.
> - Explain in the commit message why RDES0 bit 7 is not treated as an
>   L2 error.
> v1: https://lore.kernel.org/netdev/20261020190319.884375-1-opensource@grische.xyz/
>  drivers/net/ethernet/stmicro/stmmac/enh_desc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
> index 7ece8d4157a8..d0622f2605aa 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
> @@ -216,9 +216,6 @@ static int enh_desc_get_rx_status(struct stmmac_extra_stats *x,
>  		if (unlikely(rdes0 & RDES0_OVERFLOW_ERROR))
>  			x->rx_gmac_overflow++;
>  
> -		if (unlikely(rdes0 & RDES0_IPC_CSUM_ERROR))
> -			pr_err("\tIPC Csum Error/Giant frame\n");
> -
>  		if (unlikely(rdes0 & RDES0_COLLISION))
>  			x->rx_collision++;
>  		if (unlikely(rdes0 & RDES0_RECEIVE_WATCHDOG))
> @@ -230,7 +227,10 @@ static int enh_desc_get_rx_status(struct stmmac_extra_stats *x,
>  		if (unlikely(rdes0 & RDES0_CRC_ERROR)) {
>  			x->rx_crc_errors++;
>  		}
> -		ret = discard_frame;
> +		if (rdes0 & (RDES0_DESCRIPTOR_ERROR | RDES0_OVERFLOW_ERROR |
> +			     RDES0_COLLISION | RDES0_RECEIVE_WATCHDOG |
> +			     RDES0_MII_ERROR | RDES0_CRC_ERROR))
> +			ret = discard_frame;
>  	}
>  
>  	/* After a payload csum error, the ES bit is set.

