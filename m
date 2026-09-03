Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F884C77A7
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447939; cv=none; b=heQCVtzmxCzzaFCDxXNnlXkR2/GAjEZ3xnJp6hoflQZEk68ZdOMCwiYeriNr0X8tLs0OJI5XNaiUvp24GoonQcujUCFMIsl1XN23znJQIoGtCWGfHMRIVjN3CUeiMLgSvoaTHIs3tF1bsxqR96HHI5o9AAazRz7/kuDRxh5I2kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447939; c=relaxed/simple;
	bh=Kru8n/7FSLI09WSfNHjOLhIFWysYZzEaoMTziMqW3B8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TIDgX7XA2NA3mY9OMbcSY2i+KGLQzCgqn2WjSinoiXBD4NE9hryIpyRCrsjCV7hR+wouT7d0oW3eRpq5rRElAPLdWplezL4jP/aZoFx+bF6FwWt+L4nIerI/gEZG/ecRnzXbe0AXhAUwNR5NZpdxDtP4FSI0yfhsmgOnY0A6q+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pIw+DFk4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pIw+DFk4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC301F000E9;
	Thu,  3 Sep 2026 15:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447938;
	bh=kSBBEJtjjJRxGQaPC5oi1/sivgbK2XrJbuiUAcE/HjY=;
	h=Subject:To:Cc:From:Date;
	b=pIw+DFk4NJ2ceq+XIs4Sl32+Smc3M3yj/wweK9+q/KkqAF/JHnWgQig3pXk4okEVP
	 Cm2oizfM4WOaEYwRNUPcU0NqZIxGBLesit/2sRg1x4Hw3aQJDZLc6r93VAinvtOLmT
	 YZUf8/DFzXIbU6VZzdyl/lYvIZXx0KNvT5oS2QJQ=
Subject: FAILED: patch "[PATCH] mmc: via-sdmmc: cancel card-detect work on remove" failed to apply to 6.6-stable tree
To: fanwu01@zju.edu.cn,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:47:08 +0200
Message-ID: <2026090308-drainage-dandruff-6985@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 57e5d877f898d5e5c9d672a77bb6bdd24f0d9bf5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090308-drainage-dandruff-6985@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 57e5d877f898d5e5c9d672a77bb6bdd24f0d9bf5 Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Thu, 23 Jul 2026 11:28:42 +0000
Subject: [PATCH] mmc: via-sdmmc: cancel card-detect work on remove

Disabling the device interrupt and freeing the IRQ prevents new card-detect
work from being queued, but carddet_work already queued by the handler can
still run after via_sd_remove() returns. via_sdc_card_detect() recovers the
host through container_of() and dereferences its MMIO base; once remove()
returns the host can be freed, so that work would touch freed memory.

Cancel carddet_work after freeing the IRQ and before cancelling
finish_bh_work, which the card-detect handler can also queue. carddet_work
can re-enable the interrupt through via_reset_pcictrl(); mask it again
afterwards.

This issue was found by an in-house static analysis tool and confirmed by
manual code review.

Fixes: f0bf7f61b840 ("mmc: Add new via-sdmmc host controller driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Signed-off-by: Ulf Hansson <ulfh@kernel.org>

diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
index 632de678532d..4910d0f444ba 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -1205,6 +1205,10 @@ static void via_sd_remove(struct pci_dev *pcidev)
 
 	free_irq(pcidev->irq, sdhost);
 
+	cancel_work_sync(&sdhost->carddet_work);
+	/* carddet_work may re-enable the interrupt via via_reset_pcictrl(). */
+	writeb(0x0, sdhost->pcictrl_mmiobase + VIA_CRDR_PCIINTCTRL);
+
 	timer_delete_sync(&sdhost->timer);
 
 	cancel_work_sync(&sdhost->finish_bh_work);

