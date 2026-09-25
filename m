Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAD6384258;
	Fri, 25 Sep 2026 07:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790320433; cv=pass; b=HvcKfZmhqLGtyeazuH0JLO2CpwJ00+e/GcFdyVEn7vebdetydkcK0+1pKXg8pR+FzLtvtfVzSSSAYFF3X7nDwXIyRd0Igz39oVRPmx1iKcPIRu3OxLRff+y0b9JSV6x2inNBazzqJBgvjLPuAEBZlvjHBeFgR7EONPcYrkYEZbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790320433; c=relaxed/simple;
	bh=204sKMI5do38KKJp7Jqj1fEbF7DyWfLHVaIFvH58Y1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzAlbXmVDhUiCttGoiO+8WuCkDZ61VLYEMYkW2yhfqhFfBGy5KuKbJrz5MzwcORgmD61kX1HpTnldFVIianBy2FINVknaYVGLZ40j5OivFctsHdx0hltnFn5OFLti8gLAf0eBVJLgfmYEoAn/b7VRsZ4HA3YvtTQzNcUU64pCp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=LmI0yBIq; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="LmI0yBIq"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3D21C2010E2;
	Fri, 25 Sep 2026 09:13:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790320430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WLceNeGlZl/gS3dxnKEM095tZNl9hbWJqJ8xL8l+Ngk=;
	b=LmI0yBIqgdLYlZkBCpjZXNKQNbWFfWYbjkQGdgI8oJTKi4oGntWIoji0TdDTHQJ3EEPyUM
	lUWPkBqVsnlERCCmLxdFcgnWBGblRcHNwoTEY/qihG5/7/bkzheB+luC+QfHmQf91ehAEC
	k107ogFRxkRe9xelZoDmMOsDsp0azvpkOqIrPCOJ03AdM+h1e5xR6r37+JpN/WbHKiVW14
	CEV+Lex9xsFyd1fSyQcodP/oO4KTWOrSow8GmzEZtCTcXbFioBuupqJFOvCj9v4xbj7BPk
	aPVNQXjFE12d2YntZd5szOvIYc4bgVsUk/cY0LHbHE6J35BH2O4Oeii1fBTQ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790320430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WLceNeGlZl/gS3dxnKEM095tZNl9hbWJqJ8xL8l+Ngk=;
	b=FjSBUpNBgiTP2RKJG00Xn9iQ/JJqcctKp9O/ky08jS+C51zWkAhFYyH8sVwdFPCHYKa9us
	+U5V0v0A74FHrHCtCGWJLPN/5re7JATWiLsAr0APVCoWMcyDMoeTcwUtm0xhDtdwvdJwrR
	qpi5M7aaqkU+vJ5l/TkHEB9gd5UMOY2mt6Y7flzTlKenM+rv6aCd3nAHA3KjbBIYKPe/z8
	nFh82pKaYtTwgA94J0AVCxKt66K2KQCJoAWsriaPCCGuV175PmxJBctTIyXLhXsN+uFR5W
	Z6m+s1AxL62HnXrs1mfJeVwlSTOGwmcpDJ6nIgvEX8+MtM3l9UeQONk5e+d5yg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790320430; a=rsa-sha256;
	cv=none;
	b=PRWtc/sudJkmT2stVbINd3FjWG7+/X+w1GiaPS6ulSjIXeuumkxkXw8KYppU9Dq7TW1d8g
	MPKIL2swAhb+tSAM5JPbgYPfa7de+dcAwBiIhpOhANYfWQRfwDvab2NWso3j7PB/h0h2wt
	gNbrPM07qISuPs4803t9tGq5RJ/Z0lKhZUaao4zC4qUKdarYttF+sZ+N8puvdjU2Sf0bIk
	mD2skZUlLlABJgpn7LAu010byQgRRbvc3WJ0m3hpNKOlJExaNWagJfHNer0I/DAovVjRO9
	sx98NJeMnjoTHMpIMJuMofN3PqNC3jO/5tjkuEbe2R1OESp7s77GQi7Et2F/nw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xA07y-002h3b-0W;
	Fri, 25 Sep 2026 09:13:50 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xA07x-00000005Ptt-481R;
	Fri, 25 Sep 2026 09:13:49 +0200
Date: Fri, 25 Sep 2026 09:13:49 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Dennis Piecha <d.piecha@ymail.com>
Cc: "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"nic_swsd@realtek.com" <nic_swsd@realtek.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"nb@tipi-net.de" <nb@tipi-net.de>
Subject: Re: [REGRESSION] r8169: RTL8168h silent RX stall with EEE after
 "net: phy: realtek: fix EEE advertisement write on the internal PHY MMD
 path" (6.18.y)
Message-ID: <arYfLe7JpeO5tw6G@pengutronix.de>
References: <353419280.954808.1790290283530.ref@mail.yahoo.com>
 <353419280.954808.1790290283530@mail.yahoo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <353419280.954808.1790290283530@mail.yahoo.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

H Dennis,

On Thu, Sep 24, 2026 at 10:51:23PM +0000, Dennis Piecha wrote:
> Hi,
> 
> after updating from 6.18.39 to 6.18.52 (Home Assistant OS 18.2 -> 18.3,
> close to vanilla stable), the onboard RTL8168h of my NUC silently stops
> receiving every ~7-20 minutes. Disabling EEE at runtime makes it stable
> again, so I suspect the stable backport of
> 
> 202fef9bbbf5 ("net: phy: realtek: fix EEE advertisement write on the
> internal PHY MMD path")
> 
> (0af3afd054e7 in 6.18.y). There are no changes to r8169_main.c between
> 6.18.39 and 6.18.52, but this PHY fix touches rtlgen_write_mmd(), which
> is used by the "Generic FE-GE Realtek PHY" bound to this NIC. My
> guess: with the advertisement write now landing, EEE actually gets
> negotiated with the link partner, and RTL8168h doesn't handle LPI
> correctly on the RX side. The fix itself looks correct to me; it seems
> to expose an existing r8169/RTL8168h problem.
> 
> Hardware:
> Intel NUC11ATKPE, BIOS ATJSLCPX.0039.2023.0221.1502
> RTL8168h/8111h, 10ec:8168 (subsys 8086:3027), XID 541
> PHY: Generic FE-GE Realtek PHY
> link partner: AVM FRITZ!Box 6690 Cable, 1000/Full, flow control off
> no VLANs, ASPM already disabled on the device (LnkCtl ASPM bits 0)
> 
> EEE state on 6.18.52 (read via ETHTOOL_GEEE):
> supported=0x28 advertised=0x28 lp_advertised=0x28
> eee_active=1 eee_enabled=1 tx_lpi_enabled=1 tx_lpi_timer=12
> 
> Symptom: carrier stays up, nothing at all is logged by r8169 or phylib,
> no NETDEV WATCHDOG. rx_packets freezes while TX and the MSI-X interrupt
> count keep going; no RX error/missed/dropped counters move:
> 
> time rx_packets tx_packets irq bql_inflight tx_timeout
> 23:08:29 626373 188818 201071 0 0
> 23:08:31 626458 188908 201236 0 0
> 23:08:34 626513 189037 201394 0 0 <- stall
> 23:08:37 626513 189126 201473 0 0
> 23:08:44 626513 189284 201606 0 0
> 23:08:51 626513 189517 201788 0 0
> 
> It never recovers by itself. "ip link set eno1 down; ip link set eno1 up"
> restores traffic within 3 s; flushing the neighbour table does not help.
> Disabling TX checksum offload and pinning MTU 1500 (workaround for the
> VLAN-related TX timeouts reported by others on the same update) has no
> effect here.
> 
> EEE test: on a 6.18.52 boot that had stalled at ~7 min and again ~7 min
> later, I disabled EEE via ETHTOOL_SEEE (eee_active=0 afterwards). Since
> then it has run for 60+ minutes without a stall, nothing else changed.
> 
> What I have NOT done yet: verified the EEE state on 6.18.39 for
> comparison, and tested 6.18.52 with the commit reverted. I can do the
> former easily; building a kernel is harder on this appliance-style OS
> but possible if needed. I can also capture a MAC register dump
> (ETHTOOL_GREGS) during a stall if that helps.

Can you please test following patch:
https://lore.kernel.org/all/20260925071040.2137178-1-o.rempel@pengutronix.de/

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
