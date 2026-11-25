Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608432;
	b=Y6h/69qVzb7qtsV8x3jnOGzGPNKnmdKbEdNDbzfRpNESZRh9NVTqDRRoWEXSzrg9ixLQ
	 CkllD+M8rOUx3leHtVtTj3HrwQdUwDNBwfUl9VHjL3YsNbw1XStmYghM1tDUbVUbvOyGb
	 7cii/zOGHJTkix/rnIyUZhGDDXmwdXpOJV5Pxxj8vxjEEADf9K60K2UiehrFdIlewrpaj
	 plCZ1ESFlJrv7PvZfRPYDe0cn7otO55IXk+GTF0otvQZwv9g2gtGa+vqoQB56RlaX8lZt
	 HD8aeDEz878wVEmb4L005HBvxdlQDWycdINKaWJxSc5PmXyfL+35AdbWnMVAyIeR5JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608432;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qNoO+8j3BI11TC4vh/vj48sn8KYcPhAIP1hMEKJW4vc=;
	b=m2eJjTNQ2oyrg6BbwQQVv3ZEq7kLnPMKiXXTU4/8Mr9YXyDksrFDLTgssFtjUflbea+o
	 yDfTXIlF9oV9OUNUCOeXnT3uQmcbTLFTBcfST8ECgjv1/AJg4TJFZbHuhkRqgo7UWpOdr
	 uz6dKTwu9U40zPs7O36VFfhMe3Q7YxiXc0dV8w/Q6Myt6byV95rnCe+iPV9Ipem6iRHkB
	 kwvVKY2YGGaZ966/xg4iqyPxrVe8nZXjY14J/T/O1Wvgg/NfAgK1m67hUEk/F9kPfJAqF
	 mrIjQPgDM40Gz8Jk2RYmfOjGupGv++DfpjNGCPqKHNH7/YxbimihLv7yFya+hEYOyFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=gdPi4ZjD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C870606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=gdPi4ZjD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3691F000CA;
	Wed, 25 Nov 2026 12:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608431;
	bh=qNoO+8j3BI11TC4vh/vj48sn8KYcPhAIP1hMEKJW4vc=;
	h=Subject:To:Cc:From:Date;
	b=gdPi4ZjDvf/QWXXu9OcR/ripmyHsVnC1PJaOPbtZuKW71CWcDXpNDX26ccYQwiH9O
	 Kkx8agBuH7GcHiuoDY5Fo7I4ZrwgpM+zxDjNgNL7qQ6KRrzCl0VzT6ZLJ97t4BcIh7
	 qfgOnJvhJChJD8NX+7mICPu8r/J52SYI3GE4TJPc=
Subject: FAILED: patch "[PATCH] usb: dwc3: gadget: Wait for End Transfer completion on ep" failed to apply to 6.1-stable tree
To: Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org,selvarasu.g@samsung.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:41:38 +0100
Message-ID: <2026112538-freebase-eggshell-85bc@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 1338410c21a5710b7ba88057034d35367ba0f054
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112538-freebase-eggshell-85bc@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1338410c21a5710b7ba88057034d35367ba0f054 Mon Sep 17 00:00:00 2001
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Date: Wed, 21 Oct 2026 00:38:13 +0000
Subject: [PATCH] usb: dwc3: gadget: Wait for End Transfer completion on ep
 disable

The End Transfer command on ep disable is issued without interrupt, and
the endpoint flags are cleared right after a fixed delay. The command
may not have completed by then. If the function driver re-enables the
endpoint and queues a request, the next Start Transfer fails with "No
Resource".

Issue the End Transfer command with interrupt on ep disable, and keep
DWC3_EP_END_TRANSFER_PENDING and DWC3_EP_TRANSFER_STARTED until the
command completes. Defer the no-op Start Transfer of a stream endpoint
re-enabled in the meantime to the command completion.

Fixes: c5353b225df9 ("usb: dwc3: gadget: don't enable interrupt when disabling endpoint")
Cc: stable <stable@kernel.org>
Reported-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
Closes: https://lore.kernel.org/linux-usb/20260227121236.963-1-selvarasu.g@samsung.com/
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://patch.msgid.link/24fa8adeb0222dab415c8c2799405188440bad4b.1792542945.git.Thinh.Nguyen@synopsys.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index f3dabb37f806..267c922ca11b 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -771,6 +771,7 @@ struct dwc3_ep {
 #define DWC3_EP_TXFIFO_RESIZED		BIT(12)
 #define DWC3_EP_DELAY_STOP             BIT(13)
 #define DWC3_EP_RESOURCE_ALLOCATED	BIT(14)
+#define DWC3_EP_PENDING_NOOP_START	BIT(15)
 
 	/* This last one is specific to EP0 */
 #define DWC3_EP0_DIR_IN			BIT(31)
@@ -1695,7 +1696,8 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned int cmd,
 		u32 param);
 void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc);
-void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status);
+void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status,
+			  bool interrupt);
 #else
 static inline int dwc3_gadget_init(struct dwc3 *dwc)
 { return 0; }
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 46a34c4a046b..cf5a47b71efc 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -315,7 +315,7 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 		if (dwc->connected)
 			dwc3_stop_active_transfer(dwc3_ep, false, true);
 		else
-			dwc3_remove_requests(dwc, dwc3_ep, -ESHUTDOWN);
+			dwc3_remove_requests(dwc, dwc3_ep, -ESHUTDOWN, false);
 	}
 }
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index e68584f20fbd..e531adc02a40 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1020,9 +1020,14 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 	 * Response Update Transfer command.
 	 */
 	if (dep->stream_capable) {
-		ret = dwc3_gadget_ep_start_noop_transfer(dep);
-		if (ret < 0)
-			return ret;
+		if (dep->flags & (DWC3_EP_END_TRANSFER_PENDING |
+				  DWC3_EP_DELAY_STOP)) {
+			dep->flags |= DWC3_EP_PENDING_NOOP_START;
+		} else {
+			ret = dwc3_gadget_ep_start_noop_transfer(dep);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 out:
@@ -1031,16 +1036,21 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 	return 0;
 }
 
-void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status)
+void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status,
+			  bool interrupt)
 {
 	struct dwc3_request		*req;
 
-	dwc3_stop_active_transfer(dep, false, false);
+	dwc3_stop_active_transfer(dep, false, interrupt);
 
 	/* If endxfer is delayed, avoid unmapping requests */
 	if (dep->flags & DWC3_EP_DELAY_STOP)
 		return;
 
+	/* Give the controller time to stop accessing the request buffers */
+	if (dep->flags & DWC3_EP_END_TRANSFER_PENDING)
+		mdelay(1);
+
 	/* - giveback all requests to gadget driver */
 	while (!list_empty(&dep->started_list)) {
 		req = next_request(&dep->started_list);
@@ -1089,7 +1099,7 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 
 	dep->flags &= ~DWC3_EP_ENABLED;
 
-	dwc3_remove_requests(dwc, dep, -ESHUTDOWN);
+	dwc3_remove_requests(dwc, dep, -ESHUTDOWN, true);
 
 	dep->stream_capable = false;
 	dep->type = 0;
@@ -1101,6 +1111,15 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 	 */
 	if (dep->flags & DWC3_EP_DELAY_STOP)
 		mask |= (DWC3_EP_DELAY_STOP | DWC3_EP_TRANSFER_STARTED);
+
+	/*
+	 * The End Transfer command is still in progress.  Do not clear the
+	 * flags, so that the ep is only rearmed once the command completes.
+	 */
+	if (dep->flags & DWC3_EP_END_TRANSFER_PENDING)
+		mask |= (DWC3_EP_END_TRANSFER_PENDING |
+			 DWC3_EP_TRANSFER_STARTED);
+
 	dep->flags &= mask;
 
 	/* Clear out the ep descriptors for non-ep0 */
@@ -2553,7 +2572,7 @@ static void dwc3_stop_active_transfers(struct dwc3 *dwc)
 		if (!dep)
 			continue;
 
-		dwc3_remove_requests(dwc, dep, -ESHUTDOWN);
+		dwc3_remove_requests(dwc, dep, -ESHUTDOWN, false);
 	}
 }
 
@@ -3901,7 +3920,16 @@ static void dwc3_gadget_endpoint_command_complete(struct dwc3_ep *dep,
 			dwc3_ep0_send_delayed_status(dwc);
 	}
 
+	if (dep->flags & DWC3_EP_PENDING_NOOP_START) {
+		dep->flags &= ~DWC3_EP_PENDING_NOOP_START;
+
+		if (!(dep->flags & DWC3_EP_DELAY_START) &&
+		    (dep->flags & DWC3_EP_ENABLED))
+			dwc3_gadget_ep_start_noop_transfer(dep);
+	}
+
 	if ((dep->flags & DWC3_EP_DELAY_START) &&
+	    (dep->flags & DWC3_EP_ENABLED) &&
 	    !usb_endpoint_xfer_isoc(dep->endpoint.desc))
 		__dwc3_gadget_kick_transfer(dep);
 

