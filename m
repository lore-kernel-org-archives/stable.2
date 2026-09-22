Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D1D4E1C99;
	Tue, 22 Sep 2026 07:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790063062; cv=none; b=PVhhsKyr+QpMB8FK9/PJVQMH9Y7Sinf8Mgs+hf1Ej1tLykqBOdTsJQB2rCK9RiVWHZ4i6Fw02oJXv53dOF38U47KDzh/l6BwUmuUCbiKxyx/3gnhNmvnjMwnvAsrmtNiSf98dhRmuIjYJbcwnk3TVD45m0QDFLIAsbZZ6Ad/Vaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790063062; c=relaxed/simple;
	bh=YnEiC4H36BjGtiMIO9W8IrDXNgmiIYXC/t2jxKEWTdE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jd+cNukNHb5PQQyRRV1iP8yQzmMvLk7pQndmQ4TyYmO3EUd42c+GEPGHdquchRqtVjPDyxZeiNs3E96hjRsU2eroxOJihShpV6DhjoKoUd0HovurV3VumMjHiA23id2+dea5N+Lg3H0+6kum7kalnrxp9PDwE0DdC3vl/CqFK5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CowOJoow; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CowOJoow"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32491F000FF;
	Tue, 22 Sep 2026 07:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790063060;
	bh=ZTYXbDz3PbHMAg7oJRs7Uzrtey45mvJsn1WZ7FXA1W8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CowOJoowutqKKYaAXws9k+lVlb96XnB2W/R1Twj4OOmrhztiS8/QKM+Enm3y+72BN
	 7X78t+zq9dOcytXqoQA9RqQoOSToX3S9p1/G4l7/PF/nQf+V6wZvAk0XanV9ja8n/a
	 d/UONMY4gbERjiS2ejhlqXU4M8RN4RHrju48sNHMIW/6FkbdZhsl8Evro/8MS4p4ZV
	 a8CVpoC5mfeFSLFJUbJ3CG6mBW+ZeWnArBVXpDKxG47ZxQX0PvVyjUzC/ADPUpJzmC
	 CtkrXeHkJXJ8w64ohQNjIL9jfEV9SV9LrsWcJJ8RogHpSFT6rCY1Xs2aCslL4wU5T4
	 +IVu4WCOBotUQ==
Subject: Re: [PATCH net v2 2/4] ieee802154: cc2520: flush fifop_irqwork before
 destroying buffer_mutex in probe
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: alex.aring@gmail.com, miquel.raynal@bootlin.com, stefan@datenfreihafen.org,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Tue, 22 Sep 2026 07:44:19 +0000
Message-ID: <179006305957.2160803.9020319580906464646@kernel.org>
In-Reply-To: <20260921074207.2289391-2-benquike@gmail.com>
References: <20260921074207.2289391-2-benquike@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the cc2520_probe() error path
  (drivers/net/ieee802154/cc2520.c:1155-1158) still uses…
- [Medium] The commit message's quoted evidence does not match the defect
  it describes or the change it makes.
- [Medium] Incorrect Fixes: tag / wrong stable backport range.

Pre-existing issues:
- [Medium] Pre-existing: the cc2520_probe() error path does not roll back
  the hardware power/reset ramp.

--

ieee802154: cc2520: flush fifop_irqwork before destroying buffer_mutex in probe

This swaps two statements on the err_hw_init path of cc2520_probe() so that
flush_work(&priv->fifop_irqwork) runs before mutex_destroy(&priv->buffer_mutex),
with the stated goal of matching the teardown order used by cc2520_remove().

A few questions about the change and the commit log below.

>From the commit message:

>     In cc2520_probe()'s err_hw_init path, mutex_destroy(&priv->buffer_mutex)
>     is called before flush_work(&priv->fifop_irqwork). If fifop_irq fires
>     after devm_request_irq() and schedules priv->fifop_irqwork before probe
>     fails, cc2520_fifop_irqwork() can lock priv->buffer_mutex after it has
>     already been destroyed:
>
>       BUG: KASAN: slab-use-after-free in assign_work+0x2f1/0x340
>       Read of size 8 at addr ffff88800246b0b0 by task kworker/1:1/43
>       Workqueue:  0x0 (events)
>       Call Trace:
>        <TASK>
>        dump_stack_lvl+0x70/0xa0
>        print_report+0x153/0x4c6
>        kasan_report+0xf1/0x120
>        assign_work+0x2f1/0x340
>        worker_thread+0x2b8/0xb70

[Severity: Medium]
Does this trace actually correspond to the ordering problem being described?

For !CONFIG_DEBUG_MUTEXES, include/linux/mutex.h has:

	static inline void mutex_destroy(struct mutex *lock) {}

so on production kernels the reorder is a no-op.  With
CONFIG_DEBUG_MUTEXES, kernel/locking/mutex-debug.c does:

	void mutex_destroy(struct mutex *lock)
	{
		DEBUG_LOCKS_WARN_ON(mutex_is_locked(lock));
		lock->magic = NULL;
	}

which can produce a DEBUG_LOCKS warning on a subsequent mutex_lock(), but
does not free any memory.

The pasted report is a use-after-free on the work_struct inside the
workqueue core (assign_work()/worker_thread()), i.e. priv freed while the
work was still queued, which is a different failure from
cc2520_fifop_irqwork() locking a destroyed buffer_mutex.  Could the commit
message be adjusted so the quoted symptom matches the described defect,
given that the log carries Cc: stable@vger.kernel.org?

Similarly, does "Tested in QEMU with KASAN enabled by scheduling
fifop_irqwork on the cc2520_probe() error path" demonstrate the described
mutex ordering issue, or the queued-work-after-free one?

>     Fixes: ff5891b266a7 ("ieee802154: cc2520: fix FIFOP work use-after-free")

[Severity: Medium]
Is this the right commit to blame?  ff5891b266a7 changes only
cc2520_remove(), where it replaced the flush with:

	disable_work_sync(&priv->fifop_irqwork);

git blame of the err_hw_init sequence being reordered here points at
0da6bc8cc341 ("ieee802154: cc2520: adds driver for TI CC2520 radio") from
2014, not ff5891b266a7.  With the current tag, stable trees that predate
ff5891b266a7 would not pick this up.

> diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
> index 545487223838..d2c8484d8fea 100644
> --- a/drivers/net/ieee802154/cc2520.c
> +++ b/drivers/net/ieee802154/cc2520.c
> @@ -1153,8 +1153,8 @@ static int cc2520_probe(struct spi_device *spi)
>  	return 0;
>  
>  err_hw_init:
> -	mutex_destroy(&priv->buffer_mutex);
>  	flush_work(&priv->fifop_irqwork);
> +	mutex_destroy(&priv->buffer_mutex);
>  	return ret;
>  }

[Severity: High]
Can flush_work() close this window at all while the FIFOP interrupt is
still armed?

The FIFOP handler re-queues unconditionally on every edge:

	static irqreturn_t cc2520_fifop_isr(int irq, void *data)
	{
		struct cc2520_private *priv = data;

		schedule_work(&priv->fifop_irqwork);

		return IRQ_HANDLED;
	}

flush_work() waits for a queued or running instance but does not prevent a
new submission, and the irq was requested with devm_request_irq(), so it
stays registered until the driver core unwinds devres after probe returns:

cc2520_probe() [err_hw_init]
    flush_work(&priv->fifop_irqwork);      /* CPU0 */
                                           /* CPU1: FIFOP edge ->
                                              cc2520_fifop_isr() ->
                                              schedule_work() re-queues */
    mutex_destroy(&priv->buffer_mutex);
    return ret;
really_probe()
    device_unbind_cleanup()
        devres_release_all()               /* frees the irq and the
                                              devm_kzalloc'ed priv */

priv embeds both fifop_irqwork and buffer_mutex, so the worker pool then
touches a freed work_struct, and cc2520_fifop_irqwork() can dereference
freed priv:

	if (gpiod_get_value(priv->fifo_pin))
		cc2520_rx(priv);
	...
	cc2520_cmd_strobe(priv, CC2520_CMD_SFLUSHRX);

reaching cc2520_cmd_strobe(), which locks the destroyed and freed
buffer_mutex.  That is the same assign_work()/worker_thread() signature
quoted in the commit message.

Would disable_work_sync() be appropriate here, the way ff5891b266a7 handled
cc2520_remove() for exactly this devm-irq-outlives-teardown case?
Alternatively, releasing or masking the FIFOP irq before draining the work.

There is also the cc2520_register() failure case, where priv->hw is freed
but not cleared:

	err_free_device:
		ieee802154_free_hw(priv->hw);

so a surviving work item can reach a freed hw through
cc2520_rx()->ieee802154_rx_irqsafe().

For reference, no later patch in this series changes this path; err_hw_init
still reads flush_work() followed by mutex_destroy() at the end of the
series.

[Severity: Medium]
This isn't a bug introduced by this patch, but while the err_hw_init path is
being touched: should it also unwind the power and reset ramp done earlier in
cc2520_probe()?

	gpiod_set_value(vreg, HIGH);
	usleep_range(100, 150);

	gpiod_set_value(reset, HIGH);
	usleep_range(200, 250);

err_hw_init only flushes the work and destroys the mutex.  Releasing a gpio
descriptor through devres does not restore its output level, so after a
failure in cc2520_hw_init(), either devm_request_irq(), or cc2520_register(),
the CC2520 stays powered and out of reset with no driver bound.  On a later
re-bind, reset is already HIGH, so does cc2520_hw_init() then program a chip
that never saw a reset pulse?  This dates back to the original driver
(0da6bc8cc341).

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921074207.2289391-1-benquike%40gmail.com
