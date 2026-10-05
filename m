Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D575837268C
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791189734; cv=none; b=KSiEwvU9csDWe4W2s1UbJfiwDPiZO7Wralx70u/MXJMr4alYMgJoyvoo9ds7ZDauicQwU3oERxhYIuLtpOwxnK51ufWeRcFzRvs392hUgPdfBitbhA9NL5LwO9nrOctYx7kRmgczCN2fkPRuTHRupveurGfOv7KyXXLuHVSStqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791189734; c=relaxed/simple;
	bh=ywZfR3DGTgp35IiO6MOSDeRej4uiVyEMTL7Ivvdgcio=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=C3R061qva1u7s7b7TQKlbSrVWqnbSrkG0XZb5Xky9yp0rWu5SsbFr9/NUQgYp4ckF5fdQuDY2jMtbZ0EwLHCaPKgikNH/08vUeN5VfUVqW95FfoRhxKqkEc6+czIS/DOXV5BpliBGMktUFN8od/Q/uK/9os5Tp/nAw+HZrVCf/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nse0P/OD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nse0P/OD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016BC1F000FF;
	Mon,  5 Oct 2026 08:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791189732;
	bh=0LnEbj/YkQcTdqqM0grX98blwGxcq68vQj5M6LSBRt0=;
	h=Subject:To:Cc:From:Date;
	b=Nse0P/ODLBac/klSpDDsCXpPBDwOm9Jj9YE9S/rDo163r14oE/glymMoX1jNy1QG9
	 ll7+vMV2fspqcE+ujJXtU+9vOuxKdtypR/gMi6k+upM5X4GhMNCuOuxsEwQdKttHtW
	 RejZbv+MpY32OOj46yBT/D/0XT+GRuoN7tZ9hE3Q=
Subject: FAILED: patch "[PATCH] usb: ohci-spear: disable controller wakeup on removal" failed to apply to 6.6-stable tree
To: mhun512@gmail.com,ae878000@gmail.com,gregkh@linuxfoundation.org,stable@kernel.org,stern@rowland.harvard.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:42:01 +0200
Message-ID: <2026100501-compare-xerox-0894@gregkh>
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
git cherry-pick -x b1b0f8bdbbc891a4ee7f3b1a878c633e02b7bbeb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100501-compare-xerox-0894@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b1b0f8bdbbc891a4ee7f3b1a878c633e02b7bbeb Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Mon, 14 Sep 2026 21:20:10 -0400
Subject: [PATCH] usb: ohci-spear: disable controller wakeup on removal

Probe enables controller wakeup after the OHCI core marks controllers with
RemoteWakeupConnected as wakeup-capable. Removal does not undo this, so the
wakeup source can remain attached after driver unbind.

Disable controller wakeup after removing the HCD.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: a6eeeb9f45b5 ("USB: Update USB default wakeup settings")
Cc: stable <stable@kernel.org>
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://patch.msgid.link/20260915012011.61874-4-mhun512@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/ohci-spear.c b/drivers/usb/host/ohci-spear.c
index 6843d7cb3f9f..5aeabb051265 100644
--- a/drivers/usb/host/ohci-spear.c
+++ b/drivers/usb/host/ohci-spear.c
@@ -103,6 +103,7 @@ static void spear_ohci_hcd_drv_remove(struct platform_device *pdev)
 	struct spear_ohci *sohci_p = to_spear_ohci(hcd);
 
 	usb_remove_hcd(hcd);
+	device_wakeup_disable(hcd->self.controller);
 	clk_disable_unprepare(sohci_p->clk);
 
 	usb_put_hcd(hcd);

