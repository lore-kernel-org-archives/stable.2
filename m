Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795376340;
	b=4iNwCYaCJKXBea8tiCNxXHhbODKxhmqJCHBKHkAFnNMYcRMwECx664A6ozaCGua1J7Sk
	 wlPEorTjiDs12dRREu0WJKihCM95weCUAT49r7rPnaxyrH4hYBBLHZc8u2+ADDN+tB3+Y
	 ekDGHJsLDLf6df6UtHZVTKrFRX3R+PnxtQAl2ElMnh88DNFgGGFeUj+lvADJexaHdSmKE
	 M4SgkXsz3uEUMQYDdjjOhXm4lTa+a3Kd2xGea28JdUOAoPU4z5FFW909Tx9l0cjjJoWPy
	 rcdtABnUXWhk08N0zeuO23zj3ceE/dKFEorGuCDtobHOylqw62w2fulNaIyJix4dmRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795376340;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oHfNE2FrHtU3di/e/cxdeoKGuVbbhpDJwU4TFPOv7vg=;
	b=QGa79VMujC34198Egbf5ER/Hjsr9rbbBPeWiY3jP5XMkI4iiS2sEKL4azWwhgzotVHoa
	 6esNmFBMqvniUxsKqeH35KGmbCKs7s1juAyLDyYfdUMNc4HwvXQ84HbTD5odVq6BXH6kO
	 kSpDSO2elHbFT8yUrl8KDL1X93LS9EenRm96tfTX3r8+B6xNv98ksEQSOAajtQGDZFKvn
	 0ghPEuF+K4q7eNlgdOJ0/qU52r2g5mT5ogi7OmPDb3NSvNTI2hz2L0znZQRMmRObnA1Q2
	 ozLFH3Fb+xJrRDQM9TPvkAIg7ohScDl9FYUVKmtWiKK5i1o4mkT09MYmdvbLp5ch8Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hlgDYRvw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F8A606A31A;
	Sun, 22 Nov 2026 19:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hlgDYRvw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DFA1F000C0;
	Sun, 22 Nov 2026 19:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795376340;
	bh=oHfNE2FrHtU3di/e/cxdeoKGuVbbhpDJwU4TFPOv7vg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hlgDYRvwmfESIhbfYDceml2roiRZh1wYaa/Hl1eY/CWIX2B2AfRBYf6Htwk+biVBU
	 2dtL+kAmM4RzZx9kBgDssEpyvMCIqed1QsZMWjU07OjySH0199BPOULNZdWICTUK57
	 dMYusbrd+00lvtCU2sjXUHw1lSfy5nJkNyQ8mWrGlOvHELOlWg5+kDVwaboLlRvGeM
	 HANozDz4B7bidfDM0EE/u0R8B3LfdTFLKY0sX+dTHcWEjzf/w+Zw3+6IZz/tnW4QdI
	 UwLpPiPFIYeUWKj0oBQE2qNQPQnHyKVvcT8CFhhjJxwiNvOYTs+MBaZ+JckU5w1kd5
	 vDasUxlUcfRGg==
Subject: Re: [PATCH net] can: dev: reject unusable bit-timing constants
From: netdev-bot+sashiko@kernel.org
To: 25031212351@stu.xidian.edu.cn
Cc: mkl@pengutronix.de, mailhol@kernel.org, socketcan@hartkopp.net,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, byu@xidian.edu.cn, wencheng@xidian.edu.cn,
 kuba@kernel.org
Date: Sun, 22 Nov 2026 19:38:59 +0000
Message-ID: <179537633929.3131.15035208233234553367@kernel.org>
In-Reply-To: <20261121064449.9706-1-25031212351@stu.xidian.edu.cn>
References: <20261121064449.9706-1-25031212351@stu.xidian.edu.cn>
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

- [High] The fix only checks for zero, so the bug class it claims to
  close is still reachable with nonzero device-supplied constants.
- [Medium] register_candev() (drivers/net/can/dev/dev.c:649-651) runs
  can_bittiming_const_valid() only on priv->bittiming_const and…
- [Low] In can_bittiming_const_valid()
  (drivers/net/can/dev/dev.c:611-616), the new comment says the tseg…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but a
  CAP_NET_ADMIN user can crash the kernel on any CAN device that has a…

--

can: dev: reject unusable bit-timing constants

This patch adds checks to can_bittiming_const_valid(), which
register_candev() calls. Drivers that register bit-timing constants with
brp_min, brp_inc, tseg1_min or tseg2_min set to zero are now rejected.
The goal is to stop a device-supplied value (for example from gs_usb)
from causing a divide error or an endless loop in can_calc_bittiming().

> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> index 769745e22a3c7..749da996331a4 100644
> --- a/drivers/net/can/dev/dev.c
> +++ b/drivers/net/can/dev/dev.c
> @@ -601,6 +601,20 @@ can_bittiming_const_valid(const struct can_bittiming_const *btc)
>  	if (!btc)
>  		return true;
>  
> +	/* can_calc_bittiming() rounds the bit-rate prescaler to a multiple of
> +	 * brp_inc and divides priv->clock.freq by brp. A zero brp_inc divides
> +	 * by zero directly, a zero brp_min lets brp become zero.
> +	 */
> +	if (!btc->brp_min || !btc->brp_inc)
> +		return false;
> +
> +	/* The time segment loop counts down to tseg1_min + tseg2_min. If both
> +	 * are zero the unsigned loop counter wraps around and the loop does
> +	 * not terminate.
> +	 */
> +	if (!btc->tseg1_min || !btc->tseg2_min)
> +		return false;

[Severity: Low]
This isn't a bug, but the comment and the check don't match. The comment
says the loop wraps only "If both are zero". The check rejects the
constants when either minimum is zero.

The loop bound in can_calc_bittiming() depends only on the sum:

	     tseg >= (btc->tseg1_min + btc->tseg2_min) * 2; tseg--) {

With tseg1_min = 0 and tseg2_min = 1, the bound is 2 and the loop
terminates.

Should the comment say that a zero tseg minimum is never valid timing?
Alternatively, should the check be !(btc->tseg1_min + btc->tseg2_min)?
On gs_usb, a firmware that reports a single zero minimum would now fail
to probe, and the comment does not explain why.

[Severity: High]
Do zero checks alone stop device-supplied constants from crashing the
kernel? gs_make_candev() copies every bit-timing field from the
GS_USB_BREQ_BT_CONST response with no range check. can_calc_bittiming()
does all its bound and divisor arithmetic in unsigned int:

drivers/net/can/dev/calc_bittiming.c:can_calc_bittiming() {
    ...
	for (tseg = (btc->tseg1_max + btc->tseg2_max) * 2 + 1;
	     tseg >= (btc->tseg1_min + btc->tseg2_min) * 2; tseg--) {
		tsegall = CAN_SYNC_SEG + tseg / 2;

		/* Compute all possible tseg choices (tseg=tseg1+tseg2) */
		brp = priv->clock.freq / (tsegall * bt->bitrate) + tseg % 2;
    ...
		bitrate = priv->clock.freq / (brp * tsegall);
    ...
}

With tseg1_min = 1 and tseg2_min = 0x7FFFFFFF, both minima are nonzero.
(1 + 0x7FFFFFFF) * 2 wraps to 0, so tseg >= 0 is always true. The
counter wraps, which is the non-terminating loop the new comment
describes. After the wrap, tsegall is 0x80000000, so tsegall *
bt->bitrate is 0 for any even bitrate.

With tseg1_max = 0x3FFFFFFF and tseg2_max = 1, the loop starts at tseg =
0x80000001. By the third iteration tsegall is 2^30, and 2^30 * 500000
is 0 mod 2^32. That gives the same divide error as the oops in the
commit message. Even without the fault, about 2^31 iterations would run
under RTNL.

An unbounded brp_max can also make brp * tsegall above wrap to 0. The
same goes for bt->brp * can_bit_time(bt) in can_fixup_bittiming().

The commit message says such a device should "fail to probe instead of
taking the kernel down later". Should the validation also bound the
maxima and the sums? Examples would be rejecting min > max and rejecting
tseg sums that overflow when doubled. The other option is to make
can_calc_bittiming() overflow-safe with u64 arithmetic or
check_mul_overflow().

> +
>  	if (!btc->sjw_max)
>  		return false;
>  

[Severity: Medium]
Should the XL data bit-timing constants be validated as well?
register_candev() runs the validator on only two of the three constant
sets:

drivers/net/can/dev/dev.c:register_candev() {
    ...
	if (!can_bittiming_const_valid(priv->bittiming_const) ||
	    !can_bittiming_const_valid(priv->fd.data_bittiming_const))
		return -EINVAL;
    ...
}

priv->xl.data_bittiming_const is never checked. However,
can_dbt_changelink() sets dbt_params to &priv->xl and passes
dbt_params->data_bittiming_const down this chain:

can_dbt_changelink()->can_get_bittiming()->can_calc_bittiming()

can_calc_bittiming() explicitly expects btc ==
priv->xl.data_bittiming_const. It then runs the same brp / btc->brp_inc
division and tseg minima loop.

A CAN XL driver that registers XL constants with brp_inc = 0 or zero
tseg minima would still probe. It would then crash once
IFLA_CAN_XL_DATA_BITTIMING is set with a bitrate.

The only in-tree user today is dummy_can, and its constants are static
and valid. So this is a gap in the new validation rather than a crash
that can be triggered now.

[Severity: High]
This isn't a bug introduced by this patch, but a related divide error
can be triggered with valid constants. It only needs a large
user-supplied bitrate.

can_changelink() calls can_get_bittiming() before it checks
bitrate_max:

drivers/net/can/dev/netlink.c:can_changelink() {
    ...
		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
		err = can_get_bittiming(dev, &bt,
					priv->bittiming_const,
					priv->bitrate_const,
					priv->bitrate_const_cnt,
					extack);
		if (err)
			return err;

		if (priv->bitrate_max && bt.bitrate > priv->bitrate_max) {
    ...
}

Take a bitrate of 2147483648 (2^31). In can_calc_bittiming(), tsegall *
bt->bitrate is 0 mod 2^32 for any even tsegall, and an even tsegall
comes up within the first three iterations.

The division in this expression runs before any range check:

		brp = priv->clock.freq / (tsegall * bt->bitrate) + tseg % 2;

can_dbt_changelink() has the same ordering for the FD and XL data
bitrates.

This appears to affect every driver with a bittiming_const, including
gs_usb and dummy_can. In dummy_can, the bitrate_max check runs too late
to help.

Would a u64 product or check_mul_overflow() in can_calc_bittiming(), or
a bitrate upper bound before the calculation, avoid this?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121064449.9706-1-25031212351%40stu.xidian.edu.cn
