Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853556;
	b=joqn540e+MvicVzse+frx4EdXIfrBqpjmdUKQ8O3YvaFe5ivW9KakYbOl11PeBy3bX0n
	 CPvNMCI8NuVP7AVfgeXAVpDdzsmclOQ9Ns0wgwmscXBYV7y616xkSqfYwEM5UE98wE7jF
	 5GOTRT1/hd9J4L/HNr13PlkUC9xHdkUflsgruqlkS1lXQJb3N7KUDpEd1XHvFoZvI6Lf7
	 aKFYN3jg+OakdE9OiOEhyVAF9bIjs48lOJXW+gqqpO/Cu8kdiGnEs1Nr5GdpD6VyWzH0y
	 V5WOSFkWXXICYUPaB80XV/CvjrdlgoBeh7WVNgio9h6tsvXvYy+1I3PmUZ2D6ssP9MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853556;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2k2NEly1JslwutfN2kmamMP4TPSeSDUKck630Kcz9aM=;
	b=LO/BqomOEPeldVUgTZMnR8iD729cQW9eg48EuwArnkryTAFrbbZnquc8ac+OcrwIMmpP
	 8ShQETUHxg7nf/hveIEn8DD+2HOyjTiYplCne6UIqyjcKwgXcS0Zs0u7f4c3oUEeVZFzD
	 /0DgUVsb85/2D6hQg7ISyehlJW0jO93gr8CO2j6sKtjjcO/tX+7p+T3fLQ3B1qaEQBoKH
	 poxCxIyveQlRtm93NzmnuUUTxQ349Ibbpgnm2Lxu0EJxhzwxb2UztSUtzdSkYkNyF1Plv
	 ud9xdyTnHA0AoTl1TZ92kG3KV8/dH4ZLBnJdvtbUsV/0m49ThwF0sLOKaJA4XFmxKBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hIlInLX0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C556606A31C;
	Mon, 16 Nov 2026 18:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hIlInLX0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450671F000C4;
	Mon, 16 Nov 2026 18:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794853555;
	bh=2k2NEly1JslwutfN2kmamMP4TPSeSDUKck630Kcz9aM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hIlInLX0k4w7S9z9er1Q+mK2xoyvxq3xh+z63yVdJBnNG1U7r51BKt1DyyHsOsN0w
	 RP8jV9+5ZAmahdrePt1/3Fw0FSSqn0IBhBwctzCVpF103eFLuQwKqdqaAjiGS0ch19
	 SNJpB+sZgd+hzNoOlCS6wbYEZz1qkbUBtbKY5/2qh84NMplyZPHvuh1raEQ9ESeFiZ
	 bKh+WRf9x/Ya98gQj2KbEnNNcAowoEc868bUukPvDhhi16J+nsVPMwo5rV4DOa3CG7
	 umXc4/9dXU1ezRRtaQZLBXRbuJTxTKZanti9GZe9i2zyHSy9mHe2uqPMv+6dIxK+Og
	 bWhd6VF0CntMw==
Date: Mon, 16 Nov 2026 18:25:52 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, philip.radford@arm.com,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Chengyu Liu <lui2012qwq@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] firmware: arm_scmi: Fix deadlock between reboot
 notifier and forceful work
Message-ID: <20261116-astonishing-urchin-from-jupiter-838cfc@sudeepholla>
References: <20261116084211.3066460-1-cristian.marussi@arm.com>
 <20261116084211.3066460-2-cristian.marussi@arm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116084211.3066460-2-cristian.marussi@arm.com>

On Mon, Nov 16, 2026 at 08:42:10AM +0000, Cristian Marussi wrote:
> From: Chengyu Liu <lui2012qwq@gmail.com>
> 
> scmi_reboot_notifier() calls cancel_delayed_work_sync() while holding
> sc->state_mtx, but the work it waits on - scmi_forceful_work_func() -
> takes the same mutex.  If a forceful transition work is in flight when
> the reboot notifier fires, the notifier holds the lock and waits for
> the callback while the callback waits for the lock: deadlock, and the
> reboot wedges.
> 
> Moving the cancel outside the lock is not sufficient on its own, as the
> callback also calls unregister_reboot_notifier() unconditionally, which
> blocks on the reboot chain rwsem (down_write vs. the in-progress
> chain's down_read) while the notifier waits for the callback - the
> deadlock would just move to a different lock.  Fix both sides:
> 
> - Notifier: compute the decision under state_mtx, drop the lock, then
>   cancel.  A callback that slips in between sees state ==
>   SCMI_SYSPOWER_REBOOTING (not IN_PROGRESS), skips the forceful
>   request and finishes, so the cancel cannot miss it.  (The callback's
>   own system_state early-return does not cover a work item that
>   started before the reboot began: kernel_restart_prepare() runs the
>   notifier chain before setting system_state.)
> 
> - Callback: only unregister the reboot notifier when actually forcing
>   the transition - that is the only case that needs it, because the
>   forceful kernel_restart()/kernel_power_off() would otherwise
>   re-enter scmi_reboot_notifier and self-deadlock on state_mtx.  When
>   the state is not IN_PROGRESS there is nothing to force, and skipping
>   the unregister keeps the callback from blocking on the reboot chain
>   rwsem while the notifier waits for it.
> 
> Found by static analysis.
> 
> Cc: stable@vger.kernel.org
> Fixes: 2c4b97fee94a ("firmware: arm_scmi: Add SCMI System Power Control driver")
> Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
> [Cristian: drop lock before triggering forceful reboot (needs_forceful)]
> Tested-by: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  .../firmware/arm_scmi/scmi_power_control.c    | 26 ++++++++++++++-----
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/scmi_power_control.c b/drivers/firmware/arm_scmi/scmi_power_control.c
> index e791a206768c..e0680e33180e 100644
> --- a/drivers/firmware/arm_scmi/scmi_power_control.c
> +++ b/drivers/firmware/arm_scmi/scmi_power_control.c
> @@ -121,6 +121,7 @@ static int scmi_reboot_notifier(struct notifier_block *nb,
>  				unsigned long reason, void *__unused)
>  {
>  	struct scmi_syspower_conf *sc = reboot_nb_to_sconf(nb);
> +	bool cancel_work;
>  
>  	mutex_lock(&sc->state_mtx);
>  	switch (reason) {
> @@ -138,11 +139,18 @@ static int scmi_reboot_notifier(struct notifier_block *nb,
>  		break;
>  	}
>  
> -	if (sc->state == SCMI_SYSPOWER_REBOOTING) {
> +	cancel_work = sc->state == SCMI_SYSPOWER_REBOOTING;
> +	mutex_unlock(&sc->state_mtx);
> +
> +	if (cancel_work) {
>  		dev_dbg(sc->dev, "Reboot in progress...cancel delayed work.\n");
> +		/*
> +		 * cancel_delayed_work_sync() waits for a running
> +		 * scmi_forceful_work_func(), which takes state_mtx - it must
> +		 * not be called with the lock held.
> +		 */
>  		cancel_delayed_work_sync(&sc->forceful_work);

Sashiko still complains about the deadlock.

How about changing this to non-sync cancel_delayed_work() so that it doesn't
wait and deadlock like it complains ?

>  	}
> -	mutex_unlock(&sc->state_mtx);
>  
>  	return NOTIFY_OK;
>  }
> @@ -181,6 +189,7 @@ static void scmi_forceful_work_func(struct work_struct *work)
>  {
>  	struct scmi_syspower_conf *sc;
>  	struct delayed_work *dwork;
> +	bool needs_forceful;
>  
>  	if (system_state > SYSTEM_RUNNING)
>  		return;
> @@ -188,13 +197,16 @@ static void scmi_forceful_work_func(struct work_struct *work)
>  	dwork = to_delayed_work(work);
>  	sc = dwork_to_sconf(dwork);
>  
> -	dev_dbg(sc->dev, "Graceful request timed out...forcing !\n");
>  	mutex_lock(&sc->state_mtx);
> -	/* avoid deadlock by unregistering reboot notifier first */
> -	unregister_reboot_notifier(&sc->reboot_nb);
> -	if (sc->state == SCMI_SYSPOWER_IN_PROGRESS)
> -		scmi_request_forceful_transition(sc);
> +	needs_forceful = sc->state == SCMI_SYSPOWER_IN_PROGRESS;
>  	mutex_unlock(&sc->state_mtx);
> +
> +	if (needs_forceful) {
> +		dev_dbg(sc->dev, "Graceful request timed out...forcing !\n");
> +		/* avoid deadlock by unregistering reboot notifier first */
> +		unregister_reboot_notifier(&sc->reboot_nb);

And re-evaluate needs_forceful again here after un-registration before
calling below forced transition ?

-- 
Regards,
Sudeep
