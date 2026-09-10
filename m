Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0262AD00
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003959; cv=none; b=NUuUYpoD7TEgrr1AxhVRmI8ZKT2U4eTSIc3ofpZLgakvLmSD8peRM/qEuSy4vrUTRTPZnOrtZduuE2OWvL8mv93vK7p1mF3V+bTglGfyRkbkbr7OS8LaTJQNfpW1stfsn1Zew0NmhMYNDox97ukzfmV5wdTG2rUrtUSldsTR9Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003959; c=relaxed/simple;
	bh=xgZWK+ewOUAWAfbHzJdT+KFhq3K7ccbjdrHDm4DgIzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Icq5oLjQ8YWueoOTL/itMHNpWGskV4UFwOOnjxbb6IqwU40Vynv6vfnJdmkX8HLXcx7zftma3LlDrTUvPVA4/xMjP586zox/mygTWYFjpAVi41iUBQJczMFDOhpLvzxY6IH5SwD2DqtJ81DlNHqc5J+htDtmkyzOAJmpWjlqmrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lM4rwM1D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lM4rwM1D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9A81F000FF;
	Thu, 10 Sep 2026 01:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789003958;
	bh=VXCh8EGLVlxW2nYCgLQLqSrUyWh/2uCoELeNL4YFTQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lM4rwM1DFJMZhy337O+OFDcSeSFkXW4zueS+VWbUHPNsoA8/+yofm9P29O8UUOIIO
	 DVYXsVZ9IRkObly1a90PbEzfUyV0OKQxAn+z4M5gcYuX1F0MxWhjwOLvbuFO8SdrAX
	 52NsSGVWefoCtAchYYXS9IHmJHTQryLXUaaji7UWJRmhBPCMQKs3U3uXIVNC9Hg5ZN
	 pOA+jkUi2AfCZx/lFibhm3ngNoWkuLSmiaC4z10xg/+QBBoBw56mtgKMy3xbRQ5HuO
	 sgD7Ue48n0FaRAbN2HU4rQklOEvHsfo9aJEjGEOsydK386fUjmlkR+lp91PbC7tIKg
	 Smmz+V39jukIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] usb: dwc3: gadget: Reinitiate stream for all host NoStream behavior
Date: Wed,  9 Sep 2026 21:32:35 -0400
Message-ID: <20260910013236.3889340-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090819-kilometer-itunes-d755@gregkh>
References: <2026090819-kilometer-itunes-d755@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

[ Upstream commit dcfe437492e27d54f3ac491aed024da760f5c43c ]

There are too many different host behaviors when it comes to NoStream
handling, and not everyone follows the USB and xHCI spec. The DWC3
driver attempts to do some guess work to interop with different hosts,
but it can't cover everything. Let's keep it simple and treat every host
the same: just retry on NoStream after a 100ms of no response delay.
Note that some hosts cannot handle frequent retries. This may affect
performance on certain defective hosts, but NoStream is a rare
occurrence and interoperability is more important.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/b92ae94c86f01f165d5f178b7767898573b6dc75.1736819308.git.Thinh.Nguyen@synopsys.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: b58e6200450d ("usb: dwc3: clear forceRM when issuing EndTransfer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/core.h   |   3 +-
 drivers/usb/dwc3/gadget.c | 109 ++++++++++++++++++++------------------
 2 files changed, 59 insertions(+), 53 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index eb8b8f3e52167..7ee7228b31eb9 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -742,6 +742,7 @@ struct dwc3_event_buffer {
  */
 struct dwc3_ep {
 	struct usb_ep		endpoint;
+	struct delayed_work	nostream_work;
 	struct list_head	cancelled_list;
 	struct list_head	pending_list;
 	struct list_head	started_list;
@@ -764,7 +765,7 @@ struct dwc3_ep {
 #define DWC3_EP_WAIT_TRANSFER_COMPLETE	BIT(7)
 #define DWC3_EP_IGNORE_NEXT_NOSTREAM	BIT(8)
 #define DWC3_EP_FORCE_RESTART_STREAM	BIT(9)
-#define DWC3_EP_FIRST_STREAM_PRIMED	BIT(10)
+#define DWC3_EP_STREAM_PRIMED		BIT(10)
 #define DWC3_EP_PENDING_CLEAR_STALL	BIT(11)
 #define DWC3_EP_TXFIFO_RESIZED		BIT(12)
 #define DWC3_EP_DELAY_STOP             BIT(13)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index d2b07d767877e..3cf22447c0415 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -995,8 +995,7 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 
 			/*
 			 * All stream eps will reinitiate stream on NoStream
-			 * rejection until we can determine that the host can
-			 * prime after the first transfer.
+			 * rejection.
 			 *
 			 * However, if the controller is capable of
 			 * TXF_FLUSH_BYPASS, then IN direction endpoints will
@@ -3309,6 +3308,50 @@ static int dwc3_gadget_init_out_endpoint(struct dwc3_ep *dep)
 	return dwc3_alloc_trb_pool(dep);
 }
 
+#define nostream_work_to_dep(w) (container_of(to_delayed_work(w), struct dwc3_ep, nostream_work))
+static void dwc3_nostream_work(struct work_struct *work)
+{
+	struct dwc3_ep	*dep = nostream_work_to_dep(work);
+	struct dwc3	*dwc = dep->dwc;
+	unsigned long   flags;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	if (dep->flags & DWC3_EP_STREAM_PRIMED)
+		goto out;
+
+	if ((dep->flags & DWC3_EP_IGNORE_NEXT_NOSTREAM) ||
+	    (!DWC3_MST_CAPABLE(&dwc->hwparams) &&
+	     !(dep->flags & DWC3_EP_WAIT_TRANSFER_COMPLETE)))
+		goto out;
+	/*
+	 * If the host rejects a stream due to no active stream, by the
+	 * USB and xHCI spec, the endpoint will be put back to idle
+	 * state. When the host is ready (buffer added/updated), it will
+	 * prime the endpoint to inform the usb device controller. This
+	 * triggers the device controller to issue ERDY to restart the
+	 * stream. However, some hosts don't follow this and keep the
+	 * endpoint in the idle state. No prime will come despite host
+	 * streams are updated, and the device controller will not be
+	 * triggered to generate ERDY to move the next stream data. To
+	 * workaround this and maintain compatibility with various
+	 * hosts, force to reinitiate the stream until the host is ready
+	 * instead of waiting for the host to prime the endpoint.
+	 */
+	if (DWC3_VER_IS_WITHIN(DWC32, 100A, ANY)) {
+		unsigned int cmd = DWC3_DGCMD_SET_ENDPOINT_PRIME;
+
+		dwc3_send_gadget_generic_command(dwc, cmd, dep->number);
+	} else {
+		dep->flags |= DWC3_EP_DELAY_START;
+		dwc3_stop_active_transfer(dep, true, true);
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return;
+	}
+out:
+	dep->flags &= ~DWC3_EP_IGNORE_NEXT_NOSTREAM;
+	spin_unlock_irqrestore(&dwc->lock, flags);
+}
+
 static int dwc3_gadget_init_endpoint(struct dwc3 *dwc, u8 epnum)
 {
 	struct dwc3_ep			*dep;
@@ -3354,6 +3397,7 @@ static int dwc3_gadget_init_endpoint(struct dwc3 *dwc, u8 epnum)
 	INIT_LIST_HEAD(&dep->pending_list);
 	INIT_LIST_HEAD(&dep->started_list);
 	INIT_LIST_HEAD(&dep->cancelled_list);
+	INIT_DELAYED_WORK(&dep->nostream_work, dwc3_nostream_work);
 
 	dwc3_debugfs_create_endpoint_dir(dep);
 
@@ -3789,66 +3833,27 @@ static void dwc3_gadget_endpoint_command_complete(struct dwc3_ep *dep,
 static void dwc3_gadget_endpoint_stream_event(struct dwc3_ep *dep,
 		const struct dwc3_event_depevt *event)
 {
-	struct dwc3 *dwc = dep->dwc;
-
 	if (event->status == DEPEVT_STREAMEVT_FOUND) {
-		dep->flags |= DWC3_EP_FIRST_STREAM_PRIMED;
-		goto out;
+		cancel_delayed_work(&dep->nostream_work);
+		dep->flags |= DWC3_EP_STREAM_PRIMED;
+		dep->flags &= ~DWC3_EP_IGNORE_NEXT_NOSTREAM;
+		return;
 	}
 
 	/* Note: NoStream rejection event param value is 0 and not 0xFFFF */
 	switch (event->parameters) {
 	case DEPEVT_STREAM_PRIME:
-		/*
-		 * If the host can properly transition the endpoint state from
-		 * idle to prime after a NoStream rejection, there's no need to
-		 * force restarting the endpoint to reinitiate the stream. To
-		 * simplify the check, assume the host follows the USB spec if
-		 * it primed the endpoint more than once.
-		 */
-		if (dep->flags & DWC3_EP_FORCE_RESTART_STREAM) {
-			if (dep->flags & DWC3_EP_FIRST_STREAM_PRIMED)
-				dep->flags &= ~DWC3_EP_FORCE_RESTART_STREAM;
-			else
-				dep->flags |= DWC3_EP_FIRST_STREAM_PRIMED;
-		}
-
+		cancel_delayed_work(&dep->nostream_work);
+		dep->flags |= DWC3_EP_STREAM_PRIMED;
+		dep->flags &= ~DWC3_EP_IGNORE_NEXT_NOSTREAM;
 		break;
 	case DEPEVT_STREAM_NOSTREAM:
-		if ((dep->flags & DWC3_EP_IGNORE_NEXT_NOSTREAM) ||
-		    !(dep->flags & DWC3_EP_FORCE_RESTART_STREAM) ||
-		    (!DWC3_MST_CAPABLE(&dwc->hwparams) &&
-		     !(dep->flags & DWC3_EP_WAIT_TRANSFER_COMPLETE)))
-			break;
-
-		/*
-		 * If the host rejects a stream due to no active stream, by the
-		 * USB and xHCI spec, the endpoint will be put back to idle
-		 * state. When the host is ready (buffer added/updated), it will
-		 * prime the endpoint to inform the usb device controller. This
-		 * triggers the device controller to issue ERDY to restart the
-		 * stream. However, some hosts don't follow this and keep the
-		 * endpoint in the idle state. No prime will come despite host
-		 * streams are updated, and the device controller will not be
-		 * triggered to generate ERDY to move the next stream data. To
-		 * workaround this and maintain compatibility with various
-		 * hosts, force to reinitiate the stream until the host is ready
-		 * instead of waiting for the host to prime the endpoint.
-		 */
-		if (DWC3_VER_IS_WITHIN(DWC32, 100A, ANY)) {
-			unsigned int cmd = DWC3_DGCMD_SET_ENDPOINT_PRIME;
-
-			dwc3_send_gadget_generic_command(dwc, cmd, dep->number);
-		} else {
-			dep->flags |= DWC3_EP_DELAY_START;
-			dwc3_stop_active_transfer(dep, true, true);
-			return;
-		}
+		dep->flags &= ~DWC3_EP_STREAM_PRIMED;
+		if (dep->flags & DWC3_EP_FORCE_RESTART_STREAM)
+			queue_delayed_work(system_wq, &dep->nostream_work,
+					   msecs_to_jiffies(100));
 		break;
 	}
-
-out:
-	dep->flags &= ~DWC3_EP_IGNORE_NEXT_NOSTREAM;
 }
 
 static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
-- 
2.53.0

