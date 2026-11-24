Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533013;
	b=H+Ze4ga3VUUjOWJQxah5rmnYEtksXedBpmATHnOMQ4ZwmvsNMchCChk0qsvRwFPl/qRX
	 aRSN5ssfM9zympJWUz5CZBGGX6FXmErDS1cK5Fn4c4B2F+VMrupPgPhRUpJVR5xLP3aFm
	 zXJgWCuZ8mxs/g+EE8iUdMmF3hm8sjhbwdV9imBvFWZXVu/C+Vaj7rTe3+0De6qaCqkia
	 h+I1e1bsd19gmVrYXYYt6WaQmT6kFZJzrET+V7p7fe6Ee+vbtQza3F+VhrqbneVMMO+sc
	 VHZki2035S6DUXSPAPmP15JxQflDyHlVElD/GtlJRN35IYw+RiCbqTlfmRgkr3GL7qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533013;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3Iaddh/ACawqUDP7P5gmrNaMAW5R8x4yNOkHV3M2/8g=;
	b=1HV9x1hVUiI4dj8oeLHLlqVHRIEJet18lh65eSPTV9jJwgw85AXA9Tx2T/1doQLlorrt
	 DJ8o4gxTsijXb61EmpKPgVhNh/lixKlPZtPuvwmeiSjsjjjfiY9LrXcVrBGN06Yc1wD3f
	 tm5l/3bOZSACIXZTQ+5lVclQeZOhGCKItLtBs8BVFPHkh9qBHVOVjxkRaUxNDD3qtFF4w
	 d1QIPGsSsCKBWhkuuRHTaNZs6eP5DFzIzcs+smgS1KJYO91X9NY4ZD7IsJE6wGWHp5s56
	 BnUg8mI1Mt/+DyWgkgC2/MEKdAFbojVlJE6JjKftz3dlnWca4IarWEZogMxuC7mwx5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1FVqdUiX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A55D606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1FVqdUiX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92711F000C0;
	Tue, 24 Nov 2026 15:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795533013;
	bh=3Iaddh/ACawqUDP7P5gmrNaMAW5R8x4yNOkHV3M2/8g=;
	h=Subject:To:Cc:From:Date;
	b=1FVqdUiXpPtsAjOo4JfHLMV5OtwB3eg8cOobe12W37IqLMRZ4vueNI7sPXR7xNW+o
	 FYudidhNUGJxfBZDMMhLx0mau5keVSYi4ZxC8PfXrAB5SAHQqiczf5/G6lIUvkgzxK
	 VQMJNQN/B9LlCvuqC7Y1Y+Vmdq0z1tk9dBmWC0wg=
Subject: FAILED: patch "[PATCH] mmc: jz4740: Remove the host before resetting the controller" failed to apply to 6.12-stable tree
To: olivier@mgcrea.io,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:10:34 +0100
Message-ID: <2026112434-underfed-overdrawn-f84c@gregkh>
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
git cherry-pick -x 6b8b1e8827837bf4cf1f87219038fddae9e81b0b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112434-underfed-overdrawn-f84c@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6b8b1e8827837bf4cf1f87219038fddae9e81b0b Mon Sep 17 00:00:00 2001
From: Olivier Louvignes <olivier@mgcrea.io>
Date: Mon, 26 Oct 2026 09:33:23 +0100
Subject: [PATCH] mmc: jz4740: Remove the host before resetting the controller

jz4740_mmc_remove() masks every interrupt and resets the controller
before mmc_remove_host(), which removes the card and lets the card's
driver send its last commands. Those commands then run on a controller
that was just reset, and can wait out the driver's 5 s request timeout.

With an SDIO card that cost 5 s on every unbind: on a HiBy R1 (Ingenic
X1600, a BCM43430A1 driven by brcmfmac), the CMD52 that
sdio_release_irq() sends from brcmfmac's remove waited 5.1 s. The
command had finished (END_CMD_RES set in MSC_STAT), but MSC_IMASK read
0xffffffff although the request had unmasked END_CMD_RES. MSC_STAT can
still show IS_RESETTING after jz4740_mmc_reset() returns, so the reset
most likely completed after that write and undid it.

Remove the host first, then quiesce the controller, as other host
drivers do. On the R1, unbinding the Wi-Fi's MSC now takes 0.65 s.

Fixes: 61bfbdb85687 ("MMC: Add support for the controller on JZ4740 SoCs.")
Cc: stable@vger.kernel.org
Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
Signed-off-by: Ulf Hansson <ulfh@kernel.org>

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 6a3c26b7c82d..923cf1450de5 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -1151,12 +1151,13 @@ static void jz4740_mmc_remove(struct platform_device *pdev)
 {
 	struct jz4740_mmc_host *host = platform_get_drvdata(pdev);
 
+	/* The card's driver may still send commands as it goes */
+	mmc_remove_host(host->mmc);
+
 	timer_delete_sync(&host->timeout_timer);
 	jz4740_mmc_set_irq_enabled(host, 0xff, false);
 	jz4740_mmc_reset(host);
 
-	mmc_remove_host(host->mmc);
-
 	free_irq(host->irq, host);
 
 	if (host->use_dma)

