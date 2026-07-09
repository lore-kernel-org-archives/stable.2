Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C126D3E63B2
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 08:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586888; cv=none; b=PGabNnjT71LoOX7qgp8ZTI3HfzS1UwZUu4ZT8ildMAC5NztFC9FRAfqpGBodz93Jg9tyr+aaDmGuGw1cemYwjnRKKrA7BlrlDQSsCHnDXam6YaGCPEPYdo3gCM8luYuZ/Ha0BSuPXA24tuKUrU6NjwggmWdoz9y5iiXvghSU5w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586888; c=relaxed/simple;
	bh=/L+tqpwaYO9W0zF/nWpLyI2lH1dRyW25/cwwkrtvFjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ImyjZzCJk6sOjj/68nLRQ8AVdF7KJDn9j9XCkiJ9/dafT04FyHIMJfjCaUoUsA4Ax/tPSpZbOePQHRRsIXeSseXpR2HGTu2bSYy0vi5gLt3eLSABgnxPvlowImznYtQ4yAdFXSPi2EqWiGuG+XF4GvQGoQeqoUzY1whbI/m6u8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eTvWoI/P; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NF4rGnOu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eTvWoI/P";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NF4rGnOu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783586885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNLDe2YV79k3XNGNarb7q5y3JmQjEGvvYqB7WFiB7AU=;
	b=eTvWoI/PmjUhg4ylvuzo0ytJEVhiryAyw19hegCI2stkIAVK3rvBDG+q9oNof6eAHlXfEm
	DNP2nOl0PRwgPbrqRYNrjTMGGo8QpWz5nnNFhWQREPforAhdqjQ5/wVBX492pFCdT98YDS
	yERRJ1+Kx1BSwXpmRSmeqLRB/VLTpbs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-aiDH3F6oOK2TwxF6lw8vpg-1; Thu, 09 Jul 2026 04:48:04 -0400
X-MC-Unique: aiDH3F6oOK2TwxF6lw8vpg-1
X-Mimecast-MFC-AGG-ID: aiDH3F6oOK2TwxF6lw8vpg_1783586883
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4926596eebcso13263535e9.3
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 01:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783586883; x=1784191683; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uNLDe2YV79k3XNGNarb7q5y3JmQjEGvvYqB7WFiB7AU=;
        b=NF4rGnOuBsGMgTryhWYuj6quxb6GKMPKZR6iYqqK8COomx9ijVgAR6F1S6LGPEVhm2
         GRsg8qjBD1H61Boqw8PP82NaeziAn8gDRRRi3zrTQD7OKBNQif9ssiJaoOFm61KdVGcE
         cR/gYBFEVRHgtc/YTu8/06IXZ2/IIrsrUGI2jWyJI44JFwkOggLHOGXF7qbf4m4t5Ft+
         MTxjl0dlp3N+JTeUtdVmoZgBAvyA7d09mip727jPh6COYjW90XmfpCfwFFMl7uV8bjT9
         Qifdjynowg+lRucb3ZVuguyMWPwzZVs655lF1tsLjqyzZPypN/b8bnPuWZ2IPuBtQPfp
         r4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783586883; x=1784191683;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uNLDe2YV79k3XNGNarb7q5y3JmQjEGvvYqB7WFiB7AU=;
        b=prd2yQAenKkMUnrkuoNVwJB2VuIAOK2UiSSbpTJJMRd9x8ZQetrMFJ5TLHswsRJOds
         Ww5BkfT+m0RsZ2TErKHu2LO1MuAcQW05rVi62gKgkeEKApuHGDNY+6vPd+P4THNZbUla
         ysvzzEO3OjIpQktJq71ZZ2+ltOL1kxoicJiRciKplCAHpTeR0NZQIHxNO2G9K6R1Syv0
         CsjQ4pe4/3IuQPSl/4C8foUylHNpqPm9TDvJHtCx/3aids9VtW/Pk4S+BQ9mvzxw8ETc
         tyhNsMGCNBR9T09YCBWv5rsw4k4nIeXpIISMVIo1drvF0iO6b8NYQ5g9yW4rjK+70QNd
         ew7g==
X-Forwarded-Encrypted: i=1; AHgh+RrhlJLyTMRjVGCkJJDy4Jl03YPeclEMCZL2K+QR3a2OKm3zbDnJomkc2SBpHcwP6JNViTZXGuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0VrMm8x3MN0MWG/K6TIXCHqIh5V2ZHL5L48BKWzcVcmCb4j0t
	tQ29bRJaEmQpopvVFfjxSuXCzqsQb8kWrmIihWjjFL0oYT4LLH3yq6/3wlsVIo3m7p9OkfmOPkR
	RkgdJ0qUh6rjlwVfmpLg+5vobdKKBz4dQILVAvjDBnL0Fg0eOciiaeoQBKA==
X-Gm-Gg: AfdE7ck9zqvAnHQ2bf4m7Ii2FJIuuWQ9hIFUjTkxP7b4yD+OfFtvnzaRveUJBPUVvwk
	hgfTL89eq8hsczX689ZxeE6wuKgAHbeCyPp/r/VkCKRtucjJUX1D9LkQ/NauXuHnzfTXnksK52e
	gfayqHbnJ/32NDadkEwdjR/XXyvEoYw2PAs5sKh+D0phKMISyFPBi93yh9+Rb0ehPqnTudXrYru
	7RPPmcM0zN3XDYKRKVPHTmxt5vmIBhzc+IMD6Nj1vXVZHBZwwwrc3bEfMRC70trQOU/TZFxNJgo
	1suhqWeniFIS1FBVLbC/mlYP5WEWkfr84KBRtCH068cSZsymOVsAf3UbfUBK/b7wAV8/htTIB2P
	UGebKBkS64qmqrSXQxrBaNY+50TBFL+3QGLkQTJ5wq0lTzJK7IgYXIbTkltu1NBEf03y7vvVzaL
	r9pwA0tL7ZOvIR
X-Received: by 2002:a05:600c:6206:b0:493:a573:179b with SMTP id 5b1f17b1804b1-493e68d145dmr61356365e9.30.1783586883330;
        Thu, 09 Jul 2026 01:48:03 -0700 (PDT)
X-Received: by 2002:a05:600c:6206:b0:493:a573:179b with SMTP id 5b1f17b1804b1-493e68d145dmr61355965e9.30.1783586882805;
        Thu, 09 Jul 2026 01:48:02 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e5a58853sm97520615e9.1.2026.07.09.01.48.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 01:48:02 -0700 (PDT)
Message-ID: <656ea643-bf7d-4ad0-9020-7ca3f49f9e82@redhat.com>
Date: Thu, 9 Jul 2026 10:47:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] net: macb: drop in-flight Tx SKBs on close
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jeff Garzik <jeff@garzik.org>,
 Conor Dooley <conor.dooley@microchip.com>
Cc: Paolo Valerio <pvalerio@redhat.com>, Nicolai Buchwitz <nb@tipi-net.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, stable@vger.kernel.org
References: <20260702-macb-drop-tx-v4-1-1c833eebdbc8@bootlin.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260702-macb-drop-tx-v4-1-1c833eebdbc8@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/2/26 5:37 PM, Théo Lebrun wrote:
> The MACB driver has since forever leaked the outgoing SKBs that
> have not yet been marked as completed. They live in queue->tx_skb
> which gets freed without remorse nor checking.
> 
> macb_free_consistent() gets called in a few codepaths, but only close will
> trigger the added expressions. In macb_open() and macb_alloc_consistent()
> failure cases, queues' tx_skb just got allocated and are empty.
> 
> Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
> Changes in v4:
> - Drop the skb_drop_reason code. No other Ethernet driver does that and
>   the reasoning (because our stats are broken) is a bad one.
> - Take Rb trailer from Nicolai.
> - Drop <hskinnemoen@atmel.com> email that gets rejected.
> - Rebase upon latest net/main (d8e8b85a85fe).
> - Link to v3: https://patch.msgid.link/20260617-macb-drop-tx-v3-0-d4c7e57d890b@bootlin.com
> 
> Changes in v3:
> - Drop stats fixing. A proper fix deserves its own net-next refactoring
>   series to migrate to netdev_stat_ops (ynltool uAPI), which will come
>   in later. We keep the tx_dropped++ because they are safe as every
>   other context is disabled when macb_free_consistent() is called.
> - Rebased to latest net/main (406e8a651a7b), nothing to report.
> - Link to v2: https://patch.msgid.link/20260428-macb-drop-tx-v2-0-647f5199d8df@bootlin.com
> 
> Changes in v2:
> - Increment tx_dropped stat once per SKB, not once per frame.
> - Reset tx_head & tx_tail to avoid keeping stalled cursors.
> - Fix SKB dropped reasons throughout by adding the reason as parameter
>   to macb_tx_unmap(). This is a new patch. Then the drop-all-on-close
>   fix can use this ability to report we are not consuming SKBs.
> - Add increment to stats->tx_dropped on DMA mapping failure and
>   tx_error_task. Done as separate patches (3 and 4).
> - Rebase upon net/main @ 46f74a3f7d57, nothing to report.
> - Link to v1: https://patch.msgid.link/20260424-macb-drop-tx-v1-1-b3ecb787d84d@bootlin.com
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index fd282a1700fb..d394f1f43b68 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -2668,8 +2668,25 @@ static void macb_free_consistent(struct macb *bp)
>  	dma_free_coherent(dev, size, bp->queues[0].rx_ring, bp->queues[0].rx_ring_dma);
>  
>  	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
> -		kfree(queue->tx_skb);
> -		queue->tx_skb = NULL;
> +		if (queue->tx_skb) {
> +			unsigned int dropped = 0, tail;
> +
> +			for (tail = queue->tx_tail; tail != queue->tx_head;
> +			     tail++) {
> +				if (macb_tx_skb(queue, tail)->skb)
> +					dropped++;
> +				macb_tx_unmap(bp, macb_tx_skb(queue, tail), 0);
> +			}
> +
> +			queue->stats.tx_dropped += dropped;
> +			bp->dev->stats.tx_dropped += dropped;
> +
> +			kfree(queue->tx_skb);
> +			queue->tx_skb = NULL;
> +		}
> +
> +		queue->tx_head = 0;
> +		queue->tx_tail = 0;

Both sashikos noted this could race vs tx_error_task, but it looks like
a pre-existing issue, and I think it should be addressed with a
follow-up patch.

/P

