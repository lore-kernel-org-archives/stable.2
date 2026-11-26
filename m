Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710012;
	b=qTcSNBMfuLIV99Xh3C8NZp4sOWVXePr0xJiws50Bwga7U5hQELQt4CkSj+cVgVamAHfE
	 uMU/pKgci1bfFu5x7RbsZHs7gKkv3ufZhhdyvinXcB8NwW/W4oEctoFD64E+OUwpdLNGL
	 vWMgzR/bvOj0FvBoxjG84Xz1KOf/WHix8XCbU5hX5Epsu/4IhUlc2A/GOAmNuxDnBTyQ9
	 J01j5DILf4oDjDM4Q1tOAWjMxWst0+mbJBbfqrlWiMN1TTDUEaSUVIqYeNiv367Njv2/s
	 9C6Z6simG/pWhoVQQdif+hCy42NILcH6zaoP/d3+pgTJ8objY83hS5dwjZuYfHONZhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710012;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Eeo9xX+vsvYiXcLqVzRhEgt8mPKCQaYc3E7DWVaa2fQ=;
	b=SP4pa1taaYyr+wfLRFBYvsujnoizy7zpFzsv22Y8fFBd6H4aDO2dj1L54J68WKy16U04
	 eh5suWKrxHomgeTcGY2JEbJg+xwjaGgeZ/6/JZWyYkbrzjS7X6N17pBwaHfpO0oQJ1X9W
	 b6q+8VLKWAAVPjWc0rW7na4f+LKM7U2a1NJat0aGRpShs2KkqqhwmywPFzbaG+VH1J6IE
	 FBpmq2ErMH90td3jeAPmej5gUL/hMtraAyxZSA7E+NkNBEj1T8NdsD4KAXzxg3/J43ZzD
	 SOsXEIvF1i1geXmQZbIjUO+VVZ3y6sPYd30VXMpHEzJDAJh0XjeMVulrhjyl8AfgEWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d2hAH7I+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C4E606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d2hAH7I+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BB61F000C4;
	Thu, 26 Nov 2026 16:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795710012;
	bh=Eeo9xX+vsvYiXcLqVzRhEgt8mPKCQaYc3E7DWVaa2fQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d2hAH7I++h7nqunSoImEEbRCNgZ80gz6nt1pPsgDltC/dr1JaukYDRhEZpM9IrAfc
	 ANLAZKlYiE45YZrp0q9wInePt+ixtN1W0BiANRmyHwJsZCz1B+/5ebzKTORo1eS/Gx
	 HLHz33TWDX5VFKNTvrDXcHOohcv6cXAYvB9cQgjxD5t7okwdHkBN6W3zKhK18dVzqd
	 N6pTidpX228Skq5+8gZXEEJ6PO5XNwuQWqgoUFyiqDlA5R2piv0i9GhiktJyBjCsGc
	 H3HUi/n+hJsQF3cyQWvddUKXDuDMIEJ3sM4dLoHNJXrljOcuE+k3NZtw2IqfGg6Cu2
	 TFGKe6T9zR7pQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] usb: dwc3: gadget: Reinitiate stream for all host NoStream behavior
Date: Thu, 26 Nov 2026 11:20:07 -0500
Message-ID: <20261126161938.2487645-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126161938.2487645-1-sashal@kernel.org>
References: <2026112536-chili-unchanged-4493@gregkh>
 <20261126161938.2487645-1-sashal@kernel.org>
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
 drivers/usb/dwc3/gadget.c | 113 +++++++++++++++++++++-----------------
 2 files changed, 64 insertions(+), 52 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index a788700fadc0b..dd683fd4522cc 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -700,6 +700,7 @@ struct dwc3_event_buffer {
  */
 struct dwc3_ep {
 	struct usb_ep		endpoint;
+	struct delayed_work	nostream_work;
 	struct list_head	cancelled_list;
 	struct list_head	pending_list;
 	struct list_head	started_list;
@@ -722,7 +723,7 @@ struct dwc3_ep {
 #define DWC3_EP_WAIT_TRANSFER_COMPLETE	BIT(7)
 #define DWC3_EP_IGNORE_NEXT_NOSTREAM	BIT(8)
 #define DWC3_EP_FORCE_RESTART_STREAM	BIT(9)
-#define DWC3_EP_FIRST_STREAM_PRIMED	BIT(10)
+#define DWC3_EP_STREAM_PRIMED		BIT(10)
 #define DWC3_EP_PENDING_CLEAR_STALL	BIT(11)
 #define DWC3_EP_TXFIFO_RESIZED		BIT(12)
 #define DWC3_EP_DELAY_STOP             BIT(13)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index e52275ec1f7df..17026105b5ea6 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -955,8 +955,7 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 
 			/*
 			 * All stream eps will reinitiate stream on NoStream
-			 * rejection until we can determine that the host can
-			 * prime after the first transfer.
+			 * rejection.
 			 *
 			 * However, if the controller is capable of
 			 * TXF_FLUSH_BYPASS, then IN direction endpoints will
@@ -1023,6 +1022,8 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 
 	trace_dwc3_gadget_ep_disable(dep);
 
+	cancel_delayed_work(&dep->nostream_work);
+
 	/* make sure HW endpoint isn't stalled */
 	if (dep->flags & DWC3_EP_STALL)
 		__dwc3_gadget_ep_set_halt(dep, 0, false);
@@ -3172,6 +3173,50 @@ static int dwc3_gadget_init_out_endpoint(struct dwc3_ep *dep)
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
+	if (!(dep->flags & DWC3_EP_ENABLED) ||
+	    (dep->flags & DWC3_EP_STREAM_PRIMED))
+		goto out;
+
+	if ((dep->flags & DWC3_EP_IGNORE_NEXT_NOSTREAM) ||
+	    !(dep->flags & DWC3_EP_WAIT_TRANSFER_COMPLETE))
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
@@ -3217,6 +3262,7 @@ static int dwc3_gadget_init_endpoint(struct dwc3 *dwc, u8 epnum)
 	INIT_LIST_HEAD(&dep->pending_list);
 	INIT_LIST_HEAD(&dep->started_list);
 	INIT_LIST_HEAD(&dep->cancelled_list);
+	INIT_DELAYED_WORK(&dep->nostream_work, dwc3_nostream_work);
 
 	dwc3_debugfs_create_endpoint_dir(dep);
 
@@ -3249,6 +3295,9 @@ static void dwc3_gadget_free_endpoints(struct dwc3 *dwc)
 		dep = dwc->eps[epnum];
 		if (!dep)
 			continue;
+
+		cancel_delayed_work_sync(&dep->nostream_work);
+
 		/*
 		 * Physical endpoints 0 and 1 are special; they form the
 		 * bi-directional USB endpoint 0.
@@ -3651,65 +3700,27 @@ static void dwc3_gadget_endpoint_command_complete(struct dwc3_ep *dep,
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
-		    !(dep->flags & DWC3_EP_WAIT_TRANSFER_COMPLETE))
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

