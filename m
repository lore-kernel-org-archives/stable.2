Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441784B8DFC
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448036; cv=none; b=SrEoV1/aPyYJfeoEu8+Cp+lOtXXtjAyb8uxxudZPizn6RJEcstk7d+vcDCcyDw6+dKn5x+l6mIn6f3/AYWD2xwADy986nZoP7ALxe+6T8ugCqV2MBqPGh0aA1RWqBSIoWfsggip2mnEZRednHM++jg5QO1gqdsnjYMHly2VJdJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448036; c=relaxed/simple;
	bh=qZwqUtXuFfVZh551PQEXFhTryFhzeMBwf0Q5L7e2n8Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gXjFEhk2h927Kcb1LyWvTR5g+U6CmDs17K1uPXvaSvwQKDR7AO362lMxo8QrmzujbUOH5NCZ+61Rv0JgVHCP/mBO+3cj42ThB2hOpFBW7RmwuVgVLHHrYR5yPGLMb+dmOMhWmGXeZsI5ro7FavPMkmGdlDzza1qpxQtLib1ebFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XEUvvFHb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XEUvvFHb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C951F000E9;
	Thu,  3 Sep 2026 15:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788448034;
	bh=xEHA0TTh14uLMg3GjazATM0C9iH27aUbZupu7vRG94E=;
	h=Subject:To:Cc:From:Date;
	b=XEUvvFHbpy9aX/HqzwN4eJYX9pmoQz4KOsj6lOty+wOm5B8s54MbhOs5CHnHs7Qh4
	 uxrTxMmkPpBGaU6AWEtr2gEbawqxjQ6xpUwa2E4wxYB2PmAx1tx2e3aG5uiIg4Xdhy
	 TwzxEqlCgV3hVysqg3n+TGtJUh/KzESldDe9+PFo=
Subject: FAILED: patch "[PATCH] net: dsa: realtek: use gpiod_set_value_cansleep for reset" failed to apply to 6.1-stable tree
To: a.fatoum@pengutronix.de,alvin.sipraga@analog.com,kuba@kernel.org,linusw@kernel.org,luizluca@gmail.com,o.rempel@pengutronix.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:54:50 +0200
Message-ID: <2026090350-cucumber-busload-765a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x fb58b6a696b30bcbfbe0cfc0a91b19c816a955fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090350-cucumber-busload-765a@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fb58b6a696b30bcbfbe0cfc0a91b19c816a955fc Mon Sep 17 00:00:00 2001
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Fri, 14 Aug 2026 13:01:02 +0200
Subject: [PATCH] net: dsa: realtek: use gpiod_set_value_cansleep for reset
 GPIO
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

rtl83xx_reset_assert() and rtl83xx_reset_deassert() are only called from
the probe path, which may sleep and is not timing-critical.  When the
reset GPIO is provided by a sleeping controller such as an I2C I/O
expander, gpiod_set_value() warns:

  WARNING: drivers/gpio/gpiolib.c:4030 at gpiod_set_value+0x44/0x80, CPU#1: kworker/u16:4/61
  Hardware name: B&O MAP CA33 Rev f (UNKNOWN) (DT)
  Workqueue: events_unbound deferred_probe_work_func
  pc : gpiod_set_value+0x44/0x80
  lr : rtl83xx_probe+0x1d8/0x3a0
  Call trace:
   gpiod_set_value+0x44/0x80 (P)
   rtl83xx_probe+0x1d8/0x3a0
   realtek_mdio_probe+0x24/0xa0
   mdio_probe+0x38/0x78
   really_probe+0xc4/0x3e0
   __driver_probe_device+0x15c/0x1b8
   driver_probe_device+0xb4/0x120
   __device_attach_driver+0xb8/0x1a0
   bus_for_each_drv+0x88/0xf0
   __device_attach+0xa0/0x1d8
   device_initial_probe+0x54/0x68
   bus_probe_device+0x38/0xa0
   deferred_probe_work_func+0xb8/0x120
   process_one_work+0x184/0x4e8
   worker_thread+0x188/0x308
   kthread+0x130/0x150
   ret_from_fork+0x10/0x20

Switch both helpers to gpiod_set_value_cansleep() so such a reset GPIO can
be used without triggering the warning.

The reset GPIO has been driven with the non-sleeping gpiod_set_value()
since the driver was added in v4.19.  The call has since been refactored
across several files - from realtek-smi.c / realtek-mdio.c into the common
rtl83xx.c module and then into the rtl83xx_reset_assert() and
rtl83xx_reset_deassert() helpers (both in v6.9).  This patch therefore
applies as-is only to kernels that carry those helpers (v6.9+); older
stable kernels need the same gpiod_set_value_cansleep() conversion at the
corresponding open-coded call sites.

Fixes: d8652956cf37 ("net: dsa: realtek-smi: Add Realtek SMI driver")
Cc: <stable@vger.kernel.org> # 6.9.x
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Alvin Šipraga <alvin.sipraga@analog.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Link: https://patch.msgid.link/20260814110102.2362246-1-o.rempel@pengutronix.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 9dd50b20c000..d2e92bab55d2 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -321,7 +321,7 @@ void rtl83xx_reset_assert(struct realtek_priv *priv)
 			 "Failed to assert the switch reset control: %pe\n",
 			 ERR_PTR(ret));
 
-	gpiod_set_value(priv->reset, true);
+	gpiod_set_value_cansleep(priv->reset, true);
 }
 
 void rtl83xx_reset_deassert(struct realtek_priv *priv)
@@ -334,7 +334,7 @@ void rtl83xx_reset_deassert(struct realtek_priv *priv)
 			 "Failed to deassert the switch reset control: %pe\n",
 			 ERR_PTR(ret));
 
-	gpiod_set_value(priv->reset, false);
+	gpiod_set_value_cansleep(priv->reset, false);
 }
 
 /**

