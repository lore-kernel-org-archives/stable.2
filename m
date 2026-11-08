Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794122307;
	b=Nhtg/vZdaQ5inhMdJneTmlFLE/JL5NQU3JR8Y9EziFx6Ivm5EfIh+L3aT4jBXtanUsOb
	 ZZs/G3+GaXLRoYkvCxTgVYlHcEovP6B1zAGsYk4QSfZbeDbxfp34qgg8X8tNZQYn5Ibh5
	 Z4uCmo6SaSsRkCGM+q4Bfs136vsIcp0cn6do12pKeU/HolfRHWvhmwdWK4q7fEtTTxNOP
	 GIeB4w2qhyfIClLa/LetVeXUq1dsyk1jvvA4wcozZpqfJyeT77koFU0/ooVkDSLvxSWda
	 dsNRepoQ6mr3M3q643eIdtAmnZk6CzIuVUj50//z2jDqhphyAtmyGNibRvkySeVLz9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794122307;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=V2g5gJoLJ/ti0qBR40G1KW7UssJ842zGOylJ9bRHcPU=;
	b=onw7mzkxBnubz0YiSB/psj2McyMg2jG4Sz/bwO2vrFqouS+rLeQyQ1lPuNr61i67LAMu
	 ZSOvXzXEbWNDBjjj0ZNHZDIiTW7GuUdMEhvG/MPNgiGv6v0ljdXDm0NYNz7Z6nRKcXDeP
	 hR4qxnw3BlZxRXTOaiOmc6wtXtl31uTfwkBTDmoyt1riLkkL3x2zl8NaJyO40oAndxu1T
	 1pgYhwC17NLF9R28bkvp/n+BOqjQupXaqlJQJfpb4W1bjQ7qKCfS0zzpFlDkswHmE8951
	 i4qJt6k6unKHsXzXhjdxHA56Thz1B/GAeCD/ydKGE7kshqt3KsGou2ayffZCaplXk4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IX90sMAQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2435606A31C;
	Sun,  8 Nov 2026 07:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IX90sMAQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51D01F0089F;
	Sun,  8 Nov 2026 07:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794122306;
	bh=V2g5gJoLJ/ti0qBR40G1KW7UssJ842zGOylJ9bRHcPU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IX90sMAQt0TiYvZM0q/AZaA7gD5JmvYqQU3Uu+aOXjRRHXFuDc2XuYQ6GdiXeVwik
	 Pizw2Fojya5jzei1CN6CAP1k3cUiyfb/+8UMsdZSZhYuEWuyGceS1SHdJbczmimyBX
	 eka29b3zeHBDae2rxygpv3ZzVsEf9Ic8+ER/se7adkSL4ORsMlSCe7b6zS+pIn17oh
	 D1Sp0SuVihs6wwd+O+ByOWNAa6olqbiP21HQ4L7/mWGUfRkKb2aDVyF6hNVcAWwMOB
	 NzwpBafMzW3R00n+X1hN/kFTwv5B+h+3TxXtImCkam5OhLusA24spBGcmIZLleGo1Q
	 fNfI1c1OJo6Cw==
Subject: Re: [PATCH net v5 1/4] igb: do not let XDP frames span more than one
 Rx buffer
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
Date: Sun, 08 Nov 2026 07:18:24 +0000
Message-ID: <179412230443.994134.1015628730237451247@kernel.org>
In-Reply-To: <20261104-igb-rx-ts-fix-v5-1-bf4b4367129a@aweta.nl>
References: <20261104-igb-rx-ts-fix-v5-1-bf4b4367129a@aweta.nl>
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

- [High] On i354 with VFs allocated, igb_set_rlpml()
  (drivers/net/ethernet/intel/igb/igb_main.c) programs no receive-length…

--

igb: do not let XDP frames span more than one Rx buffer

While XDP is attached, this patch limits the receive length to the
configured maximum frame size. It uses RLPML when no VFs are allocated
and the PF pool's VMOLR otherwise. It also tightens the XDP frame size
check, refuses XDP with rx-all, blocks legacy-rx changes while XDP is
attached, and moves the limit programming into a new igb_set_rlpml()
called from igb_configure().

Link: https://lore.kernel.org/all/20261028083344.3047350-3-p@1g4.org/

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index ce91dda00ec0e..8abdd4e58550d 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -1964,6 +1964,54 @@ static void igb_setup_tx_mode(struct igb_adapter *adapter)

[ ... ]

> +static void igb_set_rlpml(struct igb_adapter *adapter)
> +{
> +	u32 rlpml = MAX_JUMBO_FRAME_SIZE, pool_rlpml = MAX_JUMBO_FRAME_SIZE;
> +	unsigned int vfn = adapter->vfs_allocated_count;
> +	struct e1000_hw *hw = &adapter->hw;
> +	u32 vmolr;
> +

[ ... ]

> +	/* XDP does not support frames that span more than one Rx buffer.
> +	 * With VFs the global limit stays large and the PF pool is limited
> +	 * through VMOLR.
> +	 */
> +	if (igb_xdp_is_enabled(adapter)) {
> +		pool_rlpml = min(pool_rlpml, adapter->max_frame_size);
> +		if (!vfn)
> +			rlpml = min(rlpml, adapter->max_frame_size);
> +	}
> +	wr32(E1000_RLPML, rlpml);
> +
> +	/* the PF pool's VMOLR is used on these MACs, see igb_set_rx_mode() */
> +	if (hw->mac.type < e1000_82576 || hw->mac.type > e1000_i350)
> +		return;

[Severity: High]
What happens on i354 when VFs are allocated and an XDP program is attached?

With vfn != 0, RLPML is written as MAX_JUMBO_FRAME_SIZE. In enum
e1000_mac_type, e1000_i354 comes right after e1000_i350:

	e1000_i350,
	e1000_i354,
	e1000_i210,

So on i354 this early return is taken and pool_rlpml is never written
to VMOLR(vfn). No receive length limit is programmed in that setup, and
the comment above ("the PF pool is limited through VMOLR") does not hold.

igb_probe_vfs() only rules out SR-IOV on i210, i211 and 82580, so VFs
can be allocated on i354:

	if ((hw->mac.type == e1000_i210) || (hw->mac.type == e1000_i211) ||
	    (hw->mac.type == e1000_82580))
		return;

igb_xdp_setup() and igb_xdp_frame_fits() do not refuse XDP in this
setup either.

Could frames up to 9728 bytes still reach the PF rings over several
descriptors in that case? igb_clean_rx_irq() would then run the XDP
program on a continuation buffer as if it were a new frame. That is the
failure the commit message says this patch fixes.

The skip does not look like a hardware limit. igb_set_vf_rlpml() writes
the RLPML field of VMOLR(n) with no MAC type check:

	vmolr = rd32(E1000_VMOLR(vfn));
	vmolr &= ~E1000_VMOLR_RLPML_MASK;
	vmolr |= size | E1000_VMOLR_LPE;

The > e1000_i350 check seems to come from the unrelated early return in
igb_set_rx_mode().

Should the PF pool VMOLR limit also be written on i354? Or should XDP be
refused on i354 while VFs are allocated? The commit message only says:

  As before, the PF pool's VMOLR is not written on i354.

It does not mention that this setup stays unprotected.

This also matters for a later patch in the series, "igb: do not split
AF_XDP zero-copy frames over several Rx buffers". That patch programs
2 KiB and 3 KiB SRRCTL buffers for XSK rings whose XSK frame can be as
small as 1792 bytes. It relies on this receive length limit, as its
commit message says: "Without it, the hardware can write past the XSK
frame".

On i354 with VFs, could the NIC then DMA past the end of the XSK frame?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104-igb-rx-ts-fix-v5-0-bf4b4367129a%40aweta.nl
