Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A93E41C72;
	Tue,  8 Sep 2026 00:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828366; cv=none; b=L9bDj6zEYDialk9iFC3Z7rz6YrE3gv1zd5ObMTR5uQ+ZdxNborWeJ0UfK7BXQiQjQtlghcmRpcDddjRvpj430c6UHHTNA7HT3IZFCDQp8HuRAgg8TeWCaQD6Gl0+KxoykOlNelb0NaR1SS8mYRW7Pc9uOrR/G847xWstL3atGRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828366; c=relaxed/simple;
	bh=Zhz1uluj3kL2dWsch/Lcu1uzAQ8IJhfHWPjA3Krj2RI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gkYFcNOuhZK0FkugJMvNCHySg2Nzr227yfaFqKJxb7xKnNyxAH3LevmcaBNy5gfwsGDwwkzsbu2otAsPlBNLDx7HABPUk9fi1/iFtZxGA2CQwYFgwC6d/VCTPy88YSlESe+bdq57o5ZTjKku5ujn7IyNdHz3IGfNGpFPjryxqWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpbTR1Rp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpbTR1Rp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCA01F00A3D;
	Tue,  8 Sep 2026 00:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828365;
	bh=4tLeinopXKtLTRJuVWmN24NUeUqBJ3S9IqLO/+/AtgU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KpbTR1RpZb0739kfd+lRyUAwDN5UChREbDOEdXYw1pDdnugCTk2nCvm2F7RVx0XHO
	 0/OnOyv5IUEda0If4nzxWQ/SgoRjZqRNatcCOlJYrBm/mgVLPtUUNTG67HKDuCMBdS
	 3s4VHwS1ONfCYvnawhgUhjm5erQ9NX6Ll1IaRd8I9B6Iqyye6bsjgy2LF/1jBvmUvG
	 zlM8nmLs4jWgYoC5lS9oxivZVQougZaKDuRBA5YzeGrkCnUjBubHU7uwWDmUYRlo0i
	 mVUdk1aylr7hBpjn8+gC5RVSuevkIirgvIvEAivBCFgNA7fK9wyhQcnFyEvMAQ03ry
	 dVpJ+Mi14B2cQ==
Subject: Re: [PATCH net] ptp: ocp: prevent watchdog rearming during detach
From: netdev-bot+sashiko@kernel.org
To: runyu.xiao@seu.edu.cn
Cc: richardcochran@gmail.com, jonathan.lemon@gmail.com,
 vadim.fedorenko@linux.dev, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, jianhao.xu@seu.edu.cn,
 kuba@kernel.org
Date: Tue, 08 Sep 2026 00:46:04 +0000
Message-ID: <178882836407.219967.5220210793908867090@kernel.org>
In-Reply-To: <20260904064308.4044677-1-runyu.xiao@seu.edu.cn>
References: <20260904064308.4044677-1-runyu.xiao@seu.edu.cn>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] Incorrect bug premise in the commit message and unwarranted
  Fixes:/Cc: stable tags.

--

ptp: ocp: prevent watchdog rearming during detach

The patch replaces timer_delete_sync() with timer_shutdown_sync() for the
bp->watchdog teardown in ptp_ocp_detach(), and is tagged as a fix for
773bda964921 with Cc: stable, on the grounds that the watchdog callback can
rearm itself past the sync delete and later touch freed ptp_ocp state.

> ptp_ocp_detach() uses timer_delete_sync() to stop the watchdog before
> freeing the ptp_ocp state. timer_delete_sync() waits for a callback that is
> already running but does not prevent the callback from rearming the timer.
>
> Since ptp_ocp_watchdog() unconditionally calls mod_timer(), detach can
> return with the watchdog pending. A later callback can access freed state.

[Severity: Medium]
Is this description of timer_delete_sync() accurate for a timer whose only
rearm source is its own callback?

In this driver the only two places that arm bp->watchdog are the self-rearm
at the end of ptp_ocp_watchdog():

	mod_timer(&bp->watchdog, jiffies + HZ);

and the one-time arm in ptp_ocp_init_clock() next to the timer_setup():

	if (bp->pps_to_clk) {
		timer_setup(&bp->watchdog, ptp_ocp_watchdog, 0);
		mod_timer(&bp->watchdog, jiffies + HZ);
	}

There is no other thread or interrupt path that arms the watchdog.

For that case, doesn't __timer_delete_sync() already absorb the self-rearm
by retrying until the handler is no longer running?

kernel/time/timer.c:__timer_delete_sync() {
	...
	do {
		ret = __try_to_del_timer_sync(timer, shutdown);

		if (unlikely(ret < 0)) {
			del_timer_wait_running(timer);
			cpu_relax();
		}
	} while (ret < 0);
	...
}

and __try_to_del_timer_sync() only returns -1 while the handler is running,
otherwise it detaches whatever the handler re-queued:

kernel/time/timer.c:__try_to_del_timer_sync() {
	...
	if (base->running_timer != timer) {
		ret = detach_if_pending(timer, base, true);
		if (shutdown)
			timer->function = NULL;
	}
	...
}

__mod_timer() also refuses to migrate a timer to another base while
base->running_timer == timer, so the callback's rearm stays on the base the
deleter inspects.  The kernel-doc for timer_delete_sync() states that upon
exit the timer is not queued and the handler is not running on any CPU, and
its rearm caveat is about other code arming the timer concurrently, which
does not exist for bp->watchdog.

> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 3d26ec1f7b9ec..6b5f615a279d9 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -4870,7 +4870,7 @@ ptp_ocp_detach(struct ptp_ocp *bp)
>  	ptp_ocp_debugfs_remove_device(bp);
>  	ptp_ocp_detach_sysfs(bp);
>  	ptp_ocp_attr_group_del(bp);
> -	timer_delete_sync(&bp->watchdog);
> +	timer_shutdown_sync(&bp->watchdog);

[Severity: Medium]
The change itself looks harmless and matches the documented preference for
timer_shutdown_sync() on teardown paths, since bp is freshly allocated per
probe and the timer is never armed again after detach.

Given that, is there an actual use-after-free being closed here, or is this
a robustness cleanup?  If it is the latter, would it make sense to reword
the changelog without the use-after-free claim and drop the

	Fixes: 773bda964921 ("ptp: ocp: Expose various resources on the timecard.")
	Cc: stable@vger.kernel.org

tags, so the change is not backported into every stable tree as a memory
safety fix?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904064308.4044677-1-runyu.xiao%40seu.edu.cn
