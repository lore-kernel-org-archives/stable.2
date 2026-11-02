Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793634014;
	b=SpsVRD0Vvv5TormqotXhoC+XVnolfZpl0LvR4exvSzP4FRJYZlU1TeKnA83P3TYtmPq/
	 amIzc6fTV7vCPD2S8lL5ME0Pgq+2xSP8P+BpuT4BgGsVQ3QvgYHikD8CgUN2XCcYZ/tx+
	 RII3sZJCiILKuNBtEDh4emEtGA+XTzLra11lzglPJPm3O4UJ0Ixxt/o3jobk0ipLk7e6R
	 /olRXoRNY9ynC6+esoMHhYB7Z2cfFOGPSH8JioDFJZMFxuasmdgfTDSNLDrracmFHQZ/8
	 Kv6RQKfJpnTrwA3wvttRfF7DPuMPmj1ogDtaTQu4Upu1LPj1oes/TuIq/c4MboHJrXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634014;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Sent-From:X-URL:X-Accept-Language:
	 X-Accept-Content-Type;
	bh=8Wr+MF50CVjtFFib0Ov41e24euoFkgyzKF8gJdzLfHA=;
	b=j8509Lqy/dPEIdyArw2dtY/K5d1O0H2CiAcGjQEVVFsVIgYf7ReXX5t8mRVIdGCE1XeT
	 Z4ebUtTcb+v3VaIxYfKk6xatzDHBZT0NaTtQa2gdalIMq0i5dRrtb0EZKISoYlkia/0g+
	 XN/5VOWdzyiCwr/NJj+vJIiZdyyGHNzMuEUVFCvpVeKrJfuOZKI/E97eW955ZIRYyL10z
	 FVTLYrvh21SwkrvC4es7V3HJRY+/gmsUXrA0wLgIUfkgsr35ydBIZ2vE4zUQIkfaGS8BO
	 0YJouU2hM4mE8KORFWvLEEI8EkBzKVUaPfrsD3FDt1avHqLgejio3ukaV373g8yLvnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="f8fVx/5f";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE19606B1FB;
	Mon,  2 Nov 2026 15:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDE19606B1FB
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=f8fVx/5f
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 78F5C200681;
	Mon, 02 Nov 2026 16:40:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793634010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Wr+MF50CVjtFFib0Ov41e24euoFkgyzKF8gJdzLfHA=;
	b=f8fVx/5fAuxUKHPHSqwyA8weZHJXrVWvsPXYSt8UwG8p+wXb9Gkbzzl51dHnmSEZN/80ft
	6nneNdi2RiVSJ2fPEdNdDYR+SaX+3SegyGtkBgO1Ypf2hQkb8zRyC7rcBJNKYFZAzoCEE4
	nuFaKjOx9klS4GPEugCvmFW8qxnwVDsy9AO65v98ai9CCqVk9juXTq8D2RdxnfrWiGPPpw
	bhog7kfELnXpkKxGE4og2jK60r0CROL8GoScoarg/AxTHWZHj3ZragQPxJvagUrQqMe/rm
	P/yIWhXfuTXtYD4/GxrABVPkDQ0KzzJVoqotFpQqDvP5NvsHcAnGtXTq0LRUVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793634010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Wr+MF50CVjtFFib0Ov41e24euoFkgyzKF8gJdzLfHA=;
	b=AwM+BU3xQME3SvInDPAwBXPK10/BZrDj4A5IJjfSsD90m2HMICgmC5jxGrQSGb16nIk5Gs
	6qcgXUy9JMbh3IKgFcgd+j+mzL+rqUKdAdcHTxgFlzjF0F2aP/WaJG7EPMD7jTtguWbi5V
	5PZ2uL3SONM+k7a+4gYxLHwdLWM3yF48aD+GBeH9XP1qiLZlbRuzM7U16uZM3073Z3J7gv
	H8Dbq9xnC1xxVI+T6rDIEYDILxAI/XuiwEcgL48VgemusSxwHGXfSm8KryxmGalpb/qKhj
	sDjSK2Gp7y49/Dz9m9bUJYFEp1sFsIYwoWNBcFyYRLyfqK73SamhlwQr2x6vpw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793634010; a=rsa-sha256;
	cv=none;
	b=ZUqpDqJHj014j6on3sJFVM7dsfrlHk32LDGdhCF6zJlaQKZ+rXW5sLHXO7Olb7IOcogkbT
	bNWW6uqbJigrbsv7m8IQktPhPrCy9gH4Fj/WSyuoNA1YHfmn81txu5iVOF8s1i8AbovyfD
	LstSpzUsq94/6qXcPzZOP96seszwtFuUPdN8AT7sUHpb5zryWAel4aqzlVDiJF5aCejS2x
	H6JOk1pHmVi6GJVcoLCvRomprYXDuiJjsZEMTB4jHG5mahrAgH/2tm992subSbWWzX12rm
	s5+JQ9W4VDWhc8hkjIqqXeNWAMOb1MCFukmmNASDYupLC0NM8X6LlFhVroEFcg==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xNu8o-002K1Q-1K;
	Mon, 02 Nov 2026 16:40:10 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xNu8o-00000005wnx-1GVS;
	Mon, 02 Nov 2026 16:40:10 +0100
Date: Mon, 2 Nov 2026 16:40:10 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <linux@armlinux.org.uk>, stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>, Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH net] net: usb: lan78xx: only stop phylink if the
 interface is running
Message-ID: <auiu2voApMN42KV4@pengutronix.de>
References: <20261029160204.2567-1-25031212351@stu.xidian.edu.cn>
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
In-Reply-To: <20261029160204.2567-1-25031212351@stu.xidian.edu.cn>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Fri, Oct 30, 2026 at 12:02:04AM +0800, YuanZhe Liu wrote:
> lan78xx_disconnect() unconditionally calls phylink_stop(), but
> phylink_start() is only called from lan78xx_open(). When the device is
> unplugged before the interface has been brought up, the attached PHY is
> still in PHY_READY and phy_stop() reports:
> 
>   called from state READY
>   WARNING: drivers/net/phy/phy.c:1670 at phy_stop+0xad/0x380
> 
> The same warning is emitted after an ifup/ifdown cycle, where the PHY is
> already in PHY_HALTED. Call phylink_stop() only when the network device is
> running, which is when phylink_start() has been called.
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

I reproduced the phy_stop() warning on a LAN7850 behind an i.MX8MP, by
unbinding the driver or by writing 0 to the USB device's "authorized"
attribute:

- interface never opened: "called from state READY"
- after ifup and ifdown: "called from state HALTED"
- ifup/ifdown loop during the removal: "called from state HALTED"

On kernels before the phylink conversion, none of these three cases hit
the phy_stop() warning.

With this patch, none of them warns, on net-next and on ba28ef3ccfa9
("Merge branch 'convert-lan78xx-driver-to-the-phylink'") with
312c816c6bc3 ("net: usb: lan78xx: fix WARN in __netif_napi_del_locked on
disconnect") applied. Removals with the interface open, sending, with
link up, link down or link flapping did not warn either. I ran each
case twice per patched kernel, with lockdep, KASAN and kmemleak enabled.
After re-adding the device the interface came up again.

The suspend/resume problems in the Sashiko review are not caused or
fixed by this patch.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
