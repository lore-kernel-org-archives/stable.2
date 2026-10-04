Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4472222A9;
	Sun,  4 Oct 2026 07:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791098621; cv=none; b=seZawnlaapBnzql8l9CTYU/wRbXvdOCCZpq2HJvRiuvz3pabrTJH4zHcrr16LoQiXrisn8ew42ERxtMapCpTKR3FtPhCQ2ioFXyfD4eHyhKIgWM9fCzfmkXj3Hf8t4MTBNo73d5oKK1/QOrhSdXxRo9klXjmTefLFmVLE2IbqQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791098621; c=relaxed/simple;
	bh=HatJrxYG1cE6MuvHrUiOoYJ6rQO+Uw3uzeyQcr35xg4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gOiWKOqyxrJPZY66sl/P82CfouEb3TVNhUIrcMtI6Qp6MxVdfz0KoRMCsDg/4pfokebnPi00Fiu9I9s9Mt8jm2ZgE1TjKYVji28/RHZhTiyYkX8mFFSKX5/0wrlMOAjL2mvQjfORbKpJZQfQNzzgbEv5AW9rvlcFRCxrsxdDmCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fU0eod16; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fU0eod16"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE611F000FF;
	Sun,  4 Oct 2026 07:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791098620;
	bh=oQXwsdQpk7Vk2ih8888N0lW91mEJ/GWtcppa+56cpgg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fU0eod16qU5qhBffAgBGHODy2bY7KKGLD0dm1YcCTPovJB7yLSnjX88ckWg1VCnXq
	 dEnJSp3kzgq16qWFPy0r4TO67UWjmvrXWNXXtf+mXlrY0oThBXQLyAVqmXaGPAzlHR
	 /cDv49q8oV7EVYWqEVepz2sduwhCDXz0X7J7LXOvfyw1yy8kpsg/P+mbGhnGUq+D+l
	 j5y1pjTEYJt7l31aOHXv4lrLwjLAfFuU7ZE8WzLKugJ378GADS8AyATPNHoxsVdIDb
	 qyxVUQaQlG2g5Z+/a9lI8ubdeSygvhvSdhtNJGwa3yKmcQkE02X7op4gA+pVosfIHE
	 P7/nCnIGnipfg==
Subject: Re: [PATCH net v2] bnxt_en: don't leave an XDP program installed when
 the open fails
From: netdev-bot+sashiko@kernel.org
To: vnagare@redhat.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 nagarevaibhav@gmail.com, stable@vger.kernel.org
Date: Sun, 04 Oct 2026 07:23:38 +0000
Message-ID: <179109861868.434549.4936218583368176211@kernel.org>
In-Reply-To: <20260930070901.1218980-1-vnagare@redhat.com>
References: <20260930070901.1218980-1-vnagare@redhat.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new error path in bnxt_xdp_set() also rolls back a detach.
- [Medium] The v2 rollback does not restore 'the ring and feature
  configuration that was in service before the change', as the commit…

--

bnxt_en: don't leave an XDP program installed when the open fails

With this patch, when bnxt_open_nic() fails, bnxt_xdp_set() puts the
previous XDP program back into bp->xdp_prog. The old program's reference
is now dropped only after the change succeeds. The ring and feature setup
moves into a new bnxt_xdp_apply_cfg() helper, and the error path runs it
again with the previous XDP TX ring count.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> index 9e5009be8e989..edfd751a601ab 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> @@ -381,11 +381,31 @@ int bnxt_xdp_xmit(struct net_device *dev, int num_frames,
>  	return nxmit;
>  }
>  
> +static void bnxt_xdp_apply_cfg(struct bnxt *bp, int tx_xdp)
> +{
> +	struct net_device *dev = bp->dev;
> +	int tc = bp->num_tc ? : 1;
> +
> +	if (bp->xdp_prog) {
> +		bnxt_set_rx_skb_mode(bp, true);
> +		xdp_features_set_redirect_target_locked(dev, true);
> +	} else {
> +		xdp_features_clear_redirect_target_locked(dev);
> +		bnxt_set_rx_skb_mode(bp, false);
> +	}
> +	bp->tx_nr_rings_xdp = tx_xdp;
> +	bp->tx_nr_rings = bp->tx_nr_rings_per_tc * tc + tx_xdp;
> +	bnxt_set_cp_rings(bp, true);
> +	bnxt_set_tpa_flags(bp);
> +	bnxt_set_ring_params(bp);
> +}

[ ... ]

> @@ -418,25 +438,21 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
>  	if (netif_running(dev))
>  		bnxt_close_nic(bp, true, false);
>  
> +	old_tx_xdp = bp->tx_nr_rings_xdp;
>  	old = xchg(&bp->xdp_prog, prog);
> -	if (old)
> -		bpf_prog_put(old);
> -
> -	if (prog) {
> -		bnxt_set_rx_skb_mode(bp, true);
> -		xdp_features_set_redirect_target_locked(dev, true);
> -	} else {
> -		xdp_features_clear_redirect_target_locked(dev);
> -		bnxt_set_rx_skb_mode(bp, false);
> +	bnxt_xdp_apply_cfg(bp, tx_xdp);

[Severity: Medium]

The commit message says the error path will "restore the ring and feature
configuration that was in service before the change". Before the forward
bnxt_xdp_apply_cfg() and bnxt_open_nic() run, though, only bp->xdp_prog
and bp->tx_nr_rings_xdp are saved.

The rollback call below rebuilds the configuration from the state that the
forward path and the failed open left in bp. It does not restore saved
values.

Can the RX ring size get lost here? A non-frags program with MTU at or
below BNXT_MAX_PAGE_MODE_MTU sets BNXT_FLAG_NO_AGG_RINGS. In that state,
bnxt_set_ringparam() accepts rx_pending up to BNXT_MAX_RX_DESC_CNT and
nothing clamps it.

On detach, bnxt_set_rx_skb_mode(bp, false) clears NO_AGG_RINGS, and
bnxt_set_tpa_flags() turns TPA back on. bnxt_set_ring_params() then
lowers the size:

bnxt_set_ring_params() {
    ...
	if (agg_factor) {
		if (ring_size > BNXT_MAX_RX_DESC_CNT_JUM_ENA) {
			ring_size = BNXT_MAX_RX_DESC_CNT_JUM_ENA;
			...
			bp->rx_ring_size = ring_size;
		}
    ...
}

Now suppose bnxt_open_nic() fails. The rollback turns page mode back on,
but it recomputes the ring masks from the already reduced
bp->rx_ring_size. The user's RX ring size ends up smaller even though
ndo_bpf returned an error.

What happens to the ring and TC counts? By the time bnxt_alloc_mem()
fails, __bnxt_open_nic() has already run bnxt_reserve_rings() and
bnxt_adj_tx_rings():

- __bnxt_reserve_rings() writes the firmware-granted counts into
  bp->tx_nr_rings, bp->rx_nr_rings and bp->cp_nr_rings.
- bnxt_adj_tx_rings() rewrites bp->tx_nr_rings_per_tc.

The TC mismatch path in bnxt_reserve_rings() also does this before
returning:

	if (tcs && (bp->tx_nr_rings_per_tc * tcs !=
		    bp->tx_nr_rings - bp->tx_nr_rings_xdp)) {
		netdev_err(bp->dev, "tx ring reservation failure\n");
		netdev_reset_tc(bp->dev);
		bp->num_tc = 0;
		if (bp->tx_nr_rings_xdp)
			bp->tx_nr_rings_per_tc = bp->tx_nr_rings_xdp;
		else
			bp->tx_nr_rings_per_tc = bp->tx_nr_rings;
		return -ENOMEM;
	}

bnxt_xdp_apply_cfg(bp, old_tx_xdp) then computes bp->tx_nr_rings from
these overwritten tx_nr_rings_per_tc and num_tc values. The TC map is
not restored.

For example, take a failed detach where the reservation reduced
rx_nr_rings from r to r' < r. It would end with tx_nr_rings_xdp = r and
rx_nr_rings = r'. The next open's bnxt_adj_tx_rings() may recompute
tx_nr_rings_xdp, so this mismatch might not last. The rx_ring_size and
TC changes do stay.

Could rx_ring_size, tx_nr_rings_per_tc, rx_nr_rings and num_tc be saved
before the change and restored before recomputing? Alternatively, the
claim in the commit message could be narrowed.

> +
> +	if (netif_running(dev)) {
> +		rc = bnxt_open_nic(bp, true, false);
> +		if (rc) {
> +			WRITE_ONCE(bp->xdp_prog, old);
> +			bnxt_xdp_apply_cfg(bp, old_tx_xdp);
> +			return rc;
> +		}

[Severity: High]

Does this rollback also apply when prog == NULL, i.e. a detach? In that
case old is put back into bp->xdp_prog, page mode comes back on, and
bpf_prog_put(old) is skipped, so the driver keeps its reference.

Some ndo_bpf callers assume a detach cannot fail and carry on anyway.
dev_xdp_detach_link(), reached from bpf_xdp_link_release() and
bpf_xdp_link_detach(), does this:

	bpf_op = dev_xdp_bpf_op(dev, mode);
	WARN_ON(dev_xdp_install(dev, mode, bpf_op, NULL, 0, NULL));
	dev_xdp_set_link(dev, mode, NULL);
	return 0;

dev_xdp_set_link() clears both link and prog in dev->xdp_state. Bonding
behaves the same way in __bond_release_one():

		if (dev_xdp_propagate(slave_dev, &xdp))
			slave_warn(bond_dev, slave_dev, "failed to unload XDP program\n");

Before this patch, bnxt had already dropped old and cleared
bp->xdp_prog, so the core and the driver agreed that nothing was
attached. After this patch they disagree.

bnxt_open_nic() calls netif_close() on failure. On the next
"ip link set up", bnxt_init_one_rx_ring() finds the program:

	if (BNXT_RX_PAGE_MODE(bp) && bp->xdp_prog) {
		bpf_prog_add(bp->xdp_prog, 1);
		rxr->xdp_prog = bp->xdp_prog;
	}

Would the detached program then run on every RX ring again, while
"ip link" shows no XDP program attached?

A later netlink detach would not reach the driver either.
dev_xdp_attach() skips ndo_bpf when new_prog == cur_prog, and both are
NULL at that point. At unregister, dev_xdp_uninstall() skips modes where
the core's prog is NULL.

The only place bnxt drops bp->xdp_prog is bnxt_xdp_set(). Does that mean
the reference to the program and its maps leaks unless another program
is attached later?

The legacy netlink path does keep the old program on error, which matches
the new behaviour. The link release and bonding release callers above do
not.

>  	}
> -	bp->tx_nr_rings_xdp = tx_xdp;
> -	bp->tx_nr_rings = bp->tx_nr_rings_per_tc * tc + tx_xdp;
> -	bnxt_set_cp_rings(bp, true);
> -	bnxt_set_tpa_flags(bp);
> -	bnxt_set_ring_params(bp);
>  
> -	if (netif_running(dev))
> -		return bnxt_open_nic(bp, true, false);
> +	if (old)
> +		bpf_prog_put(old);
>  
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930070901.1218980-1-vnagare%40redhat.com
