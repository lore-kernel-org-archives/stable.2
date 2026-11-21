Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795303119;
	b=kWxN3qLnOWqG80P3sYiK+fjggqX5c5B3TQop3kCO0cC32TkZaED8Rc6GfXt6Tr8oQ7pv
	 3M9qVin5C0RV41Aih2AX3/xaLy0alq2DAvQHxvmfNMsZNWX/8+EL+q/y7+yOWSehP0iq+
	 X6lVKqrgHWwmbfyOU+CNaONusqzorw2C+DWUZytL1t0oSEyn4OzMNNug5bXL09LN5f7qg
	 9VCXaBwsOjhJYrfvtaX37N4g1/Yr8DeEBorz459Pzq2dfppWmx2PJ9oiyk+fHfQoJ0h2+
	 3uq9mlxglrYdnK4UZFXiwFedhU0zDvVtaHycU51e9e8QacEDiSHaXlCXpHo4/Yht97A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795303119;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=OmQA8w8TiDFNVOcBCsrodxB2z/WYpL97V8Uh0g4rbSA=;
	b=f2kEpDzeoutP3c7I+VAztGtBo999QzGi+bkcSRW/qV/BHTKmHzvicQCGt0BkPfOV3+nv
	 ZBqDrw+3OPBuh6WpGcaWwmTdm8slr6Ok0MXgVVdJLUzi6yDce65Ct2qOIwK3441pCrsX5
	 x5mxZFNaDPVY8mBP0Ojsz8N4ORRxlvU6CeDlKtK+L4zdk69Xy5MKlvv+Rpu/wlWUn+XDY
	 Vq0flay7ojQyOshkKgq0kJxbDVSDfSRT0MSKbIFmLlm3x4dMid+K4YFJK0DVhcZ1SZMWK
	 wTaAJvuCDsUG3PAxotHj96S5ouTSfvEJu/UsfijmF4iwuvE0R18bDk+rplaMHWhOQ5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F4AfGPBP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E2D606A335;
	Sat, 21 Nov 2026 23:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F4AfGPBP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B571F000C0;
	Sat, 21 Nov 2026 23:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795303119;
	bh=OmQA8w8TiDFNVOcBCsrodxB2z/WYpL97V8Uh0g4rbSA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=F4AfGPBPkv1KuRM+0ej8g2nycut8iZ7fHjvhKC28hnndqHJsu/jGu83Cn7Q+To2W5
	 KC9bq/T/ky4hp7FQ0DNZEv9Oy7rGwzyVKdCoJS8gVGGhT9nZOlnqQKTfTApU7fksKT
	 vl4UFkqzWPCgXRirqjDcIVk/gg1PR0/1GZl6dgwM2NmvZApsoCYtBRoBQka5R2I03l
	 osq26cy/SriSZLJEy8su6xVGvV0nnvR9mitiWdUD1W5VmPOwUC2Bl/dXC6fyiuinNu
	 BEYmQnzCahl2ewf01/2T4/oYg4tyBFcm39inYqDFlCVH3cV+3Ud2yIyjtPVJbpBmJk
	 Ix2rXzkotb8Tw==
Subject: Re: [PATCH net v4 2/2] net: atl1c: free the RX buffer when the
 descriptor reports an error
From: netdev-bot+sashiko@kernel.org
To: federico@rimpianto.com
Cc: chris.snook@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sat, 21 Nov 2026 23:18:38 +0000
Message-ID: <179530311840.3135.8141689247648916052@kernel.org>
In-Reply-To: <20261117225521.19689-3-federico@rimpianto.com>
References: <20261117225521.19689-3-federico@rimpianto.com>
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

Critical: 0 · High: 0 (2) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In atl1c_clean_rx()
  (drivers/net/ethernet/atheros/atl1c/atl1c_main.c), the RRD valid bit…

Pre-existing issues:
- [High] This patch adds a new schedule_work(&adapter->common_task) call
  (atl1c_clean_rx(), line 1939) in NAPI context.
- [High] The reset branch of atl1c_common_task() (lines 363-367) calls
  atl1c_down()/atl1c_up() without rtnl_lock and without taking…

--

net: atl1c: free the RX buffer when the descriptor reports an error

With this patch, atl1c_clean_rx() unmaps and frees the skb for RRDs that
report RRS_RX_ERR_SUM or RRS_802_3_LEN_ERR. Before, those buffers leaked.
Each RRD's RFD count and index are now checked against
rfd_ring->next_to_clean, and a mismatch schedules an adapter reset. The
RRD ring is also zeroed in atl1c_clean_rx_ring().

> diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> index e9baee8fa7e5e..5d00f2489d154 100644
> --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> @@ -933,8 +933,9 @@ static void atl1c_clean_rx_ring(struct atl1c_adapter *adapter, u32 queue)
>  		buffer_info = &rfd_ring->buffer_info[j];
>  		atl1c_clean_buffer(pdev, buffer_info, 0);
>  	}
> -	/* zero out the descriptor ring */
> +	/* zero out the descriptor rings */
>  	memset(rfd_ring->desc, 0, rfd_ring->size);
> +	memset(rrd_ring->desc, 0, rrd_ring->size);
>  	rfd_ring->next_to_clean = 0;
>  	rfd_ring->next_to_use = 0;
>  	rrd_ring->next_to_use = 0;

[ ... ]

> @@ -1914,47 +1909,59 @@ static int atl1c_clean_rx(struct napi_struct *napi, int budget)
>  		if (work_done >= budget)
>  			break;
>  		rrs = ATL1C_RRD_DESC(rrd_ring, rrd_ring->next_to_clean);
> -		if (likely(RRS_RXD_IS_VALID(rrs->word3))) {
> -			rfd_num = (rrs->word0 >> RRS_RX_RFD_CNT_SHIFT) &
> -				RRS_RX_RFD_CNT_MASK;
> -			if (unlikely(rfd_num != 1))
> -				/* TODO support mul rfd*/
> -				if (netif_msg_rx_err(adapter))
> -					dev_warn(&pdev->dev,
> -						"Multi rfd not support yet!\n");
> -			goto rrs_checked;
> -		} else {
> +		if (!RRS_RXD_IS_VALID(rrs->word3))
> +			break;
> +
> +		rrs_word0 = le32_to_cpu(rrs->word0);

[Severity: Medium]
Should there be a dma_rmb() between the RRS_RXD_IS_VALID() test on word3
and the read of word0 here?

The notes after the commit message say the missing barrier is
pre-existing and will be fixed in a separate patch. Before this patch, a
stale word0 only made one poll stop early. Now the RFD count and index
taken from word0 decide whether ATL1C_WORK_EVENT_RESET is scheduled, and
that runs atl1c_down()/atl1c_up() from atl1c_common_task().

On weakly ordered CPUs such as arm64 and powerpc, the control dependency
on the word3 test does not order the later word0 load. So word0 can be
read before the device's RRD write is visible.

The RRD ring is zero after open, because dma_alloc_coherent() zeroes it.
With the memset added to atl1c_clean_rx_ring() above, it is also zero
after every reset. On the first lap after open or reset, a stale word0
would then be 0 and give rfd_num == 0, which hits:

	if (unlikely(rfd_num != 1 ||
		     rfd_index != rfd_ring->next_to_clean ||
		     !buffer_info->skb)) {
		...
		set_bit(ATL1C_WORK_EVENT_RESET, &adapter->work_event);
		schedule_work(&adapter->common_task);

Could this produce a spurious "RRD out of sync" message and a full MAC
reset that drops the link? The reset zeroes the ring again, so the next
lap is exposed in the same way.

Without the memset, a stale word0 at slot k would still hold the
previous lap's value (count 1, index k) and pass the check.

Would a dma_rmb() right after the RRS_RXD_IS_VALID() test close this
window?

> +		rfd_num = (rrs_word0 >> RRS_RX_RFD_CNT_SHIFT) &
> +			RRS_RX_RFD_CNT_MASK;
> +		rfd_index = (rrs_word0 >> RRS_RX_RFD_INDEX_SHIFT) &
> +			RRS_RX_RFD_INDEX_MASK;
> +		buffer_info = &rfd_ring->buffer_info[rfd_ring->next_to_clean];

[ ... ]

> +		if (unlikely(rfd_num != 1 ||
> +			     rfd_index != rfd_ring->next_to_clean ||
> +			     !buffer_info->skb)) {
> +			dev_err_ratelimited(&pdev->dev,
> +					    "RRD out of sync: RFD count %u index %u, expected index %u%s; resetting\n",
> +					    rfd_num, rfd_index,
> +					    rfd_ring->next_to_clean,
> +					    buffer_info->skb ? "" : " (no buffer)");
> +			set_bit(ATL1C_WORK_EVENT_RESET, &adapter->work_event);
> +			schedule_work(&adapter->common_task);

[Severity: High]
This isn't a bug introduced by this patch, but this schedule_work() is a
new producer for common_task that only napi_disable() can quiesce. Can
common_task be queued again after it has been cancelled, and then outlive
the adapter?

atl1c_close() cancels the work before atl1c_down() quiesces NAPI and the
IRQ:

atl1c_close() {
	set_bit(__AT_DOWN, &adapter->flags);
	cancel_work_sync(&adapter->common_task);
	atl1c_down(adapter);
	...
}

atl1c_down() {
	atl1c_del_timer(adapter);
	adapter->work_event = 0; /* clear all event */
	...
		napi_disable(&adapter->rrd_ring[i].napi);
	atl1c_irq_disable(adapter);
	atl1c_free_irq(adapter);
	...
}

An RX poll still running in this window that hits an out-of-sync RRD
sets ATL1C_WORK_EVENT_RESET and calls schedule_work() again. The existing
ISR_ERROR path in the interrupt handler and atl1c_link_chg_event() can do
the same.

atl1c_remove() then does:

	unregister_netdev(netdev);
	...
	free_netdev(netdev);

There is no cancel_work_sync() or flush_work() between the two. If the
worker has not run by then, the queued work_struct sits in freed
netdev_priv() memory. atl1c_common_task() would then run container_of()
and test_bit(__AT_DOWN, &adapter->flags) on freed memory.

Would a cancel_work_sync() once NAPI and the IRQ are quiesced avoid this?
That could go at the end of atl1c_close(), or in atl1c_remove() after
unregister_netdev().

[Severity: High]
This is a pre-existing issue, but this patch adds a new trigger (an
out-of-sync RRD) for the reset in atl1c_common_task(). The existing
triggers are tx_timeout and ISR_ERROR. Is that reset path serialized
against other callers of atl1c_down()/atl1c_up()?

atl1c_common_task() {
	if (test_bit(__AT_DOWN, &adapter->flags))
		return;

	if (test_and_clear_bit(ATL1C_WORK_EVENT_RESET, &adapter->work_event)) {
		netif_device_detach(netdev);
		atl1c_down(adapter);
		atl1c_up(adapter);
		netif_device_attach(netdev);
	}
	...
}

It takes neither rtnl_lock nor __AT_RESETTING. atl1c_change_mtu() runs
under rtnl and takes __AT_RESETTING before its own atl1c_down() and
atl1c_up(). Nothing keeps the two apart.

Suppose atl1c_change_mtu()'s atl1c_down() runs while common_task is
between napi_disable() and napi_enable(). The second napi_disable() takes
netdev_lock() and waits on NAPI_STATE_SCHED, which is already set.
common_task's napi_enable() then blocks on netdev_lock().

Can this deadlock while atl1c_change_mtu() holds rtnl?

Other interleavings look like they could unmap and free the same RX
buffers twice through atl1c_reset_dma_ring(). They could also call
free_irq()/request_irq() twice.

The previous patch in this series, "net: atl1c: wait for in-flight RX
polls before the link-down ring reset", describes the same
napi_disable()/netdev_lock() deadlock for the link-change work.

>  			break;
>  		}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261117225521.19689-1-federico%40rimpianto.com
