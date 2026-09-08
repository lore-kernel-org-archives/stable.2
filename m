Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3385328A8
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870158; cv=none; b=q5RtDNV2um+dxxqXhFm02EoNtbSS8oYkuTaZlr8r+odRbXiPFbPx9nUVFqAo731S8R4QV83BIxPlM9WH/1QjV929IQ1I09mgfAWJzDhCmz/V/eiqGPLdp+aBqoNrCpHG/a+pfKbrJ6pHtI/DLIkqJW0b3UU4LakwhDfieTrqWq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870158; c=relaxed/simple;
	bh=9H+6/by2MSVhKVv+QhtwXKsQHxkRhU1ljHjoJW1vxM0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UjAmAm0Ck04GBz+QWE8I1rZE4hZGm5B+PL8Ss5O0EMj03kDh5fgBAb2DPzOWVgbtpfqp+LlgUiqTvSzebL3KSwsJvI1E3rMKSivCQ1aRCFO4L74WbMRhweL5MV8dLGxa3yGciObO1D0F/JUrZsCUKmVZfK6fTYxJpwDbOiaO5ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o+Whr7L7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o+Whr7L7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6949F1F00A3A;
	Tue,  8 Sep 2026 12:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788870155;
	bh=WOllEsfxI5Kl8AMO1OwsEGjejWCWj5/jtng8Ec9Bh3E=;
	h=Subject:To:Cc:From:Date;
	b=o+Whr7L7UHOCFlhLG73mPs44M6nIuTxDNKdiwoagwPbLpm2anIg29wmb6oRudlob/
	 +C7GGjo/1yqzWK8YCTEonuJ1EWJ7SeREFqMewucrcFa4ORH2+OWsoEtXwsxU3OObU9
	 rrMm4OcQObT0yDS77vUM3xlbAq97FrrUrIxNV6vE=
Subject: FAILED: patch "[PATCH] usb: dwc3: clear forceRM when issuing EndTransfer" failed to apply to 6.12-stable tree
To: elson.serrao@oss.qualcomm.com,Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:22:19 +0200
Message-ID: <2026090819-kilometer-itunes-d755@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b58e6200450d350314db0ecda7d6d1bde3281e80
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090819-kilometer-itunes-d755@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b58e6200450d350314db0ecda7d6d1bde3281e80 Mon Sep 17 00:00:00 2001
From: Elson Serrao <elson.serrao@oss.qualcomm.com>
Date: Thu, 13 Aug 2026 08:14:56 -0700
Subject: [PATCH] usb: dwc3: clear forceRM when issuing EndTransfer

The forceRM bit of the DEPCMD register controls the behavior of the
EndTransfer command used to stop an active transfer. Older DWC3
programming guide revisions recommended setting forceRM=1 when
issuing EndTransfer. Newer programming guide revisions recommend
issuing EndTransfer with forceRM cleared.

With forceRM=1 on DWC_usb31 v2.00a and v2.10a controllers, a transfer
aborted through the ep_dequeue path was observed to remain active
after EndTransfer completion. A subsequent StartTransfer issued on the
same endpoint triggered writes associated with the aborted transfer.
This resulted in an SMMU fault because the transfer buffer had already
been unmapped during EndTransfer command-completion cleanup.

Using forceRM=0 eliminates the issue. Although older DWC3 programming
guide revisions recommended setting forceRM=1, no issues are known
from using forceRM=0. Clear forceRM when issuing EndTransfer to provide
consistent EndTransfer behavior and align with newer programming guide
recommendations.

Fixes: 1e43c86d84fb ("usb: dwc3: core: Add DWC31 version 2.00a controller")
Cc: stable <stable@kernel.org>
Signed-off-by: Elson Serrao <elson.serrao@oss.qualcomm.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://patch.msgid.link/20260813151456.867008-1-elson.serrao@oss.qualcomm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index bfe616194dfa..310b5ffb236a 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -304,7 +304,7 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 
 		dwc3_ep->flags &= ~DWC3_EP_DELAY_STOP;
 		if (dwc->connected)
-			dwc3_stop_active_transfer(dwc3_ep, true, true);
+			dwc3_stop_active_transfer(dwc3_ep, false, true);
 		else
 			dwc3_remove_requests(dwc, dwc3_ep, -ESHUTDOWN);
 	}
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index fa944856f956..f245e66cd13d 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1004,7 +1004,7 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 			 * controller to generate an ERDY to initiate the
 			 * stream.
 			 */
-			dwc3_stop_active_transfer(dep, true, true);
+			dwc3_stop_active_transfer(dep, false, true);
 
 			/*
 			 * All stream eps will reinitiate stream on NoStream
@@ -1032,7 +1032,7 @@ void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status)
 {
 	struct dwc3_request		*req;
 
-	dwc3_stop_active_transfer(dep, true, false);
+	dwc3_stop_active_transfer(dep, false, false);
 
 	/* If endxfer is delayed, avoid unmapping requests */
 	if (dep->flags & DWC3_EP_DELAY_STOP)
@@ -1720,7 +1720,7 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 		if (ret == -EAGAIN)
 			return ret;
 
-		dwc3_stop_active_transfer(dep, true, true);
+		dwc3_stop_active_transfer(dep, false, true);
 
 		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
 			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_DEQUEUED);
@@ -1757,6 +1757,11 @@ static int __dwc3_gadget_get_frame(struct dwc3 *dwc)
  * the controller won't update the TRB progress on command
  * completion. It also won't clear the HWO bit in the TRB.
  * The command will also not complete immediately in that case.
+ *
+ * Older programming guide revisions recommended setting ForceRM to 1
+ * when ending a transfer. Newer programming guide revisions now
+ * recommend keeping ForceRM cleared, and TRBs are properly updated
+ * on command completion.
  */
 static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool interrupt)
 {
@@ -1882,7 +1887,7 @@ static int dwc3_gadget_start_isoc_quirk(struct dwc3_ep *dep)
 		 * to wait for the next XferNotReady to test the command again
 		 */
 		if (cmd_status == 0) {
-			dwc3_stop_active_transfer(dep, true, true);
+			dwc3_stop_active_transfer(dep, false, true);
 			return 0;
 		}
 	}
@@ -2165,7 +2170,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 			struct dwc3_request *t;
 
 			/* wait until it is processed */
-			dwc3_stop_active_transfer(dep, true, true);
+			dwc3_stop_active_transfer(dep, false, true);
 
 			/*
 			 * Remove any started request if the transfer is
@@ -2242,7 +2247,7 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 			return 0;
 		}
 
-		dwc3_stop_active_transfer(dep, true, true);
+		dwc3_stop_active_transfer(dep, false, true);
 
 		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
 			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_STALLED);
@@ -3368,7 +3373,7 @@ static void dwc3_nostream_work(struct work_struct *work)
 		dwc3_send_gadget_generic_command(dwc, cmd, dep->number);
 	} else {
 		dep->flags |= DWC3_EP_DELAY_START;
-		dwc3_stop_active_transfer(dep, true, true);
+		dwc3_stop_active_transfer(dep, false, true);
 		spin_unlock_irqrestore(&dwc->lock, flags);
 		return;
 	}
@@ -3726,7 +3731,7 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
 	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
 		list_empty(&dep->started_list) &&
 		(list_empty(&dep->pending_list) || status == -EXDEV))
-		dwc3_stop_active_transfer(dep, true, true);
+		dwc3_stop_active_transfer(dep, false, true);
 	else if (dwc3_gadget_ep_should_continue(dep))
 		if (__dwc3_gadget_kick_transfer(dep) == 0)
 			no_started_trb = false;

