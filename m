Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710015;
	b=Y2d9lnRUkDyWR39znUZJ2299w8jbDcr0uw4ItVgW0CHk0V7msb6iqKaEJX02616xhRqq
	 POVO5VNRNbdEVQSFf9yTOB1sADBs6hjM1M7JWN6MAuYvOb7V2i/yikvh9PYgWFYCo5tJy
	 Mfo7GI1k6dJacX/tEjogSX9i74ymPG9W48152+QH9Da+S9y6dNxOv+BcTWn6d3C5/93d1
	 NdnqHXHhUY6y2ThK2vuk8hJ4GsXqp0HDy/KApOvYTYYBpx7nExX+CJrGDPGx/C1+qp6I4
	 hKL4YnXqi7tTGzTZsIItZP2jUyX3TRZhtUjcVpPbv/WbnrHw14HAR7Kjmi5o175xVqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710015;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DPS0IRol0g/KBVg5nEmZ0cm43PyuuP5D5nAkm/MQ0+0=;
	b=mjbdWOsw05/5h6kIxJQ/d1WCy0S32hPkvgCHVZbMtldQlxB6fJZxWOdDJV7XSWl1ihO3
	 uSP3vnrKQfOE8IgxKBXXNsinsfS4hLFBqx2+7j4upGsiVk3XWXYeSb73LDmCRN5mC3SMs
	 tMLZSGuLInYAOZjbSIdhmAleU2u1sXUj3Oz5yE7nkoHmVOsuzDQDQ35weLr56eUJ/BbFU
	 mwV/pgNchRFS2Dz261uRflZcO+ufdHX/2d4d528b5Skw7nHiXpvjxBj/ddA0zgQfX8IQZ
	 BoCvXivkfJAMYuYpkxmurLorO6NxxbZikpbCmXIE0i7g6/YxYacLpjudyT3ePmK9LSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c+0B8jY6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EC3606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c+0B8jY6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166CE1F000CA;
	Thu, 26 Nov 2026 16:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795710014;
	bh=DPS0IRol0g/KBVg5nEmZ0cm43PyuuP5D5nAkm/MQ0+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c+0B8jY63KgCeSf4aKG1zuQ2pLEEedlvuV9dlZZePQV9VOmxbqnQKRbH6NmAe9us3
	 56bkSBJGR/l/WS6UXuveTbbpLj9qBUHNoXLOBKchjzke4MWH6vb/VvwXqUS24+eCZV
	 4IMGAXcr7MgH+w701nAkG0dzAlLIPwMemlaoS20OGb/xnP3Gted+tNhgW5/Cb3vPKj
	 o0gSnp3a7O/kqBqTOHJem1tV1qyh/UeLaaUWffmjOJT1kAMeJS/KzuJJrQNZKY1abo
	 YT8A7kIf1qwgnA0awff6N8cmRD2RLw/CykZ40+EhO0VFX9hoVEqGIAHR5PXvszN16f
	 waxGMpvW8vSZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	stable <stable@kernel.org>,
	Selvarasu Ganesan <selvarasu.g@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/4] usb: dwc3: gadget: Issue no-op Start Transfer only for stream endpoints
Date: Thu, 26 Nov 2026 11:20:09 -0500
Message-ID: <20261126161938.2487645-4-sashal@kernel.org>
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

[ Upstream commit e616d91e02881983e5dadf6980c4aa08123800b3 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 97 ++++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 47 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 7bb843ec9592a..0b2ae9743f627 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -853,6 +853,54 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
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
@@ -918,55 +966,10 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
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
-- 
2.53.0

