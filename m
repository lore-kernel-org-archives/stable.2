Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11F23C343C
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787310410; cv=none; b=bKeta/QNr5vmLahyrG5bXyNOxB3sTewVCYDCZ1GKqUBEeRxJjInfZVOFSyxXSAKpV/cuHTTNH7U//xgoRpffAgZhUpwaSSrmbwVs77GqhMuGeP2y5HoiVUdTcjGfI7DKxsqRoowMznnvm7QUbnj0ucZiGDxWJwHJ9fotIR4O7FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787310410; c=relaxed/simple;
	bh=MySHS/kDWV3jUAPesfFVI5cIQ7RrHiIzWBsw4ihVSuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJ5YalBa4jtRxUlTgFCk8Vq5PLl8khyh1qL+vLn4BdiwNcjhtrCCEBZk7Lgf2ZU4CiMgWKfGn4vZrOrZFQuD3seXr1xxYsp9dPtbjnKBubaOUymGt2aQR11iO7pu1bDHRGRvt556n0TYa7YxmakNXRKhWuWQSba0DEPHy/BSXMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOx9p8f+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOx9p8f+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3F01F000E9;
	Fri, 21 Aug 2026 11:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787310408;
	bh=4ScHzvHLXl57ZU+Hbogf8cR4KWoixxA5+QhdOPpcW5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mOx9p8f+DUrod3le4QjUH5PMooHbC8RQtJjCJx5PpJ9UdQpouAtQB5F04ZSCedL7n
	 yu8Qnj4y0FRwQs+2qNzouif3omyOJx2iceYQ2C6Zl/jfyUdUnO6RWzTHuZPplJYqzZ
	 q5hV7JB6Sn9nvJP0aU6KXwl5Kz1pka6Sug21MZ7q2DGx1gdKievr2jRwqPr7BTNFv1
	 9ERoc8r6Lm1wj2YbudRIjdE1kpEH4kG769gBeLdpOl1Sw3bVjnd9FFB6COzARslJCF
	 ER7T3DdmnlFWHRY0DdCiim6WRZ8O+APOaSXu1JK23I+Pk+DJyjwbj6RgC9NYHY09H5
	 /3EoKTlKLMgAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] serial: amba-pl011: synchronize DMA teardown
Date: Fri, 21 Aug 2026 07:06:45 -0400
Message-ID: <20260821110645.2848076-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081746-trump-freeness-2c22@gregkh>
References: <2026081746-trump-freeness-2c22@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit 440915499231e9db1c361aa45bb702e8fd3b4a32 ]

dmaengine_terminate_all() does not wait for a running callback, so the TX
callback can still touch the TX buffer after it is freed. The RX poll
timer reads the RX buffers without the port lock.

Switch to dmaengine_terminate_sync() and delete the RX timer before
freeing the buffers.

Fixes: ead76f329f77 ("ARM: 6763/1: pl011: add optional RX DMA to PL011 v2")
Cc: stable <stable@kernel.org>
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Link: https://patch.msgid.link/20260731085915.326775-4-fanwu01@zju.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ changed upstream's `timer_delete_sync()` deletion to match this tree's `del_timer_sync()` spelling at the old call site ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/amba-pl011.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index ab68892a8b1c7..500f46bb06c85 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1196,7 +1196,7 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 
 	if (uap->using_tx_dma) {
 		/* In theory, this should already be done by pl011_dma_flush_buffer */
-		dmaengine_terminate_all(uap->dmatx.chan);
+		dmaengine_terminate_sync(uap->dmatx.chan);
 		if (uap->dmatx.queued) {
 			dma_unmap_single(uap->dmatx.chan->device->dev,
 					 uap->dmatx.dma, uap->dmatx.len,
@@ -1209,12 +1209,12 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 	}
 
 	if (uap->using_rx_dma) {
-		dmaengine_terminate_all(uap->dmarx.chan);
+		if (uap->dmarx.poll_rate)
+			timer_delete_sync(&uap->dmarx.timer);
+		dmaengine_terminate_sync(uap->dmarx.chan);
 		/* Clean up the RX DMA */
 		pl011_dmabuf_free(uap->dmarx.chan, &uap->dmarx.dbuf_a, DMA_FROM_DEVICE);
 		pl011_dmabuf_free(uap->dmarx.chan, &uap->dmarx.dbuf_b, DMA_FROM_DEVICE);
-		if (uap->dmarx.poll_rate)
-			del_timer_sync(&uap->dmarx.timer);
 		uap->using_rx_dma = false;
 	}
 }
-- 
2.53.0

