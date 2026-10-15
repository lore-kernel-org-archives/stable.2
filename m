Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D925925F7A9;
	Thu, 15 Oct 2026 03:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035001; cv=none; b=WvBCMCWQz/L29A4GhaG1bOp8kbWxVfT8Qq5RKXr63YS9roCcuwNF9cGNF6H4gmzTSP91YtkSojmRAVsa0no5bostGleDCLGWymxNJQsw4VEOg30M4qL1ySI1Z3TgGFrl7D0DUiEDZi9NtBet3q09pHgq8bUwUbrlL7sXwCpdhMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035001; c=relaxed/simple;
	bh=5cuqXH9vat4sxF51zg+2d3wpvESFGj6F+2a/87kk/3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q2tJ0TuSjS296Octd6frCHK5Ehk3DdAvXzhUpG8hPUATlFdBvJfhhkCoU0H1ynjMue2WoRPUiChDYzRrmS8PVhKwnlrF5maVJX3ECGCIU2o3V/uIeJ/4yrZJTaxkKhKRDaMEaKaGCy+7Za1dq9qGJCAU/HBHCYt9i836lgdJ5kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOCqWp9g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOCqWp9g"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80FC0C2BCF7;
	Thu, 15 Oct 2026 03:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792035001;
	bh=5cuqXH9vat4sxF51zg+2d3wpvESFGj6F+2a/87kk/3o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GOCqWp9gc/areMZc1+MzGTiQkoMJul4stATH0Oug0PPHebSsOipXWaubFqG6MfVq+
	 pIN1nAItOh20VVMNDCEqqe4fPpKmfKrrH1hPTSOqyWKzQAxILthHbc2Z6wf4e5Dyel
	 kBLRH6vw9XBd9yQntuIU8hSYByyxD1/+QdjpM9ANpIIIkGpPafwiFa6IQtpSRdIzzX
	 ryrLwflEY/1OSMdLwdOU/KnG6KEhSSPqz/S8NUhfuBBQKhysJZRFbab/VvSTNUYs+m
	 2JVVNvKSBBLP44H7DxwLT0mXTot0RY9bGoON0KEAkeph0r+VJ6rqYpBxW+N3C+qA7w
	 mEqOlJHd9j92A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA12CC6B2F;
	Thu, 15 Oct 2026 03:30:01 +0000 (UTC)
From: Austin Schlegel via B4 Relay <devnull+schlegelas.outlook.com@kernel.org>
Date: Wed, 14 Oct 2026 23:30:01 -0400
Subject: [PATCH v2 2/2] serial: tegra: fix TX DMA descriptor use-after-free
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-serial-tegra-dma-uaf-v2-2-b142b31b67e3@outlook.com>
References: <20261014-serial-tegra-dma-uaf-v2-0-b142b31b67e3@outlook.com>
In-Reply-To: <20261014-serial-tegra-dma-uaf-v2-0-b142b31b67e3@outlook.com>
To: Laxman Dewangan <ldewangan@nvidia.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Austin Schlegel <austin.schlegel@arthrex.com>, 
 Austin Schlegel <schlegelas@outlook.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792035000; l=2167;
 i=schlegelas@outlook.com; s=20261001; h=from:subject:message-id;
 bh=1rmzYHaRgOYHPq/n3d0+QHrr9+Anehm1RKT/x2oyhLw=;
 b=VyrKW3991vxpqEQIG7mJvzxRJF+Hhv7+XFExLgZz8TPd9ZS2XFflhfd/9iyIWYkR3VSfWD3Zg
 ztNHhv2PWxmDQP974e6dPfHfymcRyfsgD3gvSJ4Y0E6AewmDBb8op7G
X-Developer-Key: i=schlegelas@outlook.com; a=ed25519;
 pk=ddgmH7VQaSWderjJFy4hDyq+P7hdHupPxQvwnGRBzCs=
X-Endpoint-Received: by B4 Relay for schlegelas@outlook.com/20261001 with
 auth_id=1098
X-Original-From: Austin Schlegel <schlegelas@outlook.com>
Reply-To: schlegelas@outlook.com

From: Austin Schlegel <schlegelas@outlook.com>

tegra_uart_stop_tx() calls dmaengine_terminate_all() and then
async_tx_ack(tup->tx_dma_desc) on the descriptor that was just
terminated. With the GPC DMA driver, dmaengine_terminate_all() frees
the active descriptor immediately, so the ack call that follows
touches freed memory, the same use-after-free pattern fixed for the
RX path in tegra_uart_terminate_rx_dma() ("serial: tegra: fix RX DMA
descriptor use-after-free"). dmaengine clients must not touch a
descriptor once dmaengine_terminate_all() has returned.

Move the ack before dmaengine_terminate_all(), while the descriptor
is still owned by the driver. tegra_uart_tx_dma_complete() already
acks inside the completion callback, where the descriptor is valid,
and is unaffected.

Found by code inspection while fixing the analogous RX bug; not
reproduced on hardware, since triggering it requires stopping an
in-flight TX DMA transfer at the right moment. The RX and TX
paths share the same dmaengine_terminate_all()-then-ack structure
and the same root cause.

Fixes: e9ea096dd225 ("serial: tegra: add serial driver")
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Austin Schlegel <schlegelas@outlook.com>
---
v2:
 - Reworded commit: Removed inaccurate flush example
 - Switched to personal email (v1 sent from austin.schlegel@arthrex.com)

v1: https://lore.kernel.org/all/20261001-tty-linus-v1-2-ecb8576c802d@arthrex.com/
---
 drivers/tty/serial/serial-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index a23a92cebe0d..306a38b2fb1e 100644
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

-- 
2.53.0


