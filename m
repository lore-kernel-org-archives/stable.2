Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F07635E93E
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 22:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787264888; cv=none; b=PeSO7G3YjvrdDXwAlGEx2GxNVMWTU4/PePXioS4/n2iIVeXgLk54QOOW0loExqMnPu2dTCXmqtaWrawYTZWQW/zQU0PwPRbsqz5QpbMWxdTQZoNYieGZwP1viykhgklou8x22PRzDG7UoEfTrV5dXD3c8PawgPxjs4vghpxyJJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787264888; c=relaxed/simple;
	bh=jdrUhopOtU9DMNIwyfVrGZf84sc2cb76BndvbQKB8k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0u0dtCCHP3m57Yoi76vdL6YWlW9kuD/xMEUNqRotLpOXQFRoQhYp+6hCrzKbGiIwEoXm/ZMkdWLg8kfVR2mjfQnu7KdthF3e2Y9I/gxMlBaT+7Mqt73NDWpboMouE/2UKhkuZDuiTuqylbhzxYjC7T9J28KH6TJOpzK3OHtm/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShB3VRme; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShB3VRme"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE20D1F000E9;
	Thu, 20 Aug 2026 22:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787264886;
	bh=yo1fcS51/xSsiBn8qndUk6wS/WFZECkFL70EjJh+2Hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ShB3VRmenLN7Xm2TM7zyokbd9z/s2SNx1c7nt/xEckzVouhNYAW7WQfIs8doftNs9
	 Oigab9BnYaO+wJFvy+RdDyuh0uJn39I00S/kyR1ioT5Ry6ukP8FvutNi59Xw9ufukW
	 zMj+Y+wTTlLnWP+V4D7Jsu0LUGi7umZgCyeX6rNonu8G9QuRA3TJ0844mGdnz8r9nc
	 aLDwNvAiVmrd3LquiBDYfOx7X/2Ohj29TJct27CetZt/wO0AMcIU4qlcrvY7kJWfcj
	 ezDWtuwPY3Tj5+EXyA+HR6T0I0TnYDCFHrVXpIN6gRdVvM5t7W4gABYubwfkMpIVae
	 8lX3PPwPQVFYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] serial: amba-pl011: synchronize DMA teardown
Date: Thu, 20 Aug 2026 18:28:04 -0400
Message-ID: <20260820222804.2320219-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081745-cufflink-twiddle-15f3@gregkh>
References: <2026081745-cufflink-twiddle-15f3@gregkh>
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
index 8aa71a51cdabb..4c107556ae315 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1193,7 +1193,7 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 
 	if (uap->using_tx_dma) {
 		/* In theory, this should already be done by pl011_dma_flush_buffer */
-		dmaengine_terminate_all(uap->dmatx.chan);
+		dmaengine_terminate_sync(uap->dmatx.chan);
 		if (uap->dmatx.queued) {
 			dma_unmap_single(uap->dmatx.chan->device->dev,
 					 uap->dmatx.dma, uap->dmatx.len,
@@ -1206,12 +1206,12 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
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

