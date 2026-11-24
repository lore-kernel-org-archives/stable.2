Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533028;
	b=ijxoS/j85QZGON3gC8Tj7foazyvn+9UfxL4Koz2CXI0c19zodhK/PF3tOi6vj29rMDq2
	 Xs0vXWWI7BcqbcVJPk9HmqFldEZXSxZ8kndsxaF65ooowE9zNjnAILPQzYOO4f957tW6K
	 QdTe3SqdOtdLM/S8bCHOg98dbkEzfdwh/Lr/vP0sk5jk6nRuyPocoTJidost280oxd25d
	 ZmEojjZZxh+uJ8Ybgb1mhb3CTvHpH2y+Php47FfT5UzE1jBI3nal+IYLZyA/2RlYO8CcZ
	 9FTzQMfJb+1Ib7d4smuMc7pFGm0WgESnItllhQ+aYv3hpy07jQK8pzn4OYUJ/DA/3KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533028;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2dy4pVciuW/NtQJVAW20ZB4SFxxQOiIkDD11VuwfuJs=;
	b=audHxD7ABKSXbvNaEqP1RtkpT3xXqaChR0RC5dp+0z1lHwiGT639iRCG1KP+DmT7kjr1
	 Nxhx7HcivSwLl180WD7MTUg4/cIhkCtI8zAfme/Y6D5GYl8hJDUbXtBTeMoF0AwTHNC0b
	 8LcGarutK6R3mBAA6fEHJp6pv/wWzwbIVcOP250tPRA944GzhqG511Gqu7PUGydkrVP5y
	 7NyFnvSNpU3m9Csxmf1aBbySSCdFA11lVUDRMMD0+/358yCF/WQ8QH7kE8tGrv2zCTTUH
	 yvGmjpjgunMd3sGuVG4R/2BAzQ7uY2RT82M2exDZuMrb5qjkHHIhWvK4spUnEK0SjyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Zdvs4uwv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2963F606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Zdvs4uwv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5037C1F000C0;
	Tue, 24 Nov 2026 15:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795533027;
	bh=2dy4pVciuW/NtQJVAW20ZB4SFxxQOiIkDD11VuwfuJs=;
	h=Subject:To:Cc:From:Date;
	b=Zdvs4uwvKq/v73cePv4lh0yH9HprNa6duubKErkgl5xPVYBR7Dl5TRK5BSbQPKAlL
	 On99YNuyBdeSmGqhg8YjsTNht5kkfI2eLQEwYM2OEAWGZMik9SfcuS3KtJHd39rDKH
	 Ow+OhldQasUx7ehEh+S7EletkrHeDi2GVWbkrEFQ=
Subject: FAILED: patch "[PATCH] mmc: jz4740: Remove the host before resetting the controller" failed to apply to 5.10-stable tree
To: olivier@mgcrea.io,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:10:35 +0100
Message-ID: <2026112435-active-relight-4a16@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6b8b1e8827837bf4cf1f87219038fddae9e81b0b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112435-active-relight-4a16@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

