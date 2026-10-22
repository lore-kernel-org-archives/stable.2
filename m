Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792703910;
	b=wzKE72ZtFagof+jzEHZIf71OF9uHalfwr6MsuywA2UWuV7Uhz8ilq86fnZINVd/gIpuD
	 Dry9yrrb9Rdn94iMwQHeXZsSihOGuJTobHgGgm8gPaY27xRLfd2qAJahhUu2rCD6jbAec
	 AP+GU5HNZYVkzAQoJCLrYkHDwVTY02x1ZLi7yT+5fd9lIjxOEyu0kcX/cizp+k/Io3xm3
	 AE/b9HDwoLCKyEXwVm3TsGp787gt6QXDP7m6Ox6CT54eivQSJvJ56zK8l5D/jDyyyk4nW
	 OthYuZIoJqjvgEfmkOrCWhamsE65EAhOZiQbeeoOyf97RFIGQcHu7hPXg60+hiSC4rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=WsTLwSG0j0rvcPTxUloruhaWzU98+XdsMcTu8lqR+tY=;
	b=hbU557VYPTkjFOKAb3aeKr3/9i71BlHZHCEC2tbufa3yI8sQMZuQGrAuq91/GL937TE+
	 AvwP8pw5bILt0qm9CTR8t4qT9ReOH7+XbRjy+glbsk65smfpVCxhFFFOw97gfB7jgEPyX
	 UIqremkedrGhCvONRhPkZpSdMxPZv9+CuNLokNpPFfrlfrKheshYTck7lYIBLqT0UGboY
	 nn8M5B4Unmf49jWlTzkLpTYZcQubNGvdLTI5jcxwsQF7QfH6tCDWaypbk1256QQSD6P1R
	 ukVDdLvp+CwbZExbqtyxxN5g4k/dVeMZ6Gxpwd+1CZCzLxO/2qx0zK45+7k6f3FUyTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=feedwtV4;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE96606A31B
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 21:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BE96606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=feedwtV4
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6f74f6b46abso132554eaf.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792703908; x=1793308708; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WsTLwSG0j0rvcPTxUloruhaWzU98+XdsMcTu8lqR+tY=;
        b=feedwtV4TJjqKCyepFs1ntK4KQAHY19WFwsBXYfd9S5IR65Z9uCdA8YDMvirAtZhfg
         4WpAq7mYG6z9xz92B2KFaBF5ZdhoCXWC0Sr0NP2i774o1Ghfi/J9iTZYX5pTEKzEra/C
         up2vtzJfR0gL+fy1QFpY/qlEjXWJJHKlxZZpd7jTeVaczLgbSopKUGjUSMPCTE6uqHf1
         00sV1w9VX3dyd5f2iIHkHVViyfBMIigBcv5aX/JkSv5AUZoXjX7GpxLpP3t1RxL76Shf
         2jBi+9s7Ftq4rAqK1klP0P2t7+gqh5J26ra9gdvlusLyArE8iIpp9NNnCMRBiEmgqLb8
         Iaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792703908; x=1793308708;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WsTLwSG0j0rvcPTxUloruhaWzU98+XdsMcTu8lqR+tY=;
        b=vn5j/mRb/16ulXRdhlG+aX/8VmiKNvkYAoOd6LB9CrGXvkj1lDoxZUlTUwhoLRzPgw
         rIcSUoFaOfn7EB3ZRT799e85URqSitASqcjJne/fSX9Zn8B6sarBb5uEoosJQ74JLrBo
         DVwlp6q+d7O1cptlB8JydU9m3uHxc0Vhw9eci18fse80A/nsu5v5DD68JWbO4/jP4QhT
         PDV2Ir4yhOj6+hC9qiKsaygaCIW5NDjM/za6hKxe7vOQ+rcwXf27QK8/pP6L6nzTeVL4
         Y1xnCwVszZZ7VfIzc4a6wtImCauAP3Ec448jpNZogT5dY7GmA5bWXPPxGG5Lng4uhEMT
         gU4A==
X-Forwarded-Encrypted: i=1; AKwUvBzHdiFJy51/OqTiaJKQXhNqQECYgyZXZfWC/62EYMGN/L++Xfee/hOwdjPBhfxIB5lMVSs/Q8M=@vger.kernel.org
X-Gm-Message-State: AFq9FYLr4dEKCSa+kfn7fZ8YbB7ioX7EdRl2LU7j1yMvpqOzw2nYBbZy
	e0Lyxmpx9ZL4aNfhcp889lgSfu2ZAXpmzQ1DKIVpUV8iV78gLpbV2DxD
X-Gm-Gg: AYBFou1lG4f4LtDrhc8rqftQhIB4Qk9AuU6m1b3HavRLdEHUz4gHpEgINCZY92a4b0N
	YLiWqPeujdoBsbfMdFJ9mMQtSpH0whbCvAsv4/Dz3DbipqviXaq2K/0SGl+hwgR89Gy6c65dz+k
	o/xsEIYNTflbaw7KfG2vUrjtVtmvO4UU9PivZnJ5VhiE1gJuTKSB7OVKEPPYx+b+iG/kaY9fujm
	BJ/6Kfbqd9B5EXuJbWhIdVgK+n1Adbo60G5ULt19qLEI186wnux39lI/dG21SPvy2sh8DHK+Dbl
	EnPUd2Qdi+areLTAttN+IKUwDQ8E6q8vsQ/V5WKbIFX0Nb0mV6dwBuyxqap0/P7Z1bZhZAGW3qM
	QiyJUwsHjIFb3BAPWH6V4xQFqGsUQFNmXb7dAQMKZn5EiDjUERvEHjkfyZQPXl5Uqj0edI5tTRI
	2GvJafkKmpdw76I587DKgjo3+8zJcStBt0D/nORZeX3tiT8oxy9AWXbH4XUR1CEdvmU+GNMqUxW
	9FS08Y5nB/E2gEKJjLa9Z0m7LrZo/rR3oyVqi4f6appHk2JyG2I3ybCHhYUiAN4IEhleV7/Pfqg
	Yg/9Yjyn6nWarhHETCnkrIVj3Fgo6JLGXKMMgX0folu0rVHrq3bqhu8/WSaR1qBkSv5jP7QJ18O
	9k82+emGWl57vJGhckbKqtU87D2h7i/uMzlxCZzBphCjXN4H21qp/N9r5WbN3dn1e7kHzAswgG8
	MDh7M=
X-Received: by 2002:a05:6820:3287:b0:709:529a:477c with SMTP id 006d021491bc7-70b88ac1066mr386352eaf.87.1792703908193;
        Thu, 22 Oct 2026 14:18:28 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84fbd362c1fsm250873a34.4.2026.10.22.14.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 14:18:27 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 22 Oct 2026 15:18:26 -0600
Subject: [PATCH] dmaengine: mediatek: uart: make channel termination atomic
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
Message-Id: <20261022-submit-mtk-uart-dma-terminate-atomic-v1-v1-1-aa498ba5da25@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNwQqDMBBEf0Vy7lITS8D+SulhE7e6LYklWUUQ/
 71JPb5h5s2uMiWmrO7NrhKtnHmOBfSlUX7COBLwUFiZ1ljdGgN5cYEFgnxgwSQwBAShFDiiEKD
 MgT2sGnRv+66zFunmVbF9E714+z89nicX1Zu8VH1tOMwELmH0U42KmOLIka7n7jh+D1/b660AA
 AA=
X-Change-ID: 20261022-submit-mtk-uart-dma-terminate-atomic-v1-19693366ae4c
To: Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The 8250 transmit flush path calls dmaengine_terminate_async() with the
UART port spinlock held and interrupts disabled. UART APDMA termination
uses sleeping register polls and synchronize_irq(), which can also wait for
a threaded handler or for an interrupt pending on the calling CPU.

Serialize the stop sequence with the interrupt handler using the virtual
channel lock and use atomic register polling. A handler that was waiting
for that lock must check interrupt status before accessing a descriptor:
termination may already have masked and acknowledged its interrupt. This
allows termination to retire descriptors without waiting for the handler.

If the channel does not stop, return the timeout and retain its descriptors
instead of freeing state still owned by the transfer. Continue attempting
STOP after a flush timeout, since stopping the channel is sufficient for
termination even when the flush could not finish.

Fixes: 9135408c3ace ("dmaengine: mediatek: Add MediaTek UART APDMA support")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/mediatek/mtk-uart-apdma.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
index f74e9a328588..73d4b701ac85 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -256,6 +256,12 @@ static irqreturn_t mtk_uart_apdma_irq_handler(int irq, void *dev_id)
 	unsigned long flags;
 
 	spin_lock_irqsave(&c->vc.lock, flags);
+	/* Termination may have acknowledged an interrupt before we got the lock. */
+	if (!mtk_uart_apdma_read(c, VFF_INT_FLAG)) {
+		spin_unlock_irqrestore(&c->vc.lock, flags);
+		return IRQ_NONE;
+	}
+
 	if (c->dir == DMA_DEV_TO_MEM)
 		mtk_uart_apdma_rx_handler(c);
 	else if (c->dir == DMA_MEM_TO_DEV)
@@ -400,10 +406,12 @@ static int mtk_uart_apdma_terminate_all(struct dma_chan *chan)
 	LIST_HEAD(head);
 	int ret;
 
+	spin_lock_irqsave(&c->vc.lock, flags);
+
 	mtk_uart_apdma_write(c, VFF_FLUSH, VFF_FLUSH_B);
 
-	ret = readx_poll_timeout(readl, c->base + VFF_FLUSH,
-			  status, status != VFF_FLUSH_B, 10, 100);
+	ret = readx_poll_timeout_atomic(readl, c->base + VFF_FLUSH,
+					status, status != VFF_FLUSH_B, 10, 100);
 	if (ret)
 		dev_err(c->vc.chan.device->dev, "flush: fail, status=0x%x\n",
 			mtk_uart_apdma_read(c, VFF_DEBUG_STATUS));
@@ -415,11 +423,14 @@ static int mtk_uart_apdma_terminate_all(struct dma_chan *chan)
 	 * 3. set stop as 0
 	 */
 	mtk_uart_apdma_write(c, VFF_STOP, VFF_STOP_B);
-	ret = readx_poll_timeout(readl, c->base + VFF_EN,
-			  status, !status, 10, 100);
-	if (ret)
+	ret = readx_poll_timeout_atomic(readl, c->base + VFF_EN,
+					status, !status, 10, 100);
+	if (ret) {
 		dev_err(c->vc.chan.device->dev, "stop: fail, status=0x%x\n",
 			mtk_uart_apdma_read(c, VFF_DEBUG_STATUS));
+		spin_unlock_irqrestore(&c->vc.lock, flags);
+		return ret;
+	}
 
 	mtk_uart_apdma_write(c, VFF_STOP, VFF_STOP_CLR_B);
 	mtk_uart_apdma_write(c, VFF_INT_EN, VFF_INT_EN_CLR_B);
@@ -429,9 +440,6 @@ static int mtk_uart_apdma_terminate_all(struct dma_chan *chan)
 	else if (c->dir == DMA_MEM_TO_DEV)
 		mtk_uart_apdma_write(c, VFF_INT_FLAG, VFF_TX_INT_CLR_B);
 
-	synchronize_irq(c->irq);
-
-	spin_lock_irqsave(&c->vc.lock, flags);
 	vchan_get_all_descriptors(&c->vc, &head);
 	spin_unlock_irqrestore(&c->vc.lock, flags);
 

---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20261022-submit-mtk-uart-dma-terminate-atomic-v1-19693366ae4c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

