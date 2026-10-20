Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501860;
	b=kf8tMykC1SuqozPf8japRH7Z6iDj5IgwA6bHbpSogxam8s+qwhEPVBTPjqd02gk+LgE0
	 rhdhpL5sUiCnVHzmRz1HbrESAlY6lL83wKO7uRzfDl2GdlNhuCsKCxC2CK40Q9mrOcW9V
	 yhwB2CCawnyb2VN4LpS8PK9cS4b04OVqv7yvxB/pNewapKGP+EL66GzHk/E/WhQwQ8Vqm
	 9qKI97fWvzwQjyENUlz+sDs1Y+HD97FmjMVs6rWSmgA2O/2lPhpF/rOMu+YwDWM/bseel
	 ep9D3dh8IVgAzi+zpn43a9KO4M5ObKnaIJQgR1tkUw/TWt2f0YYEMshS2aBc3KThTDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501860;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=BgtBHnxdOVXZopSmsnS/chjAyd2c5e1oaSz23YMKP0A=;
	b=YGqV+hek0ycZwOWG8VnPfIziOip8bTIDNjjAnJCiRT32OjMfPt2W3J7Z0D9mGKvf1vu8
	 UQfSEz5SfMuWA3VJk2fBWDIryJR84EboDh9rObYNeTFqfFf/nMfmYtqHydx4pBekr9zWV
	 t6vX4shp1U6jqTGIU/C0BJ4BBC4Ess2zFuTEDV852qI7J3JPyVtvOyVfO2T7wD3levyvd
	 aM/oVbwksJX7Wjc63nnvwjw8r1aAiAZAh4SKm498qs3m27+6zqD6gJ1U8/gR6HDfZ/Acv
	 4mYPrmy2eqooQxK6O532qy4EiUO1269hqLkyxbBRd3CTFPdSpLzrmJUvkpEYH7PN/AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OlLMsskF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173C960A380C;
	Tue, 20 Oct 2026 13:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OlLMsskF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0051F000C5;
	Tue, 20 Oct 2026 13:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792501859;
	bh=BgtBHnxdOVXZopSmsnS/chjAyd2c5e1oaSz23YMKP0A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OlLMsskFsoFxLF+IvX8Llhosc1jUFdCZttH/kXyszE6omWbJJ4shiJEy/D95AhcBt
	 karqWrU9lA9umLHRJaznYWE7sbbD3lUM+8ZgnNaID971IUK73aAFjAiYEUdiuW6/p5
	 Yf/vMXBPSx8hNbTapMpLiGYncoBrWFWJm0zGK9TZ3zZTQEkvr71iKS/CRgkG9gK73A
	 ooH4NndEVtfDdo1j1zVDv/ABnSEktffo49qlYTnDKa2dawZXdNNm9Yt1eBLmjr48EP
	 soIMzog+8n+h/yh8s5jbKjjmpH3xqSOZnMzhoW5Ib4jbzGHUyisK6nwl1143sNkDpf
	 HQ+Z00FCEUtFw==
Subject: Re: [PATCH net] ice: fix Tx hang dump using stale tx_buf[0].skb
From: netdev-bot+sashiko@kernel.org
To: choiniere.vincent@hydroquebec.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, aleksandr.loktionov@intel.com,
 michal.kubiak@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 20 Oct 2026 13:10:58 +0000
Message-ID: <179250185873.3135.10101707471960530546@kernel.org>
In-Reply-To: <20261016-ice-tx-hang-dump-v1-1-3df0f5979a51@hydroquebec.com>
References: <20261016-ice-tx-hang-dump-v1-1-3df0f5979a51@hydroquebec.com>
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

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new `tx_buf->type == ICE_TX_BUF_SKB` guard in
  ice_tx_hang_reporter_dump()…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the patch
  keeps it and adds another access to the same storage.

--

ice: fix Tx hang dump using stale tx_buf[0].skb

This commit changes ice_tx_hang_reporter_dump() so it reads the Tx buffer
at event->next_to_clean instead of always reading tx_buf[0]. It uses that
buffer's skb only when the buffer type is ICE_TX_BUF_SKB, and skips the skb
dump otherwise.

Link: https://lore.kernel.org/all/20260327072332.130320-1-aleksandr.loktionov@intel.com/

> diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
> index 8e9a8a8178d48..059859c36dfb2 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/health.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/health.c
> @@ -390,12 +390,15 @@ static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,

[ ... ]

> -	skb = event->tx_ring->tx_buf->skb;
> +	tx_buf = &event->tx_ring->tx_buf[event->next_to_clean];
> +	if (tx_buf->type == ICE_TX_BUF_SKB)
> +		skb = tx_buf->skb;

[Severity: High]
Is this type check enough to stop devlink_fmsg_dump_skb() from reading a
freed skb when Tx cleanup runs at the same time?

The dump runs from the service task:

ice_service_task()
  ice_report_tx_hang()
    devlink_health_report()
      devlink_health_do_dump()
        ice_tx_hang_reporter_dump()

The only lock held on that path is reporter->dump_lock. Nothing disables
NAPI, takes the Tx queue lock or takes a reference on the skb.

ice_service_task() calls ice_report_tx_hang() before ice_reset_subtask(),
so the ring's NAPI and queue IRQ are still live while the dump runs:

	if (pf->health_reporters.tx_hang_buf.tx_ring) {
		ice_report_tx_hang(pf);
		pf->health_reporters.tx_hang_buf.tx_ring = NULL;
	}

	ice_reset_subtask(pf);

In ice_clean_tx_irq(), the skb is freed before the type is changed, and
tx_buf->skb is never cleared:

		/* free the skb */
		napi_consume_skb(tx_buf->skb, napi_budget);

		/* unmap skb header data */
		dma_unmap_single(tx_ring->dev,
		...
		/* clear tx_buf data */
		tx_buf->type = ICE_TX_BUF_EMPTY;

This means the reporter can see ICE_TX_BUF_SKB for an skb that has already
been freed.

The index is racy as well. ice_report_tx_hang() copies
tx_ring->next_to_clean with a plain read of a field that NAPI updates, so
it can name the slot NAPI is reclaiming at that moment.

After this check and before devlink_fmsg_dump_skb(), the dump makes many
devlink_fmsg_put() calls that allocate with GFP_KERNEL. It also copies the
whole descriptor ring. That is a long window in which the task can be
preempted.

The scenario in the commit message seems to set up exactly this case. The
descriptors have completed and only the queue IRQ is delayed. NAPI can run
on another CPU, as the RT IRQ thread preempting the kworker, or because Rx
traffic on the shared q_vector kicks it. Whenever it runs, it frees the
skb at next_to_clean. devlink_fmsg_dump_skb() would then read skb->len,
skb_shinfo(skb) and skb->sk from freed memory.

Could that cause the same page fault this patch is meant to fix, or copy
freed memory into the dump? The notes below the commit message already say
"the skb lifetime against concurrent Tx cleanup still needs review".

Would it work to call napi_disable() and napi_enable() on
tx_ring->q_vector->napi around reading and dumping the skb? Two other
options are to capture the skb fields while cleanup is excluded, or to
dump only the skb pointer and not the skb contents.

> @@ -409,7 +412,8 @@ static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,
>  	ice_fmsg_put_ptr(fmsg, "skb-ptr", skb);
>  	devlink_fmsg_binary_pair_put(fmsg, "desc", event->tx_ring->desc,
>  				     event->tx_ring->count * sizeof(struct ice_tx_desc));

[Severity: Medium]
This isn't a bug introduced by this patch, but the patch keeps it and adds
one more access through the same saved ring pointer. Is event->tx_ring
guaranteed to still be valid when this dump runs?

ice_prep_tx_hang_report() saves a raw ring pointer from watchdog context:

	buf->tx_ring = tx_ring;

ice_service_task() uses it later with no lock and no reference. It holds
neither rtnl nor ICE_CFG_BUSY, and ring teardown never clears the saved
pointer.

ice_set_ringparam() runs under rtnl and does not check
ice_is_reset_in_progress(). It calls ice_down(), which runs
ice_clean_tx_ring(). That frees every skb, clears tx_buf and resets
next_to_clean to 0. Then ice_set_ringparam() does:

			ice_for_each_txq(vsi, i) {
				ice_free_tx_ring(vsi->tx_rings[i]);
				*vsi->tx_rings[i] = tx_rings[i];
			}

ice_free_tx_ring() frees tx_buf and desc and sets both to NULL.

If ethtool -G runs while the service task is dumping, can
ice_tx_hang_reporter_dump() do any of the following?

- Index freed or NULL tx_buf memory using the old next_to_clean.
- Dump count * sizeof(struct ice_tx_desc) bytes from a freed or NULL desc.
  The count and desc values may also come from different ring
  generations.
- Dereference q_vector->name.

On VSI rebuild, ice_vsi_clear_rings() frees the ring structs themselves
with kfree_rcu(). That would leave the saved pointer completely stale.

ice_stop() is mostly blocked here. ice_tx_timeout() sets ICE_PFR_REQ, and
ice_stop() returns -EBUSY while a reset is in progress.

The tx_hang_buf fields are also written and read with plain accesses.
Because ice_service_task() clears tx_ring after reporting, it can drop a
newer timeout record. The head and intr values may also come from a
different event than tx_ring.

The old code had the same exposure through
event->tx_ring->tx_buf->skb.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-ice-tx-hang-dump-v1-1-3df0f5979a51%40hydroquebec.com
