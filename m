Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F19416872
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190006; cv=none; b=AmJIt/p+K79bf8VSogfco2HlI7tG5MzSoQd7iwaGs92Qr8krb2Tg2meSb7Alw19ehOPtJpMpt5eFn2T49kWV2hvUW+6Yi1K1BUbimEFeUJ7woEl0MouFnKainH/VUzBSfyS2nwDxIlWTQfB9wQUMCaTKtUnc+I/bPLz1FCv+ATo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190006; c=relaxed/simple;
	bh=EYulFYcJdeYKkLIdeQSL/MCIiNQ8tXrjGFA/YtFFAxk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=u1edL5UEIU0M8aqwKTnEaqZ75GNx2XLk7SL0HptHVat07TehqQA0AVJUPqHw2eb5uKWuTAyaq7LDX+I/PiRMS9Z7vP1X9HwTQn3aDryP/FZRFG+XU7FTwWp++ozmfPX4uzUU8r6CuT8BGzyCOnjyduX7Y6GinJEJ+z4pNMxwrFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BHKvSdg1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BHKvSdg1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FF11F00893;
	Mon,  5 Oct 2026 08:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791190004;
	bh=SPSBG1EfhgiLrsp2BW3w+zHxiXhdRkuDstwaQtENwzE=;
	h=Subject:To:Cc:From:Date;
	b=BHKvSdg1xWBUzghcWJs+9x8L0flX1AGmVJl/noT5vOPVv19VTUYKYPmXD7E0s4Fe2
	 6lyGjldMKbCE/TML++yZj2OiJYBw7DNpQ4g/rPvQRuoEBnvot7D34lahJipAIeR3/B
	 zeqQ0MMxB7990VdEbi7s1o8diDTjv8X4JbSn8eG0=
Subject: FAILED: patch "[PATCH] USB: dwc2: shut down wakeup timer before freeing HCD state" failed to apply to 6.6-stable tree
To: runyu.xiao@seu.edu.cn,Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:46:30 +0200
Message-ID: <2026100530-judicial-cilantro-08d1@gregkh>
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
git cherry-pick -x fd772af9512cdecb83de34a461801533828e77fd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100530-judicial-cilantro-08d1@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

