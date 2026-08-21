Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD91A25CC57
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 03:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787284774; cv=none; b=c13GY6x/XKx+yGvdKG1s1STP6NQG0PV94MSBiNMnRb/86yyorI7WfmRWwsajIPyA4IUSqar6t7DpUJz6VwXbOuDb73+CFu9CBhYHyhf2RGMzQrEQYTWLE2zO6pIWelbTCESa6Pr8zH8rEnGL6WbQKC62RyO039HBt0vXr2BIJFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787284774; c=relaxed/simple;
	bh=LuyoSJJhxpOSmlnTDGFRo/bAJrzaZ9DEs/PB9oAVTPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pl29wD0wtU3tDG9pVaA571ENaT3dl1gnpqZ3kKyZeSbAGErpk7UCR6TnWmzcOLMSPP/oWqGya5vveYTxA7bzizwETnd7PDWaRUE0SetzO339yazrEc56ZUL5z6UGXMA932LaVdK2AI0x2eaTye/CXdDCB/SerAuxFKn0ofviYNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgFPRveq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgFPRveq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABED1F00A3A;
	Fri, 21 Aug 2026 03:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787284772;
	bh=dBF7xGOR3NOX3yRUzKCgrWcNFquSQkKDWwtP/Tsw0yM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MgFPRveq+AKY1A0F5MwNFlM7ZRq6q38A5DU8ahZz7ihsEcOeWi7Cqk28H9O0gKX6D
	 1I4uAw9dsHJNRfQYQggtVYJ/sGMzir0SXffhva80eKevZZ4YVU+b9ckztmoNHpmfHX
	 Y1Fq9jsrFHriD+HFG4IGMyk7YZi2QOIum9TvYJAr46SRDaJH/cRkdrNym71zIqUirq
	 gRp0NWbWq+Xw8dUpX7CvwOMX6GlsSOKTCHEx5V7ECI8LarGL70VkQ7igj6UhUGoPN1
	 LsPLG342ch6h4fME5/ZanxxtRzUwZVqypXG8QhcFmg7coraVH92mq1KIrBJaVOPpJe
	 A6eKI3fbH+eqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] serial: amba-pl011: synchronize DMA teardown
Date: Thu, 20 Aug 2026 23:59:30 -0400
Message-ID: <20260821035930.2525265-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081745-polygraph-envy-e793@gregkh>
References: <2026081745-polygraph-envy-e793@gregkh>
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
index bb7f82f8278d0..c0299c7ef1c18 100644
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

