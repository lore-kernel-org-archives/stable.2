Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794960483;
	b=XE5SVqWJCSmIP6LsGCejws6YVnDeF5lXBmjfJ4GO4VuIEx/DYqdesQ3kVJ0h2GEZDavC
	 9UYAzL3Zw3Edf4/TFg5wpogPBgyq6RCf95Txj3hUlM5KldFT7yshbaN7GlTBZbPYUhW8r
	 vMr6ykXJEfEPIvc2HA8x0NucLkjR3lhyZiU30gW6GcuFJ1P44Q15HstLmFQz+hXGGgti5
	 zCSmcjPufKTA6GG8iUvKJc65iL9VvOEAJoA0mPT0vPlM/ZQzQKiC7t8xpTV2Hn2S1zIfX
	 6s6jIzatVbkDccIMVSk4p+v4xtriK8NU2WeMAtb2JNgZim6ZGlrus1ObilgAN37swQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794960483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=fVtERnt1yagTDveFZiJK9CUhtwDO+IK5KagdoU7rqog=;
	b=mECAjgQ7OyDyFt2hpRTZx1NrFKrpQmTSf11gTckDmd87M+ZcLS2K0vrD3P4I3Pepwc32
	 JlHRjbnlX8wTmJe5xSgzF48ODz+Q6K+6SXTEt+Bpshit2EkBrEM6lK39xdYd21HJDczb+
	 JdL7/JdUNOrA2NKMFonKdKqEw2OE4CzxwtVTH5yCELCPCebbQDZftxTwQ/INkX4kpX52+
	 goI463MXGeiBcQcBjJSh5rRwxW+AZ8NHBqEg46RjzEpQ4/7bTaqDfqxJXzxGbXewtbARc
	 2UHWnvgRmHBfDiwQ564/5eD1Py6QhnXojojceT2NnDlSiFoISrvOgJU/VpHKTZPY8Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Twnn6oHg;
	arc=none smtp.remote-ip=209.85.160.48
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBF3606A899
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 00:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DBF3606A899
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Twnn6oHg
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-48e2d5a69c4so215073fac.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 16:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794960482; x=1795565282; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fVtERnt1yagTDveFZiJK9CUhtwDO+IK5KagdoU7rqog=;
        b=Twnn6oHgLVr/9lhxumEC2LkQUw+5sp0zsbcRYQJsTybDl4RE7N+asuBKqbuBxXnRV8
         L3bMr1IO/JLbr3UVYAokFpl8l/wHDdPmERgtHFDFCofpniTBag9H5XK7mhmDuIqraX1N
         CtSKhKFVeJbc0iOorbYDWWLifQnxA0Lmk4v/90lZRGo48aoiM2WMmrAO+a19VxoD7f8e
         8sB994kABifSAZHmYawOOPu0UjYpMEVeSCbHTXb9Vjo9ehq123mZ2vryL+WI4llw6GJG
         tYMHNHTOckhsUDTV51s0JS7w9vW1A8yfdFJJbss6Fcrs4ZdZvbySxTJX9aUOWgmNjkIf
         6HrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794960482; x=1795565282;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fVtERnt1yagTDveFZiJK9CUhtwDO+IK5KagdoU7rqog=;
        b=G5KCrCEaEeN+UpsYFLq/SSJUnf1puUOnxAYU+nHzxg1l80Pg4QblTmy4hB4GDkzADU
         XUmdWTRmb1A1SDpVvjXYLVLc/Ce7yA+2IIp9x5Whha0ygezC7mo0zd5eS/X/2YJutA61
         tRVKDr2S8OEMemSiyIFvqUQ0TehcQXu5IOmQS8ukR7pXbQvu/POuqQBjcagA9h9CJSyJ
         DelldM/2c9Sf4tGqA1RegUkVN2lG7iEgbK9BH6qMSjcshUUsHhpOI/q5BE/iMiwgTKR+
         U8+QEEhLXkZUhIqX7+VOm/ZLxoJVUvo0kCyMjVMUoxbbeipCnc4x/S+2PdvRzQR6qMPX
         PTgw==
X-Forwarded-Encrypted: i=1; AL+hErEEz3+mRGuMKqV5D3C1kSVSYcXrx1WPfK/bJHD5ChwF6x/iU3LIG6X5ksRbAa6z53XY7GgeDpA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9v1wks/zqMq5e6oEZKMrjvhZK1jzJlCG7GCVwfQMN2kkBBybX
	kaQ3sXnUdnDCmcqQcoIwze14KyGGHnqnptUujUufUk9onj9gTOEZ6N2r/5WQ8mTWxhQ=
X-Gm-Gg: AYBFou0O41H0ovjwJWv4e3Cir2Q5vP1Th6Nj2xEEhFJEG6XEQeBx7snWGb5R/l1oae3
	DKugAYiXsglF7OrDRXoOj1ntWrtVxOegtDsAPXHkc7UzyUVFfv/+xlhIS6CV+ow5QWXbqX2OznD
	ACG1pZk9SalJGaELwg4O877l/p5hiuraSzJzxb4TftBNRXQZMLZRUzjtu7MzT+LvfRkm2HMVJ/Z
	5byMMsXMZeJ7cosGr7P37wLU0ijtCTDCo9hhlYPoq202vjkVcyRR5NCaTrY66qJxt/pnO4sh0DX
	YOTvwEACepSqAYD6um1wpogM113SXVIIUsHfKw/k2jBtemkmvZ8cjhGXwpvxbxQ8ksl8JCOeNlW
	bRRF3mjoXFFa8GxeXwABVXNyBw2q0aCKd2yUJaOSFaW/jlTbbu07TzMa/H1oPM6tW+oTL3+P4UW
	J6OVApPWWyM7bXQWE1N7DDPFKM+Ej4XMNyg5s2DkBppM9d50gbwV1YfAGa+QX2ZEF738xN8RYhT
	Rwe0MjzCEVKKD5NKfyBMEDOrMbXUQqDazxEECFWrk/Sx7x7uJrYUj5ceahmFL5QC5Ipj42KREGr
	cAafbwpMmMFiG5AihfGC6dWgDnF1pHOx2rhqaQIIguqlK40LANXDIE5IxFX+cQYp6fLCdqFxQgY
	cUoyWVw7Q/O1m5M+tttKXQhSAnVeXAs+/4nrVfzvxT5+ZNB1k/aA+iewk36t17/jRM+rQfMxVon
	k+dOjLLqe4xy0MmdvPSYtz7IDbcXV37Ac4CfcHAsnKn5HBp1MbwSM=
X-Received: by 2002:a05:6808:3a19:b0:571:d998:332a with SMTP id 5614622812f47-5773e848cfemr1518599b6e.47.1794960482162;
        Tue, 17 Nov 2026 16:08:02 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5777b393d40sm434954b6e.17.2026.11.17.16.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 16:08:01 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 17 Nov 2026 17:07:46 -0700
Subject: [PATCH v7 7/8] dmaengine: dw-axi-dmac: serialize interrupt status
 with channel reuse
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-submit-dw-axi-dma-stop-pause-v1-v7-7-d5f2309afd72@gmail.com>
References: <20261117-submit-dw-axi-dma-stop-pause-v1-v7-0-d5f2309afd72@gmail.com>
In-Reply-To: <20261117-submit-dw-axi-dma-stop-pause-v1-v7-0-d5f2309afd72@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>
Cc: Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev

The interrupt handler reads and acknowledges channel status before taking
the channel lock. Termination can finish and a new transfer can start
before the handler takes that lock. The saved completion or error status
then applies to the new descriptor, stopping it and completing its cookie
before its DMA transfer has finished.

Termination also leaves completion and error status pending. A subsequent
interrupt can consume that status after the channel has been reused, even
if no handler was running when the old transfer was stopped.

Read and acknowledge status under the channel lock and keep it held while
processing the event. Move locking out of the completion and error helpers
into their sole caller, and clear all channel status after a successful
stop. Status collection, descriptor ownership and channel reuse then share
the same serialization.

Initialize the virtual channels before requesting the shared IRQs so every
lock is ready before the interrupt handler can run.

Fixes: 1fe20f1b8454 ("dmaengine: Introduce DW AXI DMAC driver")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 31 ++++++++++++--------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 97098367535f..0116c44d3bef 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -20,6 +20,7 @@
 #include <linux/iopoll.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/kernel.h>
+#include <linux/lockdep.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_dma.h>
@@ -1071,9 +1072,8 @@ static void axi_chan_list_dump_lli(struct axi_dma_chan *chan,
 static noinline void axi_chan_handle_err(struct axi_dma_chan *chan, u32 status)
 {
 	struct virt_dma_desc *vd;
-	unsigned long flags;
 
-	spin_lock_irqsave(&chan->vc.lock, flags);
+	lockdep_assert_held(&chan->vc.lock);
 
 	axi_chan_disable(chan);
 
@@ -1082,7 +1082,7 @@ static noinline void axi_chan_handle_err(struct axi_dma_chan *chan, u32 status)
 	if (!vd) {
 		dev_err(vchan_chan_dev(&chan->vc), "BUG: %s, IRQ with no descriptors\n",
 			axi_chan_name(chan));
-		goto out;
+		return;
 	}
 	/* Remove the completed descriptor from issued list */
 	list_del(&vd->node);
@@ -1099,9 +1099,6 @@ static noinline void axi_chan_handle_err(struct axi_dma_chan *chan, u32 status)
 	chan->desc = NULL;
 	chan->cyclic_restart = false;
 	axi_chan_start_first_queued(chan);
-
-out:
-	spin_unlock_irqrestore(&chan->vc.lock, flags);
 }
 
 static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
@@ -1110,11 +1107,11 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
 	struct axi_dma_hw_desc *hw_desc;
 	struct axi_dma_desc *desc;
 	struct virt_dma_desc *vd;
-	unsigned long flags;
 	u64 llp;
 	int i;
 
-	spin_lock_irqsave(&chan->vc.lock, flags);
+	lockdep_assert_held(&chan->vc.lock);
+
 	if (unlikely(axi_chan_is_hw_enable(chan))) {
 		dev_err(vchan_chan_dev(&chan->vc), "BUG: %s caught DWAXIDMAC_IRQ_DMA_TRF, but channel not idle!\n",
 			axi_chan_name(chan));
@@ -1126,7 +1123,7 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
 	if (!vd) {
 		dev_err(vchan_chan_dev(&chan->vc), "BUG: %s, IRQ with no descriptors\n",
 			axi_chan_name(chan));
-		goto out;
+		return;
 	}
 
 	desc = vd_to_axi_desc(vd);
@@ -1158,9 +1155,6 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
 		chan->desc = NULL;
 		axi_chan_start_first_queued(chan);
 	}
-
-out:
-	spin_unlock_irqrestore(&chan->vc.lock, flags);
 }
 
 static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
@@ -1168,6 +1162,7 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
 	struct axi_dma_chip *chip = dev_id;
 	struct dw_axi_dma *dw = chip->dw;
 	struct axi_dma_chan *chan;
+	unsigned long flags;
 
 	u32 status, i;
 
@@ -1177,6 +1172,7 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
 	/* Poll, clear and process every channel interrupt status */
 	for (i = 0; i < dw->hdata->nr_channels; i++) {
 		chan = &dw->chan[i];
+		spin_lock_irqsave(&chan->vc.lock, flags);
 		status = axi_chan_irq_read(chan);
 		/* Leave suspension status for the pause and resume paths. */
 		status &= ~DWAXIDMAC_IRQ_SUSPENDED;
@@ -1189,6 +1185,7 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
 			axi_chan_handle_err(chan, status);
 		else if (status & DWAXIDMAC_IRQ_DMA_TRF)
 			axi_chan_block_xfer_complete(chan);
+		spin_unlock_irqrestore(&chan->vc.lock, flags);
 	}
 
 	/* Re-enable interrupts */
@@ -1225,7 +1222,7 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 
 	vchan_terminate_all(&chan->vc);
 
-	axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
+	axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_ALL);
 	chan->desc = NULL;
 	chan->pause_requested = false;
 	chan->is_paused = false;
@@ -1599,10 +1596,6 @@ static int dw_probe(struct platform_device *pdev)
 	if (!dw->chan)
 		return -ENOMEM;
 
-	ret = axi_req_irqs(pdev, chip);
-	if (ret)
-		return ret;
-
 	INIT_LIST_HEAD(&dw->dma.channels);
 	for (i = 0; i < hdata->nr_channels; i++) {
 		struct axi_dma_chan *chan = &dw->chan[i];
@@ -1616,6 +1609,10 @@ static int dw_probe(struct platform_device *pdev)
 		vchan_init(&chan->vc, &dw->dma);
 	}
 
+	ret = axi_req_irqs(pdev, chip);
+	if (ret)
+		return ret;
+
 	/* Set capabilities */
 	dma_cap_set(DMA_MEMCPY, dw->dma.cap_mask);
 	dma_cap_set(DMA_SLAVE, dw->dma.cap_mask);

-- 
2.53.0

