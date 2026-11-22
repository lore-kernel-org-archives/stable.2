Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795388252;
	b=IVJ/QZQ7HFplkelkbB8Z5HQN0YP2v+SoHEvc0ocsJw1eIexDmpLtuPxyj7EEdK/rxwL1
	 IFTa7//AhfYh8MnvDE1PDf/4a6GLU0rGnd5vL9ws1TTaqpsHpKPQjaeY7tNDM1Q+SR9cR
	 OVwREu7H/q7dPQQ9oasFk6p1GfH0iFlmWmoPtviO0OMtGWs9yGg1tRBz9FGKwbFg+h/rv
	 uVizUV9Z31wB4OSGjTSC2rR/uf4zKtNQnd883PxzufGlxwJAaI5mnUznuFQ4k7rEWVEAc
	 +lschKuGiYGsyX+DttalWLZxVHUOu9RUtrxi1A56mpzf2KDzTblxLAlkhEfVuE7nhTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795388252;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=jjXLYua8yEMOZG20v0014nN/5Rs2wlsBWV6M4sI7iCI=;
	b=q92nW01ac5dJTU68iTHGvoMkwwYR+Qu76GB0nGZWenaFbdfxDf1JIbzOWKMSyZBYbSM8
	 yt5tnaAvBoYM2HIS5ixnvjpxLNdDJt746wzBKE5VXOUaq/aidfZo4EtzT+kxyM1w8CdQ7
	 0+pliNRo6JdsSV5z/dnjswdEP1Gk0pq8PizeOQdn4+3Y0LhH9VEqsgC7Lm0Bq9alko357
	 NgN1XZh0fo+kt7ttLjPtDxFo0LHE+N29TSpOViGLVW8JydhGYlsamUznv5a+MP1tDfPiv
	 Y4TzAVdbkeSjN/Ec5BCHX/AFmAH7DXr1WMEm4SYMldc9/f9eYmRDNXGite4x10DyTag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Di9MXQCe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B828606A31A;
	Sun, 22 Nov 2026 22:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Di9MXQCe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341581F000CA;
	Sun, 22 Nov 2026 22:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795388251;
	bh=jjXLYua8yEMOZG20v0014nN/5Rs2wlsBWV6M4sI7iCI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Di9MXQCen520rO1uRAE9Usc9ysRbdAnis6wFWyzbj7grcxIE1lvdZsu0oo6g+eHeN
	 MzaLgjueWlINkBOPNZXSFW57nF/o40+mMB251dakPQRG46O1YdVlu/J3xL7zASzoF0
	 6ZHJYAsl8045YyeKD2N6oSopo3k0Z+yMgsMeh9aFwY39gcM3Q1rTwU3TUINrqbTnyq
	 BB92hm4LIIohgYfMPA0Vr+CtkR28wWR7QCfr1E94LrMNMQLwQsDzEGV5GNMnePPM1h
	 4J653q7lDw+IaUtobD77gyBvdgqY5vSbEQe/+jhkW2qcaZoe9BhPuIlrRY8VTU4jfC
	 iRTg8u/73nVLA==
Subject: Re: [PATCH net v2] can: dev: reject unusable bit-timing constants
From: netdev-bot+sashiko@kernel.org
To: 25031212351@stu.xidian.edu.cn
Cc: mkl@pengutronix.de, mailhol@kernel.org, socketcan@hartkopp.net,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, byu@xidian.edu.cn, wencheng@xidian.edu.cn,
 kuba@kernel.org
Date: Sun, 22 Nov 2026 22:57:30 +0000
Message-ID: <179538825072.3131.7118815518800235800@kernel.org>
In-Reply-To: <20261121094534.5221-1-25031212351@stu.xidian.edu.cn>
References: <20261121094534.5221-1-25031212351@stu.xidian.edu.cn>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is meant to make devices that hand out unusable timing
  values fail to probe.
- [Medium] register_candev() (drivers/net/can/dev/dev.c:670-672) passes
  only priv->bittiming_const and priv->fd.data_bittiming_const to the…
- [Low] can_bittiming_const_valid() rejects more constant sets than its
  comments and the commit body justify.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  leaves the same divide-error oops reachable from user space, and the…

--

can: dev: reject unusable bit-timing constants

This patch extends can_bittiming_const_valid(), which register_candev()
calls. The function now rejects bit-timing constants with a zero brp_min
or brp_inc, zero or inconsistent tseg minima, a bit time above 1024 tq,
or a brp_max * bit time product that does not fit in 32 bits. The goal
is that devices such as gs_usb that report unusable constants fail to
probe instead of crashing can_calc_bittiming() later.

> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> index 769745e22a3c7..db541f935d102 100644
> --- a/drivers/net/can/dev/dev.c
> +++ b/drivers/net/can/dev/dev.c
> @@ -595,15 +595,50 @@ static int can_get_termination(struct net_device *ndev)

[ ... ]

>  static bool
>  can_bittiming_const_valid(const struct can_bittiming_const *btc)
>  {

[ ... ]

> +	/* can_calc_bittiming() rounds the bit-rate prescaler to a multiple of
> +	 * brp_inc and divides priv->clock.freq by brp. A zero brp_inc divides
> +	 * by zero directly, a zero brp_min lets brp become zero.
> +	 */
> +	if (!btc->brp_min || btc->brp_min > btc->brp_max || !btc->brp_inc)
> +		return false;

[Severity: High]
The commit message says a device that hands out unusable values should
fail to probe. Should that also cover the clock frequency? gs_usb takes
it from the same GS_USB_BREQ_BT_CONST response:

drivers/net/can/usb/gs_usb.c:gs_make_candev() {
    ...
	dev->can.clock.freq = le32_to_cpu(bt_const.fclk_can);
    ...
}

Neither gs_make_candev() nor register_candev() checks clock.freq. ucan
does the same with device_info->freq.

Take fclk_can = 0 and constants that pass the new checks (tseg1 1..16,
tseg2 1..8, brp 1..1024, brp_inc 1). A bitrate of 0xFFFFFFFF then seems
to get all the way through can_calc_bittiming():

	brp = priv->clock.freq / (tsegall * bt->bitrate) + tseg % 2;
	    -> 0 + 1 for odd tseg, passes the brp_min/brp_max check
	bitrate = priv->clock.freq / (brp * tsegall);
	    -> 0
	bitrate_error = abs(bt->bitrate - bitrate);
	    -> abs() works on a signed int here, so this is 1

The relative error is then 1 * 10000 / 0xFFFFFFFF, clamped to 1. That
is below CAN_CALC_MAX_ERROR, so the function goes on to:

	v64 = (u64)best_brp * 1000 * 1000 * 1000;
	do_div(v64, priv->clock.freq);

Can this divide by zero with RTNL held, via
can_changelink()->can_get_bittiming()->can_calc_bittiming()? Would a
non-zero clock.freq check in register_candev() close it?

> +
> +	/* The time segment loop counts down from the maxima to the minima.
> +	 * Zero minima make the unsigned loop counter wrap around, a minimum
> +	 * above its maximum makes the loop bounds inconsistent.
> +	 */
> +	if (!btc->tseg1_min || btc->tseg1_min > btc->tseg1_max)
> +		return false;

[Severity: Low]
Is this comment accurate? The loop in can_calc_bittiming() is:

	for (tseg = (btc->tseg1_max + btc->tseg2_max) * 2 + 1;
	     tseg >= (btc->tseg1_min + btc->tseg2_min) * 2; tseg--) {

Only a zero sum of tseg1_min + tseg2_min makes it wrap. With a single
zero minimum the loop still terminates. A resulting phase segment of 0
then makes can_sjw_check() return -EINVAL.

The min > max checks for brp, tseg1 and tseg2 do not crash anything
either. No candidate is found, and can_calc_bittiming() or
can_fixup_bittiming() returns -EINVAL.

The commit message says "brp_min and the time segment minima are just
as fatal". The min > max checks are only mentioned in the v2 notes below
the --- line, and those are dropped when the patch is applied.

A gs_usb or ucan device that reports, for example, tseg2_min = 0 or
brp_min > brp_max will now fail to probe. Could the comment and the
commit message describe these checks as rejecting nonsensical values
rather than as preventing crashes?

> +
> +	if (!btc->tseg2_min || btc->tseg2_min > btc->tseg2_max)
> +		return false;
> +
> +	bit_time = (u64)btc->tseg1_max + btc->tseg2_max + CAN_SYNC_SEG;
> +	if (bit_time > CAN_MAX_BIT_TIME_TQ)
> +		return false;
> +
> +	/* can_calc_bittiming() and can_fixup_bittiming() multiply the prescaler
> +	 * by the bit time, keep the product inside 32 bits.
> +	 */
> +	if (bit_time * btc->brp_max > UINT_MAX)
> +		return false;

[Severity: High]
This is a pre-existing issue, not one introduced by this patch. The
commit message calls the tsegall * bt->bitrate overflow a separate
problem. Because of it, the divide error shown in the changelog can
still be reached from user space on every device that has
bittiming_const.

can_changelink() copies struct can_bittiming from IFLA_CAN_BITTIMING.
It calls can_get_bittiming() before the bitrate_max check, so
bt.bitrate has no upper bound when it reaches can_calc_bittiming():

	brp = priv->clock.freq / (tsegall * bt->bitrate) + tseg % 2;

Take bitrate = 0x80000000 and tq = 0. For the first even tsegall, the
32-bit product wraps to 0. The loop only exits early when bitrate_error
is 0, which cannot happen here, so the loop always reaches an even
tsegall.

Can something like "ip link set canX type can bitrate 2147483648"
trigger the divide error with RTNL held? The new bit_time and
bit_time * brp_max limits only bound brp * tsegall.
can_dbt_changelink() looks like it has the same problem for the FD and
XL data bit timing.

> +
>  	return true;
>  }

[Severity: Medium]
Should register_candev() also validate priv->xl.data_bittiming_const?
It only does:

	if (!can_bittiming_const_valid(priv->bittiming_const) ||
	    !can_bittiming_const_valid(priv->fd.data_bittiming_const))
		return -EINVAL;

The XL data constants reach the same code. can_changelink() calls
can_dbt_changelink(dev, data, false, extack), which sets
dbt_params = &priv->xl and passes dbt_params->data_bittiming_const to
can_get_bittiming(). can_calc_bittiming() then does the brp_inc
division, the tseg loop and the freq / (brp * tsegall) computation with
those constants.

A CAN XL driver that registers bad XL data constants could still hit
the divide by zero or the wrapping loop. xl.pwm_const is not checked
either, and can_calc_pwm() divides by
(pwm_const->pwms_min + pwm_const->pwml_min).

Today only dummy_can sets xl.data_bittiming_const, and its static
values are valid, so nothing in-tree triggers this yet.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121094534.5221-1-25031212351%40stu.xidian.edu.cn
