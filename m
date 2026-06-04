Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E919F13D51E
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562950; cv=none; b=ZTt34Bnbg2a5jh5BBL/P8xBeI0Y29ham2+RdHS8cH3E9eIaw6Tc/Qa4ZqCECL2/Er8VHSROD1/+E7PrrPG1g98DZv1hIu3iEj04t+X87a8sM4Oq3g4OPMV5IhDvlbkN6aXQPjbXmCFtxRH5PT5flBo3pEPcyPf39rE0mqP2W0W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562950; c=relaxed/simple;
	bh=QlF08SIHMBk2KhYMI4g5l2NIfFD9oSh/lO9JqZvx5CA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NX/H/LCuPc9yEsVVIeYFcvxXyVEw2xlwMSj0V9/806oIlHt+twcbhziJxhF8bfY4j0OiqnlY/0zAtw24mB1t0DyFihnnDjK9hKJ4oDQNUu7nUWhBvYxiIazDLSoRTfDQB7ik1Nmsg6bUJmyXfTmoqDyw/HdbQRMgixyUEmkbFxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nfmp405j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nfmp405j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9F81F00893;
	Thu,  4 Jun 2026 08:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780562948;
	bh=dqfqk7LfYLOSqhBKWRAt/XwAkIUGOpmj0om0qB291JU=;
	h=Subject:To:Cc:From:Date;
	b=Nfmp405jfl6SivqDvyonTBXISVSgNGq1VW1OdpSIt14BpORfNQV8LbcBPEIR515fv
	 yoPZWRHLxO+2Tj8eNWLzmApuxE3ocP7kzyRU/CsmUREC1Gz3K0/a0/SJjrm5r06Q04
	 xZ32L7nIaEHOOTNgjY7FQkVqtInU7wentgIwn7n0=
Subject: FAILED: patch "[PATCH] usb: cdns3: gadget: fix request skipping after clearing halt" failed to apply to 5.10-stable tree
To: yongchao.wu@autochips.com,gregkh@linuxfoundation.org,peter.chen@kernel.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 10:48:11 +0200
Message-ID: <2026060411-untoasted-urologist-7591@gregkh>
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
git cherry-pick -x c8778ff817a7047d6848fefba99dcb27b1bf01fe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060411-untoasted-urologist-7591@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c8778ff817a7047d6848fefba99dcb27b1bf01fe Mon Sep 17 00:00:00 2001
From: Yongchao Wu <yongchao.wu@autochips.com>
Date: Thu, 14 May 2026 00:00:12 +0800
Subject: [PATCH] usb: cdns3: gadget: fix request skipping after clearing halt

According to the cdns3 datasheet, the EPRST (Endpoint Reset) command
causes the DMA engine to reposition its internal pointer to the next
Transfer Descriptor (TD) if it was already processing one.

This issue is consistently observed during the ADB identification
process on macOS hosts, where the host issues a Clear_Halt. Although
commit 4bf2dd65135a ("usb: cdns3: gadget: toggle cycle bit before reset
endpoint") attempted to avoid DMA advance by toggling the cycle bit,
trace logs show that on certain hosts like macOS, the DMA pointer
(EP_TRADDR) still shifts after EPRST:

  cdns3_ctrl_req: Clear Endpoint Feature(Halt ep1out)
  cdns3_doorbell_epx: ep1out, ep_trbaddr f9c04030  <-- Should be f9c04000
  cdns3_gadget_giveback: ep1out: req: ... length: 16384/16384

As shown above, the DMA pointer jumped to the next TD, causing
the controller to skip the initial TRBs of the request. This leads to
data misalignment and ADB protocol hangs on macOS.

Fix this by manually restoring the EP_TRADDR register to the starting
physical address of the current request after the EPRST operation is
complete.

Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Cc: stable <stable@kernel.org>
Cc: Peter Chen <peter.chen@kernel.org>
Signed-off-by: Yongchao Wu <yongchao.wu@autochips.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://patch.msgid.link/20260513160012.2547894-1-yongchao.wu@autochips.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 8382231af357..1db8db1b7cc3 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -2817,9 +2817,19 @@ int __cdns3_gadget_ep_clear_halt(struct cdns3_endpoint *priv_ep)
 	priv_ep->flags &= ~(EP_STALLED | EP_STALL_PENDING);
 
 	if (request) {
-		if (trb)
+		if (trb) {
 			*trb = trb_tmp;
 
+			/*
+			 * Per datasheet, EPRST causes DMA to reposition to the next TD.
+			 * Manually reset EP_TRADDR to the current TRB to prevent
+			 * the hardware from skipping the interrupted request.
+			 */
+			writel(EP_TRADDR_TRADDR(priv_ep->trb_pool_dma +
+						priv_req->start_trb * TRB_SIZE),
+						&priv_dev->regs->ep_traddr);
+		}
+
 		cdns3_rearm_transfer(priv_ep, 1);
 	}
 

