Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7F247F77F
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787310016; cv=none; b=WalSZ9o8JXDZcgAixyHkKz33frlDy9SKe7IxxsiyCmyqBYOHOnpeYMITvWvQSwfd1mCXjk3Pg9tkXEt1kztNlcren6kwWDH6OCUoRAoAkuQeWUxdBl78H082SZwZC27QGAxwkwLbYUuHSsBSG/5qgl8kvdH6n6HdwKQYbaiKIA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787310016; c=relaxed/simple;
	bh=i6u7nGtwKbXisB7jB2NFMPJCWpuEMivpoD5vbT2YV88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqSX7V2Vla2p+auRxmrPc/syNgCOsWrMVWg6yKiewVnNw2+i29UwB6Z9fCHg3MXJHwWqmJZ8Y9Y9RIkowVUHnrztv4HlI3hIgrPilr9BjBTi66uebyhY3dw9JgHaP21FKDrgaa0DuoOzfSFY7YYPQNlsJ9El8zM+XE6K5VGSOS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhZrPFnG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhZrPFnG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12D21F00A3F;
	Fri, 21 Aug 2026 11:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787310013;
	bh=mmR7SQKaCHL9LO4vmfdpAn++SNhFHunf0Xhw5x7xvCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mhZrPFnGPficUMKMgjCLbdsLSIQfSryHdvEYfDwk5hF5vdFBfgUZ8X25K1dS3crlf
	 hnadRXZNDtBmX3fc55vllTVBzn3s+xjAG60gJPJYTrFYtyZ8GoKBIkINPZ39eekoLp
	 JRqV/Av/ljYEmPaBhQD6pBjhJwB1qlufYZHDmXHuNDnFuZ0yEl3cnam30PLWFcvKSX
	 2wM9xvs7dIjnU2EMOMyCikDqSnsZvS7E19av1RAaO7sx61GTywbWHw5FIvUhFHn/pm
	 Wxd354RZEFJ4jgYGW48Ru+An7l9c94td3/cBDGeSAKsBFS/7Gdqrvy7bw6PWOQAcWa
	 lfxT4SUn+c+3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] serial: amba-pl011: synchronize DMA teardown
Date: Fri, 21 Aug 2026 07:00:11 -0400
Message-ID: <20260821110011.2816711-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081746-unbridle-client-7ffc@gregkh>
References: <2026081746-unbridle-client-7ffc@gregkh>
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
index c881d4413b899..82d5b49194099 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1198,7 +1198,7 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 
 	if (uap->using_tx_dma) {
 		/* In theory, this should already be done by pl011_dma_flush_buffer */
-		dmaengine_terminate_all(uap->dmatx.chan);
+		dmaengine_terminate_sync(uap->dmatx.chan);
 		if (uap->dmatx.queued) {
 			dma_unmap_single(uap->dmatx.chan->device->dev,
 					 uap->dmatx.dma, uap->dmatx.len,
@@ -1211,12 +1211,12 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
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

