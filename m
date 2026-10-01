Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD8A28CF4A;
	Thu,  1 Oct 2026 04:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790828233; cv=none; b=A8Au5S5d15fomS1t7xCLPIg4x9Eg4tNesfMf4fWo1W8z7B4amMs+7CfaJYYQstxRPMj71xyThmSwm84SDEtFmLv+u0m3+SSVJ6jD96YdtgLT0sOUnSaWBv9gdhFw4lBICkD1GHk50uw/dnT8CufpAcelTHjX+bWuAo91rYDx3sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790828233; c=relaxed/simple;
	bh=HNqC9ImeKXpKoY0L7IHJNUVcHX0wDeqcR9lyrPGeDDw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O1eHYwrMpVUGuKCCe6Rx6sc0lLKxVfpsIQ/LBulR4CuBi/K/oJtYUA/4m7+tepTldpkudj0EOBJjZoMoV27DQWThS+N7Dqbb/tCUzYseldYLvWQyzfBLgU1RSWxUE9m1NesJOfnWgEuRn7OvkBgfrJfX0fmKbSBmISHtcpPrPBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpDKSKjo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpDKSKjo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D471F000FF;
	Thu,  1 Oct 2026 04:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790828231;
	bh=DCTdZnnXkfiaYcO3EIy7ViyhvYACkMSzwEco8DzSd50=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BpDKSKjoE5FtOqCOrseyvfB5rmvRMUxZiiQICQeIekNnQNW9buTiIiX4Lhj4xk3bL
	 h4rufKUuq4Pwf43rlVFO4Yc/lb8pWQ3xKdvBGpIcvhO3dJc0mOyHNommpG1UOe00w+
	 QL4l/j/KSdIi0HHMAM0oReAq+D9jFaSrfTvs/uaqDAwwiuk0VBvBlVmiNbZeFlQyXF
	 1Fd+H4UN4JGLozTLuqY10NB1tzjeREcoWd2LKnD3t3Gl9CZ5ThjVnOk90A/HcLP5tc
	 39xZafnaBMkMOWx5Xq/e8FlWJsYFOXHSMxBgDjJK82MfDrRafvBuY23qVYTnsBorss
	 RX2mc01B/76LQ==
Subject: Re: [PATCH net] bnxt_en: don't leave an XDP program installed when
 the open fails
From: netdev-bot+sashiko@kernel.org
To: nagarevaibhav@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, vnagare@redhat.com,
 stable@vger.kernel.org
Date: Thu, 01 Oct 2026 04:17:09 +0000
Message-ID: <179082822982.434549.8559527057158002010@kernel.org>
In-Reply-To: <20260928131458.1012180-1-vnagare@redhat.com>
References: <20260928131458.1012180-1-vnagare@redhat.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 1 · High: 2 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] When an XDP attach fails (old == NULL, prog == P,
  bnxt_open_nic() fails), bnxt_xdp_set() resets bp->xdp_prog to NULL but…
- [High] The rollback in bnxt_xdp_set() also runs when a program is being
  removed (prog == NULL).
- [High] When an XDP detach fails (old == P, prog == NULL,
  bnxt_open_nic() fails), bnxt_xdp_set() leaves the no-XDP configuration…
- [Medium] When a replace (old == O, prog == N) fails in bnxt_open_nic(),
  dev->max_mtu keeps the value __bnxt_set_rx_skb_mode() computed from…
- [Low] The From: author (Vaibhav Nagare <nagarevaibhav@gmail.com>) does
  not match the only Signed-off-by (Vaibhav Nagare <vnagare@redhat.com>).

--

bnxt_en: don't leave an XDP program installed when the open fails

This patch changes bnxt_xdp_set() so it keeps the reference on the previous
XDP program until bnxt_open_nic() succeeds. If the open fails, the previous
program is written back into bp->xdp_prog. The ring and feature
configuration computed for the rejected program is left in place on
purpose.

> Signed-off-by: Vaibhav Nagare <vnagare@redhat.com>

[Severity: Low]
This isn't a bug, but the From: address (nagarevaibhav@gmail.com) doesn't
match the Signed-off-by: address (vnagare@redhat.com). checkpatch reports
this as FROM_SIGN_OFF_MISMATCH.

Could the sign-off use the From: address, or the From: be changed to match?

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> index 9e5009be8e98..f30ce644e377 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> @@ -419,8 +419,6 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
>  		bnxt_close_nic(bp, true, false);
>  
>  	old = xchg(&bp->xdp_prog, prog);
> -	if (old)
> -		bpf_prog_put(old);
>  
>  	if (prog) {
>  		bnxt_set_rx_skb_mode(bp, true);
> @@ -435,8 +433,16 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
>  	bnxt_set_tpa_flags(bp);
>  	bnxt_set_ring_params(bp);
>  
> -	if (netif_running(dev))
> -		return bnxt_open_nic(bp, true, false);
> +	if (netif_running(dev)) {
> +		rc = bnxt_open_nic(bp, true, false);
> +		if (rc) {
> +			WRITE_ONCE(bp->xdp_prog, old);
> +			return rc;
> +		}
> +	}
> +
> +	if (old)
> +		bpf_prog_put(old);

[Severity: High]
Does this rollback also run when a program is being removed (prog == NULL)?

In that case old is the attached program P. If bnxt_open_nic() fails, P is
written back into bp->xdp_prog and bpf_prog_put(old) is skipped, so bnxt
keeps both P and its reference.

Some callers treat a failed removal as finished anyway.
dev_xdp_detach_link() is reached from bpf_xdp_link_release() when the last
link fd is closed, and from BPF_LINK_DETACH. It does:

net/core/dev.c:dev_xdp_detach_link() {
    ...
	WARN_ON(dev_xdp_install(dev, mode, bpf_op, NULL, 0, NULL));
	dev_xdp_set_link(dev, mode, NULL);
    ...
}

__bond_release_one() only warns before it releases the slave:

drivers/net/bonding/bond_main.c:__bond_release_one() {
    ...
		if (dev_xdp_propagate(slave_dev, &xdp))
			slave_warn(bond_dev, slave_dev, "failed to unload XDP program\n");
    ...
}

The rollback loop in bond_xdp_set() behaves the same way when it goes back
to old_prog == NULL.

After any of these, the core has no program for the device. At unregister,
dev_xdp_uninstall() therefore skips the mode:

		prog = dev_xdp_prog(dev, mode);
		if (!prog)
			continue;

so ndo_bpf(NULL) is never called. bnxt only drops the reference held in
bp->xdp_prog from bnxt_xdp_set(). Does this leak P and its maps?

bnxt also keeps treating P as live. bnxt_fix_features() strips LRO/GRO_HW,
and bnxt_change_mtu() does:

	if (READ_ONCE(bp->xdp_prog))
		bnxt_set_rx_skb_mode(bp, true);

After an MTU change and the next open, could P run on RX even though
userspace sees no attached program?

Before this patch, this path dropped P and left bp->xdp_prog == NULL, which
matched the core's view. For the removal case, would it be better to commit
the removal and put old even when the reopen fails?

[Severity: High]
On the same removal failure path, only the pointer is rolled back. The
following state stays as computed for "no XDP":

- bnxt_set_rx_skb_mode(bp, false) has cleared BNXT_FLAG_RX_PAGE_MODE, set
  rx_dir = DMA_FROM_DEVICE and set dev->max_mtu = bp->max_mtu.
- xdp_features have been cleared.
- tx_nr_rings_xdp is 0, and tx_nr_rings has no XDP rings.

On a plain reopen, bnxt_init_one_rx_ring() won't attach P because page mode
is clear:

	if (BNXT_RX_PAGE_MODE(bp) && bp->xdp_prog) {
		bpf_prog_add(bp->xdp_prog, 1);
		rxr->xdp_prog = bp->xdp_prog;
	}

so P silently doesn't run.

If the MTU is changed later, bnxt_change_mtu() sees bp->xdp_prog != NULL
and turns page mode back on. The XDP TX rings are not recreated, and the
MTU/frags check at the top of bnxt_xdp_set() is not repeated.

With tx_nr_rings_xdp == 0, bnxt_alloc_mem() sets up every TX ring as a
stack queue completed by bnxt_tx_int(). That makes bnapi->tx_ring[0] a
netdev TX ring. On XDP_TX, bnxt_rx_xdp() posts to that ring from NAPI:

	txr = rxr->bnapi->tx_ring[0];
	/* BNXT_RX_PAGE_MODE(bp) when XDP enabled */

and it does so without the txq lock. Can this race bnxt_start_xmit() on the
same producer index and doorbell?

Those XDP BDs are then completed by __bnxt_tx_int(), which expects an skb:

		if (unlikely(!skb)) {
			bnxt_sched_reset_txr(bp, txr, cons);
			return rc;
		}

Would this trigger TX ring resets? Would it also skip the RX producer
bookkeeping that bnxt_tx_int_xdp() normally does?

[Severity: Critical]
In the attach case (old == NULL, prog == P), bp->xdp_prog goes back to NULL,
but the page mode setup computed for P stays. The commit message says:

  The ring and feature configuration is left as computed for the rejected
  program; the device stays down on this path, and reconciling it is left
  for a separate change.

The admin can still change the MTU and bring the device back up. Is it safe
to reopen from this state?

Several things stay as they were set for P:

- BNXT_FLAG_RX_PAGE_MODE stays set.
- BNXT_FLAG_NO_AGG_RINGS stays set. __bnxt_set_rx_skb_mode() sets it when
  MTU <= BNXT_MAX_PAGE_MODE_MTU.
- rx_dir stays DMA_BIDIRECTIONAL.
- dev->max_mtu stays raised if P supports frags.
- The XDP TX rings stay in tx_nr_rings.

Suppose the MTU is then raised, e.g. to 9000. bnxt_change_mtu() skips
bnxt_set_rx_skb_mode() because bp->xdp_prog is NULL, and
bnxt_set_ring_params() runs with the stale flags:

	if (rx_space > PAGE_SIZE && !(bp->flags & BNXT_FLAG_NO_AGG_RINGS)) {

JUMBO is skipped and TPA is off, so agg_factor is 0. That means the page
mode rx_size clamp inside the agg_factor block is skipped too, and
bp->rx_buf_use_size ends up around 9K.

On ifup, bnxt_alloc_rx_data() still takes the BNXT_RX_PAGE_MODE branch and
backs each BD with one order-0 page_pool page. Meanwhile
bnxt_init_one_rx_ring_rxbd() programs:

	type = (bp->rx_buf_use_size << RX_BD_LEN_SHIFT) |
		RX_BD_TYPE_RX_PACKET_BD | RX_BD_FLAGS_EOP;

Can the NIC then DMA a received jumbo frame past the end of that page?

NDO_XMIT also stays advertised in xdp_features, but bnxt_xdp_xmit() rejects
every frame:

	if (!test_bit(BNXT_STATE_OPEN, &bp->state) ||
	    !bp->tx_nr_rings_xdp ||
	    !xdp_prog)
		return -EINVAL;

Should the RX mode and ring configuration be reverted here as well as the
pointer?

[Severity: Medium]
In the replace case (old == O, prog == N), bnxt_set_rx_skb_mode(bp, true)
ran while bp->xdp_prog was N. That means __bnxt_set_rx_skb_mode() computed
dev->max_mtu from N:

		if (bp->xdp_prog->aux->xdp_has_frags)
			dev->max_mtu = min_t(u16, bp->max_mtu, BNXT_MAX_MTU);

If N supports frags and O doesn't, max_mtu stays above
BNXT_MAX_PAGE_MODE_MTU after O is restored, and IFLA_MAX_MTU reports that
higher limit.

Can the MTU then be raised past BNXT_MAX_PAGE_MODE_MTU while the non-frags
O is attached? The check at the top of bnxt_xdp_set() is meant to prevent
that.

bnxt_change_mtu() would then call bnxt_set_rx_skb_mode(bp, true) and select
BNXT_FLAG_JUMBO and bnxt_rx_multi_page_skb. O would then receive
multi-buffer xdp_buffs, which it never declared support for.

>  
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928131458.1012180-1-vnagare%40redhat.com
