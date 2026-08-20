Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF0136A37A
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 15:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787238689; cv=none; b=U4BYDp/nEEFoIC0BkITl9DNwfMJlQECaYF85EsK1YeXGcK+Y4QeCADlHvg9Z4xNH0sXMFV5fWVbmGwZhrTFgbAFCn9fvXP7nrbcd+kSQHCs/B2iQ2V/LQCdaP1AlwIeG491HqSuFJi9P0H4NzxZBi06eQ+jy6SvYXV3poNDA7DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787238689; c=relaxed/simple;
	bh=dQpRJgHs4VCqTTuG7NJnSNMX8uDVRFjUZDTlhepGPIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tlfPUUEREbYovTmwDauKm5zYS8nitLieOq7XXYmzXLGrDUXgflI+uA4jmMZBgM3jDjvFJ5WGc9ZNUB6Hm2JXRYa2D4ywe9sFk7b3MuHTLNrofNBZgyGD7mAPlyi9ir6trkNeq3RuECC+kF8l6NxuEbOBLLwYer4Qzf8Wn4QPGnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=ffU3upvv; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="ffU3upvv"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d01663d816so17611475ad.1
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 08:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1787238686; x=1787843486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MFOrGLABmAiCSf8a/hvQdV7o8V8gFU3YtvzUDAL57QU=;
        b=ffU3upvvtjMavlLiVB89HhDWq/KFguQn5shwyPZXyZEuGNe/2zwX/+zhPHbAkGKPRT
         3IcooXXUXBi0vbPG8t3gtFKEa2sd10L8N3t4lZWKzyVi0C0IUDTHylxBV35inCB3wpBf
         3UDmeJxPRshMsptcqPAZfBeqodXRnCwMCIlxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787238686; x=1787843486;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MFOrGLABmAiCSf8a/hvQdV7o8V8gFU3YtvzUDAL57QU=;
        b=edwFc6whEwwESiweGObgQAIZITZFzomOu9gqWl4bkfbfXJsXI4wovbMpLatc2X9PYf
         r+Aw5QWweuwS6nuvJ1ntKcTCZP+rk/evSvw9KCU3gV18nDsdfPT4+rKADZL1kHMA0XyE
         OK0vEqVfTjUAYim1GhuaxEOwz4KtM6l6+g135zj7frUiexaDVdyVhYwCaEbHeE6jOBNz
         1ltOpXLges6hK9fj43xpktRMD7udCD9qV/jCVbJykj5i0Opm/YZr3p/ueN/BVl6wbrHq
         UHSyl65/cHckMHUW7XUkOBgq8ipVGtufF6kKR5zkD0EqxZpeIK2yyP3ZpKUOsdPbEmxw
         2xsg==
X-Forwarded-Encrypted: i=1; AHgh+RqSkvBe1GHS3Y+ri1yxVujygf36pkJFsLqASv1TAeQI/hPtdnil+LWkPLXdBldgCRK3Yfhr5wk=@vger.kernel.org
X-Gm-Message-State: AFuF++kauVMs4fq+GbFArAEK8tEmclRLxK1Y5UuvfsT/MMOhiA2g6a1R
	GPC/0nG0caKNT+HQabUA/InNCndOw3WF4AMtONnGVQt8FjJ5w1wn5WmRK1U8d2nWMg==
X-Gm-Gg: AR+sD13mhxQx2yvh9HpEqwTGcMg2wIdJxveAwWWJlj3BTQNUxahTaSkcncHGI27Ajvd
	rwybQuIK+FCqyWSAaP0XdDcBTHAlprutBClFpejG4i7VUKaTAkRHQQOUtIMQDVZSeonlUlDl5+E
	/pYuliMz3lZ0YG5lW2ShPSnrXWN7BOsqF1vrdKmrrAoypoQ69smF3kYFY7mG13BRHnCmigi8oWB
	OHRJX4OUhkNnhpB15pt2FIbHL8p0bervy8TYnx3n0R7QEjgADfHYeq627mnqB12NcFKqgVt8T/5
	PF9xc+KhOp+rO0cGl+plKdEraN3BK4/M8Z/TJRYOlowohSi7yBL/veBELpNL3rn9s+woUJLrVcj
	ZO9dFtZi6uXksoLFfT+O8k6VNWVJYoyabNE7MLEfm1bMdxI6pDLK1f/NL++d79SVsbb2O2PYPM4
	fYds4VQf0ln4JxViFxZIDVC9PKHF/kigM+0kDaWyAgVKxoHTndHj7/I+o=
X-Received: by 2002:a17:902:f550:b0:2cf:9347:f445 with SMTP id d9443c01a7336-2d60185bf48mr227449945ad.10.1787238685837;
        Thu, 20 Aug 2026 08:11:25 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2d62d588035sm8396485ad.23.2026.08.20.08.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 08:11:24 -0700 (PDT)
Message-ID: <bc62bf75-c42b-4e82-8ee2-8604a6241085@ieee.org>
Date: Thu, 20 Aug 2026 10:11:21 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ipa: fix stalled modem TX queue after runtime
 resume
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
 Alex Elder <elder@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Luca Weiss <luca.weiss@fairphone.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260815040302.653650-1-jorijnvdgraaf@catcrafts.net>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20260815040302.653650-1-jorijnvdgraaf@catcrafts.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/26 11:03 PM, Jorijn van der Graaf wrote:
> ipa_start_xmit() unconditionally stops the TX queue before calling
> pm_runtime_get(), relying on the wake scheduled by runtime resume
> (ipa_modem_wake_queue_work()) to restart it once power is ACTIVE.

I'm sorry I didn't respond to this before but I just noticed
it.  I'm going to try to explain how this scenario could happen.
I don't have evidence, so most of this is speculative.  If I
could reproduce the problem I'd be able to confirm it.


To be honest, this analysis is for my own benefit, but if
you have any feedback I'd love to hear it.


Your description indicates that you've observed this problem
on the Fairphone 6; it makes me wonder why we haven't seen
it reported earlier.  You also say it happened "within hours,"
so I presume it is happening during steady state operation,
not during initialization, shutdown, or anything related to a
modem crash.

> But that work is queued from within the runtime resume callback,
> before the device's power state reaches RPM_ACTIVE, so it can run
> while the device is still RPM_RESUMING.  The wake is then consumed
> too early: the transmit it restarts stops the queue again,
> pm_runtime_get() returns -EINPROGRESS without arranging any future
> wake (deferred_resume exists only for RPM_SUSPENDING), and after the
> resume completes nothing is left to wake the queue.  Transmit stalls
> permanently: packets pile up in the qdisc behind the stopped queue,
> the device runtime-suspends, and since the netdev registers no
> ndo_tx_timeout the watchdog never fires.  Observed on SM7635
> (Fairphone 6) as the cellular data path going permanently deaf
> within hours, RX included, since nothing resumes the suspended
> endpoints.
This involves two (maybe three) concurrent execution contexts.

The bottom line is that a synchronous resume ends with the PM
workqueue re-enabling netdev TX, but there is a window of time
after that but before the device is marked RPM_ACTIVE.  If a
TX request arrives within that window, it can disable the queue
again and then find the device is still RPM_RESUMING.  If so,
the TX fails and the queue is left stopped, never to be restarted.

This fix adds a call to pm_runtime_get_sync() *before*
restarting the netdev TX queue to guarantee the device
is RPM_ACTIVE when the next packet is sent.

I don't think the problem occurs if the resume was done
asynchronously (as is done in ipa_start_xmit()).

I'm not sure I like the runtime PM call at this particular
spot (because starting the netdev queue has nothing to do
with hardware), but it gets the job done.



Now I'll provide my expanded analysis.

First, there is a process context that initiates runtime
resume when the state of the device was RPM_SUSPENDED.

I think it's a synchronous resume, because an asynchronous
resume would be carried out by the PM workqueue and I
think that would not exhibit this problem (completing
the resume would be synchronized with enabling the queue,
both happening in the PM workqueue context).

If we ignore startup and shutdown and modem crashes, there
are only two places that get enable power--the transmit
callback and the threaded interrupt handler.

The TX callback (ipa_start_xmit()) uses pm_runtime_get()
(not synchronous).  The interrupt handler (ipa_isr_thread())
uses pm_runtime_get_sync() (synchronous).

--> So I think the first execution context is the
     threaded interrupt handler, which initiates
     rpm_resume() and waits for it to complete.

The IPA runtime_resume callback is ipa_runtime_resume().
That leads to a chain of calls that ends with:

   ipa_runtime_resume()
     ipa_endpoint_resume()
       ipa_modem_resume()
	/* Arrange for the TX queue to be restarted */
	(void)queue_pm_work(&priv->work);

In other words, the interrupt handler thread *schedules*
ipa_modem_wake_queue_work() to be run on the PM workqueue.
Once it schedules that, it returns back to rpm_resume(),
which initiated the IPA rpm_resume callback this way:

         retval = rpm_callback(callback, dev);

The state of the device at the time of this call is
RPM_RESUMING.  *After* this call returns, the state is
updated to RPM_ACTIVE, but these things don't occur
simultaneously.

(interrupt handler thread)
Inside rpm_resume()
IRQ	retval = rpm_callback(callback, dev);
		/* which concludes with: */
IRQ		(void)queue_pm_work(&priv->work);

		/* This is a window! */

IRQ	__update_runtime_status(dev, RPM_ACTIVE);


--> The second execution context is the PM workqueue.

Before this patch, all ipa_modem_wake_queue_work() did was
call netif_wake_queue() to enable transmits again.  That
atomically updates a flag and causes the first queued
transmit (which there must have been one) to be (re)started.

/* This happens as a result of rpm_callback() */
PMWQ	netif_wake_queue(netdev);

At that instant, the IPA transmit callback can called.
I'm not actually sure what in execution context this runs.
Maybe it's the PM workqueue that does this, but it could
also be a distinct third context.  For now, let's assume
it happens in the PM workqueue context.

All inside ipa_start_xmit()
PMWQ	netif_stop_queue(netdev);
PMWQ	ret = pm_runtime_get(dev);
PMWQ	if (ret == -EINPROGRESS) {
PMWQ		pm_runtime_put_noidle(dev);
PMWQ		return NETDEV_TX_BUSY;
PMWQ	}
PMWQ	netif_wake_queue(netdev);


So we have IRQ and PMWQ executing concurrently on different
cores.  One (successful) sequence of events is:

ipa_isr_thread(), via rpm_resume()
IRQ	(void)queue_pm_work(&priv->work);

				ipa_modem_wake_queue_work()
				PMWQ	netif_wake_queue(netdev);

rpm_resume()
IRQ	__update_runtime_status(dev, RPM_ACTIVE);

				ipa_start_xmit()
				PMWQ	ret = pm_runtime_get(dev);
				PMWQ	ret contains 1
				PMWQ	netif_wake_queue(netdev);
				/* Transmitting proceeds */


However another possible order of events could be:

ipa_isr_thread(), via rpm_resume()
IRQ	(void)queue_pm_work(&priv->work); /* to enable transmit */

				ipa_modem_wake_queue_work()
				PMWQ	netif_wake_queue(netdev);

				ipa_start_xmit()
				PMWQ	ret = pm_runtime_get(dev);

				/* Device is not ACTIVE yet! */

rpm_resume()
IRQ	__update_runtime_status(dev, RPM_ACTIVE);
	/* Nothing re-enables transmit any more */

				PMWQ	ret contains -EINPROGRESS
				PMWQ	pm_runtime_put_noidle(dev);
				PMWQ	return NETDEV_TX_BUSY;
				/* Transmitting is disabled */


This seems to explain how it could happen.

					-Alex

> 
> Close the window by making the wake work wait for the resume to
> complete (pm_runtime_get_sync()) before waking the queue.  Every
> queue stop is then guaranteed a later wake that happens while power
> is ACTIVE; a transmit racing a new suspend/resume cycle re-schedules
> the work.  If the device could not be resumed, wake the queue anyway
> so pending packets are dropped by the transmit path rather than
> stranded.
> 
> The STARTED power flag used to narrow this window: a wake running
> before the transmit path's stop suppressed that stop, but only once,
> as the flag was cleared by the first stop it absorbed.  Removing the
> flag made a single transmit during an in-flight resume sufficient to
> strand the queue, which is the form observed.
> 
> With an accelerated reproducer (autosuspend delay shortened to 5 ms,
> ~20 packets/s of TX), an unpatched kernel stalled three times in
> 230 s / 4380 packets; with this patch the same test ran 3601 s /
> 70298 packets without a stall.
> 
> Fixes: 688de12f080f ("net: ipa: kill the STARTED IPA power flag")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
> ---
> 
> Runtime testing was done on a v7.1.2-based device kernel carrying
> this same change, on a drivers/net/ipa/ipa_modem.c otherwise identical
> to this tree's; the patch as posted was build-tested on net at the
> base commit.
> 
>   drivers/net/ipa/ipa_modem.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ipa/ipa_modem.c b/drivers/net/ipa/ipa_modem.c
> index 9b136f6b8b4a..d84c1dbd3b1a 100644
> --- a/drivers/net/ipa/ipa_modem.c
> +++ b/drivers/net/ipa/ipa_modem.c
> @@ -266,13 +266,29 @@ void ipa_modem_suspend(struct net_device *netdev)
>    * the modem.  We can't enable the queue directly in ipa_modem_resume()
>    * because transmits restart the instant the queue is awakened; but the
>    * device power state won't be ACTIVE until *after* ipa_modem_resume()
> - * returns.
> + * returns.  A transmit restarted before that would stop the queue
> + * again and get -EINPROGRESS from pm_runtime_get(), and with this
> + * work having already run, nothing would ever wake the queue again.
> + * So wait for the resume to complete before waking the queue.
>    */
>   static void ipa_modem_wake_queue_work(struct work_struct *work)
>   {
>   	struct ipa_priv *priv = container_of(work, struct ipa_priv, work);
> +	struct device *dev = priv->ipa->dev;
> +	int ret;
> +
> +	ret = pm_runtime_get_sync(dev);

You could catch this problem with this:

         WARN_ON(!pm_runtime_active(dev));

>   
> +	/* Wake the queue even if the device could not be resumed, so
> +	 * that pending packets are dropped by the transmit path rather
> +	 * than stranded behind a stopped queue.
> +	 */
>   	netif_wake_queue(priv->tx->netdev);
> +
> +	if (ret < 0)
> +		pm_runtime_put_noidle(dev);
> +	else
> +		(void)pm_runtime_put_autosuspend(dev);
>   }
>   
>   /** ipa_modem_resume() - resume callback for runtime_pm
> 
> base-commit: 24ef02f934eeb48830cff6b739abc3c62b1d107b

