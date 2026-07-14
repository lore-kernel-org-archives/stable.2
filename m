Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263EE4A3417
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044972; cv=none; b=HYQKU++MAUMKVvAgUWU/xV1jjheSinPdClT6c+9A8DHjgdWwk2xN6Kjb+bVzlX5PFGJQUlBhQOQxbSw8Wk6LGEozo8AVJ9MwVJdj9q1rLCvU5o1qBVae4qU1rM3zypdS7zB5+a4U5ezc4DUDbvrTGABLBhkG7DC3Kejb9uDYs/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044972; c=relaxed/simple;
	bh=lH5EZUY8R6QA3gSCCF78TsIp7/+fu9Oz9WBPVYzBZ8g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=h+U1rve/xdgc0gTvf0uBKOKZlOYE9mn3Cc10Qel5Ns5wVR7o+VsrPKzYXRLFCqhH0c0BLpqTt1liZqQeY+DV82kqy0ORIGmxaVvEnw54aDXvWUG4GUd6ONxKeB75zayAncOGGAP+7pEw03dFDr2LZjKUPCwBAG98Q+d7PpmDQzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I6XpR9q9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I6XpR9q9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1601F00A3A;
	Tue, 14 Jul 2026 16:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784044971;
	bh=ibxvjIjlgHrnAI5/sc/STvN/3IJsgQv5absC2wrKekY=;
	h=Subject:To:Cc:From:Date;
	b=I6XpR9q9tpG/WVjaBCUE4ZsjkL9QF4HXuXaV//QR7iSoED3wpQirfF0S7sDtEwHBP
	 oPm844RW0sLB+d33Lmqq+y2R+F0LKj3S75/2PHz/8+EAjkAD3GeodF15HzlFG0Q8wL
	 lLuhCEA649SNDN03Ys5gCKhmFib4awMxrN20h8Pw=
Subject: FAILED: patch "[PATCH] usb: free iso schedules on failed submit" failed to apply to 5.15-stable tree
To: dawei.feng@seu.edu.cn,gregkh@linuxfoundation.org,stable@kernel.org,stern@rowland.harvard.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 18:02:34 +0200
Message-ID: <2026071434-steed-earmuff-b781@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x b9399d25fbb34a05bbe76eeedd730f62ff2670e9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071434-steed-earmuff-b781@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b9399d25fbb34a05bbe76eeedd730f62ff2670e9 Mon Sep 17 00:00:00 2001
From: Dawei Feng <dawei.feng@seu.edu.cn>
Date: Tue, 30 Jun 2026 15:14:19 +0800
Subject: [PATCH] usb: free iso schedules on failed submit

EHCI and FOTG210 isochronous submits build an ehci_iso_sched before
linking the URB to the endpoint queue, and keep the staged schedule in
urb->hcpriv until iso_stream_schedule() and the link helpers consume it.
If the controller is no longer accessible, or usb_hcd_link_urb_to_ep()
fails, submit jumps to done_not_linked before that handoff happens and
leaks the staged schedule still attached to urb->hcpriv.

Free the staged schedule from done_not_linked when submit fails before
the URB is linked and clear urb->hcpriv after the free.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still
present in v7.1.1.

An x86_64 allyesconfig build showed no new warnings. As we do not have an
EHCI host controller with a USB isochronous device to test with, no
runtime testing was able to be performed.

Fixes: 8de98402652c ("[PATCH] USB: Fix USB suspend/resume crasher (#2)")
Fixes: e9df41c5c589 ("USB: make HCDs responsible for managing endpoint queues")
Fixes: 7d50195f6c50 ("usb: host: Faraday fotg210-hcd driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://patch.msgid.link/20260630071419.349161-1-dawei.feng@seu.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/fotg210/fotg210-hcd.c b/drivers/usb/fotg210/fotg210-hcd.c
index 1a48329a4e08..956be5b56510 100644
--- a/drivers/usb/fotg210/fotg210-hcd.c
+++ b/drivers/usb/fotg210/fotg210-hcd.c
@@ -4267,8 +4267,6 @@ static int iso_stream_schedule(struct fotg210_hcd *fotg210, struct urb *urb,
 	return 0;
 
 fail:
-	iso_sched_free(stream, sched);
-	urb->hcpriv = NULL;
 	return status;
 }
 
@@ -4562,6 +4560,10 @@ static int itd_submit(struct fotg210_hcd *fotg210, struct urb *urb,
 	else
 		usb_hcd_unlink_urb_from_ep(fotg210_to_hcd(fotg210), urb);
 done_not_linked:
+	if (status < 0) {
+		iso_sched_free(stream, urb->hcpriv);
+		urb->hcpriv = NULL;
+	}
 	spin_unlock_irqrestore(&fotg210->lock, flags);
 done:
 	return status;
diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
index a241337c9af8..57d07d1c2dfa 100644
--- a/drivers/usb/host/ehci-sched.c
+++ b/drivers/usb/host/ehci-sched.c
@@ -1623,6 +1623,7 @@ iso_stream_schedule(
 			status = 1;	/* and give it back immediately */
 			iso_sched_free(stream, sched);
 			sched = NULL;
+			urb->hcpriv = NULL;
 		}
 	}
 	urb->error_count = skip / period;
@@ -1653,8 +1654,6 @@ iso_stream_schedule(
 	return status;
 
  fail:
-	iso_sched_free(stream, sched);
-	urb->hcpriv = NULL;
 	return status;
 }
 
@@ -1966,6 +1965,10 @@ static int itd_submit(struct ehci_hcd *ehci, struct urb *urb,
 		usb_hcd_unlink_urb_from_ep(ehci_to_hcd(ehci), urb);
 	}
  done_not_linked:
+	if (status < 0) {
+		iso_sched_free(stream, urb->hcpriv);
+		urb->hcpriv = NULL;
+	}
 	spin_unlock_irqrestore(&ehci->lock, flags);
  done:
 	return status;
@@ -2343,6 +2346,10 @@ static int sitd_submit(struct ehci_hcd *ehci, struct urb *urb,
 		usb_hcd_unlink_urb_from_ep(ehci_to_hcd(ehci), urb);
 	}
  done_not_linked:
+	if (status < 0) {
+		iso_sched_free(stream, urb->hcpriv);
+		urb->hcpriv = NULL;
+	}
 	spin_unlock_irqrestore(&ehci->lock, flags);
  done:
 	return status;

