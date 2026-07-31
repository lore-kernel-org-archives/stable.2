Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CEB427A10;
	Fri, 31 Jul 2026 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503507; cv=none; b=sWqgXP0XVY/54HGDMx3wgwM9rC5uPfEOV8K0yWKJdjUBMufNvz4stXZigVHnOAARAdZxRLjTV3z7g04ttx/r6rvA8mlGjhIIWexb5qcdHl1GdxpQ8OoC77sRdlVbQDSTSUOuVi5B+vK11hLDoEl4jWmnYQnAI6G4lIASiJtmm6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503507; c=relaxed/simple;
	bh=cdVFN5+AJoKFcNRze2Moihk7gMMfozZteDphDsr4YOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEyguVIfUB9xamfQ19ehV+5f3scNqVGdEK5d3RJKVvnIr4vlJf3LpfMfqFVrye516S7QxRQyYJKoxUR+GA7sAb96byF1eXz60l8JhMJ9xWlPzHoA/b9a15Cc/lfz/eIu+NWrZkXg/8+T+vs1NM3t1ScAV7BCag8ntiHazYiA4Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1rjptIk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1rjptIk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913151F000E9;
	Fri, 31 Jul 2026 13:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785503505;
	bh=njAxdslaCwu+qgiLQg8pHyf0IOr9kMNfF7OhA7OHY3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l1rjptIkxhdCbx0SBIgY4e11Qr3HBWAv0gGsQ7GR6k5tk5F56P2OgNoKJJfyV5lm6
	 O+T7YAvwieoIhRX+K5sivTHg9VW5AZJmY/FU43xpSI0zfVBFoAj3u03qEDR6Xj2g4Y
	 csLcnOhvmuOvpslR1oAPeSAKKKFwroeF6H8eRFA6zCDNYoj8zXmSzhraz0wbNMddIy
	 XXo2declF8ropp8q6rObtJkIkLneOtNdcsD9GdqV9mkqsitM3Oybm+9H2KDGSe4jsD
	 PJwDrsmv15rezD/7GBA8UIBNDCIv05MYwUz4GhrrjFTi/yHl6pT2S0ml9SxUFf7wAE
	 awUVudkdTH6Kw==
Date: Fri, 31 Jul 2026 14:11:41 +0100
From: Simon Horman <horms@kernel.org>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: netdev@vger.kernel.org, david@ixit.cz, mgreer@animalcreek.com,
	oe-linux-nfc@lists.linux.dev, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] nfc: trf7970a: drain timeout_work and keep
 trf->lock valid across teardown
Message-ID: <20260731131141.GH51943@horms.kernel.org>
References: <20260728030716.230626-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728030716.230626-1-fanwu01@zju.edu.cn>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260728030716.230626-1-fanwu01@zju.edu.cn?part=1

Simon says; Thanks for the updates in v2. It seems that Sashiko
            has some more feedback, I'd appreciate it if you could
	    look over it.
---
--- Patch [1]: [PATCH net v2] nfc: trf7970a: drain timeout_work and keep trf->lock valid across teardown ---
commit 759d465c2a36b8aecb984c2dddb7b2b408b93082
Author: Fan Wu <fanwu01@zju.edu.cn>

nfc: trf7970a: drain timeout_work and keep trf->lock valid across teardown

The patch adds cancel_delayed_work_sync(&trf->timeout_work) to
trf7970a_remove() (between nfc_digital_unregister_device() and
nfc_digital_free_device()) and to the probe error path, and it drops
mutex_destroy(&trf->lock) from both paths so the mutex stays valid until
devm releases the threaded IRQ.

A few questions below.

> diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
> index 60883001fa5d..37d543fd5913 100644
> --- a/drivers/nfc/trf7970a.c
> +++ b/drivers/nfc/trf7970a.c
> @@ -2207,13 +2207,13 @@ static int trf7970a_probe(struct spi_device *spi)
>  err_shutdown:
>  	trf7970a_shutdown(trf);
>  err_free_ddev:
> +	cancel_delayed_work_sync(&trf->timeout_work);
>  	nfc_digital_free_device(trf->ddev);
>  err_disable_vddio_regulator:
>  	regulator_disable(trf->vddio_regulator);
>  err_disable_vin_regulator:
>  	regulator_disable(trf->vin_regulator);
>  err_destroy_lock:
> -	mutex_destroy(&trf->lock);
>  	return ret;
>  }

[Severity: Low]
With mutex_destroy() gone, err_destroy_lock: is now an empty label sitting
directly in front of return ret;, while its name still says a lock is
destroyed there:

	err_destroy_lock:
		return ret;

The two remaining users are the devm_regulator_get("vin") failure and the
regulator_enable(vin) failure paths.  Would it be cleaner to turn those two
gotos into plain return ret; statements, or to rename the label to something
like err_out?

>  
> @@ -2228,12 +2228,11 @@ static void trf7970a_remove(struct spi_device *spi)
>  	mutex_unlock(&trf->lock);
>  
>  	nfc_digital_unregister_device(trf->ddev);
> +	cancel_delayed_work_sync(&trf->timeout_work);

[Severity: High]
Can the handler this drain waits for still complete upstream into the
already-torn-down digital core?  This isn't a bug introduced by this patch
(before it, the same handler could run even later, after remove() returned),
but the commit message argues that this placement makes freeing the digital
device safe, and that part looks incomplete.

Consider a timeout handler that already started and is blocked in
mutex_lock(&trf->lock) in trf7970a_timeout_work_handler() while remove()
holds the lock.  trf7970a_shutdown() completes the command once through
trf7970a_send_err_upstream(), which uses the non-blocking cancel:

drivers/nfc/trf7970a.c:trf7970a_send_err_upstream() {
	...
	cancel_delayed_work(&trf->timeout_work);
	...
}

For an already-executing handler that returns false, and the return value is
discarded, so trf->ignore_timeout stays false.  Neither
trf7970a_send_upstream() nor trf7970a_shutdown() clears trf->cb or
trf->cb_arg.

The handler is then released by the mutex_unlock() just above and, with
state TRF7970A_ST_PWR_OFF and ignore_timeout false, takes the final else
branch and does a second, stale completion:

drivers/nfc/trf7970a.c:trf7970a_send_err_upstream() {
	...
	trf->cb(trf->ddev, trf->cb_arg, ERR_PTR(errno));
}

trf->cb is digital_send_cmd_complete() and trf->cb_arg is the digital_cmd
that nfc_digital_unregister_device() just freed:

net/nfc/digital_core.c:nfc_digital_unregister_device() {
	...
	cancel_work_sync(&ddev->cmd_complete_work);

	list_for_each_entry_safe(cmd, n, &ddev->cmd_queue, queue) {
		list_del(&cmd->queue);
		...
		kfree(cmd);
	}
}

net/nfc/digital_core.c:digital_send_cmd_complete() {
	struct digital_cmd *cmd = arg;

	cmd->resp = resp;
	...
	schedule_work(&ddev->cmd_complete_work);
}

So the stale completion writes cmd->resp into freed memory and re-queues
ddev->cmd_complete_work after the core already did its single
cancel_work_sync(), and nfc_digital_free_device() frees ddev on the next
line.  __cancel_work_sync() re-enables the work after flushing, so nothing
blocks the re-queue.

Would neutralising the upstream completion during teardown help here, for
example clearing trf->cb/trf->cb_arg (or setting ignore_timeout / a
"removing" flag) under trf->lock in the shutdown path, or draining both
before and after nfc_digital_unregister_device()?

[Severity: High]
Is this drain the last event that can arm timeout_work?  This is also a
pre-existing problem rather than something the patch introduces, but the
TRF7970A_ST_LISTENING_MD state seems to escape the new drain.

trf7970a_shutdown() does not handle that state:

drivers/nfc/trf7970a.c:trf7970a_shutdown() {
	switch (trf->state) {
	...
	case TRF7970A_ST_IDLE:
	case TRF7970A_ST_IDLE_RX_BLOCKED:
		trf7970a_switch_rf_off(trf);
		break;
	default:
		break;
	}
	...
}

TRF7970A_ST_LISTENING_MD, set by _trf7970a_tg_listen(), falls into
default:, so RF is never switched off and trf7970a_power_down() bails out
(its return value is discarded):

drivers/nfc/trf7970a.c:trf7970a_power_down() {
	if (trf->state != TRF7970A_ST_RF_OFF) {
		dev_dbg(trf->dev, "Can't power down - not RF_OFF state (%d)\n", trf->state);
		return -EBUSY;
	}
	...
}

The chip stays enabled and its threaded IRQ stays registered until devm runs
devm_free_irq() after .remove() returns.  trf7970a_irq() only short-circuits
on TRF7970A_ST_RF_OFF, so an interrupt in that window reaches:

drivers/nfc/trf7970a.c:trf7970a_irq() {
	...
	case TRF7970A_ST_LISTENING_MD:
		if (status & TRF7970A_IRQ_STATUS_SRX) {
			trf->ignore_timeout = !cancel_delayed_work(&trf->timeout_work);
			ret = trf7970a_mode_detect(trf, &trf->md_rf_tech);
			...
				trf7970a_drain_fifo(trf, status);
	...
}

and trf7970a_drain_fifo() re-arms the work:

	schedule_delayed_work(&trf->timeout_work,
			   msecs_to_jiffies(TRF7970A_WAIT_FOR_RX_DATA_TIMEOUT));

Nothing drains it a second time, so the re-armed work can fire after devm
frees the devm_kzalloc()'d trf, and the same IRQ path dereferences
trf->ddev, which nfc_digital_free_device() freed on the next line.

Separately, the same shutdown gap looks like it leaks a VIN enable
reference: probe enables vin once and trf7970a_power_up() enables it again,
against the single regulator_disable(trf->vin_regulator) in remove().

Should TRF7970A_ST_LISTENING_MD be added to the shutdown switch (and the
power_down() failure be handled) so the drain is really the last arming
opportunity?

>  	nfc_digital_free_device(trf->ddev);
>  
>  	regulator_disable(trf->vddio_regulator);
>  	regulator_disable(trf->vin_regulator);
> -
> -	mutex_destroy(&trf->lock);
>  }

Simon says: I believe the issue below was discussed indirectly in the
            review of v1. And the behaviour described below is expected.

[Severity: Low]
This isn't a bug, but the correctness of dropping mutex_destroy() now rests
on an invariant that is not recorded anywhere in the file: devm reverse-order
release must run devm_free_irq() (registered in trf7970a_probe() after the
devm_kzalloc() of trf) before trf itself is freed.  The ordering as written
today is fine, but a future change that moves devm_request_threaded_irq()
ahead of the devm_kzalloc(), or converts trf to a non-devm allocation,
silently brings back the use-after-free with no comment and no build-time
check.  Removing mutex_destroy() also drops the CONFIG_DEBUG_MUTEXES
use-after-destroy check for this lock.

Would an explicit devm_free_irq()/disable_irq() at the top of
trf7970a_remove() (which synchronises the handler and lets mutex_destroy()
stay), or devm_mutex_init() so the mutex teardown is itself devm-ordered, be
preferable to relying on the implicit order?  Either way, the threaded IRQ
handler can still run during and after .remove(), taking trf->lock and
driving a device that trf7970a_shutdown() already powered down and
pm_runtime_disable()'d.

>  
>  #ifdef CONFIG_PM_SLEEP
