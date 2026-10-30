Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349496;
	b=G6nSfhZ0FgEynjDUbauWN6wg1+AI8SIrBh7jFlAFmEarilJM0eELJMwxFcX3gTdgDYg0
	 vETDfdH759f+nGS6clEQ4ApRIXIGuryWJc5cL8GENfeNhFMrUGtetDuZ4wGSE0L9+4zin
	 GsYbeTi19GMATJAruG1cGDsLfcv2WTYnGmh8lL7jLg5/C5xQ1Zy1aXGhn75KnvLncZwhi
	 vWMjeq+TuG1YtsiKXIypoe6P9Jf9VVzBqfQHgsZLr6mFNAivLPWMt2MW+G0ny7pD/iRjL
	 ZUos8CPr7UuInvToydq8KmIb0K2JHrarnV1lbXxyktBRre2jiFo3OlvpdAiiNIKlbsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349496;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=YOHPnJk49GaVwy8trzGHGIzoqGw+LTmoBiHMTZYcgM8=;
	b=2LxIZDolHlcTYXOQu8AvDqfGhaGw52GaajbAtFwxDNSvVUvb5A+Jmm8eHSurwOifEObb
	 SL93xmEtd/l0gcBsmrkIeFUv4pT4+uWVrYL0NT4knunaZdHgeBMC/Haoh/ONyY2PNwLp0
	 y/BSiTkM3nAC+YegEohdXiAocEP5CsSGSRTtW4ibi9cG2UsRbMKo/F6cJqiLXnccplFeC
	 u4dkPTczzj8wlc2gNQvQbSweHpDbLi3k4s5aUmE8AP0sqhPqEXhiwO0Mw0qAgC/wmOvfB
	 n7+DbAancSFw/3nGs8a8Xau+FjZ+QazS6CChtV6TusqJn7rnzcsIgBmWQ8+KQA54CYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P7Fz9ypy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D67606A335;
	Fri, 30 Oct 2026 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P7Fz9ypy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F111F000C1;
	Fri, 30 Oct 2026 08:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793349495;
	bh=YOHPnJk49GaVwy8trzGHGIzoqGw+LTmoBiHMTZYcgM8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=P7Fz9ypyWBztPdDLD9KdPyJyjfqBO/ftvh3VJXqPvnXy6/ycOpNAII/qLT4m6nCvY
	 oIh3AGvFBLblCZPOcsni1GT4U3P+9bzXyhXbeWBhGjn2wsJhuxOdU3wEj1mcPjt46G
	 Vo6Hki6qfobkqmUQjQTfRG0DVXPqghtfT9LoHvEsw2u3lRlHDPjI59nupGIYaiL5oC
	 lMGVYj0BozdJykYXr5W6b5g+RuxjdTB4Ld8WDpvItOHWiBflIvGDapa4RRKTerHHNp
	 +StGror1NL0i3hcAPi04BNxLGWnUZgdc6xIeUZqD55e+FWsJ0PXvNEwWvLliHqJRV5
	 e/s0YHjYgNfOQ==
Subject: Re: [PATCH net v2] mctp i2c: fix double free of midev on netdev
 register failure
From: netdev-bot+sashiko@kernel.org
To: kenny_hsieh@jabil.com
Cc: netdev@vger.kernel.org, jk@codeconstruct.com.au, matt@codeconstruct.com.au,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 30 Oct 2026 08:38:14 +0000
Message-ID: <179334949479.3134.2940952959452938540@kernel.org>
In-Reply-To: <20261027053715.1623087-1-kenny_hsieh@jabil.com>
References: <20261027053715.1623087-1-kenny_hsieh@jabil.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] If register_netdevice() fails at the NETDEV_REGISTER notifier
  stage, mctp_i2c_add_netdev() now hangs forever.
- [Medium] Moving skb_queue_purge(&midev->tx_queue) to after
  mctp_unregister_netdev() creates a circular wait with…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  mctp_register_netdevice() (net/mctp/device.c) calls mctp_add_dev()…

--

mctp i2c: fix double free of midev on netdev register failure

This patch removes the ndo_uninit callback from mctp-i2c. midev is now
freed only in the mctp_i2c_add_netdev() error path, and in
mctp_i2c_unregister() after the netdev has been unregistered. A new helper,
mctp_i2c_midev_detach(), drops mcli->sel's netdev reference before
unregistering, and the tx thread now releases the bus lock itself.

Closes: https://lore.kernel.org/netdev/179239912623.3135.11352652156626817288@kernel.org/

> diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
> index b02476d338bbf..4f4c715b43cd7 100644
> --- a/drivers/net/mctp/mctp-i2c.c
> +++ b/drivers/net/mctp/mctp-i2c.c

[ ... ]

> @@ -711,7 +713,6 @@ static void mctp_i2c_release_flow(struct mctp_dev *mdev,
>  
>  static const struct net_device_ops mctp_i2c_ops = {
>  	.ndo_start_xmit = mctp_i2c_start_xmit,
> -	.ndo_uninit = mctp_i2c_ndo_uninit,
>  	.ndo_open = mctp_i2c_ndo_open,
>  };
>  

[Severity: High]
Can removing .ndo_uninit turn the double free into a permanent hang when
register_netdevice() fails at the NETDEV_REGISTER notifier stage?

When a client has no sel yet, mctp_i2c_midev_init() selects the new midev.
That takes a netdev reference before registration:

    if (!mcli->sel)
        __mctp_i2c_device_select(mcli, midev);   /* dev_hold(midev->ndev) */

If a NETDEV_REGISTER notifier then fails, register_netdevice() unwinds the
device itself:

    ret = call_netdevice_notifiers(NETDEV_REGISTER, dev);
    ...
    if (ret) {
        dev->needs_free_netdev = false;
        unregister_netdevice_queue(dev, NULL);
        goto out;
    }

After that, the rtnl_unlock() in mctp_register_netdev() waits for all
references to go away:

mctp_i2c_add_netdev()
  mctp_register_netdev()
    rtnl_lock()
    mctp_register_netdevice()
      register_netdevice()
        unregister_netdevice_queue()   <- ndo_uninit used to run here
    rtnl_unlock()
      netdev_run_todo()
        netdev_wait_allrefs_any()      <- waits on sel's dev_hold()

Without ndo_uninit, sel's reference is only dropped by
mctp_i2c_midev_free()->mctp_i2c_midev_detach() in the err: path of
mctp_i2c_add_netdev(). That path runs only after mctp_register_netdev()
returns. Does mctp_register_netdev() ever return in this case?

The stuck thread also holds driver_clients_lock. Later calls to
mctp_i2c_probe(), the remove path, and mctp_i2c_notify_add() would all
block behind it.

Possible triggers are an allocation failure in a protocol notifier (for
example inetdev_init() in the IPv4 notifier) or fault injection while the
first netdev on a client is being registered.

This is the same register failure path the commit message says it fixes.
The new comment above mctp_i2c_midev_detach() says mctp_i2c_midev_free()
covers the failed register path, but that doesn't seem to hold for this
case.

Would keeping an ndo_uninit that calls only the idempotent
mctp_i2c_midev_detach() avoid this?

[ ... ]

> @@ -782,6 +783,31 @@ static struct mctp_i2c_dev *mctp_i2c_midev_init(struct net_device *dev,
>  	return midev;
>  }
>  
> +/* Removes midev from the parent i2c client, moving sel off midev.
> + * mctp_i2c_unregister() needs this before unregister, as sel's netdev
> + * reference would block it; mctp_i2c_midev_free() needs it for the failed
> + * register path. A second call on the same midev does nothing.
> + */

[Severity: Medium]
This isn't a bug introduced by this patch, but there is a related problem
on the failed register path in the mctp core. mctp_register_netdevice()
in net/mctp/device.c sets up the mctp_dev before calling
register_netdevice():

    mdev = mctp_add_dev(dev);
    ...
    return register_netdevice(dev);

mctp_add_dev() takes a netdev reference:

    refcount_set(&mdev->refs, 1);
    dev_hold(dev);
    mdev->dev = dev;

register_netdevice() can fail before the NETDEV_REGISTER notifier, for
example:

  - dev_get_valid_name() returns -EEXIST for the fixed "mctpi2cN" name
  - a NETDEV_POST_INIT notifier fails
  - netdev_register_kobject() fails

In those cases no NETDEV_UNREGISTER is sent, so mctp_unregister() never
runs. Are the mctp_dev and its dev_hold() reference leaked here?

mctp_i2c_add_netdev() then calls free_netdev() on the
NETREG_UNINITIALIZED device. With CONFIG_NET_DEV_REFCNT_TRACKER, this
would warn in ref_tracker_dir_exit() about the leaked reference.

[ ... ]

> @@ -827,23 +851,17 @@ static void mctp_i2c_unregister(struct mctp_i2c_dev *midev)
>  	spin_unlock_irqrestore(&midev->lock, flags);
>  	wait_for_completion(&midev->rx_done);
>  
> +	/* Release sel's reference on the netdev, otherwise
> +	 * mctp_unregister_netdev() blocks waiting for it.
> +	 */
> +	mctp_i2c_midev_detach(midev);
> +
>  	mctp_unregister_netdev(midev->ndev);
> -	/* midev has been freed now by mctp_i2c_ndo_uninit callback */
> +	mctp_i2c_midev_free(midev);
>  
>  	free_netdev(midev->ndev);
>  }

[Severity: Medium]
With skb_queue_purge() now running after mctp_unregister_netdev(), can
this wait forever when CONFIG_MCTP_FLOWS is enabled?

mctp_i2c_unregister() stops the tx thread at its start. Until dev_close()
runs inside unregister_netdev(), mctp_i2c_start_xmit() can still queue
skbs to midev->tx_queue, and nothing drains them. Each queued skb's
SKB_EXT_MCTP extension holds a reference on its mctp_sk_key.

mctp_flow_prepare_output() reattaches a device whenever key->dev is NULL,
without checking key->valid:

    if (!key->dev)
        mctp_dev_set_key(dev, key);

Suppose __mctp_key_remove() removes the key between fragments in
mctp_do_fragment_route(). That can happen through an early reply from the
peer with the matching tag, or through expiry. The next fragment then
binds the mdev, and so the netdev, to a key that is no longer on any
list. That reference is dropped only by the final mctp_key_unref(), which
needs the queued skbs to be freed first.

The resulting dependency would be:

mctp_i2c_unregister()
  mctp_unregister_netdev()
    unregister_netdev()
      netdev_run_todo()
        netdev_wait_allrefs_any()        <- waits on the key's mdev ref
  mctp_i2c_midev_free()
    skb_queue_purge(&midev->tx_queue)    <- would drop the key ref

Before this patch the purge ran from ndo_uninit, after dev_close() and
before the refcount wait.

Should tx_queue be purged before the refcount wait in
mctp_unregister_netdev()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027053715.1623087-1-kenny_hsieh%40jabil.com
