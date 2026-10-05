Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FD3149C7B
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190009; cv=none; b=TmyCmAgjs4Xs6mwNLvSNl7SOyetVpjDTu6kaNu6dBCGPSJ2AZADSaoomJtX8G7iNxbbFwe3rUmZziOgn7P8YBgqKjfnLDtlBkRjnQ4T1yNfSazo7xWYcPnDpTtNbwKnEfy8J1k8KWPgixHpan42RdM3E/BW6Vnfp1hVi2a7Oy2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190009; c=relaxed/simple;
	bh=qsFWyvUnqf4NCemtfrD3H2xQldAgpM9CBcK6e4WuAKM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ac/SyHCobqW280FsqEVLZVqlK1jSUPcOt2qB+NiUtleIbcs0do/o1W4Ib2T2A56B9P2FIAaUcGTY1xFl9tTH9A91T1vg0AuX00bUCDgpBB8Fam17MUuJ1/TEtstV0nPoiK0tzGTXHWUr93dXDXRr3MhaQeSrLoxRoMj4qau3wxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0BCC2kB5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0BCC2kB5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780DD1F000FF;
	Mon,  5 Oct 2026 08:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791190008;
	bh=weIpnn2HqTAk8mEooZBQp1v7Ypck7Q0nOf+m0hgPVtM=;
	h=Subject:To:Cc:From:Date;
	b=0BCC2kB5+VfFKpBE2NMG2j8MeUH+0GPniXTOgqUCCIVNhQl5xGDATBsY+mr8Ka3rD
	 0N8X4hdJvPHxVRaSzqCfsZtDOEHnipyL8SdklN6lLU7nkBPq4M+q4Nb/16oVaaqOIe
	 if/EOEyolnKv/Z2rk060StJuXlR7vDbGxj6gfVVY=
Subject: FAILED: patch "[PATCH] USB: dwc2: shut down wakeup timer before freeing HCD state" failed to apply to 5.10-stable tree
To: runyu.xiao@seu.edu.cn,Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:46:31 +0200
Message-ID: <2026100531-anthology-unchanged-ee00@gregkh>
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
git cherry-pick -x fd772af9512cdecb83de34a461801533828e77fd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100531-anthology-unchanged-ee00@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

