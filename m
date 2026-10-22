Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792703435;
	b=graC/49YzTpVwgwSvyQoTLsPEhhE6Z2aGYxxsRboHubUvI4d9VAEMkR2kE6bQWkes2bO
	 DJId9QdOKKFLKu6e6iogIjrYAg4daDWTST70ZFpF6Sbl9clgUKtmq5UHxZJyALmmi22kY
	 fGQWArMsXu2IM5QS0Br9xUM4C/K2KpTgL18zn9dZ9ylNPf4keaEzV4koTdSGWj5qR95ZL
	 U0aWg47ClcJdoe3YjN6BAniYplReh1Zak7c1NGikkzfmyqJEEHeveQgaeBNHhO8rj1mo6
	 +/CWWI/yMiXYXjPsdTtQ+wAxU7oRUgkzCqKVtm2Zbradzm0QfTWl+bZLWJb8gI+rYNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703435;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=kO61xKOjCcnLObMqjlzPDq8UNZqvwrRW1KYyF5xpVy0=;
	b=00fimvr0gYnI6qCWMnz0Bk8cvHvwwq5FaJ/xmEczc4VvsZ9MiXqOdnZ3jiZHEb39/Zk3
	 F0c9HulYGKL/h5D6UOglPUGGn7Fk7WTfD0mgakYtEMy/jZC2PvUCsgJsAGARtcAHyKHn5
	 0b1SLx6drlLFxfVzRYHKEWLxpfcwU/PmUwVou07YIkUAE4Z4m7unXI9vRPfKLUWjUtP3d
	 J1lVhn8D8b6bxzOxSCR4FbwvwNn8nJ7Jos7Ovf1zyCXAOnp7waI3w3bKisOSiyoJEFhsT
	 792YX6HkcFwnIcCtz9qoaIaURHP3dB0VAjX84Q8V4Sndhyl8Adc79IPXWHfy+sSHjmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nxkJU7b9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F38606A31D;
	Thu, 22 Oct 2026 21:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nxkJU7b9
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792703434;
	b=JHDguOPmRyy7ky5wGG3VPLVpD4mnPtvJrccfovlSa9ndZKMLCp1T6Gcllq0nBsRxc12D
	 KIARpz7qRQXwoDU2ZuOZWKGVYa78Rl9lVUL8T6jXYmv/WnSpqHrNnzJTTFsiJsfcBFaMZ
	 MIit0FPUZ/KzSz9/5rld/PG2L2kXaC8GVI09LYFprUr627gbKOoWfEQmVNfs97GJe109r
	 9JPjP0ivGvjmtTMzKhLyLgLykpaLrSYm8RzuK/Vif3gwzRn2xYfmJKcJwoUekrsAoySrz
	 2clbfln3vsz0hvRN0s2du6cNbnCDpOAWbmDG7AuvZCU5wH/T4tqMwSciePfsV5d8BiA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792703434;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=kO61xKOjCcnLObMqjlzPDq8UNZqvwrRW1KYyF5xpVy0=;
	b=SGbuxhgJ0kzuuzxyXOjE59cYSM5cZ5gvzF8ipTtVYhgvsGcSYHQm+eDsXjgAdplzDTEr
	 /keYdAAawKFywcvPLXcG3QpFaFY0rGNL42DKa46XtvER33gccrlyDCgMTkaB3Z0L96zdo
	 l1Tc7W1qpN7wjMV5BSQFeTLj7a9wf5E0l9VrjEjXWW6ChQTcuG1ormehGDmi1476zqj5g
	 qPOtt32bx+LfbmLYVRUKQIntK4zmg4FzfXgnHrtENpeAEOhfnzA0Px7Arubxi5R+LV/2E
	 QvCZNq8vrWGeDd8eTSeRiMyqzDBt+Lsi91tp0uR1ASRQ9o/nOqVtCkqYd04WhgjGvoQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BCF5E1F01829;
	Thu, 22 Oct 2026 21:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792703434;
	bh=kO61xKOjCcnLObMqjlzPDq8UNZqvwrRW1KYyF5xpVy0=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=nxkJU7b9xjhlTzobcC3KeesIMeKM6KVSASvuay1cbJIWjOACJ+yqG06IMOEMrWSAL
	 uro2fm+9fsq7CHCD+jxqsoqIjOR4N75EcCagq43XL1m8lVNso30PSeje+rVpUqyrxz
	 n20K1w9IMdD5jcHjAfjCVibI4eIV2wb/cAoHAxmTHjEQxQ9v+Mk/wbqvWeqcFWt0T6
	 rAx0161cN7GWXjj9O+zoJ86LvlJ5v8tirUL1i3UatwAio3eOYn5uTXlgt/XU8uW5JY
	 KjTGVihEJFIz2TR2Mlvz73mcGTZXxcDTOlyDsh/3MKMJPiUkWIAeQI9U3j1z3FKF1A
	 taRQ10ENLCePw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 18CB041F4C;
	Thu, 22 Oct 2026 21:10:33 +0000 (UTC)
From: Austin Schlegel via B4 Relay <devnull+schlegelas.outlook.com@kernel.org>
Subject: [PATCH v3 0/3] serial: tegra: fix DMA descriptor use-after-free
 and stale completions
Date: Thu, 22 Oct 2026 17:10:23 -0400
Message-Id: <20261022-serial-tegra-dma-uaf-v3-0-129f6d67f673@outlook.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ6DIBSEr2Leuq/hx2DaVe/RuAB5KqlKA0raG
 O5e9AJdfpOZb3aIFBxFuFc7BEouOr8UkJcKulEvA6GzhUEwoTjjNR59PeFKQ9BoZ42b7lHeyCr
 RMK6NgjJ9B+rd59Q+28Kji6sP3/MliSP9I0wCGRpeCyO5UQ3Jh9/WyfvXtfMztDnnH8fhk8y6A
 AAA
X-Change-ID: 20261014-serial-tegra-dma-uaf-39ed62701ab6
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792703432; l=3329;
 i=schlegelas@outlook.com; s=20261001; h=from:subject:message-id;
 bh=2u6x42Zc4M/sCENwrwvS9ZYmDV6qxlXnokQ8LOPtSWw=;
 b=9J9PKfD7iRpIx6qLoMhEbfERW7lDm6JDuJNkioe31lVgZrA5KLKeoMNdv/ynkNWJB1BQfWo8c
 oAJOWDjkH9NCxqWeHmfmNb3QxOvDs8tsij0WCIyNu4TznQQTE2tW7Tk
X-Developer-Key: i=schlegelas@outlook.com; a=ed25519;
 pk=ddgmH7VQaSWderjJFy4hDyq+P7hdHupPxQvwnGRBzCs=
X-Endpoint-Received: by B4 Relay for schlegelas@outlook.com/20261001 with
 auth_id=1098
X-Original-From: Austin Schlegel <schlegelas@outlook.com>
Reply-To: schlegelas@outlook.com

Patches 1 and 2 fix the same bug pattern in
drivers/tty/serial/serial-tegra.c: async_tx_ack() is called on a DMA
descriptor after dmaengine_terminate_all() has terminated it. With the
GPC DMA driver (tegra186-gpc-dma.c, used on Tegra186 and later),
terminating a channel frees the active descriptor synchronously via
vchan_dma_desc_free_list(), so the ack touches freed memory. dmaengine
clients are not allowed to touch a descriptor once it has been
terminated.

Patch 1 (RX) was found via a KFENCE use-after-free report on a Jetson
AGX Orin (Tegra234) under UART loopback traffic. It keeps the
descriptor-leak fix from commit b31245b94207 ("serial: tegra: ack the
rx dma desc after transfer terminated") intact: the ack still happens
for every terminated RX transfer, just before the descriptor is freed
instead of after.

Patch 2 (TX) fixes the same ordering bug in tegra_uart_stop_tx().
It also fixes tegra_uart_flush_buffer(), which terminated the TX
channel without clearing tx_in_progress, so a later
tegra_uart_stop_tx() acked the freed descriptor.

Patch 3 is new in v3. It makes the TX and RX DMA completion callbacks
return early when the transfer they were raised for has already been
stopped, flushed or terminated, instead of accounting for it a second
time.

The bugs fixed by patches 2 and 3 were found in review (Sashiko, on v2)
and have not been reproduced on hardware. In a 10-minute loopback test
with KFENCE sampling every 1 ms, which also stops and flushes TX during
DMA, the unfixed kernel produced 1635 use-after-free KFENCE
errors, all from RX. With this patch series applied there were none.

Testing was done on Tegra234 (Jetson AGX Orin) with GPC DMA only. The
APB DMA driver (Tegra20-Tegra210) recycles descriptors only after they
are acked; the series keeps every ack but has not been tested there.

Signed-off-by: Austin Schlegel <schlegelas@outlook.com>
---
Changes in v3:
- Patch 2: also fix tegra_uart_flush_buffer(), which left
  tx_in_progress set after terminating TX DMA (Sashiko review).
- New patch 3: ignore TX/RX DMA completion callbacks for transfers that
  were already stopped or terminated (Sashiko review).
- Patch 1: no code changes.
- Link to v2: https://lore.kernel.org/r/20261014-serial-tegra-dma-uaf-v2-0-b142b31b67e3@outlook.com

Changes in v2:
- Commit message updates only; no code changes.
- Patch 1: removed an inaccurate statement that the freed descriptor
  is accessed in tegra_uart_rx_dma_complete(); updated the soak test
  duration to 24+ hours.
- Patch 2: removed an inaccurate flush example; added Fixes: tag.
- Switched to my personal email address (v1 was sent from
  austin.schlegel@arthrex.com).
- Link to v1: https://lore.kernel.org/r/20261001-tty-linus-v1-0-ecb8576c802d@arthrex.com

---
Austin Schlegel (3):
      serial: tegra: fix RX DMA descriptor use-after-free
      serial: tegra: fix TX DMA descriptor use-after-free
      serial: tegra: ignore stale DMA completion callbacks

 drivers/tty/serial/serial-tegra.c | 56 +++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 5 deletions(-)
---
base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
change-id: 20261014-serial-tegra-dma-uaf-39ed62701ab6

Best regards,
-- 
Austin Schlegel <schlegelas@outlook.com>


