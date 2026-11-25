Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608435;
	b=5Xzlc7IJ2Z1/rAwc2LixT56X5K2Lmnho8LEPPI6G38aRnjPgH9PlH8/sCi9h0bUnRA6m
	 P+svfYEbeui0nYULKDiRdGFhx++vpF494v33HfxGZDodSaYUJNaMFu2r49yH7EevheXZL
	 5Im1IaycoUtnLDP0E8vsjfTEs7Zg86OlhAEvwK+ApilS6lCqT3e2zvDUSC//KtEyIH25c
	 AN5l/yUk5XZSMBLIolAESbR7OmTZtXOeLqE8ZQczVLZfXDtPH2dWAcVTJ2xkjUsfWL5hg
	 cTneg1IA1KLqVLCipyn/pGpfTQ4tKsZxVpvXaYcFUiA52Hs/J6krKkZY4TcstwweBwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608435;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+rOLiqpzdSLGEYhoBnqN0bKJCewZRZWs5yvngZ6ZObU=;
	b=AKWtI1m6BK5e5L2katyUPKjVtenGk/7yvzDiDnwX+qxLDsWiEyElnnYQ2ytkpsS20L4K
	 GnksSR4PFJH0ypZ/Tmslpk4m7OiXdAB55LeJpMjl3bS2LQL/ql3HPXrMkrqQOJo60vYD+
	 DrlbD0KZXFq7OCdJ/Frick7Fick9N/elAeOAhIXEoIYW5riXrGvoIdW4SIohSVd/bqvNo
	 RZDlQtBl5TBAiE/vIowKa/0HK/lAF2HvLUCXOXkbGELXN1Xeg6NiC1UUcLBYoxaj+eJIr
	 I/mV2cO5EPbBUkc8itGKMQKkJVA11hbNbPhmEF/AXkiD/okmxoBMd1n3Y2z73OyufpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=mfW51FqR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E577B606A329
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=mfW51FqR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3455E1F000D0;
	Wed, 25 Nov 2026 12:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608434;
	bh=+rOLiqpzdSLGEYhoBnqN0bKJCewZRZWs5yvngZ6ZObU=;
	h=Subject:To:Cc:From:Date;
	b=mfW51FqRDYyoAMpmlQKNspzlJma3fseUV1Zun0tm04F1jYo/I/Izwk519gt3llDOs
	 aLrSWLIoS6ZdI66LYgPs8N+/x0bgsDVSaoMb7PxEWyaJvH+2Lt+vIc6LE7AJcoV+5K
	 Np3AwpYU4AbO2WKjdTuweGcJXCWzZBEZPj5dH2SU=
Subject: FAILED: patch "[PATCH] usb: dwc3: gadget: Wait for End Transfer completion on ep" failed to apply to 5.10-stable tree
To: Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org,selvarasu.g@samsung.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:41:39 +0100
Message-ID: <2026112539-slogan-net-78bf@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1338410c21a5710b7ba88057034d35367ba0f054
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112539-slogan-net-78bf@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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
 

