Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602857;
	b=JxRXtViWc2fOesThM5UAwXQqpNsp29awmm3n77Fu7NXUx6e/bwf+aMUdnJTSSugUWBro
	 Z5NFgOjhfe7g6WMy4moPOYwpBTaYsgxX3UCZIeRRKFfdxYojzq+2lWWtGDKhxqYG50E2t
	 3iEZDayD9uEaKGOy7DDcZUtEgZ19n2qbLf/LjR4yfIcHSaoaMCvgVpx82kT0HXgTQA6Vn
	 9FT7yL2G5U8J9EcU6f0Xl4hJ12D0RLRQsXE8WeY38g51PtMNf8DADopFXiFwCT0ZW7gUU
	 3IdNY39Wsj/tUVvJ0ZIiX2QB9iVtt5+VpqzeW4qGMlKCWqHTJHjEguFDqUCyB8DOiFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602857;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4su7b6unfJBf1qeiNYb6F4nj7vSQXhRos9dJG/Am0ic=;
	b=ntmFL0qkhIxams9flEMq50uF8MRaxe3KloE4gG9oKGUg8x0V4GSp3wPl7VuLzfi4drsM
	 D8TVboBW/MqyPyxl670p5ijcuvLkWy774HkvNKZnHZvf1vTbVZpavfSoqV4HNEJZbhkm1
	 8lZC9t1K3vXxLGj6aPRWgut7NAmY3rIBogJMM3Y9slgzZrY2wn0l+Q4y7L7RU7U3G02x9
	 KZCVk7hCfAjzGU2jS21wlGTKUDcvDbINmA9J8wvgyDzlDpY8nbu7dwQ5ycJ6qnfdl4U5o
	 DpAOSY3CFiJgkYetxmgpUrzzvhn2TrpeAWe1IhvqmNav/KRtR7uYNIbSdKWHTQO5WPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=clSGHW3l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93062606A32A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=clSGHW3l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7FA1F000C4;
	Wed, 25 Nov 2026 10:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795602857;
	bh=4su7b6unfJBf1qeiNYb6F4nj7vSQXhRos9dJG/Am0ic=;
	h=Subject:To:Cc:From:Date;
	b=clSGHW3l+k6KimK9jhAbH+GPxlC5m9w+LQzE+hmaAjh1yq6FBAoTnRMPhhZx1yuz6
	 4ri8wf4lhYTkg45INEPqjp0xBBVU5XpXwTqahsO9xI0vBV4drlHohAIuyxfTDDNTav
	 0PxRbutV9Jn5n7jcNmup/r5DjAbGUJfXHFfJo/p4=
Subject: FAILED: patch "[PATCH] watchdog: npcm: fix clock prepare leak when setting timeout" failed to apply to 6.6-stable tree
To: zhaofeng2@cmss.chinamobile.com,linux@roeck-us.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:15:22 +0100
Message-ID: <2026112522-ocean-schilling-8a8f@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 57c7cbe21acc77291ec0fbdd4bd72aa259cf4986
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112522-ocean-schilling-8a8f@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 57c7cbe21acc77291ec0fbdd4bd72aa259cf4986 Mon Sep 17 00:00:00 2001
From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
Date: Mon, 9 Nov 2026 15:10:03 +0800
Subject: [PATCH] watchdog: npcm: fix clock prepare leak when setting timeout
 on a running watchdog

npcm_wdt_start() unconditionally prepares and enables the watchdog
clock, and npcm_wdt_stop() is the only place that disables it.
npcm_wdt_set_timeout() calls npcm_wdt_start() again whenever the
watchdog is already active, so every WDIOC_SETTIMEOUT ioctl issued
while the watchdog is running takes one extra clock prepare/enable
reference that is never dropped.

Split the register programming out of npcm_wdt_start() into a
__npcm_wdt_start() helper that assumes the clock is already running,
and call the helper from npcm_wdt_set_timeout() instead; only the
watchdog .start callback (and the restart path, which intentionally
keeps the clock) now acquires the clock.

Fixes: af084fdccfaf ("watchdog: npcm: Enable clock if provided")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
Link: https://patch.msgid.link/20261109071004.1506-1-zhaofeng2@cmss.chinamobile.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>

diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
index 4d8f21287144..07ea810fb8c9 100644
--- a/drivers/watchdog/npcm_wdt.c
+++ b/drivers/watchdog/npcm_wdt.c
@@ -145,13 +145,11 @@ static int npcm_wdt_ping(struct watchdog_device *wdd)
 	return 0;
 }
 
-static int npcm_wdt_start(struct watchdog_device *wdd)
+static void __npcm_wdt_start(struct watchdog_device *wdd)
 {
 	struct npcm_wdt *wdt = to_npcm_wdt(wdd);
 	u32 val;
 
-	clk_prepare_enable(wdt->clk);
-
 	if (wdd->timeout < 2)
 		val = 0x800;
 	else if (wdd->timeout < 3)
@@ -176,6 +174,15 @@ static int npcm_wdt_start(struct watchdog_device *wdd)
 	val |= NPCM_WTRE | NPCM_WTE | NPCM_WTR | NPCM_WTIE;
 
 	writel(val, wdt->reg);
+}
+
+static int npcm_wdt_start(struct watchdog_device *wdd)
+{
+	struct npcm_wdt *wdt = to_npcm_wdt(wdd);
+
+	clk_prepare_enable(wdt->clk);
+
+	__npcm_wdt_start(wdd);
 
 	return 0;
 }
@@ -216,7 +223,7 @@ static int npcm_wdt_set_timeout(struct watchdog_device *wdd,
 		wdd->timeout = 2750;
 
 	if (watchdog_active(wdd))
-		npcm_wdt_start(wdd);
+		__npcm_wdt_start(wdd);
 
 	return 0;
 }

