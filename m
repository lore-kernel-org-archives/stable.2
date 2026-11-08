Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794122308;
	b=XhGSUtNO7gpZc/xcPAK8Y+b0K14JyKFcZQEzmnx+FiUHWXVG5MoI+IwLU2pe+q2GLE8y
	 MwM0l/xGhBStzhXMI/envhR0u3OwUdw7lIoCJaYosfR70mlJHtnBN42nQeHARQ8BwkEnW
	 z7QFCV4vJxDimSWlAkBCFZHWnQetV63rDVs6NtO4CYX2gNV4nUJYRbROYYp3Gjn6pLGhH
	 dE5xPb8rn707VEQJMLXuWT+IkMEpwnfQ7MPsYpe3HUpj94w6mko2zBKryXWkVVCkMO8Zg
	 AkZP3mR18EQckATUOBaP/J2IcGSjzfEs2GgwcJA4SgrYEw4KRYMf+WGbFCBKT5ZFk3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794122308;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=rp00DiKSxgo0zNtK24eQEtuDxTngsNsV2eHoN50n1pY=;
	b=2eJ8oO0WtIas41H+RSP9DLHaK8JYVJ3Qa2I8ufv1pEUmY7clIEr3BYA8Mxcfdlw1pxer
	 NH5V3oYSqQR2qH1gdz8BjL6dE0XsFbvyXRaEeYwpUM8PiOrG+lRo/1GQtMAlRLFpbPKrG
	 mU1Uch5sELG7Lt6VKT9+BmAKutCoA2tVhmhT5g5nMl4/cl2619AJ3zoBPfFU5ZPjDhd7n
	 SBRG5yEPgkBKtYcieItQU5uS/T5uibRcGYqSE64qdoJRI8GrxSlT1Q+dliOYnIqXITg9C
	 cbeNP5QOZc1ctOQ5kVVBwmH4Oy1HBkAH6Rp7+tTkQCwwIErrCltZlwpDfankFbvfeOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bH1l6BqP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990B0606A322;
	Sun,  8 Nov 2026 07:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bH1l6BqP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D111F008A1;
	Sun,  8 Nov 2026 07:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794122308;
	bh=rp00DiKSxgo0zNtK24eQEtuDxTngsNsV2eHoN50n1pY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bH1l6BqPf0NPLte0hdP1howIC+6VwVqzOWf8WeOFz/Rw0OhK07gIlCHCZH5AnicOF
	 kB/NDEfmBHsEl9Mk/d6+2UHpqTziFmT/uhz5Xh/tZjjbSa3AtAe2obdNf8O7gg4wgd
	 M4uCrouUoNZ0d5ATNHjihFfg6chwpWVWLxvfzbIiaXYi/D+EtGIqNwxkpMs9q2s6CE
	 P3a2rPh21qW/Wr/9TR8loAAAyYn1PNfoLUOMrO41GWqDEpTOrWwkDMHJgDfeDHeyC0
	 Ytp9rzwE/av3YJEZt7kxUBmNxQi3+vA9zQe2Ex4ogfGjXbe4LEonZwHqRRnOOEWh++
	 CtTaNnMwl1t7w==
Subject: Re: [PATCH net v5 3/4] igb: do not split AF_XDP zero-copy frames over
 several Rx buffers
From: netdev-bot+sashiko@kernel.org
To: tkusters@aweta.nl
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 sven.auhagen@voleatech.de, richardcochran@gmail.com, kurt@linutronix.de,
 sriram.yagnaraman@ericsson.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 maciej.fijalkowski@intel.com, p@1g4.org, stable@vger.kernel.org,
 piotr.kwapulinski@intel.com, aleksandr.loktionov@intel.com,
 alexander.nowlin@intel.com
Date: Sun, 08 Nov 2026 07:18:26 +0000
Message-ID: <179412230633.994134.8603408637757773209@kernel.org>
In-Reply-To: <20261104-igb-rx-ts-fix-v5-3-bf4b4367129a@aweta.nl>
References: <20261104-igb-rx-ts-fix-v5-3-bf4b4367129a@aweta.nl>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch makes igb_setup_srrctl()
  (drivers/net/ethernet/intel/igb/igb_main.c, around line 4842) program…
- [Low] Two new comments in drivers/net/ethernet/intel/igb/igb_xsk.c
  contradict each other.

--

igb: do not split AF_XDP zero-copy frames over several Rx buffers

This patch programs SRRCTL.BSIZEPKT for AF_XDP zero-copy rings with the
same 2 KiB or 3 KiB buffer size as the other rings. Before, it used the
XSK frame size, rounded down to 1 KiB granularity. It also refuses XSK
pools and MTU changes when the frame plus the timestamp header would not
fit the XSK frame.

Link: https://lore.kernel.org/all/20261028083344.3047350-3-p@1g4.org/

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index cf9911137bd31..b286adedad5df 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -4833,9 +4833,13 @@ void igb_setup_srrctl(struct igb_adapter *adapter, struct igb_ring *ring)
>  	u32 srrctl = 0;
>  	u32 buf_size;
>  
> -	if (ring->xsk_pool)
> -		buf_size = xsk_pool_get_rx_frame_size(ring->xsk_pool);
> -	else if (ring_uses_large_buffer(ring))
> +	/* SRRCTL.BSIZEPKT has a 1 KiB granularity, so programming the XSK
> +	 * frame size would round it down and split frames over several
> +	 * buffers. XSK rings use the same buffer size as the other rings.
> +	 * While XDP is attached, the receive length limit keeps frames
> +	 * within the XSK frame, see igb_xsk_frame_fits().
> +	 */
> +	if (ring_uses_large_buffer(ring))
>  		buf_size = IGB_RXBUFFER_3072;
>  	else
>  		buf_size = IGB_RXBUFFER_2048;

[Severity: Medium]
Is a receive length limit always in force here while XDP is attached?
With 2 KiB chunks and the default headroom, the XSK frame is 1792 bytes.
BSIZEPKT is now 2048 or 3072.

With VFs allocated, igb_set_rlpml() leaves the global RLPML at
MAX_JUMBO_FRAME_SIZE. Only the PF pool's VMOLR carries the limit:

drivers/net/ethernet/intel/igb/igb_main.c:igb_set_rlpml() {
    ...
	if (igb_xdp_is_enabled(adapter)) {
		pool_rlpml = min(pool_rlpml, adapter->max_frame_size);
		if (!vfn)
			rlpml = min(rlpml, adapter->max_frame_size);
	}
	wr32(E1000_RLPML, rlpml);

	/* the PF pool's VMOLR is used on these MACs, see igb_set_rx_mode() */
	if (hw->mac.type < e1000_82576 || hw->mac.type > e1000_i350)
		return;
    ...
}

e1000_i354 is greater than e1000_i350, so the VMOLR write is skipped
there. igb_probe_vfs() only rules out VFs on i210, i211 and 82580, and
igb_enable_sriov() has no MAC type check.

Take an i354 PF with VFs and XSK zero-copy active. Could a peer that sends
a frame longer than the XSK frame make the NIC write up to 2048 or 3072
bytes, plus the timestamp header, starting at chunk + headroom? That
would run into the next UMEM chunk, or past the end of the last one. It
would be up to 256 bytes with 2 KiB buffers. With 3 KiB buffers it would
be about 1.3 KiB, for example MTU 1600 on 2 KiB chunks, which
igb_xsk_frame_fits() accepts.

The igb_xsk_frame_fits() checks in igb_xsk_pool(), igb_xsk_pool_enable()
and igb_change_mtu() only compare adapter->max_frame_size against the XSK
frame size. They only help if the MAC actually drops frames above
max_frame_size.

igb_clean_rx_irq_zc() passes the descriptor length to xsk_buff_set_size()
without checking it against the XSK frame size. The later patch in the
series, "igb: drop AF_XDP zero-copy frames that span several Rx buffers",
only drops frames without EOP. An over-long frame that fits in one 2 or
3 KiB hardware buffer has EOP set and would still be delivered.

Before this patch, BSIZEPKT was rounded down to at most the XSK frame
size. Frames were split, but the NIC could not write outside the frame.

Two hardware details could not be verified: whether i354 silicon exposes
SR-IOV, and whether the PF pool VMOLR, which is never programmed on i354,
limits the length anyway.

[ ... ]

> diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
> index ce4a7b58cad2f..fb04df82272ac 100644
> --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
> +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
> @@ -91,7 +91,20 @@ struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
>  	if (!igb_xdp_is_enabled(adapter))
>  		return NULL;
>  
> -	return (pool && pool->dev) ? pool : NULL;
> +	if (!pool || !pool->dev)
> +		return NULL;
> +
> +	/* the MTU check in igb_change_mtu() does not see a pool on a queue
> +	 * that was hidden at the time, for example by SR-IOV
> +	 */
> +	if (!igb_xsk_frame_fits(pool, adapter->max_frame_size)) {

[ ... ]

> @@ -110,6 +123,10 @@ static int igb_xsk_pool_enable(struct igb_adapter *adapter,
>  	    qid >= netdev->real_num_tx_queues)
>  		return -EINVAL;
>  
> +	/* igb_change_mtu() keeps this true while the pool is bound */
> +	if (!igb_xsk_frame_fits(pool, adapter->max_frame_size))
> +		return -EOPNOTSUPP;

[Severity: Low]
This isn't a bug, but does this comment contradict the one added to
igb_xsk_pool() above? That one says igb_change_mtu() does not see a pool
on a queue that was hidden at the time.

igb_change_mtu() finds pools through xsk_get_pool_from_qid(). That
returns NULL for a queue_id at or above both real_num_rx_queues and
real_num_tx_queues. So a pool bound on a hidden queue is not checked, and
igb_xsk_pool() can later drop it from zero-copy. The commit message
describes the same case.

Could this comment be reworded so it does not claim that igb_change_mtu()
always keeps this true while the pool is bound?

>  	err = xsk_pool_dma_map(pool, &adapter->pdev->dev, IGB_RX_DMA_ATTR);
>  	if (err)
>  		return err;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104-igb-rx-ts-fix-v5-0-bf4b4367129a%40aweta.nl
