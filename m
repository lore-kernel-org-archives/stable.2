Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E65A39F165
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787254542; cv=none; b=LKuYCBCMKU10rwH8YYFMwCnJwXFAP7phSJQqz9V5/Y2e3dLnmprKP9H/iWo4LlUpyIU8u7SsLypBTVsmxW9/8oTef2kPa+/w+C+0/xAcH+UNt/pfjBRTB5WZSMuYikL2W0shzp/tubItNZoWCLnc2u3nuUwcD/FVeWR54OPX5Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787254542; c=relaxed/simple;
	bh=PBZI1CGt1j3aTefLzoyJYI/2EAo0XVXJmkp9nhuk4Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AsrWJUn6fd8P40BbKVcVQ0FDwNGgJsL+VfHU5LiSN3auFrCPW4Fr72NFfUHdPY9ZuANi0pOgFesT5Ljmfm9tsnHT4o+nPek3Ed3MErtGTGMthfQlP3fv3k3ARNqJncLnYwiR6qPFjTZbrqq0wPzSOwoOBywYWdVo4Uqys1wwnrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2r+e04x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2r+e04x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9606F1F000E9;
	Thu, 20 Aug 2026 19:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787254540;
	bh=EGkuq2Mh4ir7eXmJjKJAm5IPsA/E4QIUTMsS9VfoL6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B2r+e04xpMElC0O9PZuXBMmoivqDmBzL1do5Rx1S5psgjczN0pjBJpXk5AaAa7ML9
	 zTCscIF1Ao7DWvfHaUJeu3jiA5TqmuOepx1P/k6Bvr9e8NDOrM9xOrue8+3TqhcvqE
	 xDlH8/SgFjhgHyRlw0xN0TIwumQCQN0OJU8ZU9Qn7xsk2lsO8iZ1gJ1GaONVDY900/
	 TXu6sa9pMpYQqnPWIqUfeYKMQwjSl3yEdjG1qgFFKgaEXVBl1+9OamKrPCjQrjbAhe
	 CgeiTYWspVFdEpepK+pdPCEDiwVjrwNgmrh0XlgorKC1FYhTzXqQMP0DgbdYkOte1K
	 BxS/sD3vfiTJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] serial: amba-pl011: synchronize DMA teardown
Date: Thu, 20 Aug 2026 15:35:37 -0400
Message-ID: <20260820193537.2273472-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081744-cosponsor-neon-92d7@gregkh>
References: <2026081744-cosponsor-neon-92d7@gregkh>
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
index 3713b23536dcc..8934fbdb0cf98 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1171,7 +1171,7 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 
 	if (uap->using_tx_dma) {
 		/* In theory, this should already be done by pl011_dma_flush_buffer */
-		dmaengine_terminate_all(uap->dmatx.chan);
+		dmaengine_terminate_sync(uap->dmatx.chan);
 		if (uap->dmatx.queued) {
 			dma_unmap_single(uap->dmatx.chan->device->dev,
 					 uap->dmatx.dma, uap->dmatx.len,
@@ -1184,12 +1184,12 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
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

