Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794661041;
	b=cFkz8Lckg3I/FqdyGebJnJ7Dt4TabCLVi72qvGuTopWUBph0yFSXeoDGij2cla/XmjkZ
	 V1OrYpJuremWOP+vsqK9uGGlxeZax41z9GeGUuj5DdqA3SQtv2Io9jvScE7sVi7Hq+UdK
	 +EQvqTo/IX8PFzjIYGl5i1Pt6ae2vga4YFHQlj/xXExwtfQxuUpK+eyYMC70isMbhzctP
	 33byyRlWXctOXmYqwzr5dLtyqYShnc5q5JjOyBneRvC+E3/jv++cRl9ciMgILxjWJajpN
	 mVQzhSAZ+LpCpLIKJF8qZHSyvA0Pi1kFlDax8RZpujT6LxattgMP8If3T3LMqebuuEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794661041;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=vURHFJpqxdNji4XYAfQR0vnMtn7b/TNM3hv/Ptn0Qv0=;
	b=oSOJjBC/fCWR5a3c+mp8x7Wi2wGnxRK6DWgg7xsGkvrReiHx9cSgPJwVNyYAaAytdtrr
	 79IJeMHQXhrDEzI6hP5OjJMSfx8SOGwVHQqXprPtw7dUHvYsfj3SD5t/zaUZqhrHw887l
	 6t+LXSEn9M4SEEQu2sYoz6Myb14TxtWgmW5B6v7bTqqnL1zks8+R+y9lh9kC5rk1q8tpn
	 qKHY+wcXMvZZ9lyFt+1Jiu2KkgItI5uOYVLCgiQduHNNVze80/Bb3ThaVAX18dF/9BK5j
	 b/TAkTdJmAQyMW97vevElym3bA3+Bxshssm0QMaSEtNsQeQka3LcvWfJJ8O2mO9pnCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=V6pRcREO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B818E606A331;
	Sat, 14 Nov 2026 12:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B818E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=V6pRcREO
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id CC911201CE0;
	Sat, 14 Nov 2026 13:57:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794661037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vURHFJpqxdNji4XYAfQR0vnMtn7b/TNM3hv/Ptn0Qv0=;
	b=V6pRcREOcS8DazD7+nUWOzWbx4mrJWgVIZ0rFjXcdVtBBnHMBpU+f/9vA0Q20cMGj8gNPh
	sId6A1UrHwcN7k1SlknbyERxEkMNi9fJDsMuPG7x6rnmDLv41H6wj72XZI+AyQjGzr5oVY
	D8cAV9/p7T4iMn9Kfk2Q05tX4LaldCaLT3YGLMZHocvDqU1jjJTxN1K20Cjf92BtWo1ZgY
	L43OXOUcU1ofPko5/28oB2cJ/df3sAqB/F1bAPILMJRSGokcz4Y4YTww1/VO3yltl/t/NN
	/5OldG5gHQUJYdfvvgU3iA7ctet0DeiAU7BNII1TyGzO5uAdK5Cgu9a28zhLbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794661037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vURHFJpqxdNji4XYAfQR0vnMtn7b/TNM3hv/Ptn0Qv0=;
	b=OvoRCl627zMY2S/Yz1ukLl+v8T4j+L0KPaiZHAFavpv5ae8u6OejyPgE/7ndVSY1VeDarc
	Ls5okLdNAmnHtb3akC9DJ2hqgAQ+EL0pPb9Efxn9MjnNdVTsl2WRbyt7sWJoB6pORazwHR
	K9zyY0x5m2B92/ViGdQLXrblBm+I3mm08mra5HHZY6X9CgVJ3s0KUmLz/M+uribwnmP6CY
	84GZ5N0gm9NSgAuHZbxluBCD1ecuBACCWMXAAcijrskHblK26Kywevjck/1zH+SQU1tUEj
	fNV0HGaO1R1OhjdKN+EsBUCXdK5KoA7/z65SMX4WjVhHbzA0A/kcf8/l/GZ2pA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794661037; a=rsa-sha256;
	cv=none;
	b=YjMGpMMkkie6EmcNdoiNMsbyHeDr5iwrD5Hv2m3OLj9ZJ31BVrWF3JtuPipQI2hzAUUSzV
	rcw5Lewt3pD1mXXhZjK8F8azBKjJ6BOe6j1PgVgv2eF/OtyKkvPOY1RWfNJKGjK6GWLYYt
	RiUrv/RL0IiK8AnNIeZKIMu6m980RkaEMezw+HEVcqJ/P9jXvTfNAYfR9Ze/WvGeDp38M7
	DyMbmcSBr6rPccVzws66HoUW81IFeRUZBD93fYjqZ6FFak77FFHu9DArS7rVLRMmqne/PT
	wXoEAo6+d5idmizcWzvoaoWEcIa5q11WF/LhA9pzw7WpRSr9UmcF9NVXcZyJWg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSDJl-0048pS-2I;
	Sat, 14 Nov 2026 13:57:17 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5B4785EB9A7;
	Sat, 14 Nov 2026 12:56:23 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH can 0/4] can: fix probing and use of
 device_get_match_data()
Date: Sat, 14 Nov 2026 13:56:13 +0100
Message-Id: <20261114-fix-device_get_match_data-v1-0-2d82025e9646@pengutronix.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM2wrCQAwFf6Xk2QVTWm+/IrLEJLYRXGV3LULpv
 zfq4xzmzAxFs2mBUzND1smKPZMDbhrgkdKgwcQZ2m27Q8Qu3OwTxEXWOGiND6o8RqFKAVH4yHL
 olffg/1dWl3/tMzAluPzH8r7eleu3CsuyApeWB7qCAAAA
X-Change-ID: 20261114-fix-device_get_match_data-11dc9cd85ec7
To: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
 Harini T <harini.t@amd.com>, Michal Simek <michal.simek@amd.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-renesas-soc@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 stable@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=1497; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=oxSiDfJJ5FKPdCOEbPDPir49JWXUKfRJ5chn629wb4c=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj6EVVw55uF9HbLnxmNq65PP8Q05W/ut9tvdIPfJZ84M
 GnvqsBW5Y5SFgYxLgZZMUWWpT9OKAoEOpT2vkyYBDOHlQlkCAMXpwBMxNCY4X9RRWYr89G6X78v
 WoikulRLxLBkC1xP8jZK8f/NxBL/qI3hN8uK3ov6ufHJptk7f/yadPKAgur5v2e4tG9XvuB9O/n
 YGUYA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

With patch 5e6c3454b405 ("net: can: Use device_get_match_data()") several
CAN drivers were converted to device_get_match_data(). The author assumed
that error checking for matching and match data is not necessary.

This misses the fact that that drivers on the platform bus can forcefully
bound using driver_override and device_get_match_data() will return NULL.

By using device_get_match_data(), this change broke probing for
m68k/coldfire, which still uses platform devices.

This series adds missing NULL pointer checks and fixes probing for the
flexcan on m68k/coldfire.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Marc Kleine-Budde (4):
      can: c_can: c_can_plat_probe(): reject devices without match data
      can: flexcan: flexcan_probe(): fix probing for m68k/coldfire and reject devices without match data
      can: xilinx_can: xcan_probe(): reject devices without match data
      can: rcar_canfd: rcar_canfd_probe(): reject devices without match data

 drivers/net/can/c_can/c_can_platform.c | 2 ++
 drivers/net/can/flexcan/flexcan-core.c | 5 +++++
 drivers/net/can/rcar/rcar_canfd.c      | 2 ++
 drivers/net/can/xilinx_can.c           | 2 ++
 4 files changed, 11 insertions(+)
---
base-commit: ead6fa9a0ab194f02a2f36d634b193e9c5f9a1c6
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git main
change-id: 20261114-fix-device_get_match_data-11dc9cd85ec7

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>

