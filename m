Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5B14C77AF
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447942; cv=none; b=hl6uHdMAQRDu2WFRy2CK4gbKD+ctELAfPntaI7YbnCDylzeoqvNVrbZMbuz/nF1eprowaSupAAcDMMYGEZend9KG9IVxeoPOOUX5mymVC+K3mVcTw6S2tb60XrcBZKadd6lV4KJNCv7gR/g9wHC4RjY4oStkc5vRbPKQpxWmVP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447942; c=relaxed/simple;
	bh=MSZHmakat7sKGbNsrL5a8n7/s15zzD4zD0feQRIQiDQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pCGOc7ETWMurBKBcx7r+Ce9Ecc+BpQz+tyDTSqM3dTew6vWoxDhTkNzW0ryHqeR0mSiN+I70b3sycTnigbjdVx8L7UGiPseTY3iQp+UWvbpdooeO9RPBGtj7B6uSORMTZx9EAoy7mjjQ9Q9vrX3qoY4fgg+7+4Cf1olXM/V/Ovo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BQ/a25pK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BQ/a25pK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A611F000E9;
	Thu,  3 Sep 2026 15:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447941;
	bh=CgqXBwaHUh23XuF4pEq1M0JoMWH4xT15oBWiTFPaRw8=;
	h=Subject:To:Cc:From:Date;
	b=BQ/a25pKF/fgwEOLt/MRSi+WrJINfVQnqPs2XBZyEvk3dHTGs9KImenNOht31ui0U
	 JHz2MJxrJl2OxBtOw1vMvjLXZGdbZYQpmiETn/H1FVnIn87aAbiI+BQg0Ke8ZCqEye
	 xaA47EXMV2req+UTX8BxQ4yf8XMFEyAJ17XkJgj8=
Subject: FAILED: patch "[PATCH] mmc: via-sdmmc: cancel card-detect work on remove" failed to apply to 5.10-stable tree
To: fanwu01@zju.edu.cn,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:47:09 +0200
Message-ID: <2026090309-gerbil-rickety-e7f6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 57e5d877f898d5e5c9d672a77bb6bdd24f0d9bf5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090309-gerbil-rickety-e7f6@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

