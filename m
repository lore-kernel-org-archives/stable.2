Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793613947;
	b=uktjJdU6RQPqKO5Vd8g4AwPwnVGqb/9NxF20l+04CjoYvW0+ywFlU3auQ3A8TH9OoMVB
	 QF0HKsVo6jaI+RJazBBWBYCA52kE5Rh1znS7AqCPEnUSqAl2mzZzX8tRG75gxJkvEpzcj
	 oMkvTIHKa8FFsN2TK122uI2I2H7NWbffFvQkBjAkx79mw4QUAy/KBFZE1s1MTkxNlQ6ed
	 GHIjl/S978hiQgG8wBmYHuxAt2Zz9BG2J/nA2MjB8oiLDfW5/0ffiw1/sNchuBBH9uRZT
	 +AaNg68g1SBjLyoTJNuYLrSWZoWgRuHsHsKR1J7UcCV3zDfM/YXMFnsJIBtPPafk+xQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613947;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Sent-From:X-URL:X-Accept-Language:
	 X-Accept-Content-Type;
	bh=OsQ3kjAxO3/eNNmxdkB9juBOEnpFB5PyKBZnUzf/src=;
	b=IxP824hFRN2Oxt0sb0ZR6jE2krMaNVDwF3hm4gQM0rz3WqjVyANt0AqftyS0ru31BvDy
	 bemaeKXNMiKqFe9Gi8y/+2eKwbH87T0JZ1w38Irb0eU8doTqabNPnFtD3nzCyULMY0/UN
	 yIhiwh8Pu+uijqSDApRDHVuYYDCkbBjk3WcA+F3eEATopRyrHEGS0fnrVnufHckvbvSJt
	 TLmkO31u+tBRIezAdFVlnH+uoK89R/o0U/4iQffMjAC85BqkvfHJeXevFD9nBhg7R1pN8
	 ZVc/0psILejd6/kVItXyldxMSjE7m+FvKO0iltwzX5hN6L9IXZoGKuDES6lpH92XNRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=KN3EAIk3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CCE606A32E;
	Mon,  2 Nov 2026 10:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01CCE606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=KN3EAIk3
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 896B620177D;
	Mon, 02 Nov 2026 11:05:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793613937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OsQ3kjAxO3/eNNmxdkB9juBOEnpFB5PyKBZnUzf/src=;
	b=KN3EAIk3ilnAn4xOSxCs3eizZiSVwVZ+DLEzqlE8D0fBG30qMnrDmtyYPunK287ZKRMYvd
	FijPtwlNh7igc2UTIQNPm/ri/OymTLcg+T9HiKIKfZAsRXeWdbcs+ZBQ+9Ro7R3lHjRXZR
	rGN/7q/Tgd5U/52qE1AFGLG7v/imTOhyZ87one4tS/lbwuTzUtqy0Jueyhe0SwHa/2fdfJ
	saWJIRS1Zk0NFBCjLan0K9uDZbjRauhe7FcJWvaNxDdvUcPAJOdytIikHFdKvPgFYiGHaZ
	aX+RT7BglojWVIgZ3T5M2mrcZeuCJwVVl/Vp3aBhoKvG06d0g8WBwOWgu+Evhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793613937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OsQ3kjAxO3/eNNmxdkB9juBOEnpFB5PyKBZnUzf/src=;
	b=UWbmRLlBQtK3LI+0CziCofwRJ7Kc+XbcszLiW4cbAPBTE3xmsMDIrsp0zwcbOX5iJX+OMi
	zV4EZyEmCjpkLEopo2F3qq1LMP61p9srEYP3vWaNissC8ygvQC1QKNlYfakWQyZtR8xBP6
	l+lCm7zxIIRj8lNDBXWr0D8X9iMzMUFqrHwbFRLUBKGr2lP34EQHIYisgahRPwFZR51CVQ
	5ijWW3TYsek9ns0WZhryMhM3+IGI/Z21o5PPjSeQTp+4kNG45DT4nCISe4JnbLS+yip/t9
	xo1K3avgtRK4mmyTL6WysMyppSfAMf6xIP2qUb/X/pX+PRBeoIuMi7wVHa4AEg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793613937; a=rsa-sha256;
	cv=none;
	b=Pt46WtaImLhUiCyqZF3YROWHV/b/Us1kJtevdzsPCm+02ZzV6rGGj5U663aOnM7le7ZTxv
	oCGrXwSBXPBawEJGvAoMitvGS7DLdy5l/Zom4dfk7Y3b1OvNXdhw7Ot8hEOMURjGJlzF/e
	DokjWIb9k66bVtv9LcnYn2mTw87xPH0WFQkzm/I3jasqJbkTtcUSQZ+KoQWnjBlg8hd9vc
	zeHBGADcdnGWk4CIbYnRzIxYgEtXJUHLb4D2iRpZZ6O/W/ueppC2NYOV/ZD8HaYTbRe89p
	4d09YOgb43YiYmZ7BghPo3LHs2ItT3xaScjK9M631crEhIap3jUNwsHf6TjJlQ==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xNov3-002HfG-1Z;
	Mon, 02 Nov 2026 11:05:37 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xNov3-00000005trn-1YYc;
	Mon, 02 Nov 2026 11:05:37 +0100
Date: Mon, 2 Nov 2026 11:05:37 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: sashiko-bot@kernel.org,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <linux@armlinux.org.uk>, stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>, Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH net] net: usb: lan78xx: only stop phylink if the
 interface is running
Message-ID: <auhgcS6p-HDFYd7x@pengutronix.de>
References: <20261029160204.2567-1-25031212351@stu.xidian.edu.cn>
 <sashiko-outbox-191206@kernel.org>
 <179346555447.2831.9240931140716315096@stu.xidian.edu.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <179346555447.2831.9240931140716315096@stu.xidian.edu.cn>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

Hi,

Thank you for your patch, i'm testing it right now on my HW.

On Sun, Nov 01, 2026 at 12:52:34AM +0800, YuanZhe Liu wrote:
> On Fri, Oct 30, 2026 at 04:02:36PM +0000, sashiko-bot@kernel.org wrote:
> > Does calling phylink_stop() and phylink_disconnect_phy() before
> > unregister_netdev(net) in drivers/net/usb/lan78xx.c:lan78xx_disconnect()
> > cause out-of-order teardown, a duplicate phylink_stop() call, and a race
> > window when rtnl_lock() is dropped?
> 
> Yes, the ordering is wrong. v2 drops the explicit phylink_stop() from the
> disconnect path and unregisters the net device first:
> 
> 	unregister_netdev(net);
> 
> 	rtnl_lock();
> 	phylink_disconnect_phy(dev->phylink);
> 	rtnl_unlock();
> 
> unregister_netdev() closes a running device, so phylink_stop() is done by
> lan78xx_stop() with dev->dev_mutex held and after the TX/RX URBs have been
> terminated, which is the same sequence as a normal ifdown. When the
> interface was never started no phylink_stop() happens at all, and that is
> exactly the case phy_stop() complains about with "called from state READY".
> 
> This also removes the second phylink_stop() invocation and the window in
> which the net device was still registered with no PHY attached.
> 
> On the remaining points:
> 
> - The duplicate phylink_stop() was harmless in practice, because after
>   phylink_disconnect_phy() pl->phydev is NULL and PHYLINK_DISABLE_STOPPED
>   is already set. It is gone now anyway.
> 
> - The PHY interrupt is not released by phylink_disconnect_phy(). The virq
>   created by irq_create_mapping() is disposed in lan78xx_remove_irq_domain(),
>   called from lan78xx_unbind(), which also clears dev->domain_data.phyirq;
>   lan78xx_status() tests that field before generic_handle_irq_safe(). The
>   intr URB is killed later in lan78xx_disconnect(), and that ordering is
>   unchanged by this patch.

If I see it correctly, in the practices it is a dead code, please see:
30a41ed32d30 ("net: phy: microchip: force IRQ polling mode for lan88xx")

> - Andrew also asked why the Fixes tag points at e110bc825897: that commit
>   added both the phylink instance and the unconditional phylink_stop() call
>   in lan78xx_disconnect(), and
> 
>     git log -S'phylink_stop(dev->phylink)' -- drivers/net/usb/lan78xx.c
> 
>   shows that the line has not been touched since.

Re-testing it right now.

Do you have access to a real hw or you testing it on QEMU?

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
