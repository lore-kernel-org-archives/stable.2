Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FBE13C908
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648938; cv=none; b=K27BfRzTppLLiXn9fWI9q86iPkX5LftRb2Gm+NjYJxZg3EkmS16kyNCII35c6PRG8CRa049CDAR7JniUSyTulYW6hxc4qvTFLs8JSiaInJBIWqncyIMg4C+2kbpX+3i3rWiR9sJhjNWI2J7ObR0brG0u19Ds8W/8PCKj7CW/nHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648938; c=relaxed/simple;
	bh=kFg28HSMVsNaPko3lndHm99sINSZDjID7G7sHUDYUjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhD6bzr+YaUOhX2j9KRaHEDwvfmCZTE2X7QTeWiXd9xUcJOWFej4lplcq808Tv+VqQ1lOSeJkznxyHbNttHGuLOOj3VW+aQJSF6swz+K7lecS4rhWM+Nokm7BlM1s3nn2MQzRmbPJrf+jFTDwMfIO9u7M47mgEXn7ZMbMvo8WZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XNsnx646; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNsnx646"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789648927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nIZjNmT37L6e0UXYttiyted0pKwzPAUWzzEiduxiea4=;
	b=XNsnx646LPGfXJBraFlELCsiJcYWJnFagPITZcVesVD39fJSsKxY1qZTcBRst+cjDl3pFo
	W/oJkHEYwMQoMERFCHQ5+sUvyCPp4SWIvqLJcY1LlnSIJPXZ/qXKuxzwORDvcyixjD5yAC
	ONaLHbLQ8njyhq8JmLXG1lZrSV9JMiU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-via1Qod6McKNGDtd9NrGAQ-1; Thu,
 17 Sep 2026 08:42:02 -0400
X-MC-Unique: via1Qod6McKNGDtd9NrGAQ-1
X-Mimecast-MFC-AGG-ID: via1Qod6McKNGDtd9NrGAQ_1789648919
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 033091978C9D;
	Thu, 17 Sep 2026 12:41:39 +0000 (UTC)
Received: from pabeni-thinkpadp1gen8.rmtit.csb (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 60BAF1944CD1;
	Thu, 17 Sep 2026 12:41:33 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: bastien.curutchet@bootlin.com
Cc: woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	ceggers@arri.de,
	arun.ramadoss@microchip.com,
	pascal.eberhard@se.com,
	miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: microchip: Save the periodic output flags and index
Date: Thu, 17 Sep 2026 14:41:07 +0200
Message-ID: <20260917124107.213222-1-pabeni@redhat.com>
In-Reply-To: <20260914-fix-perout-v1-1-9f45531a7585@bootlin.com>
References: <20260914-fix-perout-v1-1-9f45531a7585@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
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
This is an AI-generated review.

