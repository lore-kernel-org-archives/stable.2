Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217745;
	b=WjPxGcaiPWWLtRQAJYEtm0UOh4bJee697v+YIOkyFtr61iz69cdfCl8i/GtAxXyBp90V
	 Et8Xeg5X0tP6EDc0nECWs2tcuaFYpvTKDLbN5wRG19riy/bHUU55ICi20+/2mn5/CBTK+
	 bnMwE0sfmR9FFeoK90MaFBk94CxWXWjLIEvL5JxQXtjRFoY4dv7nI9ZWdpC53GNnX6yK6
	 87HqAHIg3oe5PU/c58z+yGOkKVBBuYcvYA3qmAn6OIB/IGeeDHVQCXdLYdSkV6GrWrhpt
	 5uC2Jgz7FDhqYoaG/sUjvwbdnI4XB0MrbUw2qZDa5x0kmleK9WX4vRvRjV4XVqxULzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217745;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=eMGL/SfdPd4JTRR79GZx0ANHe3xXx+490kcRSCW/wB0=;
	b=CvoyNUc32YkChVBGqtSLDuz/DS+fPYk3FdWjUi0T/Tf2byPq4JC7CJdUBv0rQAEDMnHr
	 stCDuhLd2YHBOWk6tL5i+p4a/+hTOV6dvw0BYJP+ciZCU9Ri0uODhbNBG6sb84IiZbj4p
	 PTM1rEcFe336BxgWO+5b1aYmgcn7gA7DVglWB3Av7lsKp/leQAinoTguciGeXjAoULaWB
	 m/8u25eYqYSQAFkMUKwp2Vps9yJYBfYUMnAOG3tTsiRPWYK8VObtbzA6nuxKacxLc7/lq
	 2NfhuiIp0xIpgEsT5RxLLf8Ew3L8aETOhO90pv5kwdnj3DadShf5B1HrsXXGWcqVIsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oA079Fvs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDE4606A31A;
	Wed, 28 Oct 2026 20:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oA079Fvs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2812A1F01825;
	Wed, 28 Oct 2026 20:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793217744;
	bh=eMGL/SfdPd4JTRR79GZx0ANHe3xXx+490kcRSCW/wB0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oA079FvsZbwlsepEf+HHdspm11+1XJ8lfzgtz7lxfozsRQxpLIHBTboTQqPUrLGu2
	 6ZF049Zhac13ByiMtXbzjwHnhQEOEA1yTXQYe352FhTpeOgkF7yBjDlCo3aBaEgVQc
	 /PkAppdQd24ZfISs/BTQ2iY8vRciGvvWCzKTKwnByj8wDvEiV/XW0sqK1nQzfQ5yoO
	 JryWv9gRGXMR95gIKLwj2rH2BycnDa15GDQRR1fNjDcDLHkblPLDS72OHmSqDxq2kb
	 +5tR1GwnsHjYfv4A+TDA0o4/4682txschBMFIhTJgCw9tvK3jUXJAgLpDDgU7rUVqa
	 8KSgwJHU3OwlQ==
Subject: Re: [PATCH v8 2/2] can: dev: can_tdc_fill_info(): don't read
 automatic TDCV if interface is down
From: netdev-bot+sashiko@kernel.org
To: chunyuzhiqiang@yinhe.ht
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org,
 linux-can@vger.kernel.org, mkl@pengutronix.de, mailhol@kernel.org,
 kernel@pengutronix.de, haibo.chen@oss.nxp.com, shawnguo@kernel.org,
 imx@lists.linux.dev, stable@vger.kernel.org, kuba@kernel.org
Date: Wed, 28 Oct 2026 20:02:23 +0000
Message-ID: <179321774368.3130.12586646136802755223@kernel.org>
In-Reply-To: <20261027065012.191348-2-chunyuzhiqiang@yinhe.ht>
References: <20261027065012.191348-2-chunyuzhiqiang@yinhe.ht>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message calls this change "defensive hardening
  based on code inspection" and has no Fixes: tag.
- [Medium] netif_running() is used as a stand-in for "the controller is
  clocked", but in xilinx_can it can be true while the clocks are gated.
- [Low] The modified can_tdc_get_size() prototype in
  drivers/net/can/dev/netlink.c (lines 723-725) has continuation lines…

--

can: dev: can_tdc_fill_info(): don't read automatic TDCV if interface is down

This commit makes can_tdc_fill_info() call do_get_auto_tdcv() only when
netif_running() is true. Drivers such as xilinx_can then no longer read
controller registers while the interface is down. can_tdc_get_size() and
can_data_bittiming_get_size() now take the net_device, so IFLA_CAN_TDCV
space is reserved only under the same condition.

> This is a defensive hardening based on code inspection; the automatic
> TDCV path has not been triggered on hardware.

[Severity: Medium]
Is "defensive hardening" an accurate description here? The path this patch
closes looks reachable by an unprivileged user on current mainline and
stable kernels.

xcan_probe() ends with pm_runtime_put(). The controller then stays
runtime-suspended, with bus_clk and can_clk disabled, until xcan_open()
takes a reference. xcan_get_auto_tdcv() reads a register without taking a
runtime PM reference:

drivers/net/can/xilinx_can.c:xcan_get_auto_tdcv() {
    ...
	*tdcv = FIELD_GET(XCAN_SR_TDCV_MASK, priv->read_reg(priv, XCAN_SR_OFFSET));
    ...
}

xcan_get_berr_counter(), by comparison, wraps its reads in
pm_runtime_get_sync()/pm_runtime_put().

TDC_AUTO also gets turned on while the interface is down.
can_dbt_changelink() accepts data bittiming only when the device is not
IFF_UP. It calls can_calc_tdco(), which sets TDC_AUTO whenever the data BRP
is 1 or 2. Take the usual setup sequence:

  ip link set canX type can bitrate ... dbitrate ... fd on
  ip -d link show canX

Before this patch, that sequence reaches the following path with the
clocks gated:

  rtnl_getlink()->can_fill_info()->can_tdc_fill_info()->xcan_get_auto_tdcv()

The callback was added in commit 1010a8fa96086d ("can: xilinx_can: add
Transmitter Delay Compensation (TDC) feature support"). Should this patch
carry a Fixes: tag for that commit, plus Cc: stable?

The companion patch "can: dev: can_fill_info(): don't wake up controller if
interface is down" fixes the same kind of access, and it has both tags.

The changelog note says:

> Split out of the berr-counter patch so that the stable backport only
> carries the hardware-tested change.

Without a Fixes: tag, the stable tooling cannot tell that kernels
containing 1010a8fa96086d also need this change.

> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> index b958c04d53db6..613beee9e9362 100644
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c
> @@ -720,8 +720,9 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
>  	return 0;
>  }
>  
> -static size_t can_tdc_get_size(struct data_bittiming_params *dbt_params,
> -			       u32 tdc_flags)
> +static size_t can_tdc_get_size(const struct net_device *dev,
> +				 struct data_bittiming_params *dbt_params,
> +			     u32 tdc_flags)

[Severity: Low]
This isn't a bug, but the continuation lines no longer line up with the
open parenthesis. The dbt_params line is two columns to the right of it,
and the tdc_flags line is two columns to the left. checkpatch --strict will
report "Alignment should match open parenthesis".

can_data_bittiming_get_size(), later in the same patch, is aligned
correctly.

>  {
>  	bool tdc_manual = tdc_flags & CAN_CTRLMODE_TDC_MANUAL_MASK;
>  	size_t size;
> @@ -742,7 +743,8 @@ static size_t can_tdc_get_size(struct data_bittiming_params *dbt_params,
>  	}
>  
>  	if (tdc_flags) {
> -		if (tdc_manual || dbt_params->do_get_auto_tdcv)
> +		if (tdc_manual ||
> +		    (dbt_params->do_get_auto_tdcv && netif_running(dev)))
>  			size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCV */
>  		size += nla_total_size(sizeof(u32));		/* IFLA_CAN_TDCO */
>  		if (dbt_params->tdc_const->tdcf_max)

[ ... ]

> @@ -910,7 +913,7 @@ static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev,
>  		if (tdc_manual) {
>  			tdcv = tdc->tdcv;
>  			err = 0;
> -		} else if (dbt_params->do_get_auto_tdcv) {
> +		} else if (dbt_params->do_get_auto_tdcv && netif_running(dev)) {
>  			err = dbt_params->do_get_auto_tdcv(dev, &tdcv);
>  		}

[Severity: Medium]
Can netif_running() be true while the xilinx_can clocks are still gated?
If so, xcan_get_auto_tdcv() can still read XCAN_SR_OFFSET from unclocked
hardware.

xcan_suspend() stops and detaches a running interface, then calls
pm_runtime_force_suspend(). That runs xcan_runtime_suspend(), which
disables bus_clk and can_clk. __LINK_STATE_START stays set:

drivers/net/can/xilinx_can.c:xcan_suspend() {
    ...
	if (netif_running(ndev)) {
		netif_stop_queue(ndev);
		netif_device_detach(ndev);
		xcan_chip_stop(ndev);
	}

	return pm_runtime_force_suspend(dev);
}

If pm_runtime_force_resume() fails during resume, xcan_resume() returns
early. This can happen, for example, when clk_prepare_enable() fails in
xcan_runtime_resume():

drivers/net/can/xilinx_can.c:xcan_resume() {
    ...
	ret = pm_runtime_force_resume(dev);
	if (ret) {
		dev_err(dev, "pm_runtime_force_resume failed on resume\n");
		return ret;
	}
    ...
}

At that point the clocks are off, the netdev is still IFF_UP and detached,
and netif_running() still returns true. An unprivileged
"ip -d link show canX" then passes the new check in can_tdc_fill_info()
and reads XCAN_SR_OFFSET in xcan_get_auto_tdcv().

rcar_canfd looks similar. rcar_canfd_suspend() calls
rcar_canfd_global_deinit(), which disables clkp and asserts reset. If
rcar_canfd_global_init() then fails in rcar_canfd_resume(),
rcar_canfd_get_auto_tdcv() reads cfdsts from a block that is unclocked or
held in reset.

Would it be more robust to take a runtime PM reference in
xcan_get_auto_tdcv(), as xcan_get_berr_counter() does?

Another option is to gate on netif_running(dev) && netif_device_present(dev).
Both drivers call netif_device_attach() only after the hardware is back up.

With either approach, can_tdc_get_size() needs the same condition so the
size estimate stays consistent with can_tdc_fill_info().

>  		if (!err && nla_put_u32(skb, IFLA_CAN_TDC_TDCV, tdcv))

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027065012.191348-1-chunyuzhiqiang%40yinhe.ht
