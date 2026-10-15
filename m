Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4CA547063;
	Thu, 15 Oct 2026 01:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792026281; cv=pass; b=ieUQ+OluMWLiqev5DK4wF/70HQTxUIA9nftYmKx2iT5/V6m6tF6aSMgs5UI+B1oumpf37QKE9DpTj2fJoITbFPvIjvz5vxUbVDIxp55HdyEWGFQ4CQQJiR4UrQxQVPMYkIGZOILc9QwJQzQxR8m9jPWAx5Hm2ScX3oothKB5L8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792026281; c=relaxed/simple;
	bh=J0e48rTlX5xzfVB8Q0+OjQXlE7Rollz2ymO3DxF+POA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=k1100A2wrTXuLDyy1RFgfoOXUbYFisdx8/CncCCGrQq5sLlWcSK65K3dBkAlR+eR08KayZmZtQlbym5Qn+vDoorU9UYg73MTTRYC4Xful3EVNea8+ZjwkokpAqtxykHr5YWrxeLkAXQ/O8dvmJamu4BFendP7ApmhAZxC11/32E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=au5hYeaV; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="au5hYeaV"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 02587201ADE;
	Thu, 15 Oct 2026 03:04:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792026276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1X0wDPMw5GFlyxWEgvZigVsNGJdbba31Yx2KhI4XVWg=;
	b=au5hYeaVU2bxMrLoT2uv9v/Qhw4voMOS5fijXuyyDQ8CwT7A4gbu9NfgukAncArsKdGdbE
	0gc2XkJSOF+V3p4RkctX/O+XplseCcNP3TMsERA+meCQdIWFNJqK564o4d28o4g6oHAtHs
	6rh+E9ao0PFDSNm2flMbuX3jjcYo1Aqs2ctPfrpxig6iTV6h8BZWxb/m7asexb1NtoiD98
	yHI88F7MZxYstxsD6mDQlr/ODoVTtKi8gCO+CyxM+NVUWwwsDVk9BEF/+ll+b1C96sCUhW
	gJDHViG/DywBdXzM4AHrG+7xD7NCd1dNgpOtZ9tiiL/GexGSs2FfLBMo0aMUfw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792026276; a=rsa-sha256;
	cv=none;
	b=NNjr0kACDwbkLobX1S7V/n2Zqw+WnbWIRtr0Ru6NBg7s1uwNwpAeYUm1BHC3KPkp5xlTt2
	uVIeFmjAmWX1XKATfWy16ieiy8ri9qXJiEXBC87ZitBkUv4z+vbN6IlUTvlZPvNAkdYUCT
	VeuqUFFfVAR2lUZDmd9sHtNd/RYmAymjnAqy+vdeCy80hdfWgRM4m+G+/16p+L9co7xRrA
	mzU7WcMiXBdMwlFG5sSBTTIlHKqpUdHXSViCOLUA519EeXcMk/5LoE4awZLV39bQRq9gEV
	aZrmgtQlZhkufbKMKkQgpm3fCKvQzsSOv91j2pYzJdu6k4XU4c2bDgNkOCIJUg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792026276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1X0wDPMw5GFlyxWEgvZigVsNGJdbba31Yx2KhI4XVWg=;
	b=X9AkOuSiEQe9Sq6fCh9Ufiw7SquzUlzsaFxEHGD8qSnWY67Hl9hh2tQpzZZtBGAtXweUDS
	icEclLfOhg/s9lXy5dMI34ihHRFgDREGoerg536h71kZMndHruxKYBbjO3BSqb6ykQczsD
	QblMmA2eISLZ0azf9i73CxxmrZWhtSELkrtht6SMC1NSOMFA3f057lTAaxYTl3Y52s9DX5
	rAc0ieo5MOXi4Zfvw61MxDoBimrgYnH3/cj9ujsH0pAjMv/TRdhPAczmzwvPh/QTeHTEMu
	poXql4ae9stNRB29aaWI3wkITftEJqIIl1ffYkRwxRlSfkPwk51UK3orUA3R1g==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xH9tb-005wVs-2w;
	Thu, 15 Oct 2026 03:04:35 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A04CB5C46F9;
	Thu, 15 Oct 2026 01:04:35 +0000 (UTC)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] can: usb: f81604: fix use-after-free on disconnect
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260901-f81604-fix-v1-1-c55b5178f9f8@fintek.com.tw>
References: <20260901-f81604-fix-v1-1-c55b5178f9f8@fintek.com.tw>
Date: Thu, 15 Oct 2026 03:04:30 +0200
Message-Id: <179202627096.802272.4218846714860230097.b4-review@b4>
X-Mailer: b4 0.17-dev-6be7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=7959; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=J0e48rTlX5xzfVB8Q0+OjQXlE7Rollz2ymO3DxF+POA=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi6oLZAfav0PlvJyQvTTTM/ee2dfYDn0Y1ovjDBSdPLF
 /898SjjckcpC4MYF4OsmCLL0h8nFAUCHUp7XyZMgpnDygQyhIGLUwAm4rCH4a/cEo67CRIvDOyE
 eA172+s+n9/JP+O4LVufa+s0d8M1AckM/4uXX1z7o5d9PsPME39OPZ0ntEzX5p0+e3TK5k8/o+Q
 rGLkB
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

> Unregister the URBs before cancelling clear_reg_work to prevent an URB
> completion handler from scheduling work after cancel_work_sync() has
> returned.
>
> Otherwise the pending work may run after the netdev and private data are
> freed, resulting in a use-after-free.
>
> Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Closes: https://lore.kernel.org/all/20260824133009.CF85A1F00A3A@smtp.kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>

There was some more review feedback from the netdev sashiko, can you
take care of them?

regards,
Marc

pw-bot: cr

--- Patch [29]: [PATCH net-next 29/37] can: f81604: f81604_close(): fix use-after-free on disconnect ---
commit b7c039b44e69e7dd0760d88f656535fd56000877
Author: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>

can: f81604: f81604_close(): fix use-after-free on disconnect

This commit moves cancel_work_sync(&priv->clear_reg_work) in f81604_close()
to after f81604_unregister_urbs(). After that change, an URB completion
handler can no longer schedule clear_reg_work once the cancel has returned.
The goal is to stop the work from running after the netdev and private data
are freed.

Closes: https://lore.kernel.org/all/20260824133009.CF85A1F00A3A@smtp.kernel.org/
Link: https://patch.msgid.link/20260901-f81604-fix-v1-1-c55b5178f9f8@fintek.com.tw

> Cc: stable@vger.kernel.org

Discovered by: gpt-6-astra, opus-5-5 · Missed by: sashiko-gemini
This isn't a bug, but should this have a Fixes: tag next to the stable Cc?
The teardown order in f81604_close() looks unchanged since the driver was
added, so the tag would be:

Fixes: 88da17436973 ("can: usb: f81604: add Fintek F81604 support")

> diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
> index 4c147b9d6d690..bb155b8769245 100644
> --- a/drivers/net/can/usb/f81604.c
> +++ b/drivers/net/can/usb/f81604.c
> @@ -1075,10 +1075,10 @@ static int f81604_close(struct net_device *netdev)
>  	f81604_set_reset_mode(priv);

Discovered by: opus-5-5 · Missed by: gpt-6-astra, sashiko-gemini · Confirmed by: gpt-6-astra · Ranked High by: gpt-6-astra
This is a pre-existing issue, but can a bus-off restart running at the same
time undo this reset? can_restart_work()->can_restart() does not take RTNL.
The restart_work timer could fire while f81604_set_reset_mode() is doing
its control transfers:

can_restart()
  f81604_set_mode(CAN_MODE_START)
    f81604_start()
      f81604_set_normal_mode()
        clears MOD.RM, writes IER = IRQ_ALL & ~RI

In that case, cancel_delayed_work_sync() in close_candev() only waits for
the restart to finish. f81604_unregister_urbs() then kills the URBs the
restart submitted, but nothing puts the chip back into reset mode.

Would ndo_stop then return with the SJA1000 core still in operating mode on
the bus while the netdev is down?

>
>  	netif_stop_queue(netdev);
> -	cancel_work_sync(&priv->clear_reg_work);
>  	close_candev(netdev);

Discovered by: opus-5-5 · Missed by: gpt-6-astra, sashiko-gemini · Confirmed by: gpt-6-astra · Ranked Critical by: gpt-6-astra
This reorders clear_reg_work, but doesn't restart_work have the same
problem? close_candev() runs cancel_delayed_work_sync(&priv->restart_work)
here, but the int URB stays live until f81604_unregister_urbs() below.

Suppose an int URB completes in that window with F81604_SJA1000_IRQ_EI and
SR.BS set. f81604_handle_can_bus_errors() then does:

	if (data->sr & F81604_SJA1000_SR_BS)
		can_state = CAN_STATE_BUS_OFF;
	...
		if (can_state == CAN_STATE_BUS_OFF)
			can_bus_off(netdev);

If restart_ms is set, can_bus_off() re-arms the work:

	if (priv->restart_ms)
		schedule_delayed_work(&priv->restart_work,
				      msecs_to_jiffies(priv->restart_ms));

The interrupt report could be a buffered or in-flight one, or come from a
malicious device. It can also arrive if the IER-off write in
f81604_set_reset_mode() failed, because f81604_close() ignores its return
value.

Nothing cancels restart_work after that. When it fires,
can_restart()->f81604_set_mode()->f81604_start() puts the chip back into
normal mode, resubmits the URBs and wakes the queue on an interface that is
down.

If the device is unplugged before restart_ms expires,
f81604_disconnect()->unregister_netdev() skips ndo_stop because the device
is already down. free_candev() then frees can_priv while the restart_work
timer is still armed.

Would it be better to call f81604_unregister_urbs() before close_candev(),
as gs_usb and peak_usb do?

Discovered by: opus-5-5 · Missed by: gpt-6-astra, sashiko-gemini · Confirmed by: gpt-6-astra · Ranked Critical by: gpt-6-astra
This is a pre-existing issue, but can close_candev()->can_flush_echo_skb()
race here with URB completions that use priv->echo_skb[0]?

The int URB is only killed later, by f81604_unregister_urbs(). The TX URBs
from f81604_start_xmit() are never anchored, so they are never killed or
waited for:

f81604_start_xmit()
	can_put_echo_skb(skb, netdev, 0, 0);

	ret = usb_submit_urb(write_urb, GFP_ATOMIC);

can_flush_echo_skb() checks and frees echo_skb[i] without a lock.
f81604_handle_tx() does the same through can_get_echo_skb() and
can_free_echo_skb(). f81604_write_bulk_callback() does it through
can_free_echo_skb() on error statuses. Both run in completion context.

If both sides see a non-NULL echo_skb[0], could the skb be freed twice? Or
could __can_get_echo_skb() read it after the flush has freed it?

Killing all URBs, including TX, before close_candev() looks like it would
avoid this.

>
>  	f81604_unregister_urbs(priv);
> +	cancel_work_sync(&priv->clear_reg_work);

Discovered by: gpt-6-astra, opus-5-5 · Missed by: sashiko-gemini · Ranked Critical by: gpt-6-astra
This covers ndo_stop, but can clear_reg_work still be left pending after a
failed open? In f81604_start(), the URBs are already live when
f81604_set_normal_mode() runs:

	ret = f81604_register_urbs(priv);
	if (ret)
		return ret;

	ret = f81604_set_normal_mode(priv);
	if (ret) {
		f81604_unregister_urbs(priv);
		return ret;
	}

The int URB may complete with error bits in isrc during
f81604_set_normal_mode(). If so, f81604_handle_can_bus_errors() calls
schedule_work(&priv->clear_reg_work).

If f81604_set_normal_mode() then fails (for example -ENODEV during
hot-unplug), the error path kills the URBs but does not cancel the work.
f81604_open() then only calls close_candev().

Since the open failed, IFF_UP is never set, so on disconnect:

f81604_disconnect()
  unregister_netdev()
    netif_close_many() skips ndo_stop for devices without IFF_UP
  free_candev()
    frees the netdev and the embedded f81604_port_priv

Could f81604_clear_reg_work() then run on the freed priv?

Would adding cancel_work_sync() to the f81604_start() error path, or
calling it unconditionally in f81604_disconnect() before free_candev(),
cover this case?

Discovered by: opus-5-5 · Missed by: gpt-6-astra, sashiko-gemini · Confirmed by: gpt-6-astra
This is a pre-existing issue, but does each bus-off restart submit another
set of URBs on top of the ones already running?

can_restart()->f81604_set_mode() calls f81604_start(). f81604_start() then
calls f81604_register_urbs() without calling f81604_unregister_urbs()
first. The completion callbacks resubmit on success, so nothing kills the
open-time URBs at bus-off.

Each restart would then leave another F81604_MAX_RX_URBS bulk URBs plus an
int URB in flight, with their buffers, until ndo_stop.

Also, if f81604_set_normal_mode() fails during a restart, the error path
calls f81604_unregister_urbs(), which kills every anchored URB, including
the open-time set. Would the interface then stay up with no RX or int URBs
until the next down/up?

-- 
Marc Kleine-Budde <mkl@pengutronix.de>
