Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3881B457E77;
	Mon, 21 Sep 2026 08:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980781; cv=none; b=n31Lz33znW4fCZ8myWmQotK3suCE4D+ellcgAdMJfmQ0t9DR6nkrGaVQxPxn7jW4SrEtIGtL4B0KNabcJnE7cGzQMIUIHlqoFz2K6ehE7BwTPPcdFXrHfdrgRX6uS4A2j/Tuq78V85oA7IMg5FsSTOCMvJv1S9LMaD5hNXnmZtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980781; c=relaxed/simple;
	bh=VWumyYdINZ/5KEtt1ktWYZmwhZezwWep+jwyVTffUa4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aXV1Lev8fJ4/cvl+VW4fNNY4IdgmLXiuzwXOr0YpqSoGVypVebPboly13di7q5/ADAy3s0YLi1SdwQ25fj408OZKkN9DKu1Jm+zRaROAhMXBtnLFoq4JdLmuqLEBKWXHSqM67Tod7kyEVQgRbKFNWlhrcWYUew26uJJgC9/y0sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxZtBxn5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxZtBxn5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1BA1F000FF;
	Mon, 21 Sep 2026 08:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789980779;
	bh=+afw/DGe4bk0PkJPWYl7XReefJSYXvqWnF8WgUxerYU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VxZtBxn5A1IytykXf1Ev9IOOhXFCkEiYgkLKhfewdDgL7E0JUmKN93m1XcS4kfQdV
	 PJg2spE97pdnPzV671RypxPOsSZoSAhe5lLvL5Ha9QtHg+RqANDaRY7+bhkOA4xb75
	 hRsYsZjNYdhaSkyLpBEez9Y2OKv/ib3lhDKz7o0e0sGGHFDA/wqmm9q6Frwkxd2HXP
	 sY924Q0d9DAC+qIj6vpTbGHJvMALj6PzD93abbgHyTECbQmA/1MPqXxJWR+z/5NpTM
	 FiUakB+bEZ7zMtPMRWu+sFNNa23o8FuWi344i79qXcX/TEkdU9704RxYS4Wud0BtUi
	 0c7PJhFaaKlMg==
Subject:
 Re: [PATCH net v2] net: dsa: microchip: save the periodic output request
From: netdev-bot+sashiko@kernel.org
To: bastien.curutchet@bootlin.com
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, ceggers@arri.de,
 arun.ramadoss@microchip.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 21 Sep 2026 08:52:58 +0000
Message-ID: <178998077822.2160803.3867886756893254872@kernel.org>
In-Reply-To: <20260917-fix-perout-v2-1-d8acf3eea6f7@bootlin.com>
References: <20260917-fix-perout-v2-1-d8acf3eea6f7@bootlin.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 (2) · Medium: 1 (2) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] ksz_ptp_enable_perout()
  (drivers/net/dsa/microchip/ksz_ptp.c:226) commits the caller-supplied…
- [Medium] The commit message states that 'if a flag was set in the
  request that triggered the periodic output, it is lost when the output…

Pre-existing issues:
- [High] A non-canonical but ABI-accepted period whose timespec64
  conversion is zero (e.g. period.sec = -1, period.nsec = 1000000000;…
- [High] In ksz_ptp_restart_perout()
  (drivers/net/dsa/microchip/ksz_ptp.c) the elapsed-period quotient is…
- [Medium] The device exposes three trigger output units (caps.n_per_out
  = 3 at drivers/net/dsa/microchip/ksz_ptp.c:1056, PTP_TOU_INDEX =…
- [Medium] ksz_ptp_enable_perout() resolves the output pin with
  ptp_find_pin() (drivers/net/dsa/microchip/ksz_ptp.c:206).
- [Low] ksz_ptp_tou_reset() (drivers/net/dsa/microchip/ksz_ptp.c:66-86)
  assigns the result of the TRIG_RESET read-modify-write to 'ret' at…

--

net: dsa: microchip: save the periodic output request

The patch replaces the two stored timespec64 values (perout_target_time_first
and perout_period) in struct ksz_ptp_data with a copy of the full
ptp_perout_request, so that the index and flags survive a perout restart.
ksz_ptp_restart_perout() now replays the saved request with only the start
time recomputed.

A few questions below.

>     When a periodic output is initialized, only the start and the period are
>     stored, not the flags nor the pin index. So when the periodic output is
>     restarted, the request flags and index are always set to 0. So if a pin
>     other than the first one was used, or if a flag was set in the request
>     that triggered the periodic output, it is lost when the output is
>     restarted.

[Severity: Medium]
Can request->flags ever be non-zero in this driver?

ksz_ptp_clock_register() sets caps.n_pins, caps.n_per_out and the callbacks,
but never sets caps.supported_perout_flags, and caps lives in the zeroed
struct ksz_device, so the mask stays 0. The core rejects any flag that is not
advertised before it calls the driver:

drivers/ptp/ptp_chardev.c:ptp_perout_request() {
	...
	if (perout->flags & ~ops->supported_perout_flags)
		return -EOPNOTSUPP;
	...
	return ops->enable(ops, &req, perout->period.sec || perout->period.nsec);
}

That would make the "if (request->flags & ~PTP_PEROUT_DUTY_CYCLE)" check in
ksz_ptp_enable_perout() unable to fire, the PTP_PEROUT_DUTY_CYCLE pulse-width
branch unreachable, and the newly saved flags/on fields dead state.

The user visible effect looks like the opposite of the description: the driver
implements PTP_PEROUT_DUTY_CYCLE but the core answers -EOPNOTSUPP, so such an
output can never be created. Would setting caps.supported_perout_flags =
PTP_PEROUT_DUTY_CYCLE be needed, and should the flags part of the changelog be
dropped until then? The index part of the description does hold, since
ksz_ptp_verify_pin() accepts PTP_PF_PEROUT on any pin for any channel.

> diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
> index 39cc70d65900b..0979b6e04d1e9 100644
> --- a/drivers/net/dsa/microchip/ksz_ptp.c
> +++ b/drivers/net/dsa/microchip/ksz_ptp.c

[ ... ]

> @@ -222,13 +223,11 @@ static int ksz_ptp_enable_perout(struct ksz_device *dev,
>  		return 0;
>  	}
>  
> -	ptp_data->perout_target_time_first.tv_sec  = request->start.sec;
> -	ptp_data->perout_target_time_first.tv_nsec = request->start.nsec;
> +	memcpy(&ptp_data->perout_request, request, sizeof(struct ptp_perout_request));
>  
> -	ptp_data->perout_period.tv_sec = request->period.sec;
> -	ptp_data->perout_period.tv_nsec = request->period.nsec;
> -
> -	cycle_width_ns = timespec64_to_ns(&ptp_data->perout_period);
> +	tmp.tv_sec = ptp_data->perout_request.period.sec;
> +	tmp.tv_nsec = ptp_data->perout_request.period.nsec;
> +	cycle_width_ns = timespec64_to_ns(&tmp);
>  	if ((cycle_width_ns & TRIG_CYCLE_WIDTH_M) != cycle_width_ns)
>  		return -EINVAL;

[Severity: High]
Should the request be committed to ptp_data->perout_request only after it has
been validated and the hardware has actually been programmed?

After the memcpy, ksz_ptp_enable_perout() can still fail at the cycle-width
mask check just below, at ksz_ptp_tou_pulse_verify(), and at every register
access in ksz_ptp_configure_perout(), ksz_ptp_tou_gpio() and
ksz_ptp_tou_start(). None of those returns restores the previous saved
request, and ptp_data->tou_mode is not rolled back either - it is cleared only
on the !on path and set to KSZ_PTP_TOU_PEROUT only on full success.

The entry guard in the same function accepts a new request while an output is
already running:

	if (ptp_data->tou_mode != KSZ_PTP_TOU_PEROUT &&
	    ptp_data->tou_mode != KSZ_PTP_TOU_IDLE)
		return -EBUSY;

So for a second PTP_PEROUT_REQUEST that gets rejected after the memcpy,
tou_mode stays KSZ_PTP_TOU_PEROUT and ksz_ptp_settime()/ksz_ptp_adjtime() then
enter ksz_ptp_restart_perout() with a request that was never programmed. Since
index and flags are now persisted too, can this re-arm a different trigger
unit and GPIO than the one actually running, and keep settime()/adjtime()
failing with the same error?

There is also a period that this check rejects but the memcpy has already
stored: period.sec = 4, period.nsec = 294967296 gives 0x100000000 ns, and
TRIG_CYCLE_WIDTH_M is GENMASK(31, 0), so the request returns -EINVAL. On the
next clock step, ksz_ptp_restart_perout() feeds that value to
div_u64(now_ns - first_ns, period_ns), whose divisor parameter is u32, so the
divisor truncates to 0. Is that a divide error in process context with
ptp_data->lock held?

[Severity: Low]
This isn't a bug introduced by this patch, but the ksz_ptp_tou_reset() call
that runs just above this hunk discards the result of the TRIG_RESET write:

drivers/net/dsa/microchip/ksz_ptp.c:ksz_ptp_tou_reset() {
	/* Reset trigger unit (clears TRIGGER_EN, but not GPIOSTATx) */
	ret = ksz_rmw32(dev, REG_PTP_CTRL_STAT__4, TRIG_RESET, TRIG_RESET);

	data = FIELD_PREP(TRIG_DONE_M, BIT(unit));
	ret = ksz_write32(dev, REG_PTP_TRIG_STATUS__4, data);
	if (ret)
		return ret;

ret is overwritten before it is tested, so a failed bus transaction looks like
a successful reset and both the enable and the restart flow go on to
reprogram REG_TRIG_CTRL__4, the cycle/pulse widths and the target time of a
trigger unit whose TRIG_ENABLE was never cleared. Should the first return
value be checked?

> @@ -763,6 +763,7 @@ static int ksz_ptp_restart_perout(struct ksz_device *dev)
>  	struct ptp_perout_request request;
>  	struct timespec64 next;
>  	struct timespec64 now;
> +	struct timespec64 tmp;
>  	unsigned int count;
      ^^^^^^^^^^^^^^^^^^

[Severity: High]
This is a pre-existing issue, but count is 32-bit while div_u64() returns u64,
and the patched code still depends on it. Can the quotient wrap here?

	count = div_u64(now_ns - first_ns, period_ns);
	next_ns = first_ns + count * period_ns;
	...
	while (next_ns < now_ns + 100000000)
		next_ns += period_ns;

The RTC starts at 0 (see ksz_ptp_start_clock()), so enabling a 1 ms output
shortly after probe and then stepping the clock to wall-clock time gives
now_ns - first_ns of roughly 1.7e18 ns and a true quotient of about 1.7e12.
After truncation to 32 bits, next_ns stays far behind now_ns and the guard
loop has to advance one period at a time, on the order of 1e12 iterations,
with ptp_data->lock held by ksz_ptp_settime()/ksz_ptp_adjtime(). Would
declaring count as u64 be enough here?

> @@ -773,10 +774,14 @@ static int ksz_ptp_restart_perout(struct ksz_device *dev)
>  		return ret;
>  
>  	now_ns = timespec64_to_ns(&now);
> -	first_ns = timespec64_to_ns(&ptp_data->perout_target_time_first);
> +	tmp.tv_sec = ptp_data->perout_request.start.sec;
> +	tmp.tv_nsec = ptp_data->perout_request.start.nsec;
> +	first_ns = timespec64_to_ns(&tmp);
>  
>  	/* Calculate next perout event based on start time and period */
> -	period_ns = timespec64_to_ns(&ptp_data->perout_period);
> +	tmp.tv_sec = ptp_data->perout_request.period.sec;
> +	tmp.tv_nsec = ptp_data->perout_request.period.nsec;
> +	period_ns = timespec64_to_ns(&tmp);
>  
>  	if (first_ns < now_ns) {
>  		count = div_u64(now_ns - first_ns, period_ns);

[Severity: High]
This is a pre-existing issue as well, since the old code stored
ptp_data->perout_period before the same validation, but can period_ns be 0
here?

struct ptp_clock_time has __s64 sec and __u32 nsec and the core does not
normalize them, so a request with period.sec = -1 and period.nsec =
1000000000 arrives with on == 1 because ptp_perout_request() uses the raw
fields:

	return ops->enable(ops, &req, perout->period.sec || perout->period.nsec);

timespec64_to_ns() of {-1, 1000000000} is 0, which passes the cycle-width mask
check in ksz_ptp_enable_perout(), and the derived default pulse width is 0,
which ksz_ptp_tou_pulse_verify() accepts (0 & 3 is 0 and FIELD_FIT() of 0 is
true). The zero period is stored either way.

On the next clock_settime()/clock_adjtime(), does div_u64(now_ns - first_ns, 0)
Oops, or, when first_ns >= now_ns, does this loop never terminate:

	while (next_ns < now_ns + 100000000)
		next_ns += period_ns;

Both happen with ptp_data->lock held. Would a positive-period check in
ksz_ptp_enable_perout() before the request is stored close this?

> @@ -791,12 +796,9 @@ static int ksz_ptp_restart_perout(struct ksz_device *dev)
>  
>  	/* Restart periodic output signal */
>  	next = ns_to_timespec64(next_ns);
> +	memcpy(&request, &ptp_data->perout_request, sizeof(struct ptp_perout_request));
>  	request.start.sec  = next.tv_sec;
>  	request.start.nsec = next.tv_nsec;
> -	request.period.sec  = ptp_data->perout_period.tv_sec;
> -	request.period.nsec = ptp_data->perout_period.tv_nsec;
> -	request.index = 0;
> -	request.flags = 0;
>  
>  	return ksz_ptp_enable_perout(dev, &request, 1);
>  }

[Severity: Medium]
This isn't a bug introduced by this patch either, since the restart path
already called into ksz_ptp_enable_perout() with a hardcoded index, but the
saved index is now the lookup key for a pin lookup made without pincfg_mux.

ksz_ptp_enable_perout() resolves the pin with:

	pin = ptp_find_pin(ptp_data->clock, PTP_PF_PEROUT, request->index);
	if (pin < 0)
		return -EINVAL;

and include/linux/ptp_clock_kernel.h documents for ptp_find_pin():

 * The caller must hold ptp_clock::pincfg_mux.

The core only provides that for the .enable() callback, which
ptp_perout_request() wraps in the pincfg_mux guard. Coming in through
ksz_ptp_settime()/ksz_ptp_adjtime() -> ksz_ptp_restart_perout() only
ptp_data->lock is held, while ptp_set_pinfunc() updates pin->func and
pin->chan with plain stores under pincfg_mux alone. Can a concurrent
PTP_PIN_SETFUNC make this lookup return the wrong pin index, or -1, in which
case the -EINVAL return leaves the trigger unit already reset, the output
stopped and tou_mode still KSZ_PTP_TOU_PEROUT?

Note that taking pincfg_mux here would invert the .enable() order of
pincfg_mux -> ptp_data->lock; caching the pin index resolved inside .enable()
and reusing it on restart avoids that.

> diff --git a/drivers/net/dsa/microchip/ksz_ptp.h b/drivers/net/dsa/microchip/ksz_ptp.h
> index 7067ec9bd1e6f..eb3827203b962 100644
> --- a/drivers/net/dsa/microchip/ksz_ptp.h
> +++ b/drivers/net/dsa/microchip/ksz_ptp.h
> @@ -29,8 +29,7 @@ struct ksz_ptp_data {
>  	spinlock_t clock_lock;
>  	struct timespec64 clock_time;
>  	enum ksz_ptp_tou_mode tou_mode;
> -	struct timespec64 perout_target_time_first;  /* start of first pulse */
> -	struct timespec64 perout_period;
> +	struct ptp_perout_request perout_request;
>  };

[Severity: Medium]
This is a pre-existing limitation rather than something the patch introduces,
but now that the index is part of the saved state it becomes more visible: one
tou_mode and one perout_request describe up to three trigger units
(caps.n_per_out = 3, PTP_TOU_INDEX is GENMASK(1, 0)) and two pins, and
ksz_ptp_verify_pin() accepts PTP_PF_PEROUT on any pin for any channel.

Since the guard in ksz_ptp_enable_perout() lets a request through while
tou_mode == KSZ_PTP_TOU_PEROUT, the memcpy there overwrites the record of the
first channel while its unit stays armed. A later clock step invalidates the
absolute TRIG_TARGET_SEC/NANOSEC of every armed unit, but
ksz_ptp_restart_perout() re-arms only the single saved index, so the other
output keeps a target time in the past. Disabling any channel also sets
tou_mode = KSZ_PTP_TOU_IDLE while another unit is still armed. Would it be
worth mentioning this single-slot limitation in the changelog, or tracking
state per channel?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917-fix-perout-v2-1-d8acf3eea6f7%40bootlin.com
