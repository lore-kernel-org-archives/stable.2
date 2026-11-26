Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707847;
	b=MQ/Q/kcNnNoRc2gU/W6rHqe2C0h3A+rWljTr4TabyreQOkH4Q+YLjjrJv1lWo2wE8iK3
	 ML1NU8YqN1cavgm85oSF1wDcBdUIiDQRhTYV0c3EGCUZFmMN4bA3NOUnk+4gGxZQTkvaK
	 5hzikb2Dx2v3bJpo+ZQwqN3htyd9QTpStsZquSQ51xznri+Gv985Kv83zIhFasrHYOGVS
	 sOQRU9MecK78hUotj8ZnQui/lsDO1h37VFCvyipYmMZNMmasOOVJGpJQvNNqxx5wDATYo
	 c9ruz8BLKuqFHe1cC70wYyBdF5dLV0ID/NR/ES/kFIP2q1JsvGJ8x2Pm/knJTDqQtzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707847;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=54VreeWLEBpgiNbZx52nuSDJZiLcd7uG3hUPfeaCttE=;
	b=ijHUoN7iJI06xG1914zAGtpRE1Sx/z//efK30BJTYihI8GDs+Iv4EZTmNJtPr5qblbkZ
	 go3peVDRF4kS2JeobLp7njiiETj8e7bkumppHsfU41yKa5ZMPErGfQo7jgzwo6P0L77iw
	 OpodvZbjZhBgA7PSYcuGXoXz/SeUVDhJh+HUu3ScYlTTPb2k2C/ReGbgr46yRRNov4T1G
	 Z4yX60qUL/Gnsk1lhZQQr8JrLlYcyekhXsCZxZWU1pvtcYSCeiD3477OSYEw2swCjIV4w
	 3vBfQX0wZj4QX1TKQCVYkm7X2/F7QpmyUho961iJPMPtBWr19uE+nCufKQRe3Ef52Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eugcL4GC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D863A606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eugcL4GC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8423D1F000C0;
	Thu, 26 Nov 2026 15:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795707847;
	bh=54VreeWLEBpgiNbZx52nuSDJZiLcd7uG3hUPfeaCttE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eugcL4GCtMV0cQeWZnd4/1UC3sYALU9KAmJHg/+B6Nb/QHn6QgQJkBOdhZU2fqyFC
	 YEvSWLwX3mRmUQcrqCgRQJ0Q2j7+X9+fWPzR3zXCJtpK9YkiNnovgYRDfr3a/LPv+q
	 IV+gOZEDtaYpkXbFw30v0qvO1D8SXUHcUwO8qNkg/P0kjzWvYDiC17wX+dPuAtPWyj
	 Msz8pVQWzsh0nTZHv72CwQvaUyDz57ArIPBFLIiq3/99VW1XMB9BKCcfxo879Hq18F
	 VB+TvwnzAflr2Au2XDV0gxbhXTZ79YbHCtDY9ghlhik2OBADk4bsyd31V/s9rKTZBb
	 Z/Uy+wLM9iGwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	stable <stable@kernel.org>,
	Selvarasu Ganesan <selvarasu.g@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] usb: dwc3: gadget: Wait for End Transfer completion on ep disable
Date: Thu, 26 Nov 2026 10:44:05 -0500
Message-ID: <20261126154351.2488308-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112538-freebase-eggshell-85bc@gregkh>
References: <2026112538-freebase-eggshell-85bc@gregkh>
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

[ Upstream commit 1338410c21a5710b7ba88057034d35367ba0f054 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Depends on <20261126153139.2455075-1-sashal@kernel.org>

 drivers/usb/dwc3/core.h   |  4 +++-
 drivers/usb/dwc3/ep0.c    |  2 +-
 drivers/usb/dwc3/gadget.c | 42 ++++++++++++++++++++++++++++++++-------
 3 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 56208f7d8cf5e..37a92474c4802 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -748,6 +748,7 @@ struct dwc3_ep {
 #define DWC3_EP_TXFIFO_RESIZED		BIT(12)
 #define DWC3_EP_DELAY_STOP             BIT(13)
 #define DWC3_EP_RESOURCE_ALLOCATED	BIT(14)
+#define DWC3_EP_PENDING_NOOP_START	BIT(15)
 
 	/* This last one is specific to EP0 */
 #define DWC3_EP0_DIR_IN			BIT(31)
@@ -1613,7 +1614,8 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
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
index 764360ac7e368..700fb9f450070 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -313,7 +313,7 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 		if (dwc->connected)
 			dwc3_stop_active_transfer(dwc3_ep, false, true);
 		else
-			dwc3_remove_requests(dwc, dwc3_ep, -ESHUTDOWN);
+			dwc3_remove_requests(dwc, dwc3_ep, -ESHUTDOWN, false);
 	}
 }
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 01f2729bcbfb5..13adf2b495fcb 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -978,9 +978,14 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
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
@@ -989,16 +994,21 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
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
@@ -1047,7 +1057,7 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 
 	dep->flags &= ~DWC3_EP_ENABLED;
 
-	dwc3_remove_requests(dwc, dep, -ESHUTDOWN);
+	dwc3_remove_requests(dwc, dep, -ESHUTDOWN, true);
 
 	dep->stream_capable = false;
 	dep->type = 0;
@@ -1059,6 +1069,15 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
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
@@ -2438,7 +2457,7 @@ static void dwc3_stop_active_transfers(struct dwc3 *dwc)
 		if (!dep)
 			continue;
 
-		dwc3_remove_requests(dwc, dep, -ESHUTDOWN);
+		dwc3_remove_requests(dwc, dep, -ESHUTDOWN, false);
 	}
 }
 
@@ -3756,7 +3775,16 @@ static void dwc3_gadget_endpoint_command_complete(struct dwc3_ep *dep,
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
 
-- 
2.53.0

