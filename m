Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706348;
	b=nDhdd+U0lFesEy1MipmYSs8P0OzVgB2RjitETiznFXI3QM9Ryyfg/t601WQUu50OL7z7
	 vdck9K/7H7XCWVAfV94D1vztHdSwIeaIkjJk4YbTkXkBeuAHajIRAXWRFpJq0tb6jftI4
	 YfBoM+KWsseIgiDiKVtwK99CRJo18tbdJCGh5Dja71GrLXXnN9UNfp8IbqDHl9M7WuBVQ
	 2wor7W3fxEij2ZZ9rHn8EcbIevED9cILEviKGYl+TXAgBU1a/yX6xANNA95kfrFHQ2PbD
	 sbZUCtHBEmFAKvJdfBGyU8bcmC61DwLWZKFPIBRZQWnS/JzE8C4ekRikPddmzpnVySw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706348;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PG75BlNB6Kr9dhinJjagcwYRCvcsmgEGtvnVm8e7lyc=;
	b=l7CkFCbgIVjEUAw6z4AROZy3cqTVnV+sQp9aPyQlXlkx9etAMGtYYLZg5w3NtkIMei9G
	 7A9p0JrDsbddB7ufTUB4kpiUobOOOlg+CXReSzkmmIgq38SoBd6rtW1defnHGzEZleVbX
	 BSWuW6E01Z0aI+BnpVT3CZ6D0CQcnbhuKqws/PxMlalsVjkRJb/XTm4FuVL8Qm/kLwaOx
	 XWrhgK87S8IZDhww6dvgoiam73wI1LXKt1W/0coZc22VfKpm94GYhDgW9KJHzp/qpZ9MX
	 ROTWu3Uski6p+VoQ+3B7WYGIwa7QUm1DpsEFXHhHN/J70nXArqaqgFo8aHwFBdWs4Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wppx2NWy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6053606A326;
	Thu, 26 Nov 2026 15:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wppx2NWy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8CC1F000C0;
	Thu, 26 Nov 2026 15:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795706348;
	bh=PG75BlNB6Kr9dhinJjagcwYRCvcsmgEGtvnVm8e7lyc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Wppx2NWyJfIJmXPKlGW76PZnAodmiuOCWGv83swIVOGoz5ioatRvCKTBubY9L4qlK
	 urzw1HNuD8kcueYn+e9OMtMT8AV5WkWb3Sip2d0ImikMQf1lvaBAq0ilZHuih3ewKU
	 6kMszAFihkpzt92O5vbOCYj+SsEVZyjn9jUuAUGIF799rLMiqkGOdWrAyTXayYtSrE
	 brhooqzN2R8NyABHNhvpToUKV6mnb0Qiv6xV86TIv8YnS1DoGjzhHOVpvxFZTe2Qay
	 ZlgcurPXgm0gAaS5OS8luVMG8piBoFKiJhBX3hW+3NJXBaQkhh9asgTDvl8nMRM+5l
	 JSTS/kXzXbMsA==
Subject: Re: [PATCH net v5] can: dev: reject unusable bit-timing constants
From: netdev-bot+sashiko@kernel.org
To: 25031212351@stu.xidian.edu.cn
Cc: mkl@pengutronix.de, mailhol@kernel.org, socketcan@hartkopp.net,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, byu@xidian.edu.cn, wencheng@xidian.edu.cn,
 kuba@kernel.org
Date: Thu, 26 Nov 2026 15:19:07 +0000
Message-ID: <179570634768.3131.15743135323511447022@kernel.org>
In-Reply-To: <20261125012332.6945-1-25031212351@stu.xidian.edu.cn>
References: <20261125012332.6945-1-25031212351@stu.xidian.edu.cn>
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

Critical: 0 · High: 1 (2) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] A USB device can still crash the kernel with a divide error
  through the device-supplied brp_max.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but a
  CAP_NET_ADMIN user can crash any CAN device that has a bittiming_const…
- [High] This problem wasn't introduced by this patch, but can_calc_pwm()
  (drivers/net/can/dev/calc_bittiming.c:244-246) can still compute…

--

can: dev: reject unusable bit-timing constants

This patch extends can_bittiming_const_valid() to reject zero or
inconsistent tseg/brp limits and caps the bit time at CAN_MAX_BIT_TIME_TQ.
It adds can_pwm_const_valid() for the CAN XL PWM constants. It also makes
register_candev() reject a zero clock frequency and check the constants
along the CC -> FD -> XL -> PWM chain.

> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> index 769745e22a3c7..01d74321f3306 100644
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
Can a USB device still cause a divide error through brp_max?

Here brp_max is only compared with brp_min. Its size is never limited.
gs_usb and ucan both take brp_max and the clock frequency from the device:

drivers/net/can/usb/gs_usb.c:gs_make_candev() {
    ...
	dev->bt_const.brp_max = le32_to_cpu(bt_const.brp_max);
    ...
}

drivers/net/can/usb/ucan.c:
	bittiming->brp_max = le32_to_cpu(device_info->brp_max);

The prescaler times the bit time is still a 32 bit product, and it is used
as a divisor:

drivers/net/can/dev/bittiming.c:can_fixup_bittiming() {
    ...
	bt->bitrate = priv->clock.freq / (bt->brp * can_bit_time(bt));
    ...
}

drivers/net/can/dev/calc_bittiming.c:can_calc_bittiming() {
    ...
		bitrate = priv->clock.freq / (brp * tsegall);
    ...
	bt->bitrate = priv->clock.freq /
		(bt->brp * can_bit_time(bt));
}

For example, take a device that reports brp_min = 1, brp_inc = 1,
brp_max = 0xffffffff, tseg1_max = 15, tseg2_max = 8 and fclk_can = 80 MHz.
It passes every new check. A CAP_NET_ADMIN user then sets
tq = 3355443200 ns with prop_seg + phase_seg1 + phase_seg2 = 15:

can_changelink()
  can_get_bittiming()
    can_fixup_bittiming()
      bt->brp = 2^28 (<= brp_max), can_bit_time() = 16
      2^28 * 16 wraps to 0

can_calc_bittiming() reaches the same zero divisor with
tseg1_max + tseg2_max = 1023, fclk_can = 0xffffffff and bitrate = 1. The
first loop iteration gives tsegall = 1024 and brp = 2^22.

The commit message says:

  The 32 bit overflows of the prescaler and of tsegall * bt->bitrate are
  not caused by the constants and are fixed separately.

Is that accurate for the prescaler overflow? No in-tree static table can
reach this wrap. The largest brp_max is 8192, and 8192 * 1024 is far below
2^32. So it looks like only a device-supplied brp_max can trigger it.

The 64 bit multiplication fix mentioned in the v5 changelog is not in this
tree, and the commit message does not reference it. With Cc: stable, would
a backport of this patch alone leave gs_usb and ucan open to the same
divide error?

Would this need a check such as brp_max * CAN_MAX_BIT_TIME_TQ <= U32_MAX,
or an explicit dependency on the companion fix?

> +
> +	bit_time = (u64)btc->tseg1_max + btc->tseg2_max + CAN_SYNC_SEG;
> +	if (bit_time > CAN_MAX_BIT_TIME_TQ)
> +		return false;
> +
> +	return true;
> +}

[Severity: High]
This isn't a bug introduced by this patch. The commit message says the
tsegall * bt->bitrate overflow is fixed separately, but it is still
present in this tree. Can a CAP_NET_ADMIN user crash any controller that
has a bittiming_const by choosing a large bitrate?

drivers/net/can/dev/calc_bittiming.c:can_calc_bittiming() {
    ...
		brp = priv->clock.freq / (tsegall * bt->bitrate) + tseg % 2;
    ...
}

can_validate_bittiming() in netlink.c only checks sample_point. The
bitrate_max check in can_changelink() runs after can_get_bittiming()
returns.

With typical constants (tseg1 1..16, tseg2 1..8), the tsegall scan
includes 16, 8 and 4. With bitrate = 2^30 the product wraps to 0 at those
iterations. Earlier iterations either continue or keep a non-zero bitrate
error, so the loop reaches the division:

ip link set canX type can bitrate 1073741824
  can_changelink()
    can_get_bittiming()
      can_calc_bittiming()
        priv->clock.freq / (tsegall * bt->bitrate)   /* 16 * 2^30 == 0 */

> +
> +static bool
> +can_pwm_const_valid(const struct can_pwm_const *pwm_const)
> +{
> +	u32 shortest_symbol;
> +
> +	if (pwm_const->pwms_min > pwm_const->pwms_max ||
> +	    pwm_const->pwml_min > pwm_const->pwml_max ||
> +	    pwm_const->pwmo_min > pwm_const->pwmo_max)
> +		return false;
> +
> +	/* can_calc_pwm() divides by the shortest PWM symbol. */
> +	if (check_add_overflow(pwm_const->pwms_min, pwm_const->pwml_min,
> +			       &shortest_symbol) || !shortest_symbol)
> +		return false;

[Severity: High]
This is a pre-existing issue, but this check only covers one of the two
divisors in can_calc_pwm(). Can xl_tqmin % pwm_per_bit still divide by
zero?

drivers/net/can/dev/calc_bittiming.c:can_calc_pwm() {
	u32 xl_tqmin = can_bit_time_tqmin(&priv->xl.data_bittiming);
	u32 xl_ns = can_tqmin_to_ns(xl_tqmin, priv->clock.freq);
    ...
	for (pwm_per_bit = DIV_ROUND_UP(xl_ns, CAN_PWM_NS_MAX);
	     pwm_per_bit <= pwm_per_bit_max; pwm_per_bit++)
		if (xl_tqmin % pwm_per_bit == 0)
			break;
    ...
}

Suppose priv->xl.data_bittiming is all zero while CAN_CTRLMODE_XL_TMS is
set. Then xl_tqmin, xl_ns and pwm_per_bit_max are all 0, and pwm_per_bit
starts at 0. The loop condition 0 <= 0 is true, so the body computes
0 % 0.

That state seems reachable with two requests. can_ctrlmode_changelink()
commits the ctrlmode before the bit timings are computed, and nothing
rolls it back if a later step fails:

1. Send a changelink with IFLA_CAN_CTRLMODE {mask = flags = XL | XL_TMS},
   IFLA_CAN_BITTIMING and IFLA_CAN_XL_DATA_BITTIMING, where the nominal
   or XL timing fails (for example tq = 0 and bitrate = 0). The ctrlmode
   becomes XL | XL_TMS. can_dbt_changelink() returns before it copies the
   XL data bit timing, so the timing stays zero.

2. Send any later changelink without IFLA_CAN_XL_PWM, for example only
   IFLA_CAN_RESTART_MS = 0. It reaches can_pwm_changelink():

	if (!pwm_nla)
		return can_calc_pwm(dev, extack);

dummy_can sets xl.pwm_const and supports XL_TMS, so this can happen on
at least one in-tree device.

xl_ns can also round down to 0 when clock.freq is larger than
2e9 * xl_tqmin. register_candev() does not reject such a clock either.

> +
>  	return true;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261125012332.6945-1-25031212351%40stu.xidian.edu.cn
