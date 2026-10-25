Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792901038;
	b=TBcJidEnjeNSxO8iXseXo8iCcYs1OD8XRTwR0LEIc0qwFs/p5fR9gtZyKWYr65oy/QPE
	 in5OrAiHG6lPT45Fm8juS4qHJFI2/RImy6oep0qs5/Mkb3B3rcawNFN8C6YrYBgReKaJL
	 TYMWHHf2eUoUy9nLeiOqDNTU/j5Ye2zdlljFCufeSz5+L46n8dXKX0UksvGii8xrd8EeR
	 9Zz1ot3EWw1r/PQtQQBt+ZwId7m/FJvWuV4HR48saOxKqRycRwB6UL6SF68aa2x3lTW4P
	 tCBlU0FOYjxp+FalwJiZDHK5ZMmwbw9bvjdROq6rUM8Vem9AUGWOQ2yzM4ZytLwCpIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792901038;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=xEK3ziTLDp3P8qge4qM9WyluMbHgJ78J74M7q1KfX+g=;
	b=ql+UXpOYtcYE/NMb4/ApPQSE4ESh5AkfiNJfSwPTrcx3AbofEGe07Q80GIOIEvo8kwze
	 fw/Q0mKabo9s2+AgCePAtGww1G3h1LT/4FxdU4G39pCiT85xKp9EtObD7FOhwQhkXmM9V
	 CMm/1hmRHiT+s1uU7gv33wdT6vjKEvmSr2GsClG+WkYFMYrxELv8Kvez605sgICudKUch
	 muqkBIps9dFCO7eAaVQzxvYDV+QDETTurh5SGaTd5Uo5GRLlRFZkX9A86+3pCsC8hqLj5
	 JM237wq4flB/KIGcz/Vqwr7xcU6PsMYEfQ6WWytXpuz8o4TVnBcQy+cLfqNIhj4bFeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ok6l2rWJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8576F606A32A;
	Sun, 25 Oct 2026 04:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ok6l2rWJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53221F01828;
	Sun, 25 Oct 2026 04:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792901038;
	bh=xEK3ziTLDp3P8qge4qM9WyluMbHgJ78J74M7q1KfX+g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ok6l2rWJVN763KuLiWOpbogWXmbC0yHCZNPDjsjpbqx6JvhB8HwXyEIY93vUyG0oH
	 42Y3yCqXRffw7cDb1bMOSowrBCEQBFXRNE+EYxynThrXmVxpjhHm7od9YLEJb5uKum
	 rHZHNVdihscgpp6kHkSd03q2d5GJ9h5/i7IWvOCgxRlR16Wdbs7jQj4qHOmQG6Fu5K
	 /16kvpvSDXkUH+vx/ep7+5MEwfcXL+d490vX4cZdlEhIIRXHX7lUDfLb8NasG+9yiW
	 //tdbrbBVAu/CzxiM3NxCtgiBiQNJCsxv3G6Ve7ScXR/Ri4/VrqLWwW2dIsjCwplgq
	 9qbylHg5lh7Ow==
Subject:
 Re: [PATCH net v6 3/6] nfc: nci: uart: quiesce callbacks during teardown
From: netdev-bot+sashiko@kernel.org
To: shubham@octane.security
Cc: netdev@vger.kernel.org, david@ixit.cz, oe-linux-nfc@lists.linux.dev,
 gio@octane.security, stable@vger.kernel.org, kuba@kernel.org
Date: Sun, 25 Oct 2026 04:03:57 +0000
Message-ID: <179290103732.3134.18298634182061634234@kernel.org>
In-Reply-To: <20261021032443.44412-4-shubham@octane.security>
References: <20261021032443.44412-4-shubham@octane.security>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 (3) · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] When nci_uart_tty_close() tears down an NCI UART whose NCI
  device is up, the NFC controller (NFCC) is left running in whatever RF…
- [Medium] Baseline decision: fixed later in the series.
- [Low] Baseline decision: not a bug in practice.

Pre-existing issues:
- [High] Pre-existing problem, not introduced by this patch: during a
  Marvell firmware download, the UART peer (NFCC) controls a 16-bit…
- [High] Pre-existing problem, not introduced by this patch: the Marvell
  firmware download copies from the firmware image at a peer-advanced…
- [High] Baseline decision: pre-existing and fixed later in the series.

--

nfc: nci: uart: quiesce callbacks during teardown

This patch adds a tx_lock and a CLOSING transmit state. Together they
serialize nci_uart_tx_wakeup() and nci_uart_write_work() against teardown.
It also adds nci_uart_rx_stop() and nci_uart_tx_stop(), which stop the
generic receive and transmit callbacks before the transport close operation
runs. The Marvell UART transport gets a new nci_quiesce hook that stops
these callbacks and clears its back-pointers before private state is
released.

> diff --git a/drivers/nfc/nfcmrvl/main.c b/drivers/nfc/nfcmrvl/main.c
> index 6efa832191172..baf4c781ee6b6 100644
> --- a/drivers/nfc/nfcmrvl/main.c
> +++ b/drivers/nfc/nfcmrvl/main.c

[ ... ]

> @@ -181,6 +183,9 @@ void nfcmrvl_nci_unregister_dev(struct nfcmrvl_private *priv)
>  	struct nci_dev *ndev = priv->ndev;
>  
>  	nci_unregister_device(ndev);
> +	if (priv->if_ops->nci_quiesce)
> +		priv->if_ops->nci_quiesce(priv);
> +
>  	if (priv->ndev->nfc_dev->fw_download_in_progress)
>  		nfcmrvl_fw_dnld_abort(priv);
>  

[Severity: High]
This isn't a bug introduced by this patch, but can this teardown race with
a firmware download timeout callback that is already running?

fw_dnld_over() only waits for the timer if it is still pending:

drivers/nfc/nfcmrvl/fw_dnld.c:fw_dnld_over() {
    ...
	if (timer_pending(&priv->fw_dnld.timer))
		timer_delete_sync(&priv->fw_dnld.timer);
    ...
}

If fw_dnld_timeout() is already executing, timer_pending() returns false
and nothing waits for it. nfcmrvl_nci_unregister_dev() then continues to:

	nci_free_device(ndev);
	kfree(priv);

The callback may still be using priv and priv->ndev at that point.

A later patch in this series, "nfc: nfcmrvl: stop firmware work before
unregistering", appears to fix this. With it, fw_dnld_timeout() only queues
timeout_work, and nfcmrvl_fw_dnld_abort() calls timer_shutdown_sync() and
cancel_work_sync(&timeout_work) before nci_unregister_device().

[Severity: High]
This is a pre-existing issue, not one introduced by this patch. While
looking at the firmware download teardown here: can a UART peer make
process_state_fw_dnld() overflow out_skb?

In SUBSTATE_WAIT_COMMAND, any length is accepted as long as its complement
matches (for example len = 0xFFFF with comp = 0x0000). It is then stored
with no upper bound:

drivers/nfc/nfcmrvl/fw_dnld.c:process_state_fw_dnld() {
    ...
		priv->fw_dnld.chunk_len = len;
    ...
}

In SUBSTATE_WAIT_ACK_CREDIT, the skb comes from alloc_lc_skb(), which takes
a uint8_t plen, so it holds at most 255 payload bytes. skb_put_data() then
uses the full chunk_len:

			out_skb = alloc_lc_skb(priv, priv->fw_dnld.chunk_len);
			if (!out_skb)
				return -ENOMEM;
			skb_put_data(out_skb,
				     ((uint8_t *)priv->fw_dnld.fw->data) + priv->fw_dnld.offset,
				     priv->fw_dnld.chunk_len);

With chunk_len = 65535, would skb_put() reach skb_over_panic() and BUG()?

This is reachable once a CAP_NET_ADMIN user starts NFC_CMD_FW_DOWNLOAD. The
lengths come from the device or from a pty-backed peer.

[Severity: High]
This is also a pre-existing issue, not one introduced by this patch. Does
anything in process_state_fw_dnld() bound priv->fw_dnld.offset against
priv->fw_dnld.fw->size?

SUBSTATE_WAIT_DATA_CREDIT advances the offset by the length the peer
chose:

		priv->fw_dnld.offset += priv->fw_dnld.chunk_len;

SUBSTATE_WAIT_ACK_CREDIT then copies from that offset using the
skb_put_data() call quoted above. Neither step checks offset + chunk_len
against fw->size.

Suppose a peer keeps asking for chunks of 255 bytes or less and sends the
expected credit notifications. Can offset then move past the end of the
firmware image? If so, the kernel would read memory beyond fw->data and
send it to the peer in NCI data frames, or fault on an unmapped page.

[ ... ]

> diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
> index fb9ed281f62c3..aa24e1f572d9d 100644
> --- a/net/nfc/nci/uart.c
> +++ b/net/nfc/nci/uart.c

[ ... ]

> @@ -64,24 +65,61 @@ static inline int nci_uart_queue_empty(struct nci_uart *nu)
>  
>  static int nci_uart_tx_wakeup(struct nci_uart *nu)
>  {
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&nu->tx_lock, flags);
> +	if (test_bit(NCI_UART_CLOSING, &nu->tx_state) ||
> +	    !test_bit_acquire(NCI_UART_READY, &nu->flags))
> +		goto unlock;

[Severity: Medium]
Can this READY check leave a frame stuck in nu->tx_q?

When READY is not set yet, the kick is dropped without setting
NCI_UART_TX_WAKEUP or recording that work is pending. nci_uart_set_ready()
also does not check tx_q when it publishes READY.

For Marvell, nci_register_device() runs from inside ops.open(), before
READY is set:

nci_uart_set_driver()
    nu->ops.open(nu)
        nfcmrvl_nci_uart_open()
            nfcmrvl_nci_register_dev()
                nci_register_device()
    nci_uart_set_ready(nu)

If NFC_CMD_DEV_UP arrives in that window, nci_uart_send() queues
CORE_RESET into nu->tx_q, but write_work is never scheduled. Would
nci_open_device() then time out, and would the stale CORE_RESET go out
ahead of the next command that kicks the worker?

Before this patch, the same window scheduled write_work and could
dereference a NULL nu->drv_data in nfcmrvl_nci_uart_tx_start(), so this is
still better than that crash.

A later patch in this series, "nfc: nfcmrvl: publish UART state before
registration", calls nci_uart_set_ready() before nci_register_device(),
which closes this window.

[ ... ]

> @@ -99,14 +137,50 @@ static void nci_uart_write_work(struct work_struct *work)
>  		kfree_skb(skb);
>  	}
>  
> -	if (test_bit(NCI_UART_TX_WAKEUP, &nu->tx_state))
> +	spin_lock_irqsave(&nu->tx_lock, flags);
> +	if (test_bit(NCI_UART_CLOSING, &nu->tx_state)) {
> +		clear_bit(NCI_UART_SENDING, &nu->tx_state);
> +		clear_bit(NCI_UART_TX_WAKEUP, &nu->tx_state);
> +		spin_unlock_irqrestore(&nu->tx_lock, flags);
> +		return;
> +	}

[Severity: Low]
This might not matter in practice. This early return skips ops.tx_done()
even though ops.tx_start() already ran in this pass.

With Marvell break_control, nfcmrvl_nci_uart_tx_start() calls
break_ctl(tty, 0) and nfcmrvl_nci_uart_tx_done() calls break_ctl(tty, -1).
If teardown hits the worker mid-burst, the line is left with BREAK
de-asserted. If it hits between bursts, BREAK stays asserted. Is that
difference intended?

The ldisc is being detached here, and a full tty close clears break during
serial shutdown, so the practical effect may be limited.

[ ... ]

> @@ -208,26 +279,24 @@ static void nci_uart_tty_close(struct tty_struct *tty)
>  {
>  	struct nci_uart *nu = tty->disc_data;
>  
> -	/* Detach from the tty */
> -	tty->disc_data = NULL;
> -
>  	if (!nu)
>  		return;
>  
> +	tty->disc_data = NULL;
> +
>  	if (test_bit(NCI_UART_DRIVER_SET, &nu->flags)) {
> -		kfree_skb(nu->tx_skb);
> -		kfree_skb(nu->rx_skb);
> +		nci_uart_rx_stop(nu);
> +		nci_uart_tx_stop(nu);
> +		nu->ops.close(nu);

[Severity: Medium]
Does this leave the NFC controller running in its last RF state after
teardown?

nci_uart_tx_stop() sets NCI_UART_CLOSING and cancels write_work before
nu->ops.close() runs. As a result, nci_uart_tx_wakeup() refuses every frame
sent during:

nu->ops.close()
    nfcmrvl_nci_unregister_dev()
        nci_unregister_device()
            nci_close_device()

This patch depends on the earlier series patch "nfc: nci: skip controller
reset while unregistering", which already skips the reset in
nci_close_device():

	if (!test_bit(NCI_UNREG, &ndev->flags)) {
		atomic_set(&ndev->cmd_cnt, 1);
		set_bit(NCI_INIT, &ndev->flags);
		__nci_request(ndev, nci_reset_req, (void *)0,
			      msecs_to_jiffies(NCI_RESET_TIMEOUT));

Before the series, write_work was only cancelled at the end of
nci_uart_tty_close(), so the CORE_RESET was still written to the UART and
only the response was lost. Now no command reaches the controller during
unregister.

The Marvell path does not halt the controller some other way either:

  - nfcmrvl_nci_close() only calls if_ops->nci_close, which does nothing
    for UART.
  - nfcmrvl_uart_nci_quiesce() only clears software state.
  - nfcmrvl_chip_halt() is only called from fw_dnld_over() on error, which
    only happens while a firmware download is in progress, and it also
    needs a reset GPIO.

So an NFCC that was polling with the RF field on, or in listen/card
emulation mode, would stay that way with no host driver until it is
re-attached (nci_open_device() sends CORE_RESET then) or power-cycled.

The commit message says:

    The preceding change skips the unregister-time controller
    reset because the TTY core cannot deliver its response after line
    discipline close starts.

That explains why the response is lost. Could the commit message also
explain why it is acceptable that the reset command itself is no longer
sent, or could the controller be quiesced some other way before TX is
shut off?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021032443.44412-1-shubham%40octane.security
