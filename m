Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602874;
	b=YZChrNePcgxN9rfyIn9uiFMESTf1d1Qm0ZIm95hhLk8BUn8byP0JjJtQfEF0HI7PfNwB
	 ixMXwPDTjGfieDi/9l35EFR3eT/Q55g6Zeuqg7/rQrnUiMydoBa41hHr8DtyAUJuFxHWm
	 cK4eImiUPhvO1YlxbQ5i07mF6B1UKF8FBDId5Ua454cgvNxPfHrKVivgXlvRPyoHi3Dr9
	 2l2z59tsy/hmc/R4/T8Zp+0KTvyZppkAseIBjQnGk7tHbUhhxWWX1YA3bExmmqzCgUa2t
	 FNCpailcEoz+E6ncAYycA5Py3ZwGpgbwhu4mh5i4+DdUwvwhyEZ1OIUlP3DdywnNsmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602874;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=48H4ncuNbMxvmZ8ze98nkscvwkt+OV3XwOSCzy6v2Pg=;
	b=C3is7S6U7CRVxEtBfLt/0TvCMe+0FMy6gYgqOOdXD/ZR+PLPLK1h2ohI/7GDJMhK6d/h
	 pt9bbJUvUd/YRoa8/NaQphp4GGoVZGEOSK0e+imMj/YVcy0No64yhXp67PVmfsK2+5Ujh
	 NleQt8HeQVLIm3oJSyHgy81nZCbNpD+Lz5txKX6P8GmccVFuiVjkPvUautG94IkD481Am
	 2PVbO9yiVnsxESz/hV0Z3eQySwWY8RUpbaqeMy+rxHgEXUL6yJfuG1WYKgaPq0++fTGVh
	 mmPn+dirOXG4rr+/nsW3CZhmPMZ9FGLOEF7Hi7IIsfX54cazXHXcEGfpXjPMwdTqfbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=pxapVnV1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2242B60A2600
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=pxapVnV1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9571F0093E;
	Wed, 25 Nov 2026 10:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795602873;
	bh=48H4ncuNbMxvmZ8ze98nkscvwkt+OV3XwOSCzy6v2Pg=;
	h=Subject:To:Cc:From:Date;
	b=pxapVnV1p2MY3AX6OXQg90UmTuh7vUOqjjl49X8b/gr0/M9WX82l4JU6E9qbwUiCb
	 QzWsWB0b5CiSSbpa810T4BsRGi9QwpBCzlG+03/UhDCOrG85vKekkUn31pDADCOAjZ
	 Pkr+t6Q06hG8EIRX0GEzPM7jYteKGGInYaXPchYk=
Subject: FAILED: patch "[PATCH] watchdog: rzv2h: Drop runtime PM handling from WDTDCR init" failed to apply to 6.12-stable tree
To: prabhakar.mahadev-lad.rj@bp.renesas.com,linux@roeck-us.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:15:42 +0100
Message-ID: <2026112542-doze-greedy-a67b@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f00afd5d8d5dc03994cb67246543d5c70571ebbe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112542-doze-greedy-a67b@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f00afd5d8d5dc03994cb67246543d5c70571ebbe Mon Sep 17 00:00:00 2001
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Date: Thu, 1 Oct 2026 17:51:58 +0100
Subject: [PATCH] watchdog: rzv2h: Drop runtime PM handling from WDTDCR init

WDTDCR is located in the CPG region, outside the watchdog module, and is
accessible regardless of the watchdog's clocks and reset state.

Drop the unnecessary runtime PM handling from WDTDCR initialization and
access the register directly.

Fixes: f6febd0a30b6e ("watchdog: Add Watchdog Timer driver for RZ/V2H(P)")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20261001165201.763882-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index 27ea0ad7e91c..c1c01ee7432c 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -257,20 +257,12 @@ static const struct watchdog_ops rzv2h_wdt_ops = {
 static int rzt2h_wdt_wdtdcr_init(struct platform_device *pdev,
 				 struct rzv2h_wdt_priv *priv)
 {
-	int ret;
-
 	priv->wdtdcr = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(priv->wdtdcr))
 		return PTR_ERR(priv->wdtdcr);
 
-	ret = pm_runtime_resume_and_get(&pdev->dev);
-	if (ret)
-		return ret;
-
 	rzt2h_wdt_wdtdcr_count_stop(priv);
 
-	pm_runtime_put_sync(&pdev->dev);
-
 	return 0;
 }
 

