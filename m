Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794199758;
	b=DWjfHO9g8rjRtuB1kuJTQeBcxygP/6ARYloP2S4yItvT+faKOhrWq6k0H0uE9DSzQqgM
	 1Uv02kPjht005an/hhyRGTZt1OZ6MYmw/gXcJq12JxY8UZMHHX+8cgQoclaJn3ldjT7nV
	 sTL0ZIz90OWknzEIH7+s0T/8WliBtGnMGYvS02kg38Z3FA4NVlY6klrvAzkqZ6XWL/ZCd
	 n8ahr6SuGCcMxYgg4VJuuPKJgfdKe4/PnGbUpE0L19opnw/I/6jtyOgwC6EIHzHf7v/pS
	 rAeQHD7Q5+nMSGVCWVjbmo2vFNyq2/8cH6vrHI5AFB7wjhtBYmzl7it3AyOjD2vDYFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794199758;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6qh+M+jpnQ8dORj/K5TuZQk/eepHuhg+WvLWRiWifFg=;
	b=zEFTPVAwIm8mkOZdquCTNARoc0iSlF5XzsTYVzPZlBxK6xvcMY4pKVOppGRgukjOOY7k
	 fV7CfPyyiSw9d1Ve9W4VRdOe52vQArwTuR3B/3nha+QjFKXCXNfpiErN0w64DKjvsiBnu
	 kQld7rWETbpQfmGxD6P8JOh9TV384XM0ABGNwXYKKxTnOEpGseEJhu4J/XBqezv8yTrl0
	 k9fSuy8uANknkVVFnEDcbHeSWesWUxaWdBpHBjoVK0Q5vgWs5uwBSiBBAWgvDe4Dgyz2R
	 23Vbi+BQE0tpitaBmQ24bfXWMGjB3TA8PPimCcknsbltFa4KEY9zF5ZDp4OObIa8x3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WIFEAlZP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF77606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 04:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DF77606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WIFEAlZP
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91eda36322fso1682356d6.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 20:49:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794199757; cv=none;
        d=google.com; s=arc-20260327;
        b=KcxBPI6tkYz4x+DhUXWWmC9iErW89bjujWDe3gbot9f/zI/To7w+92YQq4IiBpo/Ao
         FlA5W3IoBdd7ByPGP8CYBw3SERk9/vj3O+40DVo5B+MiHyXqCJFRiUSbSIevt1Yqynya
         rUDCCQwLwtMgn6hEkAkylNalMXhWIItZr0DQJMa1IB03q7M8xAphhE/XZPlzFIkzxnbp
         KoVVUWRnxykVy3pRKIBi4GSLXQOMhDaad9SoqtmqNggOi+WULa1Z3LPQcBJ7pzNvqWjp
         Htcw0ZdxVNHAKOdjaOmC3He8U8wpjTL4wuBeP7jhV7KK+BdC8fE2FE6lonnjqN+7EoSJ
         5qnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6qh+M+jpnQ8dORj/K5TuZQk/eepHuhg+WvLWRiWifFg=;
        fh=ebHfIQ1mUed+gKB9j84ws37OKql9hp8vcupUrhQj928=;
        b=MHdF1WFhYQLD8RCa2GScwSHLgkNlPgf5ea/rLbQkKyBKwlgZwCZ/KSkikrxsk4wB/z
         rZ+UH6h4VkM6oHT03cQFRbD94RL5QQ5o8Nb06rOYsy4E9wa5sVTRFpHQPqrWaQe62EME
         3xCdrb1lgHb94fF0LrYiMrYz40yec0MTIQWSgEAhqS1cXhlww7GTu8eTTczboC8Wq7ZR
         kqyVsy4rNPMrE9WkuzJNatw7o2vg/eASewjd4MUjld9IQGdY2JScfV/RpWjYUrx92Pdy
         y7pqUVMcrbm9AGmX5mqGav9+3f7v2sdwjKBKsXS1/j5YqskglNiWoHCir/vCD6zEHl+i
         Xsnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794199757; x=1794804557; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6qh+M+jpnQ8dORj/K5TuZQk/eepHuhg+WvLWRiWifFg=;
        b=WIFEAlZPT/yB5Oz5a2tIOkfYfS6W5IeyYoDv/9rrBzcnsfeHM1v522q0gatejSDQ3J
         3ihvBCncpCxtNWrwjOWgx7cWE/3Pf0Yg9TPN38UVzTlhHeAO/WGn8lxG7Z2v74iOt3da
         jYs828J42md7Osr6k+KZ9Tqt2W+93vdsPS8MSBaLrqrlpaXVmMd6M1PyJ3Y4IIiC0e+G
         sj82Mp9XQIJEYV8iaii5vBNwu3wb4XmNrxP77qgfjEa+KEqyI4cz2AIAzMg/MLPIljqJ
         SwfnU1sIpZKlvyXqbAmFik18qlLRYQNP2yv7v+lhSD8cSQc0qSrlnztcHfNUj9RHaiK8
         E6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794199757; x=1794804557;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6qh+M+jpnQ8dORj/K5TuZQk/eepHuhg+WvLWRiWifFg=;
        b=HegNPbf4UqSL0zSzi9e8IuiVKvzMAPWiSav8dGSpKfcRJXHK23rVo+874t3E6a0lIl
         g0xOHv8j+Wu8DUKF9oMB0KHe5zhcXQbHruv5dKM0jcKANXjARx6mSjGwJquxSf8Ys+Ud
         DaZoedtkJ01/9naFFklc4ebfkHtVruRnWH4f4i8K6+v+hoz3+gCjs+0/8wbhsBBP/8tN
         q0pbY1bmrEctqQbR0/m7MKW1j5xLYZF5f7mL84h22+thDGtYd6q9dteRCH19/GsIeGyG
         TVdTbjtGCdgbz5ug/8CmTc4HrbQWvOVCFFOoCXpBJJIUbPQCd2aMfAB68IQTVBMWHsg2
         Y6Ng==
X-Forwarded-Encrypted: i=1; AL+hErF2ZLoI7q2BkJ6M6+dKaykiGDsLA1d+9qax+Pe7gSVzdOIEDjNJk2lqyAxa+4wrDHUT70HHEqs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9MGzeu9lesD/EBukXlAnqq8q+I4Nr2wVR1gNCZz/V5dehtWVwk
	S+HmBP4lhMt2JQH6JCHvLoQcKkJWAB1nyeb4ffw4gEd4eJcU40/TCasV2XmXU8uAcPC6cpcnwIx
	HenmsDVqsDaH1+fKJPsLKnekURslgR9A=
X-Gm-Gg: AYBFou3NrtLGBhsneDsRwYP6ljogOBqdibkaK5vVL2X4fA30TAm+SXrqjRHNsPl+kP5
	o3E5G0SFsqiWTgukxbe0L06UMf4y/Ke1YO0/KSRRe7a0v6R3jJlbrW67i87mEfZ9Q/8w4Fx/Wk1
	jyxs32rV8hGRSSQB5mHIFj/WlyCiGUFnqZlJY1hjD6M0FOOkqhSzv2/Pm1QHI9+zbP+qhZoLW6b
	gFq8CVGIQvz73qAzk5X8d01ABf4Cw8HcJW//3YMQxxlpM+UV88cxfthU3Nn/tw518NNF4VhhRMw
	p4Awc3bVB9ANBtb4LItKJoS4ajkz6zL5E1yuSXwFrqh0cqIAjoUekZEN2LUU0HKweReE029PNwV
	hZRS7NnIxOlu1KL82PlbtjxmkdLLQXm2X2q+zIT+qMBNjZp9Ith6ZAmvZNyEhtUz4sLiP
X-Received: by 2002:ac8:59c9:0:b0:536:5e62:4647 with SMTP id
 d75a77b69052e-552a52a25a0mr46615241cf.16.1794199756941; Sun, 08 Nov 2026
 20:49:16 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107153319.3765325-1-hj351016@gmail.com> <179419829985.488853.2152109703584398675@kernel.org>
In-Reply-To: <179419829985.488853.2152109703584398675@kernel.org>
From: khj <hj351016@gmail.com>
Date: Mon, 9 Nov 2026 13:49:03 +0900
X-Gm-Features: AclHuK-ZD80kt-WbLxM6rTpYAny7wg66JVAuYp8w4OhVnAdIniUpTeJKn11a9DI
Message-ID: <CAGr5VtPvsfPW+1_eQmQJ0G9f-=1XskuA+vHdUHSeZpY55prnQw@mail.gmail.com>
Subject: Re: [PATCH] can: peak_usb: pcan_usb: cancel restart timer on stop to
 avoid use-after-free
To: netdev-bot+sashiko@kernel.org
Cc: mkl@pengutronix.de, linux-can@vger.kernel.org, mailhol.vincent@wanadoo.fr, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks -- this is correct. v1's dev_stop + timer_delete_sync does not
cover the re-arm: restart_timer is armed from the restart-command URB
completion (pcan_usb_restart_pending),
which is not anchored and can run after the delete, and neither
disconnect nor the adap_dev_free probe-error path calls dev_stop at
all.

v2 drops the dev_stop approach and adds a pcan_usb .dev_free that
timer_shutdown_sync()s restart_timer. dev_free() runs after
unregister_candev() and before free_candev(),
and shutdown (unlike delete) also prevents a late URB completion from
re-arming the timer. Respinning as a new thread.

pw-bot: cr

2026=EB=85=84 11=EC=9B=94 9=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 1:25, <=
netdev-bot+sashiko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The fix leaves the use-after-free reachable, because
>   restart_timer can be armed again after pcan_usb_stop() has deleted it.
>
> --
>
> can: peak_usb: pcan_usb: cancel restart timer on stop to avoid use-after-=
free
>
> This adds a dev_stop callback to the PCAN-USB adapter. The callback calls
> timer_delete_sync() on pdev->restart_timer, so the timer is drained in
> peak_usb_ndo_stop(). The aim is to stop pcan_usb_restart() from running
> on a freed struct pcan_usb after free_candev().
>
> > diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/=
usb/peak_usb/pcan_usb.c
> > index 8fd058c328564..4c131958b5aa6 100644
> > --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> > +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> > @@ -882,6 +882,14 @@ static int pcan_usb_start(struct peak_usb_device *=
dev)
> >       return pcan_usb_set_ext_vcc(dev, 0);
> >  }
> >
> > +static int pcan_usb_stop(struct peak_usb_device *dev)
> > +{
> > +     struct pcan_usb *pdev =3D container_of(dev, struct pcan_usb, dev)=
;
> > +
> > +     timer_delete_sync(&pdev->restart_timer);
>
> [Severity: High]
> Can restart_timer be armed again after this delete?
>
> The timer is armed by the restart URB completion, not by the timer
> callback. The completion calls mod_timer() every time and never checks
> urb->status:
>
> drivers/net/can/usb/peak_usb/pcan_usb.c:pcan_usb_restart_pending() {
>         ...
>         mod_timer(&pdev->restart_timer,
>                         jiffies + msecs_to_jiffies(PCAN_USB_STARTUP_TIMEO=
UT));
>         ...
> }
>
> pcan_usb_restart_async() submits that URB without anchoring it to
> dev->rx_submitted or dev->tx_submitted:
>
>         usb_fill_bulk_urb(urb, dev->udev,
>                         usb_sndbulkpipe(dev->udev, PCAN_USB_EP_CMDOUT),
>                         buf, PCAN_USB_CMD_LEN,
>                         pcan_usb_restart_pending, pdev);
>
>         return usb_submit_urb(urb, GFP_ATOMIC);
>
> So peak_usb_unlink_all_urbs() never kills it.
>
> Suppose a bus-off auto-restart, or a manual restart through netlink, has
> this URB in flight when the interface is brought down. The path is
> peak_usb_set_mode(CAN_MODE_START) -> peak_usb_restart() ->
> pcan_usb_restart_async(). peak_usb_ndo_stop() then runs as follows:
>
>   close_candev()
>     cancels only the restart work
>   peak_usb_unlink_all_urbs()
>     kills only rx_submitted and tx_submitted
>   dev->adapter->dev_stop()
>     timer is not pending yet, so nothing is deleted
>   dev->adapter->dev_set_bus(dev, 0)
>     synchronous usb_bulk_msg() on PCAN_USB_EP_CMDOUT
>
> Bulk URBs on one endpoint complete in order. Would the queued restart URB
> then complete and call mod_timer() after pcan_usb_stop() has returned?
>
> Next, suppose the device is unplugged, unbound, or the module is removed
> within PCAN_USB_STARTUP_TIMEOUT. peak_usb_disconnect() calls
> unregister_candev() on an interface that is already down, so ndo_stop
> and dev_stop do not run again. pcan_usb sets no .dev_free, so nothing
> stops the timer before free_candev():
>
> drivers/net/can/usb/peak_usb/pcan_usb_core.c:peak_usb_disconnect() {
>         ...
>                 unregister_candev(netdev);
>
>                 kfree(dev->cmd_buf);
>                 dev->next_siblings =3D NULL;
>                 if (dev->adapter->dev_free)
>                         dev->adapter->dev_free(dev);
>
>                 free_candev(netdev);
>         ...
> }
>
> pcan_usb_restart() -> peak_usb_restart_complete() would then write
> dev->can.state and call netif_wake_queue() on freed memory.
>
> No disconnect is needed for a related problem. Wouldn't the late timer
> still move a stopped interface from CAN_STATE_STOPPED to
> CAN_STATE_ERROR_ACTIVE and wake its queue after ndo_stop?
>
> The commit message says:
>
>   pcan_usb_restart() does not re-arm the timer, so a single
>   timer_delete_sync() drains it.
>
> That holds for the callback. Does it cover the case here, though, where
> the timer is armed by the asynchronous URB completion?
>
> Would a pcan_usb .dev_free callback that calls timer_shutdown_sync()
> work instead? peak_usb_disconnect() calls it after unregister_candev()
> and before free_candev(). By then, usb_unbind_interface() has already
> flushed the endpoint URBs with usb_disable_interface(), because the
> driver has no soft_unbind.
>
> Another option is to anchor the restart URB and kill it before dev_stop
> deletes the timer.
>
> The probe error paths in peak_usb_create_dev() also reach free_candev()
> with no restart_timer teardown for pcan_usb. These are the adap_dev_free
> and lbl_unregister_candev labels. Would the dev_free approach cover those
> paths too?
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261107153319.3765325-1-hj351016%40gmail.com
