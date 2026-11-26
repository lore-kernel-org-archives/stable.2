Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707138;
	b=W/x6Pjn3SxTK7pTudpPDSGt1JvwWZTqZKGB8aHHa3oaa8nEEqXGOkkhdFpT0bwpy2qHG
	 NKEgn/iXlnH7AgTzSDJcZyQXHNXcejH5VPNiBFdyrSzjggaiYuqHHMAUXtvJlSM+JXdId
	 adD3D4Q2lDX7CjDmvbed3FgOo+aEhzi+O/6jKbDYv7ktau9OMpozZaps7VWv3kEfeM5mH
	 YdmGD/UlkwaBidOrIL8FuqUHwElhuDzlot+aTMLIJ1pocBY33yh/Z6h/zebsm43VvmTqt
	 f6use2l/c+cXKsnWtlNH6eG4HzwzBPs09hOwKc7jGpvdiXprxeqDL/+I1Y0/McGlncA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707138;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jo7BrF0sYaKxQ+vITcZNbPeJCAxMTV7u0XgD3v0ifRg=;
	b=zxG2izZOR3cNTKP1n6x7Ac9Aji+Bsblb1RYCcxPsbRFRbYuDy7afFz9sXVwoC/lOZzQx
	 HLGBAfzSLYkYMyWJoNDP6yUr+3jSohwio8pHWFBMem/A3jeVcTfvjdOjLnlLV8fJEqz7B
	 oOelrZ+ij7x88AuXreX3JPSjyIsW+BY9TI2O5HonZ0qT1v35SvvybVQhXcumQ0U8bAhu0
	 7H9PAuAy4qEgXFAgw4huww6H6nJE9TulqR3a4NlCyTzJ8juwJWNlhgiJVuYQ7a9vrreKK
	 XBu/aMa30SgQm9uB+QqjVgC5bpp7B/iM3wnBJ5ervvMmLQ8u5tnDyELuK2NjLh2qfeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VPfLiJ9T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0D4606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VPfLiJ9T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF011F000C0;
	Thu, 26 Nov 2026 15:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795707138;
	bh=jo7BrF0sYaKxQ+vITcZNbPeJCAxMTV7u0XgD3v0ifRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VPfLiJ9TWG0XohthmGKJZtujohahgtzg/8Bstmm9fIcLakyxHlg6/4ve9Hj1NI0uO
	 Aof+95ClutiZUh6c3oE2ZikpcBXxLBaHvtnk5uDy4xFxjPJythezXK5ijESWzSmwpq
	 HnMTIBVGbU1JasciLiLUs4JezNKyEwlOyjMK6UXE313Z+kI+bdbhPfYcZX1U+WeFds
	 OQeL1B84j51igUqnPaVqFtqcwCalE+nqGfz8Q8EDwdiZS52mALxPSH8YN9CGHf9iZn
	 oljk8L0uiF3tSY28BkKZDCUOLwB007ZTzkhMAlySSZzg6wCe6CUhjv44+iBygSvy7a
	 /ibFMd1ky64Sg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] usb: dwc3: gadget: Reinitiate stream for all host NoStream behavior
Date: Thu, 26 Nov 2026 10:32:14 -0500
Message-ID: <20261126153139.2455075-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112535-humming-whimsical-6e80@gregkh>
References: <2026112535-humming-whimsical-6e80@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
Stable-dep-of: e616d91e0288 ("usb: dwc3: gadget: Issue no-op Start Transfer only for stream endpoints")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/core.h   |   3 +-
 drivers/usb/dwc3/gadget.c | 109 ++++++++++++++++++++------------------
 2 files changed, 59 insertions(+), 53 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 0119a8940c8d5..56208f7d8cf5e 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -720,6 +720,7 @@ struct dwc3_event_buffer {
  */
 struct dwc3_ep {
 	struct usb_ep		endpoint;
+	struct delayed_work	nostream_work;
 	struct list_head	cancelled_list;
 	struct list_head	pending_list;
 	struct list_head	started_list;
@@ -742,7 +743,7 @@ struct dwc3_ep {
 #define DWC3_EP_WAIT_TRANSFER_COMPLETE	BIT(7)
 #define DWC3_EP_IGNORE_NEXT_NOSTREAM	BIT(8)
 #define DWC3_EP_FORCE_RESTART_STREAM	BIT(9)
-#define DWC3_EP_FIRST_STREAM_PRIMED	BIT(10)
+#define DWC3_EP_STREAM_PRIMED		BIT(10)
 #define DWC3_EP_PENDING_CLEAR_STALL	BIT(11)
 #define DWC3_EP_TXFIFO_RESIZED		BIT(12)
 #define DWC3_EP_DELAY_STOP             BIT(13)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 9d356ff8d036c..1ed6f4fc89eb9 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -966,8 +966,7 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 
 			/*
 			 * All stream eps will reinitiate stream on NoStream
-			 * rejection until we can determine that the host can
-			 * prime after the first transfer.
+			 * rejection.
 			 *
 			 * However, if the controller is capable of
 			 * TXF_FLUSH_BYPASS, then IN direction endpoints will
@@ -3233,6 +3232,50 @@ static int dwc3_gadget_init_out_endpoint(struct dwc3_ep *dep)
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
@@ -3278,6 +3321,7 @@ static int dwc3_gadget_init_endpoint(struct dwc3 *dwc, u8 epnum)
 	INIT_LIST_HEAD(&dep->pending_list);
 	INIT_LIST_HEAD(&dep->started_list);
 	INIT_LIST_HEAD(&dep->cancelled_list);
+	INIT_DELAYED_WORK(&dep->nostream_work, dwc3_nostream_work);
 
 	dwc3_debugfs_create_endpoint_dir(dep);
 
@@ -3714,66 +3758,27 @@ static void dwc3_gadget_endpoint_command_complete(struct dwc3_ep *dep,
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

