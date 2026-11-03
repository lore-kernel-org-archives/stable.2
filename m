Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793683866;
	b=lqRetM5XyH1JaWTo9JEFMdTFawvnCNpk8KKLLk8YMbLAsQN3TWAbD378ErbiJvOrxQUQ
	 8PQAxfjMW7V9QO+lfZgTf8FB0N31vbNWWpflpom7FSvGTsbjsJLlxmrEwXYgGSM4ZWk+S
	 tA/C4IqNcCSEufl7n0u1qrc428TRPUjtT8ZUb1Ql4xhtU3NcXbN4ja7SmLwGNCJ9Ev2Fc
	 mXEEgZpRI8otqoAb1kgdlqXcTEVanJAUgnPQXpGlCz3cqaGtSNp3DY9uuIuDlLm+9dheq
	 mURXbwRbVSw2QokRe27OHUxz3Bw7eniF6l7M7WZl13gsrnF33u8mUFZmiC+h1Wp0hhQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793683866;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Sent-From:X-URL:X-Accept-Language:
	 X-Accept-Content-Type;
	bh=Q3/Td8B8t3SdY+QKbIiQxN+A9gUB91bNSneIAZqeY8Y=;
	b=xeBVBcDf+yNVMxl8ghsdE+d58uEwJnh0ADoI+J2s237HLSFpqeTgTpAUi6qDuj2OaRoH
	 XKVIHays1qSJqFDqsAPF1/Kl4B0iouofiPXkRenTa4qZDSjwXAQ8jGqL7kO7cKpaygb40
	 8WDgHzroFGjKaJs36HhahCa9UP/wV4IZnhjLZjyaQtqFC0Tk4HbX0K72qxZyfc0Y9rh5h
	 2mdn6EZU9G31+z+TWPU9jXYHip2S76yaWypiRKkg1qSf9GqQ0Vd+FZiRRPxbmNPDMdA7B
	 dyxf5VJkLvSIyVE5DRhO7/P3fyYfNu506CD7y/20mk6HDBvyKx3G5C6jAtJ9ERk0fnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=DTDenI6H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC23606A324;
	Tue,  3 Nov 2026 05:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BC23606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=DTDenI6H
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 61E2F202299;
	Tue, 03 Nov 2026 06:31:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793683862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3/Td8B8t3SdY+QKbIiQxN+A9gUB91bNSneIAZqeY8Y=;
	b=DTDenI6HkKb6xQaZ5i/aDhMT7A60H+TmW4OnrAHAvdcU9/E9Z7stos6Y7qXYRIg10AhuUy
	DjHVwXlGixwPduGB3b9FGqfpZS7mtYQ3U0q2Ov3Dw054GTPtMbb+OUMCvUTHW/Nl3slSeI
	1eh/qn+OfDM+C7tqaWAWex0GnGmaExgU7OZgutQHTw6R5tX1WrmUKNzUY2FPB2HBroNYho
	38C2p57xDTFxNdjOrW3J7zhlzR4U/4EfGyJFdwUfVsCH6eA1VRvfPHXRzb2a3Rva3hgVb8
	9m8+70SuY3RYLh2g24iXWl3Z9zk+xwXKCb84xM7c4yn0E4AZ9/xYgTj0EBHHtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793683862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3/Td8B8t3SdY+QKbIiQxN+A9gUB91bNSneIAZqeY8Y=;
	b=BWvvbSjIN2uKpTNEKyxDJwVu9qsTxdCXGBrc9N0WTDoVBj3ROYIkIx+S1Pxnu23tdOOVgl
	k7v4bjYmaBAdmwEovVQXEMUoEb7eVadr0WtoYnCyi7myWRZywEHAwj3pxNKGqJLYSCe7XJ
	w7boUhmTO+L7DvNrZpHRxfncikNiZA8vV7Q1fmU4AHKD22qsGDztHDA7nrdqQ07YytchqH
	1GF8n9AI6mG5/nXa1j9dGlh166adt2nyJ5aBdMxZAE7VLzsiGM5h0m4nykeXXFuBm6EDec
	lpyuv9ilh+6C9XZ11iWwD91dlBG9DZQvr3L36UgeJk8FC4tYPx6E+NaeQsROgQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793683862; a=rsa-sha256;
	cv=none;
	b=Dsaqzqw0IkIOkxdtYvb3cCAAwExCqn0e91PZeE/qVhHRezRKnEx7sWCM6zei2BARvQmYLh
	JwmBbTUvwdOXGe4UW7hRVSjQV7IkQouRDpXqi4zh/ifOpuKSyTilLnEWRF2kjLIhJ6Xk7S
	DnZhsH20LzYCXqP0fwJkEGuDKaEgCElNF9VnwKeinJmYd/IaMISRHEkPzyKW8UkDLluxe+
	JIknhA5UsHIbw4VOpOj4RS0rjFSaVfFBaOkBz4+XJfj+i0Yf2tet1B3Do4Nzzn4X1cw6S3
	a+4DhctGdZcvX8MfHEFaOkzo9tEwmtT25SsyecUKsc4UudQeOWgSGDtrMPm/Jw==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xO76s-002P5r-13;
	Tue, 03 Nov 2026 06:31:02 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xO76s-00000008mgf-0uod;
	Tue, 03 Nov 2026 06:31:02 +0100
Date: Tue, 3 Nov 2026 06:31:02 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <linux@armlinux.org.uk>, stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>, Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH net v2] net: usb: lan78xx: let unregister_netdev() stop
 phylink
Message-ID: <aulxlj404e_atUAS@pengutronix.de>
References: <20261031165213.2738-1-25031212351@stu.xidian.edu.cn>
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
In-Reply-To: <20261031165213.2738-1-25031212351@stu.xidian.edu.cn>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Sun, Nov 01, 2026 at 12:52:13AM +0800, YuanZhe Liu wrote:
> lan78xx_disconnect() stops phylink before unregistering the net device.
> phylink_start() is only called from lan78xx_open(), so when the device is
> unplugged before the interface has been brought up, the attached PHY is
> still in PHY_READY and phy_stop() reports:
> 
>   called from state READY
>   WARNING: drivers/net/phy/phy.c:1670 at phy_stop+0xad/0x380
> 
> The same warning is emitted after an ifup/ifdown cycle, where the PHY is
> already in PHY_HALTED.
> 
> unregister_netdev() already closes a running device, which calls
> lan78xx_stop() and phylink_stop() with dev->dev_mutex held and after the
> URBs have been terminated. Unregister first and disconnect the PHY
> afterwards, so the interface is stopped exactly once and only while it is
> running, and the net device can no longer be opened while its phylink
> instance has no PHY attached.
> 
> Fixes: e110bc825897 ("net: usb: lan78xx: Convert to PHYLINK for improved PHY and MAC management")
> Cc: stable@vger.kernel.org
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>

Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
