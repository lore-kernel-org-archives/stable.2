Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794471785;
	b=KLl4BczQ25rc2223aZ5TP0WdSvF9HSoT1qdgNQ5N+Pf0KARRcuvorJH+R7UBj1fWhAj7
	 JPENGA5DMTF7QZKAlJnLnqDkX/TDZGgaiKzkiNdEfnzfFqLlOvY4cUdgaI2nJDzMtN/WX
	 u5G2BSNUFi909oxteNlcTg/Z4p3ludBE+MIGqBPvZszFTS0TUjllwAt1auBGxskT5OzyI
	 r7MtThmLZRsK4DPYIhda9H8jI3qNtAkovA9y80i/XZFweBCbxptbeqFpO9iVVir2TuThv
	 k54vJdsQjgVQF0h7A4LFomz84n903hPSRoLGxZHuZlvUCvJVEltImr8EnN9cw3uIAzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=8RGDeXbdt83hUd3Brk6p8Eodv6wi4lD1lBh2U2cXcg4=;
	b=lMbXeV/cl3WZgIkzFfFcp8+4d9Marx4Hr/EFG3bBw+jP0OUVCRScjY46Vt/3Cy+sLwp8
	 Pv2tvrqCsHGWFxTLyx2aLgaPdBOzJxyIozqMFQHpFwpkWIvGYTcU+cw/APpU1yfxxTFfB
	 MDzN2jECuQiHra+WAM/2yxtsvLILHZrTMI0W3K58qTXfewUt0e86Lf5iBkzfKCAYauzSu
	 nVW8t1yiBj67Bv6BUzyIOfYJdnLPxQy813qPtrSV9cQFXry9LQ1pqyI0l3X+suEdksgbU
	 mnOU1Uk8RZlO4yzrLQK7YdL0E0fCi8xMgM98JzFPRUhObnyE+TlB5FU+V/PaW5aV9mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OJYeJzA1;
	arc=none smtp.remote-ip=209.85.160.43
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CF2606A881
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9CF2606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OJYeJzA1
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4a77dcc4ca0so2891704fac.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794471784; x=1795076584; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8RGDeXbdt83hUd3Brk6p8Eodv6wi4lD1lBh2U2cXcg4=;
        b=OJYeJzA1bPu9N5OdOgPqFCAMx9AewTZLtz/IuI2ooVcSSifmQdSaHg5jVZTKwwtnmN
         e68BqCRgWN9EWb3JRSJE/QIsbDOHRlOf0pNjM/bkwin/MBBSZJ/EBXiK0KHAznP5x20O
         Mc2tpeXls9/9L/5ZZ6qos2ooWFX5PQN2BrR7E5Pa/okDKP7sJyy95EzqssLS8J77fin4
         y0Iww423Tv9ZHPEJNR4Rped9BMs8KKxM5ajtEg6JdL/ssmp6+qq3TCtrCSwe4MCxgQ+y
         13e72Jb+cHBmY3gvgDuF0X3K3VM/6QwTUfp3gtjrwJpcf37lgdKsZKnK3kmG4f3YHlQX
         vBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794471784; x=1795076584;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8RGDeXbdt83hUd3Brk6p8Eodv6wi4lD1lBh2U2cXcg4=;
        b=IYWMGmtdBNDzoDsGANXQfk26iRRh+uaCb5me94pcgiyQRLzc1oyQ5OJ/6HML3nYo3q
         bVBKB1KV1J4tu32e0vkK+ZD7TLhyP0XTXi/TDYsyAV0PoKFMPEOImJLcvaKfAB+66MQ4
         iqYLy+SBIpXDnBV8p4mTm4p8jjprpKAA2xdLV5HMEp6h122D8DV0yFerfP1nqAtK4pXT
         5s1ySp3XRpCjwyyWfuP1u7GMMTg0iyUPsuU/IXwzg0/H3uenBEpEp/A90Dvbyhmu0KUt
         Rp1LUIojjiNH0X2d8Ye/i+cP1oUsoAIQ6Sw5fqX6PuEfLm4QLxBZzJ4fG6b63dCcg0Jc
         os1w==
X-Forwarded-Encrypted: i=1; AL+hErFy50/ciGh1UOWKwL2NaBvrZvyj73ehrft1XVZ68yIHO1Kn2M36ZNnr7swKyBkJCkeeoizWElE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8dRL8b1FEy/7zp3tJ4kHx57CiCqJ8YtYCZ5JiTi1mtInqiFISW
	ZTt/C7OFTNPfO4ZeZ/KnE+vkxsrD3nkFPydNxav9gw759lzxU7Vi1TdQfiqeu+Pk
X-Gm-Gg: AYBFou1tI3XXlngSiYDrvbRjRxQLTCQusHj2BiZ+gBFgONQZcpeMbiKxcm+HWVSR+MJ
	v7fzVOEWffObaSr7inVQxdYFjJ/mbqsssA+lYArvV7Ao+yP3IWeYlpL2UKaxZvEKNFhYd/IdUv2
	Iedi+CcMbpeUiNhvpTP2SdT10dZ9JhDjXosIRRX9cRiGYmZgmpV2a4mfzEyAbxPno1uxrGuATok
	9dlS8QFt7Y46tgo9QWs0dST0a/aXcNfpHpRSBzy+WcaUxfK+WFNfMNOM300uaGuoumYBWvZSoG3
	KLzQKXVHHqSrWYCjkEFpeeFPz4vp0HeI34/Qqvn6GMe6h0lXL0N5LEqNAP+/GVWZpbDpTZC8CX+
	4GVt7Dx1kWthiLPC1CeVVi+BqoaLobT3N/WyScGIbG2Sr34ghaq0l/zhymXdNLIp5bJLuHP+gpv
	x39WsitswMh+gK8xNxZhml9lAzypnVm8p67RAnqoDdqKzMi5ZgjVHgJ3Pw8YUl00BRqqZIiFXDI
	N6vKMjr3aP6qILWd6uYH7jBkJCIJm54acaSNeMKCz/mfFaS/jA/x/c5bHn1LDcIz7t2ulbqSkfN
	AiIhHJn1AWfo8Z0y7saDJ2G83+b6jZDha75vxbecNkLevixkpgbF2dQ7GRAbZj8BKNw9+NVVFQG
	R2kR84+6ILquOCg3yG5LUPBbp0CHkD5Fg/JfhzSSpulZwO91msN7Jd7G0WDve7nRbcwDVpzCm+V
	hW4IAq53zeFVZrywav+ugxW5A7ruoNqsSvRIfQfShN7F6d5EwqiaQ=
X-Received: by 2002:a05:6808:10ce:b0:4c3:ebb:63d6 with SMTP id 5614622812f47-56b97503626mr4350951b6e.39.1794471783661;
        Thu, 12 Nov 2026 00:23:03 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905d3bab2sm7411157b6e.12.2026.11.12.00.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 00:23:03 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 12 Nov 2026 01:22:50 -0700
Subject: [PATCH v4 1/5] dmaengine: dw-axi-dmac: keep cyclic mode in the
 descriptor
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
Message-Id: <20261112-submit-dw-axi-dma-stop-pause-v1-v4-1-3ebc24b243db@gmail.com>
References: <20261112-submit-dw-axi-dma-stop-pause-v1-v4-0-3ebc24b243db@gmail.com>
In-Reply-To: <20261112-submit-dw-axi-dma-stop-pause-v1-v4-0-3ebc24b243db@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

dw_axi_dma_chan_prep_cyclic() sets chan->cyclic before allocating all the
hardware descriptors and leaves it set when preparation fails. The flag
also survives cyclic transfer errors and channel resource release. A
subsequent noncyclic transfer then takes the cyclic completion path,
leaving its cookie incomplete and its descriptor on the issued list.
Its zero period_len can also cause a division by zero.

Resetting the flag on failure or channel allocation is not sufficient:
preparing cyclic work while an ordinary transfer is active changes how
that transfer's completion interrupt is handled.

Store the mode in each descriptor and use the completed descriptor's
mode in the interrupt handler. Cyclic preparation sets only its own
descriptor's flag, while the zero-initialized noncyclic descriptors keep
it clear. Error recovery and channel reuse then use the next descriptor's
mode without relying on channel-wide cleanup.

Fixes: 1deb96c0fa58 ("dmaegine: dw-axi-dmac: Support device_prep_dma_cyclic()")
Closes: https://lore.kernel.org/r/sashiko-outbox-208213@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 35 ++++++++++++--------------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          |  2 +-
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 7520c78f55cc..6dae63024721 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -801,7 +801,7 @@ dw_axi_dma_chan_prep_cyclic(struct dma_chan *dchan, dma_addr_t dma_addr,
 
 	chan->direction = direction;
 	desc->chan = chan;
-	chan->cyclic = true;
+	desc->cyclic = true;
 	desc->length = 0;
 	desc->period_len = period_len;
 
@@ -1117,25 +1117,23 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
 		goto out;
 	}
 
-	if (chan->cyclic) {
-		desc = vd_to_axi_desc(vd);
-		if (desc) {
-			llp = lo_hi_readq(chan->chan_regs + CH_LLP);
-			for (i = 0; i < count; i++) {
-				hw_desc = &desc->hw_desc[i];
-				if (hw_desc->llp == llp) {
-					axi_chan_irq_clear(chan, hw_desc->lli->status_lo);
-					hw_desc->lli->ctl_hi |= cpu_to_le32(CH_CTL_H_LLI_VALID);
-					desc->completed_blocks = i;
-
-					if (((hw_desc->len * (i + 1)) % desc->period_len) == 0)
-						vchan_cyclic_callback(vd);
-					break;
-				}
+	desc = vd_to_axi_desc(vd);
+	if (desc->cyclic) {
+		llp = lo_hi_readq(chan->chan_regs + CH_LLP);
+		for (i = 0; i < count; i++) {
+			hw_desc = &desc->hw_desc[i];
+			if (hw_desc->llp == llp) {
+				axi_chan_irq_clear(chan, hw_desc->lli->status_lo);
+				hw_desc->lli->ctl_hi |= cpu_to_le32(CH_CTL_H_LLI_VALID);
+				desc->completed_blocks = i;
+
+				if (((hw_desc->len * (i + 1)) % desc->period_len) == 0)
+					vchan_cyclic_callback(vd);
+				break;
 			}
-
-			axi_chan_enable(chan);
 		}
+
+		axi_chan_enable(chan);
 	} else {
 		/* Remove the completed descriptor from issued list before completing */
 		list_del(&vd->node);
@@ -1204,7 +1202,6 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 
 	vchan_get_all_descriptors(&chan->vc, &head);
 
-	chan->cyclic = false;
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
 	vchan_dma_desc_free_list(&chan->vc, &head);
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index d8dd07efe60f..3c86e5d468ea 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -50,7 +50,6 @@ struct axi_dma_chan {
 	struct axi_dma_desc		*desc;
 	struct dma_slave_config		config;
 	enum dma_transfer_direction	direction;
-	bool				cyclic;
 	/* these other elements are all protected by vc.lock */
 	bool				is_paused;
 };
@@ -105,6 +104,7 @@ struct axi_dma_desc {
 	u32				length;
 	u32				period_len;
 	u32				nr_hw_descs;
+	bool				cyclic;
 };
 
 struct axi_dma_chan_config {

-- 
2.53.0

