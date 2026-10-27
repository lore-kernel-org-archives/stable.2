Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793065331;
	b=gsjfiwfh8YoQpsf3gtGwv8qEw/yWM2FH5aSuW36r4jmpnblKMZKF9b5WI8GZuGgw16py
	 mDzH3J2cwC+2e7A6CnnKU2JlRVe6n8GKNkMfwBbgOVGjFOgpN64FStEkIdAWYkzrf0dSN
	 UuPN3qvmZepvwJlzMWLQZ3BBZUo0poO5QBNDaLoQywKi/5DPxnfVlUiDW8eebje+Y8BqQ
	 MuooyjTlGu336NPQNdS6BGwhx9ddLArslf+tqcyxJlONbci3Gm8slhNAQS0i0dy+nU/gs
	 QdEd0lOmJVqqYHusXREXVrx9T6DfSD2ng8bk3aPtiroOdzWVjqVZNA4ZGME+qgQaZKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793065331;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ONMFfWPprC8EIvIg5UdiBFsghINfDVqSYXkDkR9baYI=;
	b=AwE0nBYmWJVG9RgeKehYvVHFql9qmf3dC0dIAlMKaKRWnLsp9cZMRvHw2oXfUIO/0GhN
	 kFUCtGF2aXOUZ6mEgzGB8gu+1riX4+n2UJVSOHt4ayg3foJ4G4ds8dYLk8AK499mTco9/
	 UUKknqv+K5J6V77JQUu6LI+Itko38hSIoxDpxNUMtdDkGalt2UgXYBfPPPGFxTmL0QgGX
	 3tQheissKVFWfkgEGG1drpiPAdrzEgTOoLBytCpVP/VlRcl79wUHmJ4uGnvAFoqV67gIH
	 lBC4fzegbVL1Bi55lMj8sN3fHze8KP5LPD/yc4Thi/bBG37F8M0ZW3XXLc5oSiPXBeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IrwpuIOH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FE960A2601;
	Tue, 27 Oct 2026 01:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IrwpuIOH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E491F031E1;
	Tue, 27 Oct 2026 01:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793065330;
	bh=ONMFfWPprC8EIvIg5UdiBFsghINfDVqSYXkDkR9baYI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IrwpuIOHQmXTtcsdnLk1oo595mUzHB+U1TtheNrzhl6+sbKTJ+7pyaYyGPDPoQpSD
	 YhGlxTomcNrB1SjNQiYuW6km0+sqVsOHZMsq/S6qM2eL1X9HIOztOFI9HAHWQr7qTX
	 Qb/bVM8lZRusYxyFSSI1lnLJwR4NE6Bh/FaAaFN8dmFDNpPPTA5ieDtt2w4/uo9AT4
	 AevkiXYjKpp3oqH83tQTHntr4Ztx6dPHUib11XEy77XSM77l/BFu3EvLSBcFja0hW2
	 /rwjkP1ABBwA5TfB3opsYsZlqS84z/13ADVJIf3FcdVj+JZq911JS5wVgeA92PKLlY
	 KxVZ5/68YJPow==
Subject: Re: [PATCH net v3 4/4] gve: Fix link flap after ethtool ops
From: netdev-bot+sashiko@kernel.org
To: hramamurthy@google.com
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 jordanrhee@google.com, willemb@google.com, przemyslaw.kitszel@intel.com,
 nktgrg@google.com, maolson@google.com, jacob.e.keller@intel.com,
 pkaligineedi@google.com, yangchun@google.com, patricion@google.com,
 awogbemila@google.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 treapking@google.com
Date: Tue, 27 Oct 2026 01:42:09 +0000
Message-ID: <179306532917.3134.3709041101906222542@kernel.org>
In-Reply-To: <20261023204706.3112215-5-hramamurthy@google.com>
References: <20261023204706.3112215-5-hramamurthy@google.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Synchronous link-status update in gve_queues_start() races
  with gve_service_task(); the carrier can be left in the wrong state.

--

gve: Fix link flap after ethtool ops

gve_queues_start() now calls gve_turnup_and_check_status() directly
instead of queueing the service task, so the carrier state is updated
before the call returns to userspace. This avoids the transient carrier
drop after ethtool reconfiguration that was breaking the
drivers/net/ping.py selftest.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 52c152a986eb7..e2a016f4430a8 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c

[ ... ]

> @@ -1486,8 +1515,7 @@ static int gve_queues_start(struct gve_priv *priv,
>  			  round_jiffies(jiffies +
>  				msecs_to_jiffies(priv->stats_report_timer_period)));
>  
> -	gve_turnup(priv);
> -	queue_work(priv->gve_wq, &priv->service_task);
> +	gve_turnup_and_check_status(priv);

[Severity: Medium]
Can this race with gve_service_task() and leave the carrier in the wrong
state?

Before this change, gve_queues_start() sent its link update through
service_task. A work item never runs concurrently with itself, so these
updates were serialized.

gve_queues_start() is reached from ndo_open, from gve_adjust_config(),
and from gve_reset()->gve_recover()->gve_open(). It holds rtnl and the
netdev instance lock, and it now runs the same sequence as
gve_service_task().

gve_service_task() is queued from gve_mgmnt_intr() and holds neither
lock:

gve_service_task() {
    ...
	gve_handle_reset(priv);
	ops->report_link_status(priv);
	gve_handle_link_status(priv);
}

gve_adminq_report_link_status() reads the register and writes the
cached value in two separate steps:

	status = ioread32be(&priv->reg_bar0->device_status);
	WRITE_ONCE(priv->link_up,
		   !!(GVE_DEVICE_STATUS_LINK_STATUS_MASK & status));

Here is one possible interleaving:

gve_queues_start()                  gve_service_task()
  ioread32be() -> link down
                                    (device link up, mgmt irq)
                                    ioread32be() -> link up
                                    WRITE_ONCE(link_up, true)
                                    netif_carrier_on()
  WRITE_ONCE(link_up, false)
  netif_carrier_off()

At the end the carrier is off while the device link is up. The service
task run triggered by the interrupt has already finished, so nothing
checks the link again until the device raises another status interrupt.

gve_handle_link_status() has a similar window, because its check and
its action are not done under a lock:

	link_up = READ_ONCE(priv->link_up);
	if (link_up == netif_carrier_ok(priv->dev))
		return;

	if (link_up) {
		netdev_info(priv->dev, "Device link is up.\n");
		netif_carrier_on(priv->dev);

Suppose gve_queues_start() reads link_up == true with the carrier off,
and is then delayed in netdev_info(). In that time gve_service_task()
can write link_up = false, see that it matches netif_carrier_ok(), and
return. gve_queues_start() then calls netif_carrier_on() while the link
is down.

gve_set_xdp() and the per-queue start path already use the same
pattern without a lock. This patch also brings it to the common
gve_queues_start() path, which used to be serialized through the
service task.

Should gve_turnup_and_check_status() and gve_service_task() be
serialized against each other here?

>  	priv->interface_up_cnt++;
>  	return 0;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023204706.3112215-1-hramamurthy%40google.com
