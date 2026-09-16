Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC4347988E;
	Wed, 16 Sep 2026 08:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789547747; cv=none; b=cWfLxxzIsvPGLHL6Q/PGQZG46xfadS34o6mmBTt+/QcS11cm3EuAJufwyRs0TebBd8jdrSQ5Rb+jtbl6Gwf7+28z0pAtUBN1qAnZN+EmVYvhSjUWtuBhfrXWjAU2p3DaYaecvJsK4HHoqCAWjRvK7GQug8hrr1wYx9EdP5PLGNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789547747; c=relaxed/simple;
	bh=SKU4+tmBKCX90X/0ylR4SSbXibRSKRHggV4ish8i2kA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Khi93IUC1WmFzt9yzRdHfbD9J4F4ip/WCAY8aZbbY+1Cizx2a5M45NsD/nj2ckbocKEW9JJ0KjCCDKdJMPlnck7r4aBHZHsy2nKLx6dbTxlMeyUn2qiflfM6F6eGaExCBtE9NH0rxA5K7eAkxO0MezpKBVCEnCfPhxPc7PsnoMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLbBjiBV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLbBjiBV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213BB1F000FF;
	Wed, 16 Sep 2026 08:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789547746;
	bh=CayLRKUNsc0TJbrvDf4IDI2pxtN0W0DY6AarkdXTgYw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mLbBjiBVQc1i28n56C7FIQ+V5ktXseCZLUEEkm/RP1wQc+2brjl5hxPErcOG5QKB+
	 QUc0jRUFdFoFFUxNQBzYJ4SvGu8syDasvnPc/X+9j7w4bp3/gVZsc1vOekYojzIc7c
	 4qKltftQoiDU2jdQ4XVJiSbM0FWuYddfei8cnccJEGycSL+qIqqpLPddrzYvHVsOBa
	 H95V7qFodS+TAJjnb0MavbWcc6xDsdSAJcmCMM7E3pkfN5wxeT4QpOHTUKuZmo79fo
	 yVwec4Tn1vmoepv2RaRPtce+qLOGhfqmcPkk9U93q7h8v3yzTaF2EvSvmMqEjwQ8iC
	 50FoJKKszOZxQ==
Subject:
 Re: [PATCH net] net: dsa: microchip: Save the periodic output flags and index
From: netdev-bot+sashiko@kernel.org
To: bastien.curutchet@bootlin.com
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, ceggers@arri.de,
 arun.ramadoss@microchip.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 16 Sep 2026 08:35:44 +0000
Message-ID: <178954774464.22033.13485295141219382399@kernel.org>
In-Reply-To: <20260914-fix-perout-v1-1-9f45531a7585@bootlin.com>
References: <20260914-fix-perout-v1-1-9f45531a7585@bootlin.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 (2) · Low: 2

- [Medium] Incomplete fix: ksz_ptp_enable_perout() now saves
  request->flags into ptp_data->perout_flags, but no companion storage…
- [Low] The commit message states two user-visible symptoms — a non-zero
  pin/index is lost on restart, and "if a flag was set in the request…
- [Low] A failed perout re-configuration corrupts the saved restart
  state.

Pre-existing issues:
- [Medium] The driver advertises caps.n_per_out = 3 and
  ksz_ptp_enable_perout() accepts a second perout enable while tou_mode…
- [Medium] ksz_ptp_enable_perout() calls ptp_find_pin(), which
  include/linux/ptp_clock_kernel.h:393-406 documents as requiring…

--

net: dsa: microchip: Save the periodic output flags and index

The patch stores the perout request's flags and index into struct
ksz_ptp_data when the periodic output is enabled, and replays them from
ksz_ptp_restart_perout() instead of hard-coding index 0 and flags 0.

A few questions on the commit message and the code below.

> net: dsa: microchip: Save the periodic output flags and index
>
> When the periodic output is restarted, the request flags and index are
> always set to 0. So if a pin other than the first one was used, or if a
> flag was set in the request that triggered the periodic output, it is
> lost when the output is restarted.

[Severity: Low]
Is the flags half of this description reachable today?

ksz_ptp_clock_register() sets caps.n_pins, caps.n_per_out, caps.enable and
caps.verify, but never sets caps.supported_perout_flags. The chardev path
then does:

drivers/ptp/ptp_chardev.c:ptp_perout_request() {
	...
	if (perout->flags & ~ops->supported_perout_flags)
		return -EOPNOTSUPP;
	...
}

and the v1 ioctl masks with PTP_PEROUT_V1_VALID_FLAGS (defined as 0), while
ptp_sysfs.c period_store() builds a zero-initialized ptp_clock_request. So
request->flags looks like it is always 0 when ksz_ptp_enable_perout() runs,
which would make the PTP_PEROUT_DUTY_CYCLE handling in the driver dead code
at the moment.

The index half does look like a real user-visible fix, since caps.n_per_out
is 3 and a perout configured on channel 1 or 2 was previously restarted on
TOU/pin index 0. Given the Cc: stable, could the message distinguish which
part fixes an observable problem and which part is future-proofing?

> Save the request's flags and index when the periodic output is
> initialized.
> Use the save flags and index when the periodic output is reset

This isn't a bug, but "Use the save flags" should probably be "Use the
saved flags".

> diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
> index 39cc70d65900b..4f924df9e32bf 100644
> --- a/drivers/net/dsa/microchip/ksz_ptp.c
> +++ b/drivers/net/dsa/microchip/ksz_ptp.c
> @@ -222,6 +222,8 @@ static int ksz_ptp_enable_perout(struct ksz_device *dev,
>  		return 0;
>  	}
>  
> +	ptp_data->perout_flags = request->flags;
> +	ptp_data->perout_index = request->index;

[Severity: Medium]
Does saving flags without saving request->on make the restart path read
uninitialized stack memory?

The only flag ksz_ptp_enable_perout() accepts is PTP_PEROUT_DUTY_CYCLE, and
that flag selects the branch that consumes request->on:

drivers/net/dsa/microchip/ksz_ptp.c:ksz_ptp_enable_perout() {
	...
	if (request->flags & PTP_PEROUT_DUTY_CYCLE) {
		pulse_width_ns = request->on.sec * NSEC_PER_SEC +
			request->on.nsec;
	} else {
	...
}

ksz_ptp_restart_perout() declares "struct ptp_perout_request request;" with
no initializer and assigns only start, period, index and flags, so
request.on (the union member with rsv[4]) stays whatever was on the stack.
Before this patch request.flags was hard-coded to 0 there, so the duty-cycle
branch could not be reached from the restart path.

Either the resulting pulse width fails ksz_ptp_tou_pulse_verify() (-EINVAL
or -ERANGE), in which case ksz_ptp_tou_reset() has already cleared
TRIG_ENABLE and settime()/adjtime() returns an error while tou_mode stays
KSZ_PTP_TOU_PEROUT, or it passes and an arbitrary value is programmed into
REG_TRIG_PULSE_WIDTH__4 by ksz_ptp_configure_perout().

Would it make sense to also save request->on (or the whole validated
request) and to zero-initialize the local request in
ksz_ptp_restart_perout(), so a saved flag and its payload always travel
together?

[Severity: Low]
Should these two assignments happen only after the output has been fully
configured and started?

At this point in ksz_ptp_enable_perout() the cycle-width check,
ksz_ptp_tou_pulse_verify(), ksz_ptp_configure_perout(), ksz_ptp_tou_gpio()
and ksz_ptp_tou_start() can all still fail. A request accepted while
tou_mode is already KSZ_PTP_TOU_PEROUT and then rejected, for example by:

	cycle_width_ns = timespec64_to_ns(&ptp_data->perout_period);
	if ((cycle_width_ns & TRIG_CYCLE_WIDTH_M) != cycle_width_ns)
		return -EINVAL;

leaves the rejected request's index and flags latched in ptp_data. A later
ksz_ptp_settime()/ksz_ptp_adjtime() -> ksz_ptp_restart_perout() would then
re-arm the rejected channel rather than the last one that was successfully
configured. Before the patch that path always re-armed index 0.

>  	ptp_data->perout_target_time_first.tv_sec  = request->start.sec;
>  	ptp_data->perout_target_time_first.tv_nsec = request->start.nsec;
>  
> @@ -795,8 +797,8 @@ static int ksz_ptp_restart_perout(struct ksz_device *dev)
>  	request.start.nsec = next.tv_nsec;
>  	request.period.sec  = ptp_data->perout_period.tv_sec;
>  	request.period.nsec = ptp_data->perout_period.tv_nsec;
> -	request.index = 0;
> -	request.flags = 0;
> +	request.index = ptp_data->perout_index;
> +	request.flags = ptp_data->perout_flags;

[Severity: Medium]
This is a pre-existing issue and not introduced by this patch, but the saved
index now feeds an unlocked pin lookup.

ksz_ptp_enable_perout() calls ptp_find_pin(), whose contract is documented
in include/linux/ptp_clock_kernel.h:

 * The caller must hold ptp_clock::pincfg_mux.  Drivers do not have
 * access to that mutex as ptp_clock is an opaque type.  However, the
 * core code acquires the mutex before invoking the driver's
 * ptp_clock_info::enable() callback

That holds for the ksz_ptp_enable() path only, where ptp_chardev.c wraps the
call:

	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &ptp->pincfg_mux)
		return ops->enable(ops, &req, perout->period.sec || perout->period.nsec);

ksz_ptp_restart_perout() reaches ptp_find_pin() from
ksz_ptp_settime()/ksz_ptp_adjtime() holding only ptp_data->lock, so
info->pin_config[] is walked while PTP_PIN_SETFUNC (ptp_set_pinfunc()) can
be rewriting func/chan under pincfg_mux. That can yield a wrong index in
PTP_GPIO_INDEX, or -1 and a spurious -EINVAL from settime()/adjtime().

Note that switching to ptp_find_pin_unlocked() here would invert the lock
order established by the enable() path (pincfg_mux -> ptp_data->lock via
ptp_set_pinfunc() -> ptp_disable_pinfunc() -> info->enable()). Would caching
the resolved pin at enable() time, alongside the flags and index this patch
already caches, be an option?

>  
>  	return ksz_ptp_enable_perout(dev, &request, 1);
>  }
> diff --git a/drivers/net/dsa/microchip/ksz_ptp.h b/drivers/net/dsa/microchip/ksz_ptp.h
> index 7067ec9bd1e6f..da6a2efb23d72 100644
> --- a/drivers/net/dsa/microchip/ksz_ptp.h
> +++ b/drivers/net/dsa/microchip/ksz_ptp.h
> @@ -31,6 +31,8 @@ struct ksz_ptp_data {
>  	enum ksz_ptp_tou_mode tou_mode;
>  	struct timespec64 perout_target_time_first;  /* start of first pulse */
>  	struct timespec64 perout_period;
> +	unsigned int perout_flags;
> +	unsigned int perout_index;
>  };

[Severity: Medium]
This is a pre-existing limitation rather than something the patch
introduces, but does the new index only work for a single active channel?

caps.n_per_out is 3, and ksz_ptp_enable_perout() accepts a second enable
while a perout is already running:

	if (ptp_data->tou_mode != KSZ_PTP_TOU_PEROUT &&
	    ptp_data->tou_mode != KSZ_PTP_TOU_IDLE)
		return -EBUSY;

All perout bookkeeping is single-slot (perout_target_time_first,
perout_period, and now perout_index/perout_flags), and
ksz_ptp_restart_perout() replays exactly one request. Configuring perout on
channels 0 and 1 therefore overwrites the saved state, and after a clock
step only the most recently configured channel is re-armed; the other
trigger unit keeps a target time in the old clock epoch.

Would it be worth mentioning this scope in the commit message?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914-fix-perout-v1-1-9f45531a7585%40bootlin.com
