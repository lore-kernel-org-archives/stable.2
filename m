Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533022;
	b=eiYPAVf2fX4708M4QY6STvlxuxcYbhRv32pQN3RglVdKfwcAh4pyOmQOgYpl9tR3lSlw
	 CoWBWzW40GGmOAoA7vAuJFHZqIfxx4r0b8dC6zaKbRWsKQNBfQNGk0TuB/bBH0wgOkhTo
	 +W3dCHm5pCjjT4eBQAPHZw9vCE87fDGBNhTefq07ZZXYCnuZFBfkKO+c5AybcarLmEzS3
	 ++Br2irBGMpWAMuaQx9LAD+vVjeMm9pQ8fWcbN9rDUhOs3ARACrTsAw1DP54sb7RkdN5U
	 6irHlR9wTPiRrrv5vl/ivRUx6CMPA9lVfw8NfEmqcs7cZfwnJj9KdDn8s/NVZoZPZ+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533022;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=iTJKzMpr9ZYIWek4smph22SISyp87tYDlhWTfQxA0cY=;
	b=KvAoMthywAJJG86rSOUa3pbbh4pWBy6yOEGnuwAkwKAjh7AYruSviIczgg86Ror1sEFJ
	 3qiQ9/NlwG5+uyOFRMonpLXA+wRuiPnH/MovDa3wRjNCZnuAyOM/a153z4BXtFiIJop0m
	 n1b8WTjpCkX4+tGQHuwT/e8pAboqRM1FXME7OoUhqod/SNZ9nthN0XlOYYuzXcVD3bJat
	 4f/Dz2xqQOgBREr3TBBp+9els8xSWMvsMnjaHToWsXYovcoBV2fMNnkeVtNpBvZUMy1Kf
	 ftYXVLiUQvb30NT4SPtzn17m990Q393BjeVbWUIrtbxEeuK9Al6VisRPO0VX2VKg+Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=I2EA8C4L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB28606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=I2EA8C4L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B3E1F000C4;
	Tue, 24 Nov 2026 15:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795533021;
	bh=iTJKzMpr9ZYIWek4smph22SISyp87tYDlhWTfQxA0cY=;
	h=Subject:To:Cc:From:Date;
	b=I2EA8C4LG6xCVdhkyFrEt7HOYEVQBl9TrmIOfv/IEfSPmnm7QskOZI9N7GRbxqbJq
	 +W9+BzRRwWqF300kqWvwJrKeZF7Eh8xN1gx885ziYSVHoqNE3FRUoeRokmTmF2cWIy
	 v6pJ5/Fc7HFNH9plGfjvDU+6UJiI76zUg/usW97o=
Subject: FAILED: patch "[PATCH] mmc: jz4740: Remove the host before resetting the controller" failed to apply to 6.6-stable tree
To: olivier@mgcrea.io,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:10:34 +0100
Message-ID: <2026112434-enchilada-curled-d598@gregkh>
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
git cherry-pick -x 6b8b1e8827837bf4cf1f87219038fddae9e81b0b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112434-enchilada-curled-d598@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

