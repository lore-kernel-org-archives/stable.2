Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC79D1DF248;
	Thu, 15 Oct 2026 01:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792027776; cv=pass; b=IhIxFQwKrmHqxCC5OU+cFdsR96FFik+c3dShVB141BO32DcatV3VoMClbpA7F6VpdyVoR+CjEADzkg42k0fH3u/03VRyRqn/lu2X521AUsj8I5nx60pvHiNrpiruO3U9IjA6EKfrH2MTKEFGGhw+hX8LkTi7fd0PuqvlXXtSXrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792027776; c=relaxed/simple;
	bh=AznHk9NO/TWdj2HDEpjcm/Ra2Io3M7fEQvNFSHJRAoU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=DOItbdJRW6HT/3/mPFZ11SXPsQSa/OcXcyL20TWJfp4kMNKOFh8uqJQpdYYOheNzf7fR2OdQfYZF6vBwpoRVT86CuvJYCI7mKYOZVFoykI/Lh9I9hIk3l+ecoBIvFMf19cMW+z1PppVTzaOw/Gu70FPgAEj5djXRd94fSrqsLWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Lno3Y3c/; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Lno3Y3c/"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id CEE8C201B55;
	Thu, 15 Oct 2026 03:29:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792027770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VRDZ9XrVPNAFrk+//bZJV2l1FMzvd4V7UG7api333FU=;
	b=Lno3Y3c/1Ivp6H/nX9HlrMQzxK4EKGyJpbAQ7dk2EabpZu9Shakv0ndWL+QEuZ8rqgUI89
	k7LeZYM2JdEik2yWmknZcM//yP4fx4h1x6LPl1xNuwZijdKCXuG3y+g60bgs860R3FTj+a
	ANHrgHPItYH1hqZwrckuSX2T6stanPmYsNQWUgmLQcRNST5LQMGXs1TRwGlbTYLaLIQlmm
	ZVGFd0n+r0twF/XWGis/yPCQWPTrpMUivs3RzTYciA0EuX1an71dfDU0QbpLV2xmfUeSR6
	4CKZ8BNzo4wzXq2FkPedjqYp+/+XIpuDR8sKipScHuL+CCSEg/vRqB9mJB/1OA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792027770; a=rsa-sha256;
	cv=none;
	b=bCwN6CdqQUboLW0ucYmIIiO5C1bbYp3mUa7AcIdmblREWY6sGlpI9pHb4lgqO+Fmp1hARY
	Mx3W2F28mQJuVIypP5u2LfMzp2QZJMJidFmvpZYFcdnKedtJhqaxoZ3xk5udKwKOa5ix2i
	5H97fAXfxCNVXLsibCe1/UOaJUQ4wDZX/cxJWbiz3wJ4FufHTC6YqjIkHA3wDvgHWuMNIl
	rmNVynkc3EUQ3ZBxcrWsZhO8xZkdOrIS6zGVql7PW5hwT8rcrzKKgY2Th0Fop/IMQtWirU
	N7NawvBWfmilt3638AluNDXwLY9giGeL4ix1lB9A5xZpqOfgPYAvw9e/l4I+mw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792027770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VRDZ9XrVPNAFrk+//bZJV2l1FMzvd4V7UG7api333FU=;
	b=OAy9BJoY5807CGWmtlzrRngP60EIGZ6rCRWcV19aGGFEnxZTjMoxT7yTnt2RUWp13GSfV9
	JvN7Dr+TjSjyuFXHXKLyGZheQP/S/K/ZXvhLqKaos9HqA26vg1SpE43fFrEPYejYnqSV2k
	0AeQW2OZBVQTiRp+/DatheSPRlL79BqbntkmY5HtIJhxuizweG/EhRct/JYxIU5u/IbF5E
	/YwRIwMRZCqYWCv9lMP4QjNoQfFc7cRNqtlb2tQnsxJAILJMMILBX2P6+SBCdUk3yHcr6o
	TfzKG2Sa0zs4sGKHeRawHwPwnPKCvo5uc4hd+mpfybtjFcCQSLUKs6IoT4hB1g==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAHi-005wje-2O;
	Thu, 15 Oct 2026 03:29:30 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 752545C4705;
	Thu, 15 Oct 2026 01:29:30 +0000 (UTC)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] can: hi311x: drop hi3110_lock before free_irq() on
 open failure
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Jianhao Xu <jianhao.xu@seu.edu.cn>
In-Reply-To: <20260820020631.316418-1-runyu.xiao@seu.edu.cn>
References: <20260820020631.316418-1-runyu.xiao@seu.edu.cn>
Date: Thu, 15 Oct 2026 03:29:23 +0200
Message-Id: <179202776309.806124.17660228547499507194.b4-review@b4>
X-Mailer: b4 0.17-dev-6be7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=5908; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=AznHk9NO/TWdj2HDEpjcm/Ra2Io3M7fEQvNFSHJRAoU=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi6oFMuFsoRXS5Tp/lS9d+eBkPbj0wKEjffMnpKJt6IV
 5RX6rnaUcrCIMbFICumyLL0xwlFgUCH0t6XCZNg5rAygQxh4OIUgInEbGT4p/+IaUfy9e7Zamc/
 9Fvt7+S2U687/upH0w/mycH7ZM+dSmBkOPL0jsRkZwPFs5w+TG/Vot/eXBsyiTubI3D64Yj+Tz/
 28AIA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

> hi3110_open() requests a threaded IRQ and then performs hardware
> setup while holding priv->hi3110_lock. If reset, setup, or
> normal-mode entry fails, the error path calls free_irq() while still
> holding that mutex.
>
> The threaded handler takes priv->hi3110_lock before checking
> force_quit, while free_irq() waits for the threaded handler to finish.
> That can deadlock the open() rollback path against a pending IRQ
> thread.
>
> Set force_quit, drop hi3110_lock before free_irq(), and take the
> mutex again for the remaining hardware cleanup.
>
> Fixes: 57e83fb9b746 ("can: hi311x: Add Holt HI-311x CAN driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

The netdev LLM bot has found some new issues with this patch, can you
take care of them?

regards,
Marc

--- Patch [30]: [PATCH net-next 30/37] can: hi311x: drop hi3110_lock before free_irq() on open failure ---
commit 67dd4c372c8d870201d8692df57226dc8aab950d
Author: Runyu Xiao <runyu.xiao@seu.edu.cn>

can: hi311x: drop hi3110_lock before free_irq() on open failure

This patch changes the hi3110_open() error path. It now sets force_quit
and drops hi3110_lock before calling free_irq(), then takes the mutex
again for the remaining hardware cleanup. This avoids a deadlock against
the threaded IRQ handler, which takes hi3110_lock before it checks
force_quit.

Link: https://patch.msgid.link/20260820020631.316418-1-runyu.xiao@seu.edu.cn

> diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
> index 076a3efa1bfff..927555b5d581e 100644
> --- a/drivers/net/can/spi/hi311x.c
> +++ b/drivers/net/can/spi/hi311x.c
> @@ -787,7 +787,10 @@ static int hi3110_open(struct net_device *net)
>  	return 0;
>
>   out_free_irq:
> +	priv->force_quit = 1;
> +	mutex_unlock(&priv->hi3110_lock);
>  	free_irq(spi->irq, priv);

Discovered by: gpt-6-astra · Missed by: opus-5-5, sashiko-gemini · Confirmed by: opus-5-5 · Ranked High by: gpt-6-astra
Can this rollback turn the old deadlock into an IRQ storm when
hi3110_set_normal_mode() fails?

The IRQ is requested with IRQF_ONESHOT | IRQF_TRIGGER_HIGH. Before
hi3110_set_normal_mode() returns -EBUSY, it has already armed the chip:

drivers/net/can/spi/hi311x.c:hi3110_set_normal_mode() {
    hi3110_write(spi, HI3110_WRITE_INTE, HI3110_INT_BUSERR |
                 HI3110_INT_RXFIFO | HI3110_INT_TXCPLT);
    hi3110_write(spi, HI3110_WRITE_CTRL1, HI3110_CTRL1_TXEN);
    ...
    hi3110_write(spi, HI3110_WRITE_CTRL0, reg);
    mdelay(HI3110_OST_DELAY_MS);
    reg = hi3110_read(spi, HI3110_READ_CTRL0);
    if ((reg & HI3110_CTRL0_MODE_MASK) != reg)
        return -EBUSY;
    ...
}

A received frame or a bus error during the mdelay() window can assert
INT. Once force_quit is set, hi3110_can_ist() skips the whole
while (!priv->force_quit) loop. It never reads STATF, the FIFO or INTF,
but it still returns IRQ_HANDLED.

irq_finalize_oneshot() then unmasks the line, which is still asserted.
The interrupt fires again right away, so the SCHED_FIFO IRQ thread spins
until free_irq() finally shuts the line down.

If the IRQ thread was blocked on hi3110_lock, the new mutex_unlock()
wakes it. On the same CPU (always the case on UP), it can preempt the
opener, which holds RTNL, before the opener reaches free_irq().

The opener then only runs again through RT throttling or the fair
dl_server. That bounds the stall to about one RT period by default, but
the stall can be indefinite if those safeguards are disabled.

Would it be better to quiet the chip while still holding the mutex,
before force_quit is set and the lock is dropped? That could mirror
what hi3110_stop() does:

    hi3110_write(spi, HI3110_WRITE_CTRL1, 0x0);
    hi3110_write(spi, HI3110_WRITE_INTE, 0x0);
    hi3110_read(spi, HI3110_READ_INTF);

Another option is calling disable_irq_nosync() before mutex_unlock().

hi3110_stop() already uses the same force_quit then free_irq() ordering
while INTE is still enabled, so the same hazard exists there. In the
open() rollback path, though, it is new with this patch.

> +	mutex_lock(&priv->hi3110_lock);
>  	hi3110_hw_sleep(spi);
>   out_close:
>  	hi3110_power_enable(priv->transceiver, 0);

Discovered by: gpt-6-astra · Missed by: opus-5-5, sashiko-gemini · Confirmed by: opus-5-5 · Called a false positive by: gpt-6-astra
This is a pre-existing issue that this patch did not introduce, but is
priv->restart_work ever cancelled or flushed on shutdown?

hi3110_do_set_mode() queues it for CAN_MODE_START:

drivers/net/can/spi/hi311x.c:hi3110_do_set_mode() {
    ...
    priv->restart_tx = 1;
    if (priv->can.restart_ms == 0)
        priv->after_suspend = HI3110_AFTER_SUSPEND_RESTART;
    queue_work(priv->wq, &priv->restart_work);
    ...
}

hi3110_stop() calls close_candev(), which only cancels the CAN core's
delayed restart_work. It never calls
cancel_work_sync(&priv->restart_work), and neither does the hi3110_open()
rollback.

If the work is still pending at ifdown or during a failed open(),
hi3110_restart_work_handler() can run after cleanup. It takes
hi3110_lock and calls hi3110_hw_reset(), hi3110_setup() and
hi3110_set_normal_mode(), which re-arms INTE, TXEN and normal mode. It
then clears force_quit and calls netif_wake_queue() on the downed
interface.

The controller would then be back on the bus while the interface is
administratively down.

The new unlocked window around free_irq() in hi3110_open() gives the
worker one more place to run. It does not seem to make things worse than
the existing post-stop case, because free_irq() still completes and the
rollback then calls hi3110_hw_sleep().

There is no use-after-free here, because hi3110_can_remove() runs
destroy_workqueue() before free_candev().

-- 
Marc Kleine-Budde <mkl@pengutronix.de>
