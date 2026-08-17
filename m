Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E8121D3F5
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786969573; cv=none; b=Sa9sijW3O82Uuzwqb65mHpkKn1F2457K2tUSV9PQuqASMptPZ5o8NLr+r9Y0ttApt8tcHwLiYjQZqS0MFbS5Teynw+f/evtIW5ZTXLLKvzalct9Wz1FlcTFiIJCfAqBklpMrCe68B/S1qIASsUcMbIJ0dhdWsVAHtS2k7h9rqI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786969573; c=relaxed/simple;
	bh=4sZPPiJGi6g76ykjyRBID9+3SI22MJYOyqR5dnSKsJU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rxDhEl/Put0M870LReXUH50d1Eg/gfxZVn34vVNUPUwTt/VLnpLjvy8f0mBl3wFINJbgr6rdQmBuCOReTtw833EOk8vUynjgfFsXT77n98YGZ+hy7Dnm7IxFMYR6z65aydRL1ijx6wW/zLkAUFCefixOvwGdgqP4QLXfU94vJKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g1S13+Ll; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g1S13+Ll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86C51F000E9;
	Mon, 17 Aug 2026 12:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786969571;
	bh=NiHLZ7K54SRx002jz3fcDCMhxHaeY52WbYgspANTpGM=;
	h=Subject:To:Cc:From:Date;
	b=g1S13+Llp80yKTibTDAVc7jkS9QgLV3bY+civuA9cOVE71jk1jVLr1t614xwlF1de
	 qJh37L1mHGWKWW6FF/R6Y5FaT7hN5HpPExSYAuQjP8yBNZFxwEZnpQ7DANL0bzQ+KF
	 jDadXtDeRCXtljzEv0DFv1khUTydJKPAd4PWcybo=
Subject: FAILED: patch "[PATCH] serial: amba-pl011: synchronize DMA teardown" failed to apply to 6.1-stable tree
To: fanwu01@zju.edu.cn,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:25:46 +0200
Message-ID: <2026081745-polygraph-envy-e793@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 440915499231e9db1c361aa45bb702e8fd3b4a32
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081745-polygraph-envy-e793@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 440915499231e9db1c361aa45bb702e8fd3b4a32 Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Fri, 31 Jul 2026 08:59:15 +0000
Subject: [PATCH] serial: amba-pl011: synchronize DMA teardown

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

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 5232042fdd92..9abaeecd05fc 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1247,7 +1247,7 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 
 	if (uap->using_tx_dma) {
 		/* In theory, this should already be done by pl011_dma_flush_buffer */
-		dmaengine_terminate_all(uap->dmatx.chan);
+		dmaengine_terminate_sync(uap->dmatx.chan);
 		if (uap->dmatx.queued) {
 			dma_unmap_single(uap->dmatx.chan->device->dev,
 					 uap->dmatx.dma, uap->dmatx.len,
@@ -1260,12 +1260,12 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
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
-			timer_delete_sync(&uap->dmarx.timer);
 		uap->using_rx_dma = false;
 	}
 }

