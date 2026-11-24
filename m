Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533031;
	b=Ve2OQc8sx9AQoxTLCvLElKGhAs27xwTsFTKrBTdlYUk8T3Z1SLp7+Jrg/KUSNJ/aPhjq
	 Jehgt9iENEO87sTiogxbQ1tur7C1/GLWZ+Fimed5QV2trPbMU5Jb0OIM3u0oAfklkWTD5
	 ZY2B1VT/P8J3fp9WT+9n8lH0KBiHGkO23DDZHv+d+T+XIP93FTLG6iW/vtVmpOIihkamk
	 /ufGdcVrwZ2womxIhhZUAvwUx/XRLpjQ5xHrlI2pidMmFeHSb8HjDWxqUll7862GDjW2n
	 RGBIgR67Wjkti54jxRrhbdqcpF/VJZ/18zssTrIKDyL0qyKpPqrsd6mH/Wcy5uTArSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533031;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=gbSmFhpRTpc1PTImA2u0/ThEpcnM1lJA0M0xozJ6NgI=;
	b=Eh1k5o8FO+sbv9luEA2b7wWkwaxmZCEULxszm0K3ZctFLXuTjY19wdUmAqwF+XHqxSpC
	 Eg5hqXjrj/tq1CG/vg8z4IqNt8K4r23y+OHznBC8B5z2qL+NUdHDRZ5T3zaqmpKGyO+D3
	 EzHM7cU4d/P40MkG+CEOUKwPE4RlClz28MEW6gDDWFBLEZimUdUeLsR9rn6V0Ly1AMT2k
	 ybp5nm42yZX1DVDJiYkVIR94kaCjU5UByAWlBuB8NPvAnQTnuALyT0cAt1EgaESxLkXIw
	 orVnjrFsC0tbFaFxQy9QJGFpwVeDOPKLOY5f5rxnoS1nQPegAXcWp4pzHDdXCp9kp9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=No5XPsxa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B90606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=No5XPsxa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F781F000C6;
	Tue, 24 Nov 2026 15:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795533030;
	bh=gbSmFhpRTpc1PTImA2u0/ThEpcnM1lJA0M0xozJ6NgI=;
	h=Subject:To:Cc:From:Date;
	b=No5XPsxaTwwdCGsZaw+FGjzUKred400uKwHT12igkC6zHxI3UxrbK3xZ6EaskcHA7
	 jMzU+u4WXtTyhzz6+6tBBBUr4DM/O0x22YMrNFXJHrBGjWCZ/Jn3suWidYaT1qyyZ3
	 j1o3quBE9xW1sL6qaFheAtxVkQ058qNGy2ddys/4=
Subject: FAILED: patch "[PATCH] mmc: jz4740: Remove the host before resetting the controller" failed to apply to 6.1-stable tree
To: olivier@mgcrea.io,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:10:35 +0100
Message-ID: <2026112435-glamour-animating-1da7@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6b8b1e8827837bf4cf1f87219038fddae9e81b0b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112435-glamour-animating-1da7@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

