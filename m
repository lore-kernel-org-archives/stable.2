Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793654326;
	b=OiCaQpJ31KGzXdAnpPGAOW3fesr0d2T0+RnBW0wtXXMV3Fii5hDY3GPBbnXmOiAX95XA
	 4rJgJ+Nhgq6qKF34UxcWbG8TQtvyl2RsbqmeLmPRY2bJFv2JDYUqnmyz/lxSBfm40b7Hu
	 VdsxMuGe81mKiI5XP6zL49vOQf+soP9a1YpBfmnk06fE+3rq/H9nKUIvdm1jJBBkHdYhj
	 GTi1YLOUOU319uenO+OYOjisMMZx54mjKEFq3QI8qUJR0TzuJntSfc2xtkZ5jLkr3BcCa
	 D6yNwa1843etlF9wSDfwypY/vvsne71g77P2D2VPx3s/1peG6D5X4mLo7KbMElDYhKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654326;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=N8r2SEFBHRm93yES3ouPQTclhmQ3vt6M/44+CDFQ29E=;
	b=eRq3lzNLM0Dnc2eOnBv6f5eweL604/Ivo2p/dxIFweQ1CfXMiMw0aESMrJUv9aRWNjUc
	 bFrWmYevikovEsLzjNrLIVD7/zbJRe0vjXyozjbYaBkYXAj6lFu4x9DNezRjlpyOXydiB
	 IrASwGo++PNkGCtp1mKlP2Kr7o0z5+d7YZqt9WASzh0lgMAFyK9GD8EcNr1I4cE5f2PTE
	 nMqbgwHfbrXXPrB97OA5YsK72BKqWxZKwcjLUSaEdvSQAoj6G350DmuGzZ0dKYN4NdRzj
	 5Ul1VX4FObA3dqQA5jIYfgdn85GklicKbFOi/07jA23fHxqI5/bPuw9A3f+Wlnh/KfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=og5kmwwk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57F6606A33E;
	Mon,  2 Nov 2026 21:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=og5kmwwk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2981F00A16;
	Mon,  2 Nov 2026 21:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793654325;
	bh=N8r2SEFBHRm93yES3ouPQTclhmQ3vt6M/44+CDFQ29E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=og5kmwwkzuWONcLGHqiDI6wWAg7YhhEHplwEL8Q50PPyTJHwGPYQ8RoDhaYhhEJxw
	 qVP6eahiUXdDTw3XYj30Z8a8U9pyqdIcYp226Tg2cNQub6J59NcJ1RAFNYkBkY2fUB
	 oy0cHV1QC/Tgr53l5XSE4NIrnc1rS2CP/xUe+eCBgnjlBSnXiTA8n89C/jdlBZr6nY
	 oMZN7JrTolBTeVfEToGUvH75DjIL1B++trZcbbo49C1bVa7NojQuYonyVCgBlVdqcV
	 DEzhB934Bxn1yaAV82LUe6QKrMGcoluUL7mT5oM0vpQY6vMKq7pQh02hCvWYSDhfKG
	 zVZmUpsSAz8Ew==
Subject: Re: [PATCH net v4 4/4] gve: Fix link flap after ethtool ops
From: netdev-bot+sashiko@kernel.org
To: hramamurthy@google.com
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 jordanrhee@google.com, willemb@google.com, przemyslaw.kitszel@intel.com,
 nktgrg@google.com, maolson@google.com, jacob.e.keller@intel.com,
 pkaligineedi@google.com, yangchun@google.com, patricion@google.com,
 awogbemila@google.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 treapking@google.com
Date: Mon, 02 Nov 2026 21:18:43 +0000
Message-ID: <179365432386.3131.15374369453099115031@kernel.org>
In-Reply-To: <20261029211634.2232784-5-hramamurthy@google.com>
References: <20261029211634.2232784-5-hramamurthy@google.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch removes `queue_work(priv->gve_wq, &priv->service_task)`
  from the end of gve_queues_start()…

--

gve: Fix link flap after ethtool ops

This patch changes gve_queues_start() to update the carrier state
synchronously through gve_turnup_and_check_status(), instead of queueing
the service task to do it. It also takes netdev_lock() around the link
status update in gve_service_task(), so that update is serialized with
the synchronous path.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index b5e2f39a903c5..bc7d7c41948c3 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c

[ ... ]

> @@ -1494,8 +1526,7 @@ static int gve_queues_start(struct gve_priv *priv,
>  			  round_jiffies(jiffies +
>  				msecs_to_jiffies(priv->stats_report_timer_period)));
>  
> -	gve_turnup(priv);
> -	queue_work(priv->gve_wq, &priv->service_task);
> +	gve_turnup_and_check_status(priv);
>  	priv->interface_up_cnt++;
>  	return 0;

[Severity: Low]
Commit 3b7cc73628ff added this queue_work() for the link status update,
and the new synchronous check handles that. Does removing it also drop
the service task run that used to follow every reset recovery?

gve_reset() clears the reset flag first and then disables the service
task:

gve_reset() {
    ...
	gve_clear_do_reset(priv);
	gve_set_reset_in_progress(priv);

	if (was_up) {
		gve_turndown(priv);
		...
	}

	disable_work(&priv->service_task);
	...
	enable_work(&priv->service_task);
	err = gve_recover(priv, was_up && !skip_queue_setup);
    ...
}

gve_schedule_reset() could run after gve_clear_do_reset() but before
disable_work(). One way is gve_tx_timeout() from dev_watchdog racing
with gve_turndown(). Another is an RX NAPI error path just before
napi_disable:

gve_schedule_reset() {
	gve_set_do_reset(priv);
	queue_work(priv->gve_wq, &priv->service_task);
}

In that case, disable_work() cancels the queued work, or queue_work()
is rejected while the work is disabled. enable_work() does not queue it
again.

Before this patch, gve_recover()->gve_open()->gve_queues_start() ended
with queue_work(), so a leftover GVE_PRIV_FLAGS_DO_RESET was handled
right after recovery.

After this patch, the service task is not queued again until some
unrelated event, such as a later gve_mgmnt_intr(). When it does run,
gve_service_task()->gve_handle_reset() would perform a full gve_reset()
because of the stale flag. That reset could happen long after, and
unrelated to, the event that set the flag.

gve_suspend() and gve_resume() seem to have the same gap. They call
disable_work_sync() in gve_suspend() and enable_work() before
gve_recover() in gve_resume().

The other parts of this look fine. A missed device REPORT_STATS request
only skips a stats_report_trigger_cnt increment, because
gve_stats_report_schedule() sets do_report_stats on every timer period.
A device RESET request raised inside the disable window is covered by
the reset that is already running.

Could gve_reset() and gve_resume() queue the service task again after
recovery, or re-check gve_get_do_reset() once the work is re-enabled?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029211634.2232784-1-hramamurthy%40google.com
