Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5B64B2713
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447937; cv=none; b=HbSo+Akmz4ZPpX3V/+jDWS/8nX13FG0rDTeV9HXCHVQP9JJ8UosOgU+whzCG/HpSp1Vfy1d92KBFcXuO948dBQKNW3YcOAoKN6AdueF36EPh/FGZT6gZ8TCTHj0XyTIDL+xR06s6g3mF/iUWG3wfpd0CAbwGtu9EgGqSf1cDkxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447937; c=relaxed/simple;
	bh=iXz50wNH7qqpwZ1Aa2wZ66/Sm5hAH6CekmTtZ2IrCOs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CSWNtRZN3vniB2gOXCJ+x9e9nkXZyLYKbGYpzehwzE1hY/98X2vsKI5RInVNgeFH+N6osBUYGMby48OJGyXdKDIfPxhzOa9OTzD7vUQEeXRDM4fN6prbS01GDFSOfafJVWi7YoU7TZs140zIE7SPfWQd1p3FlF4e4YkR4s9+Cx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jSAYCro5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jSAYCro5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4D61F000E9;
	Thu,  3 Sep 2026 15:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447935;
	bh=YHaQO1+/6bdYzPBiLamPejVjIB8qjlNfNtAZXJHO/sA=;
	h=Subject:To:Cc:From:Date;
	b=jSAYCro5vD9qaTLbNv7NUD6brkvEO5zdwsNHmBNrY99Suj9Mz5CstWVHVPoOyLkhY
	 xtyTfff1YNDPoWm70j+JaEw1EzrYgLDIBmhv8UEmK9ibqtScRUtQxRKaOezvFE+znx
	 5jDbBQzvO5rOY2OTcc0lYUXowK0pOe3Uhy/f0IJg=
Subject: FAILED: patch "[PATCH] mmc: via-sdmmc: cancel card-detect work on remove" failed to apply to 6.1-stable tree
To: fanwu01@zju.edu.cn,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:47:08 +0200
Message-ID: <2026090308-pants-heritage-91be@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 57e5d877f898d5e5c9d672a77bb6bdd24f0d9bf5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090308-pants-heritage-91be@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

