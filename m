Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914733;
	b=NuO8IEHimlPEUAf+1fmCWjw3uIKUDaE0Ko0/NyYGIIF7hVeMbGKdy1q2xhM3cycMc8Wj
	 VRfXgk5L/aa2CacAe64J1RNAUslo6CMWJ9SOjJ4QIeiDPjFJEdAh9NDSRm2VHX9+/+lWd
	 IDCGTy86+rS5aF8YH4f0t6c99/XEnRnX2tsaPurX86QitE5KqThpi+sZPxMpvAYbkojlr
	 ftHIWciw/wWfn2iOU7nuhi+Rw6SLUoAGNjdvB9emmIc4aq8IkTX8Wyc3kuC4Hi193bkSb
	 VqmVwxrfQ9oCMEhMk/ztrfRJIt+j13VmtyjebB9jvT1FWmfpNv8NqL1k6NYHwQSiFNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914733;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=EjKtFJmbELwLxN/SkX96ZRarriuHbmHuTOFtDaMQmWI=;
	b=vc7+GjM4TPpDfqh51AXZMkbG/0fFJ490Ri5xPlmKdmBrIIwr5t8mMBTPgCOepE6yFv74
	 3ILtSqlA8rVkarY6A3zSQV3Ipqco1W+qSmuf46ULMOQEPt5q341nmr0AXLTliEmEQu/Li
	 UNyCBn5EV3tTNKPK/oL5pQSkbxd3c/rbuzWvOwTbbKHB79BV+IVYAGDCDbbcvprZKv341
	 udwEQKIO9ZwaF6BLj7eYjcAMlBknTibWBl+Dw+LTnulGEhjDIrRqd7nvn5yqYdnZkxQ8v
	 TpD76FPHuU/tRGASTh5yqgBNR5VjUKLZWvE0cYwszn9+voBWcpkWzpAHZ89SY/fWAcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="Yh0K/+MF";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0D9606A31C;
	Tue, 17 Nov 2026 11:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B0D9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Yh0K/+MF
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9E751476;
	Tue, 17 Nov 2026 03:25:28 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC5353F763;
	Tue, 17 Nov 2026 03:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914731; bh=tsiBf/59DLImedYvMeJnfBpkP0avVT+CnBoreYFhOPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yh0K/+MFNRFDcpjhbH82LlRvl8CDwEEwkAyIdCSxF/8JFqZfRt/a+Y5/fonHTre6z
	 k2ymSKZ2F0YsUTmdHu+F/B94sY0jucBPXi0KY4XmmqpXKdALi+O7aKmKB/T97NvlHd
	 cLuQv/+0tf4SF5AAqIY3HRg7XUO7xuLEOw0nhrRQ=
Date: Tue, 17 Nov 2026 11:25:23 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, philip.radford@arm.com,
	Chengyu Liu <lui2012qwq@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] firmware: arm_scmi: Fix deadlock between reboot
 notifier and forceful work
Message-ID: <avw5o7sTyriZ2ZiX@pluto>
References: <20261116084211.3066460-1-cristian.marussi@arm.com>
 <20261116084211.3066460-2-cristian.marussi@arm.com>
 <20261116-astonishing-urchin-from-jupiter-838cfc@sudeepholla>
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
In-Reply-To: <20261116-astonishing-urchin-from-jupiter-838cfc@sudeepholla>

On Mon, Nov 16, 2026 at 06:25:52PM +0000, Sudeep Holla wrote:
> On Mon, Nov 16, 2026 at 08:42:10AM +0000, Cristian Marussi wrote:
> > From: Chengyu Liu <lui2012qwq@gmail.com>

Hi Sudeep,

> > 
> > scmi_reboot_notifier() calls cancel_delayed_work_sync() while holding
> > sc->state_mtx, but the work it waits on - scmi_forceful_work_func() -
> > takes the same mutex.  If a forceful transition work is in flight when
> > the reboot notifier fires, the notifier holds the lock and waits for
> > the callback while the callback waits for the lock: deadlock, and the
> > reboot wedges.
> > 
> > Moving the cancel outside the lock is not sufficient on its own, as the
> > callback also calls unregister_reboot_notifier() unconditionally, which
> > blocks on the reboot chain rwsem (down_write vs. the in-progress
> > chain's down_read) while the notifier waits for the callback - the
> > deadlock would just move to a different lock.  Fix both sides:
> > 
> > - Notifier: compute the decision under state_mtx, drop the lock, then
> >   cancel.  A callback that slips in between sees state ==
> >   SCMI_SYSPOWER_REBOOTING (not IN_PROGRESS), skips the forceful
> >   request and finishes, so the cancel cannot miss it.  (The callback's
> >   own system_state early-return does not cover a work item that
> >   started before the reboot began: kernel_restart_prepare() runs the
> >   notifier chain before setting system_state.)
> > 
> > - Callback: only unregister the reboot notifier when actually forcing
> >   the transition - that is the only case that needs it, because the
> >   forceful kernel_restart()/kernel_power_off() would otherwise
> >   re-enter scmi_reboot_notifier and self-deadlock on state_mtx.  When
> >   the state is not IN_PROGRESS there is nothing to force, and skipping
> >   the unregister keeps the callback from blocking on the reboot chain
> >   rwsem while the notifier waits for it.
> > 
> > Found by static analysis.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 2c4b97fee94a ("firmware: arm_scmi: Add SCMI System Power Control driver")
> > Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
> > [Cristian: drop lock before triggering forceful reboot (needs_forceful)]
> > Tested-by: Cristian Marussi <cristian.marussi@arm.com>
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  .../firmware/arm_scmi/scmi_power_control.c    | 26 ++++++++++++++-----
> >  1 file changed, 19 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/scmi_power_control.c b/drivers/firmware/arm_scmi/scmi_power_control.c
> > index e791a206768c..e0680e33180e 100644
> > --- a/drivers/firmware/arm_scmi/scmi_power_control.c
> > +++ b/drivers/firmware/arm_scmi/scmi_power_control.c
> > @@ -121,6 +121,7 @@ static int scmi_reboot_notifier(struct notifier_block *nb,
> >  				unsigned long reason, void *__unused)
> >  {
> >  	struct scmi_syspower_conf *sc = reboot_nb_to_sconf(nb);
> > +	bool cancel_work;
> >  
> >  	mutex_lock(&sc->state_mtx);
> >  	switch (reason) {
> > @@ -138,11 +139,18 @@ static int scmi_reboot_notifier(struct notifier_block *nb,
> >  		break;
> >  	}
> >  
> > -	if (sc->state == SCMI_SYSPOWER_REBOOTING) {
> > +	cancel_work = sc->state == SCMI_SYSPOWER_REBOOTING;
> > +	mutex_unlock(&sc->state_mtx);
> > +
> > +	if (cancel_work) {
> >  		dev_dbg(sc->dev, "Reboot in progress...cancel delayed work.\n");
> > +		/*
> > +		 * cancel_delayed_work_sync() waits for a running
> > +		 * scmi_forceful_work_func(), which takes state_mtx - it must
> > +		 * not be called with the lock held.
> > +		 */
> >  		cancel_delayed_work_sync(&sc->forceful_work);
> 
> Sashiko still complains about the deadlock.
> 

Yes I know.

> How about changing this to non-sync cancel_delayed_work() so that it doesn't
> wait and deadlock like it complains ?
> 

Indeed I think this is just the solution...I mean dropping this patch as
a whole and keeping the original wider locking section BUT do not cancel 
synchronously, but simply with cancel_delayed_work(&sc->forceful_work);

> >  	}
> > -	mutex_unlock(&sc->state_mtx);
> >  
> >  	return NOTIFY_OK;
> >  }
> > @@ -181,6 +189,7 @@ static void scmi_forceful_work_func(struct work_struct *work)
> >  {
> >  	struct scmi_syspower_conf *sc;
> >  	struct delayed_work *dwork;
> > +	bool needs_forceful;
> >  
> >  	if (system_state > SYSTEM_RUNNING)
> >  		return;
> > @@ -188,13 +197,16 @@ static void scmi_forceful_work_func(struct work_struct *work)
> >  	dwork = to_delayed_work(work);
> >  	sc = dwork_to_sconf(dwork);
> >  
> > -	dev_dbg(sc->dev, "Graceful request timed out...forcing !\n");
> >  	mutex_lock(&sc->state_mtx);
> > -	/* avoid deadlock by unregistering reboot notifier first */
> > -	unregister_reboot_notifier(&sc->reboot_nb);
> > -	if (sc->state == SCMI_SYSPOWER_IN_PROGRESS)
> > -		scmi_request_forceful_transition(sc);
> > +	needs_forceful = sc->state == SCMI_SYSPOWER_IN_PROGRESS;
> >  	mutex_unlock(&sc->state_mtx);
> > +
> > +	if (needs_forceful) {
> > +		dev_dbg(sc->dev, "Graceful request timed out...forcing !\n");
> > +		/* avoid deadlock by unregistering reboot notifier first */
> > +		unregister_reboot_notifier(&sc->reboot_nb);
> 
> And re-evaluate needs_forceful again here after un-registration before
> calling below forced transition ?
>

If all of this is locked as it was originally there is no need, the two
threads should just sync properly...

Let's see what Sashiko thinks..

Thanks,
Cristian
