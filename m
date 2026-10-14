Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596593BBFDE;
	Wed, 14 Oct 2026 02:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791946762; cv=none; b=kZMQZK3GDZyRbm9tMFZAdb1ohKTk7Qn1pKBYPybPFGEK45tPzjyXsfNA7JbpMaYredlvGCYLgLKwp6pSih1aMq5XaWrWgDG1UmUlYg/pHnDHRPJ4nG+X5gXDQ+J4y3kFZbjiXOhN5SslyfB+LE1WskdZ1iOS/76a8tflghNtD0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791946762; c=relaxed/simple;
	bh=jidvamdveRMxlYL4lesNoLI+utZEiYjmWY9UMXbXwo4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uvYSSCZfs3C+5b//XoUt7VVeWVvgPyPJc8P9C7efdTLkpgsmGqJRkkyTyMFc58TlyGSU9lcgmy7pkHgi2pxRroDWyJcegUHVaZ62nFyt4Pxs4u9rQGmI7JB94fIY5kIvIl1REigydpHw1nDqhDCTrcIU/TT4ejskvJhE8yrX5AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3oTbm+1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3oTbm+1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A961F00898;
	Wed, 14 Oct 2026 02:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791946760;
	bh=VIj4iWpoay7+QB0te1lIX1/jWTONzU5LIFeKJCnjyyc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=K3oTbm+1qtl2nR2qHGuGYRLq/4Uyq04Ck/gHtYVLEgvGA/CN3HFEWw6A4sjbCRK8V
	 5CTgeOZ85hFcyyyiAEZ0hvuuu6abUMr8W+XFB2wu78kwdYkV0BoFD0L55tUvAgxlWU
	 Fe1Dq8vUDNsQIwkVXuxp6Ylyh14DdN58z44KrpZv+LxZLfh4g5tkFjL/atA3ABHuOh
	 kBL2IIFAFuwexIrLQjbkNNiuTG5GrvBRv2I2UFT8ci5H+IW6YJ3rw365dkVOpCPcBH
	 jO8rK0BSmCCDAGvTlcbgEF6opajXAaa85fqdjrDdoDs5p3NIKVo7ROp5VGsQQL5tJ1
	 NgLKqxZ+OMLGg==
Subject:
 Re: [PATCH net v5 2/2] nfc: nci: uart: quiesce write_work during teardown
From: netdev-bot+sashiko@kernel.org
To: shubham@octane.security
Cc: netdev@vger.kernel.org, david@ixit.cz, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 cuissard@marvell.com, sameo@linux.intel.com, oe-linux-nfc@lists.linux.dev,
 linux-kernel@vger.kernel.org, gio@octane.security, stable@vger.kernel.org
Date: Wed, 14 Oct 2026 02:59:19 +0000
Message-ID: <179194675966.434549.3594049944518409311@kernel.org>
In-Reply-To: <20261013025746.41292-3-shubham@octane.security>
References: <20261013025746.41292-3-shubham@octane.security>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (2) · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] nci_uart_write_work() (net/nfc/nci/uart.c) drops the old 'if
  (test_bit(NCI_UART_TX_WAKEUP)) goto restart;' check that ran before…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is a high-
  severity issue in the code this patch reworks.
- [High] This problem wasn't introduced by this patch, but it is a high-
  severity issue in the teardown sequence this patch edits.
- [Medium] nci_uart_set_driver() reads 'template =
  nci_uart_drivers[driver]' and then evaluates…

--

nfc: nci: uart: quiesce write_work during teardown

This commit adds a tx_lock and an NCI_UART_CLOSING state, so scheduling of
the nci_uart write_work is serialized against teardown. A new
nci_uart_tx_stop() blocks further scheduling and cancels the worker before
the transmit skbs are freed. The Marvell UART transport gets a new
nci_quiesce callback, and the transport module reference is now taken
before the open callback runs.

> diff --git a/drivers/nfc/nfcmrvl/main.c b/drivers/nfc/nfcmrvl/main.c
> index 3d26a54ef51b4..45c7d3546b0e9 100644
> --- a/drivers/nfc/nfcmrvl/main.c
> +++ b/drivers/nfc/nfcmrvl/main.c

[ ... ]

> @@ -186,10 +188,15 @@ void nfcmrvl_nci_unregister_dev(struct nfcmrvl_private *priv)
>  	struct nci_dev *ndev = priv->ndev;
>  
>  	nci_unregister_device(ndev);
> +	if (priv->if_ops->nci_quiesce)
> +		priv->if_ops->nci_quiesce(priv);
> +
>  	if (priv->ndev->nfc_dev->fw_download_in_progress)
>  		nfcmrvl_fw_dnld_abort(priv);
>  
>  	nfcmrvl_fw_dnld_deinit(priv);

[Severity: High]
This is a pre-existing issue, not one introduced by this patch. Since this
teardown sequence is being changed anyway: can the firmware download
rx_work still be running at this point?

nfcmrvl_nci_unregister_dev() runs these steps in order:

nci_unregister_device()
    destroy_workqueue(ndev->cmd_wq), rx_wq, tx_wq
nfcmrvl_fw_dnld_abort()
    fw_dnld_over()
        release_firmware(priv->fw_dnld.fw);
        priv->fw_dnld.fw = NULL;
        priv->fw_dnld.header = NULL;
        ...
nfcmrvl_fw_dnld_deinit()
    destroy_workqueue(priv->fw_dnld.rx_wq);

Suppose nfcmrvl_fw_dnld_recv_frame() queued fw_dnld_rx_work() just before
the tty close. That worker is only drained in the last step.

Until then, its state handlers can touch firmware state that has been
released or set to NULL. One example is process_state_init():

	memcpy(cmd.param.val, &priv->fw_dnld.header->ref_clock, 4);

Another is process_state_fw_dnld():

			skb_put_data(out_skb,
				     ((uint8_t *)priv->fw_dnld.fw->data) + priv->fw_dnld.offset,
				     priv->fw_dnld.chunk_len);

Handlers that call nci_send_cmd() would also queue_work() on
ndev->cmd_wq, which nci_unregister_device() has already destroyed. The
rx_work error path can also call fw_dnld_over() at the same time as the
abort.

The new nci_quiesce callback only stops the UART write_work. Should
fw_dnld.rx_wq be drained before nci_unregister_device() runs and before
fw_dnld_over() releases the firmware?

[ ... ]

> diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
> index aa20e8603f327..8e54eb1c8712e 100644
> --- a/net/nfc/nci/uart.c
> +++ b/net/nfc/nci/uart.c

[ ... ]

> @@ -93,48 +129,65 @@ static void nci_uart_write_work(struct work_struct *work)
>  		kfree_skb(skb);
>  	}
>  
> -	if (test_bit(NCI_UART_TX_WAKEUP, &nu->tx_state))
> -		goto restart;
> -
>  	if (nu->ops.tx_done && nci_uart_queue_empty(nu))
>  		nu->ops.tx_done(nu);
>  
> +	spin_lock_irqsave(&nu->tx_lock, flags);
> +	if (!test_bit(NCI_UART_CLOSING, &nu->tx_state) &&
> +	    test_and_clear_bit(NCI_UART_TX_WAKEUP, &nu->tx_state)) {
> +		spin_unlock_irqrestore(&nu->tx_lock, flags);
> +		goto restart;
> +	}
>  	clear_bit(NCI_UART_SENDING, &nu->tx_state);
> +	clear_bit(NCI_UART_TX_WAKEUP, &nu->tx_state);
> +	spin_unlock_irqrestore(&nu->tx_lock, flags);
>  }

[Severity: Medium]
Was it intended to drop the TX_WAKEUP check that ran before tx_done()?

Before this patch, a wakeup that arrived during the write loop sent the
worker back to restart without calling tx_done(). Now tx_done() runs as
soon as nci_uart_queue_empty() is true, right after tty->ops->write()
returns.

On the Marvell UART transport with break_control set,
nfcmrvl_nci_uart_tx_done() does:

	if (priv->config.break_control && nu->tty->ops->break_ctl) {
		nu->tty->ops->break_ctl(nu->tty, -1);
		usleep_range(1000, 3000);
	}

At that point the tty driver has only buffered the bytes.
uart_break_ctl()->serial8250_do_break_ctl() sets UART_LCR_SBC and does not
wait for the transmitter to drain. Could the BREAK corrupt the tail of the
NCI frame that was just written?

For short frames, the serial write_wakeup usually fires from the TX
interrupt almost at once. That means TX_WAKEUP is likely to be set by the
time of the final check, after the sleep in tx_done(). The worker then
restarts:

nci_uart_write_work()
  nfcmrvl_nci_uart_tx_start()
    break_ctl(nu->tty, 0); usleep_range(3000, 5000);
  (nothing left to send)
  nfcmrvl_nci_uart_tx_done()
    break_ctl(nu->tty, -1); usleep_range(1000, 3000);

Does this add an extra BREAK/release pulse and several milliseconds of
latency to every frame?

Would a locked TX_WAKEUP check before tx_done(), kept alongside the new
final check, close the lost-wakeup race and still preserve the old BREAK
timing? The commit message doesn't mention this behavior change.

>  
>  static int nci_uart_set_driver(struct tty_struct *tty, unsigned int driver)
>  {
> +	struct nci_uart *template;
>  	struct nci_uart *nu = NULL;
>  	int ret;
>  
>  	if (driver >= NCI_UART_DRIVER_MAX)
>  		return -EINVAL;
>  
> -	if (!nci_uart_drivers[driver])
> +	template = nci_uart_drivers[driver];
> +	if (!template)
> +		return -ENOENT;
> +
> +	if (!try_module_get(template->owner))
>  		return -ENOENT;

[Severity: Medium]
This isn't a bug introduced by this patch, but what keeps template alive
between the load from nci_uart_drivers[] and the try_module_get()?

nci_uart_unregister() clears the slot with a plain store, without taking
any lock:

	nci_uart_drivers[nu->driver] = NULL;

The template, for example the static nfcmrvl_nci_uart, lives in the
transport module's data. Suppose this ioctl is preempted right after the
load. A concurrent rmmod could then run the module exit and free the
module, and template->owner would be read from freed memory. The
try_module_get() comment in include/linux/module.h says callers must make
sure the module exists before calling it.

This patch does pin the module across ops.open(), as the commit message
says. The remaining window predates the patch, and the old code had a
wider one. Would putting a lock or RCU read section around the registry
lookup and the try_module_get() close it?

[ ... ]

>  	ret = nu->ops.open(nu);
> -	if (ret) {
> -		kfree(nu);
> -		return ret;
> -	} else if (!try_module_get(nu->owner)) {
> -		nu->ops.close(nu);
> -		kfree(nu);
> -		return -ENOENT;
> -	}
> +	if (ret)
> +		goto err_stop;
> +
>  	tty->disc_data = nu;

[Severity: High]
This is a pre-existing issue, not one introduced by this patch. Can two
concurrent NCIUARTSETDRIVER ioctls on the same tty both reach this store?

nci_uart_tty_ioctl() checks disc_data without holding any lock:

	case NCIUARTSETDRIVER:
		if (!nu)
			return nci_uart_set_driver(tty, (unsigned int)arg);

tty_ioctl() holds only a shared tty_ldisc_ref_wait() reference around
ld->ops->ioctl(). So two threads can both see disc_data == NULL. Each one
allocates an nci_uart, takes a module reference and calls ops.open(),
which registers its own NCI device through nfcmrvl_nci_register_dev().
Whichever thread stores to tty->disc_data last wins.

The other nu is left orphaned. Its NCI device stays registered, its
nu->tty still points at the tty, and it keeps holding the transport
module. nci_uart_tty_close() only tears down the nu in disc_data. The
orphan never gets ops.close() or nci_uart_tx_stop(), so the new
NCI_UART_CLOSING barrier never applies to it.

After the tty is freed, bringing up the orphaned device would go:

NFC_CMD_DEV_UP
  nci_open_device()
    ... CORE_RESET ...
      nfcmrvl_nci_send()
        nci_uart_send()
          nci_uart_tx_wakeup()
            nci_uart_write_work()
              tty->ops->write()

and that write would run on the freed tty_struct. Even without that
path, the nci_uart, nfcmrvl_private and nci_dev are leaked. Should the
disc_data check and the store to it be serialized?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013025746.41292-1-shubham%40octane.security
