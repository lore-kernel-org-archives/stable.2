Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C66D273803
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 02:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780713644; cv=none; b=m+fOjpO+XoHyhd9Uz64gpalMhhCmSUqozhRXJCdfS9OtVXFMGzCBkWhlA0erGJHlhvU+gfXPDtzD08OZHqUbmUt1Gj8GJNksRX2ZhYUCtOcsvpCoCjcA8UKdCvqvZKnYdvSKQJ1ZCvR1osC+VNOnZpe3PrfvnTMctPpAqh7vQCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780713644; c=relaxed/simple;
	bh=M5Bi8ieqGgSX9vQ1NT8hurUhkbNY6pPyQdskgwNd82k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gxc0oIgp9loe1EzSOeBwpnrwQuYCcZE/tQoqkS2vttSs3Rjru+MyAZvBhfiHOw8CcydEFvNTLUpCkaiuhtE9GS6Lpc8wJZxgTf9K3IPeBbkT7qIjZbHZH0gpuH0UljKrX6eepc5D9Wqm7BYZCW5eCoCRJ993QM5JQ5gokYveQIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myPm84xg; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myPm84xg"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36babe2c4bdso1661035a91.1
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 19:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780713640; x=1781318440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OnUZWQkJ/UT6kL1pJlMljxV5hMYiFMtGqMjvgMPjKdo=;
        b=myPm84xgChtImCu0mL4QpMqL4H/zr+UqtMPY06UXC5SacM25e1MsZK1kJOlaY6iLA6
         ciwmIJoJpipH9NZKE5b80NJn98G6x5PqusIRcXYYhpnzhdFsA3sqbYgc+wtMuU4zF4zG
         UZW4l75W352I0A++MP54RbNuu0Iz+qhl4u/15aXLfl9m4DWwIur+R/drwQILbWZTjF4N
         M1QDc08eJMMvgv3hf2CNaISdhdD7U/nKfXfaLB91aOEQ91D8H1QfukeIHAhLyJypfdvT
         kZWkikpq70cFIByfBAeBTGI1hTVIfZWwQwzZQQuoYD7svFzLFjj0Js5bvkm1NT8TdfEE
         LC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780713640; x=1781318440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnUZWQkJ/UT6kL1pJlMljxV5hMYiFMtGqMjvgMPjKdo=;
        b=B/x/SAghDSeM7EsoGv/+zHi66PG1hV8B5QSQa4+0lZnZjbdBVHmotHUYKce6Rorm55
         6QJWyLVU8cQHCw+gUxfBvMtTPZp29sFl2RLUM3w/js2mzD5zyWB6WdAiBkSSsEdG0kei
         hDeRKx2HZ1a7S7sLgSJ6IXtsPGFclqUmJZXnnsC2+yPWQC+clLPRF6nE1P9vZIT39xnp
         /kpjtnmFQdphyT5wxk0ik5jm5jYmO4geHfz0u7Jk+mFYiXBaay+pWf9yrpnLb9J1HMex
         t53KalmD9sW/nTS9Cch4WWfZRB1ZVL9XdCQqh1AhzX7oeK/DnLHQqJZQuIK8D7NmT/FH
         ZAdw==
X-Forwarded-Encrypted: i=1; AFNElJ9C0j3EpLGEQk9pg+CZyDMoWiiB0SxOxfQdFTkBxkrC/s2uT/qxJ3ZcnGMy9Puqi7mizWkmazk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3wugJzd0P1fDaNfnE5Jt7OVzf3xkC1P+O8/5kzIpCvhKZXLI8
	9YNpJJ4ILLCuWV+6E2BHE/IsDaWekN7msvTgXyhKVoP7Azhh8q1BnFhY
X-Gm-Gg: Acq92OG7uIgCYYyQchzsUcmH3gVObnwKAeINkHSDBGelZcZoYyksPs1YPS3lYswacSu
	WsuWmcW4aHb03A2TzwmIBfAdii/V33/LLyGL+6nn0YWV8guikjkVVh/LPeAa0ahpaPPrHp5pJtG
	Os6G5mPtCbMRkqmsHRu0Lmh7Q/zLruuGxwzFuDq/AuT4HavpR4nALByn1CwMGmWy1akIMSSQUXm
	1DBiFAtxp2gu2/TZy8/81eo5UsH8WkNlgol4gNI0XpC/iVb0hQngwKtvf3up7rCXC4vQiVHHz+Z
	FSwVNuJHFk1I6IUOS5v+k2u+8xGqnD3igl9lkA681mpFk57Sl5mq50CVe/8Z4aVSFgQWMraNP5j
	CfOBB+PFmJJWYysPeEbk6piHlEWJ4kTz93YXgARyXAfprMd0JAJ7Cq3hOVR8naMcWSMw9RELq6N
	eMofTgrxU9fKq6Vwbrv+U7xedn3aZIkzLgkGUKVsTQJIdRxyQp1CaH22VhQeRCU/feyTkQ9PwpV
	yiOASU/MpTtMQ==
X-Received: by 2002:a17:90b:4b0b:b0:36b:a2cc:4857 with SMTP id 98e67ed59e1d1-370efdaca8fmr8433786a91.18.1780713640163;
        Fri, 05 Jun 2026 19:40:40 -0700 (PDT)
Received: from viku.office.rr.lan (fs79022602.tkyc410.ap.nuro.jp. [121.2.38.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f70a29cd6sm7924955a91.11.2026.06.05.19.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 19:40:39 -0700 (PDT)
From: Vishal Kumar <vishalmimani008@gmail.com>
To: linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vishal Kumar <vishalmimani008@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: tegra-xudc: drain EP pipeline before dma_unmap
Date: Sat,  6 Jun 2026 11:40:11 +0900
Message-Id: <20260606024011.1160110-1-vishalmimani008@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tegra186/194/234 the XUDC posts a transfer-completion event when the
DMA write is dispatched to the AXI interconnect, before the store is
committed to memory.  Under SMMU strict mode dma_unmap() synchronously
invalidates the IOVA TLB entry.  An in-flight AXI write to the
just-unmapped IOVA triggers a translation fault (fsr=0x402) that
permanently wedges the bulk-OUT endpoint.

Observed on Tegra234 (Jetson Orin Nano) at ~170 MB/s USB-NCM transfers:

  arm-smmu 8000000.iommu: Unhandled context fault: fsr=0x402,
    iova=0xfffb5000, cbfrsynra=0x100f, cb=3
  tegra-mc 2c00000.memory-controller: EMEM address decode error

cbfrsynra=0x100f identifies XUDC (StreamID 0x0f per DT), cb=3 is iommu
group 4 (3550000.usb).  fsr=0x402 is a translation fault on a DMA write.

Fix: poll EP_THREAD_ACTIVE before calling usb_gadget_unmap_request() for
non-control endpoints.  EP_THREAD_ACTIVE clearing is the hardware's
guarantee that the endpoint sequencer is idle and all AXI transactions
have completed, so the subsequent TLB invalidation cannot race an
in-flight write.

Also change ep_wait_for_inactive() to return the readl_poll_timeout()
status so callers can detect a timeout.  On timeout in the completion
path, skip dma_unmap() to avoid the translation fault and force
req->usb_req.status = -EIO so the gadget driver does not treat the
transfer as successful or requeue the still-mapped buffer.  On timeout
in the dequeue path, emit a warning.

Fixes: 49d6f3dd4abe ("usb: gadget: add tegra xusb device mode driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Vishal Kumar <vishalmimani008@gmail.com>
---
 drivers/usb/gadget/udc/tegra-xudc.c | 47 ++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index 0b63b8c0a..3f18beddf 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -1023,9 +1023,9 @@ static void ep_wait_for_stopped(struct tegra_xudc *xudc, unsigned int ep)
 	xudc_writel(xudc, BIT(ep), EP_STOPPED);
 }
 
-static void ep_wait_for_inactive(struct tegra_xudc *xudc, unsigned int ep)
+static int ep_wait_for_inactive(struct tegra_xudc *xudc, unsigned int ep)
 {
-	xudc_readl_poll(xudc, EP_THREAD_ACTIVE, BIT(ep), 0);
+	return xudc_readl_poll(xudc, EP_THREAD_ACTIVE, BIT(ep), 0);
 }
 
 static void tegra_xudc_req_done(struct tegra_xudc_ep *ep,
@@ -1046,8 +1046,39 @@ static void tegra_xudc_req_done(struct tegra_xudc_ep *ep,
 					 (xudc->setup_state ==
 					  DATA_STAGE_XFER));
 	} else {
-		usb_gadget_unmap_request(&xudc->gadget, &req->usb_req,
-					 usb_endpoint_dir_in(ep->desc));
+		/*
+		 * Drain the endpoint DMA pipeline before unmapping.
+		 *
+		 * Under SMMU strict mode dma_unmap() synchronously
+		 * invalidates the IOVA TLB entry.  On Tegra186/194/234 the
+		 * XUDC appears to post the completion event when the DMA
+		 * write is dispatched to the AXI interconnect, before the
+		 * store is committed to memory.  A subsequent dma_unmap()
+		 * can remove the IOVA translation while the write is still
+		 * in-flight, triggering a translation fault (fsr=0x402) that
+		 * permanently wedges the bulk endpoint.
+		 *
+		 * Wait for EP_THREAD_ACTIVE to clear (endpoint sequencer
+		 * idle).  On timeout skip the unmap to avoid the SMMU fault;
+		 * the DMA mapping leaks but the hardware is already in an
+		 * unrecoverable state.
+		 */
+		if (!WARN_ONCE(ep_wait_for_inactive(xudc, ep->index),
+			       "ep%u: DMA drain timed out; skipping dma_unmap\n",
+			       ep->index)) {
+			/* Read-back completes the poll barrier; EP_THREAD_ACTIVE=0 guarantees DMA is idle. */
+			xudc_readl(xudc, EP_THREAD_ACTIVE);
+			usb_gadget_unmap_request(&xudc->gadget, &req->usb_req,
+						 usb_endpoint_dir_in(ep->desc));
+		} else {
+			/*
+			 * Timeout: mapping is intentionally leaked to avoid the
+			 * SMMU fault.  Force -EIO so the gadget driver does not
+			 * treat this as a successful transfer and reuse the
+			 * still-mapped buffer.
+			 */
+			req->usb_req.status = -EIO;
+		}
 	}
 
 	spin_unlock(&xudc->lock);
@@ -1443,10 +1474,12 @@ __tegra_xudc_ep_dequeue(struct tegra_xudc_ep *ep,
 		return 0;
 	}
 
-	/* Halt DMA for this endpiont. */
+	/* Halt DMA for this endpoint. */
 	if (ep_ctx_read_state(ep->context) == EP_STATE_RUNNING) {
 		ep_pause(xudc, ep->index);
-		ep_wait_for_inactive(xudc, ep->index);
+		if (ep_wait_for_inactive(xudc, ep->index))
+			dev_warn(xudc->dev, "ep%u: DMA drain timed out during dequeue\n",
+				 ep->index);
 	}
 
 	deq_trb = trb_phys_to_virt(ep, ep_ctx_read_deq_ptr(ep->context));

2.39.0
