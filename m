Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933543;
	b=TWp3NzUozlXM2WwCI0W4uYwUKOyxCnZUFSh1DCvc7AXI2KxzE5nC2fQrIfeVgtUlnbB7
	 iZkcX3l0uoI5ULIfT7DCN7UEpX9caIWUw0YznLK5wNUWmCgExJTGej3lbbuEMZ/cz8g1R
	 5vo2kV8twzprXqpysSkJfuONPCl3toVp7anaP1HFIh4EYqF7s8dqIgo0UFcBmO2yOnN2W
	 VQDGyCNJJxirOs2j9u0pkhWffN5PfB4T4IcN0yFLe9DpupWVyNy/GON3aHBcnRYK5dNSs
	 t//kyO4UA9Oyw3fX4Zs75Cq7ccRCEH+y+aNItYiIvKnoSPU6y1w423mYpDQFNxs4V3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933543;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Pfmnvxj9CbfQ1DpBEMDbGnnfXt+Q39t2/T0T0Pu6Ftc=;
	b=n6WIeqigNJo1At9W+QKjNyctwD+icPNGPHGjlaVKheAyZs6s60I8RPqM13mK2gc5jwZS
	 UGm6MBzTgrYACAdIDSEUtjQ3vkXoYi4UIZTQimFaYQddDd7S2S9zdPXC7G9OVxUPqJyoY
	 XKpmf8Nc6lYrz1GUvpkZj07IwnWQij6UunpQfTzjpdbOEEhGHcTydZQ2TuGcHQbxFpM9J
	 Vhu1kTdhzgSqm272MiZwXfLlphiNokazuqOHB+ZS7IolQPQZWJtbUyX2X/57pQAecTQ5d
	 gL0CyUj7hU9Xho7kEZUZkJKS1XRzmCNjuypeo9VKJfPhLh7OZhULy6eLjN4jOOUWcqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cMuQJ9FK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85E6606A330;
	Tue, 17 Nov 2026 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cMuQJ9FK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5151F000C4;
	Tue, 17 Nov 2026 16:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794933543;
	bh=Pfmnvxj9CbfQ1DpBEMDbGnnfXt+Q39t2/T0T0Pu6Ftc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cMuQJ9FK1PHznyu4NZPRUAJ4VOHdcaqMcn2LHbIAcspA0Jn+nJyNCZ0gTsLKwf8jX
	 4ll6OimP/Cx450xqbmlmw7SiXpEyRzzU2PZ/oUjKybiqRG/GzjIVOWX4r328I0lEOk
	 tUoTDGkaFL3kjuJrpi/tyANJvtivxjA0ySxUP4g2SC9vG/M5CoPLn10OzYdXhByYKW
	 taU8JTxpwGudZGRLlmTZP3fzgJHi1V3251d9OwSztxyJL38KXbbJtZCQnkr+QRjLID
	 YFqoP5jhB7iASLudc4UgwxZMTdnjPwHCvXTlVMy7BrlUUidZbkvPDBgP1kD3PzUZbH
	 PSWlDY739hPow==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linux-amlogic@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 06/11] dmaengine: amlogic: Destroy free_wq after devres DMA device unregistration
Date: Tue, 17 Nov 2026 16:37:07 +0000
Message-ID: <20261117163809.622249-7-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
In-Reply-To: <20261117163809.622249-1-lee@kernel.org>
References: <20261117163809.622249-1-lee@kernel.org>
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

aml_dma_probe() registers the DMA device with
dmaenginem_async_device_register(), so dma_async_device_unregister() is
deferred until devres release after aml_dma_remove() returns.  However,
aml_dma_remove() destroys aml_dma->free_wq directly, causing
aml_dma_free_desc() to queue work onto a destroyed workqueue when
channels and descriptors are released during devres teardown, and early
error returns in aml_dma_probe() also leak aml_dma->free_wq.

Allocate aml_dma->free_wq with devm_alloc_ordered_workqueue() so it is
destroyed on probe failure and after dmaenginem_async_device_register()
unwinds on removal.

Fixes: b84b5197e344 ("dmaengine: amlogic: Add general DMA driver for A9")
Closes: https://sashiko.dev/#/bug/linux-c216084a-f89a-48d5-bdea-584522d1bdda
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2: No changes

 drivers/dma/amlogic-dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/amlogic-dma.c b/drivers/dma/amlogic-dma.c
index 684121d13fca..791bd82743d3 100644
--- a/drivers/dma/amlogic-dma.c
+++ b/drivers/dma/amlogic-dma.c
@@ -620,7 +620,7 @@ static int aml_dma_probe(struct platform_device *pdev)
 	if (!aml_dma)
 		return -ENOMEM;
 
-	aml_dma->free_wq = alloc_ordered_workqueue("aml_dma_free", 0);
+	aml_dma->free_wq = devm_alloc_ordered_workqueue(&pdev->dev, "aml_dma_free", 0);
 	if (!aml_dma->free_wq)
 		return -ENOMEM;
 
@@ -712,7 +712,6 @@ static void aml_dma_remove(struct platform_device *pdev)
 		if (aml_chan)
 			tasklet_kill(&aml_chan->vchan.task);
 	}
-	destroy_workqueue(aml_dma->free_wq);
 }
 
 static const struct of_device_id aml_dma_ids[] = {
-- 
2.56.0.679.gc527c65306-goog

