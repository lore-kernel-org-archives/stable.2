Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A20E4A0913;
	Mon,  5 Oct 2026 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210987; cv=none; b=UADBN9tVVXU8/dwGPnSWFBQaCO1YBACHrajk3KvP/WPm6bRuuEiTIRAttntUpHmaTY0qUFAJVduIKdj+MoX24L7zB+DYfNO5d5hHDSp5AXZXFWjU6MzITq5G+eIeLFNZxsIOs5m1aeL/WAn1JN97mGek8idsXKDHIhKydKf0df0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210987; c=relaxed/simple;
	bh=QAhqbUCEw/Bi8WuZmwKE/HrWWVNb0rmCqV15FbxleqQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QxWCM4Wt6ZpKlWeLsGz4uY6ULyYlokyzvq852o3mrfGO5tWSgFMAp5Z8ScbGq5AB7O2gaoyTlihSXSoyl656jq5ltMSIzT2oALhttb9UaKxymokfxL4ZOw0rvKpiDueUzeBUdVhEd9S2U9eAsVEnsWmJB3b6k5RThHmgc8xZN/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tpgff4Vm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tpgff4Vm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0DD1F000FF;
	Mon,  5 Oct 2026 14:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791210974;
	bh=2LUuyLYUKU9h7Ea0wFMspyzfBUMYJEXCWcPXe6626t4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Tpgff4Vm9fIiigwJoq2GholDOdF2CO6WQdQlyagDXV2i7ygFlxv3T+eRi6eaXwKWS
	 9abwB5aLISbts6K7xhq4sw/MwXBwiKG0fDNJ/lZNA63Xv7TGr/5+pL9cPSHvSX7flC
	 FRyHKGVZQpo0K0RTQ831zTSEBRIWQA0WEZgzSxd3QJcdc0yamMC0+nShcrzjJiKiVE
	 1Gc0pEoWfxhA8B2zs8nOF3w/SVvJpR6g/Ne2uR+97yuzfqD/js6+39K8Lz0A6r5ZCg
	 DotIlrQtv4Nsgm4GL4Nr67X6Ki3O43NVLmbKLTvU5vDLS20PgBtQZhzJCnKi54zekH
	 VrdGGxOm7s5BA==
Subject: Re: [PATCH net v3] bnxt_en: don't leave an XDP program installed when
 the open fails
From: netdev-bot+sashiko@kernel.org
To: vnagare@redhat.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 nagarevaibhav@gmail.com, stable@vger.kernel.org
Date: Mon, 05 Oct 2026 14:36:12 +0000
Message-ID: <179121097298.434549.15823633516902971097@kernel.org>
In-Reply-To: <20261001142516.1386525-1-vnagare@redhat.com>
References: <20261001142516.1386525-1-vnagare@redhat.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The rollback after a failed attach does not restore the RX
  aggregation-ring mode that existed before the attach.
- [Low] Detach now hides a failed reopen and returns success, and neither
  the commit message nor the code comment says so.

--

bnxt_en: don't leave an XDP program installed when the open fails

This patch changes bnxt_xdp_set() so the old program is released only
after bnxt_open_nic() succeeds. When an attach or a replace fails, the
previous program and its ring configuration are put back. The ring and
feature setup moves into a new helper, bnxt_xdp_apply_cfg(), and a detach
whose reopen fails is not undone.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> index 9e5009be8e989..430272fc0594a 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c

[ ... ]

> @@ -418,25 +438,22 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
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
> +
> +	if (netif_running(dev)) {
> +		rc = bnxt_open_nic(bp, true, false);
> +		/* dev_xdp_detach_link() drops the ref even if we fail */
> +		if (rc && prog) {

[Severity: Low]
On a detach, prog is NULL, so if bnxt_open_nic() fails the error never
reaches the caller. The code falls through to bpf_prog_put(old) and
returns 0. By that point bnxt_open_nic() has already closed the device:

bnxt_open_nic() {
    ...
	if (rc) {
		netdev_err(bp->dev, "nic open fail (rc: %x)\n", rc);
		netif_close(bp->dev);
	}
    ...
}

Before this patch the detach path ended with return bnxt_open_nic(...),
so callers saw the error. Those callers include "ip link set dev X xdp
off", a bpf_link detach and bonding propagation. Now they all report
success while the port is down.

Returning 0 may be the better choice, since it keeps core and driver
state consistent. Could the commit message say explicitly that a failed
reopen during detach now returns success and leaves the device closed?
The patch is tagged for stable, so this change is visible to users there
too.

The in-code comment also looks imprecise. dev_xdp_detach_link() does not
drop a prog reference itself. It warns on a driver error and clears the
link:

dev_xdp_detach_link() {
    ...
	WARN_ON(dev_xdp_install(dev, mode, bpf_op, NULL, 0, NULL));
	dev_xdp_set_link(dev, mode, NULL);
    ...
}

This branch also handles the fd based dev_xdp_attach() path. On a driver
error that path returns early, and the core keeps cur_prog together with
its own reference:

dev_xdp_attach() {
    ...
		err = dev_xdp_install(dev, mode, bpf_op, extack, flags, new_prog);
		if (err)
			return err;
    ...
}

Could the comment be reworded to cover both paths and to say that rc is
dropped on purpose for a detach?

> +			WRITE_ONCE(bp->xdp_prog, old);
> +			bnxt_xdp_apply_cfg(bp, old_tx_xdp);
> +			return rc;

[Severity: Medium]
When old is NULL (a fresh attach), this rollback rebuilds the ring mode
by calling bnxt_xdp_apply_cfg() with bp->xdp_prog == NULL. That goes
through bnxt_set_rx_skb_mode(bp, false). Does that path actually undo
the page mode setup?

In page mode, __bnxt_set_rx_skb_mode() clears both agg ring flags
unconditionally:

	if (page_mode) {
		bp->flags &= ~(BNXT_FLAG_AGG_RINGS | BNXT_FLAG_NO_AGG_RINGS);
		bp->flags |= BNXT_FLAG_RX_PAGE_MODE;
		...
		if (dev->mtu > BNXT_MAX_PAGE_MODE_MTU) {
			bp->flags |= BNXT_FLAG_JUMBO;

The non page mode branch of bnxt_set_rx_skb_mode() only clears
BNXT_FLAG_NO_AGG_RINGS, and only when bnxt_get_max_rings() reports
rx > 1. It never sets the flag again.

Take a function where bnxt_get_dflt_rings() decided at probe that agg
rings cannot be afforded:

	bp->flags |= BNXT_FLAG_NO_AGG_RINGS;
	bp->dev->hw_features &= ~(NETIF_F_LRO | NETIF_F_GRO_HW);

If the MTU is above BNXT_MAX_PAGE_MODE_MTU and a program with
xdp_has_frags is attached, the sequence would be:

bnxt_xdp_set()
  bnxt_check_rings()        /* passes with pre-attach flags */
  bnxt_xdp_apply_cfg()
    __bnxt_set_rx_skb_mode(bp, true)  /* clears NO_AGG_RINGS, sets JUMBO */
  bnxt_open_nic()
    __bnxt_reserve_rings()  /* RX doubled, hwr.rx < 2 */

and __bnxt_reserve_rings() fails here:

	if (bp->flags & BNXT_FLAG_AGG_RINGS) {
		if (hwr.rx >= 2) {
			rx_rings = hwr.rx >> 1;
		} else {
			if (netif_running(bp->dev))
				return -ENOMEM;

During the rollback, bnxt_get_max_rings() still sees JUMBO, so it halves
max_rx to 0 and fails. NO_AGG_RINGS therefore stays cleared.
bnxt_set_ring_params() then finds rx_space > PAGE_SIZE without
NO_AGG_RINGS and sets JUMBO again.

bnxt_open_nic() has already closed the device. Won't every later "ip link
set up" fail with the same -ENOMEM in __bnxt_reserve_rings()? That would
leave the port unusable until the MTU is lowered or the driver is
reloaded.

The commit message says:

    Restore the previous program and its ring and feature configuration
    when an attach or a replace fails

Would it be more reliable to snapshot and restore the state instead of
recomputing it? That would cover the relevant bp->flags bits
(NO_AGG_RINGS, AGG_RINGS, JUMBO), the LRO and GRO_HW bits in
dev->hw_features, and bp->rx_ring_size, which bnxt_set_ring_params() can
clamp.

> +		}
>  	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001142516.1386525-1-vnagare%40redhat.com
