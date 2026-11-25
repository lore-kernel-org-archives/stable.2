Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602867;
	b=5Z1ooHV4tQeAUJeK3mgRPWCIdizc55UiVw+iF73ToGN/jrNQg+pkFQhn+eImeyE3U20z
	 3D6F2H3dFWUVK0h222XAvhU7yEsMR8EmY0uwj9aNTbVhByFHoy6yenZoM2uF23hn4gc0d
	 Fa73Ts9H07JRmPcihMeew848a7wk6XJ/keZCA5E5kuXm8s7hRoIjal5RPI8qyQxOWrLSC
	 Tc6DMK6VWkJ7RLkDo9cBe9Tk/mftrw87RVa5KBd1d8cV/171uwRJCWeWPi8r6NbBUI+lh
	 NXvzR3YtWQg83XZQwi25kW1q63j16sA/tSugzRH3XZTaa6ThoQv6G0gn9DLiPCDoLeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602867;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6UlQE3++LJ/VYORybYDsCwpIfKGmmLe3zJ5lUYuCed0=;
	b=im6kP1n9wnSuJW+azYjMfhFXy7hRXB6/ZwAQhKdtDPRtDRV2A6MMps1In553ttThCBkN
	 gawrc7XTs6S2ZrrFDw7O86p3iddsYh2Fd4ylIKhkn5JDSgSxwyMyPDjyTrjpbMhcDDkej
	 wFgfGYKFJS82hrrfVIuDPcw03CJHOA4DrKpQUkJMerIOOUGids8816uan36/gPHXP/BZ1
	 C75LlpQ5LaUA9KF6/AxtU9yAtwpiO9SyPPSbBgWa+LmRbbcosT4ZpoROgK2s6x0C2vYNN
	 fjCJzZfZR2Eq3ZmwaNtsXWpfEdDfJYYWaxGLGRBcUet4P+5KqhkwMZ4DmFpXzLrFBPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=dDgIddWq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B545D606A69B
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=dDgIddWq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF21A1F0156C;
	Wed, 25 Nov 2026 10:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795602867;
	bh=6UlQE3++LJ/VYORybYDsCwpIfKGmmLe3zJ5lUYuCed0=;
	h=Subject:To:Cc:From:Date;
	b=dDgIddWqNVjfDR+IdybIC76a81o7BaDb7OTAx2j/kzmogp6oGT50C9hV+E0hyt5NU
	 qP8DFVIZi/IbJE+I7ZZEM+Xbp6Lc1X3cGzy1uDAw08DTkro5wXPI5pa3ZyGyKdkOZ/
	 KL5W8r5R47G2BnPtWfkzaRmFJYaHFbYpKMmmhkgc=
Subject: FAILED: patch "[PATCH] watchdog: rzv2h: Use pm_runtime_put_sync()" failed to apply to 6.12-stable tree
To: prabhakar.mahadev-lad.rj@bp.renesas.com,linux@roeck-us.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:15:33 +0100
Message-ID: <2026112533-wand-debit-0e45@gregkh>
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
git cherry-pick -x ca800e625d18a9f5b19f94ab837ceb3fccdca22f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112533-wand-debit-0e45@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ca800e625d18a9f5b19f94ab837ceb3fccdca22f Mon Sep 17 00:00:00 2001
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Date: Thu, 1 Oct 2026 17:51:56 +0100
Subject: [PATCH] watchdog: rzv2h: Use pm_runtime_put_sync()

pm_runtime_put() may trigger the idle check after pm_runtime_disable()
is run as part of devm_pm_runtime_enable()'s cleanup action, leaving
runtime PM active.

Use pm_runtime_put_sync() to ensure the idle check runs synchronously.

Fixes: f6febd0a30b6e ("watchdog: Add Watchdog Timer driver for RZ/V2H(P)")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20261001165201.763882-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index 4353fa677778..27ea0ad7e91c 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -175,7 +175,7 @@ static int rzv2h_wdt_stop(struct watchdog_device *wdev)
 	if (priv->of_data->wdtdcr)
 		rzt2h_wdt_wdtdcr_count_stop(priv);
 
-	pm_runtime_put(wdev->parent);
+	pm_runtime_put_sync(wdev->parent);
 
 	return 0;
 }
@@ -269,7 +269,7 @@ static int rzt2h_wdt_wdtdcr_init(struct platform_device *pdev,
 
 	rzt2h_wdt_wdtdcr_count_stop(priv);
 
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
 
 	return 0;
 }

