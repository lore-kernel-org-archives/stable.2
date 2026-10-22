Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792703435;
	b=W+iHr033l5daU/Rh5KIpC5Z/L0haVsmbp7UNHwAZBDi4LOJHoT9eKCr2XExOi9yTR9hz
	 OJ3CVJ5mPMNLQcUifkDmo8MazllOwK4ezzqgSAlOR4NS8QUzLC+VFNo7SLtqXyXXsxbyX
	 H0CLzvRtUnp54BSyvirLZiT/wh/r8y6GFZ4p9iFuHr+kMx0WXgqVIP9osv4IhVvqXylkQ
	 BSfwrnBXDNecu/fnJeIUicr8mPcMKKV9r9H6sv6W5CYFI7YaO4s8MPq+kZ9biM72wZsky
	 5dGNDJ22IMdP7a6k54/bIOlF2JcPWsVMQBukkkpQKSfjZrBojFBCu4G5iJYgFpJ+FYg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703435;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=W7kN+lw5/GydYpTGjBruZgxToE+lStyqPTyM15Domeo=;
	b=X3X6WYWaOEINvM0n3Iwde93NWUjN/NYz1OdbG4rfT72N0ON2lUPOPUBOaYrCBiYlPSkl
	 Qq4yEg4IyM+jiDC6E5szLFCtB7+vW4YPiVRO5YesFnTm4LvOzwG6tqax+b4epBIRMYq7T
	 8PhCRNlpiA5/4wmCGt5zL+xslssS5YoArzmexJ9SefFgCPYlSbDYkkPhJOq9K8dL7ykDg
	 IlltAz1DNwZ056O/i/Qy/o512njhrY4qvP+kvIh8zkgRyPsY2hCYz2UZZ6zTWlYwkFfv2
	 2prQZl4Orpb+DRg8fWCoQidK7HYAqP5LkhGUO1OEp4qngpp7pncJv9JnnxICeOpH0FQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HgTIkEwL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71DA606A319;
	Thu, 22 Oct 2026 21:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HgTIkEwL
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792703434;
	b=1f39+LY6JihrCRvO1kmx6nQZrVGSNyZzsH7uM/S3K5TKQT+dfVIht4gY/fMlnieWHFEE
	 ymTdDbq8eN0Qle+2o88xaaVWr83rgq3NgE08H/Nsmf6d/wnUy/XZO5FiQJCLr8FlT95hD
	 S8SBOIpdDZcJDdlbYT1urNXAd0p9dxXNRMbDe8LM2fg7QctRzb+vpxKnR0MQ5yUNfdZId
	 C9ajVFQASGPqwlTzy771zkcjxJl3dsi8FFdzOIbJYuWyQQ+TYabEziSGOWK9+HH8L1rk+
	 1Kthc4jF+uQbTBpXA9WJjJsotpw1S9UBpeYPbaKdzlVhkzmutLLgcb7xI0W1lBIQ2Ow==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792703434;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=W7kN+lw5/GydYpTGjBruZgxToE+lStyqPTyM15Domeo=;
	b=gkNshO9Ftj52p932H8OhOOtn586ozlfPv5BvxFZJzmQvb4eepifJasyhD+BbvyL9bACf
	 Oh0rQ9zfRovQf79/M+tvO7EKMNrtxQA30utzlVppn1aWyEBTHVFTxZ3vI4HWA4kM2/2fj
	 /ykR7DllPm5hSgRyuAM3A+zWjcPJtxwVGRNfxrEX7GQoQP/doalxSItIEm4FUiq2R8bWo
	 vTxzNEPVF3/TtY4PMmh6C5TjXrlnkYunh4SgHO3N1FMetfepqdDixf7+uLYrrY6wFcwKX
	 oVHjGSljUZTwQsQwtKRVjjYs/xoqPH9RwtQa3k/tOHE7NUAi5W98j+sICccbHxXxPXA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BCCCC1F01825;
	Thu, 22 Oct 2026 21:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792703434;
	bh=W7kN+lw5/GydYpTGjBruZgxToE+lStyqPTyM15Domeo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=HgTIkEwL4Cy0IXdtb1yKXPVqNfwep6nBtfFOAhVeo7JuCbxxBom30rBu/f+onSLVN
	 F4s5VEnWF1J9QVvsSmpL4bwDcCjUDm0fAAC/RetlONkDO4a9oPpST6zePvZwcv36fe
	 ByNdlJBe41fkpRWTh07kD8PDuJstnKxXTNo5Pi41xvCzaWG96asjiMWa7CJL0oHg3M
	 dL5JGCjegjr8nEN6w2086UN3l9sJmJQH57s73TaPU50aeOFrMw88oOImQeJJaTxrdB
	 e72ptkwVO6iUm2et6mWvZwJhxh0dTmOyfzefDkiNIb/usRydZnql9sFQ0FUFQq4iGg
	 HPvu1krC2rHTw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 23DBB41EA6;
	Thu, 22 Oct 2026 21:10:33 +0000 (UTC)
From: Austin Schlegel via B4 Relay <devnull+schlegelas.outlook.com@kernel.org>
Date: Thu, 22 Oct 2026 17:10:24 -0400
Subject: [PATCH v3 1/3] serial: tegra: fix RX DMA descriptor use-after-free
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
Message-Id: <20261022-serial-tegra-dma-uaf-v3-1-129f6d67f673@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792703432; l=3938;
 i=schlegelas@outlook.com; s=20261001; h=from:subject:message-id;
 bh=5wOCuxOgp6v26DKJn2OPJjTvShSapaztXA47bgOTIT8=;
 b=4ZEObEQk/DyyWv1OwV43gipnlI350GB60rZIGas2DjgPtWh16jDXxmj2lme+//ZGd+zpxNXb8
 OXnW/KfEFGcCJbEyTaVUHjtVkf44AR/MDHAMhft+WlL2uBSQuxe7vUF
X-Developer-Key: i=schlegelas@outlook.com; a=ed25519;
 pk=ddgmH7VQaSWderjJFy4hDyq+P7hdHupPxQvwnGRBzCs=
X-Endpoint-Received: by B4 Relay for schlegelas@outlook.com/20261001 with
 auth_id=1098
X-Original-From: Austin Schlegel <schlegelas@outlook.com>
Reply-To: schlegelas@outlook.com
Content-Transfer-Encoding: 7bit

From: Austin Schlegel <schlegelas@outlook.com>

tegra_uart_terminate_rx_dma() calls dmaengine_terminate_all() and then
tegra_uart_rx_buffer_push(), which calls async_tx_ack(tup->rx_dma_desc)
on the just-terminated descriptor. With the GPC DMA driver,
dmaengine_terminate_all() frees the active descriptor immediately, so
the subsequent async_tx_ack() touches freed memory. dmaengine clients
are not allowed to touch a descriptor once it has been terminated.

Move the ack into the two call sites that still own a live descriptor:
tegra_uart_rx_dma_complete() (before the completion callback hands the
descriptor back) and tegra_uart_terminate_rx_dma() (before terminating),
and drop it from tegra_uart_rx_buffer_push() itself, since that function
no longer has a descriptor it's safe to ack.

The ack was originally added in commit b31245b94207 ("serial: tegra:
ack the rx dma desc after transfer terminated") to avoid a descriptor
leak with the Tegra20 APB DMA driver. Keep that fix intact: the ack
still happens for every terminated RX transfer, just before the
descriptor is freed instead of after.

KFENCE reports the use-after-free on a Jetson AGX Orin (Tegra234) under
UART loopback traffic:

BUG: KFENCE: use-after-free read in tegra_uart_rx_buffer_push+0x38/0x168
 tegra_uart_rx_buffer_push+0x38/0x168
 tegra_uart_terminate_rx_dma+0x88/0xf8
 tegra_uart_isr+0x380/0x470

allocated by task 0 on cpu 0 (~9 ms earlier):
 tegra_dma_prep_slave_sg+0x134/0x3c0
 tegra_uart_start_rx_dma.isra.0+0xc4/0x138
 tegra_uart_isr+0x340/0x470

freed by task 0 on cpu 0:
 tegra_dma_desc_free+0x1c/0x30
 vchan_dma_desc_free_list+0x10c/0x160
 tegra_dma_terminate_all+0x21c/0x290
 tegra_uart_terminate_rx_dma+0x7c/0xf8

Soak tested on Tegra234 (Jetson AGX Orin) for 24+ hours with
kfence.sample_interval=1 and continuous UART loopback traffic: zero
KFENCE reports, tx/rx byte counts in /proc/tty/driver/tegra_hsuart
remained equal throughout with no framing or break errors.

Fixes: b31245b94207 ("serial: tegra: ack the rx dma desc after transfer terminated")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Austin Schlegel <schlegelas@outlook.com>
---
v3:
 - No code changes.
 - Re-tested the series: in the same 10-minute UART loopback test with
   KFENCE sampling every 1 ms, the unfixed kernel gave 1635 KFENCE
   use-after-free error reports, and none with the series applied.

v2:
 - Reworded commit: Removed inaccurate statement claiming the freed-descriptor
   is accessed in tegra_uart_rx_dma_complete().
 - Reworded commit: Soak test ran for 24+ hours, so updated from 13 to 24.
 - Switched to personal email (v1 sent from austin.schlegel@arthrex.com)

v1: https://lore.kernel.org/all/20261001-tty-linus-v1-1-ecb8576c802d@arthrex.com/
---
 drivers/tty/serial/serial-tegra.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index b0fc4ae3686f..a23a92cebe0d 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -730,7 +730,6 @@ static void tegra_uart_rx_buffer_push(struct tegra_uart_port *tup,
 	struct tty_port *port = &tup->uport.state->port;
 	unsigned int count;
 
-	async_tx_ack(tup->rx_dma_desc);
 	count = tup->rx_bytes_requested - residue;
 
 	/* If we are here, DMA is stopped */
@@ -761,6 +760,7 @@ static void tegra_uart_rx_dma_complete(void *args)
 		set_rts(tup, false);
 
 	tup->rx_dma_active = false;
+	async_tx_ack(tup->rx_dma_desc);
 	tegra_uart_rx_buffer_push(tup, 0);
 	tegra_uart_start_rx_dma(tup);
 
@@ -783,6 +783,7 @@ static void tegra_uart_terminate_rx_dma(struct tegra_uart_port *tup)
 
 	dmaengine_pause(tup->rx_dma_chan);
 	dmaengine_tx_status(tup->rx_dma_chan, tup->rx_cookie, &state);
+	async_tx_ack(tup->rx_dma_desc);
 	dmaengine_terminate_all(tup->rx_dma_chan);
 
 	tegra_uart_rx_buffer_push(tup, state.residue);

-- 
2.53.0


