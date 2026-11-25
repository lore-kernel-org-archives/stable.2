Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602864;
	b=XeFVt+FdyXSvM7hLoNjntl9VcHIT280e3MYI4Vzebf8lnkmrSwVD8AluFJdc680VNGFu
	 MPVuSOhxPiJ4EOBEP2s4kBqHFTTg7MJCTuMcBDe6oTVo/4dA2nnWDIqus2iVwQXpvp3Aq
	 vr0bBzaLQSwzQIXem5qfyenrUs0pXuUrpqnNZUr/S2MGxZ+l75bKVImmQR1CqrzNcSTcp
	 /D0qJ3wsOkxiJZUbzc+5OsOtuGleUyzwlSqBLeP5Ubm0tHfCOvUCF3rC0Bu9vYDYX/0v1
	 8xt2ujBr8/rT0S6LGZZsVGDR1jZor2Ohx+rekgZq/tSmsmK3aSVHG7FFkdEZeMVyJCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602864;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=U9EYwlIJKPL2oF3/PEpuRLtiuAAEZUqZ8t1OVa1BOgI=;
	b=O+Zb/s2VAvSx0tvU6Jovc0d9WHIgCQfD0GaLN3VXDlFeGAE/zdDzLoliCLqn1SpazLWb
	 vNlbHdnXTUvzGPK3aE0e9A+MtjYP3zBXNRIdYzCeaUHMK7HFntdt3SivCd90kgsVQqaD9
	 Wc2KOOmUBcLzgvTntgWJoUxtbWmY5rnkJAADokEpC3/t9uU3xelcdVCuYSTDeYGuyKKkM
	 yQ3eKOvrNkrBEZdmDZnhHs6NM7E+JUQDheWFcUUBd98IPhvqoBFcYX2aJ6L3Tyt/YKAVs
	 /3O9fyHYfgh/Jksa58ELx5e/yB0i8yo9usDwhL6dJiyQ4S3lgxhP8vY/cvmfnRt887A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=sZcvxRE6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30922606A6B8
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=sZcvxRE6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E1D1F00A3E;
	Wed, 25 Nov 2026 10:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795602863;
	bh=U9EYwlIJKPL2oF3/PEpuRLtiuAAEZUqZ8t1OVa1BOgI=;
	h=Subject:To:Cc:From:Date;
	b=sZcvxRE6VLf91i4qXjrjpwqSe424q/XLZ15jVmVusyjE6hVzGlIabL+0kSlOw3Svg
	 LWuaI4xBptRjC7emLLUq1oRaqc3DWpXmmmIjGy2/h/ENPRLrzjupLN37P8anjv0M0x
	 qadSy0v0Zl0TIO5OYbXbIVcUsTZGBFb+vVy7fGRs=
Subject: FAILED: patch "[PATCH] watchdog: npcm: fix clock prepare leak when setting timeout" failed to apply to 6.12-stable tree
To: zhaofeng2@cmss.chinamobile.com,linux@roeck-us.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:15:22 +0100
Message-ID: <2026112521-cartel-refresh-660a@gregkh>
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
git cherry-pick -x 57c7cbe21acc77291ec0fbdd4bd72aa259cf4986
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112521-cartel-refresh-660a@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

