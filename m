Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88874418A5B
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190003; cv=none; b=p/oj6JxOP9A5PPwPvdu3jCzLzWNdkjNLWnsJ/E1OQ3a1txibIMk0+NJqfBGVVOEdb2A8BTJS9nEsbXRN/HPPxPyVeVX/D4ioNegvNSabbBlumEO3EXcWnlj08wifQL2pPnDORcbyTecNvGwFbjGc7HGYqiVp5Qj0RGxqPvT9kbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190003; c=relaxed/simple;
	bh=xv0R3PwP2N01UtMxVDB5/IfU0HCvaQOSi1WSdrnXV4k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tmXKzf5ru5RmfdgoSPWmzKLBwOimUx0fe+HHUhxekbxWYlaOm6uwWtXmE21BDRaqe8251Bey3OUAuOcPcSLq0IMQLExok2d1sOTUWuAC2ca5dmUJRIYkALOamWaWfvUNqIT8hOhYsCSTD9FHxHZd0SoRj36KehKrpnZ15cjg0bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H9eMGZVF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H9eMGZVF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963C81F00898;
	Mon,  5 Oct 2026 08:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791190001;
	bh=cFWYCzAXo1wWlcc8zhwwdBBDYFBIZhZWql8FluniACI=;
	h=Subject:To:Cc:From:Date;
	b=H9eMGZVFo7F61iQJsQRhFzhBdpoCZe8l6MOuq4o/X4ytFzFKrfdZbBV29zuW4TOZj
	 FwmBJqp3wgZ1ZtjIqBOd1rseDHJOcLSY36VMlUPVPiq1T7L9y+fCE6iGbpK+ytCuBp
	 WbYUI033kTR1NSOSR6WUJ8oAvnel6tXpLXrKaEu0=
Subject: FAILED: patch "[PATCH] USB: dwc2: shut down wakeup timer before freeing HCD state" failed to apply to 6.1-stable tree
To: runyu.xiao@seu.edu.cn,Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:46:30 +0200
Message-ID: <2026100530-bubbly-straddle-1724@gregkh>
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
git cherry-pick -x fd772af9512cdecb83de34a461801533828e77fd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100530-bubbly-straddle-1724@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fd772af9512cdecb83de34a461801533828e77fd Mon Sep 17 00:00:00 2001
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Fri, 4 Sep 2026 14:53:23 +0800
Subject: [PATCH] USB: dwc2: shut down wakeup timer before freeing HCD state

dwc2_wakeup_detected() accesses the DWC2 host state and can rearm the
wakeup timer.  dwc2_hcd_free() currently deletes the timer only after
freeing host-owned state, and timer_delete() does not synchronize a
callback or prevent it from being queued again.

Stop and shut down the timer in dwc2_hcd_release(), before the HCD
resources are freed.  This covers both the HCD initialization error path
and normal HCD removal.

Fixes: 7359d482eb4d ("staging: HCD files for the DWC2 driver")
Cc: stable <stable@kernel.org>
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Reviewed-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://patch.msgid.link/20260904065323.4047026-1-runyu.xiao@seu.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 2414291aa908..cd0dc876b421 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -5082,14 +5082,13 @@ static void dwc2_hcd_free(struct dwc2_hsotg *hsotg)
 	}
 
 	cancel_work_sync(&hsotg->phy_reset_work);
-
-	timer_delete(&hsotg->wkp_timer);
 }
 
 static void dwc2_hcd_release(struct dwc2_hsotg *hsotg)
 {
 	/* Turn off all host-specific interrupts */
 	dwc2_disable_host_interrupts(hsotg);
+	timer_shutdown_sync(&hsotg->wkp_timer);
 
 	dwc2_hcd_free(hsotg);
 }

