Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794391615;
	b=XMrEzI83yHCzh30cMmtTpxPlgSuygM2NZLN2JqUshNGnrsBtYgbnRz7RIwTtK9AgmyLV
	 TBslmcp72bs5HqJGJbWwxGVp9RMsH83pdpIYQkX5o8KEqoaeftLfEszsS2vy5/ckKpMIe
	 gagZFD6eOk6Trx8P0Hey/a4nR11SPEDwnxlKckrSze2f4i7igIxmPGA5e6uKdflZ+CIcE
	 Y/VSQ1oM9kV6GrIdqe3ewawKX9/HCc6nQ9TyWoBKWREIDixaP2q3bHH9mzY3+zX6jGGFa
	 /FreNAfr7gMt6DmA3Ze2D70utV75EPLpDcKqy1TWfsBRmuZiXkvZK/kE5tB4ilHn2aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391615;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=VlfbgDgQAEitsNSmJqDXQTJdALRr6On/NT0I0OmkIfA=;
	b=J3jIlMt9+DTOlwyRu76iiU9YMEa5dZlLw+MC3VYu78VIy8jN6mPeIW0iB0f260US4p4F
	 JgeyWX62Z7Xb4i4yEiidBkGF3vYZ1mBnOUUYmx1igPdJ1qonrlnOtqfN9MqGb8zPtIfh6
	 r/7DGNWrbZlhiyhdHmtE81IqAsvOHmJeG3WmgbZCmaU6ysMH8OpvhKz/ecsJzzQD/0c/2
	 MbAZ+Fui2J/o9BSnYRJKoSJA5Zsh2qYCdaNLMJ4uFRgCKbWeUdUrEid1XRXv+47WV6TX+
	 hvRjTmUka94U0HsFH/osA+944m/PAAy9uQoyK/wPfrgSHpEKRr3HE6RZwYEyGUPbD6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e4p588Da;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23CB606A333;
	Wed, 11 Nov 2026 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e4p588Da
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1598C1F00A05;
	Wed, 11 Nov 2026 10:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794391614;
	bh=VlfbgDgQAEitsNSmJqDXQTJdALRr6On/NT0I0OmkIfA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=e4p588Da+7AjF2uWURuees2FVLx9OHEFnt6AQUUn5ItfCjASqQlduuuqtghPqvLbf
	 wtl8MByo8ihpgEWCT1D1I/sHb1uCZ1/kCPfeaPIz7RiB1kYYwfFq8y5kNmkLgQozk0
	 WtQ9nqzBEuERWQ4hwEoOo/T/SU3+KMDkcGok88Mj+nbLg5kr5tUE57aoTQQbR91WcL
	 qlc+n91Qdwqgv1EnX3JA5B/KGqtsYfsnrIqBmOzSYjCFs/2QEZt6WHyae4SahsIxEB
	 yiP9T4qCJhko56XnxlOdxTHwM5tRhHu+snaXEQnhyOmKHdxwWHGMsDGfn6Pyi2Tibn
	 JWvxrtCyr7q7A==
Subject:
 Re: [PATCH net v5 1/2] gve: refuse XDP on queue formats without XDP support
From: netdev-bot+sashiko@kernel.org
To: amaan.cheval@gmail.com
Cc: netdev@vger.kernel.org, joshwash@google.com, hramamurthy@google.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, bcf@google.com, jordanrhee@google.com,
 przemyslaw.kitszel@intel.com, maciej.fijalkowski@intel.com,
 pkaligineedi@google.com, maolson@google.com, csully@google.com,
 willemb@google.com, yangchun@google.com, npl@google.com,
 awogbemila@google.com, shailend@google.com, nktgrg@google.com,
 maxyuan@google.com, bpf@vger.kernel.org, john.fastabend@gmail.com,
 hawk@kernel.org, sdf@fomichev.me, daniel@iogearbox.net, ast@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 11 Nov 2026 10:06:52 +0000
Message-ID: <179439161258.2199510.10096207449822395421@kernel.org>
In-Reply-To: <20261109100437.331423-2-amaan.cheval@gmail.com>
References: <20261109100437.331423-2-amaan.cheval@gmail.com>
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

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message misstates which queue formats the new check
  affects.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  extends it.

--

gve: refuse XDP on queue formats without XDP support

This patch adds a check to gve_verify_xdp_configuration() that refuses XDP
setup when dev->xdp_features lacks NETDEV_XDP_ACT_BASIC. It replaces the
queue format gate dropped by commit d8a8ca14c937. The aim is to keep XDP
off DQO-QPL, whose RX page accounting can free a page that is still
DMA-mapped and registered in the QPL.

> Refuse XDP setup in gve_verify_xdp_configuration() whenever the driver
> advertises no XDP features for the current queue format, which today
> means DQO-QPL.

[Severity: Medium]
Is "which today means DQO-QPL" accurate? gve_set_netdev_xdp_features() only
sets NETDEV_XDP_ACT_BASIC for GQI-QPL and DQO-RDA:

drivers/net/ethernet/google/gve/gve_main.c:gve_set_netdev_xdp_features() {
	if (priv->queue_format == GVE_GQI_QPL_FORMAT) {
		xdp_features = NETDEV_XDP_ACT_BASIC;
		...
	} else if (priv->queue_format == GVE_DQO_RDA_FORMAT) {
		xdp_features = NETDEV_XDP_ACT_BASIC;
		...
	} else {
		xdp_features = 0;
	}
	...
}

GQI-RDA also falls into the else branch. gve_adminq.c can still select
GVE_GQI_RDA_FORMAT from the GQI_RDA and GQI_RAW_ADDRESSING device options,
so the new check refuses GQI-RDA as well.

The check that d8a8ca14c937 removed (queue_format != GVE_GQI_QPL_FORMAT)
also refused GQI-RDA. Since that commit, XDP could be attached on GQI-RDA,
and XDP_TX there takes this path:

gve_rx()
  gve_xdp_done()
    gve_xdp_xmit_one()
      gve_tx_fill_xdp()

gve_tx_fill_xdp() always uses tx->tx_fifo: it calls gve_tx_alloc_fifo(),
memcpy()s into tx->tx_fifo.base and reads tx->tx_fifo.qpl->page_buses. A
raw-addressing TX ring never allocates that FIFO. Isn't that a NULL
dereference that this patch also fixes without saying so?

Could the commit message mention GQI-RDA? Two things are worth stating:
GQI-RDA now gets -EOPNOTSUPP, and this closes the XDP_TX crash there. That
would help stable backporters.

The follow-up patch "gve: fix RX page refcount overflow from INT_MAX
pagecnt_bias" uses the same wording ("The previous patch keeps it that way
by blocking XDP on DQO-QPL"). Its safety argument also depends on XDP being
blocked on GQI-RDA.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 2437cd8ba6331..fe560f5c5408c 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1723,6 +1723,12 @@ static int gve_verify_xdp_configuration(struct net_device *dev,
>  	struct gve_priv *priv = netdev_priv(dev);
>  	u16 max_xdp_mtu;
>  
> +	if (!(dev->xdp_features & NETDEV_XDP_ACT_BASIC)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "XDP is not supported on this queue format.");
> +		return -EOPNOTSUPP;
> +	}
> +

[Severity: High]
This is a pre-existing issue that this patch did not introduce, but the
patch adds another exit to the same gate. gve_xdp() calls
gve_verify_xdp_configuration() before it looks at the command, so the gate
also runs for teardown:

drivers/net/ethernet/google/gve/gve_main.c:gve_xdp() {
	err = gve_verify_xdp_configuration(dev, xdp->extack);
	if (err)
		return err;
	switch (xdp->command) {
	case XDP_SETUP_PROG:
		return gve_set_xdp(priv, xdp->prog, xdp->extack);
	case XDP_SETUP_XSK_POOL:
		if (xdp->xsk.pool)
			...
		else
			return gve_xsk_pool_disable(dev, xdp->xsk.queue_id);
	...
}

Several of the gate's conditions can become true after a successful bind:

- gve has no ndo_change_mtu, so the MTU can be raised above max_xdp_mtu
  while a zero-copy pool is bound.
- gve_set_features() refuses HW-GRO only when priv->xdp_prog is set, so
  HW-GRO can be turned on while only a pool is bound.
- The queue counts can be changed the same way.

When the AF_XDP socket is then closed:

xp_release_deferred()
  xp_clear_dev()
    __xp_clear_dev()
      xp_disable_drv_zc()
        gve_xdp()
          gve_verify_xdp_configuration()   /* returns -EOPNOTSUPP */

On failure, xp_disable_drv_zc() only does WARN(1, "Failed to disable
zero-copy!\n"). The core then goes on to xsk_clear_pool_at_qid(),
xdp_put_umem() and xp_destroy().

Because gve_xsk_pool_disable() never runs, clear_bit(qid, priv->xsk_pools),
xsk_pool_dma_unmap() and gve_unreg_xsk_pool() are all skipped. Won't
rx->xsk_pool and tx->xsk_pool still point at the freed pool when the RX
refill and XSK TX NAPI paths use them? The UMEM DMA mappings would also be
leaked.

dev_xdp_uninstall() follows the same pattern for programs. It does WARN_ON()
on the failed removal and then calls bpf_prog_put(), which leaves
priv->xdp_prog dangling.

The new xdp_features check cannot change between setup and teardown by
itself, since gve_setup_device() computes it only from queue_format. Even
so, would it be better to run the verification only for XDP_SETUP_PROG with
a non-NULL prog and for pool enable, so that teardown is never refused?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109100437.331423-1-amaan.cheval%40gmail.com
