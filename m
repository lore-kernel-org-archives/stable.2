Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312300;
	b=h3GTYcReOVCEnBgyE3+6sJ6+egGw9ojnmewLWED6H9sS7Zb409jB1tqYFjt3B9/0QQJE
	 cxUy71GvM+dItstoOHMNQz2bupRD0b8E4SKfte7YxH+0JOrMhlARr8Xep2SPVH6BA/ytX
	 TsNjVIt+m57pHvchQzb5YbeBLumUm1qqjjUT/esPDodkLPHkQTl3GxqN6E1zfvSw6d/mU
	 oHC4ehEGLbF8w3e2pEysEtNPO892Dhk+86aek/GRjGEym25DjrpTLy/+kO9Z1gvUrqUnl
	 u/ReXfyp5mwGu6kEY/30ZSaD7hDAy2r8Tfs/df5OMY0uyDuzbfJyirs/3zZ7SFOLo9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312300;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=2qzoTU2V3PL2+1NGWeEx3c05JhHhlLHtfGf2r6hPE0M=;
	b=PwVQtCm28cBXvSGwrE30OjN2oJ8QYBAnswGZbstP2A2wMt9x81i3mQz0NsBnm6zGYt7f
	 a8iSLUZ+pAw54WH9KkEOl1CEyCtfWeFZ10lOz+GuFM2X9uIqShTJpLBKMfygJpJOEcK0/
	 EWFx1opQidTpONoCT+udIMq2MebwOFRw6SYHHpsKxotY1tBW/6HCQgsdbD6Zd22FjzvJw
	 xB2bp6ragy2a8yQv+ysH0AunhpRMb/AJ5WbjwFVf097KSEHImAdY4VC9yDNxZz3qxtaAt
	 tQGvXFKDaq7ikZTMb85uTarwiygpHyuaaS1uzs7I0uEgjJggYRMjR0KpeJz3jGP8aUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EtbsJ3Sx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC0A606A321;
	Tue, 10 Nov 2026 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EtbsJ3Sx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1280E1F008A1;
	Tue, 10 Nov 2026 12:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312299;
	bh=2qzoTU2V3PL2+1NGWeEx3c05JhHhlLHtfGf2r6hPE0M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EtbsJ3SxdC/ckG+wU9hRtJMtS4NlZD9+I8GM4sKfA0M77RKgrVk4eH6D7qDasFtQI
	 1q3RpvRwG7twOybAs7hWmpdPpgJ8xEKMCBB//Zui6VXAmt3DI2w5vBPIIiLWEq2RLp
	 bK6olxKMnfwa/vQCqP1zZZFUinZ6+tWAlDKrFxB2jdQCZ1V0VITV/1jEmRP3balK1a
	 k9ghO6rvQYLscpahahKVWneQUGcbe9ljsumNNw358KqgKIrfCH8I4LikRHpXdwsQQK
	 UjyzetYvcMf7LxUgScArMN8PEfvVETjOstoZ9xXg/84O0krRrgD5ndOqgvqyn2Eo+E
	 0Kv9w/shvYk6w==
Subject: Re: [PATCH net v4 1/2] gve: block XDP on the DQO-QPL queue format
From: netdev-bot+sashiko@kernel.org
To: amaan.cheval@gmail.com
Cc: netdev@vger.kernel.org, joshwash@google.com, hramamurthy@google.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, bcf@google.com, jordanrhee@google.com,
 przemyslaw.kitszel@intel.com, maciej.fijalkowski@intel.com,
 pkaligineedi@google.com, maolson@google.com, csully@google.com,
 willemb@google.com, yangchun@google.com, npl@google.com,
 awogbemila@google.com, shailend@google.com, nktgrg@google.com,
 maxyuan@google.com, bpf@vger.kernel.org, john.fastabend@gmail.com,
 hawk@kernel.org, sdf@fomichev.me, daniel@iogearbox.net, ast@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 10 Nov 2026 12:04:57 +0000
Message-ID: <179431229760.994134.9605192478932025271@kernel.org>
In-Reply-To: <20261106114551.212675-2-amaan.cheval@gmail.com>
References: <20261106114551.212675-2-amaan.cheval@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch is incomplete for GVE_GQI_RDA_FORMAT.

--

gve: block XDP on the DQO-QPL queue format

This patch adds a queue_format check to gve_verify_xdp_configuration()
that refuses XDP program setup on DQO-QPL. That check was lost when
d8a8ca14c937 enabled XDP on DQO-RDA. The DQO-QPL RX page accounting can
free a page that is still DMA-mapped when a redirect target releases the
buffer synchronously.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 2437cd8ba6331..4e9e692a0ed0a 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1723,6 +1723,12 @@ static int gve_verify_xdp_configuration(struct net_device *dev,
>  	struct gve_priv *priv = netdev_priv(dev);
>  	u16 max_xdp_mtu;
>  
> +	if (priv->queue_format == GVE_DQO_QPL_FORMAT) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "XDP is not supported in DQO QPL queue format.");
> +		return -EOPNOTSUPP;
> +	}
> +

[Severity: High]
Does this leave GVE_GQI_RDA_FORMAT uncovered? The commit message says the
check removed by d8a8ca14c937 "refused every format but GQI-QPL", so it
blocked GQI-RDA as well as DQO-QPL. Only DQO-QPL is added back here.

GQI-RDA also falls into the else branch of gve_set_netdev_xdp_features():

	} else {
		xdp_features = 0;
	}

and gve_xdp_xmit() rejects it too:

	if (priv->queue_format == GVE_GQI_QPL_FORMAT)
		return gve_xdp_xmit_gqi(dev, n, frames, flags);
	else if (priv->queue_format == GVE_DQO_RDA_FORMAT)
		return gve_xdp_xmit_dqo(dev, n, frames, flags);

	return -EOPNOTSUPP;

On GQI-RDA, though, every remaining check in this function can pass:

  - GQI has no NETIF_F_GRO_HW.
  - Header split is DQO-RDA only.
  - packet_buffer_size defaults to 2K.
  - GVE_RX_PAD is only subtracted for GQI-QPL.
  - The rx/tx queue count condition can be met with ethtool -L.

Once verification passes on a running interface, the path is:

gve_xdp()->gve_set_xdp()->gve_configure_rings_xdp()->gve_adjust_config()
  ->gve_queues_start()->gve_reg_xdp_info()

On GQI-RDA, gve_is_qpl() is false, so gve_reg_xdp_info() takes this
branch:

		else
			err = xdp_rxq_info_reg_mem_model(&rx->xdp_rxq,
							 MEM_TYPE_PAGE_POOL,
							 rx->dqo.page_pool);

On a GQI ring, rx->dqo.page_pool is NULL because gve_rx_alloc_ring_gqi()
memsets the ring. __xdp_reg_mem_model() therefore returns -EINVAL. By
then gve_adjust_config() has already closed the old queues, so it logs
"!!! DISABLING ALL QUEUES !!!" and turns the device down.

Before that failure, gve_queues_start() has already set:

	priv->tx_cfg.num_xdp_queues = tx_alloc_cfg->num_xdp_rings;

and nothing rolls it back. A later ifdown/ifup goes through
gve_open()->gve_get_curr_alloc_cfgs(), rebuilds the XDP rings, and fails
in gve_reg_xdp_info() again. Does the NIC then stay down until a device
reset? If the interface is already down at attach time, gve_set_xdp()
installs the program, and every later gve_open() fails with -EINVAL.

There is also a NULL dereference that only this failure hides.
gve_tx_fill_xdp() uses tx->tx_fifo.base and
tx->tx_fifo.qpl->page_buses. On raw-addressing GQI TX rings these are
never set up: gve_tx_alloc_ring_gqi() skips the FIFO/QPL setup, and
gve_can_tx() skips the FIFO check. That dereference would become
reachable if GQI-RDA mem model registration ever succeeded.

Would an allowlist (accept only GQI_QPL and DQO_RDA) be a closer match to
"matching the features the driver advertises"? Checking for
NETDEV_XDP_ACT_BASIC in dev->xdp_features would also work.

With the Fixes: d8a8ca14c937 and Cc: stable tags, backporters may assume
that regression is fully closed. The later patch in the series ("gve: fix
RX page refcount overflow from the pagecnt bias") does not touch
gve_verify_xdp_configuration().

>  	if (dev->features & NETIF_F_GRO_HW) {
>  		NL_SET_ERR_MSG_MOD(extack,
>  				   "XDP is not supported when HW-GRO is on.");

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106114551.212675-1-amaan.cheval%40gmail.com
