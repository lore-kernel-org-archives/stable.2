Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795558483;
	b=DPsmh7z/JIS0sPe3r6yqeEUOKUx86eIPqx1Cv4TIYpI0BzS0zIs4D8cbb0lZM05TKRwh
	 aKeOuqIvKvM/K0K2ivjc63BVPhGvB6zhLcl+gHCZKeUlVhFeMXtQsjQDCgJvuLEA17Haj
	 tYUzRzSJjjcUpex+D+n8rMFZWYChkfI/bXuztXd5+CPbItp0o+6i/nqKHkF6WCn8m21Nq
	 AhAK0H/62ts5gfe3wLbO+86mHkV+iuhPZBBmYZeHRRPiykg45h7hNQQYLkbOfujrFCgIa
	 RZmv/CdPyYUDNJimRW/Dw7D0OW3G3jDKt/LOQMS0CvLzAmd/V1hI44N+a0TaKkm3fsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795558483;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=bMF4ZZDGyUJAXrolZjC1+tfiI4CiFAo8Cfg/FTkVIFc=;
	b=Rsl2t9lY6POkJIC73cy5ti0BvxyvOTd+goBceSW0OMadlaj1b+5WA210HQlRSLJO7nhf
	 Yof3a77yPUkyZ6Ra4s/EICDk01MnW4ws2y36AxmlTgej7hd1qXkGOcHYhgFJm+9s/lcLY
	 6m+Ny36Buj89BJhcadaEqVJWo+W1vQa7Y46qCuHK24v395fuOKBLQI6ILrlu+I5exijyM
	 DZWr1vwYQBbZFe9ggV7Kx+4M9LPMET11cV+o1AydYA/Df1GGw2gzec91uAFlwco9blQCA
	 +v9QWz5pDk4FoeLIs8JicinwntFsTQ4RE662/ijSD5zD1oXzxWaLHHbKbHlVO2Nx8zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HbrnSlUZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EEF606A31E;
	Tue, 24 Nov 2026 22:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HbrnSlUZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598771F000C6;
	Tue, 24 Nov 2026 22:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795558482;
	bh=bMF4ZZDGyUJAXrolZjC1+tfiI4CiFAo8Cfg/FTkVIFc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HbrnSlUZOuDW52qve1H9AahgnCSYzuqvIBYI9GCYsUrj/Vz+SjyrvlPt7usdoOz55
	 H6z83S4Lm9OmaQodyRJOrF/SQmeD5w0/RHfueFv5c0LEMBE14zETQg4PGWzKqq9xWe
	 f3IxVSsCBEqRihYPDT/W3SLcV/5yijJSai9j7Vn7TApxeQXHRf5fLa8JRIYCAJ/oJ7
	 TbyRILTUtybJe1K17o75Ylfdp/OUm/RdCpxvrCGRdjVpjMDw/uGq6XnF9UZyKZjjXw
	 0aP/ZkGTuTGfglTTsfTqLtha47g3cxmIoFLk9S2KN0sVwWwRfq4q9LEEjKsf2HH/Vx
	 SI6KCMfSkxhyA==
Subject: Re: [PATCH net v4] can: dev: reject unusable bit-timing constants
From: netdev-bot+sashiko@kernel.org
To: 25031212351@stu.xidian.edu.cn
Cc: mkl@pengutronix.de, mailhol@kernel.org, socketcan@hartkopp.net,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, byu@xidian.edu.cn, wencheng@xidian.edu.cn,
 kuba@kernel.org
Date: Tue, 24 Nov 2026 22:14:41 +0000
Message-ID: <179555848191.3131.5345246106199936359@kernel.org>
In-Reply-To: <20261123093809.5154-1-25031212351@stu.xidian.edu.cn>
References: <20261123093809.5154-1-25031212351@stu.xidian.edu.cn>
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

Critical: 0 · High: 1 (2) · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] A device can still crash the kernel with a divide error, which
  is what this patch says it prevents.
- [Low] register_candev() only rejects a zero clock frequency when
  priv->bittiming_const is set: `if (priv->bittiming_const &&…
- [Low] The patch adds a new rejection criterion: CAN_MAX_BIT_TIME_TQ =
  1024, so registration fails if tseg1_max + tseg2_max + CAN_SYNC_SEG >…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but can_calc_pwm()
  can still divide by zero (modulo) when priv->xl.data_bittiming was…
- [High] This problem wasn't introduced by this patch, but
  can_calc_bittiming() computes `brp = priv->clock.freq / (tsegall *…

--

can: dev: reject unusable bit-timing constants

This patch extends can_bittiming_const_valid() with several new checks.
It requires tseg1, tseg2 and brp min/max values that are consistent,
rejects brp_inc = 0, caps the bit time at 1024 TQ, and adds
can_pwm_const_valid() for the CAN XL PWM constants. register_candev() now
rejects a zero clock frequency when CAN-CC constants are present, and it
requires CAN-CC constants for CAN-FD.

> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> index 769745e22a3c7..9325406ff1a82 100644
> --- a/drivers/net/can/dev/dev.c
> +++ b/drivers/net/can/dev/dev.c

[ ... ]

> @@ -595,15 +596,54 @@ static int can_get_termination(struct net_device *ndev)
>  	return 0;
>  }
>  
> +/* Upper bound for the bit time in time quanta. The bit times of the
> + * currently supported CAN controllers are well below it, the limit keeps the
> + * time segment scan in can_calc_bittiming() bounded.
> + */
> +#define CAN_MAX_BIT_TIME_TQ 1024
> +
>  static bool
>  can_bittiming_const_valid(const struct can_bittiming_const *btc)
>  {

[ ... ]

> +	if (!btc->brp_min || btc->brp_min > btc->brp_max || !btc->brp_inc)
> +		return false;

[Severity: High]
Can a USB device still trigger a divide error by reporting a very large
brp_max? This check only compares brp_max against brp_min, and gs_usb and
ucan copy the value straight from the device:

drivers/net/can/usb/gs_usb.c:gs_make_candev() {
    ...
	dev->bt_const.brp_max = le32_to_cpu(bt_const.brp_max);
    ...
}

For example, these values pass all of the new checks (bit_time is 24):

  tseg1 1..15, tseg2 1..8, sjw_max 1
  brp 1..0xFFFFFFFF, brp_inc 1
  80 MHz clock

A CAP_NET_ADMIN user can then send IFLA_CAN_BITTIMING with these values:

  tq = 3355443200
  prop_seg = 1, phase_seg1 = 6, phase_seg2 = 8, sjw = 1

can_fixup_bittiming() computes brp = 2^28, which is inside
[brp_min, brp_max], and then does:

drivers/net/can/dev/bittiming.c:can_fixup_bittiming() {
    ...
	bt->bitrate = priv->clock.freq / (bt->brp * can_bit_time(bt));
    ...
}

2^28 * 16 wraps to 0 in unsigned int. This happens before the
bitrate_max check in can_changelink().

can_calc_bittiming() uses the same kind of 32-bit product as a divisor:

	bitrate = priv->clock.freq / (brp * tsegall);

So does can_bit_time_tqmin(), which can_calc_pwm() calls. gs_usb also takes
the FD dbrp_max from the device.

The v4 changelog says the brp_max * bit time limit was dropped because
"the multiplication is fixed separately". I could not find such a fix in
the tree, and the commit message only sets aside the tsegall * bitrate
overflow.

Could a bound like (u64)btc->brp_max * bit_time <= U32_MAX be added back?
In-tree drivers all have small brp_max values.

> +
> +	bit_time = (u64)btc->tseg1_max + btc->tseg2_max + CAN_SYNC_SEG;
> +	if (bit_time > CAN_MAX_BIT_TIME_TQ)
> +		return false;

[Severity: Low]
This isn't a bug, but the commit message does not mention this new limit.
Registration now fails for any device with a bit time above 1024 TQ.

The cap also stops the loop bounds in can_calc_bittiming() from wrapping:

	for (tseg = (btc->tseg1_max + btc->tseg2_max) * 2 + 1;
	     tseg >= (btc->tseg1_min + btc->tseg2_min) * 2; tseg--) {

Without the cap, tseg1_min = tseg2_min = 2^31 makes the lower bound wrap
to 0, and the loop never ends while RTNL is held.

Since this is tagged for stable, could the commit message describe the
new limit and the hang it prevents? No in-tree driver appears to be
affected. The largest bit time I found is kvaser_pciefd at 545 TQ.

> +
> +	return true;
> +}
> +
> +static bool
> +can_pwm_const_valid(const struct can_pwm_const *pwm_const)
> +{

[ ... ]

> +	/* can_calc_pwm() divides by the shortest PWM symbol. */
> +	if (check_add_overflow(pwm_const->pwms_min, pwm_const->pwml_min,
> +			       &shortest_symbol) || !shortest_symbol)
> +		return false;

[Severity: High]
This is a pre-existing issue and was not introduced by this patch.
can_calc_pwm() has a second unguarded division, which depends on device
state rather than on the constants:

drivers/net/can/dev/calc_bittiming.c:can_calc_pwm() {
    ...
	for (pwm_per_bit = DIV_ROUND_UP(xl_ns, CAN_PWM_NS_MAX);
	     pwm_per_bit <= pwm_per_bit_max; pwm_per_bit++)
		if (xl_tqmin % pwm_per_bit == 0)
			break;
    ...
}

If priv->xl.data_bittiming was never set, xl_tqmin, xl_ns and
pwm_per_bit_max are all 0. The loop then computes 0 % 0.

Can that state be reached? can_ctrlmode_changelink() commits
CAN_CTRLMODE_XL | CAN_CTRLMODE_XL_TMS before any bittiming is validated:

	priv->ctrlmode &= ~cm->mask;
	priv->ctrlmode |= maskedflags;

Suppose the CC bittiming step or can_dbt_changelink() then fails in the
same request, for example with tq and bitrate both set, or with an XL data
bitrate above bitrate_max. XL_TMS stays set and xl.data_bittiming stays
zero.

A later changelink that carries only IFLA_CAN_RESTART_MS reaches
can_pwm_changelink(). It has no PWM attribute, so it calls:

	if (!pwm_nla)
		return can_calc_pwm(dev, extack);

dummy_can advertises XL and XL_TMS and sets xl.pwm_const, so a
CAP_NET_ADMIN user appears to be able to reach this path in-tree.

> +
>  	return true;
>  }
>  
> @@ -632,8 +672,26 @@ int register_candev(struct net_device *dev)
>  	    (priv->bittiming_const || priv->fd.data_bittiming_const))
>  		return -EINVAL;
>  
> -	if (!can_bittiming_const_valid(priv->bittiming_const) ||
> -	    !can_bittiming_const_valid(priv->fd.data_bittiming_const))
> +	/* Validate CAN clock and CAN-CC bittiming */
> +	if (priv->bittiming_const &&
> +	    (!priv->clock.freq ||
> +	     !can_bittiming_const_valid(priv->bittiming_const)))
> +		return -EINVAL;

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. The
commit message calls it a separate problem, but it is still reachable in
the calculation this patch hardens:

drivers/net/can/dev/calc_bittiming.c:can_calc_bittiming() {
    ...
		brp = priv->clock.freq / (tsegall * bt->bitrate) + tseg % 2;
    ...
}

bt->bitrate comes straight from IFLA_CAN_BITTIMING, and nothing bounds it
first. can_validate_bittiming() only checks sample_point, and
can_changelink() checks bitrate_max only after can_get_bittiming()
returns.

With tq = 0 and bitrate = 2^28, any tsegall that is a multiple of 16
wraps the product to 0. sja1000 (tsegall 3..25) and dummy_can both reach
tsegall = 16 without breaking out of the loop early. bitrate = 2^31 does
the same for any even tsegall.

A single changelink from a CAP_NET_ADMIN user can hit this on any device
with bittiming_const, with no special hardware. Is a fix planned to land
together with this one?

> +
> +	/* For CAN-FD:
> +	 * Ensure CAN-CC bittiming and validate CAN-FD bittiming
> +	 */
> +	if (priv->fd.data_bittiming_const &&
> +	    (!priv->bittiming_const ||
> +	     !can_bittiming_const_valid(priv->fd.data_bittiming_const)))
> +		return -EINVAL;
> +
> +	/* For CAN XL: validate CAN XL bittiming and PWM constants */
> +	if (priv->xl.data_bittiming_const &&
> +	    !can_bittiming_const_valid(priv->xl.data_bittiming_const))
> +		return -EINVAL;
> +
> +	if (priv->xl.pwm_const && !can_pwm_const_valid(priv->xl.pwm_const))
>  		return -EINVAL;

[Severity: Low]
Should the XL branches also require priv->bittiming_const, as the FD branch
does? The zero clock.freq check only runs when bittiming_const is set. The
"either fixed bit rates or bit timing const" check above also ignores
xl.data_bittiming_const.

A driver that registers xl.data_bittiming_const or xl.pwm_const without CC
constants, and with clock.freq == 0, would pass these checks. It would then
divide by zero in can_calc_bittiming():

	do_div(v64, priv->clock.freq);

It would also divide by zero in can_calc_pwm() through can_tqmin_to_ns().

The only in-tree XL driver today is dummy_can, and it sets both
bittiming_const and clock.freq, so this is latent for now.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123093809.5154-1-25031212351%40stu.xidian.edu.cn
