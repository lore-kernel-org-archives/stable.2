Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7954503EA
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342132; cv=none; b=hdTCY7Nm7dGM1EYIUbp3ySTCzig55S2r2e0ei9doyvEJHlaUywTpC8itVW5AGDQQXN4Ba/ViavJw7Q4A7vOj/2lLnB05ntOeNvE/ciuxkPHMJr/ckUR/iriIBAXWMZTeX1rIItLvsVyGIhygB9QJBRGFc4D7mljleqSorw6j/nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342132; c=relaxed/simple;
	bh=KTQ/C/AGHF9RbysM3AnAFePH/hkPn6orzxkp3dkZudU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sIJ2D0Eslppqlbo40jmV36kzE3swoqQmoHgWpgnnsxYFdpVLYtlbTWu9jbBmxrTHWe/SOG3fhPlSyncAplfcdt5syzGf0LOLKU1NFJv+HeSycyc813XAh1VKzuUVCRG8KHHBSQpSoGxZboz1nhetjhNwdXdR+vuhXCcgylhQiU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fvtzHCEg; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fvtzHCEg"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6D9101A1020;
	Fri, 25 Sep 2026 13:15:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 411E16073B;
	Fri, 25 Sep 2026 13:15:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 158B9103294F3;
	Fri, 25 Sep 2026 15:15:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790342116; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=aA/jH+abiUuanyuKQ/jErOx9VrxS5Sybyk7KxjQG/Zg=;
	b=fvtzHCEg+5XGvBIiIIbDm/qRBcKezZoWZkz0a8OqTjBzK4C8Sm6pUVgUXqfeg3LglpLoA1
	J16LXk9TzJtGw8b+tQSgAsaMr4988sHQcGo7XRZYqro3kuUGnjrP6SKJeYlKt+HvUZ8Vvo
	6L6IqR3cV4OuiC2wm9KyvOcn264FmIzriSk2XWYDeCWCbcylLMRKz/mFTXVRITUC+iz2+Q
	Of6mGvPl/dJzSjq8DuCu3YjCR3bNlh4FACoeQxhGJ9t3rZF4OYxUKJxagsx0t1ltOJSDO3
	Bxa4sK7Vv2Jc6eXWF/6Gbv8CbMWKIToeL6BpJ9HL7nZZxKnoKnpQpovKuuG/0A==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 25 Sep 2026 15:15:08 +0200
Subject: [PATCH net] net: macb: init workqueues before register_netdev()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260925-macb-netdev-register-race-v1-1-752f90ce1c39@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMzQrCMBAGX6Xs2YU2NAV9FfGQn8+6glF20yKUv
 rtRjzMws5FBBUanbiPFKibP0mA4dJRuocxgyY3J9W7qj87zI6TIBTVjZcUsVqGsIYFdHAfnc/b
 T6Kn1L8VV3r/3mVpBl7+0Jd6R6vdK+/4BlG0FqYIAAAA=
X-Change-ID: 20260925-macb-netdev-register-race-2b4125dd5645
To: Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org, 
 sashiko <sashiko@sashiko.dev>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

register_netdev() exposes the interface to userspace which might trigger
operations like close on it. Those access the HRESP/LPI tasks and
might therefore use them uninitialised.

Fix this race by initialising both `struct work_struct` before
register_netdev().

Theoretical bugfix. The main reason for fix is to avoid future Sashiko
reports which triggers if we grow the race condition (by touching those
workqueues at open for example). The likeliness of this bug sounds
tiny, but I've not spent any time trying to reproduce it.

Fixes: c5092ba3155e ("net: macb: Convert tasklet API to new bottom half workqueue mechanism")
Cc: stable@vger.kernel.org
Reported-by: sashiko <sashiko@sashiko.dev>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918-macb-close-v1-0-05e32ce98813%40bootlin.com
Link: https://lore.kernel.org/netdev/179010942347.2160803.5970158668197373074@kernel.org/
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 8e5c034dc3a4..76260b97a07b 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5968,15 +5968,15 @@ static int macb_probe(struct platform_device *pdev)
 	if (err)
 		goto err_out_unregister_mdio;
 
+	INIT_WORK(&bp->hresp_err_bh_work, macb_hresp_error_task);
+	INIT_DELAYED_WORK(&bp->tx_lpi_work, macb_tx_lpi_work_fn);
+
 	err = register_netdev(netdev);
 	if (err) {
 		dev_err(&pdev->dev, "Cannot register net device, aborting.\n");
 		goto err_out_free_tieoff;
 	}
 
-	INIT_WORK(&bp->hresp_err_bh_work, macb_hresp_error_task);
-	INIT_DELAYED_WORK(&bp->tx_lpi_work, macb_tx_lpi_work_fn);
-
 	netdev_info(netdev, "Cadence %s rev 0x%08x at 0x%08lx irq %d (%pM)\n",
 		    macb_is_gem(bp) ? "GEM" : "MACB", macb_readl(bp, MID),
 		    netdev->base_addr, netdev->irq, netdev->dev_addr);

---
base-commit: c15c41239b491c7fa380e7ffd115ba037f2d4b11
change-id: 20260925-macb-netdev-register-race-2b4125dd5645

Best regards,
--  
Théo Lebrun <theo.lebrun@bootlin.com>

