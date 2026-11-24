Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795519740;
	b=Y5gbUcQJRZjee1+OSP9aVx63aRSqkCkaYH52alyhZf5mNZpaG1ZVwuHTYvAMqHSANEqy
	 jwHRjK4jks3ugRA2V8Wy6hrK04IFQhmO8+8MHrqOHBnqUzcSLjD+smVp9PzRY5Km6dV7Z
	 REynH9JnNt2s8Klnx6Ckm5lVK7HQBHUEtx5Bs18p4jrIMQqDKskyP8TNrqq6BfHjomTR5
	 FKylbt7cM53C1nLo0jUs5oKejUpjP+bv2PB8YwgFIXEqO6mZ8dueUyq22ZiH3V2N4AJbX
	 lT2AN+nUADLt23P4iP0UZVDHd4goVA4DGYycx+mwYPuDFyBfLFGkL1DylM3nNCkpxHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519740;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=tLnWd5jhubOeFNRkHGC8qqDZ8N8UGLt+6HY9hXZev7c=;
	b=qZ9Gh8M70EL4y91aNbHz/B4mNNEcPe5QnOPt4PTh/4DUgzZqeeTmj6IX8CGd91f3cf6g
	 +RuJaq9KORY7W912aLUw7yYsQo1oBqeiyzD05fw5pQ+Ynj+844YrXb/3tBqN38Eo2b3o5
	 OF/Zp+zWrp3eBTshmR+FtWnR26xcGKgsD0AvvWDSPPHZW4VzaIjc2VfI2ef3mPs4o9JeP
	 Dv1Mv7TUJM0ieU0Z/TfnB9NKI43oM6jG5A9MjvoZ9FqCELQ55s2wSQsNiRblGdOak3GGe
	 CSXbLQobM4s10iMp+Jwgccj4imZE34ZutOcRGKxxFsNwEXjLl860SMT6dEPe0bo8Gfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQlFSDZY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04F9606A32A;
	Tue, 24 Nov 2026 11:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQlFSDZY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46201F000CF;
	Tue, 24 Nov 2026 11:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795519739;
	bh=tLnWd5jhubOeFNRkHGC8qqDZ8N8UGLt+6HY9hXZev7c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AQlFSDZYR64armauKEVSNe6Wu9SaNzuS+A7VVAn/pvdYyNRgjnGn0la5OcsEBZcb5
	 Xa7er29p3u4mj4KAs3APV3EPmQbgbqbV+mMSfCm312q79v3rJf/ag7zM8k86aLT7yQ
	 cdfCSf1KMEEZsfPcBBddzIhmoVcVt3lCYQHi8hfc8bsKsu3clKtVzr9DGqiiVDLQVm
	 MbK9MLQIrldXLOrKDIFHiOkkDGqdL88rWzQYyygVcf6lTtG2QjtH6PiNZiPIKzE5Ll
	 v0pw5FBByM8yj6Z1dEe2ZTE9dI096b9ZpZPFnzkdXyMaLyBJQJF6HXzXQqHRE2oupI
	 Dde9sjK5u1R3A==
Subject: Re: [PATCH net v7 3/3] igb: do not split AF_XDP zero-copy frames over
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
 maciej.fijalkowski@intel.com, p@1g4.org, stable@vger.kernel.org
Date: Tue, 24 Nov 2026 11:28:57 +0000
Message-ID: <179551973728.3135.7219099542453397459@kernel.org>
In-Reply-To: <20261120-igb-rx-ts-fix-v7-3-63b03045978e@aweta.nl>
References: <20261120-igb-rx-ts-fix-v7-3-63b03045978e@aweta.nl>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This is a hardware-dependent DMA bound.

--

igb: do not split AF_XDP zero-copy frames over several Rx buffers

The patch programs SRRCTL.BSIZEPKT for AF_XDP zero-copy rings with the
same 2 KiB or 3 KiB buffer size as the other rings. Before, it used the
XSK frame size rounded down to 1 KiB. To keep DMA inside the XSK frame,
it relies on the receive length limit and adds checks on pool bind, MTU
change, ring setup and VF enable, so that the frame plus the timestamp
header fits.

Link: https://lore.kernel.org/all/20261028083344.3047350-3-p@1g4.org/

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index a59ee6575c560..d3165ae97b00d 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c

[ ... ]

> @@ -4846,9 +4882,13 @@ void igb_setup_srrctl(struct igb_adapter *adapter, struct igb_ring *ring)
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
After this change, BSIZEPKT can be larger than the XSK frame. With 2 KiB
aligned chunks and the default headroom, the XSK frame is 1792 bytes, but
BSIZEPKT is now 2048 (or 3072 with the 3K buffer flag). Before, BSIZEPKT
was never larger than the XSK frame, so the MAC could not DMA past it,
whatever the packet length.

The commit message says the receive length limit is now the only thing
that keeps the MAC inside the frame. Does that limit cover every ingress
path once VFs are enabled?

With VFs, igb_set_rlpml() leaves the global RLPML at MAX_JUMBO_FRAME_SIZE
and limits the PF only through its pool's VMOLR:

	if (igb_xdp_is_enabled(adapter)) {
		pool_rlpml = min(pool_rlpml, adapter->max_frame_size);
		if (!vfn)
			rlpml = min(rlpml, adapter->max_frame_size);
	}
	wr32(E1000_RLPML, rlpml);

igb_vmm_control() turns on loopback and replication whenever VFs exist:

	if (adapter->vfs_allocated_count) {
		igb_vmdq_set_loopback_pf(hw, true);
		igb_vmdq_set_replication_pf(hw, true);

A VF can also raise its own pool limit to 9728 with the
E1000_VF_SET_LPE mailbox message, which igb_set_vf_rlpml() handles.

The patch explicitly allows VFs to be enabled while a zero-copy socket
is bound to PF queue 0. So this setup can be reached: XDP and a 2 KiB
chunk XSK pool on PF queue 0, plus VFs assigned to guests.

Suppose the 82576/i350 internal switch does not apply the destination
pool's VMOLR.RLPML to VF-to-PF loopback frames. Could a VF then send a
jumbo frame to the PF MAC address and make the MAC write up to BSIZEPKT
bytes from the DMA start of the XSK frame?

For the second 2 KiB chunk of a 4 KiB page, the frame ends exactly at
the page boundary. That would mean writing 256 bytes past the page, or
1280 bytes with 3K buffers. Aligned-mode UMEM pages are DMA-mapped one
at a time, so those bytes would go into unrelated memory, or cause a
fault when an IOMMU is present.

The tests in the commit message only used wire frames from a peer. Was
the loopback path tested? One example would be a VF with MTU 9000
sending to the PF while a 2 KiB chunk zero-copy socket is bound to PF
queue 0.

igb_xsk_frame_fits() compares max_frame + IGB_TS_HDR_LEN with the XSK
frame size. It never compares the XSK frame size with the programmed
BSIZEPKT, so it would not catch an ingress path that skips the per-pool
length check.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261120-igb-rx-ts-fix-v7-0-63b03045978e%40aweta.nl
