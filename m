Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608416;
	b=hHyabjwMIqJ9qXhOcrttKAkhZoFROTzh8Iteb7YLxp4/0AL0KdpaTRGGajl9/VQeWtzT
	 ZmL0c6t6W9HAe6alm/ILH87wI5o0fyMaaDnfUCmDpdsMGO2oHl7yW3GZ0pmqrVR7vMRUi
	 QuAaXctHDQi9XW5dL/ID/CU9bv8CUO+I26HPiYq70IdLwP134LBIdOlm8mqMpizPVqQss
	 pqY866lthq+l5w0fT2AwNgZbEx26dO2oUD0Hja8HqQJWpP8seG40ZCe6N+m5RbM10C6wK
	 g5OVonAuJ7khl5KR4n0o5LxXJJ2YVunS1Dm3OaaF1R7OzE17v9incuR9nhv1GXVvwYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608416;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=gNKbp/WWvmLlokWCs8X1Dxf4b0jSZy6x4bUaOQrPDaY=;
	b=dBhb7CrEmu2Wsb126X+tzClDX1NHTniVjfQ816rl5PZ2jNqU0slT+t8Zw3t+1Zm3Gz4W
	 T7qsljXDmxR4d6YYihxW9xRq5Kx+AWFoFTdNEdj+p/B2nBoujxQ1+lH8ST6PEdV2UzLPV
	 3vC3oMMmkHdp4SbhRvdNaGM8Vs+kVkm14jsNcyLV6o7OJaEEkVw2WIQPi1zPfd/JCa9lV
	 bcxyaVwVTBJlVf2KqZawvGJrdu5nMiv8j3SmyjbN7akfv3zQru0aqpv3Wd/RTchCmcn7R
	 1D08MR8cGLcxNmAVrjDkq2G9DhN/B0kzOBdDOLVEuUm8ErHJpybVnsvwTjNyJBR+zuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lkooHqtj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75B6606A333
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lkooHqtj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B7C1F008B2;
	Wed, 25 Nov 2026 12:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608416;
	bh=gNKbp/WWvmLlokWCs8X1Dxf4b0jSZy6x4bUaOQrPDaY=;
	h=Subject:To:Cc:From:Date;
	b=lkooHqtjHybb+MgZFOLG1Dg/775W+TqcEcoJom/18H1dpfu/inSyB4NUE7aLmwTSN
	 NnUnXRAAZLE7qBGsnxb9YHQBfwymdIXAHWPNWufR+kZ9RAjEa8H3mpoW7P7dGjq9Ba
	 cN1syJeWtNtJ1uNMLzR536G/UGMQSEzZ2rhhEJ7I=
Subject: FAILED: patch "[PATCH] usb: dwc3: gadget: Issue no-op Start Transfer only for stream" failed to apply to 5.15-stable tree
To: Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org,selvarasu.g@samsung.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:40:36 +0100
Message-ID: <2026112536-chili-unchanged-4493@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e616d91e02881983e5dadf6980c4aa08123800b3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112536-chili-unchanged-4493@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e616d91e02881983e5dadf6980c4aa08123800b3 Mon Sep 17 00:00:00 2001
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Date: Wed, 21 Oct 2026 00:38:07 +0000
Subject: [PATCH] usb: dwc3: gadget: Issue no-op Start Transfer only for stream
 endpoints

The function driver may re-enable an endpoint before the End Transfer
command issued on ep disable completes. The no-op Start Transfer issued
on ep enable then fails with "No Resource".

Only stream endpoints need the no-op Start Transfer to initiate a
stream. Other bulk and interrupt endpoints start their transfer when a
request is queued. Skip it for those endpoints, and move it to a helper
to be reused.

Fixes: a97ea994605e ("usb: dwc3: gadget: offset Start Transfer latency for bulk EPs")
Cc: stable <stable@kernel.org>
Reported-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
Closes: https://lore.kernel.org/linux-usb/20260227121236.963-1-selvarasu.g@samsung.com/
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://patch.msgid.link/227e97e30d26a017c92d7008a8633c01f955d088.1792542945.git.Thinh.Nguyen@synopsys.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 4de3b81cb678..e68584f20fbd 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -906,6 +906,54 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 	return 0;
 }
 
+static int dwc3_gadget_ep_start_noop_transfer(struct dwc3_ep *dep)
+{
+	struct dwc3_gadget_ep_cmd_params params;
+	struct dwc3		*dwc = dep->dwc;
+	struct dwc3_trb		*trb;
+	dma_addr_t		trb_dma;
+	u32			cmd;
+	int			ret;
+
+	memset(&params, 0, sizeof(params));
+	trb = &dep->trb_pool[0];
+	trb_dma = dwc3_trb_dma_offset(dep, trb);
+
+	params.param0 = upper_32_bits(trb_dma);
+	params.param1 = lower_32_bits(trb_dma);
+
+	cmd = DWC3_DEPCMD_STARTTRANSFER;
+
+	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * For streams, at start, there maybe a race where the host primes the
+	 * endpoint before the function driver queues a request to initiate a
+	 * stream. In that case, the controller will not see the prime to
+	 * generate the ERDY and start stream. To workaround this, issue a
+	 * no-op TRB as normal, but end it immediately. As a result, when the
+	 * function driver queues the request, the next START_TRANSFER command
+	 * will cause the controller to generate an ERDY to initiate the
+	 * stream.
+	 */
+	dwc3_stop_active_transfer(dep, false, true);
+
+	/*
+	 * All stream eps will reinitiate stream on NoStream rejection.
+	 *
+	 * However, if the controller is capable of TXF_FLUSH_BYPASS, then IN
+	 * direction endpoints will automatically restart the stream without
+	 * the driver initiation.
+	 */
+	if (!dep->direction ||
+	    !(dwc->hwparams.hwparams9 & DWC3_GHWPARAMS9_DEV_TXF_FLUSH_BYPASS))
+		dep->flags |= DWC3_EP_FORCE_RESTART_STREAM;
+
+	return 0;
+}
+
 /**
  * __dwc3_gadget_ep_enable - initializes a hw endpoint
  * @dep: endpoint to be initialized
@@ -971,55 +1019,10 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 	 * Issue StartTransfer here with no-op TRB so we can always rely on No
 	 * Response Update Transfer command.
 	 */
-	if (usb_endpoint_xfer_bulk(desc) ||
-			usb_endpoint_xfer_int(desc)) {
-		struct dwc3_gadget_ep_cmd_params params;
-		struct dwc3_trb	*trb;
-		dma_addr_t trb_dma;
-		u32 cmd;
-
-		memset(&params, 0, sizeof(params));
-		trb = &dep->trb_pool[0];
-		trb_dma = dwc3_trb_dma_offset(dep, trb);
-
-		params.param0 = upper_32_bits(trb_dma);
-		params.param1 = lower_32_bits(trb_dma);
-
-		cmd = DWC3_DEPCMD_STARTTRANSFER;
-
-		ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
+	if (dep->stream_capable) {
+		ret = dwc3_gadget_ep_start_noop_transfer(dep);
 		if (ret < 0)
 			return ret;
-
-		if (dep->stream_capable) {
-			/*
-			 * For streams, at start, there maybe a race where the
-			 * host primes the endpoint before the function driver
-			 * queues a request to initiate a stream. In that case,
-			 * the controller will not see the prime to generate the
-			 * ERDY and start stream. To workaround this, issue a
-			 * no-op TRB as normal, but end it immediately. As a
-			 * result, when the function driver queues the request,
-			 * the next START_TRANSFER command will cause the
-			 * controller to generate an ERDY to initiate the
-			 * stream.
-			 */
-			dwc3_stop_active_transfer(dep, false, true);
-
-			/*
-			 * All stream eps will reinitiate stream on NoStream
-			 * rejection.
-			 *
-			 * However, if the controller is capable of
-			 * TXF_FLUSH_BYPASS, then IN direction endpoints will
-			 * automatically restart the stream without the driver
-			 * initiation.
-			 */
-			if (!dep->direction ||
-			    !(dwc->hwparams.hwparams9 &
-			      DWC3_GHWPARAMS9_DEV_TXF_FLUSH_BYPASS))
-				dep->flags |= DWC3_EP_FORCE_RESTART_STREAM;
-		}
 	}
 
 out:

