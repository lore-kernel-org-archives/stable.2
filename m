Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794812348;
	b=2skmge5hAmiJicUSjbOQiZ1ZYVz8DpzoT50/V4+44spViDGZTW98AjQvg20VF9Ojaypc
	 U7+Z8J1HhTDuPYB3ARzn9L/JcmY42SED4I5szfm+libKjInbdj45MoGmT1aXVSTnirH1O
	 kD9DvrmMCyuyvXMj9k6g9L2rwM9n5X6xYzH3zNZTzAHnKzSi2PtbPU8wIvlr4Wnqc4Fie
	 02yH4HEbcR2YOoDhE34i0xUiflNwHYoWrMN7v1CYgxWI9AZn1w97KB0sn3iE+zdYBfzmM
	 BA8orjJgAVOikDexfRp+pawvf+XrRb4iZ7KUCXUvp9IehCx1GxIWqcRt0OFEmHFN9Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794812348;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=59ZhBS4nNzF0cyplDMsPLPLfy6KtKW19pKytqkrPkmg=;
	b=qHU5E11q7f5b6MhIT0UxPtLIfebxtEJV6VPnn6YKw7C60lDYHKyD7tsdf520Qm3Fkz2t
	 SMol+gzdE2xFS7RFXBBn3GBlNZUJr/gyk1tKyRf4zS72+v44TiXkeNVcyjBVpuuNPgoZu
	 d23qKCf/+wv1uM4HFduwQ/FrYFg3ajKrTxxkRE1Ot6e/Rk4GbxFL6iMkWWPBpNxO5/vuq
	 TpWFwwy7xnIZ/9+CdREQCGvSvBwQdSpOrfZLFjIzvNQCyp0e8TyqT/2Ujb7ASC97kuSIJ
	 sz+xYu78F329lbhjDSTdgFbqfO7VJUEiShtYsIJ8zsVy2sItY0H6Op/5hlzjABO44jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WSt7bIHI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDBD606A32A;
	Mon, 16 Nov 2026 06:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WSt7bIHI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095371F000C4;
	Mon, 16 Nov 2026 06:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794812347;
	bh=59ZhBS4nNzF0cyplDMsPLPLfy6KtKW19pKytqkrPkmg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WSt7bIHISo3C4uygBxDjBmNH1QaW0CT+sW66zj4M9mKEOXGy4kaSRY6MIEFYR7IaX
	 Rqv8zX7H+lmYdFbmtEjYzqP5p6FRY0b7SDbZYKMmTBr1ebacyrm/w8PgGAVWYNGRcd
	 /PG+d4KMJ2obx6JvFRJYk3M2J4h6lKTW7EqrDWnR+19AMUqEqjVqe3jtSpk9tfc4RK
	 dEygPq/ckMSjGggERmcBl2cSZ6zcqGwIhxK1ptI+gUAwMyoY5ed3iB/5JTxRqXOGm+
	 n8o7b96WXY8VvDcbKK4I3iwwxc3FQQaMcU8NGR/AP2FdFE467GD7yEQLhEzmw5z1/f
	 OFqQjl4VKU1qw==
Subject: Re: [PATCH net] dpaa2-eth: free the DPNI interrupt before releasing
 its resources
From: netdev-bot+sashiko@kernel.org
To: mhun512@gmail.com
Cc: ioana.ciornei@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 ruxandra.radulescu@nxp.com, gregkh@linuxfoundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ae878000@gmail.com,
 stable@vger.kernel.org
Date: Mon, 16 Nov 2026 06:59:06 +0000
Message-ID: <179481234651.3136.10190438261119233878@kernel.org>
In-Reply-To: <20261112065616.34209-1-mhun512@gmail.com>
References: <20261112065616.34209-1-mhun512@gmail.com>
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

Critical: 0 · High: 1 (1) · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch's new synchronization point, dpaa2_eth_free_irqs() (or
  kthread_stop() for the poll thread), still sits after…

Pre-existing issues:
- [High] The dpaa2-switch driver in the same directory still has the
  defect this patch fixes in dpaa2-eth.
- [Medium] dpaa2_eth_free_irqs() releases the Linux handler
  (devm_free_irq) and returns the MSI vector to the parent DPRC pool…

--

dpaa2-eth: free the DPNI interrupt before releasing its resources

This commit adds dpaa2_eth_free_irqs(). It calls devm_free_irq() on the
DPNI interrupt before fsl_mc_free_irqs(). The helper is used in
dpaa2_eth_remove() and in the dpaa2_eth_probe() error path, so the handler
is released and synchronized before the MAC is disconnected and the portal
and net device are freed.

> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
> index 7227a35dfaf2f..91462b88b34ad 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
> @@ -4824,6 +4824,14 @@ static int dpaa2_eth_setup_irqs(struct fsl_mc_device *ls_dev)
>  	return err;
>  }
>  
> +static void dpaa2_eth_free_irqs(struct fsl_mc_device *ls_dev)
> +{
> +	struct fsl_mc_device_irq *irq = ls_dev->irqs[0];
> +
> +	devm_free_irq(&ls_dev->dev, irq->virq, &ls_dev->dev);
> +	fsl_mc_free_irqs(ls_dev);

[Severity: Medium]
This isn't a bug introduced by this patch, but should this helper also
disable the DPNI interrupt in the MC before the vector is given back?

dpaa2_eth_setup_irqs() arms it:

	err = dpni_set_irq_enable(ls_dev->mc_io, 0, ls_dev->mc_handle,
				  DPNI_IRQ_INDEX, 1);

Nothing in dpaa2-eth ever calls dpni_set_irq_enable(..., 0). On the free
path, __fsl_mc_msi_write_msg() also returns early without unprogramming the
MSI:

	if (msi_desc->msg.address_lo == 0x0 && msi_desc->msg.address_hi == 0x0)
		return;

Once fsl_mc_free_irqs() returns the vector to the DPRC pool, another object
in the same container could be given that vector. Suppose a DPNI link or
endpoint change happens before dpaa2_eth_free_dpni()->dpni_reset(), or at
any later time if the reset doesn't clear the enable. The DPNI could then
send a stale MSI to the new owner's handler, and nothing would clear the
DPNI IRQ status.

This depends on MC firmware behavior that can't be confirmed from the
kernel source.

The peer teardown paths disable the interrupt at the object first.
dprc_teardown_irq() does:

	(void)disable_dprc_irq(mc_dev);

	devm_free_irq(&mc_dev->dev, irq->virq, &mc_dev->dev);

	fsl_mc_free_irqs(mc_dev);

dpaa2_switch_teardown_irqs() also calls dpsw_set_irq_enable(..., 0) before
fsl_mc_free_irqs().

Would a dpni_set_irq_enable(..., 0) call ahead of devm_free_irq() fit in
this helper?

[Severity: High]
This isn't a bug introduced by this patch, but dpaa2-switch.c in the same
directory seems to have the same problem that this patch fixes in
dpaa2-eth.

dpaa2_switch_setup_irqs() registers dpaa2_switch_irq0_handler_thread()
with devm_request_threaded_irq(). The teardown helper does only this:

drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c:dpaa2_switch_teardown_irqs() {
	err = dpsw_set_irq_enable(ethsw->mc_io, 0, ethsw->dpsw_handle,
				  DPSW_IRQ_INDEX_IF, 0);
	...
	fsl_mc_free_irqs(sw_dev);
}

There is no devm_free_irq() call. dpaa2_switch_remove() then frees the
port netdevs and port_priv, ethsw->ports, ethsw->lags, the MC portal and
ethsw. The handler stays registered until devres runs, after remove()
returns.

Disabling the interrupt in the MC stops new interrupts. It doesn't wait
for a handler thread that is already running, and that thread does:

	port_priv = ethsw->ports[if_id];

	if (status & DPSW_IRQ_EVENT_LINK_CHANGED)
		dpaa2_switch_port_link_state_update(port_priv->netdev);

It later calls dpsw_clear_irq_status(ethsw->mc_io, ...).

Can these accesses hit freed memory? The dpaa2_switch_probe() error path
at err_unregister_ports uses the same helper.

The error path inside dpaa2_switch_setup_irqs() already pairs
devm_free_irq() with fsl_mc_free_irqs(). Should dpaa2-switch get the same
fix, perhaps as a follow-up patch?

dpaa2-ptp doesn't have this problem. It uses request_threaded_irq(), and
dpaa2_ptp_remove() calls ptp_qoriq_free(), which reaches free_irq(), before
fsl_mc_free_irqs().

> +}
> +
>  static void dpaa2_eth_add_ch_napi(struct dpaa2_eth_priv *priv)
>  {
>  	int i;

[ ... ]

> @@ -5104,7 +5112,7 @@ static void dpaa2_eth_remove(struct fsl_mc_device *ls_dev)
>  	if (priv->do_link_poll)
>  		kthread_stop(priv->poll_thread);
>  	else
> -		fsl_mc_free_irqs(ls_dev);
> +		dpaa2_eth_free_irqs(ls_dev);

[Severity: High]
Does this synchronization happen early enough? In dpaa2_eth_remove() it
still runs after unregister_netdev():

	unregister_netdev(net_dev);

	dpaa2_eth_dl_port_del(priv);
	dpaa2_eth_dl_traps_unregister(priv);
	dpaa2_eth_dl_free(priv);

	if (priv->do_link_poll)
		kthread_stop(priv->poll_thread);
	else
		dpaa2_eth_free_irqs(ls_dev);

The commit message says a link or endpoint change can "access the freed MC
portal and net device". A link-up handler that overlaps with
unregister_netdev() still seems able to do that.

One possible sequence:

dpni_irq0_handler_thread()
  dpaa2_eth_link_state_update()
    dpni_get_link_state() -> state.up = 1
    dpaa2_eth_set_rx_taildrop() (MC commands, may sleep)

                              dpaa2_eth_remove()
                                unregister_netdev()
                                  dpaa2_eth_stop()
                                    netif_carrier_off()
                                  linkwatch_forget_dev()
                                  reg_state = NETREG_UNREGISTERED

    netif_carrier_on(priv->net_dev)
      linkwatch_fire_event()
        linkwatch_add_event()
          netdev_hold(), dev added to lweventlist

                                dpaa2_eth_free_irqs() (thread already done)
                                ...
                                free_netdev(net_dev)

netif_carrier_on() returns early only for NETREG_UNINITIALIZED:

	if (test_and_clear_bit(__LINK_STATE_NOCARRIER, &dev->state)) {
		if (dev->reg_state == NETREG_UNINITIALIZED)
			return;
		atomic_inc(&dev->carrier_up_count);
		linkwatch_fire_event(dev);

So the unregistered device still gets queued on lweventlist. Could the
linkwatch work then run linkwatch_do_dev() and netdev_put() on the
net_device after free_netdev()?

dpaa2_eth_link_state_update() and the unregister/stop path don't share a
lock. dpaa2_eth_poll_link_state() is also stopped only at this point, so
the poll thread has the same window.

Would it be better to quiesce the DPNI interrupt, or stop the poll thread,
before unregister_netdev()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261112065616.34209-1-mhun512%40gmail.com
