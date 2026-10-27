Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793081989;
	b=th+n2al1BKUgjx2YJwxBbh5/PsXcXGqr2WG+qyyXmxBn9fP/gzvf2XP8OOD+N4q6bINv
	 /KWrBv95FQ+fHwED835Y4p+kkpsqf+zE/aZHkefTVX2Z00KVdlABlEHdJ45+Zvp1lHRNb
	 aIzyIoKPsD96gXlhFI+EHuNm4yAk9MFCk26owwS+N8YvAAjYVo7QLP4GPnqz5dYZhR6d+
	 RW08OGshmbHDMZ+6ukDfpZOwzKHRHxhTNsmgW4Y33+sbW5fmG0XGgg/b2JVDMGFXb8Bkp
	 BIZeUd2DEOfj7U5FMWDuwZ8quH9WXvmlNvJONIOkJVbzUYwW2J7E36XftzBaaJlAa4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793081989;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=vAk7JnVPBwae5fUKaIkq/jC2gmYuvdXbn/hohKLDfO8=;
	b=Hbn0xdM3UMpOWmmPs+lyo2KGqajys+sYCGubYLWprgRVNEJvfUFJyshfnMMwVeHjP2AV
	 e2aRrdeU6QZ4HcVyq9j49X5+i29+Ij3C2XkfCuqC6MQyFBGq5fZ0rDmvB7fu6ocm23EM8
	 1wbl8fb7Xg2DJagY92WY3SD2tBI9aj8vxr+GLJ7J1sLrevcOrO2OoKk+PW14Ww60kAfme
	 ztG0xfnl5X+XEtNCzzAfM0OX1nef31v9JN0N9yCIIW86pMwnYfkUgxNQFG+GBE5DHBheb
	 nCZlX4U0doIsyLN8eIz+7cwqkER5vOMFZmKwtXY3OBwPoQpyvalc1N639+UNv9n7Uqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c+8c7NW2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB0B606A31B;
	Tue, 27 Oct 2026 06:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c+8c7NW2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E541F01829;
	Tue, 27 Oct 2026 06:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793081989;
	bh=vAk7JnVPBwae5fUKaIkq/jC2gmYuvdXbn/hohKLDfO8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=c+8c7NW2UQkkf0nlM50QGAhXIwtSLrMG2fPqnmFzPjpm0yEfzzgEDwtn7juwOAopx
	 HHiYXjH1NJWIGzGy3iR4dd7+yfKWBhWUleLLWe6zbpgnhwRFWQex/HfyJ8XrfsYAvH
	 EX0UkHnbAZ5E8JL2wwvFoHI6GSqsgfKIlp+t+dPk5IZh86nHWvtcQKaIG4A2hPDYYj
	 hs2e/W8q/I98MILGos/U/kVrzJBuJVHIzCtjb25WUU//gllGG0yBgbUu4yFME1Si+O
	 V3ok1tX80nUeGIMQAFgbRBOqr7y2wnHpWxWutFoS4IF7dXfmbqcw1Cswulf//TuPTy
	 AUB2FfmrHB4Zg==
Message-ID: <b0d3e7bf-ddd3-4eaa-8ebc-fbe5e7d8443f@kernel.org>
Date: Tue, 27 Oct 2026 07:19:45 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] can: dev: can_fill_info(): don't wake up controller if
 interface is down
To: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>, netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, mkl@pengutronix.de,
 kernel@pengutronix.de, haibo.chen@oss.nxp.com, shawnguo@kernel.org,
 imx@lists.linux.dev, stable@vger.kernel.org
References: <20261021145115.153107-1-chunyuzhiqiang@yinhe.ht>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBAhsDBQsJCAcC
 AiICBhUKCQgLAgQWAgMBAh4HAheAFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmrTM8wFCR1O
 HxcACgkQq1/riG27mcJ2KAEAhG19xBSkjiA9dtatvq2WJnGaes4SUmY+LSn7dh1Lf7YBAIwB
 lsMMmigMTk3Qgwymg1nT+Z8z1Owc/TGtRlo4ZcwMzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmAhsMFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmrTNKcFCRUFdT0ACgkQq1/riG27mcLEVwD/VmnQtTf6yhowaIFj
 AjUtwiyQz9ja4NRu9GOvz/pb2L8A/3QcADR0dcxADGsmOiBpN2M9KI7nqdNIq3VPM/3/5fcB
In-Reply-To: <20261021145115.153107-1-chunyuzhiqiang@yinhe.ht>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Chun,

Because it seems you are preparing a v8, here are a few final nitpicks
on the line wrap.

On 21/10/2026 at 16:51, ChunYuZhiQiang wrote:
> If the interface is down, the CAN controller might be powered down, the
> clock disabled, and/or its external reset asserted.
> 
> Don't call do_get_berr_counter() or do_get_auto_tdcv() to read the CAN
> controller if the interface is down. This fixes a generic logic problem
> that exists on all platforms.
> 
> As a result, IFLA_CAN_BERR_COUNTER is no longer reported for down
> interfaces, and the automatic TDCV readback is skipped for both CAN FD
> and CAN XL. The other TDC parameters are still reported, as they are
> meaningful while the interface is down. Userspace must treat these
> attributes as optional.
> 
> The berr-counter issue was triggered on an i.MX8QXP board by running
> "ip link show" without ever bringing the interface up. On i.MX8QXP the
> CAN clocks are gated through the SCU LPCG and the subsystem shares the
> IMX_SC_R_CAN_0 power domain; there is a window where
> pm_runtime_resume_and_get() has returned but the clock has not reached
> the module yet, and the immediate ECR read raises a synchronous
> external abort. This is the same class of problem fixed for m_can in
> commit 91a55c72a821 ("can: m_can: m_can_get_berr_counter(): don't wake
> up controller if interface is down").
> 
> The TDC auto readback path was found by code inspection; it is gated as
> a precaution because xcan_get_auto_tdcv() reads XCAN_SR without taking a
> runtime PM reference.
> 
> Note: do_get_state() is left unguarded. Drivers that implement it by
> reading live status registers may need a similar fix. This is tracked
> separately and is not changed by this patch.
> 
> Fixes: ec56acfef2af1 ("can: flexcan: flexcan_get_berr_counter(): switch on clocks before accessing ecr register")
> Cc: stable@vger.kernel.org
> Signed-off-by: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
> ---
> v7:
>  - Rebase onto current net-next/main, including e63281614747
>    ("can: netlink: add initial CAN XL support").
>  - Gate do_get_auto_tdcv() on netif_running() for both IFLA_CAN_TDC and
>    IFLA_CAN_XL_TDC. The other TDC parameters are still reported for down
>    interfaces.
>  - Pass dev to can_tdc_get_size() and can_data_bittiming_get_size()
>    instead of a bool, as suggested by Vincent Mailhol.
>  - Adjust the TDC size calculation for both FD and XL paths.
>  - Keep the berr-counter gating unchanged.
>  - The Fixes: tag points to ec56acfef2af1 because this patch supersedes
>    the down-interface readback behavior it introduced, not because that
>    commit was buggy.
>  - TDC auto readback gating is based on code inspection; only the
>    berr-counter path was tested on i.MX8QXP hardware.
> ---
>  drivers/net/can/dev/netlink.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> index 766d455950f5..ac30d2849543 100644
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c
> @@ -720,7 +720,8 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
>  	return 0;
>  }
>  
> -static size_t can_tdc_get_size(struct data_bittiming_params *dbt_params,
> +static size_t can_tdc_get_size(const struct net_device *dev,
> +			       struct data_bittiming_params *dbt_params,
>  			       u32 tdc_flags)
>  {
>  	bool tdc_manual = tdc_flags & CAN_CTRLMODE_TDC_MANUAL_MASK;
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
> @@ -752,8 +754,10 @@ static size_t can_tdc_get_size(struct data_bittiming_params *dbt_params,
>  	return size;
>  }
>  
> -static size_t can_data_bittiming_get_size(struct data_bittiming_params *dbt_params,
> -					  u32 tdc_flags)
> +static size_t
> +can_data_bittiming_get_size(const struct net_device *dev,
> +			    struct data_bittiming_params *dbt_params,
> +			    u32 tdc_flags)
>  {
>  	size_t size = 0;
>  
> @@ -764,7 +768,7 @@ static size_t can_data_bittiming_get_size(struct data_bittiming_params *dbt_para
>  	if (dbt_params->data_bitrate_const)		/* IFLA_CAN_{,XL}_DATA_BITRATE_CONST */
>  		size += nla_total_size(sizeof(*dbt_params->data_bitrate_const) *
>  				       dbt_params->data_bitrate_const_cnt);
> -	size += can_tdc_get_size(dbt_params, tdc_flags);/* IFLA_CAN_{,XL}_TDC */
> +	size += can_tdc_get_size(dev, dbt_params, tdc_flags);/* IFLA_CAN_{,XL}_TDC */
>  
>  	return size;
>  }
> @@ -812,7 +816,8 @@ static size_t can_get_size(const struct net_device *dev)
>  	size += nla_total_size(sizeof(u32));			/* IFLA_CAN_STATE */
>  	size += nla_total_size(sizeof(struct can_ctrlmode));	/* IFLA_CAN_CTRLMODE */
>  	size += nla_total_size(sizeof(u32));			/* IFLA_CAN_RESTART_MS */
> -	if (priv->do_get_berr_counter)				/* IFLA_CAN_BERR_COUNTER */
> +	if (priv->do_get_berr_counter &&
> +	    netif_running(dev))				/* IFLA_CAN_BERR_COUNTER */

Put this on a single line:

	if (priv->do_get_berr_counter && netif_running(dev))	/* IFLA_CAN_BERR_COUNTER */

(it slightly exceeds the 80 column limit, but so does the surrounding
code).

>  		size += nla_total_size(sizeof(struct can_berr_counter));
>  	if (priv->termination_const) {
>  		size += nla_total_size(sizeof(priv->termination));		/* IFLA_CAN_TERMINATION */
> @@ -825,10 +830,10 @@ static size_t can_get_size(const struct net_device *dev)
>  	size += sizeof(priv->bitrate_max);			/* IFLA_CAN_BITRATE_MAX */
>  	size += can_ctrlmode_ext_get_size();			/* IFLA_CAN_CTRLMODE_EXT */
>  
> -	size += can_data_bittiming_get_size(&priv->fd,
> +	size += can_data_bittiming_get_size(dev, &priv->fd,
>  					    priv->ctrlmode & CAN_CTRLMODE_FD_TDC_MASK);
>  
> -	size += can_data_bittiming_get_size(&priv->xl,
> +	size += can_data_bittiming_get_size(dev, &priv->xl,
>  					    priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MASK);
>  	size += can_pwm_get_size(priv->xl.pwm_const,		/* IFLA_CAN_XL_PWM */
>  				 priv->ctrlmode & CAN_CTRLMODE_XL_TMS);
> @@ -910,7 +915,8 @@ static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev,
>  		if (tdc_manual) {
>  			tdcv = tdc->tdcv;
>  			err = 0;
> -		} else if (dbt_params->do_get_auto_tdcv) {
> +		} else if (dbt_params->do_get_auto_tdcv &&
> +			   netif_running(dev)) {

Same, this fit in one line:

		} else if (dbt_params->do_get_auto_tdcv && netif_running(dev)) {

>  			err = dbt_params->do_get_auto_tdcv(dev, &tdcv);
>  		}
>  		if (!err && nla_put_u32(skb, IFLA_CAN_TDC_TDCV, tdcv))
> @@ -1006,7 +1012,7 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
>  	    nla_put(skb, IFLA_CAN_CTRLMODE, sizeof(cm), &cm) ||
>  	    nla_put_u32(skb, IFLA_CAN_RESTART_MS, priv->restart_ms) ||
>  
> -	    (priv->do_get_berr_counter &&
> +	    (priv->do_get_berr_counter && netif_running(dev) &&
>  	     !priv->do_get_berr_counter(dev, &bec) &&
>  	     nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)) ||
>  


Yours sincerely,
Vincent Mailhol
