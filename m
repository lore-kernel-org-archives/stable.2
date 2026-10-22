Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792703435;
	b=TVyQOaOGCxK81nKeBCAaiV0/Xr8MkodZTcM79B1XQ2I5GIZKjXRh08K5UWpmMIwnVPHZ
	 YZ/b2iccyfYuM7b5uMzvKyEIv5sr449eP+bJV9B34JL1FelpluzJKnh4a9EeppAyZ1YEu
	 kC2y4UqM57+9yVSA47gH1O+6IgW5P+/9I22ffTRqKHwJh2u78AXqrFm3BQNQZJSTAL77f
	 Z7y9GDmGb5+DO7sxoPaPtwLrQdON7YUaDAboU2+0kWZkpwmncw8GLDW3n+RaGGGSnj+l5
	 A+62fwpb61lHNE5yrpPDbarxFcDkRmCJ1tbUUk+px2D7QX8lSLYZTb/m/4eZtbytVKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703435;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=H3wupAdvnZmi5Elr/RGQvnNTlqyhdieccmQn0WGSNEA=;
	b=uCDda/tEf/unqRA886CmjRJoZi1baDkY+8oTYJ4MZklV+HiCuS35psb9BGEobs2jiKLK
	 t2gCl4yhFqUW6jVkQyEZF9Njj55x/4I++hTiEWwo2CGF3XDYT/wyN4jsyyb/DY7w7OWlk
	 MbI0lEWMkhWrrk9TBaHZbue8MmVCDFwwuvk59a7B+xIiCzojId5m7fuKlhHKywdtAei4S
	 NggfFf81BkTGXLFZyFtok/BzNAALbR9Ke0Wi15XHdQn58AgLF7Cq2p2T4ug2nZV7G7OLd
	 qjWgsuLTaO7QqWqbsLdzGUndKeTBxaB0d7ikc+4Az+xgucEwplLAwSskzuO+VoXH5sA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h+eDMeOM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549F3606A321;
	Thu, 22 Oct 2026 21:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h+eDMeOM
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792703435;
	b=mcw9uEMxy1frr+eiI0Sm+AmCE9dRZoBZAYWzC8eOTJxSO/jiqtuGc7J8q5RsQctFI/So
	 VCXeJVo4Rrf+Z1NAskqW0CW9CL+ahVK7WafYn4vv8yQKWbDJl8vd1cVIBkXcY4QyIqYjI
	 tDY8pwXQNbwTPHDdshQA3KYTm+4XYyJKGXHY9ToE4vlN0waWs7xWyv5MgH9JzwfWMFI2Z
	 t8BBO5x/C0vLqINOUV81A3PoSo93JrGC0uVzxZXeKU63iKplthQkyuxVTi4G5Ql8hNHst
	 XD3CSNmpI8BE0zsSL91Jm1EJiQb+nHZbFFH+drbhw+6RtPQoaVwuYQJd8FTmaLSoUyQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792703435;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=H3wupAdvnZmi5Elr/RGQvnNTlqyhdieccmQn0WGSNEA=;
	b=BKBkBsyaPJUwLHZ7cfw3KZtPBwyUFcOFMkGqJlEy0aplxyrhrdnNBTIXKkE38GQTi7rz
	 x+DOkQDwLpS5g4rqw3gwWOuFXuaAhhrqSKrWPPz+8xyKGH1kHa9maWxwuoq97LwoQL6F3
	 77qHLmPd48WPZVAO8qbzL0pxl8baL0/Mk6LWESSP9Aox8E9Ctf6TG8s76jJ02B3VJ9xZX
	 +aA0AY1r4fRbGD0VgXwrM+QKh6Y7139IHBRhyGpq+pAGhx3DP+b3f6WT08H4R7Xgnjfa6
	 0n4m1O8JrK1iC67tf6fmnjJqTnk6e90AsoG3AhTQe2p0m7cbell3+TzBTdvVUgMNVOA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BCD461F01828;
	Thu, 22 Oct 2026 21:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792703435;
	bh=H3wupAdvnZmi5Elr/RGQvnNTlqyhdieccmQn0WGSNEA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=h+eDMeOMqq86vGopV2Lg2GPMJajdcz+71EqgK49btHFpqbQgXSiO1PLmEcy4K6Q3C
	 6t8KMOKRkvfYLHxQTpdCmH5EEoEgr8AinJYCBS0eOjKUd+4wffSby0VODvthnBJo6N
	 WYbq9cFf4Vgb3vN31MYmJ7ME00ceFD9zB6cM3QSlJPwO6F+5F06JmWDOMxKnjUpg2W
	 l185lMb8YBGVjIHOMkfgTjJWWC0y2bOT4BrjAfi4IMSYwb6ON55Zq/KKQi98xUlsNC
	 +etMF95CoywYy5/Lain+S4yJxgFdyY6n0jneUByHYTdxquaC7/pwgyBXUN8diUiIE1
	 gcL7hSS9hUX1Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2D22541F51;
	Thu, 22 Oct 2026 21:10:33 +0000 (UTC)
From: Austin Schlegel via B4 Relay <devnull+schlegelas.outlook.com@kernel.org>
Date: Thu, 22 Oct 2026 17:10:25 -0400
Subject: [PATCH v3 2/3] serial: tegra: fix TX DMA descriptor use-after-free
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
Message-Id: <20261022-serial-tegra-dma-uaf-v3-2-129f6d67f673@outlook.com>
References: <20261022-serial-tegra-dma-uaf-v3-0-129f6d67f673@outlook.com>
In-Reply-To: <20261022-serial-tegra-dma-uaf-v3-0-129f6d67f673@outlook.com>
To: Laxman Dewangan <ldewangan@nvidia.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Alan Cox <alan@linux.intel.com>, 
 Stephen Warren <swarren@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Austin Schlegel <austin.schlegel@arthrex.com>, 
 Austin Schlegel <schlegelas@outlook.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792703432; l=3749;
 i=schlegelas@outlook.com; s=20261001; h=from:subject:message-id;
 bh=E1KIGpMCN0NqKhQC503EJ//NG4Rqh9bWOmc0ND6MkLQ=;
 b=8FBZr+mxrPqSGlbtRQAqZjOOVYVmx2tgifR6ngSG685uH8QOsh+zjLPOTbXUDlfWxzHCr9c0V
 HC9FZNVDe1dB2vCNN5N0ehbMMe2qlKLMuIrXIWN0H/WrBD2XXTo5Ny7
X-Developer-Key: i=schlegelas@outlook.com; a=ed25519;
 pk=ddgmH7VQaSWderjJFy4hDyq+P7hdHupPxQvwnGRBzCs=
X-Endpoint-Received: by B4 Relay for schlegelas@outlook.com/20261001 with
 auth_id=1098
X-Original-From: Austin Schlegel <schlegelas@outlook.com>
Reply-To: schlegelas@outlook.com
Content-Transfer-Encoding: 7bit

From: Austin Schlegel <schlegelas@outlook.com>

tegra_uart_stop_tx() calls dmaengine_terminate_all() and then
async_tx_ack(tup->tx_dma_desc) on the descriptor that was just
terminated. With the GPC DMA driver, dmaengine_terminate_all() frees
the active descriptor immediately, so the ack call that follows
touches freed memory.

This is the same use-after-free pattern fixed for the RX path in
tegra_uart_terminate_rx_dma() ("serial: tegra: fix RX DMA descriptor
use-after-free"). dmaengine clients must not touch a descriptor once
dmaengine_terminate_all() has returned.

Move the ack before dmaengine_terminate_all(), while the descriptor
is still valid.

tegra_uart_flush_buffer() reaches the same freed descriptor by another
route. It terminates the TX channel but leaves tx_in_progress set to
TEGRA_UART_TX_DMA, so a later tegra_uart_stop_tx() still sees a DMA
transfer in flight and acks the descriptor that
dmaengine_terminate_all() freed. Ack the descriptor before terminating
there too, and clear tx_in_progress so that nothing touches it
afterwards. Only clear it for a DMA transfer: a PIO transfer still has
the THRI interrupt enabled and is finished by the ISR.

Acking before terminating keeps descriptors reusable on APB DMA, which
only recycles a descriptor once it has been acked.

Found by code inspection while fixing the analogous RX bug and through
Sashiko automated review (see Link below); not reproduced on hardware,
since triggering it requires stopping or flushing an in-flight TX DMA
transfer at the right moment.

The ordering has been wrong since the driver was added; it became a
use-after-free once serial-tegra could use the GPC DMA driver,
which frees descriptors on terminate.

Fixes: e9ea096dd225 ("serial: tegra: add serial driver")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/sashiko-outbox-172211@kernel.org/
Assisted-by: LLM
Signed-off-by: Austin Schlegel <schlegelas@outlook.com>
---
v3:
 - Also fix tegra_uart_flush_buffer(), which terminated the TX channel
   without clearing tx_in_progress, so a later tegra_uart_stop_tx()
   acked the freed descriptor (reported by Sashiko review of v2
   https://lore.kernel.org/all/sashiko-outbox-172211@kernel.org/).
 - The tegra_uart_tx_dma_complete() race reported in the same review
   is fixed separately in new patch 3/3.

v2:
 - Reworded commit: Removed inaccurate flush example
 - Switched to personal email (v1 sent from austin.schlegel@arthrex.com)

v1: https://lore.kernel.org/all/20261001-tty-linus-v1-2-ecb8576c802d@arthrex.com/
---
 drivers/tty/serial/serial-tegra.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index a23a92cebe0d..c179a09b8fe2 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -639,9 +639,9 @@ static void tegra_uart_stop_tx(struct uart_port *u)
 
 	dmaengine_pause(tup->tx_dma_chan);
 	dmaengine_tx_status(tup->tx_dma_chan, tup->tx_cookie, &state);
+	async_tx_ack(tup->tx_dma_desc);
 	dmaengine_terminate_all(tup->tx_dma_chan);
 	count = tup->tx_bytes_requested - state.residue;
-	async_tx_ack(tup->tx_dma_desc);
 	uart_xmit_advance(&tup->uport, count);
 	tup->tx_in_progress = 0;
 }
@@ -1275,8 +1275,14 @@ static void tegra_uart_flush_buffer(struct uart_port *u)
 	struct tegra_uart_port *tup = to_tegra_uport(u);
 
 	tup->tx_bytes = 0;
-	if (tup->tx_dma_chan)
+	if (tup->tx_dma_chan) {
+		if (tup->tx_in_progress == TEGRA_UART_TX_DMA) {
+			async_tx_ack(tup->tx_dma_desc);
+			tup->tx_in_progress = 0;
+		}
+
 		dmaengine_terminate_all(tup->tx_dma_chan);
+	}
 }
 
 static void tegra_uart_shutdown(struct uart_port *u)

-- 
2.53.0


